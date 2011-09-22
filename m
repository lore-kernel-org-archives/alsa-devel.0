From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 06/10] ASoC: twl6040: Use consistent names
	for Handsfree path
Date: Thu, 22 Sep 2011 11:05:50 +0300
Message-ID: <1316678754-11935-7-git-send-email-peter.ujfalusi@ti.com>
References: <1316678754-11935-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog120.obsmtp.com (na3sys009aog120.obsmtp.com
	[74.125.149.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 1FA7D103B03
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Sep 2011 10:06:30 +0200 (CEST)
Received: by bkar4 with SMTP id r4so2702225bka.15
	for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2011 01:06:28 -0700 (PDT)
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

Use "Handsfree XYZ" for user visible controls, while the internal DAPM
widgets can use "HF XYZ".
In this way we can group the Handsfree related controls in UI
(alsamixer for example).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/codecs/twl6040.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 3450b11..10f292d 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1158,9 +1158,9 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 			twl6040_power_mode_event,
 			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 
-	SND_SOC_DAPM_MUX("HF Left Playback",
+	SND_SOC_DAPM_MUX("Handsfree Left Playback",
 			SND_SOC_NOPM, 0, 0, &hfl_mux_controls),
-	SND_SOC_DAPM_MUX("HF Right Playback",
+	SND_SOC_DAPM_MUX("Handsfree Right Playback",
 			SND_SOC_NOPM, 0, 0, &hfr_mux_controls),
 	/* Analog playback Muxes */
 	SND_SOC_DAPM_MUX("HS Left Playback",
@@ -1172,11 +1172,11 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 			&ep_path_enable_control),
 
 	/* Analog playback drivers */
-	SND_SOC_DAPM_OUT_DRV_E("Handsfree Left Driver",
+	SND_SOC_DAPM_OUT_DRV_E("HF Left Driver",
 			TWL6040_REG_HFLCTL, 4, 0, NULL, 0,
 			pga_event,
 			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
-	SND_SOC_DAPM_OUT_DRV_E("Handsfree Right Driver",
+	SND_SOC_DAPM_OUT_DRV_E("HF Right Driver",
 			TWL6040_REG_HFRCTL, 4, 0, NULL, 0,
 			pga_event,
 			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
@@ -1194,9 +1194,9 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
 
 	/* Analog playback PGAs */
-	SND_SOC_DAPM_PGA("HFDAC Left PGA",
+	SND_SOC_DAPM_PGA("HF Left PGA",
 			TWL6040_REG_HFLCTL, 1, 0, NULL, 0),
-	SND_SOC_DAPM_PGA("HFDAC Right PGA",
+	SND_SOC_DAPM_PGA("HF Right PGA",
 			TWL6040_REG_HFRCTL, 1, 0, NULL, 0),
 
 };
@@ -1238,20 +1238,20 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"Earphone Driver", NULL, "Earphone Playback"},
 	{"EP", NULL, "Earphone Driver"},
 
-	{"HF Left Playback", "HF DAC", "HFDAC Left"},
-	{"HF Left Playback", "Line-In amp", "AFMAmpL"},
+	{"Handsfree Left Playback", "HF DAC", "HFDAC Left"},
+	{"Handsfree Left Playback", "Line-In amp", "AFMAmpL"},
 
-	{"HF Right Playback", "HF DAC", "HFDAC Right"},
-	{"HF Right Playback", "Line-In amp", "AFMAmpR"},
+	{"Handsfree Right Playback", "HF DAC", "HFDAC Right"},
+	{"Handsfree Right Playback", "Line-In amp", "AFMAmpR"},
 
-	{"HFDAC Left PGA", NULL, "HF Left Playback"},
-	{"HFDAC Right PGA", NULL, "HF Right Playback"},
+	{"HF Left PGA", NULL, "Handsfree Left Playback"},
+	{"HF Right PGA", NULL, "Handsfree Right Playback"},
 
-	{"Handsfree Left Driver", "Switch", "HFDAC Left PGA"},
-	{"Handsfree Right Driver", "Switch", "HFDAC Right PGA"},
+	{"HF Left Driver", NULL, "HF Left PGA"},
+	{"HF Right Driver", NULL, "HF Right PGA"},
 
-	{"HFL", NULL, "Handsfree Left Driver"},
-	{"HFR", NULL, "Handsfree Right Driver"},
+	{"HFL", NULL, "HF Left Driver"},
+	{"HFR", NULL, "HF Right Driver"},
 };
 
 static int twl6040_add_widgets(struct snd_soc_codec *codec)
-- 
1.7.6.1
