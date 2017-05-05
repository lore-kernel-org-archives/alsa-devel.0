From: Ryan Lee <ryans.lee@maximintegrated.com>
Subject: [PATCH] ASoC: max98927: Adding support for TDM mode and Envelop tracking control
Date: Fri, 5 May 2017 10:42:15 -0700
Message-ID: <1494006135-1178-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, ryans.lee@maximintegrated.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: ryan.lee.maxim@gmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
Changes
    * Added code to support TDM mode.
    * Added "EnvTrack Switch" and "EnvTrack Headroom" controls.
    * Added six more registers into volatile register list.
    * Added missing \n to end of dev_err messages.
    * Removed an obsolete variable from 'max98927_priv'.

 sound/soc/codecs/max98927.c | 173 ++++++++++++++++++++++++++++++++++++--------
 sound/soc/codecs/max98927.h |  17 +++--
 2 files changed, 152 insertions(+), 38 deletions(-)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index b5ee294..9b864e2 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -1,7 +1,7 @@
 /*
  * max98927.c  --  MAX98927 ALSA Soc Audio driver
  *
- * Copyright (C) 2016 Maxim Integrated Products
+ * Copyright (C) 2016-2017 Maxim Integrated Products
  * Author: Ryan Lee <ryans.lee@maximintegrated.com>
  *
  *  This program is free software; you can redistribute  it and/or modify it
@@ -146,6 +146,7 @@ static int max98927_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
 	unsigned int mode = 0;
 	unsigned int format = 0;
+	bool use_pdm = false;
 	unsigned int invert = 0;
 
 	dev_dbg(codec->dev, "%s: fmt 0x%08X\n", __func__, fmt);
@@ -159,7 +160,7 @@ static int max98927_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		mode = MAX98927_PCM_MASTER_MODE_MASTER;
 		break;
 	default:
-		dev_err(codec->dev, "DAI clock mode unsupported");
+		dev_err(codec->dev, "DAI clock mode unsupported\n");
 		return -EINVAL;
 	}
 
@@ -175,7 +176,7 @@ static int max98927_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		invert = MAX98927_PCM_MODE_CFG_PCM_BCLKEDGE;
 		break;
 	default:
-		dev_err(codec->dev, "DAI invert mode unsupported");
+		dev_err(codec->dev, "DAI invert mode unsupported\n");
 		return -EINVAL;
 	}
 
@@ -187,22 +188,27 @@ static int max98927_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	/* interface format */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
-		max98927->iface |= SND_SOC_DAIFMT_I2S;
 		format = MAX98927_PCM_FORMAT_I2S;
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
-		max98927->iface |= SND_SOC_DAIFMT_LEFT_J;
 		format = MAX98927_PCM_FORMAT_LJ;
 		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		format = MAX98927_PCM_FORMAT_TDM_MODE1;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		format = MAX98927_PCM_FORMAT_TDM_MODE0;
+		break;
 	case SND_SOC_DAIFMT_PDM:
-		max98927->iface |= SND_SOC_DAIFMT_PDM;
+		use_pdm = true;
 		break;
 	default:
 		return -EINVAL;
 	}
+	max98927->iface = fmt & SND_SOC_DAIFMT_FORMAT_MASK;
 
-	/* pcm channel configuration */
-	if (max98927->iface & (SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_LEFT_J)) {
+	if (!use_pdm) {
+		/* pcm channel configuration */
 		regmap_update_bits(max98927->regmap,
 			MAX98927_R0018_PCM_RX_EN_A,
 			MAX98927_PCM_RX_CH0_EN | MAX98927_PCM_RX_CH1_EN,
@@ -217,13 +223,12 @@ static int max98927_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 			MAX98927_R003B_SPK_SRC_SEL,
 			MAX98927_SPK_SRC_MASK, 0);
 
-	} else
 		regmap_update_bits(max98927->regmap,
-			MAX98927_R0018_PCM_RX_EN_A,
-			MAX98927_PCM_RX_CH0_EN | MAX98927_PCM_RX_CH1_EN, 0);
+			MAX98927_R0035_PDM_RX_CTRL,
+			MAX98927_PDM_RX_EN_MASK, 0);
 
