From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/2] ASoC: 88pm860x: Use regmap for I/O
Date: Thu, 19 Sep 2013 19:02:20 +0100
Message-ID: <1379613740-5800-2-git-send-email-broonie@kernel.org>
References: <1379613740-5800-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 377F726548D
 for <alsa-devel@alsa-project.org>; Thu, 19 Sep 2013 20:02:33 +0200 (CEST)
In-Reply-To: <1379613740-5800-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Haojian Zhuang <haojian.zhuang@marvell.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

As part of a move to remove the duplication of regmap functionality in ASoC
convert the 88pm860x driver to use the regmap from the MFD. This means that
we no longer cache the registers so performance will be slightly reduced
on I/O operations.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/88pm860x-codec.c |  60 ++-----------------
 sound/soc/codecs/88pm860x-codec.h | 117 +++++++++++++++++++-------------------
 2 files changed, 63 insertions(+), 114 deletions(-)

diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index ca5f9f0..75d0ad5 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -16,6 +16,7 @@
 #include <linux/mfd/88pm860x.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/regmap.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -140,6 +141,7 @@ struct pm860x_priv {
 	unsigned int		filter;
 	struct snd_soc_codec	*codec;
 	struct i2c_client	*i2c;
+	struct regmap		*regmap;
 	struct pm860x_chip	*chip;
 	struct pm860x_det	det;
 
@@ -269,48 +271,6 @@ static struct st_gain st_table[] = {
 	{   -86, 29,  0}, {   -56, 30,  0}, {   -28, 31,  0}, {     0,  0,  0},
 };
 
