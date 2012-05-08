From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: rt5631: Convert to direct regmap API
	usage
Date: Tue,  8 May 2012 15:53:33 +0100
Message-ID: <1336488813-19613-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1336488813-19613-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B6A1B104478
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 16:53:38 +0200 (CEST)
In-Reply-To: <1336488813-19613-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Daniel Drake <dsd@laptop.org>, Johnny Hsu <johnnyhsu@realtek.com>, flove@realtek.com
Cc: devel@lists.laptop.org, alsa-devel@alsa-project.org, Chris Ball <cjb@laptop.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

We're trying to remove all usage of the ASoc level cache and I/O code and
for a device like this with a pretty sparse register map the rbtree cache
is a better idea anyway.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/rt5631.c |   95 ++++++++++++++++++++++++++-------------------
 1 file changed, 54 insertions(+), 41 deletions(-)

diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
index a64f2a7..960d0e9 100644
--- a/sound/soc/codecs/rt5631.c
+++ b/sound/soc/codecs/rt5631.c
@@ -18,7 +18,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/spi/spi.h>
+#include <linux/regmap.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -30,6 +30,7 @@
 #include "rt5631.h"
 
 struct rt5631_priv {
+	struct regmap *regmap;
 	int codec_version;
 	int master;
 	int sysclk;
@@ -38,33 +39,33 @@ struct rt5631_priv {
 	int dmic_used_flag;
 };
 
-static const u16 rt5631_reg[RT5631_VENDOR_ID2 + 1] = {
-	[RT5631_SPK_OUT_VOL] = 0x8888,
-	[RT5631_HP_OUT_VOL] = 0x8080,
-	[RT5631_MONO_AXO_1_2_VOL] = 0xa080,
-	[RT5631_AUX_IN_VOL] = 0x0808,
-	[RT5631_ADC_REC_MIXER] = 0xf0f0,
-	[RT5631_VDAC_DIG_VOL] = 0x0010,
-	[RT5631_OUTMIXER_L_CTRL] = 0xffc0,
-	[RT5631_OUTMIXER_R_CTRL] = 0xffc0,
-	[RT5631_AXO1MIXER_CTRL] = 0x88c0,
-	[RT5631_AXO2MIXER_CTRL] = 0x88c0,
-	[RT5631_DIG_MIC_CTRL] = 0x3000,
-	[RT5631_MONO_INPUT_VOL] = 0x8808,
-	[RT5631_SPK_MIXER_CTRL] = 0xf8f8,
-	[RT5631_SPK_MONO_OUT_CTRL] = 0xfc00,
-	[RT5631_SPK_MONO_HP_OUT_CTRL] = 0x4440,
-	[RT5631_SDP_CTRL] = 0x8000,
-	[RT5631_MONO_SDP_CTRL] = 0x8000,
-	[RT5631_STEREO_AD_DA_CLK_CTRL] = 0x2010,
-	[RT5631_GEN_PUR_CTRL_REG] = 0x0e00,
-	[RT5631_INT_ST_IRQ_CTRL_2] = 0x071a,
-	[RT5631_MISC_CTRL] = 0x2040,
-	[RT5631_DEPOP_FUN_CTRL_2] = 0x8000,
-	[RT5631_SOFT_VOL_CTRL] = 0x07e0,
-	[RT5631_ALC_CTRL_1] = 0x0206,
-	[RT5631_ALC_CTRL_3] = 0x2000,
-	[RT5631_PSEUDO_SPATL_CTRL] = 0x0553,
+static const struct reg_default rt5631_reg[] = {
+	{ RT5631_SPK_OUT_VOL, 0x8888 },
+	{ RT5631_HP_OUT_VOL, 0x8080 },
+	{ RT5631_MONO_AXO_1_2_VOL, 0xa080 },
+	{ RT5631_AUX_IN_VOL, 0x0808 },
+	{ RT5631_ADC_REC_MIXER, 0xf0f0 },
+	{ RT5631_VDAC_DIG_VOL, 0x0010 },
+	{ RT5631_OUTMIXER_L_CTRL, 0xffc0 },
+	{ RT5631_OUTMIXER_R_CTRL, 0xffc0 },
+	{ RT5631_AXO1MIXER_CTRL, 0x88c0 },
+	{ RT5631_AXO2MIXER_CTRL, 0x88c0 },
+	{ RT5631_DIG_MIC_CTRL, 0x3000 },
+	{ RT5631_MONO_INPUT_VOL, 0x8808 },
+	{ RT5631_SPK_MIXER_CTRL, 0xf8f8 },
+	{ RT5631_SPK_MONO_OUT_CTRL, 0xfc00 },
+	{ RT5631_SPK_MONO_HP_OUT_CTRL, 0x4440 },
+	{ RT5631_SDP_CTRL, 0x8000 },
+	{ RT5631_MONO_SDP_CTRL, 0x8000 },
+	{ RT5631_STEREO_AD_DA_CLK_CTRL, 0x2010 },
+	{ RT5631_GEN_PUR_CTRL_REG, 0x0e00 },
+	{ RT5631_INT_ST_IRQ_CTRL_2, 0x071a },
+	{ RT5631_MISC_CTRL, 0x2040 },
+	{ RT5631_DEPOP_FUN_CTRL_2, 0x8000 },
+	{ RT5631_SOFT_VOL_CTRL, 0x07e0 },
+	{ RT5631_ALC_CTRL_1, 0x0206 },
+	{ RT5631_ALC_CTRL_3, 0x2000 },
+	{ RT5631_PSEUDO_SPATL_CTRL, 0x0553 },
 };
 
 /**
@@ -96,8 +97,7 @@ static int rt5631_reset(struct snd_soc_codec *codec)
 	return snd_soc_write(codec, RT5631_RESET, 0);
 }
 
-static int rt5631_volatile_register(struct snd_soc_codec *codec,
-				    unsigned int reg)
+static bool rt5631_volatile_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case RT5631_RESET:
@@ -111,8 +111,7 @@ static int rt5631_volatile_register(struct snd_soc_codec *codec,
 	}
 }
 
-static int rt5631_readable_register(struct snd_soc_codec *codec,
-				    unsigned int reg)
+static bool rt5631_readable_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case RT5631_RESET:
@@ -1543,6 +1542,8 @@ static int rt5631_codec_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 static int rt5631_set_bias_level(struct snd_soc_codec *codec,
 			enum snd_soc_bias_level level)
 {
+	struct rt5631_priv *rt5631 = snd_soc_codec_get_drvdata(codec);
+
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 	case SND_SOC_BIAS_PREPARE:
@@ -1560,8 +1561,8 @@ static int rt5631_set_bias_level(struct snd_soc_codec *codec,
 			snd_soc_update_bits(codec, RT5631_PWR_MANAG_ADD3,
 				RT5631_PWR_FAST_VREF_CTRL,
 				RT5631_PWR_FAST_VREF_CTRL);
-			codec->cache_only = false;
-			snd_soc_cache_sync(codec);
+			regcache_cache_only(rt5631->regmap, false);
+			regcache_sync(rt5631->regmap);
 		}
 		break;
 
@@ -1586,7 +1587,9 @@ static int rt5631_probe(struct snd_soc_codec *codec)
 	unsigned int val;
 	int ret;
 
-	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_I2C);
+	codec->control_data = rt5631->regmap;
+
+	ret = snd_soc_codec_set_cache_io(codec, 8, 16, SND_SOC_REGMAP);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
@@ -1697,12 +1700,6 @@ static struct snd_soc_codec_driver soc_codec_dev_rt5631 = {
 	.suspend = rt5631_suspend,
 	.resume = rt5631_resume,
 	.set_bias_level = rt5631_set_bias_level,
-	.reg_cache_size = RT5631_VENDOR_ID2 + 1,
-	.reg_word_size = sizeof(u16),
-	.reg_cache_default = rt5631_reg,
-	.volatile_register = rt5631_volatile_register,
-	.readable_register = rt5631_readable_register,
-	.reg_cache_step = 1,
 	.controls = rt5631_snd_controls,
 	.num_controls = ARRAY_SIZE(rt5631_snd_controls),
 	.dapm_widgets = rt5631_dapm_widgets,
@@ -1717,6 +1714,18 @@ static const struct i2c_device_id rt5631_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt5631_i2c_id);
 
+static const struct regmap_config rt5631_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+
+	.readable_reg = rt5631_readable_register,
+	.volatile_reg = rt5631_volatile_register,
+	.max_register = RT5631_VENDOR_ID2,
+	.reg_defaults = rt5631_reg,
+	.num_reg_defaults = ARRAY_SIZE(rt5631_reg),
+	.cache_type = REGCACHE_RBTREE,
+};
+
 static int rt5631_i2c_probe(struct i2c_client *i2c,
 		    const struct i2c_device_id *id)
 {
@@ -1730,6 +1739,10 @@ static int rt5631_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, rt5631);
 
+	rt5631->regmap = devm_regmap_init_i2c(i2c, &rt5631_regmap_config);
+	if (IS_ERR(rt5631->regmap))
+		return PTR_ERR(rt5631->regmap);
+
 	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5631,
 			rt5631_dai, ARRAY_SIZE(rt5631_dai));
 	return ret;
-- 
1.7.10
