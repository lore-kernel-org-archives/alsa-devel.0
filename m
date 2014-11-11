From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] ASoC: tlv320aic3x: Convert
	SOC_ENUM_SINGLE/DOUBLE arrays to individual
Date: Tue, 11 Nov 2014 10:59:00 +0200
Message-ID: <1415696341-12802-2-git-send-email-peter.ujfalusi@ti.com>
References: <1415696341-12802-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 99DDC264F37
 for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2014 09:59:08 +0100 (CET)
In-Reply-To: <1415696341-12802-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

It is easier to find the relevant enums in the code. Use the
SOC_ENUM_*_DECL macro for the individual items.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/tlv320aic3x.c | 151 +++++++++++++++++++++--------------------
 1 file changed, 79 insertions(+), 72 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 8770e28e53a4..990140058aa6 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -216,61 +216,68 @@ static int mic_bias_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static const char *aic3x_left_dac_mux[] = { "DAC_L1", "DAC_L3", "DAC_L2" };
-static const char *aic3x_right_dac_mux[] = { "DAC_R1", "DAC_R3", "DAC_R2" };
-static const char *aic3x_left_hpcom_mux[] =
-    { "differential of HPLOUT", "constant VCM", "single-ended" };
-static const char *aic3x_right_hpcom_mux[] =
-    { "differential of HPROUT", "constant VCM", "single-ended",
-      "differential of HPLCOM", "external feedback" };
-static const char *aic3x_linein_mode_mux[] = { "single-ended", "differential" };
-static const char *aic3x_adc_hpf[] =
-    { "Disabled", "0.0045xFs", "0.0125xFs", "0.025xFs" };
-
-#define LDAC_ENUM	0
-#define RDAC_ENUM	1
-#define LHPCOM_ENUM	2
-#define RHPCOM_ENUM	3
-#define LINE1L_2_L_ENUM	4
-#define LINE1L_2_R_ENUM	5
-#define LINE1R_2_L_ENUM	6
-#define LINE1R_2_R_ENUM	7
-#define LINE2L_ENUM	8
-#define LINE2R_ENUM	9
-#define ADC_HPF_ENUM	10
-
-static const struct soc_enum aic3x_enum[] = {
-	SOC_ENUM_SINGLE(DAC_LINE_MUX, 6, 3, aic3x_left_dac_mux),
-	SOC_ENUM_SINGLE(DAC_LINE_MUX, 4, 3, aic3x_right_dac_mux),
-	SOC_ENUM_SINGLE(HPLCOM_CFG, 4, 3, aic3x_left_hpcom_mux),
-	SOC_ENUM_SINGLE(HPRCOM_CFG, 3, 5, aic3x_right_hpcom_mux),
-	SOC_ENUM_SINGLE(LINE1L_2_LADC_CTRL, 7, 2, aic3x_linein_mode_mux),
-	SOC_ENUM_SINGLE(LINE1L_2_RADC_CTRL, 7, 2, aic3x_linein_mode_mux),
-	SOC_ENUM_SINGLE(LINE1R_2_LADC_CTRL, 7, 2, aic3x_linein_mode_mux),
-	SOC_ENUM_SINGLE(LINE1R_2_RADC_CTRL, 7, 2, aic3x_linein_mode_mux),
-	SOC_ENUM_SINGLE(LINE2L_2_LADC_CTRL, 7, 2, aic3x_linein_mode_mux),
-	SOC_ENUM_SINGLE(LINE2R_2_RADC_CTRL, 7, 2, aic3x_linein_mode_mux),
-	SOC_ENUM_DOUBLE(AIC3X_CODEC_DFILT_CTRL, 6, 4, 4, aic3x_adc_hpf),
-};
-
-static const char *aic3x_agc_level[] =
-	{ "-5.5dB", "-8dB", "-10dB", "-12dB", "-14dB", "-17dB", "-20dB", "-24dB" };
-static const struct soc_enum aic3x_agc_level_enum[] = {
-	SOC_ENUM_SINGLE(LAGC_CTRL_A, 4, 8, aic3x_agc_level),
-	SOC_ENUM_SINGLE(RAGC_CTRL_A, 4, 8, aic3x_agc_level),
-};
-
-static const char *aic3x_agc_attack[] = { "8ms", "11ms", "16ms", "20ms" };
-static const struct soc_enum aic3x_agc_attack_enum[] = {
-	SOC_ENUM_SINGLE(LAGC_CTRL_A, 2, 4, aic3x_agc_attack),
-	SOC_ENUM_SINGLE(RAGC_CTRL_A, 2, 4, aic3x_agc_attack),
-};
-
-static const char *aic3x_agc_decay[] = { "100ms", "200ms", "400ms", "500ms" };
-static const struct soc_enum aic3x_agc_decay_enum[] = {
-	SOC_ENUM_SINGLE(LAGC_CTRL_A, 0, 4, aic3x_agc_decay),
-	SOC_ENUM_SINGLE(RAGC_CTRL_A, 0, 4, aic3x_agc_decay),
-};
+static const char * const aic3x_left_dac_mux[] = {
+	"DAC_L1", "DAC_L3", "DAC_L2" };
+static SOC_ENUM_SINGLE_DECL(aic3x_left_dac_enum, DAC_LINE_MUX, 6,
+			    aic3x_left_dac_mux);
+
+static const char * const aic3x_right_dac_mux[] = {
+	"DAC_R1", "DAC_R3", "DAC_R2" };
+static SOC_ENUM_SINGLE_DECL(aic3x_right_dac_enum, DAC_LINE_MUX, 4,
+			    aic3x_right_dac_mux);
+
+static const char * const aic3x_left_hpcom_mux[] = {
+	"differential of HPLOUT", "constant VCM", "single-ended" };
+static SOC_ENUM_SINGLE_DECL(aic3x_left_hpcom_enum, HPLCOM_CFG, 4,
+			    aic3x_left_hpcom_mux);
+
+static const char * const aic3x_right_hpcom_mux[] = {
+	"differential of HPROUT", "constant VCM", "single-ended",
+	"differential of HPLCOM", "external feedback" };
+static SOC_ENUM_SINGLE_DECL(aic3x_right_hpcom_enum, HPRCOM_CFG, 3,
+			    aic3x_right_hpcom_mux);
+
+static const char * const aic3x_linein_mode_mux[] = {
+	"single-ended", "differential" };
+static SOC_ENUM_SINGLE_DECL(aic3x_line1l_2_l_enum, LINE1L_2_LADC_CTRL, 7,
+			    aic3x_linein_mode_mux);
+static SOC_ENUM_SINGLE_DECL(aic3x_line1l_2_r_enum, LINE1L_2_RADC_CTRL, 7,
+			    aic3x_linein_mode_mux);
+static SOC_ENUM_SINGLE_DECL(aic3x_line1r_2_l_enum, LINE1R_2_LADC_CTRL, 7,
+			    aic3x_linein_mode_mux);
+static SOC_ENUM_SINGLE_DECL(aic3x_line1r_2_r_enum, LINE1R_2_RADC_CTRL, 7,
+			    aic3x_linein_mode_mux);
+static SOC_ENUM_SINGLE_DECL(aic3x_line2l_2_ldac_enum, LINE2L_2_LADC_CTRL, 7,
+			    aic3x_linein_mode_mux);
+static SOC_ENUM_SINGLE_DECL(aic3x_line2r_2_rdac_enum, LINE2R_2_RADC_CTRL, 7,
+			    aic3x_linein_mode_mux);
+
+static const char * const aic3x_adc_hpf[] = {
+	"Disabled", "0.0045xFs", "0.0125xFs", "0.025xFs" };
+static SOC_ENUM_DOUBLE_DECL(aic3x_adc_hpf_enum, AIC3X_CODEC_DFILT_CTRL, 6, 4,
+			    aic3x_adc_hpf);
+
+static const char * const aic3x_agc_level[] = {
+	"-5.5dB", "-8dB", "-10dB", "-12dB",
+	"-14dB", "-17dB", "-20dB", "-24dB" };
+static SOC_ENUM_SINGLE_DECL(aic3x_lagc_level_enum, LAGC_CTRL_A, 4,
+			    aic3x_agc_level);
+static SOC_ENUM_SINGLE_DECL(aic3x_ragc_level_enum, RAGC_CTRL_A, 4,
+			    aic3x_agc_level);
+
+static const char * const aic3x_agc_attack[] = {
+	"8ms", "11ms", "16ms", "20ms" };
+static SOC_ENUM_SINGLE_DECL(aic3x_lagc_attack_enum, LAGC_CTRL_A, 2,
+			    aic3x_agc_attack);
+static SOC_ENUM_SINGLE_DECL(aic3x_ragc_attack_enum, RAGC_CTRL_A, 2,
+			    aic3x_agc_attack);
+
+static const char * const aic3x_agc_decay[] = {
+	"100ms", "200ms", "400ms", "500ms" };
+static SOC_ENUM_SINGLE_DECL(aic3x_lagc_decay_enum, LAGC_CTRL_A, 0,
+			    aic3x_agc_decay);
+static SOC_ENUM_SINGLE_DECL(aic3x_ragc_decay_enum, RAGC_CTRL_A, 0,
+			    aic3x_agc_decay);
 
 /*
  * DAC digital volumes. From -63.5 to 0 dB in 0.5 dB steps
@@ -385,12 +392,12 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 	 * adjust PGA to max value when ADC is on and will never go back.
 	*/
 	SOC_DOUBLE_R("AGC Switch", LAGC_CTRL_A, RAGC_CTRL_A, 7, 0x01, 0),
