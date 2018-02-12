From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm179x: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:39:35 +0000
Message-ID: <E1elDOR-0004Ya-F1@debutante>
References: <87tvv5xpum.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E306267B52
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:39:37 +0100 (CET)
In-Reply-To: <87tvv5xpum.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: pcm179x: replace codec to component

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

>From db0a11d00220cf84bec2047fe698004813096926 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:16:56 +0000
Subject: [PATCH] ASoC: pcm179x: replace codec to component

Now we can replace Codec to Component. Let's do it.

Note:
	xxx_codec_xxx()		->	xxx_component_xxx()
	.idle_bias_off = 0	->	.idle_bias_on = 1
	.ignore_pmdown_time = 0	->	.use_pmdown_time = 1
	-			->	.endianness = 1
	-			->	.non_legacy_dai_naming = 1

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm179x-i2c.c |  6 ------
 sound/soc/codecs/pcm179x-spi.c |  6 ------
 sound/soc/codecs/pcm179x.c     | 45 +++++++++++++++++++-----------------------
 sound/soc/codecs/pcm179x.h     |  1 -
 4 files changed, 20 insertions(+), 38 deletions(-)

diff --git a/sound/soc/codecs/pcm179x-i2c.c b/sound/soc/codecs/pcm179x-i2c.c
index 4118106abb8d..03747966c6bc 100644
--- a/sound/soc/codecs/pcm179x-i2c.c
+++ b/sound/soc/codecs/pcm179x-i2c.c
@@ -39,11 +39,6 @@ static int pcm179x_i2c_probe(struct i2c_client *client,
 	return pcm179x_common_init(&client->dev, regmap);
 }
 
-static int pcm179x_i2c_remove(struct i2c_client *client)
-{
-	return pcm179x_common_exit(&client->dev);
-}
-
 static const struct of_device_id pcm179x_of_match[] = {
 	{ .compatible = "ti,pcm1792a", },
 	{ }
@@ -63,7 +58,6 @@ static struct i2c_driver pcm179x_i2c_driver = {
 	},
 	.id_table	= pcm179x_i2c_ids,
 	.probe		= pcm179x_i2c_probe,
-	.remove		= pcm179x_i2c_remove,
 };
 
 module_i2c_driver(pcm179x_i2c_driver);
diff --git a/sound/soc/codecs/pcm179x-spi.c b/sound/soc/codecs/pcm179x-spi.c
index da924d444083..89ad715676fc 100644
--- a/sound/soc/codecs/pcm179x-spi.c
+++ b/sound/soc/codecs/pcm179x-spi.c
@@ -38,11 +38,6 @@ static int pcm179x_spi_probe(struct spi_device *spi)
 	return pcm179x_common_init(&spi->dev, regmap);
 }
 
-static int pcm179x_spi_remove(struct spi_device *spi)
-{
-	return pcm179x_common_exit(&spi->dev);
-}
-
 static const struct of_device_id pcm179x_of_match[] = {
 	{ .compatible = "ti,pcm1792a", },
 	{ }
@@ -62,7 +57,6 @@ static struct spi_driver pcm179x_spi_driver = {
 	},
 	.id_table = pcm179x_spi_ids,
 	.probe = pcm179x_spi_probe,
-	.remove = pcm179x_spi_remove,
 };
 
 module_spi_driver(pcm179x_spi_driver);
diff --git a/sound/soc/codecs/pcm179x.c b/sound/soc/codecs/pcm179x.c
index 82a3d9db32cb..4b311c06f97d 100644
--- a/sound/soc/codecs/pcm179x.c
+++ b/sound/soc/codecs/pcm179x.c
@@ -77,8 +77,8 @@ struct pcm179x_private {
 static int pcm179x_set_dai_fmt(struct snd_soc_dai *codec_dai,
                              unsigned int format)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct pcm179x_private *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct pcm179x_private *priv = snd_soc_component_get_drvdata(component);
 
 	priv->format = format;
 
@@ -87,8 +87,8 @@ static int pcm179x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 
 static int pcm179x_digital_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct pcm179x_private *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct pcm179x_private *priv = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	ret = regmap_update_bits(priv->regmap, PCM179X_SOFT_MUTE,
@@ -103,8 +103,8 @@ static int pcm179x_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params,
 			     struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct pcm179x_private *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct pcm179x_private *priv = snd_soc_component_get_drvdata(component);
 	int val = 0, ret;
 
 	priv->rate = params_rate(params);
@@ -137,7 +137,7 @@ static int pcm179x_hw_params(struct snd_pcm_substream *substream,
 		}
 		break;
 	default:
-		dev_err(codec->dev, "Invalid DAI format\n");
+		dev_err(component->dev, "Invalid DAI format\n");
 		return -EINVAL;
 	}
 
@@ -205,15 +205,17 @@ const struct regmap_config pcm179x_regmap_config = {
 };
 EXPORT_SYMBOL_GPL(pcm179x_regmap_config);
 
-static const struct snd_soc_codec_driver soc_codec_dev_pcm179x = {
-	.component_driver = {
-		.controls		= pcm179x_controls,
-		.num_controls		= ARRAY_SIZE(pcm179x_controls),
-		.dapm_widgets		= pcm179x_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(pcm179x_dapm_widgets),
-		.dapm_routes		= pcm179x_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(pcm179x_dapm_routes),
-	},
+static const struct snd_soc_component_driver soc_component_dev_pcm179x = {
+	.controls		= pcm179x_controls,
+	.num_controls		= ARRAY_SIZE(pcm179x_controls),
+	.dapm_widgets		= pcm179x_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(pcm179x_dapm_widgets),
+	.dapm_routes		= pcm179x_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(pcm179x_dapm_routes),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 int pcm179x_common_init(struct device *dev, struct regmap *regmap)
@@ -228,18 +230,11 @@ int pcm179x_common_init(struct device *dev, struct regmap *regmap)
 	pcm179x->regmap = regmap;
 	dev_set_drvdata(dev, pcm179x);
 
-	return snd_soc_register_codec(dev,
-			&soc_codec_dev_pcm179x, &pcm179x_dai, 1);
+	return devm_snd_soc_register_component(dev,
+			&soc_component_dev_pcm179x, &pcm179x_dai, 1);
 }
 EXPORT_SYMBOL_GPL(pcm179x_common_init);
 
-int pcm179x_common_exit(struct device *dev)
-{
-	snd_soc_unregister_codec(dev);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pcm179x_common_exit);
-
 MODULE_DESCRIPTION("ASoC PCM179X driver");
 MODULE_AUTHOR("Michael Trimarchi <michael@amarulasolutions.com>");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/pcm179x.h b/sound/soc/codecs/pcm179x.h
index 11e331268aae..cf8681c9a373 100644
--- a/sound/soc/codecs/pcm179x.h
+++ b/sound/soc/codecs/pcm179x.h
@@ -23,6 +23,5 @@
 extern const struct regmap_config pcm179x_regmap_config;
 
 int pcm179x_common_init(struct device *dev, struct regmap *regmap);
-int pcm179x_common_exit(struct device *dev);
 
 #endif
-- 
2.16.1
