From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ak4613: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:46:14 +0000
Message-ID: <E1elDUs-0005Tb-HR@debutante>
References: <87h8r52wc0.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B944E267D64
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:46:16 +0100 (CET)
In-Reply-To: <87h8r52wc0.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: ak4613: replace codec to component

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

>From 9123ea9ff5bcdfdb89f7ad6f8efc56f2ca55a071 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:12:39 +0000
Subject: [PATCH] ASoC: ak4613: replace codec to component

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
 sound/soc/codecs/ak4613.c | 73 ++++++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 36 deletions(-)

diff --git a/sound/soc/codecs/ak4613.c b/sound/soc/codecs/ak4613.c
index 3d1cf4784e87..a7b1e3a1ec58 100644
--- a/sound/soc/codecs/ak4613.c
+++ b/sound/soc/codecs/ak4613.c
@@ -243,9 +243,9 @@ static const struct snd_soc_dapm_route ak4613_intercon[] = {
 static void ak4613_dai_shutdown(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct ak4613_priv *priv = snd_soc_codec_get_drvdata(codec);
-	struct device *dev = codec->dev;
+	struct snd_soc_component *component = dai->component;
+	struct ak4613_priv *priv = snd_soc_component_get_drvdata(component);
+	struct device *dev = component->dev;
 
 	mutex_lock(&priv->lock);
 	priv->cnt--;
@@ -305,8 +305,8 @@ static void ak4613_hw_constraints(struct ak4613_priv *priv,
 static int ak4613_dai_startup(struct snd_pcm_substream *substream,
 			      struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct ak4613_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct ak4613_priv *priv = snd_soc_component_get_drvdata(component);
 
 	priv->cnt++;
 
@@ -318,8 +318,8 @@ static int ak4613_dai_startup(struct snd_pcm_substream *substream,
 static int ak4613_dai_set_sysclk(struct snd_soc_dai *codec_dai,
 				 int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct ak4613_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct ak4613_priv *priv = snd_soc_component_get_drvdata(component);
 
 	priv->sysclk = freq;
 
@@ -328,8 +328,8 @@ static int ak4613_dai_set_sysclk(struct snd_soc_dai *codec_dai,
 
 static int ak4613_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct ak4613_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct ak4613_priv *priv = snd_soc_component_get_drvdata(component);
 
 	fmt &= SND_SOC_DAIFMT_FORMAT_MASK;
 
@@ -366,10 +366,10 @@ static int ak4613_dai_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct ak4613_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct ak4613_priv *priv = snd_soc_component_get_drvdata(component);
 	const struct ak4613_interface *iface;
-	struct device *dev = codec->dev;
+	struct device *dev = component->dev;
 	unsigned int width = params_width(params);
 	unsigned int fmt = priv->fmt;
 	unsigned int rate;
@@ -434,11 +434,11 @@ static int ak4613_dai_hw_params(struct snd_pcm_substream *substream,
 
 	fmt_ctrl = AUDIO_IFACE_TO_VAL(iface);
 
-	snd_soc_update_bits(codec, CTRL1, FMT_MASK, fmt_ctrl);
-	snd_soc_update_bits(codec, CTRL2, DFS_MASK, ctrl2);
+	snd_soc_component_update_bits(component, CTRL1, FMT_MASK, fmt_ctrl);
+	snd_soc_component_update_bits(component, CTRL2, DFS_MASK, ctrl2);
 
-	snd_soc_update_bits(codec, ICTRL, ICTRL_MASK, priv->ic);
-	snd_soc_update_bits(codec, OCTRL, OCTRL_MASK, priv->oc);
+	snd_soc_component_update_bits(component, ICTRL, ICTRL_MASK, priv->ic);
+	snd_soc_component_update_bits(component, OCTRL, OCTRL_MASK, priv->oc);
 
 hw_params_end:
 	if (ret < 0)
@@ -447,7 +447,7 @@ static int ak4613_dai_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static int ak4613_set_bias_level(struct snd_soc_codec *codec,
+static int ak4613_set_bias_level(struct snd_soc_component *component,
 				 enum snd_soc_bias_level level)
 {
 	u8 mgmt1 = 0;
@@ -467,7 +467,7 @@ static int ak4613_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	}
 
-	snd_soc_write(codec, PW_MGMT1, mgmt1);
+	snd_soc_component_write(component, PW_MGMT1, mgmt1);
 
 	return 0;
 }
@@ -504,8 +504,8 @@ static void ak4613_dummy_write(struct work_struct *work)
 static int ak4613_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 			      struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct ak4613_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct ak4613_priv *priv = snd_soc_component_get_drvdata(component);
 
 	/*
 	 * FIXME
@@ -537,7 +537,7 @@ static int ak4613_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
 		return  0;
 
-	priv->component = &codec->component;
+	priv->component = component;
 	schedule_work(&priv->dummy_write_work);
 
 	return 0;
@@ -582,35 +582,37 @@ static struct snd_soc_dai_driver ak4613_dai = {
 	.symmetric_rates = 1,
 };
 
-static int ak4613_suspend(struct snd_soc_codec *codec)
+static int ak4613_suspend(struct snd_soc_component *component)
 {
-	struct regmap *regmap = dev_get_regmap(codec->dev, NULL);
+	struct regmap *regmap = dev_get_regmap(component->dev, NULL);
 
 	regcache_cache_only(regmap, true);
 	regcache_mark_dirty(regmap);
 	return 0;
 }
 
-static int ak4613_resume(struct snd_soc_codec *codec)
+static int ak4613_resume(struct snd_soc_component *component)
 {
-	struct regmap *regmap = dev_get_regmap(codec->dev, NULL);
+	struct regmap *regmap = dev_get_regmap(component->dev, NULL);
 
 	regcache_cache_only(regmap, false);
 	return regcache_sync(regmap);
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_ak4613 = {
+static const struct snd_soc_component_driver soc_component_dev_ak4613 = {
 	.suspend		= ak4613_suspend,
 	.resume			= ak4613_resume,
 	.set_bias_level		= ak4613_set_bias_level,
-	.component_driver = {
-		.controls		= ak4613_snd_controls,
-		.num_controls		= ARRAY_SIZE(ak4613_snd_controls),
-		.dapm_widgets		= ak4613_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(ak4613_dapm_widgets),
-		.dapm_routes		= ak4613_intercon,
-		.num_dapm_routes	= ARRAY_SIZE(ak4613_intercon),
-	},
+	.controls		= ak4613_snd_controls,
+	.num_controls		= ARRAY_SIZE(ak4613_snd_controls),
+	.dapm_widgets		= ak4613_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(ak4613_dapm_widgets),
+	.dapm_routes		= ak4613_intercon,
+	.num_dapm_routes	= ARRAY_SIZE(ak4613_intercon),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static void ak4613_parse_of(struct ak4613_priv *priv,
@@ -677,13 +679,12 @@ static int ak4613_i2c_probe(struct i2c_client *i2c,
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	return snd_soc_register_codec(dev, &soc_codec_dev_ak4613,
+	return devm_snd_soc_register_component(dev, &soc_component_dev_ak4613,
 				      &ak4613_dai, 1);
 }
 
 static int ak4613_i2c_remove(struct i2c_client *client)
 {
-	snd_soc_unregister_codec(&client->dev);
 	return 0;
 }
 
-- 
2.16.1
