From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: twl4030: Convert to use DAI DAPM widgets
Date: Thu, 20 Sep 2012 16:32:02 +0300
Message-ID: <1348147922-22527-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog129.obsmtp.com (na3sys009aog129.obsmtp.com
 [74.125.149.142])
 by alsa0.perex.cz (Postfix) with ESMTP id 58EE426531D
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2012 15:31:16 +0200 (CEST)
Received: by obbeh20 with SMTP id eh20so2018788obb.38
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2012 06:31:12 -0700 (PDT)
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
twl4030-codec twl4030-codec: Failed to create Capture debugfs file

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl4030.c | 48 +++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 2548f5c..962341d 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1237,16 +1237,11 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("Virtual Voice OUT"),
 
 	/* DACs */
-	SND_SOC_DAPM_DAC("DAC Right1", "Right Front HiFi Playback",
-			SND_SOC_NOPM, 0, 0),
-	SND_SOC_DAPM_DAC("DAC Left1", "Left Front HiFi Playback",
-			SND_SOC_NOPM, 0, 0),
-	SND_SOC_DAPM_DAC("DAC Right2", "Right Rear HiFi Playback",
-			SND_SOC_NOPM, 0, 0),
-	SND_SOC_DAPM_DAC("DAC Left2", "Left Rear HiFi Playback",
-			SND_SOC_NOPM, 0, 0),
-	SND_SOC_DAPM_DAC("DAC Voice", "Voice Playback",
-			SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_DAC("DAC Right1", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_DAC("DAC Left1", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_DAC("DAC Right2", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_DAC("DAC Left2", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_DAC("DAC Voice", NULL, SND_SOC_NOPM, 0, 0),
 
 	/* Analog bypasses */
 	SND_SOC_DAPM_SWITCH("Right1 Analog Loopback", SND_SOC_NOPM, 0, 0,
@@ -1375,14 +1370,10 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 
 	/* Introducing four virtual ADC, since TWL4030 have four channel for
 	   capture */
-	SND_SOC_DAPM_ADC("ADC Virtual Left1", "Left Front Capture",
-		SND_SOC_NOPM, 0, 0),
-	SND_SOC_DAPM_ADC("ADC Virtual Right1", "Right Front Capture",
-		SND_SOC_NOPM, 0, 0),
-	SND_SOC_DAPM_ADC("ADC Virtual Left2", "Left Rear Capture",
-		SND_SOC_NOPM, 0, 0),
-	SND_SOC_DAPM_ADC("ADC Virtual Right2", "Right Rear Capture",
-		SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_ADC("ADC Virtual Left1", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_ADC("ADC Virtual Right1", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_ADC("ADC Virtual Left2", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_ADC("ADC Virtual Right2", NULL, SND_SOC_NOPM, 0, 0),
 
 	/* Analog/Digital mic path selection.
 	   TX1 Left/Right: either analog Left/Right or Digimic0
@@ -1426,6 +1417,23 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 };
 
 static const struct snd_soc_dapm_route intercon[] = {
+	/* Stream -> DAC mapping */
+	{"DAC Right1", NULL, "HiFi Playback"},
+	{"DAC Left1", NULL, "HiFi Playback"},
+	{"DAC Right2", NULL, "HiFi Playback"},
+	{"DAC Left2", NULL, "HiFi Playback"},
+	{"DAC Voice", NULL, "Voice Playback"},
+
+	/* ADC -> Stream mapping */
+	{"HiFi Capture", NULL, "ADC Virtual Left1"},
+	{"HiFi Capture", NULL, "ADC Virtual Right1"},
+	{"HiFi Capture", NULL, "ADC Virtual Left2"},
+	{"HiFi Capture", NULL, "ADC Virtual Right2"},
+	{"Voice Capture", NULL, "ADC Virtual Left1"},
+	{"Voice Capture", NULL, "ADC Virtual Right1"},
+	{"Voice Capture", NULL, "ADC Virtual Left2"},
+	{"Voice Capture", NULL, "ADC Virtual Right2"},
+
 	{"Digital L1 Playback Mixer", NULL, "DAC Left1"},
 	{"Digital R1 Playback Mixer", NULL, "DAC Right1"},
 	{"Digital L2 Playback Mixer", NULL, "DAC Left2"},
@@ -2170,7 +2178,7 @@ static struct snd_soc_dai_driver twl4030_dai[] = {
 		.formats = TWL4030_FORMATS,
 		.sig_bits = 24,},
 	.capture = {
-		.stream_name = "Capture",
+		.stream_name = "HiFi Capture",
 		.channels_min = 2,
 		.channels_max = 4,
 		.rates = TWL4030_RATES,
@@ -2187,7 +2195,7 @@ static struct snd_soc_dai_driver twl4030_dai[] = {
 		.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
 	.capture = {
-		.stream_name = "Capture",
+		.stream_name = "Voice Capture",
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
-- 
1.7.12
