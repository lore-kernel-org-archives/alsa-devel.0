From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 2/2] ASoC: TWL4030: Convert the bitfield enums
	to VALUE_ENUM type
Date: Mon,  5 Jan 2009 09:54:58 +0200
Message-ID: <1231142098-16886-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1231142098-16886-1-git-send-email-peter.ujfalusi@nokia.com>
	<1231142098-16886-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D0452415D
	for <alsa-devel@alsa-project.org>; Mon,  5 Jan 2009 08:55:14 +0100 (CET)
In-Reply-To: <1231142098-16886-2-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, broonie@sirena.org.uk, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Convert the bitfield coded enums to the new VALUE_ENUM type.
Remove the enum check, since the VALUE_ENUM type can handle
the bitfield coding and also handles the 'holes' in the bitfield.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |  118 ++++++++++++++++++++-----------------------
 1 files changed, 55 insertions(+), 63 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 31e44e3..fd0f338 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -192,39 +192,51 @@ static void twl4030_init_chip(struct snd_soc_codec *codec)
 
 /* Earpiece */
 static const char *twl4030_earpiece_texts[] =
-		{"Off", "DACL1", "DACL2", "Invalid", "DACR1"};
+		{"Off", "DACL1", "DACL2", "DACR1"};
 
-static const struct soc_enum twl4030_earpiece_enum =
-	SOC_ENUM_SINGLE(TWL4030_REG_EAR_CTL, 1,
+static const unsigned int twl4030_earpiece_values[] =
+		{0x0, 0x1, 0x2, 0x4};
+
+static const struct soc_value_enum twl4030_earpiece_enum =
+	SOC_VALUE_ENUM_SINGLE(TWL4030_REG_EAR_CTL, 1, 0x7,
 			ARRAY_SIZE(twl4030_earpiece_texts),
-			twl4030_earpiece_texts);
+			twl4030_earpiece_texts,
+			twl4030_earpiece_values);
 
 static const struct snd_kcontrol_new twl4030_dapm_earpiece_control =
-SOC_DAPM_ENUM("Route", twl4030_earpiece_enum);
+SOC_DAPM_VALUE_ENUM("Route", twl4030_earpiece_enum);
 
 /* PreDrive Left */
 static const char *twl4030_predrivel_texts[] =
-		{"Off", "DACL1", "DACL2", "Invalid", "DACR2"};
+		{"Off", "DACL1", "DACL2", "DACR2"};
+
+static const unsigned int twl4030_predrivel_values[] =
+		{0x0, 0x1, 0x2, 0x4};
 
-static const struct soc_enum twl4030_predrivel_enum =
-	SOC_ENUM_SINGLE(TWL4030_REG_PREDL_CTL, 1,
+static const struct soc_value_enum twl4030_predrivel_enum =
+	SOC_VALUE_ENUM_SINGLE(TWL4030_REG_PREDL_CTL, 1, 0x7,
 			ARRAY_SIZE(twl4030_predrivel_texts),
-			twl4030_predrivel_texts);
+			twl4030_predrivel_texts,
+			twl4030_predrivel_values);
 
 static const struct snd_kcontrol_new twl4030_dapm_predrivel_control =
-SOC_DAPM_ENUM("Route", twl4030_predrivel_enum);
+SOC_DAPM_VALUE_ENUM("Route", twl4030_predrivel_enum);
 
 /* PreDrive Right */
 static const char *twl4030_predriver_texts[] =
-		{"Off", "DACR1", "DACR2", "Invalid", "DACL2"};
+		{"Off", "DACR1", "DACR2", "DACL2"};
 
-static const struct soc_enum twl4030_predriver_enum =
-	SOC_ENUM_SINGLE(TWL4030_REG_PREDR_CTL, 1,
+static const unsigned int twl4030_predriver_values[] =
+		{0x0, 0x1, 0x2, 0x4};
+
+static const struct soc_value_enum twl4030_predriver_enum =
+	SOC_VALUE_ENUM_SINGLE(TWL4030_REG_PREDR_CTL, 1, 0x7,
 			ARRAY_SIZE(twl4030_predriver_texts),
-			twl4030_predriver_texts);
+			twl4030_predriver_texts,
+			twl4030_predriver_values);
 
 static const struct snd_kcontrol_new twl4030_dapm_predriver_control =
-SOC_DAPM_ENUM("Route", twl4030_predriver_enum);
+SOC_DAPM_VALUE_ENUM("Route", twl4030_predriver_enum);
 
 /* Headset Left */
 static const char *twl4030_hsol_texts[] =
@@ -300,28 +312,35 @@ SOC_DAPM_ENUM("Route", twl4030_handsfreer_enum);
 
 /* Left analog microphone selection */
 static const char *twl4030_analoglmic_texts[] =
-		{"Off", "Main mic", "Headset mic", "Invalid", "AUXL",
-		 "Invalid", "Invalid", "Invalid", "Carkit mic"};
+		{"Off", "Main mic", "Headset mic", "AUXL", "Carkit mic"};
+
+static const unsigned int twl4030_analoglmic_values[] =
+		{0x0, 0x1, 0x2, 0x4, 0x8};
 
-static const struct soc_enum twl4030_analoglmic_enum =
-	SOC_ENUM_SINGLE(TWL4030_REG_ANAMICL, 0,
+static const struct soc_value_enum twl4030_analoglmic_enum =
+	SOC_VALUE_ENUM_SINGLE(TWL4030_REG_ANAMICL, 0, 0xf,
 			ARRAY_SIZE(twl4030_analoglmic_texts),
-			twl4030_analoglmic_texts);
+			twl4030_analoglmic_texts,
+			twl4030_analoglmic_values);
 
 static const struct snd_kcontrol_new twl4030_dapm_analoglmic_control =
