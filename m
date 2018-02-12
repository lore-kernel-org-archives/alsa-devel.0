From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: twl6040: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:39:16 +0000
Message-ID: <E1elDO8-0004Th-J6@debutante>
References: <87lgghxpp9.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E1819267B1C
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:39:18 +0100 (CET)
In-Reply-To: <87lgghxpp9.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: twl6040: replace codec to component

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

>From 7480389fb0d873ed78619542bf5d2717a7ad7786 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:20:09 +0000
Subject: [PATCH] ASoC: twl6040: replace codec to component

Now we can replace Codec to Component. Let's do it.

Note:
	xxx_codec_xxx()		->	xxx_component_xxx()
	.idle_bias_off = 0	->	.idle_bias_on = 1
	.ignore_pmdown_time = 1	->	.use_pmdown_time = 0
	-			->	.endianness = 1
	-			->	.non_legacy_dai_naming = 1

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/twl6040.c        | 269 ++++++++++++++++++--------------------
 sound/soc/codecs/twl6040.h        |  10 +-
 sound/soc/omap/omap-abe-twl6040.c |   8 +-
 3 files changed, 139 insertions(+), 148 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 573a523ed0b3..9bf23f8e7162 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -76,7 +76,7 @@ struct twl6040_data {
 	unsigned int clk_in;
 	unsigned int sysclk;
 	struct twl6040_jack_data hs_jack;
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 	struct mutex mutex;
 };
 
@@ -106,12 +106,12 @@ static const struct snd_pcm_hw_constraint_list sysclk_constraints[] = {
 	{ .count = ARRAY_SIZE(hp_rates), .list = hp_rates, },
 };
 
-#define to_twl6040(codec)	dev_get_drvdata((codec)->dev->parent)
+#define to_twl6040(component)	dev_get_drvdata((component)->dev->parent)
 
-static unsigned int twl6040_read(struct snd_soc_codec *codec, unsigned int reg)
+static unsigned int twl6040_read(struct snd_soc_component *component, unsigned int reg)
 {
-	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
-	struct twl6040 *twl6040 = to_twl6040(codec);
+	struct twl6040_data *priv = snd_soc_component_get_drvdata(component);
+	struct twl6040 *twl6040 = to_twl6040(component);
 	u8 value;
 
 	if (reg >= TWL6040_CACHEREGNUM)
@@ -133,10 +133,10 @@ static unsigned int twl6040_read(struct snd_soc_codec *codec, unsigned int reg)
 	return value;
 }
 
