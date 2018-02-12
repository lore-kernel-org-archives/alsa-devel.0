From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max9850: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:41:45 +0000
Message-ID: <E1elDQX-0004tC-Ci@debutante>
References: <87shapz4zr.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C1BDB267C3E
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:41:47 +0100 (CET)
In-Reply-To: <87shapz4zr.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: max9850: replace codec to component

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

>From 0b3eda289c5cf84b7b1a5245812370accece2f19 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:04:34 +0000
Subject: [PATCH] ASoC: max9850: replace codec to component

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
 sound/soc/codecs/max9850.c | 80 +++++++++++++++++++++-------------------------
 1 file changed, 37 insertions(+), 43 deletions(-)

diff --git a/sound/soc/codecs/max9850.c b/sound/soc/codecs/max9850.c
index a3dfc918c278..74d7f52c7e73 100644
--- a/sound/soc/codecs/max9850.c
+++ b/sound/soc/codecs/max9850.c
@@ -130,8 +130,8 @@ static int max9850_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params,
 			     struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct max9850_priv *max9850 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct max9850_priv *max9850 = snd_soc_component_get_drvdata(component);
 	u64 lrclk_div;
 	u8 sf, da;
 
@@ -139,14 +139,14 @@ static int max9850_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 
 	/* lrclk_div = 2^22 * rate / iclk with iclk = mclk / sf */
-	sf = (snd_soc_read(codec, MAX9850_CLOCK) >> 2) + 1;
+	sf = (snd_soc_component_read32(component, MAX9850_CLOCK) >> 2) + 1;
 	lrclk_div = (1 << 22);
 	lrclk_div *= params_rate(params);
 	lrclk_div *= sf;
 	do_div(lrclk_div, max9850->sysclk);
 
-	snd_soc_write(codec, MAX9850_LRCLK_MSB, (lrclk_div >> 8) & 0x7f);
-	snd_soc_write(codec, MAX9850_LRCLK_LSB, lrclk_div & 0xff);
+	snd_soc_component_write(component, MAX9850_LRCLK_MSB, (lrclk_div >> 8) & 0x7f);
+	snd_soc_component_write(component, MAX9850_LRCLK_LSB, lrclk_div & 0xff);
 
 	switch (params_width(params)) {
 	case 16:
@@ -161,7 +161,7 @@ static int max9850_hw_params(struct snd_pcm_substream *substream,
 	default:
 		return -EINVAL;
 	}
-	snd_soc_update_bits(codec, MAX9850_DIGITAL_AUDIO, 0x3, da);
+	snd_soc_component_update_bits(component, MAX9850_DIGITAL_AUDIO, 0x3, da);
 
 	return 0;
 }
@@ -169,16 +169,16 @@ static int max9850_hw_params(struct snd_pcm_substream *substream,
 static int max9850_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct max9850_priv *max9850 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct max9850_priv *max9850 = snd_soc_component_get_drvdata(component);
 
 	/* calculate mclk -> iclk divider */
 	if (freq <= 13000000)
-		snd_soc_write(codec, MAX9850_CLOCK, 0x0);
+		snd_soc_component_write(component, MAX9850_CLOCK, 0x0);
 	else if (freq <= 26000000)
-		snd_soc_write(codec, MAX9850_CLOCK, 0x4);
+		snd_soc_component_write(component, MAX9850_CLOCK, 0x4);
 	else if (freq <= 40000000)
-		snd_soc_write(codec, MAX9850_CLOCK, 0x8);
+		snd_soc_component_write(component, MAX9850_CLOCK, 0x8);
 	else
 		return -EINVAL;
 
@@ -188,7 +188,7 @@ static int max9850_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 
 static int max9850_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 	u8 da = 0;
 
 	/* set master/slave audio interface */
@@ -234,15 +234,15 @@ static int max9850_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	}
 
 	/* set da */
-	snd_soc_write(codec, MAX9850_DIGITAL_AUDIO, da);
+	snd_soc_component_write(component, MAX9850_DIGITAL_AUDIO, da);
 
 	return 0;
 }
 
-static int max9850_set_bias_level(struct snd_soc_codec *codec,
+static int max9850_set_bias_level(struct snd_soc_component *component,
 				  enum snd_soc_bias_level level)
 {
-	struct max9850_priv *max9850 = snd_soc_codec_get_drvdata(codec);
+	struct max9850_priv *max9850 = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	switch (level) {
@@ -251,10 +251,10 @@ static int max9850_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
 			ret = regcache_sync(max9850->regmap);
 			if (ret) {
-				dev_err(codec->dev,
+				dev_err(component->dev,
 					"Failed to sync cache: %d\n", ret);
 				return ret;
 			}
@@ -289,31 +289,32 @@ static struct snd_soc_dai_driver max9850_dai = {
 	.ops = &max9850_dai_ops,
 };
 
-static int max9850_probe(struct snd_soc_codec *codec)
+static int max9850_probe(struct snd_soc_component *component)
 {
 	/* enable zero-detect */
-	snd_soc_update_bits(codec, MAX9850_GENERAL_PURPOSE, 1, 1);
+	snd_soc_component_update_bits(component, MAX9850_GENERAL_PURPOSE, 1, 1);
 	/* enable slew-rate control */
-	snd_soc_update_bits(codec, MAX9850_VOLUME, 0x40, 0x40);
+	snd_soc_component_update_bits(component, MAX9850_VOLUME, 0x40, 0x40);
 	/* set slew-rate 125ms */
-	snd_soc_update_bits(codec, MAX9850_CHARGE_PUMP, 0xff, 0xc0);
+	snd_soc_component_update_bits(component, MAX9850_CHARGE_PUMP, 0xff, 0xc0);
 
 	return 0;
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_max9850 = {
-	.probe =	max9850_probe,
-	.set_bias_level = max9850_set_bias_level,
-	.suspend_bias_off = true,
-
-	.component_driver = {
-		.controls		= max9850_controls,
-		.num_controls		= ARRAY_SIZE(max9850_controls),
-		.dapm_widgets		= max9850_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(max9850_dapm_widgets),
-		.dapm_routes		= max9850_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(max9850_dapm_routes),
-	},
+static const struct snd_soc_component_driver soc_component_dev_max9850 = {
+	.probe			= max9850_probe,
+	.set_bias_level		= max9850_set_bias_level,
+	.controls		= max9850_controls,
+	.num_controls		= ARRAY_SIZE(max9850_controls),
+	.dapm_widgets		= max9850_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(max9850_dapm_widgets),
+	.dapm_routes		= max9850_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(max9850_dapm_routes),
+	.suspend_bias_off	= 1,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static int max9850_i2c_probe(struct i2c_client *i2c,
@@ -333,17 +334,11 @@ static int max9850_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, max9850);
 
-	ret = snd_soc_register_codec(&i2c->dev,
-			&soc_codec_dev_max9850, &max9850_dai, 1);
+	ret = devm_snd_soc_register_component(&i2c->dev,
+			&soc_component_dev_max9850, &max9850_dai, 1);
 	return ret;
 }
 
-static int max9850_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-	return 0;
-}
-
 static const struct i2c_device_id max9850_i2c_id[] = {
 	{ "max9850", 0 },
 	{ }
@@ -355,7 +350,6 @@ static struct i2c_driver max9850_i2c_driver = {
 		.name = "max9850",
 	},
 	.probe = max9850_i2c_probe,
-	.remove = max9850_i2c_remove,
 	.id_table = max9850_i2c_id,
 };
 
-- 
2.16.1
