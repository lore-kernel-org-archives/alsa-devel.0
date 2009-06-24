From: Tim Blechmann <tim@klingt.org>
Subject: [PATCH] alsa: lx6464es - configure ethersound io
	channels
Date: Wed, 24 Jun 2009 15:27:30 +0200
Message-ID: <20090624152730.654a8520@thinkpad>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8060254867729165454=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 1189F10382C
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Jun 2009 15:27:39 +0200 (CEST)
Received: from thinkpad (localhost [127.0.0.1]) (authenticated bits=0)
	by klingt.org (8.14.3/8.14.3/Debian-9) with ESMTP id n5ODRZQq000398
	for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2009 15:27:39 +0200
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

--===============8060254867729165454==
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/AAWFoBh.lIfNED/6.W=bhck";
 protocol="application/pgp-signature"

--Sig_/AAWFoBh.lIfNED/6.W=bhck
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

as long as the io channel number is not set by the driver, the card
is not visible from the ethersound network

Signed-off-by: Tim Blechmann <tim@klingt.org>
---
 sound/pci/lx6464es/lx6464es.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
index ccf1b38..c92fba5 100644
--- a/sound/pci/lx6464es/lx6464es.c
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -654,13 +654,12 @@ static int __devinit lx_init_ethersound_config(struct=
 lx6464es *chip)
 	int i;
 	u32 orig_conf_es =3D lx_dsp_reg_read(chip, eReg_CONFES);
=20
-	u32 default_conf_es =3D (64 << IOCR_OUTPUTS_OFFSET) |
+	/* configure 64 io channels */
+	u32 conf_es =3D (orig_conf_es & CONFES_READ_PART_MASK) |
 		(64 << IOCR_INPUTS_OFFSET) |
+		(64 << IOCR_OUTPUTS_OFFSET) |
 		(FREQ_RATIO_SINGLE_MODE << FREQ_RATIO_OFFSET);
=20
-	u32 conf_es =3D (orig_conf_es & CONFES_READ_PART_MASK)
-		| (default_conf_es & CONFES_WRITE_PART_MASK);
-
 	snd_printdd("->lx_init_ethersound\n");
=20
 	chip->freq_ratio =3D FREQ_RATIO_SINGLE_MODE;
--=20
1.6.2.1

--Sig_/AAWFoBh.lIfNED/6.W=bhck
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkpCKcIACgkQdL+4qsZfVsudCQCfT+0G3IKiVuPPtX0A1rrJgNJI
voEAoKS9MDqplOYYaoY2LCU4LK8eILSz
=irZH
-----END PGP SIGNATURE-----

--Sig_/AAWFoBh.lIfNED/6.W=bhck--

--===============8060254867729165454==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8060254867729165454==--
