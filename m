From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: [PATCH v2] ASoC: da7210: Add support for PLL and SRM
Date: Mon, 23 Jan 2012 15:37:21 +0530
Message-ID: <1327313241.31594.12.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
	by alsa0.perex.cz (Postfix) with ESMTP id A464D24470
	for <alsa-devel@alsa-project.org>; Mon, 23 Jan 2012 10:55:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg <lrg@ti.com>, alsa-devel <alsa-devel@alsa-project.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

Current DA7210 driver does support PLL mode fully. It uses fixed
value of input master clock and PLL mode is enabled and disabled based
on the sampling frequency being used for playback or recording. It also
doesn't support Sample Rate Measurement feature of DA7210 hardware.

This patch adds full support for PLL and SRM. Basically following three
modes of operation are possible for DA7210 hardware,

(1) I2S SLAVE mode with PLL bypassed
(2) I2S SLAVE mode with PLL enabled
(3) I2S Master mode with PLL enabled

This patch adds support for all three modes. Also, in case of SLAVE mode
with PLL, it supports SRM (Sample Rate Measurement) feature of the chip.

This patch has been tested on DA7210 EVB with Samsung SMDK6410 board.

Signed-off-by: Ashish Chavan <ashish.chavan@kpitcummins.com>
Signed-off-by: David Dajun Chen <dchen@diasemi.com>
---
Changes since v1:
- Removed unnecessary function to configure clock dividers
- Changed data layout and code related to PLL dividers. Tried making it
more readable and robust
---
 sound/soc/codecs/da7210.c |  259 +++++++++++++++++++++++++++++++++++++--------
 1 files changed, 216 insertions(+), 43 deletions(-)

diff --git a/sound/soc/codecs/da7210.c b/sound/soc/codecs/da7210.c
index ab38e93..4d7eec4 100644
--- a/sound/soc/codecs/da7210.c
+++ b/sound/soc/codecs/da7210.c
@@ -145,6 +145,7 @@
 #define DA7210_DAI_EN			(1 << 7)
 
 /*PLL_DIV3 bit fields */
+#define DA7210_PLL_DIV_L_MASK		(0xF << 0)
 #define DA7210_MCLK_RANGE_10_20_MHZ	(1 << 4)
 #define DA7210_PLL_BYP			(1 << 6)
 
@@ -161,12 +162,16 @@
 #define DA7210_PLL_FS_48000		(0xB << 0)
 #define DA7210_PLL_FS_88200		(0xE << 0)
 #define DA7210_PLL_FS_96000		(0xF << 0)
+#define DA7210_MCLK_DET_EN		(0x1 << 5)
+#define DA7210_MCLK_SRM_EN		(0x1 << 6)
 #define DA7210_PLL_EN			(0x1 << 7)
 
 /* SOFTMUTE bit fields */
 #define DA7210_RAMP_EN			(1 << 6)
 
 /* CONTROL bit fields */
+#define DA7210_REG_EN			(1 << 0)
+#define DA7210_BIAS_EN			(1 << 2)
 #define DA7210_NOISE_SUP_EN		(1 << 3)
 
 /* IN_GAIN bit fields */
@@ -205,6 +210,57 @@
 #define DA7210_OUT2_OUTMIX_L		(1 << 6)
 #define DA7210_OUT2_EN			(1 << 7)
 
