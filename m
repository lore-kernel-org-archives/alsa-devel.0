From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ssm2602: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:38:15 +0000
Message-ID: <E1elDN9-0004FC-Cr@debutante>
References: <87tvv5waqn.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DB15267A7B
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:38:17 +0100 (CET)
In-Reply-To: <87tvv5waqn.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: ssm2602: replace codec to component

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

>From ad4771ef9d45b8db72318d2cd85024bd7b5f5e95 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:28:41 +0000
Subject: [PATCH] ASoC: ssm2602: replace codec to component

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
 sound/soc/codecs/ssm2602-i2c.c |  7 ----
 sound/soc/codecs/ssm2602-spi.c |  7 ----
 sound/soc/codecs/ssm2602.c     | 77 +++++++++++++++++++++---------------------
 3 files changed, 39 insertions(+), 52 deletions(-)

diff --git a/sound/soc/codecs/ssm2602-i2c.c b/sound/soc/codecs/ssm2602-i2c.c
index 173ba85ff59e..f1c2b1a3ada3 100644
--- a/sound/soc/codecs/ssm2602-i2c.c
+++ b/sound/soc/codecs/ssm2602-i2c.c
@@ -27,12 +27,6 @@ static int ssm2602_i2c_probe(struct i2c_client *client,
 		devm_regmap_init_i2c(client, &ssm2602_regmap_config));
 }
 
-static int ssm2602_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-	return 0;
-}
-
 static const struct i2c_device_id ssm2602_i2c_id[] = {
 	{ "ssm2602", SSM2602 },
 	{ "ssm2603", SSM2602 },
@@ -55,7 +49,6 @@ static struct i2c_driver ssm2602_i2c_driver = {
 		.of_match_table = ssm2602_of_match,
 	},
 	.probe = ssm2602_i2c_probe,
-	.remove = ssm2602_i2c_remove,
 	.id_table = ssm2602_i2c_id,
 };
 module_i2c_driver(ssm2602_i2c_driver);
diff --git a/sound/soc/codecs/ssm2602-spi.c b/sound/soc/codecs/ssm2602-spi.c
index 842f373045c6..8848628571a1 100644
--- a/sound/soc/codecs/ssm2602-spi.c
+++ b/sound/soc/codecs/ssm2602-spi.c
@@ -20,12 +20,6 @@ static int ssm2602_spi_probe(struct spi_device *spi)
 		devm_regmap_init_spi(spi, &ssm2602_regmap_config));
 }
 
-static int ssm2602_spi_remove(struct spi_device *spi)
-{
-	snd_soc_unregister_codec(&spi->dev);
-	return 0;
-}
-
 static const struct of_device_id ssm2602_of_match[] = {
 	{ .compatible = "adi,ssm2602", },
 	{ }
@@ -38,7 +32,6 @@ static struct spi_driver ssm2602_spi_driver = {
 		.of_match_table = ssm2602_of_match,
 	},
 	.probe		= ssm2602_spi_probe,
-	.remove		= ssm2602_spi_remove,
 };
 module_spi_driver(ssm2602_spi_driver);
 
diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 9b341c23f62b..031e0eabcc1f 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -273,8 +273,8 @@ static int ssm2602_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params,
 	struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct ssm2602_priv *ssm2602 = snd_soc_component_get_drvdata(component);
 	int srate = ssm2602_get_coeff(ssm2602->sysclk, params_rate(params));
 	unsigned int iface;
 
