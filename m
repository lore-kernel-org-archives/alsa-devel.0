From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/2] ASoC: ak4671: Convert to direct regmap API
	usage
Date: Tue, 11 Feb 2014 19:56:58 +0000
Message-ID: <1392148618-24830-2-git-send-email-broonie@kernel.org>
References: <1392148618-24830-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 45D6D2608B7
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2014 20:57:12 +0100 (CET)
In-Reply-To: <1392148618-24830-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

This helps us remove the ASoC level I/O functionality which is now just
a thin wrapper around regmap.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/ak4671.c | 221 +++++++++++++++++++++++-----------------------
 sound/soc/codecs/ak4671.h |   2 -
 2 files changed, 111 insertions(+), 112 deletions(-)

diff --git a/sound/soc/codecs/ak4671.c b/sound/soc/codecs/ak4671.c
index 456bd0a065b1..743bbe31bc08 100644
--- a/sound/soc/codecs/ak4671.c
+++ b/sound/soc/codecs/ak4671.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <sound/soc.h>
 #include <sound/initval.h>
@@ -23,104 +24,99 @@
 #include "ak4671.h"
 
 
-/* codec private data */
-struct ak4671_priv {
-	enum snd_soc_control_type control_type;
-};
-
 /* ak4671 register cache & default register settings */
