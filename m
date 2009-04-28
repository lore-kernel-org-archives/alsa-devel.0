From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH] ASoC: TWL4030: change DAPMs for analog
 microphone selection
Date: Tue, 28 Apr 2009 14:59:50 +0900
Message-ID: <49F69B56.4000902@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DA672445F
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 08:00:04 +0200 (CEST)
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
	by mailout2.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KIS00M2ARBQY4@mailout2.samsung.com> for
	alsa-devel@alsa-project.org; Tue, 28 Apr 2009 14:59:50 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KIS00289RBQ9R@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Tue, 28 Apr 2009 14:59:50 +0900 (KST)
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
Cc: kyungmin.park@samsung.com, broonie@opensource.wolfsonmicro.com, peter.ujfalusi@nokia.com, bhmin@samsung.com
List-Id: alsa-devel@alsa-project.org

The mixer DAPM is suitable than the mux DAPM for the analog microphone
registers(0x05, 0x06) because each bit for path is switchable.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 sound/soc/codecs/twl4030.c |   52 ++++++++++++++++---------------------------
 1 files changed, 19 insertions(+), 33 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index e23c20c..a7875c2 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -397,36 +397,18 @@ static const struct snd_kcontrol_new twl4030_dapm_handsfreer_control =
 SOC_DAPM_ENUM("Route", twl4030_handsfreer_enum);
 
 /* Left analog microphone selection */
-static const char *twl4030_analoglmic_texts[] =
-		{"Off", "Main mic", "Headset mic", "AUXL", "Carkit mic"};
-
-static const unsigned int twl4030_analoglmic_values[] =
-		{0x0, 0x1, 0x2, 0x4, 0x8};
-
-static const struct soc_enum twl4030_analoglmic_enum =
-	SOC_VALUE_ENUM_SINGLE(TWL4030_REG_ANAMICL, 0, 0xf,
-			ARRAY_SIZE(twl4030_analoglmic_texts),
-			twl4030_analoglmic_texts,
-			twl4030_analoglmic_values);
-
-static const struct snd_kcontrol_new twl4030_dapm_analoglmic_control =
-SOC_DAPM_VALUE_ENUM("Route", twl4030_analoglmic_enum);
+static const struct snd_kcontrol_new twl4030_dapm_analoglmic_controls[] = {
+	SOC_DAPM_SINGLE("Main mic", TWL4030_REG_ANAMICL, 0, 1, 0),
+	SOC_DAPM_SINGLE("Headset mic", TWL4030_REG_ANAMICL, 1, 1, 0),
+	SOC_DAPM_SINGLE("AUXL", TWL4030_REG_ANAMICL, 2, 1, 0),
+	SOC_DAPM_SINGLE("Carkit mic", TWL4030_REG_ANAMICL, 3, 1, 0),
+};
 
 /* Right analog microphone selection */
-static const char *twl4030_analogrmic_texts[] =
-		{"Off", "Sub mic", "AUXR"};
-
-static const unsigned int twl4030_analogrmic_values[] =
-		{0x0, 0x1, 0x4};
-
-static const struct soc_enum twl4030_analogrmic_enum =
-	SOC_VALUE_ENUM_SINGLE(TWL4030_REG_ANAMICR, 0, 0x5,
-			ARRAY_SIZE(twl4030_analogrmic_texts),
-			twl4030_analogrmic_texts,
-			twl4030_analogrmic_values);
-
-static const struct snd_kcontrol_new twl4030_dapm_analogrmic_control =
-SOC_DAPM_VALUE_ENUM("Route", twl4030_analogrmic_enum);
+static const struct snd_kcontrol_new twl4030_dapm_analogrmic_controls[] = {
+	SOC_DAPM_SINGLE("Sub mic", TWL4030_REG_ANAMICR, 0, 1, 0),
+	SOC_DAPM_SINGLE("AUXR", TWL4030_REG_ANAMICR, 1, 1, 0),
+};
 
 /* TX1 L/R Analog/Digital microphone selection */
 static const char *twl4030_micpathtx1_texts[] =
@@ -1034,11 +1016,15 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 		SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD|
 		SND_SOC_DAPM_POST_REG),
 
-	/* Analog input muxes with switch for the capture amplifiers */
-	SND_SOC_DAPM_VALUE_MUX("Analog Left Capture Route",
-		TWL4030_REG_ANAMICL, 4, 0, &twl4030_dapm_analoglmic_control),
-	SND_SOC_DAPM_VALUE_MUX("Analog Right Capture Route",
-		TWL4030_REG_ANAMICR, 4, 0, &twl4030_dapm_analogrmic_control),
+	/* Analog input mixers for the capture amplifiers */
+	SND_SOC_DAPM_MIXER("Analog Left Capture Route",
+		TWL4030_REG_ANAMICL, 4, 0,
+		&twl4030_dapm_analoglmic_controls[0],
+		ARRAY_SIZE(twl4030_dapm_analoglmic_controls)),
+	SND_SOC_DAPM_MIXER("Analog Right Capture Route",
+		TWL4030_REG_ANAMICR, 4, 0,
+		&twl4030_dapm_analogrmic_controls[0],
+		ARRAY_SIZE(twl4030_dapm_analogrmic_controls)),
 
 	SND_SOC_DAPM_PGA("ADC Physical Left",
 		TWL4030_REG_AVADC_CTL, 3, 0, NULL, 0),
-- 
1.6.0.4