@@ -308,8 +308,8 @@ static int ssm2602_hw_params(struct snd_pcm_substream *substream,
 static int ssm2602_startup(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct ssm2602_priv *ssm2602 = snd_soc_component_get_drvdata(component);
 
 	if (ssm2602->sysclk_constraints) {
 		snd_pcm_hw_constraint_list(substream->runtime, 0,
@@ -322,7 +322,7 @@ static int ssm2602_startup(struct snd_pcm_substream *substream,
 
 static int ssm2602_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(dai->codec);
+	struct ssm2602_priv *ssm2602 = snd_soc_component_get_drvdata(dai->component);
 
 	if (mute)
 		regmap_update_bits(ssm2602->regmap, SSM2602_APDIGI,
@@ -337,8 +337,8 @@ static int ssm2602_mute(struct snd_soc_dai *dai, int mute)
 static int ssm2602_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct ssm2602_priv *ssm2602 = snd_soc_component_get_drvdata(component);
 
 	if (dir == SND_SOC_CLOCK_IN) {
 		if (clk_id != SSM2602_SYSCLK)
@@ -389,7 +389,7 @@ static int ssm2602_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 static int ssm2602_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
-	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec_dai->codec);
+	struct ssm2602_priv *ssm2602 = snd_soc_component_get_drvdata(codec_dai->component);
 	unsigned int iface = 0;
 
 	/* set master/slave audio interface */
@@ -445,10 +445,10 @@ static int ssm2602_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
-static int ssm2602_set_bias_level(struct snd_soc_codec *codec,
+static int ssm2602_set_bias_level(struct snd_soc_component *component,
 				 enum snd_soc_bias_level level)
 {
-	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec);
+	struct ssm2602_priv *ssm2602 = snd_soc_component_get_drvdata(component);
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
@@ -511,19 +511,19 @@ static struct snd_soc_dai_driver ssm2602_dai = {
 	.symmetric_samplebits = 1,
 };
 
-static int ssm2602_resume(struct snd_soc_codec *codec)
+static int ssm2602_resume(struct snd_soc_component *component)
 {
-	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec);
+	struct ssm2602_priv *ssm2602 = snd_soc_component_get_drvdata(component);
 
 	regcache_sync(ssm2602->regmap);
 
 	return 0;
 }
 
-static int ssm2602_codec_probe(struct snd_soc_codec *codec)
+static int ssm2602_component_probe(struct snd_soc_component *component)
 {
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
-	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	struct ssm2602_priv *ssm2602 = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	regmap_update_bits(ssm2602->regmap, SSM2602_LOUT1V,
@@ -531,7 +531,7 @@ static int ssm2602_codec_probe(struct snd_soc_codec *codec)
 	regmap_update_bits(ssm2602->regmap, SSM2602_ROUT1V,
 			    ROUT1V_RLHP_BOTH, ROUT1V_RLHP_BOTH);
 
-	ret = snd_soc_add_codec_controls(codec, ssm2602_snd_controls,
+	ret = snd_soc_add_component_controls(component, ssm2602_snd_controls,
 			ARRAY_SIZE(ssm2602_snd_controls));
 	if (ret)
 		return ret;
@@ -545,9 +545,9 @@ static int ssm2602_codec_probe(struct snd_soc_codec *codec)
 			ARRAY_SIZE(ssm2602_routes));
 }
 
-static int ssm2604_codec_probe(struct snd_soc_codec *codec)
+static int ssm2604_component_probe(struct snd_soc_component *component)
 {
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 	int ret;
 
 	ret = snd_soc_dapm_new_controls(dapm, ssm2604_dapm_widgets,
@@ -559,14 +559,14 @@ static int ssm2604_codec_probe(struct snd_soc_codec *codec)
 			ARRAY_SIZE(ssm2604_routes));
 }
 
-static int ssm260x_codec_probe(struct snd_soc_codec *codec)
+static int ssm260x_component_probe(struct snd_soc_component *component)
 {
-	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec);
+	struct ssm2602_priv *ssm2602 = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	ret = regmap_write(ssm2602->regmap, SSM2602_RESET, 0);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to issue reset: %d\n", ret);
+		dev_err(component->dev, "Failed to issue reset: %d\n", ret);
 		return ret;
 	}
 
@@ -581,30 +581,31 @@ static int ssm260x_codec_probe(struct snd_soc_codec *codec)
 
 	switch (ssm2602->type) {
 	case SSM2602:
-		ret = ssm2602_codec_probe(codec);
+		ret = ssm2602_component_probe(component);
 		break;
 	case SSM2604:
-		ret = ssm2604_codec_probe(codec);
+		ret = ssm2604_component_probe(component);
 		break;
 	}
 
 	return ret;
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_ssm2602 = {
-	.probe =	ssm260x_codec_probe,
-	.resume =	ssm2602_resume,
-	.set_bias_level = ssm2602_set_bias_level,
-	.suspend_bias_off = true,
-
-	.component_driver = {
-		.controls		= ssm260x_snd_controls,
-		.num_controls		= ARRAY_SIZE(ssm260x_snd_controls),
-		.dapm_widgets		= ssm260x_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(ssm260x_dapm_widgets),
-		.dapm_routes		= ssm260x_routes,
-		.num_dapm_routes	= ARRAY_SIZE(ssm260x_routes),
-	},
+static const struct snd_soc_component_driver soc_component_dev_ssm2602 = {
+	.probe			= ssm260x_component_probe,
+	.resume			= ssm2602_resume,
+	.set_bias_level		= ssm2602_set_bias_level,
+	.controls		= ssm260x_snd_controls,
+	.num_controls		= ARRAY_SIZE(ssm260x_snd_controls),
+	.dapm_widgets		= ssm260x_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(ssm260x_dapm_widgets),
+	.dapm_routes		= ssm260x_routes,
+	.num_dapm_routes	= ARRAY_SIZE(ssm260x_routes),
+	.suspend_bias_off	= 1,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static bool ssm2602_register_volatile(struct device *dev, unsigned int reg)
@@ -641,7 +642,7 @@ int ssm2602_probe(struct device *dev, enum ssm2602_type type,
 	ssm2602->type = type;
 	ssm2602->regmap = regmap;
 
-	return snd_soc_register_codec(dev, &soc_codec_dev_ssm2602,
+	return devm_snd_soc_register_component(dev, &soc_component_dev_ssm2602,
 		&ssm2602_dai, 1);
 }
 EXPORT_SYMBOL_GPL(ssm2602_probe);
-- 
2.16.1
