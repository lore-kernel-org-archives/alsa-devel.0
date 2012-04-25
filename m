From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] ASoC: SSM2602: Convert to direct regmap
	API usage
Date: Wed, 25 Apr 2012 11:42:48 +0200
Message-ID: <1335346968-6086-3-git-send-email-lars@metafoo.de>
References: <1335346968-6086-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-098.synserver.de (smtp-out-102.synserver.de
	[212.40.185.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 00509104843
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Apr 2012 11:40:30 +0200 (CEST)
In-Reply-To: <1335346968-6086-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Mostly a one to one converion. On one occasion the patch replaces a
snd_soc_read-snd_soc_write sequence with regmap_update_bits though as it helps
to keep the conversion simple.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ssm2602.c |   87 +++++++++++++++++++++++++++++---------------
 1 file changed, 57 insertions(+), 30 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index aef8a49..079066f 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -33,6 +33,7 @@
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/spi/spi.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -52,10 +53,11 @@ enum ssm2602_type {
 struct ssm2602_priv {
 	unsigned int sysclk;
 	struct snd_pcm_hw_constraint_list *sysclk_constraints;
-	enum snd_soc_control_type control_type;
 	struct snd_pcm_substream *master_substream;
 	struct snd_pcm_substream *slave_substream;
 
+	struct regmap *regmap;
+
 	enum ssm2602_type type;
 	unsigned int clk_out_pwr;
 };
@@ -72,7 +74,6 @@ static const u16 ssm2602_reg[SSM2602_CACHEREGNUM] = {
 	0x0000, 0x0000
 };
 
-#define ssm2602_reset(c)	snd_soc_write(c, SSM2602_RESET, 0)
 
 /*Appending several "None"s just for OSS mixer use*/
 static const char *ssm2602_input_select[] = {
@@ -273,8 +274,8 @@ static int ssm2602_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec);
-	u16 iface = snd_soc_read(codec, SSM2602_IFACE) & 0xfff3;
 	int srate = ssm2602_get_coeff(ssm2602->sysclk, params_rate(params));
+	unsigned int iface;
 
 	if (substream == ssm2602->slave_substream) {
 		dev_dbg(codec->dev, "Ignoring hw_params for slave substream\n");
@@ -284,23 +285,27 @@ static int ssm2602_hw_params(struct snd_pcm_substream *substream,
 	if (srate < 0)
 		return srate;
 
-	snd_soc_write(codec, SSM2602_SRATE, srate);
+	regmap_write(ssm2602->regmap, SSM2602_SRATE, srate);
 
 	/* bit size */
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
+		iface = 0x0;
 		break;
 	case SNDRV_PCM_FORMAT_S20_3LE:
-		iface |= 0x0004;
+		iface = 0x4;
 		break;
 	case SNDRV_PCM_FORMAT_S24_LE:
-		iface |= 0x0008;
+		iface = 0x8;
 		break;
 	case SNDRV_PCM_FORMAT_S32_LE:
-		iface |= 0x000c;
+		iface = 0xc;
 		break;
+	default:
+		return -EINVAL;
 	}
-	snd_soc_write(codec, SSM2602_IFACE, iface);
+	regmap_update_bits(ssm2602->regmap, SSM2602_IFACE,
+		IFACE_AUDIO_DATA_LEN, iface);
 	return 0;
 }
 
@@ -361,14 +366,14 @@ static void ssm2602_shutdown(struct snd_pcm_substream *substream,
 
 static int ssm2602_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(dai->codec);
 
 	if (mute)
-		snd_soc_update_bits(codec, SSM2602_APDIGI,
+		regmap_update_bits(ssm2602->regmap, SSM2602_APDIGI,
 				    APDIGI_ENABLE_DAC_MUTE,
 				    APDIGI_ENABLE_DAC_MUTE);
 	else
-		snd_soc_update_bits(codec, SSM2602_APDIGI,
+		regmap_update_bits(ssm2602->regmap, SSM2602_APDIGI,
 				    APDIGI_ENABLE_DAC_MUTE, 0);
 	return 0;
 }
@@ -418,7 +423,7 @@ static int ssm2602_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		else
 			ssm2602->clk_out_pwr &= ~mask;
 
-		snd_soc_update_bits(codec, SSM2602_PWR,
+		regmap_update_bits(ssm2602->regmap, SSM2602_PWR,
 			PWR_CLK_OUT_PDN | PWR_OSC_PDN, ssm2602->clk_out_pwr);
 	}
 
@@ -428,8 +433,8 @@ static int ssm2602_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 static int ssm2602_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	u16 iface = 0;
+	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec_dai->codec);
+	unsigned int iface = 0;
 
 	/* set master/slave audio interface */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -480,7 +485,7 @@ static int ssm2602_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	}
 
 	/* set iface */
-	snd_soc_write(codec, SSM2602_IFACE, iface);
+	regmap_write(ssm2602->regmap, SSM2602_IFACE, iface);
 	return 0;
 }
 
@@ -492,7 +497,7 @@ static int ssm2602_set_bias_level(struct snd_soc_codec *codec,
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		/* vref/mid on, osc and clkout on if enabled */
-		snd_soc_update_bits(codec, SSM2602_PWR,
+		regmap_update_bits(ssm2602->regmap, SSM2602_PWR,
 			PWR_POWER_OFF | PWR_CLK_OUT_PDN | PWR_OSC_PDN,
 			ssm2602->clk_out_pwr);
 		break;
@@ -500,13 +505,13 @@ static int ssm2602_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		/* everything off except vref/vmid, */
-		snd_soc_update_bits(codec, SSM2602_PWR,
+		regmap_update_bits(ssm2602->regmap, SSM2602_PWR,
 			PWR_POWER_OFF | PWR_CLK_OUT_PDN | PWR_OSC_PDN,
 			PWR_CLK_OUT_PDN | PWR_OSC_PDN);
 		break;
 	case SND_SOC_BIAS_OFF:
 		/* everything off */
-		snd_soc_update_bits(codec, SSM2602_PWR,
+		regmap_update_bits(ssm2602->regmap, SSM2602_PWR,
 			PWR_POWER_OFF, PWR_POWER_OFF);
 		break;
 
@@ -565,12 +570,13 @@ static int ssm2602_resume(struct snd_soc_codec *codec)
 
 static int ssm2602_probe(struct snd_soc_codec *codec)
 {
+	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec);
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	int ret;
 
-	snd_soc_update_bits(codec, SSM2602_LOUT1V,
+	regmap_update_bits(ssm2602->regmap, SSM2602_LOUT1V,
 			    LOUT1V_LRHP_BOTH, LOUT1V_LRHP_BOTH);
-	snd_soc_update_bits(codec, SSM2602_ROUT1V,
+	regmap_update_bits(ssm2602->regmap, SSM2602_ROUT1V,
 			    ROUT1V_RLHP_BOTH, ROUT1V_RLHP_BOTH);
 
 	ret = snd_soc_add_codec_controls(codec, ssm2602_snd_controls,
@@ -606,25 +612,26 @@ static int ssm260x_probe(struct snd_soc_codec *codec)
 	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
-	ret = snd_soc_codec_set_cache_io(codec, 7, 9, ssm2602->control_type);
+	codec->control_data = ssm2602->regmap;
+	ret = snd_soc_codec_set_cache_io(codec, 0, 0, SND_SOC_REGMAP);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
 		return ret;
 	}
 
-	ret = ssm2602_reset(codec);
+	ret = regmap_write(ssm2602->regmap, SSM2602_RESET, 0);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to issue reset: %d\n", ret);
 		return ret;
 	}
 
 	/* set the update bits */
-	snd_soc_update_bits(codec, SSM2602_LINVOL,
+	regmap_update_bits(ssm2602->regmap, SSM2602_LINVOL,
 			    LINVOL_LRIN_BOTH, LINVOL_LRIN_BOTH);
-	snd_soc_update_bits(codec, SSM2602_RINVOL,
+	regmap_update_bits(ssm2602->regmap, SSM2602_RINVOL,
 			    RINVOL_RLIN_BOTH, RINVOL_RLIN_BOTH);
 	/*select Line in as default input*/
-	snd_soc_write(codec, SSM2602_APANA, APANA_SELECT_DAC |
+	regmap_write(ssm2602->regmap, SSM2602_APANA, APANA_SELECT_DAC |
 			APANA_ENABLE_MIC_BOOST);
 
 	switch (ssm2602->type) {
@@ -657,9 +664,6 @@ static struct snd_soc_codec_driver soc_codec_dev_ssm2602 = {
 	.suspend =	ssm2602_suspend,
 	.resume =	ssm2602_resume,
 	.set_bias_level = ssm2602_set_bias_level,
-	.reg_cache_size = ARRAY_SIZE(ssm2602_reg),
-	.reg_word_size = sizeof(u16),
-	.reg_cache_default = ssm2602_reg,
 
 	.controls = ssm260x_snd_controls,
 	.num_controls = ARRAY_SIZE(ssm260x_snd_controls),
@@ -669,6 +673,23 @@ static struct snd_soc_codec_driver soc_codec_dev_ssm2602 = {
 	.num_dapm_routes = ARRAY_SIZE(ssm260x_routes),
 };
 
+static bool ssm2602_register_volatile(struct device *dev, unsigned int reg)
+{
+	return reg == SSM2602_RESET;
+}
+
+static const struct regmap_config ssm2602_regmap_config = {
+	.val_bits = 9,
+	.reg_bits = 7,
+
+	.max_register = SSM2602_RESET,
+	.volatile_reg = ssm2602_register_volatile,
+
+	.cache_type = REGCACHE_RBTREE,
+	.reg_defaults_raw = ssm2602_reg,
+	.num_reg_defaults_raw = ARRAY_SIZE(ssm2602_reg),
+};
+
 #if defined(CONFIG_SPI_MASTER)
 static int __devinit ssm2602_spi_probe(struct spi_device *spi)
 {
@@ -681,9 +702,12 @@ static int __devinit ssm2602_spi_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	spi_set_drvdata(spi, ssm2602);
-	ssm2602->control_type = SND_SOC_SPI;
 	ssm2602->type = SSM2602;
 
+	ssm2602->regmap = devm_regmap_init_spi(spi, &ssm2602_regmap_config);
+	if (IS_ERR(ssm2602->regmap))
+		return PTR_ERR(ssm2602->regmap);
+
 	ret = snd_soc_register_codec(&spi->dev,
 			&soc_codec_dev_ssm2602, &ssm2602_dai, 1);
 	return ret;
@@ -724,9 +748,12 @@ static int __devinit ssm2602_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	i2c_set_clientdata(i2c, ssm2602);
-	ssm2602->control_type = SND_SOC_I2C;
 	ssm2602->type = id->driver_data;
 
+	ssm2602->regmap = devm_regmap_init_i2c(i2c, &ssm2602_regmap_config);
+	if (IS_ERR(ssm2602->regmap))
+		return PTR_ERR(ssm2602->regmap);
+
 	ret = snd_soc_register_codec(&i2c->dev,
 			&soc_codec_dev_ssm2602, &ssm2602_dai, 1);
 	return ret;
-- 
1.7.9.5