-SOC_DAPM_ENUM("Route", twl4030_analoglmic_enum);
+SOC_DAPM_VALUE_ENUM("Route", twl4030_analoglmic_enum);
 
 /* Right analog microphone selection */
 static const char *twl4030_analogrmic_texts[] =
-		{"Off", "Sub mic", "Invalid", "Invalid", "AUXR"};
+		{"Off", "Sub mic", "AUXR"};
 
-static const struct soc_enum twl4030_analogrmic_enum =
-	SOC_ENUM_SINGLE(TWL4030_REG_ANAMICR, 0,
+static const unsigned int twl4030_analogrmic_values[] =
+		{0x0, 0x1, 0x4};
+
+static const struct soc_value_enum twl4030_analogrmic_enum =
+	SOC_VALUE_ENUM_SINGLE(TWL4030_REG_ANAMICR, 0, 0x5,
 			ARRAY_SIZE(twl4030_analogrmic_texts),
-			twl4030_analogrmic_texts);
+			twl4030_analogrmic_texts,
+			twl4030_analogrmic_values);
 
 static const struct snd_kcontrol_new twl4030_dapm_analogrmic_control =
-SOC_DAPM_ENUM("Route", twl4030_analogrmic_enum);
+SOC_DAPM_VALUE_ENUM("Route", twl4030_analogrmic_enum);
 
 /* TX1 L/R Analog/Digital microphone selection */
 static const char *twl4030_micpathtx1_texts[] =
@@ -347,28 +366,6 @@ static const struct soc_enum twl4030_micpathtx2_enum =
 static const struct snd_kcontrol_new twl4030_dapm_micpathtx2_control =
 SOC_DAPM_ENUM("Route", twl4030_micpathtx2_enum);
 
-/*
- * This function filters out the non valid mux settings, named as "Invalid"
- * in the enum texts.
- * Just refuse to set an invalid mux mode.
- */
-static int twl4030_enum_event(struct snd_soc_dapm_widget *w,
-	struct snd_kcontrol *kcontrol, int event)
-{
-	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
-	int ret = 0;
-	int val;
-
-	val = w->value >> e->shift_l;
-	if (!strcmp("Invalid", e->texts[val])) {
-		printk(KERN_WARNING "Invalid MUX setting on 0x%02x (%d)\n",
-			e->reg, val);
-		ret = -1;
-	}
-
-	return ret;
-}
-
 static int micpath_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
@@ -737,16 +734,13 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 
 	/* Output MUX controls */
 	/* Earpiece */
-	SND_SOC_DAPM_MUX_E("Earpiece Mux", SND_SOC_NOPM, 0, 0,
-		&twl4030_dapm_earpiece_control, twl4030_enum_event,
-		SND_SOC_DAPM_PRE_REG),
+	SND_SOC_DAPM_VALUE_MUX("Earpiece Mux", SND_SOC_NOPM, 0, 0,
+		&twl4030_dapm_earpiece_control),
 	/* PreDrivL/R */
-	SND_SOC_DAPM_MUX_E("PredriveL Mux", SND_SOC_NOPM, 0, 0,
-		&twl4030_dapm_predrivel_control, twl4030_enum_event,
-		SND_SOC_DAPM_PRE_REG),
-	SND_SOC_DAPM_MUX_E("PredriveR Mux", SND_SOC_NOPM, 0, 0,
-		&twl4030_dapm_predriver_control, twl4030_enum_event,
-		SND_SOC_DAPM_PRE_REG),
+	SND_SOC_DAPM_VALUE_MUX("PredriveL Mux", SND_SOC_NOPM, 0, 0,
+		&twl4030_dapm_predrivel_control),
+	SND_SOC_DAPM_VALUE_MUX("PredriveR Mux", SND_SOC_NOPM, 0, 0,
+		&twl4030_dapm_predriver_control),
 	/* HeadsetL/R */
 	SND_SOC_DAPM_MUX("HeadsetL Mux", SND_SOC_NOPM, 0, 0,
 		&twl4030_dapm_hsol_control),
@@ -789,12 +783,10 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 		SND_SOC_DAPM_POST_REG),
 
 	/* Analog input muxes with power switch for the physical ADCL/R */
-	SND_SOC_DAPM_MUX_E("Analog Left Capture Route",
-		TWL4030_REG_AVADC_CTL, 3, 0, &twl4030_dapm_analoglmic_control,
-		twl4030_enum_event, SND_SOC_DAPM_PRE_REG),
-	SND_SOC_DAPM_MUX_E("Analog Right Capture Route",
-		TWL4030_REG_AVADC_CTL, 1, 0, &twl4030_dapm_analogrmic_control,
-		twl4030_enum_event, SND_SOC_DAPM_PRE_REG),
+	SND_SOC_DAPM_VALUE_MUX("Analog Left Capture Route",
+		TWL4030_REG_AVADC_CTL, 3, 0, &twl4030_dapm_analoglmic_control),
+	SND_SOC_DAPM_VALUE_MUX("Analog Right Capture Route",
+		TWL4030_REG_AVADC_CTL, 1, 0, &twl4030_dapm_analogrmic_control),
 
 	SND_SOC_DAPM_PGA("Analog Left Amplifier",
 		TWL4030_REG_ANAMICL, 4, 0, NULL, 0),
-- 
1.6.0.6
