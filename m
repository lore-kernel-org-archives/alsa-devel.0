From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8974: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:47:50 +0000
Message-ID: <E1elDWQ-0005l0-U8@debutante>
References: <878tch4b61.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BCE7267E92
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:47:53 +0100 (CET)
In-Reply-To: <878tch4b61.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: wm8974: replace codec to component

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

>From 3e32a3ff800b71c84796a89479a6ea89eee0803e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:06:52 +0000
Subject: [PATCH] ASoC: wm8974: replace codec to component

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
 sound/soc/codecs/wm8974.c | 143 ++++++++++++++++++++++------------------------
 1 file changed, 68 insertions(+), 75 deletions(-)

diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index d414ddd6e197..43edaf8cd276 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -54,7 +54,7 @@ static const struct reg_default wm8974_reg_defaults[] = {
 #define WM8974_POWER1_BIASEN  0x08
 #define WM8974_POWER1_BUFIOEN 0x04
 
-#define wm8974_reset(c)	snd_soc_write(c, WM8974_RESET, 0)
+#define wm8974_reset(c)	snd_soc_component_write(c, WM8974_RESET, 0)
 
 static const char *wm8974_companding[] = {"Off", "NC", "u-law", "A-law" };
 static const char *wm8974_deemp[] = {"None", "32kHz", "44.1kHz", "48kHz" };
@@ -324,33 +324,33 @@ static void pll_factors(struct pll_ *pll_div,
 static int wm8974_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 		int source, unsigned int freq_in, unsigned int freq_out)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 	struct pll_ pll_div;
 	u16 reg;
 
 	if (freq_in == 0 || freq_out == 0) {
 		/* Clock CODEC directly from MCLK */
-		reg = snd_soc_read(codec, WM8974_CLOCK);
-		snd_soc_write(codec, WM8974_CLOCK, reg & 0x0ff);
+		reg = snd_soc_component_read32(component, WM8974_CLOCK);
+		snd_soc_component_write(component, WM8974_CLOCK, reg & 0x0ff);
 
 		/* Turn off PLL */
-		reg = snd_soc_read(codec, WM8974_POWER1);
-		snd_soc_write(codec, WM8974_POWER1, reg & 0x1df);
+		reg = snd_soc_component_read32(component, WM8974_POWER1);
+		snd_soc_component_write(component, WM8974_POWER1, reg & 0x1df);
 		return 0;
 	}
 
 	pll_factors(&pll_div, freq_out, freq_in);
 
-	snd_soc_write(codec, WM8974_PLLN, (pll_div.pre_div << 4) | pll_div.n);
-	snd_soc_write(codec, WM8974_PLLK1, pll_div.k >> 18);
-	snd_soc_write(codec, WM8974_PLLK2, (pll_div.k >> 9) & 0x1ff);
-	snd_soc_write(codec, WM8974_PLLK3, pll_div.k & 0x1ff);
-	reg = snd_soc_read(codec, WM8974_POWER1);
-	snd_soc_write(codec, WM8974_POWER1, reg | 0x020);
+	snd_soc_component_write(component, WM8974_PLLN, (pll_div.pre_div << 4) | pll_div.n);
+	snd_soc_component_write(component, WM8974_PLLK1, pll_div.k >> 18);
+	snd_soc_component_write(component, WM8974_PLLK2, (pll_div.k >> 9) & 0x1ff);
+	snd_soc_component_write(component, WM8974_PLLK3, pll_div.k & 0x1ff);
+	reg = snd_soc_component_read32(component, WM8974_POWER1);
+	snd_soc_component_write(component, WM8974_POWER1, reg | 0x020);
 
 	/* Run CODEC from PLL instead of MCLK */
-	reg = snd_soc_read(codec, WM8974_CLOCK);
-	snd_soc_write(codec, WM8974_CLOCK, reg | 0x100);
+	reg = snd_soc_component_read32(component, WM8974_CLOCK);
+	snd_soc_component_write(component, WM8974_CLOCK, reg | 0x100);
 
 	return 0;
 }