-	SOC_ENUM("Left AGC Target level", aic3x_agc_level_enum[0]),
-	SOC_ENUM("Right AGC Target level", aic3x_agc_level_enum[1]),
-	SOC_ENUM("Left AGC Attack time", aic3x_agc_attack_enum[0]),
-	SOC_ENUM("Right AGC Attack time", aic3x_agc_attack_enum[1]),
-	SOC_ENUM("Left AGC Decay time", aic3x_agc_decay_enum[0]),
-	SOC_ENUM("Right AGC Decay time", aic3x_agc_decay_enum[1]),
+	SOC_ENUM("Left AGC Target level", aic3x_lagc_level_enum),
+	SOC_ENUM("Right AGC Target level", aic3x_ragc_level_enum),
+	SOC_ENUM("Left AGC Attack time", aic3x_lagc_attack_enum),
+	SOC_ENUM("Right AGC Attack time", aic3x_ragc_attack_enum),
+	SOC_ENUM("Left AGC Decay time", aic3x_lagc_decay_enum),
+	SOC_ENUM("Right AGC Decay time", aic3x_ragc_decay_enum),
 
 	/* De-emphasis */
 	SOC_DOUBLE("De-emphasis Switch", AIC3X_CODEC_DFILT_CTRL, 2, 0, 0x01, 0),
