From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98371: replace codec to component"
	to the asoc tree
Date: Mon, 12 Feb 2018 12:41:34 +0000
Message-ID: <E1elDQM-0004s7-3N@debutante>
References: <87r2q9z4yk.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 556F42679B5
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:41:36 +0100 (CET)
In-Reply-To: <87r2q9z4yk.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: max98371: replace codec to component

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

>From 1ae91ac7f787ee4078d93147d633ce3377ece748 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:05:15 +0000
Subject: [PATCH] ASoC: max98371: replace codec to component

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
 sound/soc/codecs/max98371.c | 43 +++++++++++++++++++------------------------
 sound/soc/codecs/max98371.h |  1 -
 2 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/max98371.c b/sound/soc/codecs/max98371.c
index 7bc2a17c1e94..d4ba1392aaf8 100644
--- a/sound/soc/codecs/max98371.c
+++ b/sound/soc/codecs/max98371.c
@@ -187,15 +187,15 @@ static const struct snd_kcontrol_new max98371_snd_controls[] = {
 static int max98371_dai_set_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct max98371_priv *max98371 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct max98371_priv *max98371 = snd_soc_component_get_drvdata(component);
 	unsigned int val = 0;
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS:
 		break;
 	default:
-		dev_err(codec->dev, "DAI clock mode unsupported");
+		dev_err(component->dev, "DAI clock mode unsupported");
 		return -EINVAL;
 	}
 
@@ -210,7 +210,7 @@ static int max98371_dai_set_fmt(struct snd_soc_dai *codec_dai,
 		val |= MAX98371_DAI_LEFT;
 		break;
 	default:
-		dev_err(codec->dev, "DAI wrong mode unsupported");
+		dev_err(component->dev, "DAI wrong mode unsupported");
 		return -EINVAL;
 	}
 	regmap_update_bits(max98371->regmap, MAX98371_FMT,
@@ -222,8 +222,8 @@ static int max98371_dai_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params,
 		struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct max98371_priv *max98371 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct max98371_priv *max98371 = snd_soc_component_get_drvdata(component);
 	int blr_clk_ratio, ch_size, channels = params_channels(params);
 	int rate = params_rate(params);
 
@@ -348,15 +348,17 @@ static struct snd_soc_dai_driver max98371_dai[] = {
 	}
 };
 
-static const struct snd_soc_codec_driver max98371_codec = {
-	.component_driver = {
-		.controls = max98371_snd_controls,
-		.num_controls = ARRAY_SIZE(max98371_snd_controls),
-		.dapm_routes = max98371_audio_map,
-		.num_dapm_routes = ARRAY_SIZE(max98371_audio_map),
-		.dapm_widgets = max98371_dapm_widgets,
-		.num_dapm_widgets = ARRAY_SIZE(max98371_dapm_widgets),
-	},
+static const struct snd_soc_component_driver max98371_component = {
+	.controls		= max98371_snd_controls,
+	.num_controls		= ARRAY_SIZE(max98371_snd_controls),
+	.dapm_routes		= max98371_audio_map,
+	.num_dapm_routes	= ARRAY_SIZE(max98371_audio_map),
+	.dapm_widgets		= max98371_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(max98371_dapm_widgets),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct regmap_config max98371_regmap = {
@@ -397,21 +399,15 @@ static int max98371_i2c_probe(struct i2c_client *i2c,
 	}
 	dev_info(&i2c->dev, "device version %x\n", reg);
 
-	ret = snd_soc_register_codec(&i2c->dev, &max98371_codec,
+	ret = devm_snd_soc_register_component(&i2c->dev, &max98371_component,
 			max98371_dai, ARRAY_SIZE(max98371_dai));
 	if (ret < 0) {
-		dev_err(&i2c->dev, "Failed to register codec: %d\n", ret);
+		dev_err(&i2c->dev, "Failed to register component: %d\n", ret);
 		return ret;
 	}
 	return ret;
 }
 
-static int max98371_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-	return 0;
-}
-
 static const struct i2c_device_id max98371_i2c_id[] = {
 	{ "max98371", 0 },
 	{ }
@@ -432,7 +428,6 @@ static struct i2c_driver max98371_i2c_driver = {
 		.of_match_table = of_match_ptr(max98371_of_match),
 	},
 	.probe  = max98371_i2c_probe,
-	.remove = max98371_i2c_remove,
 	.id_table = max98371_i2c_id,
 };
 
diff --git a/sound/soc/codecs/max98371.h b/sound/soc/codecs/max98371.h
index 9f6330964d98..06e9ba784e0b 100644
--- a/sound/soc/codecs/max98371.h
+++ b/sound/soc/codecs/max98371.h
@@ -62,6 +62,5 @@
 
 struct max98371_priv {
 	struct regmap *regmap;
-	struct snd_soc_codec *codec;
 };
 #endif
-- 
2.16.1
