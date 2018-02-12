From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm9867: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:46:24 +0000
Message-ID: <E1elDV2-0005VH-9E@debutante>
References: <87lggh2wdg.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E1FC267DBD
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:46:26 +0100 (CET)
In-Reply-To: <87lggh2wdg.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: wm9867: replace codec to component

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

>From 91880a6b6ba398c74420b4b0d0ef6fc3005f71ca Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:11:46 +0000
Subject: [PATCH] ASoC: wm9867: replace codec to component

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
 sound/soc/codecs/max9867.c | 65 +++++++++++++++++++++-------------------------
 sound/soc/codecs/max9867.h |  2 +-
 2 files changed, 31 insertions(+), 36 deletions(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index 2f60924fe919..a4e8fafb7e6d 100644
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -179,8 +179,8 @@ static inline int get_ni_value(int mclk, int rate)
 static int max9867_dai_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct max9867_priv *max9867 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct max9867_priv *max9867 = snd_soc_component_get_drvdata(component);
 	unsigned int ni_h, ni_l;
 	int value;
 
@@ -227,7 +227,7 @@ static int max9867_dai_hw_params(struct snd_pcm_substream *substream,
 				bclk_value = MAX9867_IFC1B_PCLK_16;
 				break;
 			default:
-				dev_err(codec->dev,
+				dev_err(component->dev,
 					"unsupported sampling rate\n");
 				return -EINVAL;
 			}
@@ -239,7 +239,7 @@ static int max9867_dai_hw_params(struct snd_pcm_substream *substream,
 			bclk_value = MAX9867_IFC1B_32BIT;
 			break;
 		default:
-			dev_err(codec->dev, "unsupported sampling rate\n");
+			dev_err(component->dev, "unsupported sampling rate\n");
 			return -EINVAL;
 		}
 		regmap_update_bits(max9867->regmap, MAX9867_IFC1B,
@@ -251,8 +251,8 @@ static int max9867_dai_hw_params(struct snd_pcm_substream *substream,
 static int max9867_prepare(struct snd_pcm_substream *substream,
 			 struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct max9867_priv *max9867 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct max9867_priv *max9867 = snd_soc_component_get_drvdata(component);
 
 	regmap_update_bits(max9867->regmap, MAX9867_PWRMAN,
 		MAX9867_SHTDOWN_MASK, MAX9867_SHTDOWN_MASK);
@@ -261,8 +261,8 @@ static int max9867_prepare(struct snd_pcm_substream *substream,
 
 static int max9867_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct max9867_priv *max9867 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct max9867_priv *max9867 = snd_soc_component_get_drvdata(component);
 
 	if (mute)
 		regmap_update_bits(max9867->regmap, MAX9867_DACLEVEL,
@@ -276,8 +276,8 @@ static int max9867_mute(struct snd_soc_dai *dai, int mute)
 static int max9867_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct max9867_priv *max9867 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct max9867_priv *max9867 = snd_soc_component_get_drvdata(component);
 	int value = 0;
 
 	/* Set the prescaler based on the master clock frequency*/
@@ -306,8 +306,8 @@ static int max9867_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 static int max9867_dai_set_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct max9867_priv *max9867 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct max9867_priv *max9867 = snd_soc_component_get_drvdata(component);
 	u8 iface1A = 0, iface1B = 0;
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -404,25 +404,27 @@ static int max9867_resume(struct device *dev)
 }
 #endif
 
-static int max9867_probe(struct snd_soc_codec *codec)
+static int max9867_probe(struct snd_soc_component *component)
 {
-	struct max9867_priv *max9867 = snd_soc_codec_get_drvdata(codec);
+	struct max9867_priv *max9867 = snd_soc_component_get_drvdata(component);
 
-	dev_dbg(codec->dev, "max98090_probe\n");
-	max9867->codec = codec;
+	dev_dbg(component->dev, "max98090_probe\n");
+	max9867->component = component;
 	return 0;
 }
 
-static const struct snd_soc_codec_driver max9867_codec = {
-	.probe = max9867_probe,
-	.component_driver = {
-		.controls		= max9867_snd_controls,
-		.num_controls		= ARRAY_SIZE(max9867_snd_controls),
-		.dapm_routes		= max9867_audio_map,
-		.num_dapm_routes	= ARRAY_SIZE(max9867_audio_map),
-		.dapm_widgets		= max9867_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(max9867_dapm_widgets),
-	},
+static const struct snd_soc_component_driver max9867_component = {
+	.probe			= max9867_probe,
+	.controls		= max9867_snd_controls,
+	.num_controls		= ARRAY_SIZE(max9867_snd_controls),
+	.dapm_routes		= max9867_audio_map,
+	.num_dapm_routes	= ARRAY_SIZE(max9867_audio_map),
+	.dapm_widgets		= max9867_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(max9867_dapm_widgets),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static bool max9867_volatile_register(struct device *dev, unsigned int reg)
@@ -497,21 +499,15 @@ static int max9867_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 	dev_info(&i2c->dev, "device revision: %x\n", reg);
-	ret = snd_soc_register_codec(&i2c->dev, &max9867_codec,
+	ret = devm_snd_soc_register_component(&i2c->dev, &max9867_component,
 			max9867_dai, ARRAY_SIZE(max9867_dai));
 	if (ret < 0) {
-		dev_err(&i2c->dev, "Failed to register codec: %d\n", ret);
+		dev_err(&i2c->dev, "Failed to register component: %d\n", ret);
 		return ret;
 	}
 	return ret;
 }
 
-static int max9867_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-	return 0;
-}
-
 static const struct i2c_device_id max9867_i2c_id[] = {
 	{ "max9867", 0 },
 	{ }
@@ -535,7 +531,6 @@ static struct i2c_driver max9867_i2c_driver = {
 		.pm = &max9867_pm_ops,
 	},
 	.probe  = max9867_i2c_probe,
-	.remove = max9867_i2c_remove,
 	.id_table = max9867_i2c_id,
 };
 
diff --git a/sound/soc/codecs/max9867.h b/sound/soc/codecs/max9867.h
index 65590b4ad62a..c0aea3d1f2ba 100644
--- a/sound/soc/codecs/max9867.h
+++ b/sound/soc/codecs/max9867.h
@@ -75,7 +75,7 @@
 /* codec private data */
 struct max9867_priv {
 	struct regmap *regmap;
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 	unsigned int sysclk;
 	unsigned int pclk;
 	unsigned int master;
-- 
2.16.1
