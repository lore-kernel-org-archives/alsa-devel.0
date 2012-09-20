From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: twl6040: Convert to use DAI DAPM widgets
Date: Thu, 20 Sep 2012 16:32:15 +0300
Message-ID: <1348147935-22562-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog122.obsmtp.com (na3sys009aog122.obsmtp.com
 [74.125.149.147])
 by alsa0.perex.cz (Postfix) with ESMTP id D651426531D
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2012 15:31:23 +0200 (CEST)
Received: by obbeh20 with SMTP id eh20so2018968obb.38
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2012 06:31:22 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use DAPM mapping for stream events and give unique names for the streams.
This change also fixes the following warning:
twl6040-codec twl6040-codec: Failed to create Capture debugfs file

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c | 43 +++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index c084c54..e8f97af 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -727,10 +727,8 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 			TWL6040_REG_MICRCTL, 1, 0, NULL, 0),
 
 	/* ADCs */
-	SND_SOC_DAPM_ADC("ADC Left", "Left Front Capture",
-			TWL6040_REG_MICLCTL, 2, 0),
-	SND_SOC_DAPM_ADC("ADC Right", "Right Front Capture",
-			TWL6040_REG_MICRCTL, 2, 0),
+	SND_SOC_DAPM_ADC("ADC Left", NULL, TWL6040_REG_MICLCTL, 2, 0),
+	SND_SOC_DAPM_ADC("ADC Right", NULL, TWL6040_REG_MICRCTL, 2, 0),
 
 	/* Microphone bias */
 	SND_SOC_DAPM_SUPPLY("Headset Mic Bias",
@@ -743,15 +741,12 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 			    TWL6040_REG_DMICBCTL, 4, 0, NULL, 0),
 
 	/* DACs */
-	SND_SOC_DAPM_DAC("HSDAC Left", "Headset Playback", SND_SOC_NOPM, 0, 0),
-	SND_SOC_DAPM_DAC("HSDAC Right", "Headset Playback", SND_SOC_NOPM, 0, 0),
-	SND_SOC_DAPM_DAC("HFDAC Left", "Handsfree Playback",
-			 TWL6040_REG_HFLCTL, 0, 0),
-	SND_SOC_DAPM_DAC("HFDAC Right", "Handsfree Playback",
-			 TWL6040_REG_HFRCTL, 0, 0),
+	SND_SOC_DAPM_DAC("HSDAC Left", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_DAC("HSDAC Right", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_DAC("HFDAC Left", NULL, TWL6040_REG_HFLCTL, 0, 0),
+	SND_SOC_DAPM_DAC("HFDAC Right", NULL, TWL6040_REG_HFRCTL, 0, 0),
 	/* Virtual DAC for vibra path (DL4 channel) */
-	SND_SOC_DAPM_DAC("VIBRA DAC", "Vibra Playback",
-			SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_DAC("VIBRA DAC", NULL, SND_SOC_NOPM, 0, 0),
 
 	SND_SOC_DAPM_MUX("Handsfree Left Playback",
 			SND_SOC_NOPM, 0, 0, &hfl_mux_controls),
@@ -810,6 +805,26 @@ static const struct snd_soc_dapm_widget twl6040_dapm_widgets[] = {
 };
 
 static const struct snd_soc_dapm_route intercon[] = {
+	/* Stream -> DAC mapping */
+	{"HSDAC Left", NULL, "Legacy Playback"},
+	{"HSDAC Left", NULL, "Headset Playback"},
+	{"HSDAC Right", NULL, "Legacy Playback"},
+	{"HSDAC Right", NULL, "Headset Playback"},
+
+	{"HFDAC Left", NULL, "Legacy Playback"},
+	{"HFDAC Left", NULL, "Handsfree Playback"},
+	{"HFDAC Right", NULL, "Legacy Playback"},
+	{"HFDAC Right", NULL, "Handsfree Playback"},
+
+	{"VIBRA DAC", NULL, "Legacy Playback"},
+	{"VIBRA DAC", NULL, "Vibra Playback"},
+
+	/* ADC -> Stream mapping */
+	{"ADC Left", NULL, "Legacy Capture"},
+	{"ADC Left", NULL, "Capture"},
+	{"ADC Right", NULL, "Legacy Capture"},
+	{"ADC Right", NULL, "Capture"},
+
 	/* Capture path */
 	{"Analog Left Capture Route", "Headset Mic", "HSMIC"},
 	{"Analog Left Capture Route", "Main Mic", "MAINMIC"},
@@ -1028,14 +1043,14 @@ static struct snd_soc_dai_driver twl6040_dai[] = {
 {
 	.name = "twl6040-legacy",
 	.playback = {
-		.stream_name = "Playback",
+		.stream_name = "Legacy Playback",
 		.channels_min = 1,
 		.channels_max = 5,
 		.rates = TWL6040_RATES,
 		.formats = TWL6040_FORMATS,
 	},
 	.capture = {
-		.stream_name = "Capture",
+		.stream_name = "Legacy Capture",
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = TWL6040_RATES,
-- 
1.7.12
