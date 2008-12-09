From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/9] ASoC: TWL4030: Correct DAPM_DAC with power
	control
Date: Tue,  9 Dec 2008 12:35:44 +0200
Message-ID: <1228818952-31082-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1228818952-31082-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 082EE10385E
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2008 11:36:05 +0100 (CET)
In-Reply-To: <1228818952-31082-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

Add all four DACs to dapm_widgets with power switch.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 3c9fdf2..3543bf6 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -616,8 +616,15 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("OUTL"),
 	SND_SOC_DAPM_OUTPUT("OUTR"),
 
-	SND_SOC_DAPM_DAC("DACL", "Left Playback", SND_SOC_NOPM, 0, 0),
-	SND_SOC_DAPM_DAC("DACR", "Right Playback", SND_SOC_NOPM, 0, 0),
+	/* DACs */
+	SND_SOC_DAPM_DAC("DACR1", "Right Front Playback",
+			TWL4030_REG_AVDAC_CTL, 0, 0),
+	SND_SOC_DAPM_DAC("DACL1", "Left Front Playback",
+			TWL4030_REG_AVDAC_CTL, 1, 0),
+	SND_SOC_DAPM_DAC("DACR2", "Right Rear Playback",
+			TWL4030_REG_AVDAC_CTL, 2, 0),
+	SND_SOC_DAPM_DAC("DACL2", "Left Rear Playback",
+			TWL4030_REG_AVDAC_CTL, 3, 0),
 
 	SND_SOC_DAPM_ADC("ADCL", "Left Capture", SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_ADC("ADCR", "Right Capture", SND_SOC_NOPM, 0, 0),
@@ -625,8 +632,8 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 
 static const struct snd_soc_dapm_route intercon[] = {
 	/* outputs */
-	{"OUTL", NULL, "DACL"},
-	{"OUTR", NULL, "DACR"},
+	{"OUTL", NULL, "DACL2"},
+	{"OUTR", NULL, "DACR2"},
 
 	/* inputs */
 	{"ADCL", NULL, "INL"},
-- 
1.6.0.3
