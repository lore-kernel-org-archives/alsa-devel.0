From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/1] ASoC: TWL4030: Differentiate the playback
	streams
Date: Fri, 22 May 2009 15:12:15 +0300
Message-ID: <1242994335-12582-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1242994335-12582-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id EA58410390F
	for <alsa-devel@alsa-project.org>;
	Fri, 22 May 2009 14:12:25 +0200 (CEST)
In-Reply-To: <1242994335-12582-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Give unique stream names for the two playback streams so
DAPM can figure out which codec_dai is in use.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 584507f..9197fdd 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1092,13 +1092,13 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("VIBRA"),
 
 	/* DACs */
-	SND_SOC_DAPM_DAC("DAC Right1", "Right Front Playback",
+	SND_SOC_DAPM_DAC("DAC Right1", "Right Front HiFi Playback",
 			SND_SOC_NOPM, 0, 0),
-	SND_SOC_DAPM_DAC("DAC Left1", "Left Front Playback",
+	SND_SOC_DAPM_DAC("DAC Left1", "Left Front HiFi Playback",
 			SND_SOC_NOPM, 0, 0),
-	SND_SOC_DAPM_DAC("DAC Right2", "Right Rear Playback",
+	SND_SOC_DAPM_DAC("DAC Right2", "Right Rear HiFi Playback",
 			SND_SOC_NOPM, 0, 0),
-	SND_SOC_DAPM_DAC("DAC Left2", "Left Rear Playback",
+	SND_SOC_DAPM_DAC("DAC Left2", "Left Rear HiFi Playback",
 			SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_DAC("DAC Voice", "Voice Playback",
 			SND_SOC_NOPM, 0, 0),
@@ -1937,7 +1937,7 @@ struct snd_soc_dai twl4030_dai[] = {
 {
 	.name = "twl4030",
 	.playback = {
-		.stream_name = "Playback",
+		.stream_name = "HiFi Playback",
 		.channels_min = 2,
 		.channels_max = 4,
 		.rates = TWL4030_RATES | SNDRV_PCM_RATE_96000,
@@ -1953,7 +1953,7 @@ struct snd_soc_dai twl4030_dai[] = {
 {
 	.name = "twl4030 Voice",
 	.playback = {
-		.stream_name = "Playback",
+		.stream_name = "Voice Playback",
 		.channels_min = 1,
 		.channels_max = 1,
 		.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
-- 
1.6.3.1
