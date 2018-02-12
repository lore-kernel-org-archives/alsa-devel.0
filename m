From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ak4104: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:45:57 +0000
Message-ID: <E1elDUb-0005QJ-JW@debutante>
References: <87bmhd2w9s.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B50C12678E8
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:45:59 +0100 (CET)
In-Reply-To: <87bmhd2w9s.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: ak4104: replace codec to component

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

>From 61feead8d78fe103dd18dba5d9acb3a67dce2567 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:14:01 +0000
Subject: [PATCH] ASoC: ak4104: replace codec to component

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
 sound/soc/codecs/ak4104.c | 68 +++++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 38 deletions(-)

diff --git a/sound/soc/codecs/ak4104.c b/sound/soc/codecs/ak4104.c
index dbb184118f2e..32bc545c19cf 100644
--- a/sound/soc/codecs/ak4104.c
+++ b/sound/soc/codecs/ak4104.c
@@ -65,8 +65,8 @@ static const struct snd_soc_dapm_route ak4104_dapm_routes[] = {
 static int ak4104_set_dai_fmt(struct snd_soc_dai *codec_dai,
 			      unsigned int format)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct ak4104_private *ak4104 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct ak4104_private *ak4104 = snd_soc_component_get_drvdata(component);
 	int val = 0;
 	int ret;
 
@@ -81,7 +81,7 @@ static int ak4104_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		val |= AK4104_CONTROL1_DIF0 | AK4104_CONTROL1_DIF1;
 		break;
 	default:
-		dev_err(codec->dev, "invalid dai format\n");
+		dev_err(component->dev, "invalid dai format\n");
 		return -EINVAL;
 	}
 
@@ -102,8 +102,8 @@ static int ak4104_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct ak4104_private *ak4104 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct ak4104_private *ak4104 = snd_soc_component_get_drvdata(component);
 	int ret, val = 0;
 
 	/* set the IEC958 bits: consumer mode, no copyright bit */
@@ -141,7 +141,7 @@ static int ak4104_hw_params(struct snd_pcm_substream *substream,
 		val |= IEC958_AES3_CON_FS_192000;
 		break;
 	default:
-		dev_err(codec->dev, "unsupported sampling rate\n");
+		dev_err(component->dev, "unsupported sampling rate\n");
 		return -EINVAL;
 	}
 
@@ -174,14 +174,14 @@ static struct snd_soc_dai_driver ak4104_dai = {
 	.ops = &ak4101_dai_ops,
 };
 
-static int ak4104_probe(struct snd_soc_codec *codec)
+static int ak4104_probe(struct snd_soc_component *component)
 {
-	struct ak4104_private *ak4104 = snd_soc_codec_get_drvdata(codec);
+	struct ak4104_private *ak4104 = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	ret = regulator_enable(ak4104->regulator);
 	if (ret < 0) {
-		dev_err(codec->dev, "Unable to enable regulator: %d\n", ret);
+		dev_err(component->dev, "Unable to enable regulator: %d\n", ret);
 		return ret;
 	}
 
@@ -205,30 +205,28 @@ static int ak4104_probe(struct snd_soc_codec *codec)
 	return ret;
 }
 
-static int ak4104_remove(struct snd_soc_codec *codec)
+static void ak4104_remove(struct snd_soc_component *component)
 {
-	struct ak4104_private *ak4104 = snd_soc_codec_get_drvdata(codec);
+	struct ak4104_private *ak4104 = snd_soc_component_get_drvdata(component);
 
 	regmap_update_bits(ak4104->regmap, AK4104_REG_CONTROL1,
 			   AK4104_CONTROL1_PW | AK4104_CONTROL1_RSTN, 0);
 	regulator_disable(ak4104->regulator);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
-static int ak4104_soc_suspend(struct snd_soc_codec *codec)
+static int ak4104_soc_suspend(struct snd_soc_component *component)
 {
-	struct ak4104_private *priv = snd_soc_codec_get_drvdata(codec);
+	struct ak4104_private *priv = snd_soc_component_get_drvdata(component);
 
 	regulator_disable(priv->regulator);
 
 	return 0;
 }
 
-static int ak4104_soc_resume(struct snd_soc_codec *codec)
+static int ak4104_soc_resume(struct snd_soc_component *component)
 {
-	struct ak4104_private *priv = snd_soc_codec_get_drvdata(codec);
+	struct ak4104_private *priv = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	ret = regulator_enable(priv->regulator);
@@ -242,18 +240,19 @@ static int ak4104_soc_resume(struct snd_soc_codec *codec)
 #define ak4104_soc_resume	NULL
 #endif /* CONFIG_PM */
 
-static const struct snd_soc_codec_driver soc_codec_device_ak4104 = {
-	.probe = ak4104_probe,
-	.remove = ak4104_remove,
-	.suspend = ak4104_soc_suspend,
-	.resume = ak4104_soc_resume,
-
-	.component_driver = {
-		.dapm_widgets		= ak4104_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(ak4104_dapm_widgets),
-		.dapm_routes		= ak4104_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(ak4104_dapm_routes),
-	}
+static const struct snd_soc_component_driver soc_component_device_ak4104 = {
+	.probe			= ak4104_probe,
+	.remove			= ak4104_remove,
+	.suspend		= ak4104_soc_suspend,
+	.resume			= ak4104_soc_resume,
+	.dapm_widgets		= ak4104_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(ak4104_dapm_widgets),
+	.dapm_routes		= ak4104_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(ak4104_dapm_routes),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct regmap_config ak4104_regmap = {
@@ -323,17 +322,11 @@ static int ak4104_spi_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, ak4104);
 
-	ret = snd_soc_register_codec(&spi->dev,
-			&soc_codec_device_ak4104, &ak4104_dai, 1);
+	ret = devm_snd_soc_register_component(&spi->dev,
+			&soc_component_device_ak4104, &ak4104_dai, 1);
 	return ret;
 }
 
-static int ak4104_spi_remove(struct spi_device *spi)
-{
-	snd_soc_unregister_codec(&spi->dev);
-	return 0;
-}
-
 static const struct of_device_id ak4104_of_match[] = {
 	{ .compatible = "asahi-kasei,ak4104", },
 	{ }
@@ -353,7 +346,6 @@ static struct spi_driver ak4104_spi_driver = {
 	},
 	.id_table = ak4104_id_table,
 	.probe  = ak4104_spi_probe,
-	.remove = ak4104_spi_remove,
 };
 
 module_spi_driver(ak4104_spi_driver);
-- 
2.16.1
