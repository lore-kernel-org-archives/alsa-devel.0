From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/1 - v2] ASoC: TWL4030: Fix for capture mixer
	strings
Date: Fri, 14 Aug 2009 08:44:00 +0300
Message-ID: <1250228640-31829-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1250228640-31829-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 76E92103927
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Aug 2009 07:44:17 +0200 (CEST)
In-Reply-To: <1250228640-31829-1-git-send-email-peter.ujfalusi@nokia.com>
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

Change the strings related to capture in order to be
interpreted correctly by alsamixer and possible other
UI based mixer applications.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   46 +++++++++++++++++++++++--------------------
 1 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 1a65004..4df7c6c 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -399,16 +399,20 @@ SOC_DAPM_ENUM("Route", twl4030_vibrapath_enum);

 /* Left analog microphone selection */
 static const struct snd_kcontrol_new twl4030_dapm_analoglmic_controls[] = {
-	SOC_DAPM_SINGLE("Main mic", TWL4030_REG_ANAMICL, 0, 1, 0),
-	SOC_DAPM_SINGLE("Headset mic", TWL4030_REG_ANAMICL, 1, 1, 0),
-	SOC_DAPM_SINGLE("AUXL", TWL4030_REG_ANAMICL, 2, 1, 0),
-	SOC_DAPM_SINGLE("Carkit mic", TWL4030_REG_ANAMICL, 3, 1, 0),
+	SOC_DAPM_SINGLE("Main Mic Capture Switch",
+			TWL4030_REG_ANAMICL, 0, 1, 0),
+	SOC_DAPM_SINGLE("Headset Mic Capture Switch",
+			TWL4030_REG_ANAMICL, 1, 1, 0),
+	SOC_DAPM_SINGLE("AUXL Capture Switch",
+			TWL4030_REG_ANAMICL, 2, 1, 0),
+	SOC_DAPM_SINGLE("Carkit Mic Capture Switch",
+			TWL4030_REG_ANAMICL, 3, 1, 0),
 };

 /* Right analog microphone selection */
 static const struct snd_kcontrol_new twl4030_dapm_analogrmic_controls[] = {
-	SOC_DAPM_SINGLE("Sub mic", TWL4030_REG_ANAMICR, 0, 1, 0),
-	SOC_DAPM_SINGLE("AUXR", TWL4030_REG_ANAMICR, 2, 1, 0),
+	SOC_DAPM_SINGLE("Sub Mic Capture Switch", TWL4030_REG_ANAMICR, 0, 1, 0),
+	SOC_DAPM_SINGLE("AUXR Capture Switch", TWL4030_REG_ANAMICR, 2, 1, 0),
 };

 /* TX1 L/R Analog/Digital microphone selection */
@@ -1333,11 +1337,11 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 		SND_SOC_DAPM_POST_REG),

 	/* Analog input mixers for the capture amplifiers */
-	SND_SOC_DAPM_MIXER("Analog Left Capture Route",
+	SND_SOC_DAPM_MIXER("Analog Left",
 		TWL4030_REG_ANAMICL, 4, 0,
 		&twl4030_dapm_analoglmic_controls[0],
 		ARRAY_SIZE(twl4030_dapm_analoglmic_controls)),
-	SND_SOC_DAPM_MIXER("Analog Right Capture Route",
+	SND_SOC_DAPM_MIXER("Analog Right",
 		TWL4030_REG_ANAMICR, 4, 0,
 		&twl4030_dapm_analogrmic_controls[0],
 		ARRAY_SIZE(twl4030_dapm_analogrmic_controls)),
@@ -1446,16 +1450,16 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"VIBRA", NULL, "Vibra Route"},

 	/* Capture path */
-	{"Analog Left Capture Route", "Main mic", "MAINMIC"},
-	{"Analog Left Capture Route", "Headset mic", "HSMIC"},
-	{"Analog Left Capture Route", "AUXL", "AUXL"},
-	{"Analog Left Capture Route", "Carkit mic", "CARKITMIC"},
+	{"Analog Left", "Main Mic Capture Switch", "MAINMIC"},
+	{"Analog Left", "Headset Mic Capture Switch", "HSMIC"},
+	{"Analog Left", "AUXL Capture Switch", "AUXL"},
+	{"Analog Left", "Carkit Mic Capture Switch", "CARKITMIC"},

-	{"Analog Right Capture Route", "Sub mic", "SUBMIC"},
-	{"Analog Right Capture Route", "AUXR", "AUXR"},
+	{"Analog Right", "Sub Mic Capture Switch", "SUBMIC"},
+	{"Analog Right", "AUXR Capture Switch", "AUXR"},

-	{"ADC Physical Left", NULL, "Analog Left Capture Route"},
-	{"ADC Physical Right", NULL, "Analog Right Capture Route"},
+	{"ADC Physical Left", NULL, "Analog Left"},
+	{"ADC Physical Right", NULL, "Analog Right"},

 	{"Digimic0 Enable", NULL, "DIGIMIC0"},
 	{"Digimic1 Enable", NULL, "DIGIMIC1"},
@@ -1479,11 +1483,11 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"ADC Virtual Right2", NULL, "TX2 Capture Route"},

 	/* Analog bypass routes */
-	{"Right1 Analog Loopback", "Switch", "Analog Right Capture Route"},
-	{"Left1 Analog Loopback", "Switch", "Analog Left Capture Route"},
-	{"Right2 Analog Loopback", "Switch", "Analog Right Capture Route"},
-	{"Left2 Analog Loopback", "Switch", "Analog Left Capture Route"},
-	{"Voice Analog Loopback", "Switch", "Analog Left Capture Route"},
+	{"Right1 Analog Loopback", "Switch", "Analog Right"},
+	{"Left1 Analog Loopback", "Switch", "Analog Left"},
+	{"Right2 Analog Loopback", "Switch", "Analog Right"},
+	{"Left2 Analog Loopback", "Switch", "Analog Left"},
+	{"Voice Analog Loopback", "Switch", "Analog Left"},

 	{"Analog R1 Playback Mixer", NULL, "Right1 Analog Loopback"},
 	{"Analog L1 Playback Mixer", NULL, "Left1 Analog Loopback"},
--
1.6.4
