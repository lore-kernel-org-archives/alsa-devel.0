From: John Keeping <john@metanate.com>
Subject: [PATCH 2/9] ASoC: es8328: Fix ADC format setup
Date: Mon,  9 May 2016 12:24:30 +0100
Message-ID: <20160509112437.8924-3-john@metanate.com>
References: <20160509112437.8924-1-john@metanate.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160509112437.8924-1-john@metanate.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, John Keeping <john@metanate.com>
List-Id: alsa-devel@alsa-project.org

The ADCCONTROL4 and DACCONTROL1 registers are similar but not identical,
with the DACCONTROL1 having each field starting one bit higher than
ADCCONTROL4.

Instead of introducing a magic shift, add new constants for the values
in ADCCONTROL4 and use a second variable to setup the ADC.

Signed-off-by: John Keeping <john@metanate.com>
---
 sound/soc/codecs/es8328.c | 16 ++++++++++------
 sound/soc/codecs/es8328.h | 15 +++++++++++++++
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index 3ca89ae32889..63e82628222c 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -493,7 +493,8 @@ static int es8328_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	u8 mode = ES8328_DACCONTROL1_DACWL_16;
+	u8 dac_mode = ES8328_DACCONTROL1_DACWL_16;
+	u8 adc_mode = ES8328_ADCCONTROL4_ADCWL_16;
 
 	/* set master/slave audio interface */
 	if ((fmt & SND_SOC_DAIFMT_MASTER_MASK) != SND_SOC_DAIFMT_CBM_CFM)
@@ -502,13 +503,16 @@ static int es8328_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	/* interface format */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
-		mode |= ES8328_DACCONTROL1_DACFORMAT_I2S;
+		dac_mode |= ES8328_DACCONTROL1_DACFORMAT_I2S;
+		adc_mode |= ES8328_ADCCONTROL4_ADCFORMAT_I2S;
 		break;
 	case SND_SOC_DAIFMT_RIGHT_J:
-		mode |= ES8328_DACCONTROL1_DACFORMAT_RJUST;
+		dac_mode |= ES8328_DACCONTROL1_DACFORMAT_RJUST;
+		adc_mode |= ES8328_ADCCONTROL4_ADCFORMAT_RJUST;
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
-		mode |= ES8328_DACCONTROL1_DACFORMAT_LJUST;
+		dac_mode |= ES8328_DACCONTROL1_DACFORMAT_LJUST;
+		adc_mode |= ES8328_ADCCONTROL4_ADCFORMAT_LJUST;
 		break;
 	default:
 		return -EINVAL;
@@ -518,8 +522,8 @@ static int es8328_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	if ((fmt & SND_SOC_DAIFMT_INV_MASK) != SND_SOC_DAIFMT_NB_NF)
 		return -EINVAL;
 
-	snd_soc_write(codec, ES8328_DACCONTROL1, mode);
-	snd_soc_write(codec, ES8328_ADCCONTROL4, mode);
+	snd_soc_write(codec, ES8328_DACCONTROL1, dac_mode);
+	snd_soc_write(codec, ES8328_ADCCONTROL4, adc_mode);
 
 	/* Master serial port mode, with BCLK generated automatically */
 	snd_soc_update_bits(codec, ES8328_MASTERMODE,
diff --git a/sound/soc/codecs/es8328.h b/sound/soc/codecs/es8328.h
index 156c748c89c7..5a4af014e516 100644
--- a/sound/soc/codecs/es8328.h
+++ b/sound/soc/codecs/es8328.h
@@ -84,7 +84,22 @@ int es8328_probe(struct device *dev, struct regmap *regmap);
 #define ES8328_ADCCONTROL1	0x09
 #define ES8328_ADCCONTROL2	0x0a
 #define ES8328_ADCCONTROL3	0x0b
+
 #define ES8328_ADCCONTROL4	0x0c
+#define ES8328_ADCCONTROL4_ADCFORMAT_I2S (0 << 0)
+#define ES8328_ADCCONTROL4_ADCFORMAT_LJUST (1 << 0)
+#define ES8328_ADCCONTROL4_ADCFORMAT_RJUST (2 << 0)
+#define ES8328_ADCCONTROL4_ADCFORMAT_PCM (3 << 0)
+#define ES8328_ADCCONTROL4_ADCWL_24 (0 << 2)
+#define ES8328_ADCCONTROL4_ADCWL_20 (1 << 2)
+#define ES8328_ADCCONTROL4_ADCWL_18 (2 << 2)
+#define ES8328_ADCCONTROL4_ADCWL_16 (3 << 2)
+#define ES8328_ADCCONTROL4_ADCWL_32 (4 << 2)
+#define ES8328_ADCCONTROL4_ADCLRP_I2S_POL_NORMAL (0 << 5)
+#define ES8328_ADCCONTROL4_ADCLRP_I2S_POL_INV (1 << 5)
+#define ES8328_ADCCONTROL4_ADCLRP_PCM_MSB_CLK2 (0 << 5)
+#define ES8328_ADCCONTROL4_ADCLRP_PCM_MSB_CLK1 (1 << 5)
+
 #define ES8328_ADCCONTROL5	0x0d
 #define ES8328_ADCCONTROL5_RATEMASK (0x1f << 0)
 
-- 
2.8.0.rc4.238.g874082a
