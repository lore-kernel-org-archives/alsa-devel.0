From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8971: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:48:00 +0000
Message-ID: <E1elDWa-0005pl-Ib@debutante>
References: <87bmhd4b6w.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 164D1267EA4
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:48:03 +0100 (CET)
In-Reply-To: <87bmhd4b6w.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: wm8971: replace codec to component

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

>From 58a6597ea0e6f310e568c0db6224b586a5bf7c7c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:06:22 +0000
Subject: [PATCH] ASoC: wm8971: replace codec to component

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
 sound/soc/codecs/wm8971.c | 108 ++++++++++++++++++++++------------------------
 1 file changed, 51 insertions(+), 57 deletions(-)

diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
index 887d31cf3945..a79f7a7ab44b 100644
--- a/sound/soc/codecs/wm8971.c
+++ b/sound/soc/codecs/wm8971.c
@@ -89,7 +89,7 @@ static const struct reg_default wm8971_reg_defaults[] = {
 	{ 42, 0x0079 },
 };
 
-#define wm8971_reset(c)	snd_soc_write(c, WM8971_RESET, 0)
+#define wm8971_reset(c)	snd_soc_component_write(c, WM8971_RESET, 0)
 
 /* WM8971 Controls */
 static const char *wm8971_bass[] = { "Linear Control", "Adaptive Boost" };
@@ -433,8 +433,8 @@ static int get_coeff(int mclk, int rate)
 static int wm8971_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct wm8971_priv *wm8971 = snd_soc_component_get_drvdata(component);
 
 	switch (freq) {
 	case 11289600:
@@ -451,7 +451,7 @@ static int wm8971_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 static int wm8971_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 	u16 iface = 0;
 
 	/* set master/slave audio interface */
@@ -502,7 +502,7 @@ static int wm8971_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	snd_soc_write(codec, WM8971_IFACE, iface);
+	snd_soc_component_write(component, WM8971_IFACE, iface);
 	return 0;
 }
 
@@ -510,10 +510,10 @@ static int wm8971_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params,
 	struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
-	u16 iface = snd_soc_read(codec, WM8971_IFACE) & 0x1f3;
-	u16 srate = snd_soc_read(codec, WM8971_SRATE) & 0x1c0;
+	struct snd_soc_component *component = dai->component;
+	struct wm8971_priv *wm8971 = snd_soc_component_get_drvdata(component);
+	u16 iface = snd_soc_component_read32(component, WM8971_IFACE) & 0x1f3;
+	u16 srate = snd_soc_component_read32(component, WM8971_SRATE) & 0x1c0;
 	int coeff = get_coeff(wm8971->sysclk, params_rate(params));
 
 	/* bit size */
@@ -532,9 +532,9 @@ static int wm8971_pcm_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* set iface & srate */
-	snd_soc_write(codec, WM8971_IFACE, iface);
+	snd_soc_component_write(component, WM8971_IFACE, iface);
 	if (coeff >= 0)
-		snd_soc_write(codec, WM8971_SRATE, srate |
+		snd_soc_component_write(component, WM8971_SRATE, srate |
 			(coeff_div[coeff].sr << 1) | coeff_div[coeff].usb);
 
 	return 0;
@@ -542,13 +542,13 @@ static int wm8971_pcm_hw_params(struct snd_pcm_substream *substream,
 
 static int wm8971_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	u16 mute_reg = snd_soc_read(codec, WM8971_ADCDAC) & 0xfff7;
+	struct snd_soc_component *component = dai->component;
+	u16 mute_reg = snd_soc_component_read32(component, WM8971_ADCDAC) & 0xfff7;
 
 	if (mute)
-		snd_soc_write(codec, WM8971_ADCDAC, mute_reg | 0x8);
+		snd_soc_component_write(component, WM8971_ADCDAC, mute_reg | 0x8);
 	else
-		snd_soc_write(codec, WM8971_ADCDAC, mute_reg);
+		snd_soc_component_write(component, WM8971_ADCDAC, mute_reg);
 	return 0;
 }
 
@@ -561,37 +561,37 @@ static void wm8971_charge_work(struct work_struct *work)
 	regmap_update_bits(wm8971->regmap, WM8971_PWR1, 0x0180, 0x0100);
 }
 
