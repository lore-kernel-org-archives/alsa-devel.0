From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 3/3] ASoC: TWL4030: Change the name for the DACs
Date: Wed, 10 Dec 2008 12:51:48 +0200
Message-ID: <1228906308-17374-4-git-send-email-peter.ujfalusi@nokia.com>
References: <1228906308-17374-1-git-send-email-peter.ujfalusi@nokia.com>
	<1228906308-17374-2-git-send-email-peter.ujfalusi@nokia.com>
	<1228906308-17374-3-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id C448324413
	for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2008 11:52:50 +0100 (CET)
In-Reply-To: <1228906308-17374-3-git-send-email-peter.ujfalusi@nokia.com>
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

To avoid confusion the names for the DACs changed:
DACL1 -> DAC Left1
...

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index e3a7115..aa9f855 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -764,13 +764,13 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("HFR"),
 
 	/* DACs */
-	SND_SOC_DAPM_DAC("DACR1", "Right Front Playback",
+	SND_SOC_DAPM_DAC("DAC Right1", "Right Front Playback",
 			TWL4030_REG_AVDAC_CTL, 0, 0),
-	SND_SOC_DAPM_DAC("DACL1", "Left Front Playback",
+	SND_SOC_DAPM_DAC("DAC Left1", "Left Front Playback",
 			TWL4030_REG_AVDAC_CTL, 1, 0),
-	SND_SOC_DAPM_DAC("DACR2", "Right Rear Playback",
+	SND_SOC_DAPM_DAC("DAC Right2", "Right Rear Playback",
 			TWL4030_REG_AVDAC_CTL, 2, 0),
-	SND_SOC_DAPM_DAC("DACL2", "Left Rear Playback",
+	SND_SOC_DAPM_DAC("DAC Left2", "Left Rear Playback",
 			TWL4030_REG_AVDAC_CTL, 3, 0),
 
 	/* Analog PGAs */
@@ -816,10 +816,10 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 };
 
 static const struct snd_soc_dapm_route intercon[] = {
-	{"ARXL1_APGA", NULL, "DACL1"},
-	{"ARXR1_APGA", NULL, "DACR1"},
-	{"ARXL2_APGA", NULL, "DACL2"},
-	{"ARXR2_APGA", NULL, "DACR2"},
+	{"ARXL1_APGA", NULL, "DAC Left1"},
+	{"ARXR1_APGA", NULL, "DAC Right1"},
+	{"ARXL2_APGA", NULL, "DAC Left2"},
+	{"ARXR2_APGA", NULL, "DAC Right2"},
 
 	/* Internal playback routings */
 	/* Earpiece */
-- 
1.6.0.4
