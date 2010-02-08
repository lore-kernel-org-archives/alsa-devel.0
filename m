From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: [PATCH] alsa-info.sh: Sort the list of loaded modules.
Date: Mon, 08 Feb 2010 20:48:35 +0100
Message-ID: <1265658515.3834.36.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3974800869709594300=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id C15C92433C
	for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2010 20:48:36 +0100 (CET)
Received: from f053038078.adsl.alicedsl.de ([78.53.38.78]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1NeZb2-0005K8-DI
	for alsa-devel@alsa-project.org; Mon, 08 Feb 2010 19:48:36 +0000
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


--===============3974800869709594300==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-CkLcSA32JnmmrHqxu8XJ"


--=-CkLcSA32JnmmrHqxu8XJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Searching for loaded modules in this list is easier with the list sorted.

Signed-off-by: Paul Menzel <paulepanter@users.sourceforge.net>
---
 utils/alsa-info.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/utils/alsa-info.sh b/utils/alsa-info.sh
index fe7c08d..5b4e045 100755
--- a/utils/alsa-info.sh
+++ b/utils/alsa-info.sh
@@ -127,7 +127,7 @@ withlsmod() {
 	echo "!!All Loaded Modules" >> $FILE
 	echo "!!------------------" >> $FILE
 	echo "" >> $FILE
-	lsmod |awk {'print $1'} >> $FILE
+	lsmod |sort |awk {'print $1'} >> $FILE
 	echo "" >> $FILE
 	echo "" >> $FILE
 }
--=20
1.6.6.1

--=-CkLcSA32JnmmrHqxu8XJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAktwapIACgkQPX1aK2wOHViE7QCfR0Wo1y6CuRNAqTM9MndzVNbH
WKUAniS8fQjDCRYNQ77tAC3jlXcoxRKI
=O3Ks
-----END PGP SIGNATURE-----

--=-CkLcSA32JnmmrHqxu8XJ--


--===============3974800869709594300==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3974800869709594300==--
