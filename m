From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 3/4] ASoC: tlv320aic3x: Reimplement output
	mixers
Date: Fri, 27 Aug 2010 16:56:49 +0300
Message-ID: <1282917410-12000-4-git-send-email-jhnikula@gmail.com>
References: <1282917410-12000-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4DA83103899
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 15:56:14 +0200 (CEST)
Received: by mail-ew0-f51.google.com with SMTP id 21so1983186ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 27 Aug 2010 06:56:14 -0700 (PDT)
In-Reply-To: <1282917410-12000-1-git-send-email-jhnikula@gmail.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

It turned out that the output mixers and their routes were misdefined: They
are not mixing output pins to internal signals but opposite. This has worked
for direct left-to-left and right-to-right routes since for those there are
complete routes. For swapped left-to-right and right-to-left routes this is
not working since there are no routes defined between them.

Another consequence is that those misdefined mixers are incorrectly routed
to several output pins leading unnecessary pin powerings even if there is no
route active to them.

Fix these by reimplementing the output mixers and routes as they are in
hardware. For completeness add also a few missing links between internal
signals and outputs.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.c |  394 +++++++++++++++++++---------------------
 sound/soc/codecs/tlv320aic3x.h |    8 +
 2 files changed, 195 insertions(+), 207 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 6e4ed79..0a3b98c 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -389,22 +389,74 @@ SOC_DAPM_ENUM("Route", aic3x_enum[LHPCOM_ENUM]);
 static const struct snd_kcontrol_new aic3x_right_hpcom_mux_controls =
 SOC_DAPM_ENUM("Route", aic3x_enum[RHPCOM_ENUM]);
 
