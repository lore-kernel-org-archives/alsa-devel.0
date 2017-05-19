From: Ryan Lee <ryans.lee@maximintegrated.com>
Subject: [PATCH 1/5] staging: max98927: Added TDM support
Date: Thu, 18 May 2017 20:00:40 -0700
Message-ID: <1495162840-21470-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0129.outbound.protection.outlook.com [104.47.34.129])
 by alsa0.perex.cz (Postfix) with ESMTP id C094A266A0D
 for <alsa-devel@alsa-project.org>; Fri, 19 May 2017 05:01:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, ryans.lee@maximintegrated.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: ryan.lee.maxim@gmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
 sound/soc/codecs/max98927.c | 141 ++++++++++++++++++++++++++++++++++++--------
 sound/soc/codecs/max98927.h |   6 +-
 2 files changed, 120 insertions(+), 27 deletions(-)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index b5ee294..99d6e41 100644
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
diff --git a/sound/soc/codecs/max98927.h b/sound/soc/codecs/max98927.h
index ece6a60..bf7a6f92 100644
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
-- 
2.7.4