@@ -361,21 +361,21 @@ static int wm8974_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 static int wm8974_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 		int div_id, int div)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 	u16 reg;
 
 	switch (div_id) {
 	case WM8974_OPCLKDIV:
-		reg = snd_soc_read(codec, WM8974_GPIO) & 0x1cf;
-		snd_soc_write(codec, WM8974_GPIO, reg | div);
+		reg = snd_soc_component_read32(component, WM8974_GPIO) & 0x1cf;
+		snd_soc_component_write(component, WM8974_GPIO, reg | div);
 		break;
 	case WM8974_MCLKDIV:
-		reg = snd_soc_read(codec, WM8974_CLOCK) & 0x11f;
-		snd_soc_write(codec, WM8974_CLOCK, reg | div);
+		reg = snd_soc_component_read32(component, WM8974_CLOCK) & 0x11f;
+		snd_soc_component_write(component, WM8974_CLOCK, reg | div);
 		break;
 	case WM8974_BCLKDIV:
-		reg = snd_soc_read(codec, WM8974_CLOCK) & 0x1e3;
-		snd_soc_write(codec, WM8974_CLOCK, reg | div);
+		reg = snd_soc_component_read32(component, WM8974_CLOCK) & 0x1e3;
+		snd_soc_component_write(component, WM8974_CLOCK, reg | div);
 		break;
 	default:
 		return -EINVAL;
@@ -418,8 +418,8 @@ static unsigned int wm8974_get_mclkdiv(unsigned int f_in, unsigned int f_out,
 
 static int wm8974_update_clocks(struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm8974_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct wm8974_priv *priv = snd_soc_component_get_drvdata(component);
 	unsigned int fs256;
 	unsigned int fpll = 0;
 	unsigned int f;
@@ -446,8 +446,8 @@ static int wm8974_update_clocks(struct snd_soc_dai *dai)
 static int wm8974_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 				 unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm8974_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct wm8974_priv *priv = snd_soc_component_get_drvdata(component);
 
 	if (dir != SND_SOC_CLOCK_IN)
 		return -EINVAL;
@@ -460,9 +460,9 @@ static int wm8974_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 static int wm8974_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 	u16 iface = 0;
-	u16 clk = snd_soc_read(codec, WM8974_CLOCK) & 0x1fe;
+	u16 clk = snd_soc_component_read32(component, WM8974_CLOCK) & 0x1fe;
 
 	/* set master/slave audio interface */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -509,8 +509,8 @@ static int wm8974_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	snd_soc_write(codec, WM8974_IFACE, iface);
-	snd_soc_write(codec, WM8974_CLOCK, clk);
+	snd_soc_component_write(component, WM8974_IFACE, iface);
+	snd_soc_component_write(component, WM8974_CLOCK, clk);
 	return 0;
 }
 
@@ -518,10 +518,10 @@ static int wm8974_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm8974_priv *priv = snd_soc_codec_get_drvdata(codec);
-	u16 iface = snd_soc_read(codec, WM8974_IFACE) & 0x19f;
-	u16 adn = snd_soc_read(codec, WM8974_ADD) & 0x1f1;
+	struct snd_soc_component *component = dai->component;
+	struct wm8974_priv *priv = snd_soc_component_get_drvdata(component);
+	u16 iface = snd_soc_component_read32(component, WM8974_IFACE) & 0x19f;
+	u16 adn = snd_soc_component_read32(component, WM8974_ADD) & 0x1f1;
 	int err;
 
 	priv->fs = params_rate(params);
@@ -566,55 +566,55 @@ static int wm8974_pcm_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	snd_soc_write(codec, WM8974_IFACE, iface);
-	snd_soc_write(codec, WM8974_ADD, adn);
+	snd_soc_component_write(component, WM8974_IFACE, iface);
+	snd_soc_component_write(component, WM8974_ADD, adn);
 	return 0;
 }
 
 static int wm8974_mute(struct snd_soc_dai *dai, int mute)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	u16 mute_reg = snd_soc_read(codec, WM8974_DAC) & 0xffbf;
+	struct snd_soc_component *component = dai->component;
+	u16 mute_reg = snd_soc_component_read32(component, WM8974_DAC) & 0xffbf;
 
 	if (mute)
-		snd_soc_write(codec, WM8974_DAC, mute_reg | 0x40);
+		snd_soc_component_write(component, WM8974_DAC, mute_reg | 0x40);
 	else
-		snd_soc_write(codec, WM8974_DAC, mute_reg);
+		snd_soc_component_write(component, WM8974_DAC, mute_reg);
 	return 0;
 }
 
 /* liam need to make this lower power with dapm */
