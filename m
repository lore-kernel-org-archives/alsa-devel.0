From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 13/17] ASoC: twl6040: Use consistent names for
	Headset path
Date: Thu, 15 Sep 2011 15:39:35 +0300
Message-ID: <1316090379-30760-14-git-send-email-peter.ujfalusi@ti.com>
References: <1316090379-30760-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog114.obsmtp.com (na3sys009aog114.obsmtp.com
	[74.125.149.211])
	by alsa0.perex.cz (Postfix) with ESMTP id 592B6103B72
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Sep 2011 14:40:42 +0200 (CEST)
Received: by mail-bw0-f48.google.com with SMTP id zu5so4201873bkb.21
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2011 05:40:41 -0700 (PDT)
In-Reply-To: <1316090379-30760-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <samuel.ortiz@intel.com>, Dmitry Torokhov <dtor@mail.ru>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Use "Headset XYZ" for user visible controls, while the internal DAPM
widgets can use "HS XYZ".
In this way we can group the Headset related controls in UI
(alsamixer for example).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 858bfd4..035803c 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1159,9 +1159,9 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 	SND_SOC_DAPM_MUX("Handsfree Right Playback",
 			SND_SOC_NOPM, 0, 0, &hfr_mux_controls),
 	/* Analog playback Muxes */
-	SND_SOC_DAPM_MUX("HS Left Playback",
+	SND_SOC_DAPM_MUX("Headset Left Playback",
 			SND_SOC_NOPM, 0, 0, &hsl_mux_controls),
-	SND_SOC_DAPM_MUX("HS Right Playback",
+	SND_SOC_DAPM_MUX("Headset Right Playback",
 			SND_SOC_NOPM, 0, 0, &hsr_mux_controls),
 
 	SND_SOC_DAPM_SWITCH("Earphone Playback", SND_SOC_NOPM, 0, 0,
@@ -1176,11 +1176,11 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 			TWL6040_REG_HFRCTL, 4, 0, NULL, 0,
 			pga_event,
 			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
-	SND_SOC_DAPM_OUT_DRV_E("Headset Left Driver",
+	SND_SOC_DAPM_OUT_DRV_E("HS Left Driver",
 			TWL6040_REG_HSLCTL, 2, 0, NULL, 0,
 			pga_event,
 			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
-	SND_SOC_DAPM_OUT_DRV_E("Headset Right Driver",
+	SND_SOC_DAPM_OUT_DRV_E("HS Right Driver",
 			TWL6040_REG_HSRCTL, 2, 0, NULL, 0,
 			pga_event,
 			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
@@ -1217,17 +1217,17 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"AFMAmpL", NULL, "AFML"},
 	{"AFMAmpR", NULL, "AFMR"},
 
-	{"HS Left Playback", "HS DAC", "HSDAC Left"},
-	{"HS Left Playback", "Line-In amp", "AFMAmpL"},
+	{"Headset Left Playback", "HS DAC", "HSDAC Left"},
+	{"Headset Left Playback", "Line-In amp", "AFMAmpL"},
 
-	{"HS Right Playback", "HS DAC", "HSDAC Right"},
-	{"HS Right Playback", "Line-In amp", "AFMAmpR"},
+	{"Headset Right Playback", "HS DAC", "HSDAC Right"},
+	{"Headset Right Playback", "Line-In amp", "AFMAmpR"},
 
-	{"Headset Left Driver", NULL, "HS Left Playback"},
-	{"Headset Right Driver", NULL, "HS Right Playback"},
+	{"HS Left Driver", NULL, "Headset Left Playback"},
+	{"HS Right Driver", NULL, "Headset Right Playback"},
 
-	{"HSOL", NULL, "Headset Left Driver"},
-	{"HSOR", NULL, "Headset Right Driver"},
+	{"HSOL", NULL, "HS Left Driver"},
+	{"HSOR", NULL, "HS Right Driver"},
 
 	/* Earphone playback path */
 	{"Earphone Playback", "Switch", "HSDAC Left"},
-- 
1.7.6.1
