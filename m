From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic26: replace codec to
	component" to the asoc tree
Date: Mon, 12 Feb 2018 12:40:03 +0000
Message-ID: <E1elDOt-0004eZ-NI@debutante>
References: <874ln5z4l8.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 11502267660
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:40:06 +0100 (CET)
In-Reply-To: <874ln5z4l8.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic26: replace codec to component

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 1514613a7a4480e40f40a2d41527292fece8b362 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:13:13 +0000
Subject: [PATCH] ASoC: tlv320aic26: replace codec to component

Now we can replace Codec to Component. Let's do it.

Note:
	xxx_codec_xxx()		->	xxx_component_xxx()
	.idle_bias_off = 0	->	.idle_bias_on = 1
	.ignore_pmdown_time = 0	->	.use_pmdown_time = 1
	-			->	.endianness = 1
	-			->	.non_legacy_dai_naming = 1

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic26.c | 83 ++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 44 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index 89421caaeb70..b91b8d5f1ba3 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -30,7 +30,7 @@ MODULE_LICENSE("GPL");
 struct aic26 {
 	struct spi_device *spi;
 	struct regmap *regmap;
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 	int master;
 	int datfm;
 	int mclk;
@@ -64,8 +64,8 @@ static int aic26_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *params,
 			   struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct aic26 *aic26 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct aic26 *aic26 = snd_soc_component_get_drvdata(component);
 	int fsref, divisor, wlen, pval, jval, dval, qval;
 	u16 reg;
 
@@ -112,20 +112,20 @@ static int aic26_hw_params(struct snd_pcm_substream *substream,
 	dev_dbg(&aic26->spi->dev, "Setting PLLM to %d.%04d\n", jval, dval);
 	qval = 0;
 	reg = 0x8000 | qval << 11 | pval << 8 | jval << 2;
-	snd_soc_write(codec, AIC26_REG_PLL_PROG1, reg);
+	snd_soc_component_write(component, AIC26_REG_PLL_PROG1, reg);
 	reg = dval << 2;
-	snd_soc_write(codec, AIC26_REG_PLL_PROG2, reg);
+	snd_soc_component_write(component, AIC26_REG_PLL_PROG2, reg);
 
 	/* Audio Control 3 (master mode, fsref rate) */
 	if (aic26->master)
 		reg = 0x0800;
 	if (fsref == 48000)
 		reg = 0x2000;
-	snd_soc_update_bits(codec, AIC26_REG_AUDIO_CTRL3, 0xf800, reg);
+	snd_soc_component_update_bits(component, AIC26_REG_AUDIO_CTRL3, 0xf800, reg);
 
 	/* Audio Control 1 (FSref divisor) */
 	reg = wlen | aic26->datfm | (divisor << 3) | divisor;
-	snd_soc_update_bits(codec, AIC26_REG_AUDIO_CTRL1, 0xfff, reg);
+	snd_soc_component_update_bits(component, AIC26_REG_AUDIO_CTRL1, 0xfff, reg);
 
 	return 0;
 }
@@ -135,8 +135,8 @@ static int aic26_hw_params(struct snd_pcm_substream *substream,
  */
 static int aic26_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct aic26 *aic26 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct aic26 *aic26 = snd_soc_component_get_drvdata(component);
 	u16 reg;
 
 	dev_dbg(&aic26->spi->dev, "aic26_mute(dai=%p, mute=%i)\n",
@@ -146,7 +146,7 @@ static int aic26_mute(struct snd_soc_dai *dai, int mute)
 		reg = 0x8080;
 	else
 		reg = 0;
-	snd_soc_update_bits(codec, AIC26_REG_DAC_GAIN, 0x8000, reg);
+	snd_soc_component_update_bits(component, AIC26_REG_DAC_GAIN, 0x8000, reg);
 
 	return 0;
 }
@@ -154,8 +154,8 @@ static int aic26_mute(struct snd_soc_dai *dai, int mute)
 static int aic26_set_sysclk(struct snd_soc_dai *codec_dai,
 			    int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct aic26 *aic26 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct aic26 *aic26 = snd_soc_component_get_drvdata(component);
 
 	dev_dbg(&aic26->spi->dev, "aic26_set_sysclk(dai=%p, clk_id==%i,"
 		" freq=%i, dir=%i)\n",
@@ -171,8 +171,8 @@ static int aic26_set_sysclk(struct snd_soc_dai *codec_dai,
 
 static int aic26_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct aic26 *aic26 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct aic26 *aic26 = snd_soc_component_get_drvdata(component);
 
 	dev_dbg(&aic26->spi->dev, "aic26_set_fmt(dai=%p, fmt==%i)\n",
 		codec_dai, fmt);
@@ -265,7 +265,7 @@ static ssize_t aic26_keyclick_show(struct device *dev,
 	struct aic26 *aic26 = dev_get_drvdata(dev);
 	int val, amp, freq, len;
 
-	val = snd_soc_read(aic26->codec, AIC26_REG_AUDIO_CTRL2);
+	val = snd_soc_component_read32(aic26->component, AIC26_REG_AUDIO_CTRL2);
 	amp = (val >> 12) & 0x7;
 	freq = (125 << ((val >> 8) & 0x7)) >> 1;
 	len = 2 * (1 + ((val >> 4) & 0xf));
@@ -280,7 +280,7 @@ static ssize_t aic26_keyclick_set(struct device *dev,
 {
 	struct aic26 *aic26 = dev_get_drvdata(dev);
 
-	snd_soc_update_bits(aic26->codec, AIC26_REG_AUDIO_CTRL2,
+	snd_soc_component_update_bits(aic26->component, AIC26_REG_AUDIO_CTRL2,
 			    0x8000, 0x800);
 
 	return count;
@@ -291,44 +291,46 @@ static DEVICE_ATTR(keyclick, 0644, aic26_keyclick_show, aic26_keyclick_set);
 /* ---------------------------------------------------------------------
  * SoC CODEC portion of driver: probe and release routines
  */
-static int aic26_probe(struct snd_soc_codec *codec)
+static int aic26_probe(struct snd_soc_component *component)
 {
-	struct aic26 *aic26 = dev_get_drvdata(codec->dev);
+	struct aic26 *aic26 = dev_get_drvdata(component->dev);
 	int ret, reg;
 
-	aic26->codec = codec;
+	aic26->component = component;
 
 	/* Reset the codec to power on defaults */
-	snd_soc_write(codec, AIC26_REG_RESET, 0xBB00);
+	snd_soc_component_write(component, AIC26_REG_RESET, 0xBB00);
 
 	/* Power up CODEC */
-	snd_soc_write(codec, AIC26_REG_POWER_CTRL, 0);
+	snd_soc_component_write(component, AIC26_REG_POWER_CTRL, 0);
 
 	/* Audio Control 3 (master mode, fsref rate) */
-	reg = snd_soc_read(codec, AIC26_REG_AUDIO_CTRL3);
+	reg = snd_soc_component_read32(component, AIC26_REG_AUDIO_CTRL3);
 	reg &= ~0xf800;
 	reg |= 0x0800; /* set master mode */
-	snd_soc_write(codec, AIC26_REG_AUDIO_CTRL3, reg);
+	snd_soc_component_write(component, AIC26_REG_AUDIO_CTRL3, reg);
 
 	/* Register the sysfs files for debugging */
 	/* Create SysFS files */
-	ret = device_create_file(codec->dev, &dev_attr_keyclick);
+	ret = device_create_file(component->dev, &dev_attr_keyclick);
 	if (ret)
-		dev_info(codec->dev, "error creating sysfs files\n");
+		dev_info(component->dev, "error creating sysfs files\n");
 
 	return 0;
 }
 
-static const struct snd_soc_codec_driver aic26_soc_codec_dev = {
-	.probe = aic26_probe,
-	.component_driver = {
-		.controls		= aic26_snd_controls,
-		.num_controls		= ARRAY_SIZE(aic26_snd_controls),
-		.dapm_widgets		= tlv320aic26_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(tlv320aic26_dapm_widgets),
-		.dapm_routes		= tlv320aic26_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(tlv320aic26_dapm_routes),
-	},
+static const struct snd_soc_component_driver aic26_soc_component_dev = {
+	.probe			= aic26_probe,
+	.controls		= aic26_snd_controls,
+	.num_controls		= ARRAY_SIZE(aic26_snd_controls),
+	.dapm_widgets		= tlv320aic26_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(tlv320aic26_dapm_widgets),
+	.dapm_routes		= tlv320aic26_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(tlv320aic26_dapm_routes),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct regmap_config aic26_regmap = {
@@ -361,23 +363,16 @@ static int aic26_spi_probe(struct spi_device *spi)
 	dev_set_drvdata(&spi->dev, aic26);
 	aic26->master = 1;
 
-	ret = snd_soc_register_codec(&spi->dev,
-			&aic26_soc_codec_dev, &aic26_dai, 1);
+	ret = devm_snd_soc_register_component(&spi->dev,
+			&aic26_soc_component_dev, &aic26_dai, 1);
 	return ret;
 }
 
-static int aic26_spi_remove(struct spi_device *spi)
-{
-	snd_soc_unregister_codec(&spi->dev);
-	return 0;
-}
-
 static struct spi_driver aic26_spi = {
 	.driver = {
 		.name = "tlv320aic26-codec",
 	},
 	.probe = aic26_spi_probe,
-	.remove = aic26_spi_remove,
 };
 
 module_spi_driver(aic26_spi);
-- 
2.16.1