-static int wm8971_set_bias_level(struct snd_soc_codec *codec,
+static int wm8971_set_bias_level(struct snd_soc_component *component,
 	enum snd_soc_bias_level level)
 {
-	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
-	u16 pwr_reg = snd_soc_read(codec, WM8971_PWR1) & 0xfe3e;
+	struct wm8971_priv *wm8971 = snd_soc_component_get_drvdata(component);
+	u16 pwr_reg = snd_soc_component_read32(component, WM8971_PWR1) & 0xfe3e;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		/* set vmid to 50k and unmute dac */
-		snd_soc_write(codec, WM8971_PWR1, pwr_reg | 0x00c1);
+		snd_soc_component_write(component, WM8971_PWR1, pwr_reg | 0x00c1);
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		/* Wait until fully charged */
 		flush_delayed_work(&wm8971->charge_work);
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
-			snd_soc_cache_sync(codec);
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
+			snd_soc_component_cache_sync(component);
 			/* charge output caps - set vmid to 5k for quick power up */
-			snd_soc_write(codec, WM8971_PWR1, pwr_reg | 0x01c0);
+			snd_soc_component_write(component, WM8971_PWR1, pwr_reg | 0x01c0);
 			queue_delayed_work(system_power_efficient_wq,
 				&wm8971->charge_work, msecs_to_jiffies(1000));
 		} else {
 			/* mute dac and set vmid to 500k, enable VREF */
-			snd_soc_write(codec, WM8971_PWR1, pwr_reg | 0x0140);
+			snd_soc_component_write(component, WM8971_PWR1, pwr_reg | 0x0140);
 		}
 
 		break;
 	case SND_SOC_BIAS_OFF:
 		cancel_delayed_work_sync(&wm8971->charge_work);
-		snd_soc_write(codec, WM8971_PWR1, 0x0001);
+		snd_soc_component_write(component, WM8971_PWR1, 0x0001);
 		break;
 	}
 	return 0;
@@ -628,40 +628,41 @@ static struct snd_soc_dai_driver wm8971_dai = {
 	.ops = &wm8971_dai_ops,
 };
 
-static int wm8971_probe(struct snd_soc_codec *codec)
+static int wm8971_probe(struct snd_soc_component *component)
 {
-	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
+	struct wm8971_priv *wm8971 = snd_soc_component_get_drvdata(component);
 
 	INIT_DELAYED_WORK(&wm8971->charge_work, wm8971_charge_work);
 
-	wm8971_reset(codec);
+	wm8971_reset(component);
 
 	/* set the update bits */
-	snd_soc_update_bits(codec, WM8971_LDAC, 0x0100, 0x0100);
-	snd_soc_update_bits(codec, WM8971_RDAC, 0x0100, 0x0100);
-	snd_soc_update_bits(codec, WM8971_LOUT1V, 0x0100, 0x0100);
-	snd_soc_update_bits(codec, WM8971_ROUT1V, 0x0100, 0x0100);
-	snd_soc_update_bits(codec, WM8971_LOUT2V, 0x0100, 0x0100);
-	snd_soc_update_bits(codec, WM8971_ROUT2V, 0x0100, 0x0100);
-	snd_soc_update_bits(codec, WM8971_LINVOL, 0x0100, 0x0100);
-	snd_soc_update_bits(codec, WM8971_RINVOL, 0x0100, 0x0100);
+	snd_soc_component_update_bits(component, WM8971_LDAC, 0x0100, 0x0100);
+	snd_soc_component_update_bits(component, WM8971_RDAC, 0x0100, 0x0100);
+	snd_soc_component_update_bits(component, WM8971_LOUT1V, 0x0100, 0x0100);
+	snd_soc_component_update_bits(component, WM8971_ROUT1V, 0x0100, 0x0100);
+	snd_soc_component_update_bits(component, WM8971_LOUT2V, 0x0100, 0x0100);
+	snd_soc_component_update_bits(component, WM8971_ROUT2V, 0x0100, 0x0100);
+	snd_soc_component_update_bits(component, WM8971_LINVOL, 0x0100, 0x0100);
+	snd_soc_component_update_bits(component, WM8971_RINVOL, 0x0100, 0x0100);
 
 	return 0;
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_wm8971 = {
-	.probe =	wm8971_probe,
-	.set_bias_level = wm8971_set_bias_level,
-	.suspend_bias_off = true,
-
-	.component_driver = {
-		.controls		= wm8971_snd_controls,
-		.num_controls		= ARRAY_SIZE(wm8971_snd_controls),
-		.dapm_widgets		= wm8971_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(wm8971_dapm_widgets),
-		.dapm_routes		= wm8971_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(wm8971_dapm_routes),
-	},
+static const struct snd_soc_component_driver soc_component_dev_wm8971 = {
+	.probe			= wm8971_probe,
+	.set_bias_level		= wm8971_set_bias_level,
+	.controls		= wm8971_snd_controls,
+	.num_controls		= ARRAY_SIZE(wm8971_snd_controls),
+	.dapm_widgets		= wm8971_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(wm8971_dapm_widgets),
+	.dapm_routes		= wm8971_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(wm8971_dapm_routes),
+	.suspend_bias_off	= 1,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct regmap_config wm8971_regmap = {
@@ -691,18 +692,12 @@ static int wm8971_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, wm8971);
 
-	ret = snd_soc_register_codec(&i2c->dev,
-			&soc_codec_dev_wm8971, &wm8971_dai, 1);
+	ret = devm_snd_soc_register_component(&i2c->dev,
+			&soc_component_dev_wm8971, &wm8971_dai, 1);
 
 	return ret;
 }
 
-static int wm8971_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-	return 0;
-}
-
 static const struct i2c_device_id wm8971_i2c_id[] = {
 	{ "wm8971", 0 },
 	{ }
@@ -714,7 +709,6 @@ static struct i2c_driver wm8971_i2c_driver = {
 		.name = "wm8971",
 	},
 	.probe =    wm8971_i2c_probe,
-	.remove =   wm8971_i2c_remove,
 	.id_table = wm8971_i2c_id,
 };
 
-- 
2.16.1
