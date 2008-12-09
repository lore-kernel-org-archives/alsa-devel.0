From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 2/9] ASoC: TWL4030: Add Analog PGA control
	switch to DAPM
Date: Tue,  9 Dec 2008 12:35:45 +0200
Message-ID: <1228818952-31082-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1228818952-31082-1-git-send-email-peter.ujfalusi@nokia.com>
	<1228818952-31082-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id E74B910385D
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2008 11:36:05 +0100 (CET)
In-Reply-To: <1228818952-31082-2-git-send-email-peter.ujfalusi@nokia.com>
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

Add all four APGA switch to DAPM routing and widgets.
Add user control for DA enable for all APGA as normal
control.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 3543bf6..4293ec7 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -562,6 +562,12 @@ static const struct snd_kcontrol_new twl4030_snd_controls[] = {
 	SOC_DOUBLE_R_TLV("DAC2 Analog Playback Volume",
 		TWL4030_REG_ARXL2_APGA_CTL, TWL4030_REG_ARXR2_APGA_CTL,
 		3, 0x12, 1, analog_tlv),
+	SOC_DOUBLE_R("DAC1 Analog Playback Switch",
+		TWL4030_REG_ARXL1_APGA_CTL, TWL4030_REG_ARXR1_APGA_CTL,
+		1, 1, 0),
+	SOC_DOUBLE_R("DAC2 Analog Playback Switch",
+		TWL4030_REG_ARXL2_APGA_CTL, TWL4030_REG_ARXR2_APGA_CTL,
+		1, 1, 0),
 
 	/* Separate output gain controls */
 	SOC_DOUBLE_R_TLV_TWL4030("PreDriv Playback Volume",
@@ -626,14 +632,29 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_DAC("DACL2", "Left Rear Playback",
 			TWL4030_REG_AVDAC_CTL, 3, 0),
 
+	/* Analog PGAs */
+	SND_SOC_DAPM_PGA("ARXR1_APGA", TWL4030_REG_ARXR1_APGA_CTL,
+			0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("ARXL1_APGA", TWL4030_REG_ARXL1_APGA_CTL,
+			0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("ARXR2_APGA", TWL4030_REG_ARXR2_APGA_CTL,
+			0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("ARXL2_APGA", TWL4030_REG_ARXL2_APGA_CTL,
+			0, 0, NULL, 0),
+
 	SND_SOC_DAPM_ADC("ADCL", "Left Capture", SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_ADC("ADCR", "Right Capture", SND_SOC_NOPM, 0, 0),
 };
 
 static const struct snd_soc_dapm_route intercon[] = {
+	{"ARXL1_APGA", NULL, "DACL1"},
+	{"ARXR1_APGA", NULL, "DACR1"},
+	{"ARXL2_APGA", NULL, "DACL2"},
+	{"ARXR2_APGA", NULL, "DACR2"},
+
 	/* outputs */
-	{"OUTL", NULL, "DACL2"},
-	{"OUTR", NULL, "DACR2"},
+	{"OUTL", NULL, "ARXL2_APGA"},
+	{"OUTR", NULL, "ARXR2_APGA"},
 
 	/* inputs */
 	{"ADCL", NULL, "INL"},
-- 
1.6.0.3
