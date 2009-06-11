From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: [PATCH v2 2/2] ASoC: pxa-ssp.c,
	Automatically set TDM when needed
Date: Thu, 11 Jun 2009 07:17:04 -0300
Message-ID: <1244715424.21356.30.camel@brutus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7890506745010713606=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C545245FC
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Jun 2009 12:17:11 +0200 (CEST)
Received: by qyk1 with SMTP id 1so1944771qyk.16
	for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2009 03:17:11 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@sirena.org.uk>
Cc: Paul Shen <boshen9@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org


--===============7890506745010713606==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-ESKRUOUY4Gvp1jq6mkxc"


--=-ESKRUOUY4Gvp1jq6mkxc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

* Automatically sets TDM mode for frame_width larger than 32 bits, if
  the user doesn't setup the TDM slots with set_tdm_slot().
* Reset SSCR0_EDSS and SSCR0_DSS on pxa_ssp_set_dai_fmt.
* Makes SSCR0_MOD optional.
* Clears SSCR1_RWOT case SSCR0_MOD is set.

Signed-off-by: Daniel Ribeiro <drwyrm@gmail.com>

---
 sound/soc/pxa/pxa-ssp.c |   88 ++++++++++++++++++++++++++++---------------=
---
 1 files changed, 53 insertions(+), 35 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 613cccb..7e72c41 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -452,8 +452,8 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_=
dai,
 	}
=20
 	/* reset port settings */
-	sscr0 =3D ssp_read_reg(ssp, SSCR0) &
-		(SSCR0_ECS |  SSCR0_NCS | SSCR0_MOD | SSCR0_ACS);
+	sscr0 =3D ssp_read_reg(ssp, SSCR0) & (SSCR0_ECS | SSCR0_NCS | SSCR0_MOD |
+			SSCR0_ACS | SSCR0_DSS | SSCR0_EDSS);
 	sscr1 =3D SSCR1_RxTresh(8) | SSCR1_TxTresh(7);
 	sspsp =3D 0;
=20
@@ -496,7 +496,7 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_=
dai,
 	case SND_SOC_DAIFMT_DSP_A:
 		sspsp |=3D SSPSP_FSRT;
 	case SND_SOC_DAIFMT_DSP_B:
-		sscr0 |=3D SSCR0_MOD | SSCR0_PSP;
+		sscr0 |=3D SSCR0_PSP;
 		sscr1 |=3D SSCR1_TRAIL | SSCR1_RWOT;
 		break;
=20
@@ -532,10 +532,18 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream=
 *substream,
 	struct ssp_priv *priv =3D cpu_dai->private_data;
 	struct ssp_device *ssp =3D priv->dev.ssp;
 	int chn =3D params_channels(params);
-	u32 sscr0;
-	u32 sspsp;
+	u32 sscr0, sscr1, sspsp;
 	int width =3D snd_pcm_format_physical_width(params_format(params));
-	int ttsa =3D ssp_read_reg(ssp, SSTSA) & 0xf;
+	int slot_width, frame_width =3D 0;
+
+	/* check if the user explicitly set a slot_width */
+	sscr0 =3D ssp_read_reg(ssp, SSCR0);
+
+	if (sscr0 & (SSCR0_EDSS | SSCR0_DSS))
+		slot_width =3D (sscr0 & SSCR0_DSS) +
+			(sscr0 & SSCR0_EDSS ? 17 : 1);
+	else
+		frame_width =3D slot_width =3D width * chn;
=20
 	/* generate correct DMA params */
 	if (cpu_dai->dma_data)
@@ -545,35 +553,53 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream=
 *substream,
 	 * to force 16-bit frame width on the wire (for S16_LE), even
 	 * with two channels. Use 16-bit DMA transfers for this case.
 	 */