-	/* pdm channel configuration */
-	if (max98927->iface & SND_SOC_DAIFMT_PDM) {
+	} else {
+		/* pdm channel configuration */
 		regmap_update_bits(max98927->regmap,
 			MAX98927_R0035_PDM_RX_CTRL,
 			MAX98927_PDM_RX_EN_MASK, 1);
@@ -231,10 +236,12 @@ static int max98927_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		regmap_update_bits(max98927->regmap,
 			MAX98927_R003B_SPK_SRC_SEL,
 			MAX98927_SPK_SRC_MASK, 3);
-	} else
+
 		regmap_update_bits(max98927->regmap,
-			MAX98927_R0035_PDM_RX_CTRL,
-			MAX98927_PDM_RX_EN_MASK, 0);
+			MAX98927_R0018_PCM_RX_EN_A,
+			MAX98927_PCM_RX_CH0_EN | MAX98927_PCM_RX_CH1_EN, 0);
+
+	}
 	return 0;
 }
 
@@ -245,6 +252,21 @@ static const int rate_table[] = {
 	13000000, 19200000,
 };
 
+/* BCLKs per LRCLK */
+static const int bclk_sel_table[] = {
+	32, 48, 64, 96, 128, 192, 256, 384, 512,
+};
+
+static int max98927_get_bclk_sel(int bclk)
+{
+	int i;
+	/* match BCLKs per LRCLK */
+	for (i = 0; i < ARRAY_SIZE(bclk_sel_table); i++) {
+		if (bclk_sel_table[i] == bclk)
+			return i + 2;
+	}
+	return 0;
+}
 static int max98927_set_clock(struct max98927_priv *max98927,
 	struct snd_pcm_hw_params *params)
 {
@@ -270,19 +292,17 @@ static int max98927_set_clock(struct max98927_priv *max98927,
 			i << MAX98927_PCM_MASTER_MODE_MCLK_RATE_SHIFT);
 	}
 
