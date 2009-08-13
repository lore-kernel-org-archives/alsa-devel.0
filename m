From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 2/2] ASoC: TWL4030: Introduce PGAs for outputs
Date: Thu, 13 Aug 2009 15:59:34 +0300
Message-ID: <1250168374-24280-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1250168374-24280-1-git-send-email-peter.ujfalusi@nokia.com>
	<1250168374-24280-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C3381038D2
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Aug 2009 14:59:58 +0200 (CEST)
In-Reply-To: <1250168374-24280-2-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Dynamically control and control only the needed output amplifier
muting/un-muting.

The original code was muting and un-muting the following output
amplifiers: Earpiece PreDrivL/R, CarkitL/R at the same time
regardless which pin is actually in use at the given moment.

Move these as separate PGA so only the needed amplifier will be touched.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |  109 ++++++++++++++++++++++++--------------------
 1 files changed, 60 insertions(+), 49 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index c64e314..4902226 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -225,55 +225,11 @@ static void twl4030_codec_mute(struct snd_soc_codec *codec, int mute)
 		return;
 
 	if (mute) {
-		/* Bypass the reg_cache and mute the volumes
-		 * Headset mute is done in it's own event handler
-		 * Things to mute:  Earpiece, PreDrivL/R, CarkitL/R
-		 */
-		reg_val = twl4030_read_reg_cache(codec, TWL4030_REG_EAR_CTL);
-		twl4030_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
-					reg_val & (~TWL4030_EAR_GAIN),
-					TWL4030_REG_EAR_CTL);
-
-		reg_val = twl4030_read_reg_cache(codec, TWL4030_REG_PREDL_CTL);
-		twl4030_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
-					reg_val & (~TWL4030_PREDL_GAIN),
-					TWL4030_REG_PREDL_CTL);
-		reg_val = twl4030_read_reg_cache(codec, TWL4030_REG_PREDR_CTL);
-		twl4030_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
-					reg_val & (~TWL4030_PREDR_GAIN),
-					TWL4030_REG_PREDL_CTL);
-
-		reg_val = twl4030_read_reg_cache(codec, TWL4030_REG_PRECKL_CTL);
-		twl4030_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
-					reg_val & (~TWL4030_PRECKL_GAIN),
-					TWL4030_REG_PRECKL_CTL);
-		reg_val = twl4030_read_reg_cache(codec, TWL4030_REG_PRECKR_CTL);
-		twl4030_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
-					reg_val & (~TWL4030_PRECKR_GAIN),
-					TWL4030_REG_PRECKR_CTL);
-
 		/* Disable PLL */
 		reg_val = twl4030_read_reg_cache(codec, TWL4030_REG_APLL_CTL);
 		reg_val &= ~TWL4030_APLL_EN;
 		twl4030_write(codec, TWL4030_REG_APLL_CTL, reg_val);
 	} else {
-		/* Restore the volumes
-		 * Headset mute is done in it's own event handler
-		 * Things to restore:  Earpiece, PreDrivL/R, CarkitL/R
-		 */
-		twl4030_write(codec, TWL4030_REG_EAR_CTL,
-			twl4030_read_reg_cache(codec, TWL4030_REG_EAR_CTL));
-
-		twl4030_write(codec, TWL4030_REG_PREDL_CTL,
-			twl4030_read_reg_cache(codec, TWL4030_REG_PREDL_CTL));
-		twl4030_write(codec, TWL4030_REG_PREDR_CTL,
-			twl4030_read_reg_cache(codec, TWL4030_REG_PREDR_CTL));
-
-		twl4030_write(codec, TWL4030_REG_PRECKL_CTL,
-			twl4030_read_reg_cache(codec, TWL4030_REG_PRECKL_CTL));
-		twl4030_write(codec, TWL4030_REG_PRECKR_CTL,
-			twl4030_read_reg_cache(codec, TWL4030_REG_PRECKR_CTL));
-
 		/* Enable PLL */
 		reg_val = twl4030_read_reg_cache(codec, TWL4030_REG_APLL_CTL);
 		reg_val |= TWL4030_APLL_EN;
@@ -564,6 +520,41 @@ static int micpath_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+/*
+ * Output PGA builder:
+ * Handle the muting and unmuting of the given output (turning off the
+ * amplifier associated with the output pin)
+ * On mute bypass the reg_cache and mute the volume
+ * On unmute: restore the register content
+ * Outputs handled in this way:  Earpiece, PreDrivL/R, CarkitL/R
+ */
+#define TWL4030_OUTPUT_PGA(pin_name, reg, mask)				\
+static int pin_name##pga_event(struct snd_soc_dapm_widget *w,		\
+		struct snd_kcontrol *kcontrol, int event)		\
+{									\
+	u8 reg_val;							\
+									\
+	switch (event) {						\
+	case SND_SOC_DAPM_POST_PMU:					\
+		twl4030_write(w->codec, reg,				\
+			twl4030_read_reg_cache(w->codec, reg));		\
+		break;							\
+	case SND_SOC_DAPM_POST_PMD:					\
+		reg_val = twl4030_read_reg_cache(w->codec, reg);	\
+		twl4030_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,	\
+					reg_val & (~mask),		\
+					reg);				\
+		break;							\
+	}								\
+	return 0;							\
+}
+
+TWL4030_OUTPUT_PGA(earpiece, TWL4030_REG_EAR_CTL, TWL4030_EAR_GAIN);
+TWL4030_OUTPUT_PGA(predrivel, TWL4030_REG_PREDL_CTL, TWL4030_PREDL_GAIN);
+TWL4030_OUTPUT_PGA(predriver, TWL4030_REG_PREDR_CTL, TWL4030_PREDR_GAIN);
+TWL4030_OUTPUT_PGA(carkitl, TWL4030_REG_PRECKL_CTL, TWL4030_PRECKL_GAIN);
+TWL4030_OUTPUT_PGA(carkitr, TWL4030_REG_PRECKR_CTL, TWL4030_PRECKR_GAIN);
+
 static void handsfree_ramp(struct snd_soc_codec *codec, int reg, int ramp)
 {
 	unsigned char hs_ctl;
@@ -1257,13 +1248,22 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_MIXER("Earpiece Mixer", SND_SOC_NOPM, 0, 0,
 			&twl4030_dapm_earpiece_controls[0],
 			ARRAY_SIZE(twl4030_dapm_earpiece_controls)),
+	SND_SOC_DAPM_PGA_E("Earpiece PGA", SND_SOC_NOPM,
+			0, 0, NULL, 0, earpiecepga_event,
+			SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
 	/* PreDrivL/R */
 	SND_SOC_DAPM_MIXER("PredriveL Mixer", SND_SOC_NOPM, 0, 0,
 			&twl4030_dapm_predrivel_controls[0],
 			ARRAY_SIZE(twl4030_dapm_predrivel_controls)),
+	SND_SOC_DAPM_PGA_E("PredriveL PGA", SND_SOC_NOPM,
+			0, 0, NULL, 0, predrivelpga_event,
+			SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_MIXER("PredriveR Mixer", SND_SOC_NOPM, 0, 0,
 			&twl4030_dapm_predriver_controls[0],
 			ARRAY_SIZE(twl4030_dapm_predriver_controls)),
+	SND_SOC_DAPM_PGA_E("PredriveR PGA", SND_SOC_NOPM,
+			0, 0, NULL, 0, predriverpga_event,
+			SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
 	/* HeadsetL/R */
 	SND_SOC_DAPM_MIXER("HeadsetL Mixer", SND_SOC_NOPM, 0, 0,
 			&twl4030_dapm_hsol_controls[0],
@@ -1281,9 +1281,15 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	SND_SOC_DAPM_MIXER("CarkitL Mixer", SND_SOC_NOPM, 0, 0,
 			&twl4030_dapm_carkitl_controls[0],
 			ARRAY_SIZE(twl4030_dapm_carkitl_controls)),
+	SND_SOC_DAPM_PGA_E("CarkitL PGA", SND_SOC_NOPM,
+			0, 0, NULL, 0, carkitlpga_event,
+			SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_MIXER("CarkitR Mixer", SND_SOC_NOPM, 0, 0,
 			&twl4030_dapm_carkitr_controls[0],
 			ARRAY_SIZE(twl4030_dapm_carkitr_controls)),
+	SND_SOC_DAPM_PGA_E("CarkitR PGA", SND_SOC_NOPM,
+			0, 0, NULL, 0, carkitrpga_event,
+			SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
 
 	/* Output MUX controls */
 	/* HandsfreeL/R */
@@ -1375,16 +1381,19 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"Earpiece Mixer", "AudioL1", "Analog L1 Playback Mixer"},
 	{"Earpiece Mixer", "AudioL2", "Analog L2 Playback Mixer"},
 	{"Earpiece Mixer", "AudioR1", "Analog R1 Playback Mixer"},
+	{"Earpiece PGA", NULL, "Earpiece Mixer"},
 	/* PreDrivL */
 	{"PredriveL Mixer", "Voice", "Analog Voice Playback Mixer"},
 	{"PredriveL Mixer", "AudioL1", "Analog L1 Playback Mixer"},
 	{"PredriveL Mixer", "AudioL2", "Analog L2 Playback Mixer"},
 	{"PredriveL Mixer", "AudioR2", "Analog R2 Playback Mixer"},
+	{"PredriveL PGA", NULL, "PredriveL Mixer"},
 	/* PreDrivR */
 	{"PredriveR Mixer", "Voice", "Analog Voice Playback Mixer"},
 	{"PredriveR Mixer", "AudioR1", "Analog R1 Playback Mixer"},
 	{"PredriveR Mixer", "AudioR2", "Analog R2 Playback Mixer"},
 	{"PredriveR Mixer", "AudioL2", "Analog L2 Playback Mixer"},
+	{"PredriveR PGA", NULL, "PredriveR Mixer"},
 	/* HeadsetL */
 	{"HeadsetL Mixer", "Voice", "Analog Voice Playback Mixer"},
 	{"HeadsetL Mixer", "AudioL1", "Analog L1 Playback Mixer"},
@@ -1399,10 +1408,12 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"CarkitL Mixer", "Voice", "Analog Voice Playback Mixer"},
 	{"CarkitL Mixer", "AudioL1", "Analog L1 Playback Mixer"},
 	{"CarkitL Mixer", "AudioL2", "Analog L2 Playback Mixer"},
+	{"CarkitL PGA", NULL, "CarkitL Mixer"},
 	/* CarkitR */
 	{"CarkitR Mixer", "Voice", "Analog Voice Playback Mixer"},
 	{"CarkitR Mixer", "AudioR1", "Analog R1 Playback Mixer"},
 	{"CarkitR Mixer", "AudioR2", "Analog R2 Playback Mixer"},
+	{"CarkitR PGA", NULL, "CarkitR Mixer"},
 	/* HandsfreeL */
 	{"HandsfreeL Mux", "Voice", "Analog Voice Playback Mixer"},
 	{"HandsfreeL Mux", "AudioL1", "Analog L1 Playback Mixer"},
@@ -1426,13 +1437,13 @@ static const struct snd_soc_dapm_route intercon[] = {
 	/* outputs */
 	{"OUTL", NULL, "Analog L2 Playback Mixer"},
 	{"OUTR", NULL, "Analog R2 Playback Mixer"},
-	{"EARPIECE", NULL, "Earpiece Mixer"},
-	{"PREDRIVEL", NULL, "PredriveL Mixer"},
-	{"PREDRIVER", NULL, "PredriveR Mixer"},
+	{"EARPIECE", NULL, "Earpiece PGA"},
+	{"PREDRIVEL", NULL, "PredriveL PGA"},
+	{"PREDRIVER", NULL, "PredriveR PGA"},
 	{"HSOL", NULL, "HeadsetL PGA"},
 	{"HSOR", NULL, "HeadsetR PGA"},
-	{"CARKITL", NULL, "CarkitL Mixer"},
-	{"CARKITR", NULL, "CarkitR Mixer"},
+	{"CARKITL", NULL, "CarkitL PGA"},
+	{"CARKITR", NULL, "CarkitR PGA"},
 	{"HFL", NULL, "HandsfreeL PGA"},
 	{"HFR", NULL, "HandsfreeR PGA"},
 	{"Vibra Route", "Audio", "Vibra Mux"},
-- 
1.6.4
