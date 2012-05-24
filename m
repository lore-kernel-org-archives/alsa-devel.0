From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH 2/5] ASoC: core: Add widget
	SND_SOC_DAPM_CLOCK_SUPPLY
Date: Thu, 24 May 2012 15:26:25 +0200
Message-ID: <1337865985-26077-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog107.obsmtp.com (eu1sys200aog107.obsmtp.com
	[207.126.144.123])
	by alsa0.perex.cz (Postfix) with ESMTP id A91EE244A7
	for <alsa-devel@alsa-project.org>;
	Thu, 24 May 2012 15:26:33 +0200 (CEST)
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
 include/sound/soc-dapm.h |   10 ++++++++++
 sound/soc/soc-dapm.c     |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index e3833d9..05559e5 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -229,6 +229,10 @@ struct device;
 {	.id = snd_soc_dapm_adc, .name = wname, .sname = stname, .reg = wreg, \
 	.shift = wshift, .invert = winvert, \
 	.event = wevent, .event_flags = wflags}
+#define SND_SOC_DAPM_CLOCK_SUPPLY(wname) \
+{	.id = snd_soc_dapm_clock_supply, .name = wname, \
+	.reg = SND_SOC_NOPM, .event = dapm_clock_event, \
+	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD }
 
 /* generic widgets */
 #define SND_SOC_DAPM_REG(wid, wname, wreg, wshift, wmask, won_val, woff_val) \
@@ -245,6 +249,7 @@ struct device;
 	.reg = SND_SOC_NOPM, .shift = wdelay, .event = dapm_regulator_event, \
 	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD }
 
+
 /* dapm kcontrol types */
 #define SOC_DAPM_SINGLE(xname, reg, shift, max, invert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
@@ -327,6 +332,8 @@ int dapm_reg_event(struct snd_soc_dapm_widget *w,
 		   struct snd_kcontrol *kcontrol, int event);
 int dapm_regulator_event(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol, int event);
+int dapm_clock_event(struct snd_soc_dapm_widget *w,
+			 struct snd_kcontrol *kcontrol, int event);
 
 /* dapm controls */
 int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
@@ -432,6 +439,7 @@ enum snd_soc_dapm_type {
 	snd_soc_dapm_post,			/* machine specific post widget - exec last */
 	snd_soc_dapm_supply,		/* power/clock supply */
 	snd_soc_dapm_regulator_supply,	/* external regulator */
+	snd_soc_dapm_clock_supply,	/* external clock */
 	snd_soc_dapm_aif_in,		/* audio interface input */
 	snd_soc_dapm_aif_out,		/* audio interface output */
 	snd_soc_dapm_siggen,		/* signal generator */
@@ -537,6 +545,8 @@ struct snd_soc_dapm_widget {
 	struct list_head dirty;
 	int inputs;
 	int outputs;
+
+	struct clk *clk;
 };
 
 struct snd_soc_dapm_update {
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 90ee77d..3bb7a6f 100644
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
 	[snd_soc_dapm_dai_link] = 2,
 	[snd_soc_dapm_dai] = 3,
@@ -92,6 +94,7 @@ static int dapm_down_seq[] = {
 	[snd_soc_dapm_aif_out] = 10,
 	[snd_soc_dapm_dai] = 10,
 	[snd_soc_dapm_dai_link] = 11,
+	[snd_soc_dapm_clock_supply] = 12,
 	[snd_soc_dapm_regulator_supply] = 12,
 	[snd_soc_dapm_supply] = 12,
 	[snd_soc_dapm_post] = 13,
@@ -391,6 +394,7 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 	case snd_soc_dapm_vmid:
 	case snd_soc_dapm_supply:
 	case snd_soc_dapm_regulator_supply:
+	case snd_soc_dapm_clock_supply:
 	case snd_soc_dapm_aif_in:
 	case snd_soc_dapm_aif_out:
 	case snd_soc_dapm_dai:
@@ -764,6 +768,7 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget,
 	switch (widget->id) {
 	case snd_soc_dapm_supply:
 	case snd_soc_dapm_regulator_supply:
+	case snd_soc_dapm_clock_supply:
 		return 0;
 	default:
 		break;
@@ -850,6 +855,7 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget,
 	switch (widget->id) {
 	case snd_soc_dapm_supply:
 	case snd_soc_dapm_regulator_supply:
+	case snd_soc_dapm_clock_supply:
 		return 0;
 	default:
 		break;
@@ -996,6 +1002,24 @@ int dapm_regulator_event(struct snd_soc_dapm_widget *w,
 }
 EXPORT_SYMBOL_GPL(dapm_regulator_event);
 
+/*
+ * Handler for clock supply widget.
+ */
+int dapm_clock_event(struct snd_soc_dapm_widget *w,
+		   struct snd_kcontrol *kcontrol, int event)
+{
+	if (!w->clk)
+		return -EIO;
+
+	if (SND_SOC_DAPM_EVENT_ON(event)) {
+		return clk_enable(w->clk);
+	} else {
+		clk_disable(w->clk);
+		return 0;
+	}
+}
+EXPORT_SYMBOL_GPL(dapm_clock_event);
+
 static int dapm_widget_power_check(struct snd_soc_dapm_widget *w)
 {
 	if (w->power_checked)
@@ -1487,6 +1511,7 @@ static void dapm_widget_set_power(struct snd_soc_dapm_widget *w, bool power,
 	switch (w->id) {
 	case snd_soc_dapm_supply:
 	case snd_soc_dapm_regulator_supply:
+	case snd_soc_dapm_clock_supply:
 		/* Supplies can't affect their outputs, only their inputs */
 		break;
 	default:
@@ -1587,6 +1612,7 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 				break;
 			case snd_soc_dapm_supply:
 			case snd_soc_dapm_regulator_supply:
+			case snd_soc_dapm_clock_supply:
 			case snd_soc_dapm_micbias:
 				if (d->target_bias_level < SND_SOC_BIAS_STANDBY)
 					d->target_bias_level = SND_SOC_BIAS_STANDBY;
@@ -1941,6 +1967,7 @@ static ssize_t dapm_widget_show(struct device *dev,
 		case snd_soc_dapm_mixer_named_ctl:
 		case snd_soc_dapm_supply:
 		case snd_soc_dapm_regulator_supply:
+		case snd_soc_dapm_clock_supply:
 			if (w->name)
 				count += sprintf(buf + count, "%s: %s\n",
 					w->name, w->power ? "On":"Off");
@@ -2187,6 +2214,7 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 	case snd_soc_dapm_post:
 	case snd_soc_dapm_supply:
 	case snd_soc_dapm_regulator_supply:
+	case snd_soc_dapm_clock_supply:
 	case snd_soc_dapm_aif_in:
 	case snd_soc_dapm_aif_out:
 	case snd_soc_dapm_dai:
@@ -2873,6 +2901,15 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 			return NULL;
 		}
 		break;
+	case snd_soc_dapm_clock_supply:
+		w->clk = clk_get(dapm->dev, w->name);
+		if (IS_ERR(w->clk)) {
+			ret = PTR_ERR(w->clk);
+			dev_err(dapm->dev, "Failed to request %s: %d\n",
+				w->name, ret);
+			return NULL;
+		}
+		break;
 	default:
 		break;
 	}
@@ -2924,6 +2961,7 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 		break;
 	case snd_soc_dapm_supply:
 	case snd_soc_dapm_regulator_supply:
+	case snd_soc_dapm_clock_supply:
 		w->power_check = dapm_supply_check_power;
 		break;
 	case snd_soc_dapm_dai:
-- 
1.7.8.3