-static int wm8974_set_bias_level(struct snd_soc_codec *codec,
+static int wm8974_set_bias_level(struct snd_soc_component *component,
 	enum snd_soc_bias_level level)
 {
-	u16 power1 = snd_soc_read(codec, WM8974_POWER1) & ~0x3;
+	u16 power1 = snd_soc_component_read32(component, WM8974_POWER1) & ~0x3;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 	case SND_SOC_BIAS_PREPARE:
 		power1 |= 0x1;  /* VMID 50k */
-		snd_soc_write(codec, WM8974_POWER1, power1);
+		snd_soc_component_write(component, WM8974_POWER1, power1);
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
 		power1 |= WM8974_POWER1_BIASEN | WM8974_POWER1_BUFIOEN;
 
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
-			regcache_sync(dev_get_regmap(codec->dev, NULL));
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
+			regcache_sync(dev_get_regmap(component->dev, NULL));
 
 			/* Initial cap charge at VMID 5k */
-			snd_soc_write(codec, WM8974_POWER1, power1 | 0x3);
+			snd_soc_component_write(component, WM8974_POWER1, power1 | 0x3);
 			mdelay(100);
 		}
 
 		power1 |= 0x2;  /* VMID 500k */
-		snd_soc_write(codec, WM8974_POWER1, power1);
+		snd_soc_component_write(component, WM8974_POWER1, power1);
 		break;
 
 	case SND_SOC_BIAS_OFF:
-		snd_soc_write(codec, WM8974_POWER1, 0);
-		snd_soc_write(codec, WM8974_POWER2, 0);
-		snd_soc_write(codec, WM8974_POWER3, 0);
+		snd_soc_component_write(component, WM8974_POWER1, 0);
+		snd_soc_component_write(component, WM8974_POWER2, 0);
+		snd_soc_component_write(component, WM8974_POWER3, 0);
 		break;
 	}
 
@@ -663,32 +663,33 @@ static const struct regmap_config wm8974_regmap = {
 	.cache_type = REGCACHE_FLAT,
 };
 
-static int wm8974_probe(struct snd_soc_codec *codec)
+static int wm8974_probe(struct snd_soc_component *component)
 {
 	int ret = 0;
 
-	ret = wm8974_reset(codec);
+	ret = wm8974_reset(component);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to issue reset\n");
+		dev_err(component->dev, "Failed to issue reset\n");
 		return ret;
 	}
 
 	return 0;
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_wm8974 = {
-	.probe = 	wm8974_probe,
-	.set_bias_level = wm8974_set_bias_level,
-	.suspend_bias_off = true,
-
-	.component_driver = {
-		.controls		= wm8974_snd_controls,
-		.num_controls		= ARRAY_SIZE(wm8974_snd_controls),
-		.dapm_widgets		= wm8974_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(wm8974_dapm_widgets),
-		.dapm_routes		= wm8974_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(wm8974_dapm_routes),
-	},
+static const struct snd_soc_component_driver soc_component_dev_wm8974 = {
+	.probe			= wm8974_probe,
+	.set_bias_level		= wm8974_set_bias_level,
+	.controls		= wm8974_snd_controls,
+	.num_controls		= ARRAY_SIZE(wm8974_snd_controls),
+	.dapm_widgets		= wm8974_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(wm8974_dapm_widgets),
+	.dapm_routes		= wm8974_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(wm8974_dapm_routes),
+	.suspend_bias_off	= 1,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static int wm8974_i2c_probe(struct i2c_client *i2c,
@@ -708,19 +709,12 @@ static int wm8974_i2c_probe(struct i2c_client *i2c,
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	ret = snd_soc_register_codec(&i2c->dev,
-			&soc_codec_dev_wm8974, &wm8974_dai, 1);
+	ret = devm_snd_soc_register_component(&i2c->dev,
+			&soc_component_dev_wm8974, &wm8974_dai, 1);
 
 	return ret;
 }
 
-static int wm8974_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-
-	return 0;
-}
-
 static const struct i2c_device_id wm8974_i2c_id[] = {
 	{ "wm8974", 0 },
 	{ }
@@ -739,7 +733,6 @@ static struct i2c_driver wm8974_i2c_driver = {
 		.of_match_table = wm8974_of_match,
 	},
 	.probe =    wm8974_i2c_probe,
-	.remove =   wm8974_i2c_remove,
 	.id_table = wm8974_i2c_id,
 };
 
-- 
2.16.1