+/* PLL out frequency values */
+#define FOUT_2822400		2822400
+#define FOUT_3072000		3072000
+
+/* Index fields for PLL divider array */
+#define FREF_IDX		(0 << 0)
+#define DIV1_IDX		(1 << 0)
+#define DIV2_IDX		(2 << 0)
+#define DIV3_IDX		(3 << 0)
+
+/* Number of PLL input frequencies supported */
+#define FREF_CNT		(7 << 0)
+/* Number of PLL dividers for each frequency */
+#define DIV_CNT			(3 << 0)
+
+/* PLL Master mode dividers */
+static const u32 da7210_fout_2822400_div[][DIV_CNT + 1] = {
+	{ 12000000, 0xE8, 0x6C, 0x2, },		/* MCLK=12Mhz    Fs=44.1Khz */
+	{ 13000000, 0xDF, 0x28, 0xC, },		/* MCLK=13Mhz    Fs=44.1Khz */
+	{ 13500000, 0xDB, 0x0A, 0xD, },		/* MCLK=13.5Mhz  Fs=44.1Khz */
+	{ 14400000, 0xD4, 0x5A, 0x2, },		/* MCLK=14.4Mhz  Fs=44.1Khz */
+	{ 19200000, 0xBB, 0x43, 0x9, },		/* MCLK=19.2Mhz  Fs=44.1Khz */
+	{ 19680000, 0xB9, 0x6D, 0xA, },		/* MCLK=19.68Mhz Fs=44.1Khz */
+	{ 19800000, 0xB8, 0xFB, 0xB, },		/* MCLK=19.8Mhz  Fs=44.1Khz */
+};
+
+static const u32 da7210_fout_3072000_div[][DIV_CNT + 1] = {
+	{ 12000000, 0xF3, 0x12, 0x7, },		/* MCLK=12Mhz    Fs=48Khz */
+	{ 13000000, 0xE8, 0xFD, 0x5, },		/* MCLK=13Mhz    Fs=48Khz */
+	{ 13500000, 0xE4, 0x82, 0x3, },		/* MCLK=13.5Mhz  Fs=48Khz */
+	{ 14400000, 0xDD, 0x3A, 0x0, },		/* MCLK=14.4Mhz  Fs=48Khz */
+	{ 19200000, 0xC1, 0xEB, 0x8, },		/* MCLK=19.2Mhz  Fs=48Khz */
+	{ 19680000, 0xBF, 0xEC, 0x0, },		/* MCLK=19.68Mhz Fs=48Khz */
+	{ 19800000, 0xBF, 0x70, 0x0, },		/* MCLK=19.8Mhz  Fs=48Khz */
+};
+
+/* PLL SRM mode dividers */
+static const u32 da7210_pll_srm_div[][DIV_CNT + 1] = {
+	{ 12000000, 0xED, 0xBF, 0x5, },		/* MCLK=12Mhz */
+	{ 13000000, 0xE4, 0x13, 0x0, },		/* MCLK=13Mhz */
+	{ 13500000, 0xDF, 0xC6, 0x8, },		/* MCLK=13.5Mhz */
+	{ 14400000, 0xD8, 0xCA, 0x1, },		/* MCLK=14.4Mhz */
+	{ 19200000, 0xBE, 0x97, 0x9, },		/* MCLK=19.2Mhz */
+	{ 19680000, 0xBC, 0xAC, 0xD, },		/* MCLK=19.68Mhz */
+	{ 19800000, 0xBC, 0x35, 0xE, },		/* MCLK=19.8Mhz  */
+};
+
+enum clk_src {
+	DA7210_CLKSRC_MCLK
+};
+
 #define DA7210_VERSION "0.0.1"
 
 /*
@@ -627,6 +683,8 @@ static const struct snd_soc_dapm_route da7210_audio_map[] = {
 /* Codec private data */
 struct da7210_priv {
 	enum snd_soc_control_type control_type;
+	unsigned int mclk_rate;
+	int master;
 };
 
 /*
@@ -673,8 +731,9 @@ static int da7210_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_codec *codec = rtd->codec;
+	struct da7210_priv *da7210 = snd_soc_codec_get_drvdata(codec);
 	u32 dai_cfg1;
-	u32 fs, bypass;
+	u32 fs;
 
 	/* set DAI source to Left and Right ADC */
 	snd_soc_write(codec, DA7210_DAI_SRC_SEL,
@@ -707,43 +766,33 @@ static int da7210_hw_params(struct snd_pcm_substream *substream,
 	switch (params_rate(params)) {
 	case 8000:
 		fs		= DA7210_PLL_FS_8000;
-		bypass		= DA7210_PLL_BYP;
 		break;
 	case 11025:
 		fs		= DA7210_PLL_FS_11025;
-		bypass		= 0;
 		break;
 	case 12000:
 		fs		= DA7210_PLL_FS_12000;
-		bypass		= DA7210_PLL_BYP;
 		break;
 	case 16000:
 		fs		= DA7210_PLL_FS_16000;
-		bypass		= DA7210_PLL_BYP;
 		break;
 	case 22050:
 		fs		= DA7210_PLL_FS_22050;
-		bypass		= 0;
 		break;
 	case 32000:
 		fs		= DA7210_PLL_FS_32000;
-		bypass		= DA7210_PLL_BYP;
 		break;
 	case 44100:
 		fs		= DA7210_PLL_FS_44100;
-		bypass		= 0;
 		break;
 	case 48000:
 		fs		= DA7210_PLL_FS_48000;
-		bypass		= DA7210_PLL_BYP;
 		break;
 	case 88200:
 		fs		= DA7210_PLL_FS_88200;
-		bypass		= 0;
 		break;
 	case 96000:
 		fs		= DA7210_PLL_FS_96000;
-		bypass		= DA7210_PLL_BYP;
 		break;
 	default:
 		return -EINVAL;
@@ -753,8 +802,15 @@ static int da7210_hw_params(struct snd_pcm_substream *substream,
 	snd_soc_update_bits(codec, DA7210_STARTUP1, DA7210_SC_MST_EN, 0);
 
 	snd_soc_update_bits(codec, DA7210_PLL, DA7210_PLL_FS_MASK, fs);
-	snd_soc_update_bits(codec, DA7210_PLL_DIV3, DA7210_PLL_BYP, bypass);
 
+	if (da7210->mclk_rate) {
+		/* PLL mode, disable PLL bypass */
+		snd_soc_update_bits(codec, DA7210_PLL_DIV3, DA7210_PLL_BYP, 0);
+	} else {
+		/* PLL bypass mode, enable PLL bypass */
+		snd_soc_update_bits(codec, DA7210_PLL_DIV3, DA7210_PLL_BYP,
+							    DA7210_PLL_BYP);
+	}
 	/* Enable active mode */
 	snd_soc_update_bits(codec, DA7210_STARTUP1,
 			    DA7210_SC_MST_EN, DA7210_SC_MST_EN);
@@ -768,6 +824,7 @@ static int da7210_hw_params(struct snd_pcm_substream *substream,
 static int da7210_set_dai_fmt(struct snd_soc_dai *codec_dai, u32 fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
+	struct da7210_priv *da7210 = snd_soc_codec_get_drvdata(codec);
 	u32 dai_cfg1;
 	u32 dai_cfg3;
 
@@ -776,9 +833,11 @@ static int da7210_set_dai_fmt(struct snd_soc_dai *codec_dai, u32 fmt)
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
+		da7210->master = 1;
 		dai_cfg1 |= DA7210_DAI_MODE_MASTER;
 		break;
 	case SND_SOC_DAIFMT_CBS_CFS:
+		da7210->master = 0;
 		dai_cfg1 |= DA7210_DAI_MODE_SLAVE;
 		break;
 	default:
@@ -830,10 +889,148 @@ static int da7210_mute(struct snd_soc_dai *dai, int mute)
 #define DA7210_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
+static int da7210_set_dai_sysclk(struct snd_soc_dai *codec_dai,
+				 int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct da7210_priv *da7210 = snd_soc_codec_get_drvdata(codec);
+
+	switch (clk_id) {
+	case DA7210_CLKSRC_MCLK:
+		switch (freq) {
+		case 12000000:
+		case 13000000:
+		case 13500000:
+		case 14400000:
+		case 19200000:
+		case 19680000:
+		case 19800000:
+			da7210->mclk_rate = freq;
+			return 0;
+		default:
+			dev_err(codec_dai->dev, "Unsupported MCLK value %d\n",
+				freq);
+			return -EINVAL;
+		}
+		break;
+	default:
+		dev_err(codec_dai->dev, "Unknown clock source %d\n", clk_id);
+		return -EINVAL;
+	}
+}
+
+/**
+ * da7210_set_dai_pll	:Configure the codec PLL
+ * @param codec_dai	: pointer to codec DAI
+ * @param pll_id	: da7210 has only one pll, so pll_id is always zero
+ * @param fref		: MCLK frequency, should be < 20MHz
+ * @param fout		: FsDM value, Refer page 44 & 45 of datasheet
+ * @return int		: Zero for success, negative error code for error
+ *
+ * Note: Supported PLL input frequencies are 12MHz, 13MHz, 13.5MHz, 14.4MHz,
+ *       19.2MHz, 19.6MHz and 19.8MHz
+ */
+static int da7210_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
+			      int source, unsigned int fref, unsigned int fout)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct da7210_priv *da7210 = snd_soc_codec_get_drvdata(codec);
+
+	u8 pll_div1, pll_div2, pll_div3, row_idx;
+
+	if (da7210->master) {
+		/* In PLL master mode, use master mode PLL dividers */
+		if (fout == FOUT_2822400) {
+			for (row_idx = 0; row_idx < FREF_CNT; row_idx++) {
+				if (fref == da7210_fout_2822400_div[row_idx]
+								[FREF_IDX]) {
+					pll_div1 =
+						da7210_fout_2822400_div[row_idx]
+						[DIV1_IDX];
+					pll_div2 =
+						da7210_fout_2822400_div[row_idx]
+						[DIV2_IDX];
+					pll_div3 =
+						da7210_fout_2822400_div[row_idx]
+						[DIV3_IDX];
+					break;
+				}
+			}
+		} else if (fout == FOUT_3072000) {
+			for (row_idx = 0; row_idx < FREF_CNT; row_idx++) {
+				if (fref == da7210_fout_3072000_div[row_idx]
+								[FREF_IDX]) {
+					pll_div1 =
+						da7210_fout_3072000_div[row_idx]
+						[DIV1_IDX];
+					pll_div2 =
+						da7210_fout_3072000_div[row_idx]
+						[DIV2_IDX];
+					pll_div3 =
+						da7210_fout_3072000_div[row_idx]
+						[DIV3_IDX];
+					break;
+				}
+			}
+		} else {
+			dev_err(codec_dai->dev,
+				"Unsupported PLL output frequency %d\n", fout);
+			return -EINVAL;
+		}
+		if (row_idx >= FREF_CNT)
+			goto err;
+	} else {
+		/* In PLL slave mode, use SRM mode PLL dividers */
+		for (row_idx = 0; row_idx < FREF_CNT; row_idx++) {
+			if (fref == da7210_pll_srm_div[row_idx][FREF_IDX]) {
+				pll_div1 =
+					da7210_pll_srm_div[row_idx][DIV1_IDX];
+				pll_div2 =
+					da7210_pll_srm_div[row_idx][DIV2_IDX];
+				pll_div3 =
+					da7210_pll_srm_div[row_idx][DIV3_IDX];
+				break;
+			}
+		}
+		if (row_idx >= FREF_CNT)
+			goto err;
+	}
+
+	/* Disable active mode */
+	snd_soc_update_bits(codec, DA7210_STARTUP1, DA7210_SC_MST_EN, 0);
+	/* Write PLL dividers */
+	snd_soc_write(codec, DA7210_PLL_DIV1, pll_div1);
+	snd_soc_write(codec, DA7210_PLL_DIV2, pll_div2);
+	snd_soc_update_bits(codec, DA7210_PLL_DIV3,
+				   DA7210_PLL_DIV_L_MASK, pll_div3);
+
+	if (da7210->master) {
+		/* In master mode, no need to enable SRM */
+		snd_soc_update_bits(codec, DA7210_PLL, DA7210_PLL_EN,
+						       DA7210_PLL_EN);
+	} else {
+		/* In slave mode, enable SRM and PLL */
+		snd_soc_update_bits(codec, DA7210_PLL,
+				   (DA7210_PLL_EN | DA7210_MCLK_SRM_EN |
+						     DA7210_MCLK_DET_EN),
+				   (DA7210_PLL_EN | DA7210_MCLK_SRM_EN |
+						    DA7210_MCLK_DET_EN));
+	}
+	/* Enable active mode */
+	snd_soc_update_bits(codec, DA7210_STARTUP1, DA7210_SC_MST_EN,
+						    DA7210_SC_MST_EN);
+	return 0;
+err:
+	dev_err(codec_dai->dev, "Unsupported PLL input frequency %d\n", fref);
+	return -EINVAL;
+}
+
 /* DAI operations */
 static const struct snd_soc_dai_ops da7210_dai_ops = {
 	.hw_params	= da7210_hw_params,
 	.set_fmt	= da7210_set_dai_fmt,
+	.set_sysclk	= da7210_set_dai_sysclk,
+	.set_pll	= da7210_set_dai_pll,
 	.digital_mute	= da7210_mute,
 };
 
@@ -872,24 +1069,13 @@ static int da7210_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	/* FIXME
-	 *
-	 * This driver use fixed value here
-	 * And below settings expects MCLK = 12.288MHz
-	 *
-	 * When you select different MCLK, please check...
-	 *      DA7210_PLL_DIV1 val
-	 *      DA7210_PLL_DIV2 val
-	 *      DA7210_PLL_DIV3 val
-	 *      DA7210_PLL_DIV3 :: DA7210_MCLK_RANGExxx
-	 */
+	da7210->mclk_rate	= 0;	/* This will be set from set_sysclk() */
+	da7210->master		= 0;	/* This will be set from set_fmt() */
+
+	/* Enable internal regulator & bias current */
+	snd_soc_write(codec, DA7210_CONTROL, DA7210_REG_EN | DA7210_BIAS_EN);
 
-	/*
-	 * make sure that DA7210 use bypass mode before start up
-	 */
 	snd_soc_write(codec, DA7210_STARTUP1, 0);
-	snd_soc_write(codec, DA7210_PLL_DIV3,
-		     DA7210_MCLK_RANGE_10_20_MHZ | DA7210_PLL_BYP);
 
 	/*
 	 * ADC settings
@@ -964,24 +1150,11 @@ static int da7210_probe(struct snd_soc_codec *codec)
 	/* Enable Aux2 */
 	snd_soc_write(codec, DA7210_AUX2, DA7210_AUX2_EN);
 
+	/* Set PLL Master clock range 10-20 MHz */
+	snd_soc_write(codec, DA7210_PLL_DIV3, DA7210_MCLK_RANGE_10_20_MHZ);
 	/* Diable PLL and bypass it */
 	snd_soc_write(codec, DA7210_PLL, DA7210_PLL_FS_48000);
 
-	/*
-	 * If 48kHz sound came, it use bypass mode,
-	 * and when it is 44.1kHz, it use PLL.
-	 *
-	 * This time, this driver sets PLL always ON
-	 * and controls bypass/PLL mode by switching
-	 * DA7210_PLL_DIV3 :: DA7210_PLL_BYP bit.
-	 *   see da7210_hw_params
-	 */
-	snd_soc_write(codec, DA7210_PLL_DIV1, 0xE5); /* MCLK = 12.288MHz */
-	snd_soc_write(codec, DA7210_PLL_DIV2, 0x99);
-	snd_soc_write(codec, DA7210_PLL_DIV3, 0x0A |
-		     DA7210_MCLK_RANGE_10_20_MHZ | DA7210_PLL_BYP);
-	snd_soc_update_bits(codec, DA7210_PLL, DA7210_PLL_EN, DA7210_PLL_EN);
-
 	/* As suggested by Dialog */
 	snd_soc_write(codec, DA7210_A_HID_UNLOCK,	0x8B); /* unlock */
 	snd_soc_write(codec, DA7210_A_TEST_UNLOCK,	0xB4);
-- 
1.7.1
