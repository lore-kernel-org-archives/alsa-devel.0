From: John Keeping <john@metanate.com>
Subject: [PATCH 7/9] ASoC: es8328: Support more sample formats
Date: Mon,  9 May 2016 12:24:35 +0100
Message-ID: <20160509112437.8924-8-john@metanate.com>
References: <20160509112437.8924-1-john@metanate.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160509112437.8924-1-john@metanate.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, John Keeping <john@metanate.com>
List-Id: alsa-devel@alsa-project.org

The values are the same for the DAC and ADC so remove the specific
values and use values with shifts.

Signed-off-by: John Keeping <john@metanate.com>
---
 sound/soc/codecs/es8328.c | 35 +++++++++++++++++++++++++++++------
 sound/soc/codecs/es8328.h | 12 ++----------
 2 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index 31c90ef9abf2..636177641173 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -60,7 +60,11 @@ static const char * const supply_names[ES8328_SUPPLY_NUM] = {
 #define ES8328_RATES (SNDRV_PCM_RATE_44100 | \
 		SNDRV_PCM_RATE_22050 | \
 		SNDRV_PCM_RATE_11025)
-#define ES8328_FORMATS (SNDRV_PCM_FMTBIT_S16_LE)
+#define ES8328_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
+		SNDRV_PCM_FMTBIT_S18_3LE | \
+		SNDRV_PCM_FMTBIT_S20_3LE | \
+		SNDRV_PCM_FMTBIT_S24_LE | \
+		SNDRV_PCM_FMTBIT_S32_LE)
 
 struct es8328_priv {
 	struct regmap *regmap;
@@ -449,6 +453,7 @@ static int es8328_hw_params(struct snd_pcm_substream *substream,
 	int i;
 	int reg;
 	int val;
+	int wl;
 	u8 ratio;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
@@ -470,10 +475,28 @@ static int es8328_hw_params(struct snd_pcm_substream *substream,
 			 ES8328_SYSCLK_RATE_1X, ES8328_SYSCLK_RATE_2X);
 		return -EINVAL;
 	}
-	ret = snd_soc_update_bits(codec, ES8328_MASTERMODE,
+	snd_soc_update_bits(codec, ES8328_MASTERMODE,
 			ES8328_MASTERMODE_MCLKDIV2, val);
-	if (ret < 0)
-		return ret;
+
+	switch (params_width(params)) {
+	case 16:
+		wl = 3;
+		break;
+	case 18:
+		wl = 2;
+		break;
+	case 20:
+		wl = 1;
+		break;
+	case 24:
+		wl = 0;
+		break;
+	case 32:
+		wl = 4;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	/* find master mode MCLK to sampling frequency ratio */
 	ratio = mclk_ratios[0].rate;
@@ -484,14 +507,14 @@ static int es8328_hw_params(struct snd_pcm_substream *substream,
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		snd_soc_update_bits(codec, ES8328_DACCONTROL1,
 				ES8328_DACCONTROL1_DACWL_MASK,
-				ES8328_DACCONTROL1_DACWL_16);
+				wl << ES8328_DACCONTROL1_DACWL_SHIFT);
 
 		es8328->playback_fs = params_rate(params);
 		es8328_set_deemph(codec);
 	} else
 		snd_soc_update_bits(codec, ES8328_ADCCONTROL4,
 				ES8328_ADCCONTROL4_ADCWL_MASK,
-				ES8328_ADCCONTROL4_ADCWL_16);
+				wl << ES8328_ADCCONTROL4_ADCWL_SHIFT);
 
 	return snd_soc_update_bits(codec, reg, ES8328_RATEMASK, ratio);
 }
diff --git a/sound/soc/codecs/es8328.h b/sound/soc/codecs/es8328.h
index 9c33d8bda859..1a736e72a929 100644
--- a/sound/soc/codecs/es8328.h
+++ b/sound/soc/codecs/es8328.h
@@ -91,11 +91,7 @@ int es8328_probe(struct device *dev, struct regmap *regmap);
 #define ES8328_ADCCONTROL4_ADCFORMAT_LJUST (1 << 0)
 #define ES8328_ADCCONTROL4_ADCFORMAT_RJUST (2 << 0)
 #define ES8328_ADCCONTROL4_ADCFORMAT_PCM (3 << 0)
-#define ES8328_ADCCONTROL4_ADCWL_24 (0 << 2)
-#define ES8328_ADCCONTROL4_ADCWL_20 (1 << 2)
-#define ES8328_ADCCONTROL4_ADCWL_18 (2 << 2)
-#define ES8328_ADCCONTROL4_ADCWL_16 (3 << 2)
-#define ES8328_ADCCONTROL4_ADCWL_32 (4 << 2)
+#define ES8328_ADCCONTROL4_ADCWL_SHIFT 2
 #define ES8328_ADCCONTROL4_ADCWL_MASK (7 << 2)
 #define ES8328_ADCCONTROL4_ADCLRP_I2S_POL_NORMAL (0 << 5)
 #define ES8328_ADCCONTROL4_ADCLRP_I2S_POL_INV (1 << 5)
@@ -131,11 +127,7 @@ int es8328_probe(struct device *dev, struct regmap *regmap);
 #define ES8328_DACCONTROL1_DACFORMAT_LJUST (1 << 1)
 #define ES8328_DACCONTROL1_DACFORMAT_RJUST (2 << 1)
 #define ES8328_DACCONTROL1_DACFORMAT_PCM (3 << 1)
-#define ES8328_DACCONTROL1_DACWL_24 (0 << 3)
-#define ES8328_DACCONTROL1_DACWL_20 (1 << 3)
-#define ES8328_DACCONTROL1_DACWL_18 (2 << 3)
-#define ES8328_DACCONTROL1_DACWL_16 (3 << 3)
-#define ES8328_DACCONTROL1_DACWL_32 (4 << 3)
+#define ES8328_DACCONTROL1_DACWL_SHIFT 3
 #define ES8328_DACCONTROL1_DACWL_MASK (7 << 3)
 #define ES8328_DACCONTROL1_DACLRP_I2S_POL_NORMAL (0 << 6)
 #define ES8328_DACCONTROL1_DACLRP_I2S_POL_INV (1 << 6)
-- 
2.8.0.rc4.238.g874082a
