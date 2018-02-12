From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8824: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:37:52 +0000
Message-ID: <E1elDMm-000498-KX@debutante>
References: <87k1w1wam7.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0391A267844
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:37:55 +0100 (CET)
In-Reply-To: <87k1w1wam7.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: nau8824: replace codec to component

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

>From 12a72f91a28eb302e1431ef0bb68b5f83e35a891 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:31:19 +0000
Subject: [PATCH] ASoC: nau8824: replace codec to component

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
 sound/soc/codecs/nau8824.c | 113 +++++++++++++++++++++------------------------
 sound/soc/codecs/nau8824.h |   2 +-
 2 files changed, 54 insertions(+), 61 deletions(-)

diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index 088e0cef4cb8..4d9148a6a080 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -414,8 +414,8 @@ static const struct snd_kcontrol_new nau8824_snd_controls[] = {
 static int nau8824_output_dac_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct nau8824 *nau8824 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct nau8824 *nau8824 = snd_soc_component_get_drvdata(component);
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -437,8 +437,8 @@ static int nau8824_output_dac_event(struct snd_soc_dapm_widget *w,
 static int nau8824_spk_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct nau8824 *nau8824 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct nau8824 *nau8824 = snd_soc_component_get_drvdata(component);
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -461,8 +461,8 @@ static int nau8824_spk_event(struct snd_soc_dapm_widget *w,
 static int nau8824_pump_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct nau8824 *nau8824 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct nau8824 *nau8824 = snd_soc_component_get_drvdata(component);
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
@@ -487,8 +487,8 @@ static int nau8824_pump_event(struct snd_soc_dapm_widget *w,
 static int system_clock_control(struct snd_soc_dapm_widget *w,
 		struct snd_kcontrol *k, int  event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct nau8824 *nau8824 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct nau8824 *nau8824 = snd_soc_component_get_drvdata(component);
 
 	if (SND_SOC_DAPM_EVENT_OFF(event)) {
 		/* Set clock source to disable or internal clock before the
@@ -509,8 +509,8 @@ static int system_clock_control(struct snd_soc_dapm_widget *w,
 static int dmic_clock_control(struct snd_soc_dapm_widget *w,
 		struct snd_kcontrol *k, int  event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct nau8824 *nau8824 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct nau8824 *nau8824 = snd_soc_component_get_drvdata(component);
 	int src;
 
 	/* The DMIC clock is gotten from system clock (256fs) divided by
@@ -988,8 +988,8 @@ static int nau8824_clock_check(struct nau8824 *nau8824,
 static int nau8824_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct nau8824 *nau8824 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct nau8824 *nau8824 = snd_soc_component_get_drvdata(component);
 	unsigned int val_len = 0, osr, ctrl_val, bclk_fs, bclk_div;
 
 	nau8824_sema_acquire(nau8824, HZ);
@@ -1072,8 +1072,8 @@ static int nau8824_hw_params(struct snd_pcm_substream *substream,
 
 static int nau8824_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct nau8824 *nau8824 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct nau8824 *nau8824 = snd_soc_component_get_drvdata(component);
 	unsigned int ctrl1_val = 0, ctrl2_val = 0;
 
 	nau8824_sema_acquire(nau8824, HZ);
@@ -1149,8 +1149,8 @@ static int nau8824_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 static int nau8824_set_tdm_slot(struct snd_soc_dai *dai,
 	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct nau8824 *nau8824 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct nau8824 *nau8824 = snd_soc_component_get_drvdata(component);
 	unsigned int tslot_l = 0, ctrl_val = 0;
 
 	if (slots > 4 || ((tx_mask & 0xf0) && (tx_mask & 0xf)) ||
@@ -1288,10 +1288,10 @@ static void nau8824_fll_apply(struct regmap *regmap,
 }
 
 /* freq_out must be 256*Fs in order to achieve the best performance */
-static int nau8824_set_pll(struct snd_soc_codec *codec, int pll_id, int source,
+static int nau8824_set_pll(struct snd_soc_component *component, int pll_id, int source,
 		unsigned int freq_in, unsigned int freq_out)
 {
-	struct nau8824 *nau8824 = snd_soc_codec_get_drvdata(codec);
+	struct nau8824 *nau8824 = snd_soc_component_get_drvdata(component);
 	struct nau8824_fll fll_param;
 	int ret, fs;
 
@@ -1374,10 +1374,10 @@ static int nau8824_config_sysclk(struct nau8824 *nau8824,
 	return 0;
 }
 
-static int nau8824_set_sysclk(struct snd_soc_codec *codec,
+static int nau8824_set_sysclk(struct snd_soc_component *component,
 	int clk_id, int source, unsigned int freq, int dir)
 {
-	struct nau8824 *nau8824 = snd_soc_codec_get_drvdata(codec);
+	struct nau8824 *nau8824 = snd_soc_component_get_drvdata(component);
 
 	return nau8824_config_sysclk(nau8824, clk_id, freq);
 }
@@ -1403,10 +1403,10 @@ static void nau8824_resume_setup(struct nau8824 *nau8824)
 	}
 }
 
-static int nau8824_set_bias_level(struct snd_soc_codec *codec,
+static int nau8824_set_bias_level(struct snd_soc_component *component,
 	enum snd_soc_bias_level level)
 {
-	struct nau8824 *nau8824 = snd_soc_codec_get_drvdata(codec);
+	struct nau8824 *nau8824 = snd_soc_component_get_drvdata(component);
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
@@ -1416,7 +1416,7 @@ static int nau8824_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
 			/* Setup codec configuration after resume */
 			nau8824_resume_setup(nau8824);
 		}
@@ -1434,23 +1434,23 @@ static int nau8824_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static int nau8824_codec_probe(struct snd_soc_codec *codec)
+static int nau8824_component_probe(struct snd_soc_component *component)
 {
-	struct nau8824 *nau8824 = snd_soc_codec_get_drvdata(codec);
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	struct nau8824 *nau8824 = snd_soc_component_get_drvdata(component);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 
 	nau8824->dapm = dapm;
 
 	return 0;
 }
 
-static int __maybe_unused nau8824_suspend(struct snd_soc_codec *codec)
+static int __maybe_unused nau8824_suspend(struct snd_soc_component *component)
 {
-	struct nau8824 *nau8824 = snd_soc_codec_get_drvdata(codec);
+	struct nau8824 *nau8824 = snd_soc_component_get_drvdata(component);
 
 	if (nau8824->irq) {
 		disable_irq(nau8824->irq);
-		snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_OFF);
+		snd_soc_component_force_bias_level(component, SND_SOC_BIAS_OFF);
 	}
 	regcache_cache_only(nau8824->regmap, true);
 	regcache_mark_dirty(nau8824->regmap);
@@ -1458,9 +1458,9 @@ static int __maybe_unused nau8824_suspend(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int __maybe_unused nau8824_resume(struct snd_soc_codec *codec)
+static int __maybe_unused nau8824_resume(struct snd_soc_component *component)
 {
-	struct nau8824 *nau8824 = snd_soc_codec_get_drvdata(codec);
+	struct nau8824 *nau8824 = snd_soc_component_get_drvdata(component);
 
 	regcache_cache_only(nau8824->regmap, false);
 	regcache_sync(nau8824->regmap);
@@ -1475,23 +1475,24 @@ static int __maybe_unused nau8824_resume(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static const struct snd_soc_codec_driver nau8824_codec_driver = {
-	.probe = nau8824_codec_probe,
-	.set_sysclk = nau8824_set_sysclk,
-	.set_pll = nau8824_set_pll,
-	.set_bias_level = nau8824_set_bias_level,
-	.suspend = nau8824_suspend,
-	.resume = nau8824_resume,
-	.suspend_bias_off = true,
-
-	.component_driver = {
-		.controls = nau8824_snd_controls,
-		.num_controls = ARRAY_SIZE(nau8824_snd_controls),
-		.dapm_widgets = nau8824_dapm_widgets,
-		.num_dapm_widgets = ARRAY_SIZE(nau8824_dapm_widgets),
-		.dapm_routes = nau8824_dapm_routes,
-		.num_dapm_routes = ARRAY_SIZE(nau8824_dapm_routes),
-	},
+static const struct snd_soc_component_driver nau8824_component_driver = {
+	.probe			= nau8824_component_probe,
+	.set_sysclk		= nau8824_set_sysclk,
+	.set_pll		= nau8824_set_pll,
+	.set_bias_level		= nau8824_set_bias_level,
+	.suspend		= nau8824_suspend,
+	.resume			= nau8824_resume,
+	.controls		= nau8824_snd_controls,
+	.num_controls		= ARRAY_SIZE(nau8824_snd_controls),
+	.dapm_widgets		= nau8824_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(nau8824_dapm_widgets),
+	.dapm_routes		= nau8824_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(nau8824_dapm_routes),
+	.suspend_bias_off	= 1,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct snd_soc_dai_ops nau8824_dai_ops = {
@@ -1547,10 +1548,10 @@ static const struct regmap_config nau8824_regmap_config = {
  * events will be routed to the given jack.  Jack can be null to stop
  * reporting.
  */
-int nau8824_enable_jack_detect(struct snd_soc_codec *codec,
+int nau8824_enable_jack_detect(struct snd_soc_component *component,
 	struct snd_soc_jack *jack)
 {
-	struct nau8824 *nau8824 = snd_soc_codec_get_drvdata(codec);
+	struct nau8824 *nau8824 = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	nau8824->jack = jack;
@@ -1838,15 +1839,8 @@ static int nau8824_i2c_probe(struct i2c_client *i2c,
 	if (i2c->irq)
 		nau8824_setup_irq(nau8824);
 
-	return snd_soc_register_codec(dev,
-		&nau8824_codec_driver, &nau8824_dai, 1);
-}
-
-
-static int nau8824_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-	return 0;
+	return devm_snd_soc_register_component(dev,
+		&nau8824_component_driver, &nau8824_dai, 1);
 }
 
 static const struct i2c_device_id nau8824_i2c_ids[] = {
@@ -1878,7 +1872,6 @@ static struct i2c_driver nau8824_i2c_driver = {
 		.acpi_match_table = ACPI_PTR(nau8824_acpi_match),
 	},
 	.probe = nau8824_i2c_probe,
-	.remove = nau8824_i2c_remove,
 	.id_table = nau8824_i2c_ids,
 };
 module_i2c_driver(nau8824_i2c_driver);
diff --git a/sound/soc/codecs/nau8824.h b/sound/soc/codecs/nau8824.h
index 21eae2431c83..6184a2b5c941 100644
--- a/sound/soc/codecs/nau8824.h
+++ b/sound/soc/codecs/nau8824.h
@@ -471,7 +471,7 @@ struct nau8824_osr_attr {
 };
 
 
-int nau8824_enable_jack_detect(struct snd_soc_codec *codec,
+int nau8824_enable_jack_detect(struct snd_soc_component *component,
 	struct snd_soc_jack *jack);
 
 #endif				/* _NAU8824_H */
-- 
2.16.1
