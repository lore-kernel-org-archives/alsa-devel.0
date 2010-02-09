From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: [PATCH] ASoC: Typo. s/Freecale/Freescale/
Date: Tue, 09 Feb 2010 11:42:27 +0100
Message-ID: <1265712147.25544.0.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4474453908882083941=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F94D24554
	for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2010 11:42:30 +0100 (CET)
Received: from f053032124.adsl.alicedsl.de ([78.53.32.124]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1NenY4-0004Fp-Rt
	for alsa-devel@alsa-project.org; Tue, 09 Feb 2010 10:42:28 +0000
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


--===============4474453908882083941==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-H8xWPbM8Y15e0bcn9Xvw"


--=-H8xWPbM8Y15e0bcn9Xvw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


Signed-off-by: Paul Menzel <paulepanter@users.sourceforge.net>
---
 sound/soc/imx/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
index 5f006f0..c7d0fd9 100644
--- a/sound/soc/imx/Kconfig
+++ b/sound/soc/imx/Kconfig
@@ -1,5 +1,5 @@
 config SND_IMX_SOC
-	tristate "SoC Audio for Freecale i.MX CPUs"
+	tristate "SoC Audio for Freescale i.MX CPUs"
 	depends on ARCH_MXC && BROKEN
 	select SND_PCM
 	select FIQ
--=20
1.6.6.1

--=-H8xWPbM8Y15e0bcn9Xvw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAktxPAwACgkQPX1aK2wOHVghyACfdfuGDgzNZTOzdTHoLszZvTPb
tm8AnirnY2icqDOVrcRn2f1bSvK9uXDJ
=Kmuo
-----END PGP SIGNATURE-----

--=-H8xWPbM8Y15e0bcn9Xvw--


--===============4474453908882083941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4474453908882083941==--
