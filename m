From: John Keeping <john@metanate.com>
Subject: [PATCH 6/9] ASoC: es8328: Move sample size setup to
	hw_params
Date: Mon,  9 May 2016 12:24:34 +0100
Message-ID: <20160509112437.8924-7-john@metanate.com>
References: <20160509112437.8924-1-john@metanate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metanate.com (dougal.metanate.com [90.155.101.14])
 by alsa0.perex.cz (Postfix) with ESMTP id B94622655A6
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2016 13:24:48 +0200 (CEST)
In-Reply-To: <20160509112437.8924-1-john@metanate.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, John Keeping <john@metanate.com>
List-Id: alsa-devel@alsa-project.org

This is a refactor in preparation for supporting more sample sizes which
has no functional change.

Signed-off-by: John Keeping <john@metanate.com>
---
 sound/soc/codecs/es8328.c | 19 ++++++++++++++-----
 sound/soc/codecs/es8328.h |  4 ++++
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index 8661d1837422..31c90ef9abf2 100644
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
2.8.0.rc4.238.g874082a
