From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: es8328: Move sample size setup to hw_params" to the asoc tree
Date: Tue, 10 May 2016 19:49:28 +0100
Message-ID: <E1b0Cim-0007cT-VJ@debutante>
References: <20160509112437.8924-7-john@metanate.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160509112437.8924-7-john@metanate.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Keeping <john@metanate.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: es8328: Move sample size setup to hw_params

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 8865c95e43257e6676bc0f6b042ecce17eff74fe Mon Sep 17 00:00:00 2001
From: John Keeping <john@metanate.com>
Date: Mon, 9 May 2016 12:24:34 +0100
Subject: [PATCH] ASoC: es8328: Move sample size setup to hw_params

This is a refactor in preparation for supporting more sample sizes which
has no functional change.

Signed-off-by: John Keeping <john@metanate.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/es8328.c | 19 ++++++++++++++-----
 sound/soc/codecs/es8328.h |  4 ++++
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index d580300d9220..c5a36e65fc40 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -482,9 +482,16 @@ static int es8328_hw_params(struct snd_pcm_substream *substream,
 			ratio = mclk_ratios[i].ratio;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		snd_soc_update_bits(codec, ES8328_DACCONTROL1,
+				ES8328_DACCONTROL1_DACWL_MASK,
+				ES8328_DACCONTROL1_DACWL_16);
+
 		es8328->playback_fs = params_rate(params);
 		es8328_set_deemph(codec);
-	}
+	} else
+		snd_soc_update_bits(codec, ES8328_ADCCONTROL4,
+				ES8328_ADCCONTROL4_ADCWL_MASK,
+				ES8328_ADCCONTROL4_ADCWL_16);
 
 	return snd_soc_update_bits(codec, reg, ES8328_RATEMASK, ratio);
 }
@@ -493,8 +500,8 @@ static int es8328_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	u8 dac_mode = ES8328_DACCONTROL1_DACWL_16;
-	u8 adc_mode = ES8328_ADCCONTROL4_ADCWL_16;
+	u8 dac_mode = 0;
+	u8 adc_mode = 0;
 
 	/* set master/slave audio interface */
 	if ((fmt & SND_SOC_DAIFMT_MASTER_MASK) != SND_SOC_DAIFMT_CBM_CFM)
@@ -522,8 +529,10 @@ static int es8328_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	if ((fmt & SND_SOC_DAIFMT_INV_MASK) != SND_SOC_DAIFMT_NB_NF)
 		return -EINVAL;
 
-	snd_soc_write(codec, ES8328_DACCONTROL1, dac_mode);
-	snd_soc_write(codec, ES8328_ADCCONTROL4, adc_mode);
+	snd_soc_update_bits(codec, ES8328_DACCONTROL1,
+			ES8328_DACCONTROL1_DACFORMAT_MASK, dac_mode);
+	snd_soc_update_bits(codec, ES8328_ADCCONTROL4,
+			ES8328_ADCCONTROL4_ADCFORMAT_MASK, adc_mode);
 
 	/* Master serial port mode, with BCLK generated automatically */
 	snd_soc_update_bits(codec, ES8328_MASTERMODE,
diff --git a/sound/soc/codecs/es8328.h b/sound/soc/codecs/es8328.h
index 8bc79fff0218..9c33d8bda859 100644
--- a/sound/soc/codecs/es8328.h
+++ b/sound/soc/codecs/es8328.h
@@ -86,6 +86,7 @@ int es8328_probe(struct device *dev, struct regmap *regmap);
 #define ES8328_ADCCONTROL3	0x0b
 
 #define ES8328_ADCCONTROL4	0x0c
+#define ES8328_ADCCONTROL4_ADCFORMAT_MASK (3 << 0)
 #define ES8328_ADCCONTROL4_ADCFORMAT_I2S (0 << 0)
 #define ES8328_ADCCONTROL4_ADCFORMAT_LJUST (1 << 0)
 #define ES8328_ADCCONTROL4_ADCFORMAT_RJUST (2 << 0)
@@ -95,6 +96,7 @@ int es8328_probe(struct device *dev, struct regmap *regmap);
 #define ES8328_ADCCONTROL4_ADCWL_18 (2 << 2)
 #define ES8328_ADCCONTROL4_ADCWL_16 (3 << 2)
 #define ES8328_ADCCONTROL4_ADCWL_32 (4 << 2)
+#define ES8328_ADCCONTROL4_ADCWL_MASK (7 << 2)
 #define ES8328_ADCCONTROL4_ADCLRP_I2S_POL_NORMAL (0 << 5)
 #define ES8328_ADCCONTROL4_ADCLRP_I2S_POL_INV (1 << 5)
 #define ES8328_ADCCONTROL4_ADCLRP_PCM_MSB_CLK2 (0 << 5)
@@ -124,6 +126,7 @@ int es8328_probe(struct device *dev, struct regmap *regmap);
 #define ES8328_ADCCONTROL14	0x16
 
 #define ES8328_DACCONTROL1	0x17
+#define ES8328_DACCONTROL1_DACFORMAT_MASK (3 << 1)
 #define ES8328_DACCONTROL1_DACFORMAT_I2S (0 << 1)
 #define ES8328_DACCONTROL1_DACFORMAT_LJUST (1 << 1)
 #define ES8328_DACCONTROL1_DACFORMAT_RJUST (2 << 1)
@@ -133,6 +136,7 @@ int es8328_probe(struct device *dev, struct regmap *regmap);
 #define ES8328_DACCONTROL1_DACWL_18 (2 << 3)
 #define ES8328_DACCONTROL1_DACWL_16 (3 << 3)
 #define ES8328_DACCONTROL1_DACWL_32 (4 << 3)
+#define ES8328_DACCONTROL1_DACWL_MASK (7 << 3)
 #define ES8328_DACCONTROL1_DACLRP_I2S_POL_NORMAL (0 << 6)
 #define ES8328_DACCONTROL1_DACLRP_I2S_POL_INV (1 << 6)
 #define ES8328_DACCONTROL1_DACLRP_PCM_MSB_CLK2 (0 << 6)
-- 
2.8.1
