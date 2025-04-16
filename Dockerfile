FROM antora/antora AS build

# Copy the playbook and book files
WORKDIR /book/
COPY ./ /book/

# Build the website
RUN antora --fetch antora-playbook.yml

FROM busybox:latest

# Copy built website from build stage
COPY --from=build /book/build/ /book/

# Serve the book
EXPOSE 80
CMD ["busybox", "httpd", "-f", "-p", "80", "-h", "/book/site/"]

