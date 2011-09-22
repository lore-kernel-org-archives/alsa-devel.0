From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 07/10] ASoC: twl6040: Use consistent names
	for Headset path
Date: Thu, 22 Sep 2011 11:05:51 +0300
Message-ID: <1316678754-11935-8-git-send-email-peter.ujfalusi@ti.com>
References: <1316678754-11935-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog108.obsmtp.com (na3sys009aog108.obsmtp.com
	[74.125.149.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 136CD103B06
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Sep 2011 10:06:31 +0200 (CEST)
Received: by mail-bw0-f42.google.com with SMTP id r4so2701726bka.15
	for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2011 01:06:30 -0700 (PDT)
In-Reply-To: <1316678754-11935-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Use "Headset XYZ" for user visible controls, while the internal DAPM
widgets can use "HS XYZ".
In this way we can group the Headset related controls in UI
(alsamixer for example).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/codecs/twl6040.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 10f292d..fffd7ff 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1163,9 +1163,9 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
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
@@ -1180,11 +1180,11 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
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
@@ -1221,17 +1221,17 @@ static const struct snd_soc_dapm_route intercon[] = {
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