-	cpu_dai->dma_data =3D ssp_get_dma_params(ssp,
-			((chn =3D=3D 2) && (ttsa !=3D 1)) || (width =3D=3D 32),
+	cpu_dai->dma_data =3D ssp_get_dma_params(ssp, slot_width > 16,
 			substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK);
=20
 	/* we can only change the settings if the port is not in use */
-	if (ssp_read_reg(ssp, SSCR0) & SSCR0_SSE)
+	if (sscr0 & SSCR0_SSE)
 		return 0;
=20
-	/* clear selected SSP bits */
-	sscr0 =3D ssp_read_reg(ssp, SSCR0) & ~(SSCR0_DSS | SSCR0_EDSS);
-	ssp_write_reg(ssp, SSCR0, sscr0);
-
-	/* bit size */
-	sscr0 =3D ssp_read_reg(ssp, SSCR0);
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
 #ifdef CONFIG_PXA3xx
-		if (cpu_is_pxa3xx())
-			sscr0 |=3D SSCR0_FPCKE;
+	if (width =3D=3D 16 && cpu_is_pxa3xx())
+		sscr0 |=3D SSCR0_FPCKE;
 #endif
-		sscr0 |=3D SSCR0_DataSize(16);
-		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
-		sscr0 |=3D (SSCR0_EDSS | SSCR0_DataSize(8));
-		break;
-	case SNDRV_PCM_FORMAT_S32_LE:
-		sscr0 |=3D (SSCR0_EDSS | SSCR0_DataSize(16));
-		break;
+
+	if (frame_width > 0) {
+		/* Not using network mode */
+		if (frame_width > 16)
+			sscr0 |=3D SSCR0_EDSS | SSCR0_DataSize(frame_width - 16);
+		else
+			sscr0 |=3D SSCR0_DataSize(frame_width);
+
+		if (frame_width > 32) {
+			/*
+			 * Network mode is needed to support this frame width.
+			 * We assume the wire is not networked and setup a
+			 * fake network mode here. Use as many slots as needed
+			 * each with 32 bits.
+			 */
+			int slots =3D frame_width / 32;
+
+			sscr0 |=3D SSCR0_MOD;
+			sscr0 |=3D SSCR0_SlotsPerFrm(slots);
+
+			/*
+			 * Set active slots. Only set an active TX slot
+			 * if we are going to use it.
+			 */
+			ssp_write_reg(ssp, SSRSA, slots - 1);
+			if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
+				ssp_write_reg(ssp, SSTSA, slots - 1);
+		}
 	}
+
+	/* If SSCR0_MOD is set we can't use SSCR1_RWOT */
+	if (sscr0 & SSCR0_MOD) {
+		sscr1 =3D ssp_read_reg(ssp, SSCR1);
+		ssp_write_reg(ssp, SSCR1, sscr1 & ~SSCR1_RWOT);
+	}
+
 	ssp_write_reg(ssp, SSCR0, sscr0);
=20
 	switch (priv->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
@@ -620,14 +646,6 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream =
*substream,
 		break;
 	}
=20
-	/* When we use a network mode, we always require TDM slots
-	 * - complain loudly and fail if they've not been set up yet.
-	 */
-	if ((sscr0 & SSCR0_MOD) && !ttsa) {
-		dev_err(&ssp->pdev->dev, "No TDM timeslot configured\n");
-		return -EINVAL;
-	}
-
 	dump_registers(ssp);
=20
 	return 0;
--=20
tg: (5231b18..) asoc/ssp-internals (depends on: asoc/set_tdm_slot)

--=20
Daniel Ribeiro

--=-ESKRUOUY4Gvp1jq6mkxc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta =?ISO-8859-1?Q?=E9?= uma parte de mensagem
 assinada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkow2aAACgkQw3OYl0G0liSYtACfW9WfFU5VRR3P1V4TquKfSZIL
92QAmgOnRf5BiMfyfVSbfGUw+78fhaCk
=ob0B
-----END PGP SIGNATURE-----

--=-ESKRUOUY4Gvp1jq6mkxc--


--===============7890506745010713606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7890506745010713606==--
