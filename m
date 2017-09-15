From: Ryan Lee <ryans.lee@maximintegrated.com>
Subject: [PATCH 2/2] ASoC: max98927: Added max98927_dai_tdm_slot function
Date: Thu, 14 Sep 2017 17:30:37 -0700
Message-ID: <1505435439-18012-2-git-send-email-ryans.lee@maximintegrated.com>
References: <1505435439-18012-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1505435439-18012-1-git-send-email-ryans.lee@maximintegrated.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, ryans.lee@maximintegrated.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: ryan.lee.maxim@gmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
Changelog:
Added 'max98927_dai_tdm_slot' function to set proper slot configuration.
Added variable 'tdm_mode' to avoid BCLK overwrite after 'max98927_dai_tdm_slot' configure BCLK value.
 :BCLK value is being set inside 'max98927_dai_tdm_slot' function when it is tdm mode because number of slots and slot width information is available here.
 :'max98927_set_clock' is called from hw_params and slot information is not available in this function so it can overwrite BCLK value.
 :Variable 'tdm_mode' will be cleared after SND_SOC_DAPM_POST_PMD event is recieved.
Added 'max98927_get_bclk_sel' to avoid code duplication and support BCLK up to 512.	

 sound/soc/codecs/max98927.c | 118 ++++++++++++++++++++++++++++++++++++++------
 sound/soc/codecs/max98927.h |   1 +
 2 files changed, 103 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index 6f7b3ef..116cb9b 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -250,6 +250,21 @@ static const int rate_table[] = {
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
@@ -275,23 +290,20 @@ static int max98927_set_clock(struct max98927_priv *max98927,
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
-		return -EINVAL;
+	if (!max98927->tdm_mode) {
+		/* BCLK configuration */
+		value = max98927_get_bclk_sel(blr_clk_ratio);
+		if (!value) {
+			dev_err(codec->dev, "format unsupported %d\n",
+				params_format(params));
+			return -EINVAL;
+		}
+
+		regmap_update_bits(max98927->regmap,
+			MAX98927_R0022_PCM_CLK_SETUP,
+			MAX98927_PCM_CLK_SETUP_BSEL_MASK,
+			value);
 	}
-	regmap_update_bits(max98927->regmap,
-		MAX98927_R0022_PCM_CLK_SETUP,
-		MAX98927_PCM_CLK_SETUP_BSEL_MASK,
-		value);
 	return 0;
 }
 
@@ -391,6 +403,78 @@ static int max98927_dai_hw_params(struct snd_pcm_substream *substream,
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
+	max98927->tdm_mode = true;
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
@@ -410,6 +494,7 @@ static const struct snd_soc_dai_ops max98927_dai_ops = {
 	.set_sysclk = max98927_dai_set_sysclk,
 	.set_fmt = max98927_dai_set_fmt,
 	.hw_params = max98927_dai_hw_params,
+	.set_tdm_slot = max98927_dai_tdm_slot,
 };
 
 static int max98927_dac_event(struct snd_soc_dapm_widget *w,
@@ -434,6 +519,7 @@ static int max98927_dac_event(struct snd_soc_dapm_widget *w,
 		regmap_update_bits(max98927->regmap,
 			MAX98927_R003A_AMP_EN,
 			MAX98927_AMP_EN_MASK, 0);
+		max98927->tdm_mode = 0;
 		break;
 	default:
 		return 0;
diff --git a/sound/soc/codecs/max98927.h b/sound/soc/codecs/max98927.h
index bf7a6f92..9ea8397 100644
--- a/sound/soc/codecs/max98927.h
+++ b/sound/soc/codecs/max98927.h
@@ -270,5 +270,6 @@ struct max98927_priv {
 	unsigned int iface;
 	unsigned int master;
 	unsigned int digital_gain;
+	bool tdm_mode;
 };
 #endif
-- 
2.7.4
