From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tfa9879: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:36:16 +0000
Message-ID: <E1elDLE-0003rw-TJ@debutante>
References: <87po5tuvnf.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2694F267A56
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:36:19 +0100 (CET)
In-Reply-To: <87po5tuvnf.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: tfa9879: replace codec to component

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

>From 064f6682f93898d55e6024a536dc1fad3843fa12 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:39:54 +0000
Subject: [PATCH] ASoC: tfa9879: replace codec to component

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
 sound/soc/codecs/tfa9879.c | 50 ++++++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 28 deletions(-)

diff --git a/sound/soc/codecs/tfa9879.c b/sound/soc/codecs/tfa9879.c
index e7ca764b5729..6d213c6d3920 100644
--- a/sound/soc/codecs/tfa9879.c
+++ b/sound/soc/codecs/tfa9879.c
@@ -30,8 +30,8 @@ static int tfa9879_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params,
 			     struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct tfa9879_priv *tfa9879 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct tfa9879_priv *tfa9879 = snd_soc_component_get_drvdata(component);
 	int fs;
 	int i2s_set = 0;
 
@@ -88,11 +88,11 @@ static int tfa9879_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (tfa9879->lsb_justified)
-		snd_soc_update_bits(codec, TFA9879_SERIAL_INTERFACE_1,
+		snd_soc_component_update_bits(component, TFA9879_SERIAL_INTERFACE_1,
 				    TFA9879_I2S_SET_MASK,
 				    i2s_set << TFA9879_I2S_SET_SHIFT);
 
-	snd_soc_update_bits(codec, TFA9879_SERIAL_INTERFACE_1,
+	snd_soc_component_update_bits(component, TFA9879_SERIAL_INTERFACE_1,
 			    TFA9879_I2S_FS_MASK,
 			    fs << TFA9879_I2S_FS_SHIFT);
 	return 0;
@@ -100,9 +100,9 @@ static int tfa9879_hw_params(struct snd_pcm_substream *substream,
 
 static int tfa9879_digital_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 
-	snd_soc_update_bits(codec, TFA9879_MISC_CONTROL,
+	snd_soc_component_update_bits(component, TFA9879_MISC_CONTROL,
 			    TFA9879_S_MUTE_MASK,
 			    !!mute << TFA9879_S_MUTE_SHIFT);
 
@@ -111,8 +111,8 @@ static int tfa9879_digital_mute(struct snd_soc_dai *dai, int mute)
 
 static int tfa9879_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct tfa9879_priv *tfa9879 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct tfa9879_priv *tfa9879 = snd_soc_component_get_drvdata(component);
 	int i2s_set;
 	int sck_pol;
 
@@ -151,10 +151,10 @@ static int tfa9879_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, TFA9879_SERIAL_INTERFACE_1,
+	snd_soc_component_update_bits(component, TFA9879_SERIAL_INTERFACE_1,
 			    TFA9879_SCK_POL_MASK,
 			    sck_pol << TFA9879_SCK_POL_SHIFT);
-	snd_soc_update_bits(codec, TFA9879_SERIAL_INTERFACE_1,
+	snd_soc_component_update_bits(component, TFA9879_SERIAL_INTERFACE_1,
 			    TFA9879_I2S_SET_MASK,
 			    i2s_set << TFA9879_I2S_SET_SHIFT);
 	return 0;
@@ -230,15 +230,17 @@ static const struct snd_soc_dapm_route tfa9879_dapm_routes[] = {
 	{ "DAC", NULL, "POWER" },
 };
 
-static const struct snd_soc_codec_driver tfa9879_codec = {
-	.component_driver = {
-		.controls		= tfa9879_controls,
-		.num_controls		= ARRAY_SIZE(tfa9879_controls),
-		.dapm_widgets		= tfa9879_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(tfa9879_dapm_widgets),
-		.dapm_routes		= tfa9879_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(tfa9879_dapm_routes),
-	},
+static const struct snd_soc_component_driver tfa9879_component = {
+	.controls		= tfa9879_controls,
+	.num_controls		= ARRAY_SIZE(tfa9879_controls),
+	.dapm_widgets		= tfa9879_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(tfa9879_dapm_widgets),
+	.dapm_routes		= tfa9879_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(tfa9879_dapm_routes),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct regmap_config tfa9879_regmap = {
@@ -295,17 +297,10 @@ static int tfa9879_i2c_probe(struct i2c_client *i2c,
 		regmap_write(tfa9879->regmap,
 			     tfa9879_regs[i].reg, tfa9879_regs[i].def);
 
-	return snd_soc_register_codec(&i2c->dev, &tfa9879_codec,
+	return devm_snd_soc_register_component(&i2c->dev, &tfa9879_component,
 				      &tfa9879_dai, 1);
 }
 
-static int tfa9879_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-
-	return 0;
-}
-
 static const struct i2c_device_id tfa9879_i2c_id[] = {
 	{ "tfa9879", 0 },
 	{ }
@@ -324,7 +319,6 @@ static struct i2c_driver tfa9879_i2c_driver = {
 		.of_match_table = tfa9879_of_match,
 	},
 	.probe = tfa9879_i2c_probe,
-	.remove = tfa9879_i2c_remove,
 	.id_table = tfa9879_i2c_id,
 };
 
-- 
2.16.1
