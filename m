From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98926: replace codec to component"
	to the asoc tree
Date: Mon, 12 Feb 2018 12:41:23 +0000
Message-ID: <E1elDQB-0004pa-Le@debutante>
References: <87mv0xz4vu.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DC4C1267C1B
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:41:25 +0100 (CET)
In-Reply-To: <87mv0xz4vu.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: max98926: replace codec to component

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

>From 6f2b5d0db19a0e428dd7fc3abf326ebbc0726693 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:06:51 +0000
Subject: [PATCH] ASoC: max98926: replace codec to component

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
 sound/soc/codecs/max98926.c | 56 +++++++++++++++++++++------------------------
 sound/soc/codecs/max98926.h |  2 +-
 2 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/sound/soc/codecs/max98926.c b/sound/soc/codecs/max98926.c
index 7b1d1b0fa879..d9b1f68f243d 100644
--- a/sound/soc/codecs/max98926.c
+++ b/sound/soc/codecs/max98926.c
@@ -336,18 +336,18 @@ static void max98926_set_sense_data(struct max98926_priv *max98926)
 static int max98926_dai_set_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct max98926_priv *max98926 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct max98926_priv *max98926 = snd_soc_component_get_drvdata(component);
 	unsigned int invert = 0;
 
-	dev_dbg(codec->dev, "%s: fmt 0x%08X\n", __func__, fmt);
+	dev_dbg(component->dev, "%s: fmt 0x%08X\n", __func__, fmt);
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS:
 		max98926_set_sense_data(max98926);
 		break;
 	default:
-		dev_err(codec->dev, "DAI clock mode unsupported\n");
+		dev_err(component->dev, "DAI clock mode unsupported\n");
 		return -EINVAL;
 	}
 
@@ -364,7 +364,7 @@ static int max98926_dai_set_fmt(struct snd_soc_dai *codec_dai,
 		invert = MAX98926_DAI_BCI_MASK | MAX98926_DAI_WCI_MASK;
 		break;
 	default:
-		dev_err(codec->dev, "DAI invert mode unsupported\n");
+		dev_err(component->dev, "DAI invert mode unsupported\n");
 		return -EINVAL;
 	}
 
@@ -381,8 +381,8 @@ static int max98926_dai_hw_params(struct snd_pcm_substream *substream,
 {
 	int dai_sr = -EINVAL;
 	int rate = params_rate(params), i;
-	struct snd_soc_codec *codec = dai->codec;
-	struct max98926_priv *max98926 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct max98926_priv *max98926 = snd_soc_component_get_drvdata(component);
 	int blr_clk_ratio;
 
 	switch (params_format(params)) {
@@ -408,7 +408,7 @@ static int max98926_dai_hw_params(struct snd_pcm_substream *substream,
 		max98926->ch_size = 32;
 		break;
 	default:
-		dev_dbg(codec->dev, "format unsupported %d\n",
+		dev_dbg(component->dev, "format unsupported %d\n",
 			params_format(params));
 		return -EINVAL;
 	}
@@ -485,27 +485,29 @@ static struct snd_soc_dai_driver max98926_dai[] = {
 }
 };
 
-static int max98926_probe(struct snd_soc_codec *codec)
+static int max98926_probe(struct snd_soc_component *component)
 {
-	struct max98926_priv *max98926 = snd_soc_codec_get_drvdata(codec);
+	struct max98926_priv *max98926 = snd_soc_component_get_drvdata(component);
 
-	max98926->codec = codec;
+	max98926->component = component;
 
 	/* Hi-Z all the slots */
 	regmap_write(max98926->regmap, MAX98926_DOUT_HIZ_CFG4, 0xF0);
 	return 0;
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_max98926 = {
-	.probe	= max98926_probe,
-	.component_driver = {
-		.controls		= max98926_snd_controls,
-		.num_controls		= ARRAY_SIZE(max98926_snd_controls),
-		.dapm_routes		= max98926_audio_map,
-		.num_dapm_routes	= ARRAY_SIZE(max98926_audio_map),
-		.dapm_widgets		= max98926_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(max98926_dapm_widgets),
-	},
+static const struct snd_soc_component_driver soc_component_dev_max98926 = {
+	.probe			= max98926_probe,
+	.controls		= max98926_snd_controls,
+	.num_controls		= ARRAY_SIZE(max98926_snd_controls),
+	.dapm_routes		= max98926_audio_map,
+	.num_dapm_routes	= ARRAY_SIZE(max98926_audio_map),
+	.dapm_widgets		= max98926_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(max98926_dapm_widgets),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct regmap_config max98926_regmap = {
@@ -563,22 +565,17 @@ static int max98926_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_max98926,
+	ret = devm_snd_soc_register_component(&i2c->dev,
+			&soc_component_dev_max98926,
 			max98926_dai, ARRAY_SIZE(max98926_dai));
 	if (ret < 0)
 		dev_err(&i2c->dev,
-				"Failed to register codec: %d\n", ret);
+				"Failed to register component: %d\n", ret);
 	dev_info(&i2c->dev, "device version: %x\n", reg);
 err_out:
 	return ret;
 }
 
-static int max98926_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-	return 0;
-}
-
 static const struct i2c_device_id max98926_i2c_id[] = {
 	{ "max98926", 0 },
 	{ }
@@ -598,7 +595,6 @@ static struct i2c_driver max98926_i2c_driver = {
 		.pm = NULL,
 	},
 	.probe	= max98926_i2c_probe,
-	.remove = max98926_i2c_remove,
 	.id_table = max98926_i2c_id,
 };
 
diff --git a/sound/soc/codecs/max98926.h b/sound/soc/codecs/max98926.h
index 9d7ab6df79ca..ccf2c3f66c07 100644
--- a/sound/soc/codecs/max98926.h
+++ b/sound/soc/codecs/max98926.h
@@ -838,7 +838,7 @@
 
 struct max98926_priv {
 	struct regmap *regmap;
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 	unsigned int sysclk;
 	unsigned int v_slot;
 	unsigned int i_slot;
-- 
2.16.1
