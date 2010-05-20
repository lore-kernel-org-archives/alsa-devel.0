From: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Subject: [PATCH 2/2] ASoC: TWL6040: Correct widget handling for
	drivers
Date: Thu, 20 May 2010 17:53:08 -0500
Message-ID: <1274395988-19801-3-git-send-email-jorge.candelaria@ti.com>
References: <1274395988-19801-1-git-send-email-jorge.candelaria@ti.com>
	<1274395988-19801-2-git-send-email-jorge.candelaria@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id DBBA51037F2
	for <alsa-devel@alsa-project.org>;
	Fri, 21 May 2010 01:05:26 +0200 (CEST)
In-Reply-To: <1274395988-19801-2-git-send-email-jorge.candelaria@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Margarita Olaya Cabrera <magi.olaya@ti.com>, Jorge Eduardo Candelaria <jorge.candelaria@ti.com>, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

In order to reduce pop-noise at powering up/down of the DACs and Drivers,
these components have to be handled in a specific sequence. Headset,
Handsfree, and Earphone drivers are now registered as PGA components to
ensure DACs are enabled first.

Also, add a pop_time of 1 ms to leave time for DACs to settle before
continuing power up/down sequence.

Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
---
 sound/soc/codecs/twl6040.c |   36 ++++++++++++------------------------
 1 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 85dd4fb..746c569 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -471,20 +471,6 @@ static const struct snd_kcontrol_new hfdacl_switch_controls =
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
 
@@ -571,18 +557,19 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
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
@@ -616,8 +603,8 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"HSDAC Left Playback", "Switch", "HSDAC Left"},
 	{"HSDAC Right Playback", "Switch", "HSDAC Right"},
 
-	{"Headset Left Driver", "Switch", "HSDAC Left Playback"},
-	{"Headset Right Driver", "Switch", "HSDAC Right Playback"},
+	{"Headset Left Driver", NULL, "HSDAC Left Playback"},
+	{"Headset Right Driver", NULL, "HSDAC Right Playback"},
 
 	{"HSOL", NULL, "Headset Left Driver"},
 	{"HSOR", NULL, "Headset Right Driver"},
@@ -1105,6 +1092,7 @@ static int __devinit twl6040_codec_probe(struct platform_device *pdev)
 	priv->naudint = naudint;
 
 	codec = &priv->codec;
+	codec->pop_time = 1;
 	codec->dev = &pdev->dev;
 	twl6040_dai.dev = &pdev->dev;
 
-- 
1.6.3.3
