From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: [RFC] Auto setup TDM when needed. Add frame_width and
 rx/tx masks to set_tdm_slots.
Date: Mon, 08 Jun 2009 18:07:24 -0300
Message-ID: <1244495244.17327.184.camel@brutus>
References: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
	<20090606201225.GA1029@sirena.org.uk>
	<74d0deb30906080512q29b9915fvec9b068bf4b2e126@mail.gmail.com>
	<20090608124045.GE7858@sirena.org.uk>
	<1244477000.30582.72.camel@brutus>
	<20090608165328.GB14026@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6994471272896615259=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BC5B1037F2
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 23:08:44 +0200 (CEST)
Received: by qyk1 with SMTP id 1so4398847qyk.16
	for <alsa-devel@alsa-project.org>; Mon, 08 Jun 2009 14:08:43 -0700 (PDT)
In-Reply-To: <20090608165328.GB14026@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6994471272896615259==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-4phTt5yFa1pE/IShIo/3"


--=-4phTt5yFa1pE/IShIo/3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em Seg, 2009-06-08 =C3=A0s 17:53 +0100, Mark Brown escreveu:
> I'd like to see all these details handled within the driver - knowing if
> and when network mode are to be set up is the sort of thing that users
> ought to be able to rely on the driver for.

Untested, RFC only version of patch.
(plus some minor copynpaste and whitespace fixes)

Am I on the right direction? :)

 include/sound/soc-dai.h |    3 +
 sound/soc/pxa/pxa-ssp.c |   86 +++++++++++++++++++++++++++++--------------=
-----
 sound/soc/soc-core.c    |   13 ++++---
 3 files changed, 62 insertions(+), 40 deletions(-)
--
diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 1367647..0bf9502 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -154,7 +154,8 @@ struct snd_soc_dai_ops {
 	 */
 	int (*set_fmt)(struct snd_soc_dai *dai, unsigned int fmt);
 	int (*set_tdm_slot)(struct snd_soc_dai *dai,
-		unsigned int mask, int slots);
+		unsigned int tx_mask, unsigned int rx_mask,
+		int slots, int frame_width);
 	int (*set_tristate)(struct snd_soc_dai *dai, int tristate);
=20
 	/*
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 92838af..a0b7bad 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -490,21 +490,31 @@ static int pxa_ssp_set_dai_pll(struct snd_soc_dai *cp=
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
+	sscr0 &=3D ~(SSCR0_SlotsPerFrm(7) | SSCR0_EDSS | SSCR0_DSS);
+
+	/* enable network mode */
+	sscr0 |=3D SSCR0_MOD;
+
+	/* set frame width */
+	if (frame_width > 16)
+		sscr0 |=3D SSCR0_EDSS | SSCR0_DataSize(frame_width - 16);
+	else
+		sscr0 |=3D SSCR0_DataSize(frame_width);
=20
 	/* set number of active slots */
 	sscr0 |=3D SSCR0_SlotsPerFrm(slots);
 	ssp_write_reg(ssp, SSCR0, sscr0);
=20
 	/* set active slot mask */
-	ssp_write_reg(ssp, SSTSA, mask);
-	ssp_write_reg(ssp, SSRSA, mask);
+	ssp_write_reg(ssp, SSTSA, tx_mask);
+	ssp_write_reg(ssp, SSRSA, rx_mask);
 	return 0;
 }
=20
@@ -555,7 +565,7 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_=
dai,
=20
 	/* reset port settings */
 	sscr0 =3D ssp_read_reg(ssp, SSCR0) &
-		(SSCR0_ECS |  SSCR0_NCS | SSCR0_MOD | SSCR0_ACS);
+		(SSCR0_ECS | SSCR0_NCS | SSCR0_MOD | SSCR0_ACS);
 	sscr1 =3D SSCR1_RxTresh(8) | SSCR1_TxTresh(7);
 	sspsp =3D 0;
=20
@@ -602,7 +612,7 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_=
dai,
 	case SND_SOC_DAIFMT_DSP_A:
 		sspsp |=3D SSPSP_FSRT;
 	case SND_SOC_DAIFMT_DSP_B:
-		sscr0 |=3D SSCR0_MOD | SSCR0_PSP;
+		sscr0 |=3D SSCR0_PSP;
 		sscr1 |=3D SSCR1_TRAIL | SSCR1_RWOT;
=20
 		switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
@@ -652,10 +662,10 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream=
 *substream,
 	struct ssp_priv *priv =3D cpu_dai->private_data;
 	struct ssp_device *ssp =3D priv->dev.ssp;
 	int dma =3D 0, chn =3D params_channels(params);
-	u32 sscr0;
+	u32 sscr0, sscr1;
 	u32 sspsp;
 	int width =3D snd_pcm_format_physical_width(params_format(params));
