From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm1681: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:39:29 +0000
Message-ID: <E1elDOL-0004Wz-6W@debutante>
References: <87r2q9xpsk.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BB44267B44
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:39:31 +0100 (CET)
In-Reply-To: <87r2q9xpsk.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: pcm1681: replace codec to component

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

>From 7dbbaa5180cb380ac28f023dda8663d8dd3b8b56 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:18:12 +0000
Subject: [PATCH] ASoC: pcm1681: replace codec to component

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
 sound/soc/codecs/pcm1681.c | 62 ++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 33 deletions(-)

diff --git a/sound/soc/codecs/pcm1681.c b/sound/soc/codecs/pcm1681.c
index c7e28dd2e815..84777d3fa464 100644
--- a/sound/soc/codecs/pcm1681.c
+++ b/sound/soc/codecs/pcm1681.c
@@ -90,9 +90,9 @@ struct pcm1681_private {
 
 static const int pcm1681_deemph[] = { 44100, 48000, 32000 };
 
-static int pcm1681_set_deemph(struct snd_soc_codec *codec)
+static int pcm1681_set_deemph(struct snd_soc_component *component)
 {
-	struct pcm1681_private *priv = snd_soc_codec_get_drvdata(codec);
+	struct pcm1681_private *priv = snd_soc_component_get_drvdata(component);
 	int i = 0, val = -1, enable = 0;
 
 	if (priv->deemph) {
@@ -120,8 +120,8 @@ static int pcm1681_set_deemph(struct snd_soc_codec *codec)
 static int pcm1681_get_deemph(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct pcm1681_private *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct pcm1681_private *priv = snd_soc_component_get_drvdata(component);
 
 	ucontrol->value.integer.value[0] = priv->deemph;
 
@@ -131,23 +131,23 @@ static int pcm1681_get_deemph(struct snd_kcontrol *kcontrol,
 static int pcm1681_put_deemph(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct pcm1681_private *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct pcm1681_private *priv = snd_soc_component_get_drvdata(component);
 
 	priv->deemph = ucontrol->value.integer.value[0];
 
-	return pcm1681_set_deemph(codec);
+	return pcm1681_set_deemph(component);
 }
 
 static int pcm1681_set_dai_fmt(struct snd_soc_dai *codec_dai,
 			      unsigned int format)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct pcm1681_private *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct pcm1681_private *priv = snd_soc_component_get_drvdata(component);
 
 	/* The PCM1681 can only be slave to all clocks */
 	if ((format & SND_SOC_DAIFMT_MASTER_MASK) != SND_SOC_DAIFMT_CBS_CFS) {
-		dev_err(codec->dev, "Invalid clocking mode\n");
+		dev_err(component->dev, "Invalid clocking mode\n");
 		return -EINVAL;
 	}
 
@@ -158,8 +158,8 @@ static int pcm1681_set_dai_fmt(struct snd_soc_dai *codec_dai,
 
 static int pcm1681_digital_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct pcm1681_private *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct pcm1681_private *priv = snd_soc_component_get_drvdata(component);
 	int val;
 
 	if (mute)
@@ -174,8 +174,8 @@ static int pcm1681_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params,
 			     struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct pcm1681_private *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct pcm1681_private *priv = snd_soc_component_get_drvdata(component);
 	int val = 0, ret;
 
 	priv->rate = params_rate(params);
@@ -200,7 +200,7 @@ static int pcm1681_hw_params(struct snd_pcm_substream *substream,
 		val = 0x05;
 		break;
 	default:
-		dev_err(codec->dev, "Invalid DAI format\n");
+		dev_err(component->dev, "Invalid DAI format\n");
 		return -EINVAL;
 	}
 
@@ -208,7 +208,7 @@ static int pcm1681_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
-	return pcm1681_set_deemph(codec);
+	return pcm1681_set_deemph(component);
 }
 
 static const struct snd_soc_dai_ops pcm1681_dai_ops = {
@@ -288,15 +288,17 @@ static const struct regmap_config pcm1681_regmap = {
 	.readable_reg		= pcm1681_accessible_reg,
 };
 
-static const struct snd_soc_codec_driver soc_codec_dev_pcm1681 = {
-	.component_driver = {
-		.controls		= pcm1681_controls,
-		.num_controls		= ARRAY_SIZE(pcm1681_controls),
-		.dapm_widgets		= pcm1681_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(pcm1681_dapm_widgets),
-		.dapm_routes		= pcm1681_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(pcm1681_dapm_routes),
-	},
+static const struct snd_soc_component_driver soc_component_dev_pcm1681 = {
+	.controls		= pcm1681_controls,
+	.num_controls		= ARRAY_SIZE(pcm1681_controls),
+	.dapm_widgets		= pcm1681_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(pcm1681_dapm_widgets),
+	.dapm_routes		= pcm1681_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(pcm1681_dapm_routes),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct i2c_device_id pcm1681_i2c_id[] = {
@@ -324,16 +326,11 @@ static int pcm1681_i2c_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, priv);
 
-	return snd_soc_register_codec(&client->dev, &soc_codec_dev_pcm1681,
+	return devm_snd_soc_register_component(&client->dev,
+		&soc_component_dev_pcm1681,
 		&pcm1681_dai, 1);
 }
 
-static int pcm1681_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-	return 0;
-}
-
 static struct i2c_driver pcm1681_i2c_driver = {
 	.driver = {
 		.name	= "pcm1681",
@@ -341,7 +338,6 @@ static struct i2c_driver pcm1681_i2c_driver = {
 	},
 	.id_table	= pcm1681_i2c_id,
 	.probe		= pcm1681_i2c_probe,
-	.remove		= pcm1681_i2c_remove,
 };
 
 module_i2c_driver(pcm1681_i2c_driver);
-- 
2.16.1