-static int pm860x_volatile(unsigned int reg)
-{
-	BUG_ON(reg >= REG_CACHE_SIZE);
-
-	switch (reg) {
-	case PM860X_AUDIO_SUPPLIES_2:
-		return 1;
-	}
-
-	return 0;
-}
-
-static unsigned int pm860x_read_reg_cache(struct snd_soc_codec *codec,
-					  unsigned int reg)
-{
-	unsigned char *cache = codec->reg_cache;
-
-	BUG_ON(reg >= REG_CACHE_SIZE);
-
-	if (pm860x_volatile(reg))
-		return cache[reg];
-
-	reg += REG_CACHE_BASE;
-
-	return pm860x_reg_read(codec->control_data, reg);
-}
-
-static int pm860x_write_reg_cache(struct snd_soc_codec *codec,
-				  unsigned int reg, unsigned int value)
-{
-	unsigned char *cache = codec->reg_cache;
-
-	BUG_ON(reg >= REG_CACHE_SIZE);
-
-	if (!pm860x_volatile(reg))
-		cache[reg] = (unsigned char)value;
-
-	reg += REG_CACHE_BASE;
-
-	return pm860x_reg_write(codec->control_data, reg, value);
-}
-
 static int snd_soc_get_volsw_2r_st(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_value *ucontrol)
 {
@@ -1367,7 +1327,7 @@ static int pm860x_probe(struct snd_soc_codec *codec)
 
 	pm860x->codec = codec;
 
-	codec->control_data = pm860x->i2c;
+	codec->control_data = pm860x->regmap;
 
 	for (i = 0; i < 4; i++) {
 		ret = request_threaded_irq(pm860x->irq[i], NULL,
@@ -1381,14 +1341,6 @@ static int pm860x_probe(struct snd_soc_codec *codec)
 
 	pm860x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-	ret = pm860x_bulk_read(pm860x->i2c, REG_CACHE_BASE,
-			       REG_CACHE_SIZE, codec->reg_cache);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to fill register cache: %d\n",
-			ret);
-		goto out;
-	}
-
 	return 0;
 
 out:
@@ -1411,10 +1363,6 @@ static int pm860x_remove(struct snd_soc_codec *codec)
 static struct snd_soc_codec_driver soc_codec_dev_pm860x = {
 	.probe		= pm860x_probe,
 	.remove		= pm860x_remove,
-	.read		= pm860x_read_reg_cache,
-	.write		= pm860x_write_reg_cache,
-	.reg_cache_size	= REG_CACHE_SIZE,
-	.reg_word_size	= sizeof(u8),
 	.set_bias_level	= pm860x_set_bias_level,
 
 	.controls = pm860x_snd_controls,
@@ -1440,6 +1388,8 @@ static int pm860x_codec_probe(struct platform_device *pdev)
 	pm860x->chip = chip;
 	pm860x->i2c = (chip->id == CHIP_PM8607) ? chip->client
 			: chip->companion;
+	pm860x->regmap = (chip->id == CHIP_PM8607) ? chip->regmap
+			: chip->regmap_companion;
 	platform_set_drvdata(pdev, pm860x);
 
 	for (i = 0; i < 4; i++) {
diff --git a/sound/soc/codecs/88pm860x-codec.h b/sound/soc/codecs/88pm860x-codec.h
index 3364ba4..f7282f4 100644
--- a/sound/soc/codecs/88pm860x-codec.h
+++ b/sound/soc/codecs/88pm860x-codec.h
@@ -12,67 +12,66 @@
 #ifndef __88PM860X_H
 #define __88PM860X_H
 
-/* The offset of these registers are 0xb0 */
-#define PM860X_PCM_IFACE_1		0x00
-#define PM860X_PCM_IFACE_2		0x01
-#define PM860X_PCM_IFACE_3		0x02
-#define PM860X_PCM_RATE			0x03
-#define PM860X_EC_PATH			0x04
-#define PM860X_SIDETONE_L_GAIN		0x05
-#define PM860X_SIDETONE_R_GAIN		0x06
-#define PM860X_SIDETONE_SHIFT		0x07
-#define PM860X_ADC_OFFSET_1		0x08
-#define PM860X_ADC_OFFSET_2		0x09
-#define PM860X_DMIC_DELAY		0x0a
+#define PM860X_PCM_IFACE_1		0xb0
+#define PM860X_PCM_IFACE_2		0xb1
+#define PM860X_PCM_IFACE_3		0xb2
+#define PM860X_PCM_RATE			0xb3
+#define PM860X_EC_PATH			0xb4
+#define PM860X_SIDETONE_L_GAIN		0xb5
+#define PM860X_SIDETONE_R_GAIN		0xb6
+#define PM860X_SIDETONE_SHIFT		0xb7
+#define PM860X_ADC_OFFSET_1		0xb8
+#define PM860X_ADC_OFFSET_2		0xb9
+#define PM860X_DMIC_DELAY		0xba
 
-#define PM860X_I2S_IFACE_1		0x0b
-#define PM860X_I2S_IFACE_2		0x0c
-#define PM860X_I2S_IFACE_3		0x0d
-#define PM860X_I2S_IFACE_4		0x0e
-#define PM860X_EQUALIZER_N0_1		0x0f
-#define PM860X_EQUALIZER_N0_2		0x10
-#define PM860X_EQUALIZER_N1_1		0x11
-#define PM860X_EQUALIZER_N1_2		0x12
-#define PM860X_EQUALIZER_D1_1		0x13
-#define PM860X_EQUALIZER_D1_2		0x14
-#define PM860X_LOFI_GAIN_LEFT		0x15
-#define PM860X_LOFI_GAIN_RIGHT		0x16
-#define PM860X_HIFIL_GAIN_LEFT		0x17
-#define PM860X_HIFIL_GAIN_RIGHT		0x18
-#define PM860X_HIFIR_GAIN_LEFT		0x19
-#define PM860X_HIFIR_GAIN_RIGHT		0x1a
-#define PM860X_DAC_OFFSET		0x1b
-#define PM860X_OFFSET_LEFT_1		0x1c
-#define PM860X_OFFSET_LEFT_2		0x1d
-#define PM860X_OFFSET_RIGHT_1		0x1e
-#define PM860X_OFFSET_RIGHT_2		0x1f
-#define PM860X_ADC_ANA_1		0x20
-#define PM860X_ADC_ANA_2		0x21
-#define PM860X_ADC_ANA_3		0x22
-#define PM860X_ADC_ANA_4		0x23
-#define PM860X_ANA_TO_ANA		0x24
-#define PM860X_HS1_CTRL			0x25
-#define PM860X_HS2_CTRL			0x26
-#define PM860X_LO1_CTRL			0x27
-#define PM860X_LO2_CTRL			0x28
-#define PM860X_EAR_CTRL_1		0x29
-#define PM860X_EAR_CTRL_2		0x2a
-#define PM860X_AUDIO_SUPPLIES_1		0x2b
-#define PM860X_AUDIO_SUPPLIES_2		0x2c
-#define PM860X_ADC_EN_1			0x2d
-#define PM860X_ADC_EN_2			0x2e
-#define PM860X_DAC_EN_1			0x2f
-#define PM860X_DAC_EN_2			0x31
-#define PM860X_AUDIO_CAL_1		0x32
-#define PM860X_AUDIO_CAL_2		0x33
-#define PM860X_AUDIO_CAL_3		0x34
-#define PM860X_AUDIO_CAL_4		0x35
-#define PM860X_AUDIO_CAL_5		0x36
-#define PM860X_ANA_INPUT_SEL_1		0x37
-#define PM860X_ANA_INPUT_SEL_2		0x38
+#define PM860X_I2S_IFACE_1		0xbb
+#define PM860X_I2S_IFACE_2		0xbc
+#define PM860X_I2S_IFACE_3		0xbd
+#define PM860X_I2S_IFACE_4		0xbe
+#define PM860X_EQUALIZER_N0_1		0xbf
+#define PM860X_EQUALIZER_N0_2		0xc0
+#define PM860X_EQUALIZER_N1_1		0xc1
+#define PM860X_EQUALIZER_N1_2		0xc2
+#define PM860X_EQUALIZER_D1_1		0xc3
+#define PM860X_EQUALIZER_D1_2		0xc4
+#define PM860X_LOFI_GAIN_LEFT		0xc5
+#define PM860X_LOFI_GAIN_RIGHT		0xc6
+#define PM860X_HIFIL_GAIN_LEFT		0xc7
+#define PM860X_HIFIL_GAIN_RIGHT		0xc8
+#define PM860X_HIFIR_GAIN_LEFT		0xc9
+#define PM860X_HIFIR_GAIN_RIGHT		0xca
+#define PM860X_DAC_OFFSET		0xcb
+#define PM860X_OFFSET_LEFT_1		0xcc
+#define PM860X_OFFSET_LEFT_2		0xcd
+#define PM860X_OFFSET_RIGHT_1		0xce
+#define PM860X_OFFSET_RIGHT_2		0xcf
+#define PM860X_ADC_ANA_1		0xd0
+#define PM860X_ADC_ANA_2		0xd1
+#define PM860X_ADC_ANA_3		0xd2
+#define PM860X_ADC_ANA_4		0xd3
+#define PM860X_ANA_TO_ANA		0xd4
+#define PM860X_HS1_CTRL			0xd5
+#define PM860X_HS2_CTRL			0xd6
+#define PM860X_LO1_CTRL			0xd7
+#define PM860X_LO2_CTRL			0xd8
+#define PM860X_EAR_CTRL_1		0xd9
+#define PM860X_EAR_CTRL_2		0xda
+#define PM860X_AUDIO_SUPPLIES_1		0xdb
+#define PM860X_AUDIO_SUPPLIES_2		0xdc
+#define PM860X_ADC_EN_1			0xdd
+#define PM860X_ADC_EN_2			0xde
+#define PM860X_DAC_EN_1			0xdf
+#define PM860X_DAC_EN_2			0xe1
+#define PM860X_AUDIO_CAL_1		0xe2
+#define PM860X_AUDIO_CAL_2		0xe3
+#define PM860X_AUDIO_CAL_3		0xe4
+#define PM860X_AUDIO_CAL_4		0xe5
+#define PM860X_AUDIO_CAL_5		0xe6
+#define PM860X_ANA_INPUT_SEL_1		0xe7
+#define PM860X_ANA_INPUT_SEL_2		0xe8
 
-#define PM860X_PCM_IFACE_4		0x39
-#define PM860X_I2S_IFACE_5		0x3a
+#define PM860X_PCM_IFACE_4		0xe9
+#define PM860X_I2S_IFACE_5		0xea
 
 #define PM860X_SHORTS			0x3b
 #define PM860X_PLL_ADJ_1		0x3c
-- 
1.8.4.rc3
