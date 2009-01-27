From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 4/6] ASoC: TWL4030: Physical ADC and amplifier
	power switch change
Date: Tue, 27 Jan 2009 11:29:42 +0200
Message-ID: <1233048584-29662-5-git-send-email-peter.ujfalusi@nokia.com>
References: <1233048584-29662-1-git-send-email-peter.ujfalusi@nokia.com>
	<1233048584-29662-2-git-send-email-peter.ujfalusi@nokia.com>
	<1233048584-29662-3-git-send-email-peter.ujfalusi@nokia.com>
	<1233048584-29662-4-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 609391037EA
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 10:30:00 +0100 (CET)
In-Reply-To: <1233048584-29662-4-git-send-email-peter.ujfalusi@nokia.com>
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

Change the power switches for the physical ADC and for the
amplifiers for the analog capture path to map more closely
the actual path inside of the codec.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 0e3198f..651be7f 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -802,16 +802,16 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 		SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD|
 		SND_SOC_DAPM_POST_REG),
 
-	/* Analog input muxes with power switch for the physical ADCL/R */
+	/* Analog input muxes with switch for the capture amplifiers */
 	SND_SOC_DAPM_VALUE_MUX("Analog Left Capture Route",
-		TWL4030_REG_AVADC_CTL, 3, 0, &twl4030_dapm_analoglmic_control),
+		TWL4030_REG_ANAMICL, 4, 0, &twl4030_dapm_analoglmic_control),
 	SND_SOC_DAPM_VALUE_MUX("Analog Right Capture Route",
-		TWL4030_REG_AVADC_CTL, 1, 0, &twl4030_dapm_analogrmic_control),
+		TWL4030_REG_ANAMICR, 4, 0, &twl4030_dapm_analogrmic_control),
 
-	SND_SOC_DAPM_PGA("Analog Left Amplifier",
-		TWL4030_REG_ANAMICL, 4, 0, NULL, 0),
-	SND_SOC_DAPM_PGA("Analog Right Amplifier",
-		TWL4030_REG_ANAMICR, 4, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("ADC Physical Left",
+		TWL4030_REG_AVADC_CTL, 3, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("ADC Physical Right",
+		TWL4030_REG_AVADC_CTL, 1, 0, NULL, 0),
 
 	SND_SOC_DAPM_PGA("Digimic0 Enable",
 		TWL4030_REG_ADCMICSEL, 1, 0, NULL, 0),
@@ -885,23 +885,23 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"Analog Right Capture Route", "Sub mic", "SUBMIC"},
 	{"Analog Right Capture Route", "AUXR", "AUXR"},
 
-	{"Analog Left Amplifier", NULL, "Analog Left Capture Route"},
-	{"Analog Right Amplifier", NULL, "Analog Right Capture Route"},
+	{"ADC Physical Left", NULL, "Analog Left Capture Route"},
+	{"ADC Physical Right", NULL, "Analog Right Capture Route"},
 
 	{"Digimic0 Enable", NULL, "DIGIMIC0"},
 	{"Digimic1 Enable", NULL, "DIGIMIC1"},
 
 	/* TX1 Left capture path */
-	{"TX1 Capture Route", "Analog", "Analog Left Amplifier"},
+	{"TX1 Capture Route", "Analog", "ADC Physical Left"},
 	{"TX1 Capture Route", "Digimic0", "Digimic0 Enable"},
 	/* TX1 Right capture path */
-	{"TX1 Capture Route", "Analog", "Analog Right Amplifier"},
+	{"TX1 Capture Route", "Analog", "ADC Physical Right"},
 	{"TX1 Capture Route", "Digimic0", "Digimic0 Enable"},
 	/* TX2 Left capture path */
-	{"TX2 Capture Route", "Analog", "Analog Left Amplifier"},
+	{"TX2 Capture Route", "Analog", "ADC Physical Left"},
 	{"TX2 Capture Route", "Digimic1", "Digimic1 Enable"},
 	/* TX2 Right capture path */
-	{"TX2 Capture Route", "Analog", "Analog Right Amplifier"},
+	{"TX2 Capture Route", "Analog", "ADC Physical Right"},
 	{"TX2 Capture Route", "Digimic1", "Digimic1 Enable"},
 
 	{"ADC Virtual Left1", NULL, "TX1 Capture Route"},
-- 
1.6.1
