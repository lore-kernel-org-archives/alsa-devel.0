From: Tim Blechmann <tim@klingt.org>
Subject: [PATCH] ALSA: HDSP: check for io box before uploading
	firmware
Date: Sat, 08 Nov 2008 12:36:30 +0100
Message-ID: <1226144189.6872.2.camel@thinkpad>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5410919241046711527=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 8780F1037EE
	for <alsa-devel@alsa-project.org>; Sat,  8 Nov 2008 12:37:52 +0100 (CET)
Received: from [10.9.3.234] (localhost [127.0.0.1]) (authenticated bits=0)
	by klingt.org (8.14.3/8.14.3/Debian-5) with ESMTP id mA8BbptR003790
	for <alsa-devel@alsa-project.org>; Sat, 8 Nov 2008 12:37:52 +0100
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


--===============5410919241046711527==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-49hq5w30M3ZT2m2fZNAa"


--=-49hq5w30M3ZT2m2fZNAa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

currently the hdsp driver tries to upload the firmware, even if the
io box is not connected. this patch adds a check for the io box
before trying to upload the firmware.
thus instead of messages complaining about the fifo status and firmware
loading failure, the driver gives a message that no multiface or
digiface is connected.

Signed-off-by: Tim Blechmann <tim@klingt.org>
---
 sound/pci/rme9652/hdsp.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index d723543..cf9eb41 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -5045,6 +5045,9 @@ static int __devinit snd_hdsp_create(struct snd_card =
*card,
 		/* we wait 2 seconds to let freshly inserted cardbus cards do their hard=
ware init */
 		ssleep(2);
=20
+		if ((err =3D hdsp_check_for_iobox(hdsp)) < 0)
+			return err;
+
 		if ((hdsp_read (hdsp, HDSP_statusRegister) & HDSP_DllError) !=3D 0) {
 #ifdef HDSP_FW_LOADER
 			if ((err =3D hdsp_request_fw_loader(hdsp)) < 0)
@@ -5057,7 +5060,7 @@ static int __devinit snd_hdsp_create(struct snd_card =
*card,
 				/* init is complete, we return */
 				return 0;
 #endif
-			/* no iobox connected, we defer initialization */
+			/* we defer initialization */
 			snd_printk(KERN_INFO "Hammerfall-DSP: card initialization pending : wai=
ting for firmware\n");
 			if ((err =3D snd_hdsp_create_hwdep(card, hdsp)) < 0)
 				return err;
--=20
1.5.6.3

--=-49hq5w30M3ZT2m2fZNAa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkVeboACgkQFz+XezW6HD6fdgCeL7vSi8FTrJj63Drbg4asUhqx
uHgAoIToXDb/En3wjd7ryPz1tsV8aNTO
=fSNz
-----END PGP SIGNATURE-----

--=-49hq5w30M3ZT2m2fZNAa--


--===============5410919241046711527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5410919241046711527==--
