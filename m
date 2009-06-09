From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: [PATCH] ASoC: Automatically set TDM if needed on
 pxa-ssp and allow frame width override when using TDM.
Date: Tue, 09 Jun 2009 14:13:10 -0300
Message-ID: <1244567590.7406.100.camel@brutus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0618673898767325324=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D91F103802
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Jun 2009 19:13:17 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 9so70480qwj.56
	for <alsa-devel@alsa-project.org>; Tue, 09 Jun 2009 10:13:16 -0700 (PDT)
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


--===============0618673898767325324==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-PiUKe42rq19qefnGqabr"


--=-PiUKe42rq19qefnGqabr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

* Extend set_tdm_slot to allow the user to arbitrarily set the frame
  width and active TX/RX slots.
* Reset SSCR0_EDSS and SSCR0_DSS on pxa_ssp_set_dai_fmt.
* Makes SSCR0_MOD optional.
* Automatically sets network mode when needed if set_tdm_slot was
  never called.
* Clears SSCR1_RWOT case SSCR0_MOD is set.
* Updates magician.c and wm9081.c for the new set_tdm_slot()

(Patch is based on Mark's for-2.6.32 branch)

Signed-off-by: Daniel Ribeiro <drwyrm@gmail.com>

---
 include/sound/soc-dai.h   |    5 +
 sound/soc/codecs/wm9081.c |    4 -
 sound/soc/pxa/magician.c  |    2=20
 sound/soc/pxa/pxa-ssp.c   |  119 ++++++++++++++++++++++++++++-------------=
-----
 sound/soc/soc-core.c      |    9 ++-
 5 files changed, 85 insertions(+), 54 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 352d7ee..f96cc36 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -106,7 +106,7 @@ int snd_soc_dai_set_pll(struct snd_soc_dai *dai,
 int snd_soc_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt);
=20
 int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
-	unsigned int mask, int slots);
+	unsigned int tx_mask, unsigned int rx_mask, int slots, int frame_width);
=20
 int snd_soc_dai_set_tristate(struct snd_soc_dai *dai, int tristate);
=20
@@ -140,7 +140,8 @@ struct snd_soc_dai_ops {
 	 */
 	int (*set_fmt)(struct snd_soc_dai *dai, unsigned int fmt);
 	int (*set_tdm_slot)(struct snd_soc_dai *dai,
-		unsigned int mask, int slots);
+		unsigned int tx_mask, unsigned int rx_mask,
+		int slots, int frame_width);
 	int (*set_tristate)(struct snd_soc_dai *dai, int tristate);
=20
 	/*
diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index 86fc57e..85c720a 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -1207,7 +1207,7 @@ static int wm9081_set_sysclk(struct snd_soc_dai *code=
c_dai,
 }
=20
 static int wm9081_set_tdm_slot(struct snd_soc_dai *dai,
-			       unsigned int mask, int slots)
+	unsigned int tx_mask, unsigned int rx_mask, int slots, int frame_width)
 {
 	struct snd_soc_codec *codec =3D dai->codec;
 	unsigned int aif1 =3D wm9081_read(codec, WM9081_AUDIO_INTERFACE_1);
@@ -1219,7 +1219,7 @@ static int wm9081_set_tdm_slot(struct snd_soc_dai *da=
i,
=20
 	aif1 |=3D (slots - 1) << WM9081_AIFDAC_TDM_MODE_SHIFT;
=20
-	switch (mask) {
+	switch (tx_mask) {
 	case 1:
 		break;
 	case 2:
diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
index c89a3cd..2345869 100644
--- a/sound/soc/pxa/magician.c
+++ b/sound/soc/pxa/magician.c
@@ -188,7 +188,7 @@ static int magician_playback_hw_params(struct snd_pcm_s=
ubstream *substream,
 	if (ret < 0)
 		return ret;
=20
-	ret =3D snd_soc_dai_set_tdm_slot(cpu_dai, 1, 1);
+	ret =3D snd_soc_dai_set_tdm_slot(cpu_dai, 1, 1, 1, 16);
 	if (ret < 0)
 		return ret;
=20
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 46d14f3..f0931e7 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -375,21 +375,34 @@ static int pxa_ssp_set_dai_pll(struct snd_soc_dai *cp=
u_dai,
  * Set the active slots in TDM/Network mode
  */
 static int pxa_ssp_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai,
-	unsigned int mask, int slots)
+	unsigned int tx_mask, unsigned int rx_mask, int slots, int frame_width)
 {
 	struct ssp_priv *priv =3D cpu_dai->private_data;
 	struct ssp_device *ssp =3D priv->dev.ssp;
 	u32 sscr0;
=20
-	sscr0 =3D ssp_read_reg(ssp, SSCR0) & ~SSCR0_SlotsPerFrm(7);
+	sscr0 =3D ssp_read_reg(ssp, SSCR0);
+	sscr0 &=3D ~(SSCR0_MOD | SSCR0_SlotsPerFrm(7) | SSCR0_EDSS | SSCR0_DSS);
+
+	/* set frame width */
+	if (frame_width > 16)
+		sscr0 |=3D SSCR0_EDSS | SSCR0_DataSize(frame_width - 16);
+	else
+		sscr0 |=3D SSCR0_DataSize(frame_width);
+
+	if (slots > 1) {
+		/* enable network mode */
+		sscr0 |=3D SSCR0_MOD;
=20
-	/* set number of active slots */
-	sscr0 |=3D SSCR0_SlotsPerFrm(slots);
+		/* set number of active slots */
+		sscr0 |=3D SSCR0_SlotsPerFrm(slots);
+
+		/* set active slot mask */
+		ssp_write_reg(ssp, SSTSA, tx_mask);
+		ssp_write_reg(ssp, SSRSA, rx_mask);
+	}
 	ssp_write_reg(ssp, SSCR0, sscr0);
=20
-	/* set active slot mask */
-	ssp_write_reg(ssp, SSTSA, mask);
-	ssp_write_reg(ssp, SSRSA, mask);
 	return 0;
 }
