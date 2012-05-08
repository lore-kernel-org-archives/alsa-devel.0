From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH 03/11] ASoC: core: Add widget
	SND_SOC_DAPM_CLOCK_SUPPLY
Date: Tue, 8 May 2012 15:56:40 +0200
Message-ID: <1336485400-27150-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog105.obsmtp.com (eu1sys200aog105.obsmtp.com
	[207.126.144.119])
	by alsa0.perex.cz (Postfix) with ESMTP id 78401244BB
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 15:56:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

Adds a supply-widget variant for connection to the clock-framework.
This widget-type corresponds to the variant for regulators.

Signed-off-by: Ola Lilja <ola.o.lilja@stericsson.com>
---
 include/sound/soc-dapm.h |    9 +++++++
 sound/soc/soc-dapm.c     |   59 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 1649ef2..0e7ab1e 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -248,6 +248,10 @@ struct device;
 {	.id = snd_soc_dapm_regulator_supply, .name = wname, \
 	.reg = SND_SOC_NOPM, .shift = wdelay, .event = dapm_regulator_event, \
 	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD }
+#define SND_SOC_DAPM_CLOCK_SUPPLY(wname, is_sys) \
+{	.id = snd_soc_dapm_clock_supply, .name = wname, \
+	.reg = SND_SOC_NOPM, .shift = is_sys , .event = dapm_clock_event, \
+	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD }
 
 /* dapm kcontrol types */
 #define SOC_DAPM_SINGLE(xname, reg, shift, max, invert) \
@@ -329,6 +333,8 @@ int dapm_reg_event(struct snd_soc_dapm_widget *w,
 		   struct snd_kcontrol *kcontrol, int event);
 int dapm_regulator_event(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol, int event);
+int dapm_clock_event(struct snd_soc_dapm_widget *w,
+			 struct snd_kcontrol *kcontrol, int event);
 
 /* dapm controls */
 int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
@@ -401,6 +407,8 @@ void snd_soc_dapm_auto_nc_codec_pins(struct snd_soc_codec *codec);
 
 int snd_soc_dapm_get_regulator_status(struct snd_soc_dapm_context *dapm,
 				const char *pin);
+int snd_soc_dapm_get_power_status(struct snd_soc_dapm_context *dapm,
+				const char *pin);
 
 /* Mostly internal - should not normally be used */
 void dapm_mark_dirty(struct snd_soc_dapm_widget *w, const char *reason);