-/* Left DAC_L1 Mixer */
-static const struct snd_kcontrol_new aic3x_left_dac_mixer_controls[] = {
-	SOC_DAPM_SINGLE("LineL Switch", DACL1_2_LLOPM_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("LineR Switch", DACL1_2_RLOPM_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("Mono Switch", DACL1_2_MONOLOPM_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("HP Switch", DACL1_2_HPLOUT_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("HPCOM Switch", DACL1_2_HPLCOM_VOL, 7, 1, 0),
+/* Left Line Mixer */
+static const struct snd_kcontrol_new aic3x_left_line_mixer_controls[] = {
+	SOC_DAPM_SINGLE("Line2L Bypass Switch", LINE2L_2_LLOPM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("PGAL Bypass Switch", PGAL_2_LLOPM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("DACL1 Switch", DACL1_2_LLOPM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("Line2R Bypass Switch", LINE2R_2_LLOPM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("PGAR Bypass Switch", PGAR_2_LLOPM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("DACR1 Switch", DACR1_2_LLOPM_VOL, 7, 1, 0),
 };
 
-/* Right DAC_R1 Mixer */
-static const struct snd_kcontrol_new aic3x_right_dac_mixer_controls[] = {
-	SOC_DAPM_SINGLE("LineL Switch", DACR1_2_LLOPM_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("LineR Switch", DACR1_2_RLOPM_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("Mono Switch", DACR1_2_MONOLOPM_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("HP Switch", DACR1_2_HPROUT_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("HPCOM Switch", DACR1_2_HPRCOM_VOL, 7, 1, 0),
+/* Right Line Mixer */
+static const struct snd_kcontrol_new aic3x_right_line_mixer_controls[] = {
+	SOC_DAPM_SINGLE("Line2L Bypass Switch", LINE2L_2_RLOPM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("PGAL Bypass Switch", PGAL_2_RLOPM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("DACL1 Switch", DACL1_2_RLOPM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("Line2R Bypass Switch", LINE2R_2_RLOPM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("PGAR Bypass Switch", PGAR_2_RLOPM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("DACR1 Switch", DACR1_2_RLOPM_VOL, 7, 1, 0),
+};
+
+/* Mono Mixer */
+static const struct snd_kcontrol_new aic3x_mono_mixer_controls[] = {
+	SOC_DAPM_SINGLE("Line2L Bypass Switch", LINE2L_2_MONOLOPM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("PGAL Bypass Switch", PGAL_2_MONOLOPM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("DACL1 Switch", DACL1_2_MONOLOPM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("Line2R Bypass Switch", LINE2R_2_MONOLOPM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("PGAR Bypass Switch", PGAR_2_MONOLOPM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("DACR1 Switch", DACR1_2_MONOLOPM_VOL, 7, 1, 0),
+};
+
+/* Left HP Mixer */
+static const struct snd_kcontrol_new aic3x_left_hp_mixer_controls[] = {
+	SOC_DAPM_SINGLE("Line2L Bypass Switch", LINE2L_2_HPLOUT_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("PGAL Bypass Switch", PGAL_2_HPLOUT_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("DACL1 Switch", DACL1_2_HPLOUT_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("Line2R Bypass Switch", LINE2R_2_HPLOUT_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("PGAR Bypass Switch", PGAR_2_HPLOUT_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("DACR1 Switch", DACR1_2_HPLOUT_VOL, 7, 1, 0),
+};
+
+/* Right HP Mixer */
+static const struct snd_kcontrol_new aic3x_right_hp_mixer_controls[] = {
+	SOC_DAPM_SINGLE("Line2L Bypass Switch", LINE2L_2_HPROUT_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("PGAL Bypass Switch", PGAL_2_HPROUT_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("DACL1 Switch", DACL1_2_HPROUT_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("Line2R Bypass Switch", LINE2R_2_HPROUT_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("PGAR Bypass Switch", PGAR_2_HPROUT_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("DACR1 Switch", DACR1_2_HPROUT_VOL, 7, 1, 0),
+};
+
+/* Left HPCOM Mixer */
+static const struct snd_kcontrol_new aic3x_left_hpcom_mixer_controls[] = {
+	SOC_DAPM_SINGLE("Line2L Bypass Switch", LINE2L_2_HPLCOM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("PGAL Bypass Switch", PGAL_2_HPLCOM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("DACL1 Switch", DACL1_2_HPLCOM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("Line2R Bypass Switch", LINE2R_2_HPLCOM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("PGAR Bypass Switch", PGAR_2_HPLCOM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("DACR1 Switch", DACR1_2_HPLCOM_VOL, 7, 1, 0),
+};
+
+/* Right HPCOM Mixer */
+static const struct snd_kcontrol_new aic3x_right_hpcom_mixer_controls[] = {
+	SOC_DAPM_SINGLE("Line2L Bypass Switch", LINE2L_2_HPRCOM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("PGAL Bypass Switch", PGAL_2_HPRCOM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("DACL1 Switch", DACL1_2_HPRCOM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("Line2R Bypass Switch", LINE2R_2_HPRCOM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("PGAR Bypass Switch", PGAR_2_HPRCOM_VOL, 7, 1, 0),
+	SOC_DAPM_SINGLE("DACR1 Switch", DACR1_2_HPRCOM_VOL, 7, 1, 0),
 };
 
 /* Left PGA Mixer */
@@ -441,54 +493,11 @@ SOC_DAPM_ENUM("Route", aic3x_enum[LINE2L_ENUM]);
 static const struct snd_kcontrol_new aic3x_right_line2_mux_controls =
 SOC_DAPM_ENUM("Route", aic3x_enum[LINE2R_ENUM]);
 
-/* Left PGA Bypass Mixer */
-static const struct snd_kcontrol_new aic3x_left_pga_bp_mixer_controls[] = {
-	SOC_DAPM_SINGLE("LineL Switch", PGAL_2_LLOPM_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("LineR Switch", PGAL_2_RLOPM_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("Mono Switch", PGAL_2_MONOLOPM_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("HPL Switch", PGAL_2_HPLOUT_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("HPR Switch", PGAL_2_HPROUT_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("HPLCOM Switch", PGAL_2_HPLCOM_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("HPRCOM Switch", PGAL_2_HPRCOM_VOL, 7, 1, 0),
-};
-
-/* Right PGA Bypass Mixer */
-static const struct snd_kcontrol_new aic3x_right_pga_bp_mixer_controls[] = {
-	SOC_DAPM_SINGLE("LineL Switch", PGAR_2_LLOPM_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("LineR Switch", PGAR_2_RLOPM_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("Mono Switch", PGAR_2_MONOLOPM_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("HPL Switch", PGAR_2_HPLOUT_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("HPR Switch", PGAR_2_HPROUT_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("HPLCOM Switch", PGAR_2_HPLCOM_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("HPRCOM Switch", PGAR_2_HPRCOM_VOL, 7, 1, 0),
-};
-
-/* Left Line2 Bypass Mixer */
-static const struct snd_kcontrol_new aic3x_left_line2_bp_mixer_controls[] = {
-	SOC_DAPM_SINGLE("LineL Switch", LINE2L_2_LLOPM_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("LineR Switch", LINE2L_2_RLOPM_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("Mono Switch", LINE2L_2_MONOLOPM_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("HP Switch", LINE2L_2_HPLOUT_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("HPLCOM Switch", LINE2L_2_HPLCOM_VOL, 7, 1, 0),
-};
-
-/* Right Line2 Bypass Mixer */
-static const struct snd_kcontrol_new aic3x_right_line2_bp_mixer_controls[] = {
-	SOC_DAPM_SINGLE("LineL Switch", LINE2R_2_LLOPM_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("LineR Switch", LINE2R_2_RLOPM_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("Mono Switch", LINE2R_2_MONOLOPM_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("HP Switch", LINE2R_2_HPROUT_VOL, 7, 1, 0),
-	SOC_DAPM_SINGLE("HPRCOM Switch", LINE2R_2_HPRCOM_VOL, 7, 1, 0),
-};
-
 static const struct snd_soc_dapm_widget aic3x_dapm_widgets[] = {
 	/* Left DAC to Left Outputs */
 	SND_SOC_DAPM_DAC("Left DAC", "Left Playback", DAC_PWR, 7, 0),
 	SND_SOC_DAPM_MUX("Left DAC Mux", SND_SOC_NOPM, 0, 0,
 			 &aic3x_left_dac_mux_controls),
-	SND_SOC_DAPM_MIXER("Left DAC_L1 Mixer", SND_SOC_NOPM, 0, 0,
-			   &aic3x_left_dac_mixer_controls[0],
-			   ARRAY_SIZE(aic3x_left_dac_mixer_controls)),
 	SND_SOC_DAPM_MUX("Left HPCOM Mux", SND_SOC_NOPM, 0, 0,
 			 &aic3x_left_hpcom_mux_controls),
 	SND_SOC_DAPM_PGA("Left Line Out", LLOPM_CTRL, 0, 0, NULL, 0),
@@ -499,9 +508,6 @@ static const struct snd_soc_dapm_widget aic3x_dapm_widgets[] = {
 	SND_SOC_DAPM_DAC("Right DAC", "Right Playback", DAC_PWR, 6, 0),
 	SND_SOC_DAPM_MUX("Right DAC Mux", SND_SOC_NOPM, 0, 0,
 			 &aic3x_right_dac_mux_controls),
-	SND_SOC_DAPM_MIXER("Right DAC_R1 Mixer", SND_SOC_NOPM, 0, 0,
-			   &aic3x_right_dac_mixer_controls[0],
-			   ARRAY_SIZE(aic3x_right_dac_mixer_controls)),
 	SND_SOC_DAPM_MUX("Right HPCOM Mux", SND_SOC_NOPM, 0, 0,
 			 &aic3x_right_hpcom_mux_controls),
 	SND_SOC_DAPM_PGA("Right Line Out", RLOPM_CTRL, 0, 0, NULL, 0),
@@ -565,25 +571,28 @@ static const struct snd_soc_dapm_widget aic3x_dapm_widgets[] = {
 	SND_SOC_DAPM_REG(snd_soc_dapm_micbias, "Mic Bias AVDD",
 			 MICBIAS_CTRL, 6, 3, 3, 0),
 
-	/* Left PGA to Left Output bypass */
-	SND_SOC_DAPM_MIXER("Left PGA Bypass Mixer", SND_SOC_NOPM, 0, 0,
-			   &aic3x_left_pga_bp_mixer_controls[0],
-			   ARRAY_SIZE(aic3x_left_pga_bp_mixer_controls)),
-
-	/* Right PGA to Right Output bypass */
-	SND_SOC_DAPM_MIXER("Right PGA Bypass Mixer", SND_SOC_NOPM, 0, 0,
-			   &aic3x_right_pga_bp_mixer_controls[0],
-			   ARRAY_SIZE(aic3x_right_pga_bp_mixer_controls)),
-
-	/* Left Line2 to Left Output bypass */
-	SND_SOC_DAPM_MIXER("Left Line2 Bypass Mixer", SND_SOC_NOPM, 0, 0,
-			   &aic3x_left_line2_bp_mixer_controls[0],
-			   ARRAY_SIZE(aic3x_left_line2_bp_mixer_controls)),
-
-	/* Right Line2 to Right Output bypass */
-	SND_SOC_DAPM_MIXER("Right Line2 Bypass Mixer", SND_SOC_NOPM, 0, 0,
-			   &aic3x_right_line2_bp_mixer_controls[0],
-			   ARRAY_SIZE(aic3x_right_line2_bp_mixer_controls)),
+	/* Output mixers */
+	SND_SOC_DAPM_MIXER("Left Line Mixer", SND_SOC_NOPM, 0, 0,
+			   &aic3x_left_line_mixer_controls[0],
+			   ARRAY_SIZE(aic3x_left_line_mixer_controls)),
+	SND_SOC_DAPM_MIXER("Right Line Mixer", SND_SOC_NOPM, 0, 0,
+			   &aic3x_right_line_mixer_controls[0],
+			   ARRAY_SIZE(aic3x_right_line_mixer_controls)),
+	SND_SOC_DAPM_MIXER("Mono Mixer", SND_SOC_NOPM, 0, 0,
+			   &aic3x_mono_mixer_controls[0],
+			   ARRAY_SIZE(aic3x_mono_mixer_controls)),
+	SND_SOC_DAPM_MIXER("Left HP Mixer", SND_SOC_NOPM, 0, 0,
+			   &aic3x_left_hp_mixer_controls[0],
+			   ARRAY_SIZE(aic3x_left_hp_mixer_controls)),
+	SND_SOC_DAPM_MIXER("Right HP Mixer", SND_SOC_NOPM, 0, 0,
+			   &aic3x_right_hp_mixer_controls[0],
+			   ARRAY_SIZE(aic3x_right_hp_mixer_controls)),
+	SND_SOC_DAPM_MIXER("Left HPCOM Mixer", SND_SOC_NOPM, 0, 0,
+			   &aic3x_left_hpcom_mixer_controls[0],
+			   ARRAY_SIZE(aic3x_left_hpcom_mixer_controls)),
+	SND_SOC_DAPM_MIXER("Right HPCOM Mixer", SND_SOC_NOPM, 0, 0,
+			   &aic3x_right_hpcom_mixer_controls[0],
+			   ARRAY_SIZE(aic3x_right_hpcom_mixer_controls)),
 
 	SND_SOC_DAPM_OUTPUT("LLOUT"),
 	SND_SOC_DAPM_OUTPUT("RLOUT"),
@@ -611,66 +620,6 @@ static const struct snd_soc_dapm_widget aic3007_dapm_widgets[] = {
 };
 
 static const struct snd_soc_dapm_route intercon[] = {
-	/* Left Output */
-	{"Left DAC Mux", "DAC_L1", "Left DAC"},
-	{"Left DAC Mux", "DAC_L2", "Left DAC"},
-	{"Left DAC Mux", "DAC_L3", "Left DAC"},
-
-	{"Left DAC_L1 Mixer", "LineL Switch", "Left DAC Mux"},
-	{"Left DAC_L1 Mixer", "LineR Switch", "Left DAC Mux"},
-	{"Left DAC_L1 Mixer", "Mono Switch", "Left DAC Mux"},
-	{"Left DAC_L1 Mixer", "HP Switch", "Left DAC Mux"},
-	{"Left DAC_L1 Mixer", "HPCOM Switch", "Left DAC Mux"},
-	{"Left Line Out", NULL, "Left DAC Mux"},
-	{"Left HP Out", NULL, "Left DAC Mux"},
-
-	{"Left HPCOM Mux", "differential of HPLOUT", "Left DAC_L1 Mixer"},
-	{"Left HPCOM Mux", "constant VCM", "Left DAC_L1 Mixer"},
-	{"Left HPCOM Mux", "single-ended", "Left DAC_L1 Mixer"},
-
-	{"Left Line Out", NULL, "Left DAC_L1 Mixer"},
-	{"Mono Out", NULL, "Left DAC_L1 Mixer"},
-	{"Left HP Out", NULL, "Left DAC_L1 Mixer"},
-	{"Left HP Com", NULL, "Left HPCOM Mux"},
-
-	{"LLOUT", NULL, "Left Line Out"},
-	{"LLOUT", NULL, "Left Line Out"},
-	{"HPLOUT", NULL, "Left HP Out"},
-	{"HPLCOM", NULL, "Left HP Com"},
-
-	/* Right Output */
-	{"Right DAC Mux", "DAC_R1", "Right DAC"},
-	{"Right DAC Mux", "DAC_R2", "Right DAC"},
-	{"Right DAC Mux", "DAC_R3", "Right DAC"},
-
-	{"Right DAC_R1 Mixer", "LineL Switch", "Right DAC Mux"},
-	{"Right DAC_R1 Mixer", "LineR Switch", "Right DAC Mux"},
-	{"Right DAC_R1 Mixer", "Mono Switch", "Right DAC Mux"},
-	{"Right DAC_R1 Mixer", "HP Switch", "Right DAC Mux"},
-	{"Right DAC_R1 Mixer", "HPCOM Switch", "Right DAC Mux"},
-	{"Right Line Out", NULL, "Right DAC Mux"},
-	{"Right HP Out", NULL, "Right DAC Mux"},
-
-	{"Right HPCOM Mux", "differential of HPROUT", "Right DAC_R1 Mixer"},
-	{"Right HPCOM Mux", "constant VCM", "Right DAC_R1 Mixer"},
-	{"Right HPCOM Mux", "single-ended", "Right DAC_R1 Mixer"},
-	{"Right HPCOM Mux", "differential of HPLCOM", "Right DAC_R1 Mixer"},
-	{"Right HPCOM Mux", "external feedback", "Right DAC_R1 Mixer"},
-
-	{"Right Line Out", NULL, "Right DAC_R1 Mixer"},
-	{"Mono Out", NULL, "Right DAC_R1 Mixer"},
-	{"Right HP Out", NULL, "Right DAC_R1 Mixer"},
-	{"Right HP Com", NULL, "Right HPCOM Mux"},
-
-	{"RLOUT", NULL, "Right Line Out"},
-	{"RLOUT", NULL, "Right Line Out"},
-	{"HPROUT", NULL, "Right HP Out"},
-	{"HPRCOM", NULL, "Right HP Com"},
-
-	/* Mono Output */
-	{"MONO_LOUT", NULL, "Mono Out"},
-	{"MONO_LOUT", NULL, "Mono Out"},
-
 	/* Left Input */
 	{"Left Line1L Mux", "single-ended", "LINE1L"},
 	{"Left Line1L Mux", "differential", "LINE1L"},
@@ -703,74 +652,6 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"Right ADC", NULL, "Right PGA Mixer"},
 	{"Right ADC", NULL, "GPIO1 dmic modclk"},
 
-	/* Left PGA Bypass */
-	{"Left PGA Bypass Mixer", "LineL Switch", "Left PGA Mixer"},
-	{"Left PGA Bypass Mixer", "LineR Switch", "Left PGA Mixer"},
-	{"Left PGA Bypass Mixer", "Mono Switch", "Left PGA Mixer"},
-	{"Left PGA Bypass Mixer", "HPL Switch", "Left PGA Mixer"},
-	{"Left PGA Bypass Mixer", "HPR Switch", "Left PGA Mixer"},
-	{"Left PGA Bypass Mixer", "HPLCOM Switch", "Left PGA Mixer"},
-	{"Left PGA Bypass Mixer", "HPRCOM Switch", "Left PGA Mixer"},
-
-	{"Left HPCOM Mux", "differential of HPLOUT", "Left PGA Bypass Mixer"},
-	{"Left HPCOM Mux", "constant VCM", "Left PGA Bypass Mixer"},
-	{"Left HPCOM Mux", "single-ended", "Left PGA Bypass Mixer"},
-
-	{"Left Line Out", NULL, "Left PGA Bypass Mixer"},
-	{"Mono Out", NULL, "Left PGA Bypass Mixer"},
-	{"Left HP Out", NULL, "Left PGA Bypass Mixer"},
-
-	/* Right PGA Bypass */
-	{"Right PGA Bypass Mixer", "LineL Switch", "Right PGA Mixer"},
-	{"Right PGA Bypass Mixer", "LineR Switch", "Right PGA Mixer"},
-	{"Right PGA Bypass Mixer", "Mono Switch", "Right PGA Mixer"},
-	{"Right PGA Bypass Mixer", "HPL Switch", "Right PGA Mixer"},
-	{"Right PGA Bypass Mixer", "HPR Switch", "Right PGA Mixer"},
-	{"Right PGA Bypass Mixer", "HPLCOM Switch", "Right PGA Mixer"},
-	{"Right PGA Bypass Mixer", "HPRCOM Switch", "Right PGA Mixer"},
-
-	{"Right HPCOM Mux", "differential of HPROUT", "Right PGA Bypass Mixer"},
-	{"Right HPCOM Mux", "constant VCM", "Right PGA Bypass Mixer"},
-	{"Right HPCOM Mux", "single-ended", "Right PGA Bypass Mixer"},
-	{"Right HPCOM Mux", "differential of HPLCOM", "Right PGA Bypass Mixer"},
-	{"Right HPCOM Mux", "external feedback", "Right PGA Bypass Mixer"},
-
-	{"Right Line Out", NULL, "Right PGA Bypass Mixer"},
-	{"Mono Out", NULL, "Right PGA Bypass Mixer"},
-	{"Right HP Out", NULL, "Right PGA Bypass Mixer"},
-
-	/* Left Line2 Bypass */
-	{"Left Line2 Bypass Mixer", "LineL Switch", "Left Line2L Mux"},
-	{"Left Line2 Bypass Mixer", "LineR Switch", "Left Line2L Mux"},
-	{"Left Line2 Bypass Mixer", "Mono Switch", "Left Line2L Mux"},
-	{"Left Line2 Bypass Mixer", "HP Switch", "Left Line2L Mux"},
-	{"Left Line2 Bypass Mixer", "HPLCOM Switch", "Left Line2L Mux"},
-
-	{"Left HPCOM Mux", "differential of HPLOUT", "Left Line2 Bypass Mixer"},
-	{"Left HPCOM Mux", "constant VCM", "Left Line2 Bypass Mixer"},
-	{"Left HPCOM Mux", "single-ended", "Left Line2 Bypass Mixer"},
-
-	{"Left Line Out", NULL, "Left Line2 Bypass Mixer"},
-	{"Mono Out", NULL, "Left Line2 Bypass Mixer"},
-	{"Left HP Out", NULL, "Left Line2 Bypass Mixer"},
-
-	/* Right Line2 Bypass */
-	{"Right Line2 Bypass Mixer", "LineL Switch", "Right Line2R Mux"},
-	{"Right Line2 Bypass Mixer", "LineR Switch", "Right Line2R Mux"},
-	{"Right Line2 Bypass Mixer", "Mono Switch", "Right Line2R Mux"},
-	{"Right Line2 Bypass Mixer", "HP Switch", "Right Line2R Mux"},
-	{"Right Line2 Bypass Mixer", "HPRCOM Switch", "Right Line2R Mux"},
-
-	{"Right HPCOM Mux", "differential of HPROUT", "Right Line2 Bypass Mixer"},
-	{"Right HPCOM Mux", "constant VCM", "Right Line2 Bypass Mixer"},
-	{"Right HPCOM Mux", "single-ended", "Right Line2 Bypass Mixer"},
-	{"Right HPCOM Mux", "differential of HPLCOM", "Right Line2 Bypass Mixer"},
-	{"Right HPCOM Mux", "external feedback", "Right Line2 Bypass Mixer"},
-
-	{"Right Line Out", NULL, "Right Line2 Bypass Mixer"},
-	{"Mono Out", NULL, "Right Line2 Bypass Mixer"},
-	{"Right HP Out", NULL, "Right Line2 Bypass Mixer"},
-
 	/*
 	 * Logical path between digital mic enable and GPIO1 modulator clock
 	 * output function
@@ -778,6 +659,105 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"GPIO1 dmic modclk", NULL, "DMic Rate 128"},
 	{"GPIO1 dmic modclk", NULL, "DMic Rate 64"},
 	{"GPIO1 dmic modclk", NULL, "DMic Rate 32"},
+
+	/* Left DAC Output */
+	{"Left DAC Mux", "DAC_L1", "Left DAC"},
+	{"Left DAC Mux", "DAC_L2", "Left DAC"},
+	{"Left DAC Mux", "DAC_L3", "Left DAC"},
+
+	/* Right DAC Output */
+	{"Right DAC Mux", "DAC_R1", "Right DAC"},
+	{"Right DAC Mux", "DAC_R2", "Right DAC"},
+	{"Right DAC Mux", "DAC_R3", "Right DAC"},
+
+	/* Left Line Output */
+	{"Left Line Mixer", "Line2L Bypass Switch", "Left Line2L Mux"},
+	{"Left Line Mixer", "PGAL Bypass Switch", "Left PGA Mixer"},
+	{"Left Line Mixer", "DACL1 Switch", "Left DAC Mux"},
+	{"Left Line Mixer", "Line2R Bypass Switch", "Right Line2R Mux"},
+	{"Left Line Mixer", "PGAR Bypass Switch", "Right PGA Mixer"},
+	{"Left Line Mixer", "DACR1 Switch", "Right DAC Mux"},
+
+	{"Left Line Out", NULL, "Left Line Mixer"},
+	{"Left Line Out", NULL, "Left DAC Mux"},
+	{"LLOUT", NULL, "Left Line Out"},
+
+	/* Right Line Output */
+	{"Right Line Mixer", "Line2L Bypass Switch", "Left Line2L Mux"},
+	{"Right Line Mixer", "PGAL Bypass Switch", "Left PGA Mixer"},
+	{"Right Line Mixer", "DACL1 Switch", "Left DAC Mux"},
+	{"Right Line Mixer", "Line2R Bypass Switch", "Right Line2R Mux"},
+	{"Right Line Mixer", "PGAR Bypass Switch", "Right PGA Mixer"},
+	{"Right Line Mixer", "DACR1 Switch", "Right DAC Mux"},
+
+	{"Right Line Out", NULL, "Right Line Mixer"},
+	{"Right Line Out", NULL, "Right DAC Mux"},
+	{"RLOUT", NULL, "Right Line Out"},
+
+	/* Mono Output */
+	{"Mono Mixer", "Line2L Bypass Switch", "Left Line2L Mux"},
+	{"Mono Mixer", "PGAL Bypass Switch", "Left PGA Mixer"},
+	{"Mono Mixer", "DACL1 Switch", "Left DAC Mux"},
+	{"Mono Mixer", "Line2R Bypass Switch", "Right Line2R Mux"},
+	{"Mono Mixer", "PGAR Bypass Switch", "Right PGA Mixer"},
+	{"Mono Mixer", "DACR1 Switch", "Right DAC Mux"},
+
+	{"Mono Out", NULL, "Mono Mixer"},
+	{"MONO_LOUT", NULL, "Mono Out"},
+
+	/* Left HP Output */
+	{"Left HP Mixer", "Line2L Bypass Switch", "Left Line2L Mux"},
+	{"Left HP Mixer", "PGAL Bypass Switch", "Left PGA Mixer"},
+	{"Left HP Mixer", "DACL1 Switch", "Left DAC Mux"},
+	{"Left HP Mixer", "Line2R Bypass Switch", "Right Line2R Mux"},
+	{"Left HP Mixer", "PGAR Bypass Switch", "Right PGA Mixer"},
+	{"Left HP Mixer", "DACR1 Switch", "Right DAC Mux"},
+
+	{"Left HP Out", NULL, "Left HP Mixer"},
+	{"Left HP Out", NULL, "Left DAC Mux"},
+	{"HPLOUT", NULL, "Left HP Out"},
+
+	/* Right HP Output */
+	{"Right HP Mixer", "Line2L Bypass Switch", "Left Line2L Mux"},
+	{"Right HP Mixer", "PGAL Bypass Switch", "Left PGA Mixer"},
+	{"Right HP Mixer", "DACL1 Switch", "Left DAC Mux"},
+	{"Right HP Mixer", "Line2R Bypass Switch", "Right Line2R Mux"},
+	{"Right HP Mixer", "PGAR Bypass Switch", "Right PGA Mixer"},
+	{"Right HP Mixer", "DACR1 Switch", "Right DAC Mux"},
+
+	{"Right HP Out", NULL, "Right HP Mixer"},
+	{"Right HP Out", NULL, "Right DAC Mux"},
+	{"HPROUT", NULL, "Right HP Out"},
+
+	/* Left HPCOM Output */
+	{"Left HPCOM Mixer", "Line2L Bypass Switch", "Left Line2L Mux"},
+	{"Left HPCOM Mixer", "PGAL Bypass Switch", "Left PGA Mixer"},
+	{"Left HPCOM Mixer", "DACL1 Switch", "Left DAC Mux"},
+	{"Left HPCOM Mixer", "Line2R Bypass Switch", "Right Line2R Mux"},
+	{"Left HPCOM Mixer", "PGAR Bypass Switch", "Right PGA Mixer"},
+	{"Left HPCOM Mixer", "DACR1 Switch", "Right DAC Mux"},
+
+	{"Left HPCOM Mux", "differential of HPLOUT", "Left HP Mixer"},
+	{"Left HPCOM Mux", "constant VCM", "Left HPCOM Mixer"},
+	{"Left HPCOM Mux", "single-ended", "Left HPCOM Mixer"},
+	{"Left HP Com", NULL, "Left HPCOM Mux"},
+	{"HPLCOM", NULL, "Left HP Com"},
+
+	/* Right HPCOM Output */
+	{"Right HPCOM Mixer", "Line2L Bypass Switch", "Left Line2L Mux"},
+	{"Right HPCOM Mixer", "PGAL Bypass Switch", "Left PGA Mixer"},
+	{"Right HPCOM Mixer", "DACL1 Switch", "Left DAC Mux"},
+	{"Right HPCOM Mixer", "Line2R Bypass Switch", "Right Line2R Mux"},
+	{"Right HPCOM Mixer", "PGAR Bypass Switch", "Right PGA Mixer"},
+	{"Right HPCOM Mixer", "DACR1 Switch", "Right DAC Mux"},
+
+	{"Right HPCOM Mux", "differential of HPROUT", "Right HP Mixer"},
+	{"Right HPCOM Mux", "constant VCM", "Right HPCOM Mixer"},
+	{"Right HPCOM Mux", "single-ended", "Right HPCOM Mixer"},
+	{"Right HPCOM Mux", "differential of HPLCOM", "Left HPCOM Mixer"},
+	{"Right HPCOM Mux", "external feedback", "Right HPCOM Mixer"},
+	{"Right HP Com", NULL, "Right HPCOM Mux"},
+	{"HPRCOM", NULL, "Right HP Com"},
 };
 
 static const struct snd_soc_dapm_route intercon_3007[] = {
diff --git a/sound/soc/codecs/tlv320aic3x.h b/sound/soc/codecs/tlv320aic3x.h
index 20d8cac..06a1978 100644
--- a/sound/soc/codecs/tlv320aic3x.h
+++ b/sound/soc/codecs/tlv320aic3x.h
@@ -85,22 +85,30 @@
 #define LINE2L_2_HPLOUT_VOL		45
 #define PGAL_2_HPLOUT_VOL		46
 #define DACL1_2_HPLOUT_VOL		47
+#define LINE2R_2_HPLOUT_VOL		48
 #define PGAR_2_HPLOUT_VOL		49
+#define DACR1_2_HPLOUT_VOL		50
 #define HPLOUT_CTRL			51
 /* Left High Power COM control registers */
 #define LINE2L_2_HPLCOM_VOL		52
 #define PGAL_2_HPLCOM_VOL		53
 #define DACL1_2_HPLCOM_VOL		54
+#define LINE2R_2_HPLCOM_VOL		55
 #define PGAR_2_HPLCOM_VOL		56
+#define DACR1_2_HPLCOM_VOL		57
 #define HPLCOM_CTRL			58
 /* Right High Power Output control registers */
+#define LINE2L_2_HPROUT_VOL		59
 #define PGAL_2_HPROUT_VOL		60
+#define DACL1_2_HPROUT_VOL		61
 #define LINE2R_2_HPROUT_VOL		62
 #define PGAR_2_HPROUT_VOL		63
 #define DACR1_2_HPROUT_VOL		64
 #define HPROUT_CTRL			65
 /* Right High Power COM control registers */
+#define LINE2L_2_HPRCOM_VOL		66
 #define PGAL_2_HPRCOM_VOL		67
+#define DACL1_2_HPRCOM_VOL		68
 #define LINE2R_2_HPRCOM_VOL		69
 #define PGAR_2_HPRCOM_VOL		70
 #define DACR1_2_HPRCOM_VOL		71
-- 
1.7.1
