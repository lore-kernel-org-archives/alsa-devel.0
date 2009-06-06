From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: [RFC/PATCH] asoc: pxa-ssp.c -> enchance the I2S
	enchancement :)
Date: Sat, 06 Jun 2009 15:38:37 -0300
Message-ID: <1244313517.6717.107.camel@brutus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2368525903574242167=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id C780124384
	for <alsa-devel@alsa-project.org>;
	Sat,  6 Jun 2009 20:38:43 +0200 (CEST)
Received: by qyk1 with SMTP id 1so3107593qyk.16
	for <alsa-devel@alsa-project.org>; Sat, 06 Jun 2009 11:38:42 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Paul Shen <boshen9@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Mark Brown <broonie@sirena.org.uk>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2368525903574242167==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-avC0LEbNl67CCk2LJQUu"


--=-avC0LEbNl67CCk2LJQUu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi, this patch is what i need to use Paul's pxa-ssp.c I2S enchancements
on my board.

Basically, it doesn't enforce the "fake" network mode, as i dont need
it. And i need _real_ network mode, so i prefer to set SSCR0_MOD only
when really using network mode.

And it uses PXA_SSP_FRM_??FS to actually set SSCR0_DataSize() too. This
allows me to use 32bit frames for 16 bit stereo audio. (No, I don't want
to fake network mode for this, and SSCR0_MOD doesn't work as expected
when PXA is slave).

This patch is incremental to the recent patch from Paul Shen.

Signed-off-by: Daniel Ribeiro <drwyrm@gmail.com>

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index ed0906e..762cb93 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -579,7 +579,7 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai
*cpu_dai,
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 	case SND_SOC_DAIFMT_LEFT_J:
-		sscr0 |=3D SSCR0_PSP | SSCR0_MOD;
+		sscr0 |=3D SSCR0_PSP;
 		sscr1 |=3D SSCR1_RWOT | SSCR1_TRAIL;
=20
 		/* See hw_params() */
@@ -655,7 +655,7 @@ static int pxa_ssp_hw_params(struct
snd_pcm_substream *substream,
 	int dma =3D 0, chn =3D params_channels(params);
 	u32 sscr0;
 	u32 sspsp;
-	int frame_width;
+	int frame_width =3D 0;
 	int width =3D snd_pcm_format_physical_width(params_format(params));
 	int ttsa =3D ssp_read_reg(ssp, SSTSA) & 0xf;
=20
@@ -698,7 +698,6 @@ static int pxa_ssp_hw_params(struct
snd_pcm_substream *substream,
 		sscr0 |=3D (SSCR0_EDSS | SSCR0_DataSize(16));
 		break;
 	}
-	ssp_write_reg(ssp, SSCR0, sscr0);
=20
 	switch (priv->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
@@ -742,6 +741,15 @@ static int pxa_ssp_hw_params(struct
snd_pcm_substream *substream,
 		break;
 	}
=20
+	if (frame_width) {
+		sscr0 &=3D ~(SSCR0_EDSS | SSCR0_DataSize(16));
+		if (frame_width % 48 =3D=3D 0)
+			sscr0 |=3D SSCR0_EDSS | SSCR0_DataSize(8);
+		else
+			sscr0 |=3D SSCR0_EDSS | SSCR0_DataSize(16);
+	}
+	ssp_write_reg(ssp, SSCR0, sscr0);
+
 	/* When we use a network mode, we always require TDM slots
 	 * - complain loudly and fail if they've not been set up yet.
 	 */


--=20
Daniel Ribeiro

--=-avC0LEbNl67CCk2LJQUu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta =?ISO-8859-1?Q?=E9?= uma parte de mensagem
 assinada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkoqt6YACgkQw3OYl0G0liS9QACgn53nUYjZ6Zysqg5DrfsMlm/S
Z68AniTu0W2FKKmfUWxRWujadP7jTocg
=Nusp
-----END PGP SIGNATURE-----

--=-avC0LEbNl67CCk2LJQUu--


--===============2368525903574242167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2368525903574242167==--