-	switch (blr_clk_ratio) {
-	case 32:
-		value = 2;
-		break;
-	case 48:
-		value = 3;
-		break;
-	case 64:
-		value = 4;
-		break;
-	default:
+	if ((max98927->iface == SND_SOC_DAIFMT_DSP_A) ||
+	    (max98927->iface == SND_SOC_DAIFMT_DSP_B))
+		return 0;
+
+	/* BCLK configuration */
+	value = max98927_get_bclk_sel(blr_clk_ratio);
+	if (!value) {
+		dev_err(codec->dev, "BCLK %d not supported\n", blr_clk_ratio);
 		return -EINVAL;
 	}
+
 	regmap_update_bits(max98927->regmap,
 		MAX98927_R0022_PCM_CLK_SETUP,
 		MAX98927_PCM_CLK_SETUP_BSEL_MASK,
@@ -311,7 +331,7 @@ static int max98927_dai_hw_params(struct snd_pcm_substream *substream,
 		chan_sz = MAX98927_PCM_MODE_CFG_CHANSZ_32;
 		break;
 	default:
-		dev_err(codec->dev, "format unsupported %d",
+		dev_err(codec->dev, "format unsupported %d\n",
 			params_format(params));
 		goto err;
 	}
@@ -386,6 +406,76 @@ static int max98927_dai_hw_params(struct snd_pcm_substream *substream,
 	return -EINVAL;
 }
 
+static int max98927_dai_tdm_slot(struct snd_soc_dai *dai,
+	unsigned int tx_mask, unsigned int rx_mask,
+	int slots, int slot_width)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
+	int bsel = 0;
+	unsigned int chan_sz = 0;
+
+	/* BCLK configuration */
+	bsel = max98927_get_bclk_sel(slots * slot_width);
+	if (bsel == 0) {
+		dev_err(codec->dev, "BCLK %d not supported\n",
+			slots * slot_width);
+		return -EINVAL;
+	}
+
+	regmap_update_bits(max98927->regmap,
+		MAX98927_R0022_PCM_CLK_SETUP,
+		MAX98927_PCM_CLK_SETUP_BSEL_MASK,
+		bsel);
+
+	/* Channel size configuration */
+	switch (slot_width) {
+	case 16:
+		chan_sz = MAX98927_PCM_MODE_CFG_CHANSZ_16;
+		break;
+	case 24:
+		chan_sz = MAX98927_PCM_MODE_CFG_CHANSZ_24;
+		break;
+	case 32:
+		chan_sz = MAX98927_PCM_MODE_CFG_CHANSZ_32;
+		break;
+	default:
+		dev_err(codec->dev, "format unsupported %d\n",
+			slot_width);
+		return -EINVAL;
+	}
+
+	regmap_update_bits(max98927->regmap,
+		MAX98927_R0020_PCM_MODE_CFG,
+		MAX98927_PCM_MODE_CFG_CHANSZ_MASK, chan_sz);
+
+	/* Rx slot configuration */
+	regmap_write(max98927->regmap,
+		MAX98927_R0018_PCM_RX_EN_A,
+		rx_mask & 0xFF);
+	regmap_write(max98927->regmap,
+		MAX98927_R0019_PCM_RX_EN_B,
+		(rx_mask & 0xFF00) >> 8);
+
+	/* Tx slot configuration */
+	regmap_write(max98927->regmap,
+		MAX98927_R001A_PCM_TX_EN_A,
+		tx_mask & 0xFF);
+	regmap_write(max98927->regmap,
+		MAX98927_R001B_PCM_TX_EN_B,
+		(tx_mask & 0xFF00) >> 8);
+
+	/* Tx slot Hi-Z configuration */
+	regmap_write(max98927->regmap,
+		MAX98927_R001C_PCM_TX_HIZ_CTRL_A,
+		~tx_mask & 0xFF);
+	regmap_write(max98927->regmap,
+		MAX98927_R001D_PCM_TX_HIZ_CTRL_B,
+		(~tx_mask & 0xFF00) >> 8);
+
+	return 0;
+}
+
 #define MAX98927_RATES SNDRV_PCM_RATE_8000_48000
 
 #define MAX98927_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
@@ -405,6 +495,7 @@ static const struct snd_soc_dai_ops max98927_dai_ops = {
 	.set_sysclk = max98927_dai_set_sysclk,
 	.set_fmt = max98927_dai_set_fmt,
 	.hw_params = max98927_dai_hw_params,
+	.set_tdm_slot = max98927_dai_tdm_slot,
 };
 
 static int max98927_dac_event(struct snd_soc_dapm_widget *w,
@@ -495,6 +586,12 @@ static bool max98927_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case MAX98927_R0001_INT_RAW1 ... MAX98927_R0009_INT_FLAG3:
+	case MAX98927_R004C_MEAS_ADC_CH0_READ:
+	case MAX98927_R004D_MEAS_ADC_CH1_READ:
+	case MAX98927_R004E_MEAS_ADC_CH2_READ:
+	case MAX98927_R0051_BROWNOUT_STATUS:
+	case MAX98927_R0087_ENV_TRACK_BOOST_VOUT_READ:
+	case MAX98927_R01FF_REV_ID:
 		return true;
 	default:
 		return false;
@@ -523,6 +620,18 @@ static SOC_ENUM_SINGLE_DECL(max98927_current_limit,
 		MAX98927_R0042_BOOST_CTRL1, 1,
 		max98927_current_limit_text);
 
+static const char * const max98927_env_track_headroom_text[] = {
+	"0.000V", "0.125V", "0.250V", "0.375V", "0.500V", "0.625V",
+	"0.750V", "0.875V", "1.000V", "1.125V", "1.250V", "1.375V",
+	"1.500V", "1.625V", "1.750V", "1.875V", "2.000V", "2.125V",
+	"2.250V", "2.375V", "2.500V", "2.625V", "2.750V", "2.875V",
+	"3.000V", "3.125V", "3.250V", "3.375V", "3.500V"
+};
+
+static SOC_ENUM_SINGLE_DECL(max98927_env_track_headroom,
+		MAX98927_R0082_ENV_TRACK_VOUT_HEADROOM, 0,
+		max98927_env_track_headroom_text);
+
 static const struct snd_kcontrol_new max98927_snd_controls[] = {
 	SOC_SINGLE_TLV("Speaker Volume", MAX98927_R003C_SPK_GAIN,
 		0, 6, 0,
@@ -540,6 +649,9 @@ static const struct snd_kcontrol_new max98927_snd_controls[] = {
 		MAX98927_AMP_VOL_SEL_SHIFT, 1, 0),
 	SOC_ENUM("Boost Output Voltage", max98927_boost_voltage),
 	SOC_ENUM("Current Limit", max98927_current_limit),
+	SOC_SINGLE("EnvTrack Switch", MAX98927_R0086_ENV_TRACK_CTRL,
+		MAX98927_ENV_TRACKER_EN_SHIFT, 1, 0),
+	SOC_ENUM("EnvTrack Headroom", max98927_env_track_headroom),
 };
 
 static const struct snd_soc_dapm_route max98927_audio_map[] = {
@@ -635,13 +747,10 @@ static int max98927_probe(struct snd_soc_codec *codec)
 	/* Envelope Tracking configuration */
 	regmap_write(max98927->regmap,
 		MAX98927_R0082_ENV_TRACK_VOUT_HEADROOM,
-		0x08);
+		0x0A);
 	regmap_write(max98927->regmap,
 		MAX98927_R0086_ENV_TRACK_CTRL,
 		0x01);
-	regmap_write(max98927->regmap,
-		MAX98927_R0087_ENV_TRACK_BOOST_VOUT_READ,
-		0x10);
 
 	/* voltage, current slot configuration */
 	regmap_write(max98927->regmap,
diff --git a/sound/soc/codecs/max98927.h b/sound/soc/codecs/max98927.h
index ece6a60..43d3c74 100644
--- a/sound/soc/codecs/max98927.h
+++ b/sound/soc/codecs/max98927.h
@@ -1,7 +1,7 @@
 /*
  * max98927.h  --  MAX98927 ALSA Soc Audio driver
  *
- * Copyright 2013-15 Maxim Integrated Products
+ * Copyright (C) 2016-2017 Maxim Integrated Products
  * Author: Ryan Lee <ryans.lee@maximintegrated.com>
  *
  *  This program is free software; you can redistribute  it and/or modify it
@@ -161,7 +161,9 @@
 #define MAX98927_PCM_MODE_CFG_FORMAT_SHIFT (3)
 #define MAX98927_PCM_FORMAT_I2S (0x0 << 0)
 #define MAX98927_PCM_FORMAT_LJ (0x1 << 0)
-
+#define MAX98927_PCM_FORMAT_TDM_MODE0 (0x3 << 0)
+#define MAX98927_PCM_FORMAT_TDM_MODE1 (0x4 << 0)
+#define MAX98927_PCM_FORMAT_TDM_MODE2 (0x5 << 0)
 #define MAX98927_PCM_MODE_CFG_CHANSZ_MASK (0x3 << 6)
 #define MAX98927_PCM_MODE_CFG_CHANSZ_16 (0x1 << 6)
 #define MAX98927_PCM_MODE_CFG_CHANSZ_24 (0x2 << 6)
@@ -194,7 +196,7 @@
 /* MAX98927_R0024_PCM_SR_SETUP2 */
 #define MAX98927_PCM_SR_SET2_SR_MASK (0xF << 4)
 #define MAX98927_PCM_SR_SET2_SR_SHIFT (4)
-#define MAX98927_PCM_SR_SET2_IVADC_SR_MASK (0xf << 0)
+#define MAX98927_PCM_SR_SET2_IVADC_SR_MASK (0xF << 0)
 
 /* MAX98927_R0025_PCM_TO_SPK_MONOMIX_A */
 #define MAX98927_PCM_TO_SPK_MONOMIX_CFG_MASK (0x3 << 6)
@@ -207,7 +209,7 @@
 #define MAX98927_AMP_VOL_SEL (0x1 << 7)
 #define MAX98927_AMP_VOL_SEL_WIDTH (1)
 #define MAX98927_AMP_VOL_SEL_SHIFT (7)
-#define MAX98927_AMP_VOL_MASK (0x7f << 0)
+#define MAX98927_AMP_VOL_MASK (0x7F << 0)
 #define MAX98927_AMP_VOL_WIDTH (7)
 #define MAX98927_AMP_VOL_SHIFT (0)
 
@@ -238,7 +240,7 @@
 #define MAX98927_MEAS_I_EN (0x1 << 1)
 
 /* MAX98927_R0040_BOOST_CTRL0 */
-#define MAX98927_BOOST_CTRL0_VOUT_MASK (0x1f << 0)
+#define MAX98927_BOOST_CTRL0_VOUT_MASK (0x1F << 0)
 #define MAX98927_BOOST_CTRL0_PVDD_MASK (0x1 << 7)
 #define MAX98927_BOOST_CTRL0_PVDD_EN_SHIFT (7)
 
@@ -248,6 +250,10 @@
 #define MAX98927_BROWNOUT_DSP_EN (0x1 << 2)
 #define MAX98927_BROWNOUT_DSP_SHIFT (2)
 
+/* MAX98927_R0086_ENV_TRACK_CTRL */
+#define MAX98927_ENV_TRACKER_EN (0x1 << 0)
+#define MAX98927_ENV_TRACKER_EN_SHIFT (0)
+
 /* MAX98927_R0100_SOFT_RESET */
 #define MAX98927_SOFT_RESET (0x1 << 0)
 
@@ -257,7 +263,6 @@
 struct max98927_priv {
 	struct regmap *regmap;
 	struct snd_soc_codec *codec;
-	struct max98927_pdata *pdata;
 	unsigned int spk_gain;
 	unsigned int sysclk;
 	unsigned int v_l_slot;
-- 
2.7.4
