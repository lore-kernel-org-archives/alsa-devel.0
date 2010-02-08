From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: [PATCH] Typo. s/distrubs/disturbs/
Date: Mon, 08 Feb 2010 20:37:26 +0100
Message-ID: <1265657846.3834.29.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0980519674143612354=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B4852414D
	for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2010 20:37:28 +0100 (CET)
Received: from f053038078.adsl.alicedsl.de ([78.53.38.78]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1NeZQG-0003lp-3M
	for alsa-devel@alsa-project.org; Mon, 08 Feb 2010 19:37:28 +0000
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


--===============0980519674143612354==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-6tjGEo6mMn0J6gB4gvLP"


--=-6tjGEo6mMn0J6gB4gvLP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


Signed-off-by: Paul Menzel <paulepanter@users.sourceforge.net>
---
 sound/pci/hda/hda_intel.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 06f230f..051cf51 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1411,7 +1411,7 @@ static int __devinit azx_codec_create(struct azx *chi=
p, const char *model)
 				chip->codec_mask &=3D ~(1 << c);
 				/* More badly, accessing to a non-existing
 				 * codec often screws up the controller chip,
-				 * and distrubs the further communications.
+				 * and disturbs the further communications.
 				 * Thus if an error occurs during probing,
 				 * better to reset the controller chip to
 				 * get back to the sanity state.
--=20
1.6.6.1

--=-6tjGEo6mMn0J6gB4gvLP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAktwZ/YACgkQPX1aK2wOHVgzLgCeJw0hgnNl2q6ctgmQ7KcEYyOE
q4sAn2Z3Oj5UH2e0QqOUgLF/XZlUDVTd
=HrQ1
-----END PGP SIGNATURE-----

--=-6tjGEo6mMn0J6gB4gvLP--


--===============0980519674143612354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0980519674143612354==--
