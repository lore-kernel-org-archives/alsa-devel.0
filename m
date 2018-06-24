From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/2] ASoC: rt5651: Add support for external
	amplifier enable GPIO
Date: Sun, 24 Jun 2018 15:02:46 +0200
Message-ID: <20180624130247.18150-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id D099B267353
 for <alsa-devel@alsa-project.org>; Sun, 24 Jun 2018 15:02:53 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

The rt5651 does not have a built-in speaker amplifier, so it is often
used together with an external amplifier. On some boards the external
amplifier's enable pin is driven through a GPIO, add support for this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/codecs/rt5651.c | 43 +++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/rt5651.h |  2 ++
 2 files changed, 45 insertions(+)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 6b5669f3e85d..e5db8883ee9f 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/acpi.h>
+#include <linux/gpio/consumer.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -717,6 +718,26 @@ static int rt5651_amp_power_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int rt5651_ext_amp_power_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct rt5651_priv *rt5651 = snd_soc_component_get_drvdata(component);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		gpiod_set_value_cansleep(rt5651->ext_amp_gpio, 1);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		gpiod_set_value_cansleep(rt5651->ext_amp_gpio, 0);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static int rt5651_hp_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
@@ -1057,6 +1078,9 @@ static const struct snd_soc_dapm_widget rt5651_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("Amp Power", RT5651_PWR_ANLG1,
 			    RT5651_PWR_HA_BIT, 0, rt5651_amp_power_event,
 			    SND_SOC_DAPM_POST_PMU),
+	SND_SOC_DAPM_SUPPLY("Ext Amp Power", SND_SOC_NOPM, 0, 0,
+			    rt5651_ext_amp_power_event,
+			    SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
 	SND_SOC_DAPM_PGA_S("HP Amp", 1, SND_SOC_NOPM, 0, 0, rt5651_hp_event,
 			   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
 	SND_SOC_DAPM_SWITCH("HPO L Playback", SND_SOC_NOPM, 0, 0,
@@ -1272,8 +1296,10 @@ static const struct snd_soc_dapm_route rt5651_dapm_routes[] = {
 	{"LOUT R Playback", "Switch", "LOUT MIX"},
 	{"LOUTL", NULL, "LOUT L Playback"},
 	{"LOUTL", NULL, "Amp Power"},
+	{"LOUTL", NULL, "Ext Amp Power"},
 	{"LOUTR", NULL, "LOUT R Playback"},
 	{"LOUTR", NULL, "Amp Power"},
+	{"LOUTR", NULL, "Ext Amp Power"},
 
 	{"PDML", NULL, "PDM L Mux"},
 	{"PDMR", NULL, "PDM R Mux"},
@@ -1857,6 +1883,23 @@ static int rt5651_probe(struct snd_soc_component *component)
 
 	rt5651_apply_properties(component);
 
+	/*
+	 * Needs to be done from component-probe() and not i2c-probe(), so that
+	 * the platform driver can add GPIO mappings if necessary.
+	 */
+	rt5651->ext_amp_gpio = devm_gpiod_get_optional(component->dev,
+						       "ext-amp-enable",
+						       GPIOD_OUT_LOW);
+	if (IS_ERR(rt5651->ext_amp_gpio)) {
+		int err = PTR_ERR(rt5651->ext_amp_gpio);
+
+		if (err != -EPROBE_DEFER)
+			dev_err(component->dev, "Failed to get ext-amp GPIO: %d\n",
+				err);
+
+		return err;
+	}
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/rt5651.h b/sound/soc/codecs/rt5651.h
index 3a0968c53fde..267a71395bd7 100644
--- a/sound/soc/codecs/rt5651.h
+++ b/sound/soc/codecs/rt5651.h
@@ -12,6 +12,7 @@
 #ifndef __RT5651_H__
 #define __RT5651_H__
 
+#include <linux/gpio/consumer.h>
 #include <dt-bindings/sound/rt5651.h>
 
 /* Info */
@@ -2071,6 +2072,7 @@ struct rt5651_pll_code {
 struct rt5651_priv {
 	struct snd_soc_component *component;
 	struct regmap *regmap;
+	struct gpio_desc *ext_amp_gpio;
 	struct snd_soc_jack *hp_jack;
 	struct work_struct jack_detect_work;
 	unsigned int jd_src;
-- 
2.17.1