@@ -429,6 +437,7 @@ enum snd_soc_dapm_type {
 	snd_soc_dapm_post,			/* machine specific post widget - exec last */
 	snd_soc_dapm_supply,		/* power/clock supply */
 	snd_soc_dapm_regulator_supply,	/* external regulator */
+	snd_soc_dapm_clock_supply,	/* external clock */
 	snd_soc_dapm_aif_in,		/* audio interface input */
 	snd_soc_dapm_aif_out,		/* audio interface output */
 	snd_soc_dapm_siggen,		/* signal generator */
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index b6c9df5..8649c1f 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -35,6 +35,7 @@
 #include <linux/debugfs.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
+#include <linux/clk.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -51,6 +52,7 @@ static int dapm_up_seq[] = {
 	[snd_soc_dapm_pre] = 0,
 	[snd_soc_dapm_supply] = 1,
 	[snd_soc_dapm_regulator_supply] = 1,
+	[snd_soc_dapm_clock_supply] = 1,
 	[snd_soc_dapm_micbias] = 2,
 	[snd_soc_dapm_dai] = 3,
 	[snd_soc_dapm_aif_in] = 3,
@@ -88,6 +90,7 @@ static int dapm_down_seq[] = {
 	[snd_soc_dapm_aif_in] = 10,
 	[snd_soc_dapm_aif_out] = 10,
 	[snd_soc_dapm_dai] = 10,
+	[snd_soc_dapm_clock_supply] = 11,
 	[snd_soc_dapm_regulator_supply] = 11,
 	[snd_soc_dapm_supply] = 11,
 	[snd_soc_dapm_post] = 12,
@@ -365,6 +368,7 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 	case snd_soc_dapm_vmid:
 	case snd_soc_dapm_supply:
 	case snd_soc_dapm_regulator_supply:
+	case snd_soc_dapm_clock_supply:
 	case snd_soc_dapm_aif_in:
 	case snd_soc_dapm_aif_out:
 	case snd_soc_dapm_dai:
@@ -697,6 +701,7 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget)
 	switch (widget->id) {
 	case snd_soc_dapm_supply:
 	case snd_soc_dapm_regulator_supply:
+	case snd_soc_dapm_clock_supply:
 		return 0;
 	default:
 		break;
@@ -768,6 +773,7 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget)
 	switch (widget->id) {
 	case snd_soc_dapm_supply:
 	case snd_soc_dapm_regulator_supply:
+	case snd_soc_dapm_clock_supply:
 		return 0;
 	default:
 		break;
@@ -857,6 +863,21 @@ EXPORT_SYMBOL_GPL(dapm_reg_event);
 /*
  * Handler for regulator supply widget.
  */
+int dapm_clock_event(struct snd_soc_dapm_widget *w,
+		   struct snd_kcontrol *kcontrol, int event)
+{
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		return clk_enable(w->priv);
+	else {
+		clk_disable(w->priv);
+		return 0;
+	}
+}
+EXPORT_SYMBOL_GPL(dapm_clock_event);
+
+/*
+ * Handler for clock supply widget.
+ */
 int dapm_regulator_event(struct snd_soc_dapm_widget *w,
 		   struct snd_kcontrol *kcontrol, int event)
 {
@@ -1355,6 +1376,7 @@ static void dapm_widget_set_power(struct snd_soc_dapm_widget *w, bool power,
 	switch (w->id) {
 	case snd_soc_dapm_supply:
 	case snd_soc_dapm_regulator_supply:
+	case snd_soc_dapm_clock_supply:
 		/* Supplies can't affect their outputs, only their inputs */
 		break;
 	default:
@@ -1457,6 +1479,7 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 				break;
 			case snd_soc_dapm_supply:
 			case snd_soc_dapm_regulator_supply:
+			case snd_soc_dapm_clock_supply:
 			case snd_soc_dapm_micbias:
 				if (d->target_bias_level < SND_SOC_BIAS_STANDBY)
 					d->target_bias_level = SND_SOC_BIAS_STANDBY;
@@ -1809,6 +1832,7 @@ static ssize_t dapm_widget_show(struct device *dev,
 		case snd_soc_dapm_mixer_named_ctl:
 		case snd_soc_dapm_supply:
 		case snd_soc_dapm_regulator_supply:
+		case snd_soc_dapm_clock_supply:
 			if (w->name)
 				count += sprintf(buf + count, "%s: %s\n",
 					w->name, w->power ? "On":"Off");
@@ -2050,6 +2074,7 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 	case snd_soc_dapm_post:
 	case snd_soc_dapm_supply:
 	case snd_soc_dapm_regulator_supply:
+	case snd_soc_dapm_clock_supply:
 	case snd_soc_dapm_aif_in:
 	case snd_soc_dapm_aif_out:
 	case snd_soc_dapm_dai:
@@ -2723,6 +2748,16 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 			return NULL;
 		}
 		break;
+	case snd_soc_dapm_clock_supply:
+		w->priv = (w->shift) ? clk_get_sys(w->name, NULL) :
+				clk_get(dapm->dev, w->name);
+		if (IS_ERR(w->priv)) {
+			ret = PTR_ERR(w->priv);
+			dev_err(dapm->dev, "Failed to request %s: %d\n",
+				w->name, ret);
+			return NULL;
+		}
+		break;
 	default:
 		break;
 	}
@@ -2773,6 +2808,7 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 		break;
 	case snd_soc_dapm_supply:
 	case snd_soc_dapm_regulator_supply:
+	case snd_soc_dapm_clock_supply:
 		w->power_check = dapm_supply_check_power;
 		break;
 	case snd_soc_dapm_dai:
@@ -3114,6 +3150,29 @@ int snd_soc_dapm_get_regulator_status(struct snd_soc_dapm_context *dapm,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_get_regulator_status);
 
+ /**
+ * snd_soc_dapm_get_power_status - get widget power status
+ * @dapm: DAPM context
+ * @pin: Widget name
+ *
+ * Get widget power status - Enabled or disabled.
+ *
+ * Returns -1 for failure.
+ * Returns 0 if disabled.
+ * Returns 1 if enabled.
+ */
+int snd_soc_dapm_get_power_status(struct snd_soc_dapm_context *dapm,
+				const char *pin)
+{
+	struct snd_soc_dapm_widget *w = dapm_find_widget(dapm, pin, true);
+
+	if (!w)
+		return -1;
+
+	return w->power;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_get_power_status);
+
 /**
  * snd_soc_dapm_ignore_suspend - ignore suspend status for DAPM endpoint
  * @dapm: DAPM context
-- 
1.7.8.3
