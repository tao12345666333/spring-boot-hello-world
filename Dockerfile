FROM maven:3.6.1-jdk-8-alpine AS builder

WORKDIR /app

COPY pom.xml /app/
RUN mvn dependency:go-offline
COPY src /app/src
RUN mvn -e -B package

FROM builder AS dev

RUN apk add --no-cache vim

FROM openjdk:8-jre-alpine

COPY --from=builder /app/target/gs-spring-boot-0.1.0.jar /

CMD [ "java", "-jar", "/gs-spring-boot-0.1.0.jar" ]
