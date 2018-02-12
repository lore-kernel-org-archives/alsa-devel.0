From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tas5086: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:37:59 +0000
Message-ID: <E1elDMt-0004An-3z@debutante>
References: <87mv0xwan8.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5926426744A
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:38:01 +0100 (CET)
In-Reply-To: <87mv0xwan8.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: tas5086: replace codec to component

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

>From 459bc024b7f2360f656b03562ec02ee5945bd033 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:30:43 +0000
Subject: [PATCH] ASoC: tas5086: replace codec to component

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
 sound/soc/codecs/tas5086.c | 94 +++++++++++++++++++++++-----------------------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/sound/soc/codecs/tas5086.c b/sound/soc/codecs/tas5086.c
index 199272d5cb6a..5efc4b7145d4 100644
--- a/sound/soc/codecs/tas5086.c
+++ b/sound/soc/codecs/tas5086.c
@@ -261,9 +261,9 @@ struct tas5086_private {
 
 static int tas5086_deemph[] = { 0, 32000, 44100, 48000 };
 
-static int tas5086_set_deemph(struct snd_soc_codec *codec)
+static int tas5086_set_deemph(struct snd_soc_component *component)
 {
-	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
+	struct tas5086_private *priv = snd_soc_component_get_drvdata(component);
 	int i, val = 0;
 
 	if (priv->deemph) {
@@ -282,8 +282,8 @@ static int tas5086_set_deemph(struct snd_soc_codec *codec)
 static int tas5086_get_deemph(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct tas5086_private *priv = snd_soc_component_get_drvdata(component);
 
 	ucontrol->value.integer.value[0] = priv->deemph;
 
@@ -293,20 +293,20 @@ static int tas5086_get_deemph(struct snd_kcontrol *kcontrol,
 static int tas5086_put_deemph(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct tas5086_private *priv = snd_soc_component_get_drvdata(component);
 
 	priv->deemph = ucontrol->value.integer.value[0];
 
-	return tas5086_set_deemph(codec);
+	return tas5086_set_deemph(component);
 }
 
 
 static int tas5086_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 				  int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct tas5086_private *priv = snd_soc_component_get_drvdata(component);
 
 	switch (clk_id) {
 	case TAS5086_CLK_IDX_MCLK:
@@ -323,12 +323,12 @@ static int tas5086_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 static int tas5086_set_dai_fmt(struct snd_soc_dai *codec_dai,
 			       unsigned int format)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct tas5086_private *priv = snd_soc_component_get_drvdata(component);
 
 	/* The TAS5086 can only be slave to all clocks */
 	if ((format & SND_SOC_DAIFMT_MASTER_MASK) != SND_SOC_DAIFMT_CBS_CFS) {
-		dev_err(codec->dev, "Invalid clocking mode\n");
+		dev_err(component->dev, "Invalid clocking mode\n");
 		return -EINVAL;
 	}
 
@@ -361,8 +361,8 @@ static int tas5086_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params,
 			     struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct tas5086_private *priv = snd_soc_component_get_drvdata(component);
 	int val;
 	int ret;
 
@@ -373,7 +373,7 @@ static int tas5086_hw_params(struct snd_pcm_substream *substream,
 			     ARRAY_SIZE(tas5086_sample_rates), priv->rate);
 
 	if (val < 0) {
-		dev_err(codec->dev, "Invalid sample rate\n");
+		dev_err(component->dev, "Invalid sample rate\n");
 		return -EINVAL;
 	}
 
@@ -387,7 +387,7 @@ static int tas5086_hw_params(struct snd_pcm_substream *substream,
 	val = index_in_array(tas5086_ratios, ARRAY_SIZE(tas5086_ratios),
 			     priv->mclk / priv->rate);
 	if (val < 0) {
-		dev_err(codec->dev, "Invalid MCLK / Fs ratio\n");
+		dev_err(component->dev, "Invalid MCLK / Fs ratio\n");
 		return -EINVAL;
 	}
 
@@ -424,7 +424,7 @@ static int tas5086_hw_params(struct snd_pcm_substream *substream,
 		val = 0x06;
 		break;
 	default:
-		dev_err(codec->dev, "Invalid DAI format\n");
+		dev_err(component->dev, "Invalid DAI format\n");
 		return -EINVAL;
 	}
 
@@ -440,7 +440,7 @@ static int tas5086_hw_params(struct snd_pcm_substream *substream,
 		val += 2;
 		break;
 	default:
-		dev_err(codec->dev, "Invalid bit width\n");
+		dev_err(component->dev, "Invalid bit width\n");
 		return -EINVAL;
 	}
 
@@ -454,13 +454,13 @@ static int tas5086_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
-	return tas5086_set_deemph(codec);
+	return tas5086_set_deemph(component);
 }
 
 static int tas5086_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct tas5086_private *priv = snd_soc_component_get_drvdata(component);
 	unsigned int val = 0;
 
 	if (mute)
@@ -773,9 +773,9 @@ static struct snd_soc_dai_driver tas5086_dai = {
 };
 
 #ifdef CONFIG_PM
-static int tas5086_soc_suspend(struct snd_soc_codec *codec)
+static int tas5086_soc_suspend(struct snd_soc_component *component)
 {
-	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
+	struct tas5086_private *priv = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	/* Shut down all channels */
@@ -788,9 +788,9 @@ static int tas5086_soc_suspend(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int tas5086_soc_resume(struct snd_soc_codec *codec)
+static int tas5086_soc_resume(struct snd_soc_component *component)
 {
-	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
+	struct tas5086_private *priv = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(priv->supplies), priv->supplies);
@@ -800,7 +800,7 @@ static int tas5086_soc_resume(struct snd_soc_codec *codec)
 	tas5086_reset(priv);
 	regcache_mark_dirty(priv->regmap);
 
-	ret = tas5086_init(codec->dev, priv);
+	ret = tas5086_init(component->dev, priv);
 	if (ret < 0)
 		return ret;
 
@@ -823,22 +823,22 @@ static const struct of_device_id tas5086_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, tas5086_dt_ids);
 #endif
 
-static int tas5086_probe(struct snd_soc_codec *codec)
+static int tas5086_probe(struct snd_soc_component *component)
 {
-	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
+	struct tas5086_private *priv = snd_soc_component_get_drvdata(component);
 	int i, ret;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(priv->supplies), priv->supplies);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to enable regulators: %d\n", ret);
+		dev_err(component->dev, "Failed to enable regulators: %d\n", ret);
 		return ret;
 	}
 
 	priv->pwm_start_mid_z = 0;
 	priv->charge_period = 1300000; /* hardware default is 1300 ms */
 
-	if (of_match_device(of_match_ptr(tas5086_dt_ids), codec->dev)) {
-		struct device_node *of_node = codec->dev->of_node;
+	if (of_match_device(of_match_ptr(tas5086_dt_ids), component->dev)) {
+		struct device_node *of_node = component->dev->of_node;
 
 		of_property_read_u32(of_node, "ti,charge-period",
 				     &priv->charge_period);
@@ -855,7 +855,7 @@ static int tas5086_probe(struct snd_soc_codec *codec)
 	}
 
 	tas5086_reset(priv);
-	ret = tas5086_init(codec->dev, priv);
+	ret = tas5086_init(component->dev, priv);
 	if (ret < 0)
 		goto exit_disable_regulators;
 
@@ -872,32 +872,32 @@ static int tas5086_probe(struct snd_soc_codec *codec)
 	return ret;
 }
 
-static int tas5086_remove(struct snd_soc_codec *codec)
+static void tas5086_remove(struct snd_soc_component *component)
 {
-	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
+	struct tas5086_private *priv = snd_soc_component_get_drvdata(component);
 
 	if (gpio_is_valid(priv->gpio_nreset))
 		/* Set codec to the reset state */
 		gpio_set_value(priv->gpio_nreset, 0);
 
 	regulator_bulk_disable(ARRAY_SIZE(priv->supplies), priv->supplies);
-
-	return 0;
 };
 
-static const struct snd_soc_codec_driver soc_codec_dev_tas5086 = {
+static const struct snd_soc_component_driver soc_component_dev_tas5086 = {
 	.probe			= tas5086_probe,
 	.remove			= tas5086_remove,
 	.suspend		= tas5086_soc_suspend,
 	.resume			= tas5086_soc_resume,
-	.component_driver = {
-		.controls		= tas5086_controls,
-		.num_controls		= ARRAY_SIZE(tas5086_controls),
-		.dapm_widgets		= tas5086_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(tas5086_dapm_widgets),
-		.dapm_routes		= tas5086_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(tas5086_dapm_routes),
-	},
+	.controls		= tas5086_controls,
+	.num_controls		= ARRAY_SIZE(tas5086_controls),
+	.dapm_widgets		= tas5086_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(tas5086_dapm_widgets),
+	.dapm_routes		= tas5086_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(tas5086_dapm_routes),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct i2c_device_id tas5086_i2c_id[] = {
@@ -985,7 +985,8 @@ static int tas5086_i2c_probe(struct i2c_client *i2c,
 	regulator_bulk_disable(ARRAY_SIZE(priv->supplies), priv->supplies);
 
 	if (ret == 0)
-		ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_tas5086,
+		ret = devm_snd_soc_register_component(&i2c->dev,
+					     &soc_component_dev_tas5086,
 					     &tas5086_dai, 1);
 
 	return ret;
@@ -993,7 +994,6 @@ static int tas5086_i2c_probe(struct i2c_client *i2c,
 
 static int tas5086_i2c_remove(struct i2c_client *i2c)
 {
-	snd_soc_unregister_codec(&i2c->dev);
 	return 0;
 }
 
-- 
2.16.1
