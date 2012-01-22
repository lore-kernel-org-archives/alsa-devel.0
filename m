From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: Provide REGULATOR_SUPPLY widget type
Date: Sun, 22 Jan 2012 15:53:37 +0000
Message-ID: <1327247619-19958-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C35A524698
	for <alsa-devel@alsa-project.org>; Sun, 22 Jan 2012 16:53:57 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Modern devices allow systems to enable and disable individual supplies on
the device, allowing additional power saving by switching off regulators
which power portions of the device which are not currently in use. Add a
new SND_SOC_DAPM_REGULATOR_SUPPLY widget type factoring out the code for
managing such widgets from individual drivers.

The widget name will be used as the supply name when requesting the
regulator from the regulator API.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    9 ++++++++
 sound/soc/soc-dapm.c     |   51 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index d26a9b7..bfa0d3c 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -243,6 +243,10 @@
 {	.id = snd_soc_dapm_supply, .name = wname, .reg = wreg,	\
 	.shift = wshift, .invert = winvert, .event = wevent, \
 	.event_flags = wflags}
+#define SND_SOC_DAPM_REGULATOR_SUPPLY(wname, wdelay) \
+{	.id = snd_soc_dapm_regulator_supply, .name = wname, \
+	.reg = SND_SOC_NOPM, .shift = wdelay, .event = dapm_regulator_event, \
+	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD }
 
 /* dapm kcontrol types */
 #define SOC_DAPM_SINGLE(xname, reg, shift, max, invert) \
@@ -322,6 +326,8 @@ struct snd_soc_dapm_context;
 
 int dapm_reg_event(struct snd_soc_dapm_widget *w,
 		   struct snd_kcontrol *kcontrol, int event);
+int dapm_regulator_event(struct snd_soc_dapm_widget *w,
+			 struct snd_kcontrol *kcontrol, int event);
 
 /* dapm controls */
 int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
