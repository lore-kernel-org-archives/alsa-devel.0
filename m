From: Bryan Hanks <bryan.hanks@access-company.com>
Subject: Re: [PATCH] [alsa-utils] Fix build with library
Date: Thu, 24 Jul 2008 15:51:26 -0700
Message-ID: <1216939886.7377.238.camel@svbhankslnx.svl.access-company.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-OGgQJW1/2UjHne25TAoH"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx3.access-company.com (mx4.access-company.com [12.7.175.32])
	by alsa0.perex.cz (Postfix) with ESMTP id 3023E10390D
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jul 2008 00:49:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Sean McNamara <sean.mcnamara@access-company.com>, alsa-devel@alsa-project.org, Frederic Roussel <frederic.roussel@access-company.com>
List-Id: alsa-devel@alsa-project.org


--=-OGgQJW1/2UjHne25TAoH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Takashi,

Here is the patch for alsa-utils not being able to compile against
alsa-lib if certain features were disabled in the library. It uses
AC_CHECK_HEADERS as you suggested. It disables midi or seq and alsactl
(if either are disabled, since it makes use of rawmidi.h and seq.h) from
the build. 

Bryan


--=-OGgQJW1/2UjHne25TAoH
Content-Disposition: attachment; filename=patch-alsa-utils-no-midi.zip
Content-Type: application/zip; name=patch-alsa-utils-no-midi.zip
Content-Transfer-Encoding: base64

UEsDBBQAAAAIANl8+Dio/0QxRQEAAFgCAAASABUAY29uZmlndXJlLmluLnBhdGNoVVQJAAN6BIlI
+wOJSFV4BADpA+kDjZBPa4NAEMXv+ykG2kNCNNtC2ksRFBUizZ825lAIQTbrWJfomu5q68fvmqS2
OQTqQWbYN+/9eI7jOEBpip/Um73QkglJqwNKW1eN4khZoZnd1KLQNBW6prySmXhvFI6FvJmADVRz
xWqe76qWNhqVprucyb2meVXiz9zZs+Lwb2cwVA5xXbAnd9YjjMz//gFcl8DxQ8341tp0DqVoUTm1
anA7JODNE3+5CKJ1tFx4s4E3i7159BauLKhR19De9ifgQNtdmSMyugE/R76HrFKg2FcpUkFGnp/4
09B/TqahF4SreNDd0vPzOLdgA910zIZtv2ZGZnYYGodLmnkURD1Ip/1lGBkG3iNo/GhQclTXIIzg
BGCGP/nddj0+Dl/7dKO8CCeQyuJUgj4i5MhSU1ImCtRj06t/BkjideATENnVQp+gzlGSb1BLAwQU
AAAACAAte/g4gLbHeJcBAAAKAwAAEQAVAE1ha2VmaWxlLmFtLnBhdGNoVVQJAANVAYlI+wOJSFV4
BADpA+kDjVLBbqMwEL37K0baHBJR6pUaaU+W4iZ0hRZKN1Cpt8iFAawYzGJTtX9fQ0KkrtrVXsae
53kzz0/DGGNAaYEvlEcPtBGypbrD1jd66HOkQhnhD1YqQwtpLI3FEUup8Fo039bgAzV5L2xeP+tX
OhjsDX2uRXs0tNYNzvexu1Dd/zYGp4mRzQb89dUP8NZXN99hsyGAyiABHqU8Dp+C/WEX7plD20KW
xE8fb12eMpBtroYCYRyQW3U6dVvCYvmBugLRyEKO8RV7EJ0SbyAxN2jB4B8wHTpJvW/RWJiEQrOG
ThOPeLKENPhNPBcmFa6eeJO8C+TySdipOg53IfHGOD1Ok2fGBf2MMk/i2yw6UU/fmskX/EL+CnfS
/rbIOXIuW/3DpsVyVrj61KzF8vzn1deeQfCU7bkrSjMG4xhZXfedsDV8zJqjbI0VShWyN7B161Nh
pCsI79OMRxFkyS6BfcB3cXAmDj1CXeW66dzyQIHdeHVb8pglMf8VHJKHLEzuU1bqHmXVupdtlGx5
dODxXcR/psDAD51K8g5QSwECFwMUAAAACADZfPg4qP9EMUUBAABYAgAAEgANAAAAAAABAAAApIEA
AAAAY29uZmlndXJlLmluLnBhdGNoVVQFAAN6BIlIVXgAAFBLAQIXAxQAAAAIAC17+DiAtsd4lwEA
AAoDAAARAA0AAAAAAAEAAACkgYoBAABNYWtlZmlsZS5hbS5wYXRjaFVUBQADVQGJSFV4AABQSwUG
AAAAAAIAAgCZAAAAZQMAAAAA


--=-OGgQJW1/2UjHne25TAoH
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-OGgQJW1/2UjHne25TAoH--
