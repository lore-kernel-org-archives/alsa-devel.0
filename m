From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH 2/2] ASoC: twl4030 - Add VDL path support
Date: Tue, 24 Mar 2009 21:59:31 +0900
Message-ID: <49C8D933.5020303@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout5.samsung.com (mailout5.samsung.com [203.254.224.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A76A103803
	for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2009 13:59:33 +0100 (CET)
Received: from epmmp1 (mailout5.samsung.com [203.254.224.35])
	by mailout5.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KH000C77HF87E@mailout5.samsung.com> for
	alsa-devel@alsa-project.org; Tue, 24 Mar 2009 21:59:32 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KH000HNEHF8DM@mmp1.samsung.com> for
	alsa-devel@alsa-project.org; Tue, 24 Mar 2009 21:59:32 +0900 (KST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, =?UTF-8?B?J+uwleqyveuvvCc=?= <kyungmin.park@samsung.com>, =?UTF-8?B?66+8?= =?UTF-8?B?67OR7Zi4?= <bhmin@samsung.com>
List-Id: alsa-devel@alsa-project.org

Adds DAPMs for VDL(voice down link) path.
To support VDL path, we have to change DAPM of outputs(Earpiece,
PreDrive Left/Right, Headset Left/Right, Carkit Left/Right) from mux to
mixer, also codec mode from option1 to option2.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 sound/soc/codecs/twl4030.c |  259 +++++++++++++++++++++-----------------------
 1 files changed, 126 insertions(+), 133 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 97738e2..967048a 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -42,8 +42,8 @@
  */
 static const u8 twl4030_reg[TWL4030_CACHEREGNUM] = {
 	0x00, /* this register not used		*/
-	0x91, /* REG_CODEC_MODE		(0x1)	*/
-	0xc3, /* REG_OPTION		(0x2)	*/
+	0x90, /* REG_CODEC_MODE		(0x1)	*/
+	0xd3, /* REG_OPTION		(0x2)	*/
 	0x00, /* REG_UNKNOWN		(0x3)	*/
 	0x00, /* REG_MICBIAS_CTL	(0x4)	*/
 	0x20, /* REG_ANAMICL		(0x5)	*/
@@ -56,7 +56,7 @@ static const u8 twl4030_reg[TWL4030_CACHEREGNUM] = {
 	0x00, /* REG_AVTXL2PGA		(0xC)	*/
 	0x00, /* REG_AVTXR2PGA		(0xD)	*/
 	0x01, /* REG_AUDIO_IF		(0xE)	*/
-	0x00, /* REG_VOICE_IF		(0xF)	*/
+	0xe3, /* REG_VOICE_IF		(0xF)	*/
 	0x00, /* REG_ARXR1PGA		(0x10)	*/
 	0x00, /* REG_ARXL1PGA		(0x11)	*/
 	0x6c, /* REG_ARXR2PGA		(0x12)	*/
@@ -313,104 +313,60 @@ static void twl4030_power_down(struct snd_soc_codec *codec)
 }
 
 /* Earpiece */
-static const char *twl4030_earpiece_texts[] =
-		{"Off", "DACL1", "DACL2", "DACR1"};
-
-static const unsigned int twl4030_earpiece_values[] =
-		{0x0, 0x1, 0x2, 0x4};
-
-static const struct soc_enum twl4030_earpiece_enum =
-	SOC_VALUE_ENUM_SINGLE(TWL4030_REG_EAR_CTL, 1, 0x7,
-			ARRAY_SIZE(twl4030_earpiece_texts),
-			twl4030_earpiece_texts,
-			twl4030_earpiece_values);
-
-static const struct snd_kcontrol_new twl4030_dapm_earpiece_control =
-SOC_DAPM_VALUE_ENUM("Route", twl4030_earpiece_enum);
+static const struct snd_kcontrol_new twl4030_dapm_earpiece_controls[] = {
+	SOC_DAPM_SINGLE("Voice", TWL4030_REG_EAR_CTL, 0, 1, 0),
+	SOC_DAPM_SINGLE("AudioL1", TWL4030_REG_EAR_CTL, 1, 1, 0),
+	SOC_DAPM_SINGLE("AudioL2", TWL4030_REG_EAR_CTL, 2, 1, 0),
+	SOC_DAPM_SINGLE("AudioR1", TWL4030_REG_EAR_CTL, 3, 1, 0),
+};
 
 /* PreDrive Left */
-static const char *twl4030_predrivel_texts[] =
-		{"Off", "DACL1", "DACL2", "DACR2"};
-
-static const unsigned int twl4030_predrivel_values[] =
-		{0x0, 0x1, 0x2, 0x4};
-
-static const struct soc_enum twl4030_predrivel_enum =
-	SOC_VALUE_ENUM_SINGLE(TWL4030_REG_PREDL_CTL, 1, 0x7,
-			ARRAY_SIZE(twl4030_predrivel_texts),
-			twl4030_predrivel_texts,
-			twl4030_predrivel_values);
-
-static const struct snd_kcontrol_new twl4030_dapm_predrivel_control =
-SOC_DAPM_VALUE_ENUM("Route", twl4030_predrivel_enum);
+static const struct snd_kcontrol_new twl4030_dapm_predrivel_controls[] = {
+	SOC_DAPM_SINGLE("Voice", TWL4030_REG_PREDL_CTL, 0, 1, 0),
+	SOC_DAPM_SINGLE("AudioL1", TWL4030_REG_PREDL_CTL, 1, 1, 0),
+	SOC_DAPM_SINGLE("AudioL2", TWL4030_REG_PREDL_CTL, 2, 1, 0),
+	SOC_DAPM_SINGLE("AudioR2", TWL4030_REG_PREDL_CTL, 3, 1, 0),
+};
 
 /* PreDrive Right */
-static const char *twl4030_predriver_texts[] =
-		{"Off", "DACR1", "DACR2", "DACL2"};
-
-static const unsigned int twl4030_predriver_values[] =
-		{0x0, 0x1, 0x2, 0x4};
-
-static const struct soc_enum twl4030_predriver_enum =
-	SOC_VALUE_ENUM_SINGLE(TWL4030_REG_PREDR_CTL, 1, 0x7,
-			ARRAY_SIZE(twl4030_predriver_texts),
-			twl4030_predriver_texts,
-			twl4030_predriver_values);
-
-static const struct snd_kcontrol_new twl4030_dapm_predriver_control =
-SOC_DAPM_VALUE_ENUM("Route", twl4030_predriver_enum);
+static const struct snd_kcontrol_new twl4030_dapm_predriver_controls[] = {
+	SOC_DAPM_SINGLE("Voice", TWL4030_REG_PREDR_CTL, 0, 1, 0),
+	SOC_DAPM_SINGLE("AudioR1", TWL4030_REG_PREDR_CTL, 1, 1, 0),
+	SOC_DAPM_SINGLE("AudioR2", TWL4030_REG_PREDR_CTL, 2, 1, 0),
+	SOC_DAPM_SINGLE("AudioL2", TWL4030_REG_PREDR_CTL, 3, 1, 0),
+};
 
 /* Headset Left */
-static const char *twl4030_hsol_texts[] =
-		{"Off", "DACL1", "DACL2"};
-
-static const struct soc_enum twl4030_hsol_enum =
-	SOC_ENUM_SINGLE(TWL4030_REG_HS_SEL, 1,
-			ARRAY_SIZE(twl4030_hsol_texts),
-			twl4030_hsol_texts);
-
-static const struct snd_kcontrol_new twl4030_dapm_hsol_control =
-SOC_DAPM_ENUM("Route", twl4030_hsol_enum);
+static const struct snd_kcontrol_new twl4030_dapm_hsol_controls[] = {
+	SOC_DAPM_SINGLE("Voice", TWL4030_REG_HS_SEL, 0, 1, 0),
+	SOC_DAPM_SINGLE("AudioL1", TWL4030_REG_HS_SEL, 1, 1, 0),
+	SOC_DAPM_SINGLE("AudioL2", TWL4030_REG_HS_SEL, 2, 1, 0),
+};
 
 /* Headset Right */
-static const char *twl4030_hsor_texts[] =
-		{"Off", "DACR1", "DACR2"};
-
-static const struct soc_enum twl4030_hsor_enum =
-	SOC_ENUM_SINGLE(TWL4030_REG_HS_SEL, 4,
-			ARRAY_SIZE(twl4030_hsor_texts),
-			twl4030_hsor_texts);
-
-static const struct snd_kcontrol_new twl4030_dapm_hsor_control =
-SOC_DAPM_ENUM("Route", twl4030_hsor_enum);
+static const struct snd_kcontrol_new twl4030_dapm_hsor_controls[] = {
+	SOC_DAPM_SINGLE("Voice", TWL4030_REG_HS_SEL, 3, 1, 0),
+	SOC_DAPM_SINGLE("AudioR1", TWL4030_REG_HS_SEL, 4, 1, 0),
+	SOC_DAPM_SINGLE("AudioR2", TWL4030_REG_HS_SEL, 5, 1, 0),
+};
 
 /* Carkit Left */
-static const char *twl4030_carkitl_texts[] =
-		{"Off", "DACL1", "DACL2"};
-
-static const struct soc_enum twl4030_carkitl_enum =
-	SOC_ENUM_SINGLE(TWL4030_REG_PRECKL_CTL, 1,
-			ARRAY_SIZE(twl4030_carkitl_texts),
-			twl4030_carkitl_texts);
-
-static const struct snd_kcontrol_new twl4030_dapm_carkitl_control =
-SOC_DAPM_ENUM("Route", twl4030_carkitl_enum);
+static const struct snd_kcontrol_new twl4030_dapm_carkitl_controls[] = {
+	SOC_DAPM_SINGLE("Voice", TWL4030_REG_PRECKL_CTL, 0, 1, 0),
+	SOC_DAPM_SINGLE("AudioL1", TWL4030_REG_PRECKL_CTL, 1, 1, 0),
+	SOC_DAPM_SINGLE("AudioL2", TWL4030_REG_PRECKL_CTL, 2, 1, 0),
+};
 
 /* Carkit Right */
-static const char *twl4030_carkitr_texts[] =
-		{"Off", "DACR1", "DACR2"};
-
-static const struct soc_enum twl4030_carkitr_enum =
-	SOC_ENUM_SINGLE(TWL4030_REG_PRECKR_CTL, 1,
-			ARRAY_SIZE(twl4030_carkitr_texts),
-			twl4030_carkitr_texts);
-
-static const struct snd_kcontrol_new twl4030_dapm_carkitr_control =
-SOC_DAPM_ENUM("Route", twl4030_carkitr_enum);
+static const struct snd_kcontrol_new twl4030_dapm_carkitr_controls[] = {
+	SOC_DAPM_SINGLE("Voice", TWL4030_REG_PRECKR_CTL, 0, 1, 0),
+	SOC_DAPM_SINGLE("AudioR1", TWL4030_REG_PRECKR_CTL, 1, 1, 0),
+	SOC_DAPM_SINGLE("AudioR2", TWL4030_REG_PRECKR_CTL, 2, 1, 0),
+};
 
 /* Handsfree Left */
 static const char *twl4030_handsfreel_texts[] =
-		{"Voice", "DACL1", "DACL2", "DACR2"};
+		{"Voice", "AudioL1", "AudioL2", "AudioR2"};
 
 static const struct soc_enum twl4030_handsfreel_enum =
 	SOC_ENUM_SINGLE(TWL4030_REG_HFL_CTL, 0,
@@ -422,7 +378,7 @@ SOC_DAPM_ENUM("Route", twl4030_handsfreel_enum);
 
 /* Handsfree Right */
 static const char *twl4030_handsfreer_texts[] =
-		{"Voice", "DACR1", "DACR2", "DACL2"};
+		{"Voice", "AudioR1", "AudioR2", "AudioL2"};
 
 static const struct soc_enum twl4030_handsfreer_enum =
 	SOC_ENUM_SINGLE(TWL4030_REG_HFR_CTL, 0,
@@ -808,6 +764,12 @@ static int snd_soc_put_volsw_r2_twl4030(struct snd_kcontrol *kcontrol,
 }
 
 /*
+ * Voice RX GAIN volume control:
+ * from -37 to 12 dB in 1 dB steps (mute instead of -37 dB)
+ */
+static DECLARE_TLV_DB_SCALE(voice_rx_tlv, -3700, 100, 1);
+
+/*
  * FGAIN volume control:
  * from -62 to 0 dB in 1 dB steps (mute instead of -63 dB)
  */
@@ -856,6 +818,9 @@ static const struct soc_enum twl4030_rampdelay_enum =
 			twl4030_rampdelay_texts);
 
 static const struct snd_kcontrol_new twl4030_snd_controls[] = {
+	SOC_SINGLE_TLV("DAC Voice RX Volume",
+		TWL4030_REG_VRXPGA, 0, 0x31, 0, voice_rx_tlv),
+
 	/* Common playback gain controls */
 	SOC_DOUBLE_R_TLV("DAC1 Digital Fine Playback Volume",
 		TWL4030_REG_ARXL1PGA, TWL4030_REG_ARXR1PGA,
@@ -871,6 +836,11 @@ static const struct snd_kcontrol_new twl4030_snd_controls[] = {
 		TWL4030_REG_ARXL2PGA, TWL4030_REG_ARXR2PGA,
 		6, 0x2, 0, digital_coarse_tlv),
 
+	SOC_SINGLE_TLV("DAC Voice Down Link Analog Volume",
+		TWL4030_REG_VDL_APGA_CTL, 3, 0x12, 1, analog_tlv),
+	SOC_SINGLE("DAC Voice Down Link Switch",
+		TWL4030_REG_VDL_APGA_CTL, 1, 1, 0),
+
 	SOC_DOUBLE_R_TLV("DAC1 Analog Playback Volume",
 		TWL4030_REG_ARXL1_APGA_CTL, TWL4030_REG_ARXR1_APGA_CTL,
 		3, 0x12, 1, analog_tlv),
@@ -940,6 +910,7 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("HFR"),
 
 	/* DACs */
+	SND_SOC_DAPM_DAC_ACTIVE("DAC Voice", TWL4030_REG_AVDAC_CTL, 4, 0),
 	SND_SOC_DAPM_DAC("DAC Right1", "Right Front Playback",
 			SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_DAC("DAC Left1", "Left Front Playback",
@@ -950,6 +921,8 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 			SND_SOC_NOPM, 0, 0),
 
 	/* Analog PGAs */
+	SND_SOC_DAPM_PGA("VDL_APGA", TWL4030_REG_VDL_APGA_CTL,
+			0, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("ARXR1_APGA", TWL4030_REG_ARXR1_APGA_CTL,
 			0, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("ARXL1_APGA", TWL4030_REG_ARXL1_APGA_CTL,
@@ -990,26 +963,35 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_MIXER("Analog L2 Playback Mixer", TWL4030_REG_AVDAC_CTL,
 			3, 0, NULL, 0),
 
-	/* Output MUX controls */
+	/* Output MIXER controls */
 	/* Earpiece */
-	SND_SOC_DAPM_VALUE_MUX("Earpiece Mux", SND_SOC_NOPM, 0, 0,
-		&twl4030_dapm_earpiece_control),
+	SND_SOC_DAPM_MIXER("Earpiece Mixer", SND_SOC_NOPM, 0, 0,
+			&twl4030_dapm_earpiece_controls[0],
+			ARRAY_SIZE(twl4030_dapm_earpiece_controls)),
 	/* PreDrivL/R */
-	SND_SOC_DAPM_VALUE_MUX("PredriveL Mux", SND_SOC_NOPM, 0, 0,
-		&twl4030_dapm_predrivel_control),
-	SND_SOC_DAPM_VALUE_MUX("PredriveR Mux", SND_SOC_NOPM, 0, 0,
-		&twl4030_dapm_predriver_control),
+	SND_SOC_DAPM_MIXER("PredriveL Mixer", SND_SOC_NOPM, 0, 0,
+			&twl4030_dapm_predrivel_controls[0],
+			ARRAY_SIZE(twl4030_dapm_predrivel_controls)),
+	SND_SOC_DAPM_MIXER("PredriveR Mixer", SND_SOC_NOPM, 0, 0,
+			&twl4030_dapm_predriver_controls[0],
+			ARRAY_SIZE(twl4030_dapm_predriver_controls)),
 	/* HeadsetL/R */
-	SND_SOC_DAPM_MUX_E("HeadsetL Mux", SND_SOC_NOPM, 0, 0,
-		&twl4030_dapm_hsol_control, headsetl_event,
-		SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
-	SND_SOC_DAPM_MUX("HeadsetR Mux", SND_SOC_NOPM, 0, 0,
-		&twl4030_dapm_hsor_control),
+	SND_SOC_DAPM_MIXER_E("HeadsetL Mixer", SND_SOC_NOPM, 0, 0,
+			&twl4030_dapm_hsol_controls[0],
+			ARRAY_SIZE(twl4030_dapm_hsol_controls), headsetl_event,
+			SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_MIXER("HeadsetR Mixer", SND_SOC_NOPM, 0, 0,
+			&twl4030_dapm_hsor_controls[0],
+			ARRAY_SIZE(twl4030_dapm_hsor_controls)),
 	/* CarkitL/R */
-	SND_SOC_DAPM_MUX("CarkitL Mux", SND_SOC_NOPM, 0, 0,
-		&twl4030_dapm_carkitl_control),
-	SND_SOC_DAPM_MUX("CarkitR Mux", SND_SOC_NOPM, 0, 0,
-		&twl4030_dapm_carkitr_control),
+	SND_SOC_DAPM_MIXER("CarkitL Mixer", SND_SOC_NOPM, 0, 0,
+			&twl4030_dapm_carkitl_controls[0],
+			ARRAY_SIZE(twl4030_dapm_carkitl_controls)),
+	SND_SOC_DAPM_MIXER("CarkitR Mixer", SND_SOC_NOPM, 0, 0,
+			&twl4030_dapm_carkitr_controls[0],
+			ARRAY_SIZE(twl4030_dapm_carkitr_controls)),
+
+	/* Output MUX controls */
 	/* HandsfreeL/R */
 	SND_SOC_DAPM_MUX_E("HandsfreeL Mux", TWL4030_REG_HFL_CTL, 5, 0,
 		&twl4030_dapm_handsfreel_control, handsfree_event,
@@ -1064,6 +1046,8 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 };
 
 static const struct snd_soc_dapm_route intercon[] = {
+	{"VDL_APGA", NULL, "DAC Voice"},
+
 	{"Analog L1 Playback Mixer", NULL, "DAC Left1"},
 	{"Analog R1 Playback Mixer", NULL, "DAC Right1"},
 	{"Analog L2 Playback Mixer", NULL, "DAC Left2"},
@@ -1076,48 +1060,57 @@ static const struct snd_soc_dapm_route intercon[] = {
 
 	/* Internal playback routings */
 	/* Earpiece */
-	{"Earpiece Mux", "DACL1", "ARXL1_APGA"},
-	{"Earpiece Mux", "DACL2", "ARXL2_APGA"},
-	{"Earpiece Mux", "DACR1", "ARXR1_APGA"},
+	{"Earpiece Mixer", "Voice", "VDL_APGA"},
+	{"Earpiece Mixer", "AudioL1", "ARXL1_APGA"},
+	{"Earpiece Mixer", "AudioL2", "ARXL2_APGA"},
+	{"Earpiece Mixer", "AudioR1", "ARXR1_APGA"},
 	/* PreDrivL */
-	{"PredriveL Mux", "DACL1", "ARXL1_APGA"},
-	{"PredriveL Mux", "DACL2", "ARXL2_APGA"},
-	{"PredriveL Mux", "DACR2", "ARXR2_APGA"},
+	{"PredriveL Mixer", "Voice", "VDL_APGA"},
+	{"PredriveL Mixer", "AudioL1", "ARXL1_APGA"},
+	{"PredriveL Mixer", "AudioL2", "ARXL2_APGA"},
+	{"PredriveL Mixer", "AudioR2", "ARXR2_APGA"},
 	/* PreDrivR */
-	{"PredriveR Mux", "DACR1", "ARXR1_APGA"},
-	{"PredriveR Mux", "DACR2", "ARXR2_APGA"},
-	{"PredriveR Mux", "DACL2", "ARXL2_APGA"},
+	{"PredriveR Mixer", "Voice", "VDL_APGA"},
+	{"PredriveR Mixer", "AudioR1", "ARXR1_APGA"},
+	{"PredriveR Mixer", "AudioR2", "ARXR2_APGA"},
+	{"PredriveR Mixer", "AudioL2", "ARXL2_APGA"},
 	/* HeadsetL */
-	{"HeadsetL Mux", "DACL1", "ARXL1_APGA"},
-	{"HeadsetL Mux", "DACL2", "ARXL2_APGA"},
+	{"HeadsetL Mixer", "Voice", "VDL_APGA"},
+	{"HeadsetL Mixer", "AudioL1", "ARXL1_APGA"},
+	{"HeadsetL Mixer", "AudioL2", "ARXL2_APGA"},
 	/* HeadsetR */
-	{"HeadsetR Mux", "DACR1", "ARXR1_APGA"},
-	{"HeadsetR Mux", "DACR2", "ARXR2_APGA"},
+	{"HeadsetR Mixer", "Voice", "VDL_APGA"},
+	{"HeadsetR Mixer", "AudioR1", "ARXR1_APGA"},
+	{"HeadsetR Mixer", "AudioR2", "ARXR2_APGA"},
 	/* CarkitL */
-	{"CarkitL Mux", "DACL1", "ARXL1_APGA"},
-	{"CarkitL Mux", "DACL2", "ARXL2_APGA"},
+	{"CarkitL Mixer", "Voice", "VDL_APGA"},
+	{"CarkitL Mixer", "AudioL1", "ARXL1_APGA"},
+	{"CarkitL Mixer", "AudioL2", "ARXL2_APGA"},
 	/* CarkitR */
-	{"CarkitR Mux", "DACR1", "ARXR1_APGA"},
-	{"CarkitR Mux", "DACR2", "ARXR2_APGA"},
+	{"CarkitR Mixer", "Voice", "VDL_APGA"},
+	{"CarkitR Mixer", "AudioR1", "ARXR1_APGA"},
+	{"CarkitR Mixer", "AudioR2", "ARXR2_APGA"},
 	/* HandsfreeL */
-	{"HandsfreeL Mux", "DACL1", "ARXL1_APGA"},
-	{"HandsfreeL Mux", "DACL2", "ARXL2_APGA"},
-	{"HandsfreeL Mux", "DACR2", "ARXR2_APGA"},
+	{"HandsfreeL Mux", "Voice", "VDL_APGA"},
+	{"HandsfreeL Mux", "AudioL1", "ARXL1_APGA"},
+	{"HandsfreeL Mux", "AudioL2", "ARXL2_APGA"},
+	{"HandsfreeL Mux", "AudioR2", "ARXR2_APGA"},
 	/* HandsfreeR */
-	{"HandsfreeR Mux", "DACR1", "ARXR1_APGA"},
-	{"HandsfreeR Mux", "DACR2", "ARXR2_APGA"},
-	{"HandsfreeR Mux", "DACL2", "ARXL2_APGA"},
+	{"HandsfreeR Mux", "Voice", "VDL_APGA"},
+	{"HandsfreeR Mux", "AudioR1", "ARXR1_APGA"},
+	{"HandsfreeR Mux", "AudioR2", "ARXR2_APGA"},
+	{"HandsfreeR Mux", "AudioL2", "ARXL2_APGA"},
 
 	/* outputs */
 	{"OUTL", NULL, "ARXL2_APGA"},
 	{"OUTR", NULL, "ARXR2_APGA"},
-	{"EARPIECE", NULL, "Earpiece Mux"},
-	{"PREDRIVEL", NULL, "PredriveL Mux"},
-	{"PREDRIVER", NULL, "PredriveR Mux"},
-	{"HSOL", NULL, "HeadsetL Mux"},
-	{"HSOR", NULL, "HeadsetR Mux"},
-	{"CARKITL", NULL, "CarkitL Mux"},
-	{"CARKITR", NULL, "CarkitR Mux"},
+	{"EARPIECE", NULL, "Earpiece Mixer"},
+	{"PREDRIVEL", NULL, "PredriveL Mixer"},
+	{"PREDRIVER", NULL, "PredriveR Mixer"},
+	{"HSOL", NULL, "HeadsetL Mixer"},
+	{"HSOR", NULL, "HeadsetR Mixer"},
+	{"CARKITL", NULL, "CarkitL Mixer"},
+	{"CARKITR", NULL, "CarkitR Mixer"},
 	{"HFL", NULL, "HandsfreeL Mux"},
 	{"HFR", NULL, "HandsfreeR Mux"},
 
-- 
1.5.6.3