-static const u8 ak4671_reg[AK4671_CACHEREGNUM] = {
-	0x00,	/* AK4671_AD_DA_POWER_MANAGEMENT	(0x00)	*/
-	0xf6,	/* AK4671_PLL_MODE_SELECT0		(0x01)	*/
-	0x00,	/* AK4671_PLL_MODE_SELECT1		(0x02)	*/
-	0x02,	/* AK4671_FORMAT_SELECT			(0x03)	*/
-	0x00,	/* AK4671_MIC_SIGNAL_SELECT		(0x04)	*/
-	0x55,	/* AK4671_MIC_AMP_GAIN			(0x05)	*/
-	0x00,	/* AK4671_MIXING_POWER_MANAGEMENT0	(0x06)	*/
-	0x00,	/* AK4671_MIXING_POWER_MANAGEMENT1	(0x07)	*/
-	0xb5,	/* AK4671_OUTPUT_VOLUME_CONTROL		(0x08)	*/
-	0x00,	/* AK4671_LOUT1_SIGNAL_SELECT		(0x09)	*/
-	0x00,	/* AK4671_ROUT1_SIGNAL_SELECT		(0x0a)	*/
-	0x00,	/* AK4671_LOUT2_SIGNAL_SELECT		(0x0b)	*/
-	0x00,	/* AK4671_ROUT2_SIGNAL_SELECT		(0x0c)	*/
-	0x00,	/* AK4671_LOUT3_SIGNAL_SELECT		(0x0d)	*/
-	0x00,	/* AK4671_ROUT3_SIGNAL_SELECT		(0x0e)	*/
-	0x00,	/* AK4671_LOUT1_POWER_MANAGERMENT	(0x0f)	*/
-	0x00,	/* AK4671_LOUT2_POWER_MANAGERMENT	(0x10)	*/
-	0x80,	/* AK4671_LOUT3_POWER_MANAGERMENT	(0x11)	*/
-	0x91,	/* AK4671_LCH_INPUT_VOLUME_CONTROL	(0x12)	*/
-	0x91,	/* AK4671_RCH_INPUT_VOLUME_CONTROL	(0x13)	*/
-	0xe1,	/* AK4671_ALC_REFERENCE_SELECT		(0x14)	*/
-	0x00,	/* AK4671_DIGITAL_MIXING_CONTROL	(0x15)	*/
-	0x00,	/* AK4671_ALC_TIMER_SELECT		(0x16)	*/
-	0x00,	/* AK4671_ALC_MODE_CONTROL		(0x17)	*/
-	0x02,	/* AK4671_MODE_CONTROL1			(0x18)	*/
-	0x01,	/* AK4671_MODE_CONTROL2			(0x19)	*/
-	0x18,	/* AK4671_LCH_OUTPUT_VOLUME_CONTROL	(0x1a)	*/
-	0x18,	/* AK4671_RCH_OUTPUT_VOLUME_CONTROL	(0x1b)	*/
-	0x00,	/* AK4671_SIDETONE_A_CONTROL		(0x1c)	*/
-	0x02,	/* AK4671_DIGITAL_FILTER_SELECT		(0x1d)	*/
-	0x00,	/* AK4671_FIL3_COEFFICIENT0		(0x1e)	*/
-	0x00,	/* AK4671_FIL3_COEFFICIENT1		(0x1f)	*/
-	0x00,	/* AK4671_FIL3_COEFFICIENT2		(0x20)	*/
-	0x00,	/* AK4671_FIL3_COEFFICIENT3		(0x21)	*/
-	0x00,	/* AK4671_EQ_COEFFICIENT0		(0x22)	*/
-	0x00,	/* AK4671_EQ_COEFFICIENT1		(0x23)	*/
-	0x00,	/* AK4671_EQ_COEFFICIENT2		(0x24)	*/
-	0x00,	/* AK4671_EQ_COEFFICIENT3		(0x25)	*/
-	0x00,	/* AK4671_EQ_COEFFICIENT4		(0x26)	*/
-	0x00,	/* AK4671_EQ_COEFFICIENT5		(0x27)	*/
-	0xa9,	/* AK4671_FIL1_COEFFICIENT0		(0x28)	*/
-	0x1f,	/* AK4671_FIL1_COEFFICIENT1		(0x29)	*/
-	0xad,	/* AK4671_FIL1_COEFFICIENT2		(0x2a)	*/
-	0x20,	/* AK4671_FIL1_COEFFICIENT3		(0x2b)	*/
-	0x00,	/* AK4671_FIL2_COEFFICIENT0		(0x2c)	*/
-	0x00,	/* AK4671_FIL2_COEFFICIENT1		(0x2d)	*/
-	0x00,	/* AK4671_FIL2_COEFFICIENT2		(0x2e)	*/
-	0x00,	/* AK4671_FIL2_COEFFICIENT3		(0x2f)	*/
-	0x00,	/* AK4671_DIGITAL_FILTER_SELECT2	(0x30)	*/
-	0x00,	/* this register not used			*/
-	0x00,	/* AK4671_E1_COEFFICIENT0		(0x32)	*/
-	0x00,	/* AK4671_E1_COEFFICIENT1		(0x33)	*/
-	0x00,	/* AK4671_E1_COEFFICIENT2		(0x34)	*/
-	0x00,	/* AK4671_E1_COEFFICIENT3		(0x35)	*/
-	0x00,	/* AK4671_E1_COEFFICIENT4		(0x36)	*/
-	0x00,	/* AK4671_E1_COEFFICIENT5		(0x37)	*/
-	0x00,	/* AK4671_E2_COEFFICIENT0		(0x38)	*/
-	0x00,	/* AK4671_E2_COEFFICIENT1		(0x39)	*/
-	0x00,	/* AK4671_E2_COEFFICIENT2		(0x3a)	*/
-	0x00,	/* AK4671_E2_COEFFICIENT3		(0x3b)	*/
-	0x00,	/* AK4671_E2_COEFFICIENT4		(0x3c)	*/
-	0x00,	/* AK4671_E2_COEFFICIENT5		(0x3d)	*/
-	0x00,	/* AK4671_E3_COEFFICIENT0		(0x3e)	*/
-	0x00,	/* AK4671_E3_COEFFICIENT1		(0x3f)	*/
-	0x00,	/* AK4671_E3_COEFFICIENT2		(0x40)	*/
-	0x00,	/* AK4671_E3_COEFFICIENT3		(0x41)	*/
-	0x00,	/* AK4671_E3_COEFFICIENT4		(0x42)	*/
-	0x00,	/* AK4671_E3_COEFFICIENT5		(0x43)	*/
-	0x00,	/* AK4671_E4_COEFFICIENT0		(0x44)	*/
-	0x00,	/* AK4671_E4_COEFFICIENT1		(0x45)	*/
-	0x00,	/* AK4671_E4_COEFFICIENT2		(0x46)	*/
-	0x00,	/* AK4671_E4_COEFFICIENT3		(0x47)	*/
-	0x00,	/* AK4671_E4_COEFFICIENT4		(0x48)	*/
-	0x00,	/* AK4671_E4_COEFFICIENT5		(0x49)	*/
-	0x00,	/* AK4671_E5_COEFFICIENT0		(0x4a)	*/
-	0x00,	/* AK4671_E5_COEFFICIENT1		(0x4b)	*/
-	0x00,	/* AK4671_E5_COEFFICIENT2		(0x4c)	*/
-	0x00,	/* AK4671_E5_COEFFICIENT3		(0x4d)	*/
-	0x00,	/* AK4671_E5_COEFFICIENT4		(0x4e)	*/
-	0x00,	/* AK4671_E5_COEFFICIENT5		(0x4f)	*/
-	0x88,	/* AK4671_EQ_CONTROL_250HZ_100HZ	(0x50)	*/
-	0x88,	/* AK4671_EQ_CONTROL_3500HZ_1KHZ	(0x51)	*/
-	0x08,	/* AK4671_EQ_CONTRO_10KHZ		(0x52)	*/
-	0x00,	/* AK4671_PCM_IF_CONTROL0		(0x53)	*/
-	0x00,	/* AK4671_PCM_IF_CONTROL1		(0x54)	*/
-	0x00,	/* AK4671_PCM_IF_CONTROL2		(0x55)	*/
-	0x18,	/* AK4671_DIGITAL_VOLUME_B_CONTROL	(0x56)	*/
-	0x18,	/* AK4671_DIGITAL_VOLUME_C_CONTROL	(0x57)	*/
-	0x00,	/* AK4671_SIDETONE_VOLUME_CONTROL	(0x58)	*/
-	0x00,	/* AK4671_DIGITAL_MIXING_CONTROL2	(0x59)	*/
-	0x00,	/* AK4671_SAR_ADC_CONTROL		(0x5a)	*/
+static const struct reg_default ak4671_reg_defaults[] = {
+	{ 0x00, 0x00 },	/* AK4671_AD_DA_POWER_MANAGEMENT	(0x00)	*/
+	{ 0x01, 0xf6 },	/* AK4671_PLL_MODE_SELECT0		(0x01)	*/
+	{ 0x02, 0x00 },	/* AK4671_PLL_MODE_SELECT1		(0x02)	*/
+	{ 0x03, 0x02 },	/* AK4671_FORMAT_SELECT			(0x03)	*/
+	{ 0x04, 0x00 },	/* AK4671_MIC_SIGNAL_SELECT		(0x04)	*/
+	{ 0x05, 0x55 },	/* AK4671_MIC_AMP_GAIN			(0x05)	*/
+	{ 0x06, 0x00 },	/* AK4671_MIXING_POWER_MANAGEMENT0	(0x06)	*/
+	{ 0x07, 0x00 },	/* AK4671_MIXING_POWER_MANAGEMENT1	(0x07)	*/
+	{ 0x08, 0xb5 },	/* AK4671_OUTPUT_VOLUME_CONTROL		(0x08)	*/
+	{ 0x09, 0x00 },	/* AK4671_LOUT1_SIGNAL_SELECT		(0x09)	*/
+	{ 0x0a, 0x00 },	/* AK4671_ROUT1_SIGNAL_SELECT		(0x0a)	*/
+	{ 0x0b, 0x00 },	/* AK4671_LOUT2_SIGNAL_SELECT		(0x0b)	*/
+	{ 0x0c, 0x00 },	/* AK4671_ROUT2_SIGNAL_SELECT		(0x0c)	*/
+	{ 0x0d, 0x00 },	/* AK4671_LOUT3_SIGNAL_SELECT		(0x0d)	*/
+	{ 0x0e, 0x00 },	/* AK4671_ROUT3_SIGNAL_SELECT		(0x0e)	*/
+	{ 0x0f, 0x00 },	/* AK4671_LOUT1_POWER_MANAGERMENT	(0x0f)	*/
+	{ 0x10, 0x00 },	/* AK4671_LOUT2_POWER_MANAGERMENT	(0x10)	*/
+	{ 0x11, 0x80 },	/* AK4671_LOUT3_POWER_MANAGERMENT	(0x11)	*/
+	{ 0x12, 0x91 },	/* AK4671_LCH_INPUT_VOLUME_CONTROL	(0x12)	*/
+	{ 0x13, 0x91 },	/* AK4671_RCH_INPUT_VOLUME_CONTROL	(0x13)	*/
+	{ 0x14, 0xe1 },	/* AK4671_ALC_REFERENCE_SELECT		(0x14)	*/
+	{ 0x15, 0x00 },	/* AK4671_DIGITAL_MIXING_CONTROL	(0x15)	*/
+	{ 0x16, 0x00 },	/* AK4671_ALC_TIMER_SELECT		(0x16)	*/
+	{ 0x17, 0x00 },	/* AK4671_ALC_MODE_CONTROL		(0x17)	*/
+	{ 0x18, 0x02 },	/* AK4671_MODE_CONTROL1			(0x18)	*/
+	{ 0x19, 0x01 },	/* AK4671_MODE_CONTROL2			(0x19)	*/
+	{ 0x1a, 0x18 },	/* AK4671_LCH_OUTPUT_VOLUME_CONTROL	(0x1a)	*/
+	{ 0x1b, 0x18 },	/* AK4671_RCH_OUTPUT_VOLUME_CONTROL	(0x1b)	*/
+	{ 0x1c, 0x00 },	/* AK4671_SIDETONE_A_CONTROL		(0x1c)	*/
+	{ 0x1d, 0x02 },	/* AK4671_DIGITAL_FILTER_SELECT		(0x1d)	*/
+	{ 0x1e, 0x00 },	/* AK4671_FIL3_COEFFICIENT0		(0x1e)	*/
+	{ 0x1f, 0x00 },	/* AK4671_FIL3_COEFFICIENT1		(0x1f)	*/
+	{ 0x20, 0x00 },	/* AK4671_FIL3_COEFFICIENT2		(0x20)	*/
+	{ 0x21, 0x00 },	/* AK4671_FIL3_COEFFICIENT3		(0x21)	*/
+	{ 0x22, 0x00 },	/* AK4671_EQ_COEFFICIENT0		(0x22)	*/
+	{ 0x23, 0x00 },	/* AK4671_EQ_COEFFICIENT1		(0x23)	*/
+	{ 0x24, 0x00 },	/* AK4671_EQ_COEFFICIENT2		(0x24)	*/
+	{ 0x25, 0x00 },	/* AK4671_EQ_COEFFICIENT3		(0x25)	*/
+	{ 0x26, 0x00 },	/* AK4671_EQ_COEFFICIENT4		(0x26)	*/
+	{ 0x27, 0x00 },	/* AK4671_EQ_COEFFICIENT5		(0x27)	*/
+	{ 0x28, 0xa9 },	/* AK4671_FIL1_COEFFICIENT0		(0x28)	*/
+	{ 0x29, 0x1f },	/* AK4671_FIL1_COEFFICIENT1		(0x29)	*/
+	{ 0x2a, 0xad },	/* AK4671_FIL1_COEFFICIENT2		(0x2a)	*/
+	{ 0x2b, 0x20 },	/* AK4671_FIL1_COEFFICIENT3		(0x2b)	*/
+	{ 0x2c, 0x00 },	/* AK4671_FIL2_COEFFICIENT0		(0x2c)	*/
+	{ 0x2d, 0x00 },	/* AK4671_FIL2_COEFFICIENT1		(0x2d)	*/
+	{ 0x2e, 0x00 },	/* AK4671_FIL2_COEFFICIENT2		(0x2e)	*/
+	{ 0x2f, 0x00 },	/* AK4671_FIL2_COEFFICIENT3		(0x2f)	*/
+	{ 0x30, 0x00 },	/* AK4671_DIGITAL_FILTER_SELECT2	(0x30)	*/
+
+	{ 0x32, 0x00 },	/* AK4671_E1_COEFFICIENT0		(0x32)	*/
+	{ 0x33, 0x00 },	/* AK4671_E1_COEFFICIENT1		(0x33)	*/
+	{ 0x34, 0x00 },	/* AK4671_E1_COEFFICIENT2		(0x34)	*/
+	{ 0x35, 0x00 },	/* AK4671_E1_COEFFICIENT3		(0x35)	*/
+	{ 0x36, 0x00 },	/* AK4671_E1_COEFFICIENT4		(0x36)	*/
+	{ 0x37, 0x00 },	/* AK4671_E1_COEFFICIENT5		(0x37)	*/
+	{ 0x38, 0x00 },	/* AK4671_E2_COEFFICIENT0		(0x38)	*/
+	{ 0x39, 0x00 },	/* AK4671_E2_COEFFICIENT1		(0x39)	*/
+	{ 0x3a, 0x00 },	/* AK4671_E2_COEFFICIENT2		(0x3a)	*/
+	{ 0x3b, 0x00 },	/* AK4671_E2_COEFFICIENT3		(0x3b)	*/
+	{ 0x3c, 0x00 },	/* AK4671_E2_COEFFICIENT4		(0x3c)	*/
+	{ 0x3d, 0x00 },	/* AK4671_E2_COEFFICIENT5		(0x3d)	*/
+	{ 0x3e, 0x00 },	/* AK4671_E3_COEFFICIENT0		(0x3e)	*/
+	{ 0x3f, 0x00 },	/* AK4671_E3_COEFFICIENT1		(0x3f)	*/
+	{ 0x40, 0x00 },	/* AK4671_E3_COEFFICIENT2		(0x40)	*/
+	{ 0x41, 0x00 },	/* AK4671_E3_COEFFICIENT3		(0x41)	*/
+	{ 0x42, 0x00 },	/* AK4671_E3_COEFFICIENT4		(0x42)	*/
+	{ 0x43, 0x00 },	/* AK4671_E3_COEFFICIENT5		(0x43)	*/
+	{ 0x44, 0x00 },	/* AK4671_E4_COEFFICIENT0		(0x44)	*/
+	{ 0x45, 0x00 },	/* AK4671_E4_COEFFICIENT1		(0x45)	*/
+	{ 0x46, 0x00 },	/* AK4671_E4_COEFFICIENT2		(0x46)	*/
+	{ 0x47, 0x00 },	/* AK4671_E4_COEFFICIENT3		(0x47)	*/
+	{ 0x48, 0x00 },	/* AK4671_E4_COEFFICIENT4		(0x48)	*/
+	{ 0x49, 0x00 },	/* AK4671_E4_COEFFICIENT5		(0x49)	*/
+	{ 0x4a, 0x00 },	/* AK4671_E5_COEFFICIENT0		(0x4a)	*/
+	{ 0x4b, 0x00 },	/* AK4671_E5_COEFFICIENT1		(0x4b)	*/
+	{ 0x4c, 0x00 },	/* AK4671_E5_COEFFICIENT2		(0x4c)	*/
+	{ 0x4d, 0x00 },	/* AK4671_E5_COEFFICIENT3		(0x4d)	*/
+	{ 0x4e, 0x00 },	/* AK4671_E5_COEFFICIENT4		(0x4e)	*/
+	{ 0x4f, 0x00 },	/* AK4671_E5_COEFFICIENT5		(0x4f)	*/
+	{ 0x50, 0x88 },	/* AK4671_EQ_CONTROL_250HZ_100HZ	(0x50)	*/
+	{ 0x51, 0x88 },	/* AK4671_EQ_CONTROL_3500HZ_1KHZ	(0x51)	*/
+	{ 0x52, 0x08 },	/* AK4671_EQ_CONTRO_10KHZ		(0x52)	*/
+	{ 0x53, 0x00 },	/* AK4671_PCM_IF_CONTROL0		(0x53)	*/
+	{ 0x54, 0x00 },	/* AK4671_PCM_IF_CONTROL1		(0x54)	*/
+	{ 0x55, 0x00 },	/* AK4671_PCM_IF_CONTROL2		(0x55)	*/
+	{ 0x56, 0x18 },	/* AK4671_DIGITAL_VOLUME_B_CONTROL	(0x56)	*/
+	{ 0x57, 0x18 },	/* AK4671_DIGITAL_VOLUME_C_CONTROL	(0x57)	*/
+	{ 0x58, 0x00 },	/* AK4671_SIDETONE_VOLUME_CONTROL	(0x58)	*/
+	{ 0x59, 0x00 },	/* AK4671_DIGITAL_MIXING_CONTROL2	(0x59)	*/
+	{ 0x5a, 0x00 },	/* AK4671_SAR_ADC_CONTROL		(0x5a)	*/
 };
 
 /*
@@ -619,10 +615,9 @@ static struct snd_soc_dai_driver ak4671_dai = {
 
 static int ak4671_probe(struct snd_soc_codec *codec)
 {
-	struct ak4671_priv *ak4671 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
-	ret = snd_soc_codec_set_cache_io(codec, 8, 8, ak4671->control_type);
+	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_REGMAP);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
@@ -645,28 +640,34 @@ static struct snd_soc_codec_driver soc_codec_dev_ak4671 = {
 	.set_bias_level = ak4671_set_bias_level,
 	.controls = ak4671_snd_controls,
 	.num_controls = ARRAY_SIZE(ak4671_snd_controls),
-	.reg_cache_size = AK4671_CACHEREGNUM,
-	.reg_word_size = sizeof(u8),
-	.reg_cache_default = ak4671_reg,
 	.dapm_widgets = ak4671_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(ak4671_dapm_widgets),
 	.dapm_routes = ak4671_intercon,
 	.num_dapm_routes = ARRAY_SIZE(ak4671_intercon),
 };
 
+static const struct regmap_config ak4671_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = AK4671_SAR_ADC_CONTROL,
+	.reg_defaults = ak4671_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(ak4671_reg_defaults),
+	.cache_type = REGCACHE_RBTREE,
+};
+
 static int ak4671_i2c_probe(struct i2c_client *client,
 			    const struct i2c_device_id *id)
 {
-	struct ak4671_priv *ak4671;
+	struct regmap *regmap;
 	int ret;
 
-	ak4671 = devm_kzalloc(&client->dev, sizeof(struct ak4671_priv),
-			      GFP_KERNEL);
-	if (ak4671 == NULL)
-		return -ENOMEM;
-
-	i2c_set_clientdata(client, ak4671);
-	ak4671->control_type = SND_SOC_I2C;
+	regmap = devm_regmap_init_i2c(client, &ak4671_regmap);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		dev_err(&client->dev, "Failed to create regmap: %d\n", ret);
+		return ret;
+	}
 
 	ret = snd_soc_register_codec(&client->dev,
 			&soc_codec_dev_ak4671, &ak4671_dai, 1);
diff --git a/sound/soc/codecs/ak4671.h b/sound/soc/codecs/ak4671.h
index 61cb7ab7552c..394a34d3f50a 100644
--- a/sound/soc/codecs/ak4671.h
+++ b/sound/soc/codecs/ak4671.h
@@ -105,8 +105,6 @@
 #define AK4671_DIGITAL_MIXING_CONTROL2		0x59
 #define AK4671_SAR_ADC_CONTROL			0x5a
 
-#define AK4671_CACHEREGNUM			(AK4671_SAR_ADC_CONTROL + 1)
-
 /* Bitfield Definitions */
 
 /* AK4671_AD_DA_POWER_MANAGEMENT (0x00) Fields */
-- 
1.9.0.rc3