=20
@@ -439,8 +452,8 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_=
dai,
 	}
=20
 	/* reset port settings */
-	sscr0 =3D ssp_read_reg(ssp, SSCR0) &
-		(SSCR0_ECS |  SSCR0_NCS | SSCR0_MOD | SSCR0_ACS);
+	sscr0 =3D ssp_read_reg(ssp, SSCR0) & (SSCR0_ECS | SSCR0_NCS | SSCR0_MOD |
+			SSCR0_ACS | SSCR0_EDSS | SSCR0_DSS);
 	sscr1 =3D SSCR1_RxTresh(8) | SSCR1_TxTresh(7);
 	sspsp =3D 0;
=20
@@ -487,7 +500,7 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_=
dai,
 	case SND_SOC_DAIFMT_DSP_A:
 		sspsp |=3D SSPSP_FSRT;
 	case SND_SOC_DAIFMT_DSP_B:
-		sscr0 |=3D SSCR0_MOD | SSCR0_PSP;
+		sscr0 |=3D SSCR0_PSP;
 		sscr1 |=3D SSCR1_TRAIL | SSCR1_RWOT;
=20
 		switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
@@ -537,48 +550,70 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream=
 *substream,
 	struct ssp_priv *priv =3D cpu_dai->private_data;
 	struct ssp_device *ssp =3D priv->dev.ssp;
 	int chn =3D params_channels(params);
-	u32 sscr0;
-	u32 sspsp;
+	u32 sscr0, sscr1, sspsp;
 	int width =3D snd_pcm_format_physical_width(params_format(params));
-	int ttsa =3D ssp_read_reg(ssp, SSTSA) & 0xf;
+	int frame_width;
+
+	/* check if the user explicitly set a frame_width */
+	sscr0 =3D ssp_read_reg(ssp, SSCR0);
+
+	if (sscr0 & (SSCR0_EDSS | SSCR0_DSS))
+		frame_width =3D (sscr0 & SSCR0_DSS) +
+			(sscr0 & SSCR0_EDSS ? 17 : 1);
+	else
+		frame_width =3D width * chn;
=20
 	/* generate correct DMA params */
 	if (cpu_dai->dma_data)
 		kfree(cpu_dai->dma_data);
=20
-	/* Network mode with one active slot (ttsa =3D=3D 1) can be used
-	 * to force 16-bit frame width on the wire (for S16_LE), even
-	 * with two channels. Use 16-bit DMA transfers for this case.
-	 */
-	cpu_dai->dma_data =3D ssp_get_dma_params(ssp,
-			((chn =3D=3D 2) && (ttsa !=3D 1)) || (width =3D=3D 32),
+	cpu_dai->dma_data =3D ssp_get_dma_params(ssp, frame_width > 16,
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
+	/* FIXME: What this is for? */
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
+	if (!(sscr0 & (SSCR0_EDSS | SSCR0_DSS))) {
+		/* Frame width not set yet, we are not using network mode */
+		if (frame_width > 16)
+			sscr0 |=3D SSCR0_EDSS | SSCR0_DataSize(frame_width - 16);
+		else
+			sscr0 |=3D SSCR0_DataSize(frame_width);
+
+		if (frame_width > 32) {
+			/*
+			 * Network mode is needed to support this frame_width
+			 * We assume that the wire is not networked and setup
+			 * a "fake" network mode here.
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
@@ -625,14 +660,6 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream =
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
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e1a920c..69becf2 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2133,17 +2133,20 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_fmt);
 /**
  * snd_soc_dai_set_tdm_slot - configure DAI TDM.
  * @dai: DAI
- * @mask: DAI specific mask representing used slots.
+ * @tx_mask: bitmask representing active TX slots.
+ * @rx_mask: bitmask representing active RX slots.
  * @slots: Number of slots in use.
+ * @frame_width: Width in bits for each slot.
  *
  * Configures a DAI for TDM operation. Both mask and slots are codec and D=
AI
  * specific.
  */
 int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
-	unsigned int mask, int slots)
+	unsigned int tx_mask, unsigned int rx_mask, int slots, int frame_width)
 {
 	if (dai->ops && dai->ops->set_tdm_slot)
-		return dai->ops->set_tdm_slot(dai, mask, slots);
+		return dai->ops->set_tdm_slot(dai, tx_mask, rx_mask,
+				slots, frame_width);
 	else
 		return -EINVAL;
 }

--=20
Daniel Ribeiro

--=-PiUKe42rq19qefnGqabr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta =?ISO-8859-1?Q?=E9?= uma parte de mensagem
 assinada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkoumB0ACgkQw3OYl0G0liQDNwCgkIRu+iz1ailfipXlj1WZPiuY
xVkAn1KC/epTQn0HMBUBVlCBOgmk9aS2
=WXKl
-----END PGP SIGNATURE-----

--=-PiUKe42rq19qefnGqabr--


--===============0618673898767325324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0618673898767325324==--
