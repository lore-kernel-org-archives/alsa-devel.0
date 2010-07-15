From: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Subject: [PATCH v2] ASoC: TWL6040: Correct widget handling for
	drivers
Date: Thu, 15 Jul 2010 11:38:01 -0500
Message-ID: <1279211881-31416-1-git-send-email-jorge.candelaria@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D7C6103816
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Jul 2010 18:40:27 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com
Cc: Margarita Olaya Cabrera <magi.olaya@ti.com>, Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
List-Id: alsa-devel@alsa-project.org

In order to reduce pop-noise at powering up/down of the DACs and Drivers,
these components have to be handled in a specific sequence. Headset,
Handsfree, and Earphone drivers are now registered as PGA components to
ensure DACs are enabled first.

Also, add a delay to leave time for DACs to settle before
continuing power up/down sequence.

Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
---
 sound/soc/codecs/twl6040.c |   56 ++++++++++++++++++++++----------------------
 1 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 715caef..345d86a 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -360,6 +360,13 @@ static int headset_power_mode(struct snd_soc_codec *codec, int high_perf)
 	return 0;
 }
 
+static int twl6040_hs_dac_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *kcontrol, int event)
+{
+	msleep(1);
+	return 0;
+}
+
 static int twl6040_power_mode_event(struct snd_soc_dapm_widget *w,
 			struct snd_kcontrol *kcontrol, int event)
 {
@@ -371,6 +378,8 @@ static int twl6040_power_mode_event(struct snd_soc_dapm_widget *w,
 	else
 		priv->non_lp--;
 
+	msleep(1);
+
 	return 0;
 }
 
@@ -471,20 +480,6 @@ static const struct snd_kcontrol_new hfdacl_switch_controls =
 static const struct snd_kcontrol_new hfdacr_switch_controls =
 	SOC_DAPM_SINGLE("Switch", TWL6040_REG_HFRCTL, 2, 1, 0);
 
-/* Headset driver switches */
-static const struct snd_kcontrol_new hsl_driver_switch_controls =
-	SOC_DAPM_SINGLE("Switch", TWL6040_REG_HSLCTL, 2, 1, 0);
-
-static const struct snd_kcontrol_new hsr_driver_switch_controls =
-	SOC_DAPM_SINGLE("Switch", TWL6040_REG_HSRCTL, 2, 1, 0);
-
-/* Handsfree driver switches */
-static const struct snd_kcontrol_new hfl_driver_switch_controls =
-	SOC_DAPM_SINGLE("Switch", TWL6040_REG_HFLCTL, 4, 1, 0);
-
-static const struct snd_kcontrol_new hfr_driver_switch_controls =
-	SOC_DAPM_SINGLE("Switch", TWL6040_REG_HFRCTL, 4, 1, 0);
-
 static const struct snd_kcontrol_new ep_driver_switch_controls =
 	SOC_DAPM_SINGLE("Switch", TWL6040_REG_EARCTL, 0, 1, 0);
 
@@ -548,10 +543,14 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 			TWL6040_REG_DMICBCTL, 4, 0),
 
 	/* DACs */
-	SND_SOC_DAPM_DAC("HSDAC Left", "Headset Playback",
-			TWL6040_REG_HSLCTL, 0, 0),
-	SND_SOC_DAPM_DAC("HSDAC Right", "Headset Playback",
-			TWL6040_REG_HSRCTL, 0, 0),
+	SND_SOC_DAPM_DAC_E("HSDAC Left", "Headset Playback",
+			TWL6040_REG_HSLCTL, 0, 0,
+			twl6040_hs_dac_event,
+			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_DAC_E("HSDAC Right", "Headset Playback",
+			TWL6040_REG_HSRCTL, 0, 0,
+			twl6040_hs_dac_event,
+			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_DAC_E("HFDAC Left", "Handsfree Playback",
 			TWL6040_REG_HFLCTL, 0, 0,
 			twl6040_power_mode_event,
@@ -571,18 +570,19 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 	SND_SOC_DAPM_SWITCH("HFDAC Right Playback",
 			SND_SOC_NOPM, 0, 0, &hfdacr_switch_controls),
 
-	SND_SOC_DAPM_SWITCH("Headset Left Driver",
-			SND_SOC_NOPM, 0, 0, &hsl_driver_switch_controls),
-	SND_SOC_DAPM_SWITCH("Headset Right Driver",
-			SND_SOC_NOPM, 0, 0, &hsr_driver_switch_controls),
-	SND_SOC_DAPM_SWITCH_E("Handsfree Left Driver",
-			SND_SOC_NOPM, 0, 0, &hfl_driver_switch_controls,
+	/* Analog playback drivers */
+	SND_SOC_DAPM_PGA_E("Handsfree Left Driver",
+			TWL6040_REG_HFLCTL, 4, 0, NULL, 0,
 			twl6040_power_mode_event,
 			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
-	SND_SOC_DAPM_SWITCH_E("Handsfree Right Driver",
-			SND_SOC_NOPM, 0, 0, &hfr_driver_switch_controls,
+	SND_SOC_DAPM_PGA_E("Handsfree Right Driver",
+			TWL6040_REG_HFRCTL, 4, 0, NULL, 0,
 			twl6040_power_mode_event,
 			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_PGA("Headset Left Driver",
+			TWL6040_REG_HSLCTL, 2, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Headset Right Driver",
+			TWL6040_REG_HSRCTL, 2, 0, NULL, 0),
 	SND_SOC_DAPM_SWITCH_E("Earphone Driver",
 			SND_SOC_NOPM, 0, 0, &ep_driver_switch_controls,
 			twl6040_power_mode_event,
@@ -616,8 +616,8 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"HSDAC Left Playback", "Switch", "HSDAC Left"},
 	{"HSDAC Right Playback", "Switch", "HSDAC Right"},
 
-	{"Headset Left Driver", "Switch", "HSDAC Left Playback"},
-	{"Headset Right Driver", "Switch", "HSDAC Right Playback"},
+	{"Headset Left Driver", NULL, "HSDAC Left Playback"},
+	{"Headset Right Driver", NULL, "HSDAC Right Playback"},
 
 	{"HSOL", NULL, "Headset Left Driver"},
 	{"HSOR", NULL, "Headset Right Driver"},
-- 
1.7.0.4