-	int ttsa =3D ssp_read_reg(ssp, SSTSA) & 0xf;
+	int frame_width =3D width * chn;
=20
 	/* select correct DMA params */
 	if (substream->stream !=3D SNDRV_PCM_STREAM_PLAYBACK)
@@ -664,7 +674,7 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *=
substream,
 	 * to force 16-bit frame width on the wire (for S16_LE), even
 	 * with two channels. Use 16-bit DMA transfers for this case.
 	 */
-	if (((chn =3D=3D 2) && (ttsa !=3D 1)) || (width =3D=3D 32))
+	if (frame_width >=3D 32)
 		dma +=3D 2; /* 32-bit DMA offset is 2, 16-bit is 0 */
=20
 	cpu_dai->dma_data =3D ssp_dma_params[cpu_dai->id][dma];
@@ -675,32 +685,48 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream=
 *substream,
 	if (ssp_read_reg(ssp, SSCR0) & SSCR0_SSE)
 		return 0;
=20
-	/* clear selected SSP bits */
-	sscr0 =3D ssp_read_reg(ssp, SSCR0) & ~(SSCR0_DSS | SSCR0_EDSS);
-	ssp_write_reg(ssp, SSCR0, sscr0);
+	/* frame width */
+	sscr0 =3D ssp_read_reg(ssp, SSCR0) & ~(SSCR0_EDSS | SSCR0_DSS);
=20
-	/* bit size */
-	sscr0 =3D ssp_read_reg(ssp, SSCR0);
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
+	/* FIXME: Is this needed? */
 #ifdef CONFIG_PXA3xx
-		if (cpu_is_pxa3xx())
-			sscr0 |=3D SSCR0_FPCKE;
+	if (width =3D=3D 16 && cpu_is_pxa3xx())
+		sscr0 |=3D SSCR0_FPCKE;
 #endif
+
+	if (!(sscr0 & SSCR0_MOD)) {
+
+		/* Not on network mode, setup the frame width */
 		sscr0 |=3D SSCR0_DataSize(16);
-		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
-		sscr0 |=3D (SSCR0_EDSS | SSCR0_DataSize(8));
-		break;
-	case SNDRV_PCM_FORMAT_S32_LE:
-		sscr0 |=3D (SSCR0_EDSS | SSCR0_DataSize(16));
-		break;
+		if (frame_width >=3D 32)
+			sscr0 |=3D SSCR0_EDSS;
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
+			ssp_write_reg(ssp, SSTSA, slots - 1);
+			ssp_write_reg(ssp, SSRSA, slots - 1);
+		}
+	}
+
+	/* If SSCR0_MOD is set we can't use SSCR1_RWOT */
+	if (sscr0 & SSCR0_MOD) {
+		sscr1 =3D ssp_read_reg(ssp, SSCR1);
+		ssp_write_reg(ssp, SSCR1, sscr1 & ~SSCR1_RWOT);
 	}
+
 	ssp_write_reg(ssp, SSCR0, sscr0);
=20
 	switch (priv->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
-	       sspsp =3D ssp_read_reg(ssp, SSPSP);
+		sspsp =3D ssp_read_reg(ssp, SSPSP);
=20
 		if ((ssp_get_scr(ssp) =3D=3D 4) && (width =3D=3D 16)) {
 			/* This is a special case where the bitclk is 64fs
@@ -742,14 +768,6 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream =
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
index c9f19d0..ce13b6d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2130,17 +2130,20 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_fmt);
 /**
  * snd_soc_dai_set_tdm_slot - configure DAI TDM.
  * @dai: DAI
- * @mask: DAI specific mask representing used slots.
+ * @tx_mask: DAI specific mask representing TX slots.
+ * @rx_mask: DAI specific mask representing RX slots.
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
-	if (dai->ops->set_sysclk)
-		return dai->ops->set_tdm_slot(dai, mask, slots);
+	if (dai->ops->set_tdm_slot)
+		return dai->ops->set_tdm_slot(dai, tx_mask, rx_mask,
+				slots, frame_width);
 	else
 		return -EINVAL;
 }
@@ -2155,7 +2158,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_tdm_slot);
  */
 int snd_soc_dai_set_tristate(struct snd_soc_dai *dai, int tristate)
 {
-	if (dai->ops->set_sysclk)
+	if (dai->ops->set_tristate)
 		return dai->ops->set_tristate(dai, tristate);
 	else
 		return -EINVAL;

--=20
Daniel Ribeiro

--=-4phTt5yFa1pE/IShIo/3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta =?ISO-8859-1?Q?=E9?= uma parte de mensagem
 assinada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkotfYwACgkQw3OYl0G0liQ2YgCggvJgjhQ0/EL+N32+Kvc3eC8W
I+4An2AvsQdoa6um+jPkt9Y2JRmGrJSc
=SSx2
-----END PGP SIGNATURE-----

--=-4phTt5yFa1pE/IShIo/3--


--===============6994471272896615259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6994471272896615259==--
