From: Forest Bond <forest@alittletooquiet.net>
Subject: [PATCH alsa-kernel] snd-hda-codec-realtek: Add quirk
 for Jetway NF92
Date: Mon, 28 Mar 2011 14:43:07 -0400
Message-ID: <20110328184307.GJ29800@alittletooquiet.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2327100216185337879=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from storm.alittletooquiet.net (storm.alittletooquiet.net
	[67.23.28.199]) by alsa0.perex.cz (Postfix) with ESMTP id B3F6710382C
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Mar 2011 20:43:09 +0200 (CEST)
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


--===============2327100216185337879==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QNDPHrPUIc00TOLW"
Content-Disposition: inline


--QNDPHrPUIc00TOLW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The Jetway NF92 mainboard works with model=3D3stack-6ch-dig.  Add a
quirk to automatically configure the codec accordingly.

Signed-off-by: Forest Bond <forest.bond@rapidrollout.com>
---
 sound/pci/hda/patch_realtek.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f1a03f2..6cc8378 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -18777,6 +18777,7 @@ static struct snd_pci_quirk alc662_cfg_tbl[] =3D {
 	SND_PCI_QUIRK_MASK(0x1854, 0xf000, 0x2000, "ASUS H13-200x",
 			   ALC663_ASUS_H13),
 	SND_PCI_QUIRK(0x1991, 0x5628, "Ordissimo EVE", ALC662_LENOVO_101E),
+	SND_PCI_QUIRK(0x16f3, 0xa625, "Jetway NF92", ALC662_3ST_6ch_DIG),
 	{}
 };
=20
--=20
1.7.0.4

--QNDPHrPUIc00TOLW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk2Q1rsACgkQRO4fQQdv5AxFvgCggLG1dxx5mRexYg41N6hNTCkB
NYwAniHjKDw9e5Nxaz1ntE6Faa5s9V0S
=HIpY
-----END PGP SIGNATURE-----

--QNDPHrPUIc00TOLW--

--===============2327100216185337879==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2327100216185337879==--
