From: Simon McVittie <smcv@debian.org>
Subject: [PATCH 1/2] Version-check libtool correctly when doing
 an out-of-tree build
Date: Fri, 8 Oct 2010 09:06:29 +0100
Message-ID: <20101008080629.GA11076@reptile.pseudorandom.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4502433975049915377=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from figment.pseudorandom.co.uk (figment.pseudorandom.co.uk
	[195.10.223.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 11AC610381C
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Oct 2010 10:06:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4502433975049915377==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

libtool is only created at the end of ./configure, so it doesn't make
sense to grep it in ./configure (the check would always fail the first
time). However, ltmain.sh is copied into the ${srcdir} by libtoolize and
should be safe to check at any time that configure can be run.

Signed-off-by: Simon McVittie <smcv@debian.org>
---
 configure.in |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/configure.in b/configure.in
index abc4687..e904956 100644
--- a/configure.in
+++ b/configure.in
@@ -115,7 +115,7 @@ AC_ARG_WITH(versioned,
   versioned=3D"$withval", versioned=3D"yes")
 if test "$versioned" =3D "yes"; then
   # it seems that GNU ld versions since 2.10 are not broken
-  xres=3D`grep '^VERSION=3D' libtool | cut -d =3D -f 2 | cut -d \" -f 2`
+  xres=3D`grep '^VERSION=3D' ${srcdir}/ltmain.sh | cut -d =3D -f 2 | cut -=
d \" -f 2`
   major=3D`echo $xres | cut -d . -f 1`
   minor=3D`echo $xres | cut -d . -f 2`
   pass=3D0
--=20
1.7.1


--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----

iQIVAwUBTK7Q/E3o/ypjx8yQAQjWKw//R6xaRY/S4phd0bfWOgumGkkJq6bfG4mM
XyksV67eUH4N0/BHtTwx/h2oNr9J7vrKHJiIkh8Skqy0CFsMp/sQ51p7qyhumURF
wGwjQZqPHSo4GTTDL2yfCFsVVNDY7Ur/pudr1IH5nDgAp4JbFlJ40ptUm7wsPPQE
CCuZ5dKcidguGQr0A6BSg6LsJ5pHMDRhc7XdxkFGr48ZQ8OHyOfXaFFX/Vy546zv
qu1QypSDpQTduNO9LVj5SABujMPbb075c+vZ0NSV0I/9DaBuj6taW8oPE5NXLPrM
TSL8SMjYvy0lVn+kS5S3Bm2kq1LUrJ0U/rq1OesC6/qDLtkHWxjgBEF9z0rC2ZnJ
bTY8nfJqBWMca1UsRD5or/ne7IH5lmfOWqWG9H4Za0kBbyqLgB13HqRjHzE99P4V
yq0SNKWaRzST8+GvPolHsXU59sdJpf5zm8PAT8xkKkfmCK9gu19Iujkh9ETZkrcB
xCf4d1yOGulMFhYn66Cry2QABRBIN+eym0FCviSAdtkTWdJuww+kn9FXy38xQ77H
Kn1XF8YMaPOYMxwnI8KVLU+KtO04LhwjUy9uGSJ1uu3zIRKQwlP/hJpoErDQ0Y2q
GaYNwj0rmwA2G0ChJ8F4cM57in84z3Yq8POYRkiGM+qALM+X3M0xSNgeXxFEpMp1
0Rrl+KR+j8g=
=mGHf
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--

--===============4502433975049915377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4502433975049915377==--
