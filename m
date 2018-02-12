From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8804: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:51:50 +0000
Message-ID: <E1elDaI-0006SE-PY@debutante>
References: <87k1w14b9t.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DB38268109
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:51:53 +0100 (CET)
In-Reply-To: <87k1w14b9t.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: wm8804: replace codec to component

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

>From cf73dce9bc4947a777cc07b7fb7b9ff11f1e3b68 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:04:37 +0000
Subject: [PATCH] ASoC: wm8804: replace codec to component

Now we can replace Codec to Component. Let's do it.

Note:
	xxx_codec_xxx()		->	xxx_component_xxx()
	.idle_bias_off = 1	->	.idle_bias_on = 0
	.ignore_pmdown_time = 0	->	.use_pmdown_time = 1
	-			->	.endianness = 1
	-			->	.non_legacy_dai_naming = 1

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8804.c | 100 +++++++++++++++++++++++-----------------------
 1 file changed, 49 insertions(+), 51 deletions(-)

diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index fc69b87443d8..89f13249966e 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -137,21 +137,21 @@ static const struct snd_soc_dapm_route wm8804_dapm_routes[] = {
 static int wm8804_aif_event(struct snd_soc_dapm_widget *w,
 			    struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct wm8804_priv *wm8804 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct wm8804_priv *wm8804 = snd_soc_component_get_drvdata(component);
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
 		/* power up the aif */
 		if (!wm8804->aif_pwr)
-			snd_soc_update_bits(codec, WM8804_PWRDN, 0x10, 0x0);
+			snd_soc_component_update_bits(component, WM8804_PWRDN, 0x10, 0x0);
 		wm8804->aif_pwr++;
 		break;
 	case SND_SOC_DAPM_POST_PMD:
 		/* power down only both paths are disabled */
 		wm8804->aif_pwr--;
 		if (!wm8804->aif_pwr)
-			snd_soc_update_bits(codec, WM8804_PWRDN, 0x10, 0x10);
+			snd_soc_component_update_bits(component, WM8804_PWRDN, 0x10, 0x10);
 		break;
 	}
 
@@ -161,8 +161,8 @@ static int wm8804_aif_event(struct snd_soc_dapm_widget *w,
 static int txsrc_put(struct snd_kcontrol *kcontrol,
 		     struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	struct snd_soc_component *component = snd_soc_dapm_kcontrol_component(kcontrol);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int val = ucontrol->value.enumerated.item[0] << e->shift_l;
 	unsigned int mask = 1 << e->shift_l;
@@ -173,18 +173,18 @@ static int txsrc_put(struct snd_kcontrol *kcontrol,
 
 	snd_soc_dapm_mutex_lock(dapm);
 
-	if (snd_soc_test_bits(codec, e->reg, mask, val)) {
+	if (snd_soc_component_test_bits(component, e->reg, mask, val)) {
 		/* save the current power state of the transmitter */
-		txpwr = snd_soc_read(codec, WM8804_PWRDN) & 0x4;
+		txpwr = snd_soc_component_read32(component, WM8804_PWRDN) & 0x4;
 
 		/* power down the transmitter */
-		snd_soc_update_bits(codec, WM8804_PWRDN, 0x4, 0x4);
+		snd_soc_component_update_bits(component, WM8804_PWRDN, 0x4, 0x4);
 
 		/* set the tx source */
-		snd_soc_update_bits(codec, e->reg, mask, val);
+		snd_soc_component_update_bits(component, e->reg, mask, val);
 
 		/* restore the transmitter's configuration */
-		snd_soc_update_bits(codec, WM8804_PWRDN, 0x4, txpwr);
+		snd_soc_component_update_bits(component, WM8804_PWRDN, 0x4, txpwr);
 	}
 
 	snd_soc_dapm_mutex_unlock(dapm);
@@ -218,10 +218,10 @@ static int wm8804_soft_reset(struct wm8804_priv *wm8804)
 
 static int wm8804_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 	u16 format, master, bcp, lrp;
 
-	codec = dai->codec;
+	component = dai->component;
 
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
@@ -243,8 +243,8 @@ static int wm8804_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	}
 
 	/* set data format */
-	snd_soc_update_bits(codec, WM8804_AIFTX, 0x3, format);
-	snd_soc_update_bits(codec, WM8804_AIFRX, 0x3, format);
+	snd_soc_component_update_bits(component, WM8804_AIFTX, 0x3, format);
+	snd_soc_component_update_bits(component, WM8804_AIFRX, 0x3, format);
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
@@ -259,7 +259,7 @@ static int wm8804_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	}
 
 	/* set master/slave mode */
-	snd_soc_update_bits(codec, WM8804_AIFRX, 0x40, master << 6);
+	snd_soc_component_update_bits(component, WM8804_AIFRX, 0x40, master << 6);
 
 	bcp = lrp = 0;
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
@@ -280,9 +280,9 @@ static int wm8804_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	}
 
 	/* set frame inversion */
-	snd_soc_update_bits(codec, WM8804_AIFTX, 0x10 | 0x20,
+	snd_soc_component_update_bits(component, WM8804_AIFTX, 0x10 | 0x20,
 			    (bcp << 4) | (lrp << 5));
-	snd_soc_update_bits(codec, WM8804_AIFRX, 0x10 | 0x20,
+	snd_soc_component_update_bits(component, WM8804_AIFRX, 0x10 | 0x20,
 			    (bcp << 4) | (lrp << 5));
 	return 0;
 }
@@ -291,10 +291,10 @@ static int wm8804_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 	u16 blen;
 
-	codec = dai->codec;
+	component = dai->component;
 
 	switch (params_width(params)) {
 	case 16:
@@ -313,8 +313,8 @@ static int wm8804_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	/* set word length */
-	snd_soc_update_bits(codec, WM8804_AIFTX, 0xc, blen << 2);
-	snd_soc_update_bits(codec, WM8804_AIFRX, 0xc, blen << 2);
+	snd_soc_component_update_bits(component, WM8804_AIFTX, 0xc, blen << 2);
+	snd_soc_component_update_bits(component, WM8804_AIFRX, 0xc, blen << 2);
 
 	return 0;
 }
@@ -405,8 +405,8 @@ static int wm8804_set_pll(struct snd_soc_dai *dai, int pll_id,
 			  int source, unsigned int freq_in,
 			  unsigned int freq_out)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm8804_priv *wm8804 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct wm8804_priv *wm8804 = snd_soc_component_get_drvdata(component);
 	bool change;
 
 	if (!freq_in || !freq_out) {
@@ -431,18 +431,18 @@ static int wm8804_set_pll(struct snd_soc_dai *dai, int pll_id,
 			pm_runtime_get_sync(wm8804->dev);
 
 		/* set PLLN and PRESCALE */
-		snd_soc_update_bits(codec, WM8804_PLL4, 0xf | 0x10,
+		snd_soc_component_update_bits(component, WM8804_PLL4, 0xf | 0x10,
 				    pll_div.n | (pll_div.prescale << 4));
 		/* set mclkdiv and freqmode */
-		snd_soc_update_bits(codec, WM8804_PLL5, 0x3 | 0x8,
+		snd_soc_component_update_bits(component, WM8804_PLL5, 0x3 | 0x8,
 				    pll_div.freqmode | (pll_div.mclkdiv << 3));
 		/* set PLLK */
-		snd_soc_write(codec, WM8804_PLL1, pll_div.k & 0xff);
-		snd_soc_write(codec, WM8804_PLL2, (pll_div.k >> 8) & 0xff);
-		snd_soc_write(codec, WM8804_PLL3, pll_div.k >> 16);
+		snd_soc_component_write(component, WM8804_PLL1, pll_div.k & 0xff);
+		snd_soc_component_write(component, WM8804_PLL2, (pll_div.k >> 8) & 0xff);
+		snd_soc_component_write(component, WM8804_PLL3, pll_div.k >> 16);
 
 		/* power up the PLL */
-		snd_soc_update_bits(codec, WM8804_PWRDN, 0x1, 0);
+		snd_soc_component_update_bits(component, WM8804_PWRDN, 0x1, 0);
 	}
 
 	return 0;
@@ -451,15 +451,15 @@ static int wm8804_set_pll(struct snd_soc_dai *dai, int pll_id,
 static int wm8804_set_sysclk(struct snd_soc_dai *dai,
 			     int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 
-	codec = dai->codec;
+	component = dai->component;
 
 	switch (clk_id) {
 	case WM8804_TX_CLKSRC_MCLK:
 		if ((freq >= 10000000 && freq <= 14400000)
 				|| (freq >= 16280000 && freq <= 27000000))
-			snd_soc_update_bits(codec, WM8804_PLL6, 0x80, 0x80);
+			snd_soc_component_update_bits(component, WM8804_PLL6, 0x80, 0x80);
 		else {
 			dev_err(dai->dev, "OSCCLOCK is not within the "
 				"recommended range: %uHz\n", freq);
@@ -467,13 +467,13 @@ static int wm8804_set_sysclk(struct snd_soc_dai *dai,
 		}
 		break;
 	case WM8804_TX_CLKSRC_PLL:
-		snd_soc_update_bits(codec, WM8804_PLL6, 0x80, 0);
+		snd_soc_component_update_bits(component, WM8804_PLL6, 0x80, 0);
 		break;
 	case WM8804_CLKOUT_SRC_CLK1:
-		snd_soc_update_bits(codec, WM8804_PLL6, 0x8, 0);
+		snd_soc_component_update_bits(component, WM8804_PLL6, 0x8, 0);
 		break;
 	case WM8804_CLKOUT_SRC_OSCCLK:
-		snd_soc_update_bits(codec, WM8804_PLL6, 0x8, 0x8);
+		snd_soc_component_update_bits(component, WM8804_PLL6, 0x8, 0x8);
 		break;
 	default:
 		dev_err(dai->dev, "Unknown clock source: %d\n", clk_id);
@@ -486,17 +486,17 @@ static int wm8804_set_sysclk(struct snd_soc_dai *dai,
 static int wm8804_set_clkdiv(struct snd_soc_dai *dai,
 			     int div_id, int div)
 {
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 	struct wm8804_priv *wm8804;
 
-	codec = dai->codec;
+	component = dai->component;
 	switch (div_id) {
 	case WM8804_CLKOUT_DIV:
-		snd_soc_update_bits(codec, WM8804_PLL5, 0x30,
+		snd_soc_component_update_bits(component, WM8804_PLL5, 0x30,
 				    (div & 0x3) << 4);
 		break;
 	case WM8804_MCLK_DIV:
-		wm8804 = snd_soc_codec_get_drvdata(codec);
+		wm8804 = snd_soc_component_get_drvdata(component);
 		wm8804->mclk_div = div;
 		break;
 	default:
@@ -542,15 +542,14 @@ static struct snd_soc_dai_driver wm8804_dai = {
 	.symmetric_rates = 1
 };
 
-static const struct snd_soc_codec_driver soc_codec_dev_wm8804 = {
-	.idle_bias_off = true,
-
-	.component_driver = {
-		.dapm_widgets		= wm8804_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(wm8804_dapm_widgets),
-		.dapm_routes		= wm8804_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(wm8804_dapm_routes),
-	},
+static const struct snd_soc_component_driver soc_component_dev_wm8804 = {
+	.dapm_widgets		= wm8804_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(wm8804_dapm_widgets),
+	.dapm_routes		= wm8804_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(wm8804_dapm_routes),
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 const struct regmap_config wm8804_regmap_config = {
@@ -661,7 +660,7 @@ int wm8804_probe(struct device *dev, struct regmap *regmap)
 		}
 	}
 
-	ret = snd_soc_register_codec(dev, &soc_codec_dev_wm8804,
+	ret = devm_snd_soc_register_component(dev, &soc_component_dev_wm8804,
 				     &wm8804_dai, 1);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register CODEC: %d\n", ret);
@@ -683,7 +682,6 @@ EXPORT_SYMBOL_GPL(wm8804_probe);
 void wm8804_remove(struct device *dev)
 {
 	pm_runtime_disable(dev);
-	snd_soc_unregister_codec(dev);
 }
 EXPORT_SYMBOL_GPL(wm8804_remove);
 
-- 
2.16.1