@@ -411,6 +417,7 @@ enum snd_soc_dapm_type {
 	snd_soc_dapm_pre,			/* machine specific pre widget - exec first */
 	snd_soc_dapm_post,			/* machine specific post widget - exec last */
 	snd_soc_dapm_supply,		/* power/clock supply */
+	snd_soc_dapm_regulator_supply,	/* external regulator */
 	snd_soc_dapm_aif_in,		/* audio interface input */
 	snd_soc_dapm_aif_out,		/* audio interface output */
 	snd_soc_dapm_siggen,		/* signal generator */
@@ -465,6 +472,8 @@ struct snd_soc_dapm_widget {
 	struct list_head list;
 	struct snd_soc_dapm_context *dapm;
 
+	void *priv;				/* widget specific data */
+
 	/* dapm control */
 	short reg;						/* negative reg = no direct dapm */
 	unsigned char shift;			/* bits to shift */
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 541bcbf..131508a 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -40,6 +40,7 @@
 #include <linux/jiffies.h>
 #include <linux/debugfs.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -55,6 +56,7 @@
 static int dapm_up_seq[] = {
 	[snd_soc_dapm_pre] = 0,
 	[snd_soc_dapm_supply] = 1,
+	[snd_soc_dapm_regulator_supply] = 1,
 	[snd_soc_dapm_micbias] = 2,
 	[snd_soc_dapm_aif_in] = 3,
 	[snd_soc_dapm_aif_out] = 3,
@@ -90,6 +92,7 @@ static int dapm_down_seq[] = {
 	[snd_soc_dapm_value_mux] = 9,
 	[snd_soc_dapm_aif_in] = 10,
 	[snd_soc_dapm_aif_out] = 10,
+	[snd_soc_dapm_regulator_supply] = 11,
 	[snd_soc_dapm_supply] = 11,
 	[snd_soc_dapm_post] = 12,
 };
@@ -352,6 +355,7 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 	case snd_soc_dapm_micbias:
 	case snd_soc_dapm_vmid:
 	case snd_soc_dapm_supply:
+	case snd_soc_dapm_regulator_supply:
 	case snd_soc_dapm_aif_in:
 	case snd_soc_dapm_aif_out:
 	case snd_soc_dapm_hp:
@@ -680,8 +684,13 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget)
 
 	DAPM_UPDATE_STAT(widget, path_checks);
 
-	if (widget->id == snd_soc_dapm_supply)
+	switch (widget->id) {
+	case snd_soc_dapm_supply:
+	case snd_soc_dapm_regulator_supply:
 		return 0;
+	default:
+		break;
+	}
 
 	switch (widget->id) {
 	case snd_soc_dapm_adc:
@@ -745,8 +754,13 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget)
 
 	DAPM_UPDATE_STAT(widget, path_checks);
 
-	if (widget->id == snd_soc_dapm_supply)
+	switch (widget->id) {
+	case snd_soc_dapm_supply:
+	case snd_soc_dapm_regulator_supply:
 		return 0;
+	default:
+		break;
+	}
 
 	/* active stream ? */
 	switch (widget->id) {
@@ -828,6 +842,19 @@ int dapm_reg_event(struct snd_soc_dapm_widget *w,
 }
 EXPORT_SYMBOL_GPL(dapm_reg_event);
 
+/*
+ * Handler for regulator supply widget.
+ */
+int dapm_regulator_event(struct snd_soc_dapm_widget *w,
+		   struct snd_kcontrol *kcontrol, int event)
+{
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		return regulator_enable(w->priv);
+	else
+		return regulator_disable_deferred(w->priv, w->shift);
+}
+EXPORT_SYMBOL_GPL(dapm_regulator_event);
+
 static int dapm_widget_power_check(struct snd_soc_dapm_widget *w)
 {
 	if (w->power_checked)
@@ -1308,6 +1335,7 @@ static void dapm_widget_set_power(struct snd_soc_dapm_widget *w, bool power,
 	}
 	switch (w->id) {
 	case snd_soc_dapm_supply:
+	case snd_soc_dapm_regulator_supply:
 		/* Supplies can't affect their outputs, only their inputs */
 		break;
 	default:
@@ -1411,6 +1439,7 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 			 */
 			switch (w->id) {
 			case snd_soc_dapm_supply:
+			case snd_soc_dapm_regulator_supply:
 			case snd_soc_dapm_micbias:
 				if (d->target_bias_level < SND_SOC_BIAS_STANDBY)
 					d->target_bias_level = SND_SOC_BIAS_STANDBY;
@@ -1769,6 +1798,7 @@ static ssize_t dapm_widget_show(struct device *dev,
 		case snd_soc_dapm_mixer:
 		case snd_soc_dapm_mixer_named_ctl:
 		case snd_soc_dapm_supply:
+		case snd_soc_dapm_regulator_supply:
 			if (w->name)
 				count += sprintf(buf + count, "%s: %s\n",
 					w->name, w->power ? "On":"Off");
@@ -2007,6 +2037,7 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 	case snd_soc_dapm_pre:
 	case snd_soc_dapm_post:
 	case snd_soc_dapm_supply:
+	case snd_soc_dapm_regulator_supply:
 	case snd_soc_dapm_aif_in:
 	case snd_soc_dapm_aif_out:
 		list_add(&path->list, &dapm->card->paths);
@@ -2673,10 +2704,25 @@ int snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 {
 	struct snd_soc_dapm_widget *w;
 	size_t name_len;
+	int ret;
 
 	if ((w = dapm_cnew_widget(widget)) == NULL)
 		return -ENOMEM;
 
+	switch (w->id) {
+	case snd_soc_dapm_regulator_supply:
+		w->priv = devm_regulator_get(dapm->dev, w->name);
+		if (IS_ERR(w->priv)) {
+			ret = PTR_ERR(w->priv);
+			dev_err(dapm->dev, "Failed to request %s: %d\n",
+				w->name, ret);
+			return ret;
+		}
+		break;
+	default:
+		break;
+	}
+
 	name_len = strlen(widget->name) + 1;
 	if (dapm->codec && dapm->codec->name_prefix)
 		name_len += 1 + strlen(dapm->codec->name_prefix);
@@ -2722,6 +2768,7 @@ int snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 		w->power_check = dapm_generic_check_power;
 		break;
 	case snd_soc_dapm_supply:
+	case snd_soc_dapm_regulator_supply:
 		w->power_check = dapm_supply_check_power;
 		break;
 	default:
-- 
1.7.7.3