@@ -400,7 +407,7 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 			 0, 119, 0, adc_tlv),
 	SOC_DOUBLE_R("PGA Capture Switch", LADC_VOL, RADC_VOL, 7, 0x01, 1),
 
-	SOC_ENUM("ADC HPF Cut-off", aic3x_enum[ADC_HPF_ENUM]),
+	SOC_ENUM("ADC HPF Cut-off", aic3x_adc_hpf_enum),
 };
 
 static const struct snd_kcontrol_new aic3x_mono_controls[] = {
@@ -427,19 +434,19 @@ static const struct snd_kcontrol_new aic3x_classd_amp_gain_ctrl =
 
 /* Left DAC Mux */
 static const struct snd_kcontrol_new aic3x_left_dac_mux_controls =
-SOC_DAPM_ENUM("Route", aic3x_enum[LDAC_ENUM]);
+SOC_DAPM_ENUM("Route", aic3x_left_dac_enum);
 
 /* Right DAC Mux */
 static const struct snd_kcontrol_new aic3x_right_dac_mux_controls =
-SOC_DAPM_ENUM("Route", aic3x_enum[RDAC_ENUM]);
+SOC_DAPM_ENUM("Route", aic3x_right_dac_enum);
 
 /* Left HPCOM Mux */
 static const struct snd_kcontrol_new aic3x_left_hpcom_mux_controls =
-SOC_DAPM_ENUM("Route", aic3x_enum[LHPCOM_ENUM]);
+SOC_DAPM_ENUM("Route", aic3x_left_hpcom_enum);
 
 /* Right HPCOM Mux */
 static const struct snd_kcontrol_new aic3x_right_hpcom_mux_controls =
-SOC_DAPM_ENUM("Route", aic3x_enum[RHPCOM_ENUM]);
+SOC_DAPM_ENUM("Route", aic3x_right_hpcom_enum);
 
 /* Left Line Mixer */
 static const struct snd_kcontrol_new aic3x_left_line_mixer_controls[] = {
@@ -531,23 +538,23 @@ static const struct snd_kcontrol_new aic3x_right_pga_mixer_controls[] = {
 
 /* Left Line1 Mux */
 static const struct snd_kcontrol_new aic3x_left_line1l_mux_controls =
-SOC_DAPM_ENUM("Route", aic3x_enum[LINE1L_2_L_ENUM]);
+SOC_DAPM_ENUM("Route", aic3x_line1l_2_l_enum);
 static const struct snd_kcontrol_new aic3x_right_line1l_mux_controls =
-SOC_DAPM_ENUM("Route", aic3x_enum[LINE1L_2_R_ENUM]);
+SOC_DAPM_ENUM("Route", aic3x_line1l_2_r_enum);
 
 /* Right Line1 Mux */
 static const struct snd_kcontrol_new aic3x_right_line1r_mux_controls =
-SOC_DAPM_ENUM("Route", aic3x_enum[LINE1R_2_R_ENUM]);
+SOC_DAPM_ENUM("Route", aic3x_line1r_2_r_enum);
 static const struct snd_kcontrol_new aic3x_left_line1r_mux_controls =
-SOC_DAPM_ENUM("Route", aic3x_enum[LINE1R_2_L_ENUM]);
+SOC_DAPM_ENUM("Route", aic3x_line1r_2_l_enum);
 
 /* Left Line2 Mux */
 static const struct snd_kcontrol_new aic3x_left_line2_mux_controls =
-SOC_DAPM_ENUM("Route", aic3x_enum[LINE2L_ENUM]);
+SOC_DAPM_ENUM("Route", aic3x_line2l_2_ldac_enum);
 
 /* Right Line2 Mux */
 static const struct snd_kcontrol_new aic3x_right_line2_mux_controls =
-SOC_DAPM_ENUM("Route", aic3x_enum[LINE2R_ENUM]);
+SOC_DAPM_ENUM("Route", aic3x_line2r_2_rdac_enum);
 
 static const struct snd_soc_dapm_widget aic3x_dapm_widgets[] = {
 	/* Left DAC to Left Outputs */
-- 
2.1.3
