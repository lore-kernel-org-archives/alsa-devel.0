From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8523: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:50:54 +0000
Message-ID: <E1elDZO-0006JA-J2@debutante>
References: <871si95q00.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 19D56268066
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:50:56 +0100 (CET)
In-Reply-To: <871si95q00.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: wm8523: replace codec to component

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

>From 4bf8ae8356c982847ef5bd5f613b87311f9024ec Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:01:09 +0000
Subject: [PATCH] ASoC: wm8523: replace codec to component

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
 sound/soc/codecs/wm8523.c | 98 ++++++++++++++++++++++-------------------------
 1 file changed, 46 insertions(+), 52 deletions(-)

diff --git a/sound/soc/codecs/wm8523.c b/sound/soc/codecs/wm8523.c
index c7c33e98fbcb..f4a9e25fb334 100644
--- a/sound/soc/codecs/wm8523.c
+++ b/sound/soc/codecs/wm8523.c
@@ -125,14 +125,14 @@ static const struct {
 static int wm8523_startup(struct snd_pcm_substream *substream,
 			  struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm8523_priv *wm8523 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct wm8523_priv *wm8523 = snd_soc_component_get_drvdata(component);
 
 	/* The set of sample rates that can be supported depends on the
 	 * MCLK supplied to the CODEC - enforce this.
 	 */
 	if (!wm8523->sysclk) {
-		dev_err(codec->dev,
+		dev_err(component->dev,
 			"No MCLK configured, call set_sysclk() on init\n");
 		return -EINVAL;
 	}
@@ -148,11 +148,11 @@ static int wm8523_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm8523_priv *wm8523 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct wm8523_priv *wm8523 = snd_soc_component_get_drvdata(component);
 	int i;
-	u16 aifctrl1 = snd_soc_read(codec, WM8523_AIF_CTRL1);
-	u16 aifctrl2 = snd_soc_read(codec, WM8523_AIF_CTRL2);
+	u16 aifctrl1 = snd_soc_component_read32(component, WM8523_AIF_CTRL1);
+	u16 aifctrl2 = snd_soc_component_read32(component, WM8523_AIF_CTRL2);
 
 	/* Find a supported LRCLK ratio */
 	for (i = 0; i < ARRAY_SIZE(lrclk_ratios); i++) {
@@ -163,7 +163,7 @@ static int wm8523_hw_params(struct snd_pcm_substream *substream,
 
 	/* Should never happen, should be handled by constraints */
 	if (i == ARRAY_SIZE(lrclk_ratios)) {
-		dev_err(codec->dev, "MCLK/fs ratio %d unsupported\n",
+		dev_err(component->dev, "MCLK/fs ratio %d unsupported\n",
 			wm8523->sysclk / params_rate(params));
 		return -EINVAL;
 	}
@@ -178,7 +178,7 @@ static int wm8523_hw_params(struct snd_pcm_substream *substream,
 				break;
 
 		if (i == ARRAY_SIZE(bclk_ratios)) {
-			dev_err(codec->dev,
+			dev_err(component->dev,
 				"No matching BCLK/fs ratio for word length %d\n",
 				params_width(params));
 			return -EINVAL;
@@ -203,8 +203,8 @@ static int wm8523_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	snd_soc_write(codec, WM8523_AIF_CTRL1, aifctrl1);
-	snd_soc_write(codec, WM8523_AIF_CTRL2, aifctrl2);
+	snd_soc_component_write(component, WM8523_AIF_CTRL1, aifctrl1);
+	snd_soc_component_write(component, WM8523_AIF_CTRL2, aifctrl2);
 
 	return 0;
 }
@@ -212,8 +212,8 @@ static int wm8523_hw_params(struct snd_pcm_substream *substream,
 static int wm8523_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct wm8523_priv *wm8523 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct wm8523_priv *wm8523 = snd_soc_component_get_drvdata(component);
 	unsigned int val;
 	int i;
 
@@ -239,13 +239,13 @@ static int wm8523_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		case 96000:
 		case 176400:
 		case 192000:
-			dev_dbg(codec->dev, "Supported sample rate: %dHz\n",
+			dev_dbg(component->dev, "Supported sample rate: %dHz\n",
 				val);
 			wm8523->rate_constraint_list[i] = val;
 			wm8523->rate_constraint.count++;
 			break;
 		default:
-			dev_dbg(codec->dev, "Skipping sample rate: %dHz\n",
+			dev_dbg(component->dev, "Skipping sample rate: %dHz\n",
 				val);
 		}
 	}
@@ -261,8 +261,8 @@ static int wm8523_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 static int wm8523_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	u16 aifctrl1 = snd_soc_read(codec, WM8523_AIF_CTRL1);
+	struct snd_soc_component *component = codec_dai->component;
+	u16 aifctrl1 = snd_soc_component_read32(component, WM8523_AIF_CTRL1);
 
 	aifctrl1 &= ~(WM8523_BCLK_INV_MASK | WM8523_LRCLK_INV_MASK |
 		      WM8523_FMT_MASK | WM8523_AIF_MSTR_MASK);
@@ -312,15 +312,15 @@ static int wm8523_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	snd_soc_write(codec, WM8523_AIF_CTRL1, aifctrl1);
+	snd_soc_component_write(component, WM8523_AIF_CTRL1, aifctrl1);
 
 	return 0;
 }
 
-static int wm8523_set_bias_level(struct snd_soc_codec *codec,
+static int wm8523_set_bias_level(struct snd_soc_component *component,
 				 enum snd_soc_bias_level level)
 {
-	struct wm8523_priv *wm8523 = snd_soc_codec_get_drvdata(codec);
+	struct wm8523_priv *wm8523 = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	switch (level) {
@@ -329,16 +329,16 @@ static int wm8523_set_bias_level(struct snd_soc_codec *codec,
 
 	case SND_SOC_BIAS_PREPARE:
 		/* Full power on */
-		snd_soc_update_bits(codec, WM8523_PSCTRL1,
+		snd_soc_component_update_bits(component, WM8523_PSCTRL1,
 				    WM8523_SYS_ENA_MASK, 3);
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
 			ret = regulator_bulk_enable(ARRAY_SIZE(wm8523->supplies),
 						    wm8523->supplies);
 			if (ret != 0) {
-				dev_err(codec->dev,
+				dev_err(component->dev,
 					"Failed to enable supplies: %d\n",
 					ret);
 				return ret;
@@ -348,21 +348,21 @@ static int wm8523_set_bias_level(struct snd_soc_codec *codec,
 			regcache_sync(wm8523->regmap);
 
 			/* Initial power up */
-			snd_soc_update_bits(codec, WM8523_PSCTRL1,
+			snd_soc_component_update_bits(component, WM8523_PSCTRL1,
 					    WM8523_SYS_ENA_MASK, 1);
 
 			msleep(100);
 		}
 
 		/* Power up to mute */
-		snd_soc_update_bits(codec, WM8523_PSCTRL1,
+		snd_soc_component_update_bits(component, WM8523_PSCTRL1,
 				    WM8523_SYS_ENA_MASK, 2);
 
 		break;
 
 	case SND_SOC_BIAS_OFF:
 		/* The chip runs through the power down sequence for us. */
-		snd_soc_update_bits(codec, WM8523_PSCTRL1,
+		snd_soc_component_update_bits(component, WM8523_PSCTRL1,
 				    WM8523_SYS_ENA_MASK, 0);
 		msleep(100);
 
@@ -397,35 +397,36 @@ static struct snd_soc_dai_driver wm8523_dai = {
 	.ops = &wm8523_dai_ops,
 };
 
-static int wm8523_probe(struct snd_soc_codec *codec)
+static int wm8523_probe(struct snd_soc_component *component)
 {
-	struct wm8523_priv *wm8523 = snd_soc_codec_get_drvdata(codec);
+	struct wm8523_priv *wm8523 = snd_soc_component_get_drvdata(component);
 
 	wm8523->rate_constraint.list = &wm8523->rate_constraint_list[0];
 	wm8523->rate_constraint.count =
 		ARRAY_SIZE(wm8523->rate_constraint_list);
 
 	/* Change some default settings - latch VU and enable ZC */
-	snd_soc_update_bits(codec, WM8523_DAC_GAINR,
+	snd_soc_component_update_bits(component, WM8523_DAC_GAINR,
 			    WM8523_DACR_VU, WM8523_DACR_VU);
-	snd_soc_update_bits(codec, WM8523_DAC_CTRL3, WM8523_ZC, WM8523_ZC);
+	snd_soc_component_update_bits(component, WM8523_DAC_CTRL3, WM8523_ZC, WM8523_ZC);
 
 	return 0;
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_wm8523 = {
-	.probe =	wm8523_probe,
-	.set_bias_level = wm8523_set_bias_level,
-	.suspend_bias_off = true,
-
-	.component_driver = {
-		.controls		= wm8523_controls,
-		.num_controls		= ARRAY_SIZE(wm8523_controls),
-		.dapm_widgets		= wm8523_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(wm8523_dapm_widgets),
-		.dapm_routes		= wm8523_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(wm8523_dapm_routes),
-	},
+static const struct snd_soc_component_driver soc_component_dev_wm8523 = {
+	.probe			= wm8523_probe,
+	.set_bias_level		= wm8523_set_bias_level,
+	.controls		= wm8523_controls,
+	.num_controls		= ARRAY_SIZE(wm8523_controls),
+	.dapm_widgets		= wm8523_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(wm8523_dapm_widgets),
+	.dapm_routes		= wm8523_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(wm8523_dapm_routes),
+	.suspend_bias_off	= 1,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct of_device_id wm8523_of_match[] = {
@@ -511,8 +512,8 @@ static int wm8523_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, wm8523);
 
-	ret =  snd_soc_register_codec(&i2c->dev,
-			&soc_codec_dev_wm8523, &wm8523_dai, 1);
+	ret = devm_snd_soc_register_component(&i2c->dev,
+			&soc_component_dev_wm8523, &wm8523_dai, 1);
 
 	return ret;
 
@@ -521,12 +522,6 @@ static int wm8523_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static int wm8523_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-	return 0;
-}
-
 static const struct i2c_device_id wm8523_i2c_id[] = {
 	{ "wm8523", 0 },
 	{ }
@@ -539,7 +534,6 @@ static struct i2c_driver wm8523_i2c_driver = {
 		.of_match_table = wm8523_of_match,
 	},
 	.probe =    wm8523_i2c_probe,
-	.remove =   wm8523_i2c_remove,
 	.id_table = wm8523_i2c_id,
 };
 
-- 
2.16.1