-static bool twl6040_can_write_to_chip(struct snd_soc_codec *codec,
+static bool twl6040_can_write_to_chip(struct snd_soc_component *component,
 				  unsigned int reg)
 {
-	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
+	struct twl6040_data *priv = snd_soc_component_get_drvdata(component);
 
 	switch (reg) {
 	case TWL6040_REG_HSLCTL:
@@ -152,10 +152,10 @@ static bool twl6040_can_write_to_chip(struct snd_soc_codec *codec,
 	}
 }
 
-static inline void twl6040_update_dl12_cache(struct snd_soc_codec *codec,
+static inline void twl6040_update_dl12_cache(struct snd_soc_component *component,
 					     u8 reg, u8 value)
 {
-	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
+	struct twl6040_data *priv = snd_soc_component_get_drvdata(component);
 
 	switch (reg) {
 	case TWL6040_REG_HSLCTL:
@@ -170,54 +170,54 @@ static inline void twl6040_update_dl12_cache(struct snd_soc_codec *codec,
 	}
 }
 
-static int twl6040_write(struct snd_soc_codec *codec,
+static int twl6040_write(struct snd_soc_component *component,
 			unsigned int reg, unsigned int value)
 {
-	struct twl6040 *twl6040 = to_twl6040(codec);
+	struct twl6040 *twl6040 = to_twl6040(component);
 
 	if (reg >= TWL6040_CACHEREGNUM)
 		return -EIO;
 
-	twl6040_update_dl12_cache(codec, reg, value);
-	if (twl6040_can_write_to_chip(codec, reg))
+	twl6040_update_dl12_cache(component, reg, value);
+	if (twl6040_can_write_to_chip(component, reg))
 		return twl6040_reg_write(twl6040, reg, value);
 	else
 		return 0;
 }
 
-static void twl6040_init_chip(struct snd_soc_codec *codec)
+static void twl6040_init_chip(struct snd_soc_component *component)
 {
-	twl6040_read(codec, TWL6040_REG_TRIM1);
-	twl6040_read(codec, TWL6040_REG_TRIM2);
-	twl6040_read(codec, TWL6040_REG_TRIM3);
-	twl6040_read(codec, TWL6040_REG_HSOTRIM);
-	twl6040_read(codec, TWL6040_REG_HFOTRIM);
+	twl6040_read(component, TWL6040_REG_TRIM1);
+	twl6040_read(component, TWL6040_REG_TRIM2);
+	twl6040_read(component, TWL6040_REG_TRIM3);
+	twl6040_read(component, TWL6040_REG_HSOTRIM);
+	twl6040_read(component, TWL6040_REG_HFOTRIM);
 
 	/* Change chip defaults */
 	/* No imput selected for microphone amplifiers */
-	twl6040_write(codec, TWL6040_REG_MICLCTL, 0x18);
-	twl6040_write(codec, TWL6040_REG_MICRCTL, 0x18);
+	twl6040_write(component, TWL6040_REG_MICLCTL, 0x18);
+	twl6040_write(component, TWL6040_REG_MICRCTL, 0x18);
 
 	/*
 	 * We need to lower the default gain values, so the ramp code
 	 * can work correctly for the first playback.
 	 * This reduces the pop noise heard at the first playback.
 	 */
-	twl6040_write(codec, TWL6040_REG_HSGAIN, 0xff);
-	twl6040_write(codec, TWL6040_REG_EARCTL, 0x1e);
-	twl6040_write(codec, TWL6040_REG_HFLGAIN, 0x1d);
-	twl6040_write(codec, TWL6040_REG_HFRGAIN, 0x1d);
-	twl6040_write(codec, TWL6040_REG_LINEGAIN, 0);
+	twl6040_write(component, TWL6040_REG_HSGAIN, 0xff);
+	twl6040_write(component, TWL6040_REG_EARCTL, 0x1e);
+	twl6040_write(component, TWL6040_REG_HFLGAIN, 0x1d);
+	twl6040_write(component, TWL6040_REG_HFRGAIN, 0x1d);
+	twl6040_write(component, TWL6040_REG_LINEGAIN, 0);
 }
 
 /* set headset dac and driver power mode */
-static int headset_power_mode(struct snd_soc_codec *codec, int high_perf)
+static int headset_power_mode(struct snd_soc_component *component, int high_perf)
 {
 	int hslctl, hsrctl;
 	int mask = TWL6040_HSDRVMODE | TWL6040_HSDACMODE;
 
-	hslctl = twl6040_read(codec, TWL6040_REG_HSLCTL);
-	hsrctl = twl6040_read(codec, TWL6040_REG_HSRCTL);
+	hslctl = twl6040_read(component, TWL6040_REG_HSLCTL);
+	hsrctl = twl6040_read(component, TWL6040_REG_HSRCTL);
 
 	if (high_perf) {
 		hslctl &= ~mask;
@@ -227,8 +227,8 @@ static int headset_power_mode(struct snd_soc_codec *codec, int high_perf)
 		hsrctl |= mask;
 	}
 
-	twl6040_write(codec, TWL6040_REG_HSLCTL, hslctl);
-	twl6040_write(codec, TWL6040_REG_HSRCTL, hsrctl);
+	twl6040_write(component, TWL6040_REG_HSLCTL, hslctl);
+	twl6040_write(component, TWL6040_REG_HSRCTL, hsrctl);
 
 	return 0;
 }
@@ -236,7 +236,7 @@ static int headset_power_mode(struct snd_soc_codec *codec, int high_perf)
 static int twl6040_hs_dac_event(struct snd_soc_dapm_widget *w,
 			struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	u8 hslctl, hsrctl;
 
 	/*
@@ -244,8 +244,8 @@ static int twl6040_hs_dac_event(struct snd_soc_dapm_widget *w,
 	 * Both HS DAC need to be turned on (before the HS driver) and off at
 	 * the same time.
 	 */
-	hslctl = twl6040_read(codec, TWL6040_REG_HSLCTL);
-	hsrctl = twl6040_read(codec, TWL6040_REG_HSRCTL);
+	hslctl = twl6040_read(component, TWL6040_REG_HSLCTL);
+	hsrctl = twl6040_read(component, TWL6040_REG_HSRCTL);
 	if (SND_SOC_DAPM_EVENT_ON(event)) {
 		hslctl |= TWL6040_HSDACENA;
 		hsrctl |= TWL6040_HSDACENA;
@@ -253,8 +253,8 @@ static int twl6040_hs_dac_event(struct snd_soc_dapm_widget *w,
 		hslctl &= ~TWL6040_HSDACENA;
 		hsrctl &= ~TWL6040_HSDACENA;
 	}
-	twl6040_write(codec, TWL6040_REG_HSLCTL, hslctl);
-	twl6040_write(codec, TWL6040_REG_HSRCTL, hsrctl);
+	twl6040_write(component, TWL6040_REG_HSLCTL, hslctl);
+	twl6040_write(component, TWL6040_REG_HSRCTL, hsrctl);
 
 	msleep(1);
 	return 0;
@@ -263,17 +263,17 @@ static int twl6040_hs_dac_event(struct snd_soc_dapm_widget *w,
 static int twl6040_ep_drv_event(struct snd_soc_dapm_widget *w,
 			struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct twl6040_data *priv = snd_soc_component_get_drvdata(component);
 	int ret = 0;
 
 	if (SND_SOC_DAPM_EVENT_ON(event)) {
 		/* Earphone doesn't support low power mode */
 		priv->hs_power_mode_locked = 1;
-		ret = headset_power_mode(codec, 1);
+		ret = headset_power_mode(component, 1);
 	} else {
 		priv->hs_power_mode_locked = 0;
-		ret = headset_power_mode(codec, priv->hs_power_mode);
+		ret = headset_power_mode(component, priv->hs_power_mode);
 	}
 
 	msleep(1);
@@ -281,16 +281,16 @@ static int twl6040_ep_drv_event(struct snd_soc_dapm_widget *w,
 	return ret;
 }
 
-static void twl6040_hs_jack_report(struct snd_soc_codec *codec,
+static void twl6040_hs_jack_report(struct snd_soc_component *component,
 				   struct snd_soc_jack *jack, int report)
 {
-	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
+	struct twl6040_data *priv = snd_soc_component_get_drvdata(component);
 	int status;
 
 	mutex_lock(&priv->mutex);
 
 	/* Sync status */
-	status = twl6040_read(codec, TWL6040_REG_STATUS);
+	status = twl6040_read(component, TWL6040_REG_STATUS);
 	if (status & TWL6040_PLUGCOMP)
 		snd_soc_jack_report(jack, report, report);
 	else
@@ -299,16 +299,16 @@ static void twl6040_hs_jack_report(struct snd_soc_codec *codec,
 	mutex_unlock(&priv->mutex);
 }
 
-void twl6040_hs_jack_detect(struct snd_soc_codec *codec,
+void twl6040_hs_jack_detect(struct snd_soc_component *component,
 				struct snd_soc_jack *jack, int report)
 {
-	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
+	struct twl6040_data *priv = snd_soc_component_get_drvdata(component);
 	struct twl6040_jack_data *hs_jack = &priv->hs_jack;
 
 	hs_jack->jack = jack;
 	hs_jack->report = report;
 
-	twl6040_hs_jack_report(codec, hs_jack->jack, hs_jack->report);
+	twl6040_hs_jack_report(component, hs_jack->jack, hs_jack->report);
 }
 EXPORT_SYMBOL_GPL(twl6040_hs_jack_detect);
 
@@ -316,17 +316,17 @@ static void twl6040_accessory_work(struct work_struct *work)
 {
 	struct twl6040_data *priv = container_of(work,
 					struct twl6040_data, hs_jack.work.work);
-	struct snd_soc_codec *codec = priv->codec;
+	struct snd_soc_component *component = priv->component;
 	struct twl6040_jack_data *hs_jack = &priv->hs_jack;
 
-	twl6040_hs_jack_report(codec, hs_jack->jack, hs_jack->report);
+	twl6040_hs_jack_report(component, hs_jack->jack, hs_jack->report);
 }
 
 /* audio interrupt handler */
 static irqreturn_t twl6040_audio_handler(int irq, void *data)
 {
-	struct snd_soc_codec *codec = data;
-	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = data;
+	struct twl6040_data *priv = snd_soc_component_get_drvdata(component);
 
 	queue_delayed_work(system_power_efficient_wq,
 			   &priv->hs_jack.work, msecs_to_jiffies(200));
@@ -337,12 +337,12 @@ static irqreturn_t twl6040_audio_handler(int irq, void *data)
 static int twl6040_soc_dapm_put_vibra_enum(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_kcontrol_codec(kcontrol);
+	struct snd_soc_component *component = snd_soc_dapm_kcontrol_component(kcontrol);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int val;
 
 	/* Do not allow changes while Input/FF efect is running */
-	val = twl6040_read(codec, e->reg);
+	val = twl6040_read(component, e->reg);
 	if (val & TWL6040_VIBENA && !(val & TWL6040_VIBSEL))
 		return -EBUSY;
 
@@ -486,8 +486,8 @@ static SOC_ENUM_SINGLE_EXT_DECL(twl6040_power_mode_enum,
 static int twl6040_headset_power_get_enum(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct twl6040_data *priv = snd_soc_component_get_drvdata(component);
 
 	ucontrol->value.enumerated.item[0] = priv->hs_power_mode;
 
@@ -497,13 +497,13 @@ static int twl6040_headset_power_get_enum(struct snd_kcontrol *kcontrol,
 static int twl6040_headset_power_put_enum(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct twl6040_data *priv = snd_soc_component_get_drvdata(component);
 	int high_perf = ucontrol->value.enumerated.item[0];
 	int ret = 0;
 
 	if (!priv->hs_power_mode_locked)
-		ret = headset_power_mode(codec, high_perf);
+		ret = headset_power_mode(component, high_perf);
 
 	if (!ret)
 		priv->hs_power_mode = high_perf;
@@ -514,8 +514,8 @@ static int twl6040_headset_power_put_enum(struct snd_kcontrol *kcontrol,
 static int twl6040_pll_get_enum(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct twl6040_data *priv = snd_soc_component_get_drvdata(component);
 
 	ucontrol->value.enumerated.item[0] = priv->pll_power_mode;
 
@@ -525,17 +525,17 @@ static int twl6040_pll_get_enum(struct snd_kcontrol *kcontrol,
 static int twl6040_pll_put_enum(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct twl6040_data *priv = snd_soc_component_get_drvdata(component);
 
 	priv->pll_power_mode = ucontrol->value.enumerated.item[0];
 
 	return 0;
 }
 
-int twl6040_get_dl1_gain(struct snd_soc_codec *codec)
+int twl6040_get_dl1_gain(struct snd_soc_component *component)
 {
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 
 	if (snd_soc_dapm_get_pin_status(dapm, "EP"))
 		return -1; /* -1dB */
@@ -543,7 +543,7 @@ int twl6040_get_dl1_gain(struct snd_soc_codec *codec)
 	if (snd_soc_dapm_get_pin_status(dapm, "HSOR") ||
 		snd_soc_dapm_get_pin_status(dapm, "HSOL")) {
 
-		u8 val = twl6040_read(codec, TWL6040_REG_HSLCTL);
+		u8 val = twl6040_read(component, TWL6040_REG_HSLCTL);
 		if (val & TWL6040_HSDACMODE)
 			/* HSDACL in LP mode */
 			return -8; /* -8dB */
@@ -555,26 +555,26 @@ int twl6040_get_dl1_gain(struct snd_soc_codec *codec)
 }
 EXPORT_SYMBOL_GPL(twl6040_get_dl1_gain);
 
-int twl6040_get_clk_id(struct snd_soc_codec *codec)
+int twl6040_get_clk_id(struct snd_soc_component *component)
 {
-	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
+	struct twl6040_data *priv = snd_soc_component_get_drvdata(component);
 
 	return priv->pll_power_mode;
 }
 EXPORT_SYMBOL_GPL(twl6040_get_clk_id);
 
-int twl6040_get_trim_value(struct snd_soc_codec *codec, enum twl6040_trim trim)
+int twl6040_get_trim_value(struct snd_soc_component *component, enum twl6040_trim trim)
 {
 	if (unlikely(trim >= TWL6040_TRIM_INVAL))
 		return -EINVAL;
 
-	return twl6040_read(codec, TWL6040_REG_TRIM1 + trim);
+	return twl6040_read(component, TWL6040_REG_TRIM1 + trim);
 }
 EXPORT_SYMBOL_GPL(twl6040_get_trim_value);
 
-int twl6040_get_hs_step_size(struct snd_soc_codec *codec)
+int twl6040_get_hs_step_size(struct snd_soc_component *component)
 {
-	struct twl6040 *twl6040 = to_twl6040(codec);
+	struct twl6040 *twl6040 = to_twl6040(component);
 
 	if (twl6040_get_revid(twl6040) < TWL6040_REV_ES1_3)
 		/* For ES under ES_1.3 HS step is 2 mV */
@@ -829,11 +829,11 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"VIBRAR", NULL, "Vibra Right Driver"},
 };
 
-static int twl6040_set_bias_level(struct snd_soc_codec *codec,
+static int twl6040_set_bias_level(struct snd_soc_component *component,
 				enum snd_soc_bias_level level)
 {
-	struct twl6040 *twl6040 = to_twl6040(codec);
-	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
+	struct twl6040 *twl6040 = to_twl6040(component);
+	struct twl6040_data *priv = snd_soc_component_get_drvdata(component);
 	int ret = 0;
 
 	switch (level) {
@@ -856,7 +856,7 @@ static int twl6040_set_bias_level(struct snd_soc_codec *codec,
 		priv->codec_powered = 1;
 
 		/* Set external boost GPO */
-		twl6040_write(codec, TWL6040_REG_GPOCTL, 0x02);
+		twl6040_write(component, TWL6040_REG_GPOCTL, 0x02);
 		break;
 	case SND_SOC_BIAS_OFF:
 		if (!priv->codec_powered)
@@ -873,8 +873,8 @@ static int twl6040_set_bias_level(struct snd_soc_codec *codec,
 static int twl6040_startup(struct snd_pcm_substream *substream,
 			struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct twl6040_data *priv = snd_soc_component_get_drvdata(component);
 
 	snd_pcm_hw_constraint_list(substream->runtime, 0,
 				SNDRV_PCM_HW_PARAM_RATE,
@@ -887,8 +887,8 @@ static int twl6040_hw_params(struct snd_pcm_substream *substream,
 			struct snd_pcm_hw_params *params,
 			struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct twl6040_data *priv = snd_soc_component_get_drvdata(component);
 	int rate;
 
 	rate = params_rate(params);
@@ -899,7 +899,7 @@ static int twl6040_hw_params(struct snd_pcm_substream *substream,
 	case 88200:
 		/* These rates are not supported when HPPLL is in use */
 		if (unlikely(priv->pll == TWL6040_SYSCLK_SEL_HPPLL)) {
-			dev_err(codec->dev, "HPPLL does not support rate %d\n",
+			dev_err(component->dev, "HPPLL does not support rate %d\n",
 				rate);
 			return -EINVAL;
 		}
@@ -913,7 +913,7 @@ static int twl6040_hw_params(struct snd_pcm_substream *substream,
 		priv->sysclk = 19200000;
 		break;
 	default:
-		dev_err(codec->dev, "unsupported rate %d\n", rate);
+		dev_err(component->dev, "unsupported rate %d\n", rate);
 		return -EINVAL;
 	}
 
@@ -923,20 +923,20 @@ static int twl6040_hw_params(struct snd_pcm_substream *substream,
 static int twl6040_prepare(struct snd_pcm_substream *substream,
 			struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct twl6040 *twl6040 = to_twl6040(codec);
-	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct twl6040 *twl6040 = to_twl6040(component);
+	struct twl6040_data *priv = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	if (!priv->sysclk) {
-		dev_err(codec->dev,
+		dev_err(component->dev,
 			"no mclk configured, call set_sysclk() on init\n");
 		return -EINVAL;
 	}
 
 	ret = twl6040_set_pll(twl6040, priv->pll, priv->clk_in, priv->sysclk);
 	if (ret) {
-		dev_err(codec->dev, "Can not set PLL (%d)\n", ret);
+		dev_err(component->dev, "Can not set PLL (%d)\n", ret);
 		return -EPERM;
 	}
 
@@ -946,8 +946,8 @@ static int twl6040_prepare(struct snd_pcm_substream *substream,
 static int twl6040_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
-	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = codec_dai->component;
+	struct twl6040_data *priv = snd_soc_component_get_drvdata(component);
 
 	switch (clk_id) {
 	case TWL6040_SYSCLK_SEL_LPPLL:
@@ -956,26 +956,26 @@ static int twl6040_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		priv->clk_in = freq;
 		break;
 	default:
-		dev_err(codec->dev, "unknown clk_id %d\n", clk_id);
+		dev_err(component->dev, "unknown clk_id %d\n", clk_id);
 		return -EINVAL;
 	}
 
 	return 0;
 }
 
-static void twl6040_mute_path(struct snd_soc_codec *codec, enum twl6040_dai_id id,
+static void twl6040_mute_path(struct snd_soc_component *component, enum twl6040_dai_id id,
 			     int mute)
 {
-	struct twl6040 *twl6040 = to_twl6040(codec);
-	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
+	struct twl6040 *twl6040 = to_twl6040(component);
+	struct twl6040_data *priv = snd_soc_component_get_drvdata(component);
 	int hslctl, hsrctl, earctl;
 	int hflctl, hfrctl;
 
 	switch (id) {
 	case TWL6040_DAI_DL1:
-		hslctl = twl6040_read(codec, TWL6040_REG_HSLCTL);
-		hsrctl = twl6040_read(codec, TWL6040_REG_HSRCTL);
-		earctl = twl6040_read(codec, TWL6040_REG_EARCTL);
+		hslctl = twl6040_read(component, TWL6040_REG_HSLCTL);
+		hsrctl = twl6040_read(component, TWL6040_REG_HSRCTL);
+		earctl = twl6040_read(component, TWL6040_REG_EARCTL);
 
 		if (mute) {
 			/* Power down drivers and DACs */
@@ -991,8 +991,8 @@ static void twl6040_mute_path(struct snd_soc_codec *codec, enum twl6040_dai_id i
 		priv->dl1_unmuted = !mute;
 		break;
 	case TWL6040_DAI_DL2:
-		hflctl = twl6040_read(codec, TWL6040_REG_HFLCTL);
-		hfrctl = twl6040_read(codec, TWL6040_REG_HFRCTL);
+		hflctl = twl6040_read(component, TWL6040_REG_HFLCTL);
+		hfrctl = twl6040_read(component, TWL6040_REG_HFRCTL);
 
 		if (mute) {
 			/* Power down drivers and DACs */
@@ -1015,12 +1015,12 @@ static int twl6040_digital_mute(struct snd_soc_dai *dai, int mute)
 {
 	switch (dai->id) {
 	case TWL6040_DAI_LEGACY:
-		twl6040_mute_path(dai->codec, TWL6040_DAI_DL1, mute);
-		twl6040_mute_path(dai->codec, TWL6040_DAI_DL2, mute);
+		twl6040_mute_path(dai->component, TWL6040_DAI_DL1, mute);
+		twl6040_mute_path(dai->component, TWL6040_DAI_DL2, mute);
 		break;
 	case TWL6040_DAI_DL1:
 	case TWL6040_DAI_DL2:
-		twl6040_mute_path(dai->codec, dai->id, mute);
+		twl6040_mute_path(dai->component, dai->id, mute);
 		break;
 	default:
 		break;
@@ -1107,23 +1107,23 @@ static struct snd_soc_dai_driver twl6040_dai[] = {
 },
 };
 
-static int twl6040_probe(struct snd_soc_codec *codec)
+static int twl6040_probe(struct snd_soc_component *component)
 {
 	struct twl6040_data *priv;
-	struct platform_device *pdev = to_platform_device(codec->dev);
+	struct platform_device *pdev = to_platform_device(component->dev);
 	int ret = 0;
 
-	priv = devm_kzalloc(codec->dev, sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(component->dev, sizeof(*priv), GFP_KERNEL);
 	if (priv == NULL)
 		return -ENOMEM;
 
-	snd_soc_codec_set_drvdata(codec, priv);
+	snd_soc_component_set_drvdata(component, priv);
 
-	priv->codec = codec;
+	priv->component = component;
 
 	priv->plug_irq = platform_get_irq(pdev, 0);
 	if (priv->plug_irq < 0) {
-		dev_err(codec->dev, "invalid irq: %d\n", priv->plug_irq);
+		dev_err(component->dev, "invalid irq: %d\n", priv->plug_irq);
 		return priv->plug_irq;
 	}
 
@@ -1134,64 +1134,55 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 	ret = request_threaded_irq(priv->plug_irq, NULL,
 					twl6040_audio_handler,
 					IRQF_NO_SUSPEND | IRQF_ONESHOT,
-					"twl6040_irq_plug", codec);
+					"twl6040_irq_plug", component);
 	if (ret) {
-		dev_err(codec->dev, "PLUG IRQ request failed: %d\n", ret);
+		dev_err(component->dev, "PLUG IRQ request failed: %d\n", ret);
 		return ret;
 	}
 
-	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	twl6040_init_chip(codec);
+	snd_soc_component_force_bias_level(component, SND_SOC_BIAS_STANDBY);
+	twl6040_init_chip(component);
 
 	return 0;
 }
 
-static int twl6040_remove(struct snd_soc_codec *codec)
+static void twl6040_remove(struct snd_soc_component *component)
 {
-	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
+	struct twl6040_data *priv = snd_soc_component_get_drvdata(component);
 
-	free_irq(priv->plug_irq, codec);
-
-	return 0;
+	free_irq(priv->plug_irq, component);
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_twl6040 = {
-	.probe = twl6040_probe,
-	.remove = twl6040_remove,
-	.read = twl6040_read,
-	.write = twl6040_write,
-	.set_bias_level = twl6040_set_bias_level,
-	.suspend_bias_off = true,
-	.ignore_pmdown_time = true,
-
-	.component_driver = {
-		.controls		= twl6040_snd_controls,
-		.num_controls		= ARRAY_SIZE(twl6040_snd_controls),
-		.dapm_widgets		= twl6040_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(twl6040_dapm_widgets),
-		.dapm_routes		= intercon,
-		.num_dapm_routes	= ARRAY_SIZE(intercon),
-	},
+static const struct snd_soc_component_driver soc_component_dev_twl6040 = {
+	.probe			= twl6040_probe,
+	.remove			= twl6040_remove,
+	.read			= twl6040_read,
+	.remove			= twl6040_remove,
+	.set_bias_level		= twl6040_set_bias_level,
+	.controls		= twl6040_snd_controls,
+	.num_controls		= ARRAY_SIZE(twl6040_snd_controls),
+	.dapm_widgets		= twl6040_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(twl6040_dapm_widgets),
+	.dapm_routes		= intercon,
+	.num_dapm_routes	= ARRAY_SIZE(intercon),
+	.suspend_bias_off	= 1,
+	.idle_bias_on		= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static int twl6040_codec_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_twl6040,
+	return devm_snd_soc_register_component(&pdev->dev,
+				      &soc_component_dev_twl6040,
 				      twl6040_dai, ARRAY_SIZE(twl6040_dai));
 }
 
-static int twl6040_codec_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_codec(&pdev->dev);
-	return 0;
-}
-
 static struct platform_driver twl6040_codec_driver = {
 	.driver = {
 		.name = "twl6040-codec",
 	},
 	.probe = twl6040_codec_probe,
-	.remove = twl6040_codec_remove,
 };
 
 module_platform_driver(twl6040_codec_driver);
diff --git a/sound/soc/codecs/twl6040.h b/sound/soc/codecs/twl6040.h
index 0611406ca7c0..3d9f957077ef 100644
--- a/sound/soc/codecs/twl6040.h
+++ b/sound/soc/codecs/twl6040.h
@@ -34,11 +34,11 @@ enum twl6040_trim {
 #define TWL6040_HSF_TRIM_LEFT(x)	(x & 0x0f)
 #define TWL6040_HSF_TRIM_RIGHT(x)	((x >> 4) & 0x0f)
 
-int twl6040_get_dl1_gain(struct snd_soc_codec *codec);
-void twl6040_hs_jack_detect(struct snd_soc_codec *codec,
+int twl6040_get_dl1_gain(struct snd_soc_component *component);
+void twl6040_hs_jack_detect(struct snd_soc_component *component,
 			    struct snd_soc_jack *jack, int report);
-int twl6040_get_clk_id(struct snd_soc_codec *codec);
-int twl6040_get_trim_value(struct snd_soc_codec *codec, enum twl6040_trim trim);
-int twl6040_get_hs_step_size(struct snd_soc_codec *codec);
+int twl6040_get_clk_id(struct snd_soc_component *component);
+int twl6040_get_trim_value(struct snd_soc_component *component, enum twl6040_trim trim);
+int twl6040_get_hs_step_size(struct snd_soc_component *component);
 
 #endif /* End of __TWL6040_H__ */
diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
index 614b18d2f631..15ccbf479c96 100644
--- a/sound/soc/omap/omap-abe-twl6040.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -52,7 +52,7 @@ static int omap_abe_hw_params(struct snd_pcm_substream *substream,
 	int clk_id, freq;
 	int ret;
 
-	clk_id = twl6040_get_clk_id(rtd->codec);
+	clk_id = twl6040_get_clk_id(codec_dai->component);
 	if (clk_id == TWL6040_SYSCLK_SEL_HPPLL)
 		freq = priv->mclk_freq;
 	else if (clk_id == TWL6040_SYSCLK_SEL_LPPLL)
@@ -166,7 +166,7 @@ static const struct snd_soc_dapm_route audio_map[] = {
 
 static int omap_abe_twl6040_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_component *component = rtd->codec_dai->component;
 	struct snd_soc_card *card = rtd->card;
 	struct abe_twl6040 *priv = snd_soc_card_get_drvdata(card);
 	int hs_trim;
@@ -176,7 +176,7 @@ static int omap_abe_twl6040_init(struct snd_soc_pcm_runtime *rtd)
 	 * Configure McPDM offset cancellation based on the HSOTRIM value from
 	 * twl6040.
 	 */
-	hs_trim = twl6040_get_trim_value(codec, TWL6040_TRIM_HSOTRIM);
+	hs_trim = twl6040_get_trim_value(component, TWL6040_TRIM_HSOTRIM);
 	omap_mcpdm_configure_dn_offsets(rtd, TWL6040_HSF_TRIM_LEFT(hs_trim),
 					TWL6040_HSF_TRIM_RIGHT(hs_trim));
 
@@ -189,7 +189,7 @@ static int omap_abe_twl6040_init(struct snd_soc_pcm_runtime *rtd)
 		if (ret)
 			return ret;
 
-		twl6040_hs_jack_detect(codec, &hs_jack, SND_JACK_HEADSET);
+		twl6040_hs_jack_detect(component, &hs_jack, SND_JACK_HEADSET);
 	}
 
 	return 0;
-- 
2.16.1
