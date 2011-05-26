From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ASoC: tlv320aic3x: Add correct hw registers to
	Line1 cross connect muxes
Date: Thu, 26 May 2011 11:37:02 +0300
Message-ID: <1306399022-4490-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A0A4910380A
	for <alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 10:36:51 +0200 (CEST)
Received: by ewy6 with SMTP id 6so188239ewy.38
	for <alsa-devel@alsa-project.org>; Thu, 26 May 2011 01:36:51 -0700 (PDT)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Commit af46800 ("ASoC: Implement mux control sharing") revealed that
"Left Line1[L | R] Mux" and "Right Line1[L | R] Mux" widgets were pointing
to the same kcontrols and codec registers and thus soc-core falsely detected
them as shared controls. This is actually wrong since there are separate
registers in hardware that configure Line1L to RADC and Line1R to LADC cross
connects so these muxes should not be shared.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.c |   34 +++++++++++++++++++++-------------
 1 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 789453d..0963c4c 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -226,11 +226,13 @@ static const char *aic3x_adc_hpf[] =
 #define RDAC_ENUM	1
 #define LHPCOM_ENUM	2
 #define RHPCOM_ENUM	3
-#define LINE1L_ENUM	4
-#define LINE1R_ENUM	5
-#define LINE2L_ENUM	6
-#define LINE2R_ENUM	7
-#define ADC_HPF_ENUM	8
+#define LINE1L_2_L_ENUM	4
+#define LINE1L_2_R_ENUM	5
+#define LINE1R_2_L_ENUM	6
+#define LINE1R_2_R_ENUM	7
+#define LINE2L_ENUM	8
+#define LINE2R_ENUM	9
+#define ADC_HPF_ENUM	10
 
 static const struct soc_enum aic3x_enum[] = {
 	SOC_ENUM_SINGLE(DAC_LINE_MUX, 6, 3, aic3x_left_dac_mux),
@@ -238,6 +240,8 @@ static const struct soc_enum aic3x_enum[] = {
 	SOC_ENUM_SINGLE(HPLCOM_CFG, 4, 3, aic3x_left_hpcom_mux),
 	SOC_ENUM_SINGLE(HPRCOM_CFG, 3, 5, aic3x_right_hpcom_mux),
 	SOC_ENUM_SINGLE(LINE1L_2_LADC_CTRL, 7, 2, aic3x_linein_mode_mux),
+	SOC_ENUM_SINGLE(LINE1L_2_RADC_CTRL, 7, 2, aic3x_linein_mode_mux),
+	SOC_ENUM_SINGLE(LINE1R_2_LADC_CTRL, 7, 2, aic3x_linein_mode_mux),
 	SOC_ENUM_SINGLE(LINE1R_2_RADC_CTRL, 7, 2, aic3x_linein_mode_mux),
 	SOC_ENUM_SINGLE(LINE2L_2_LADC_CTRL, 7, 2, aic3x_linein_mode_mux),
 	SOC_ENUM_SINGLE(LINE2R_2_RADC_CTRL, 7, 2, aic3x_linein_mode_mux),
@@ -490,12 +494,16 @@ static const struct snd_kcontrol_new aic3x_right_pga_mixer_controls[] = {
 };
 
 /* Left Line1 Mux */
-static const struct snd_kcontrol_new aic3x_left_line1_mux_controls =
-SOC_DAPM_ENUM("Route", aic3x_enum[LINE1L_ENUM]);
+static const struct snd_kcontrol_new aic3x_left_line1l_mux_controls =
+SOC_DAPM_ENUM("Route", aic3x_enum[LINE1L_2_L_ENUM]);
+static const struct snd_kcontrol_new aic3x_right_line1l_mux_controls =
+SOC_DAPM_ENUM("Route", aic3x_enum[LINE1L_2_R_ENUM]);
 
 /* Right Line1 Mux */
-static const struct snd_kcontrol_new aic3x_right_line1_mux_controls =
-SOC_DAPM_ENUM("Route", aic3x_enum[LINE1R_ENUM]);
+static const struct snd_kcontrol_new aic3x_right_line1r_mux_controls =
+SOC_DAPM_ENUM("Route", aic3x_enum[LINE1R_2_R_ENUM]);
+static const struct snd_kcontrol_new aic3x_left_line1r_mux_controls =
+SOC_DAPM_ENUM("Route", aic3x_enum[LINE1R_2_L_ENUM]);
 
 /* Left Line2 Mux */
 static const struct snd_kcontrol_new aic3x_left_line2_mux_controls =
@@ -535,9 +543,9 @@ static const struct snd_soc_dapm_widget aic3x_dapm_widgets[] = {
 			   &aic3x_left_pga_mixer_controls[0],
 			   ARRAY_SIZE(aic3x_left_pga_mixer_controls)),
 	SND_SOC_DAPM_MUX("Left Line1L Mux", SND_SOC_NOPM, 0, 0,
-			 &aic3x_left_line1_mux_controls),
+			 &aic3x_left_line1l_mux_controls),
 	SND_SOC_DAPM_MUX("Left Line1R Mux", SND_SOC_NOPM, 0, 0,
-			 &aic3x_left_line1_mux_controls),
+			 &aic3x_left_line1r_mux_controls),
 	SND_SOC_DAPM_MUX("Left Line2L Mux", SND_SOC_NOPM, 0, 0,
 			 &aic3x_left_line2_mux_controls),
 
@@ -548,9 +556,9 @@ static const struct snd_soc_dapm_widget aic3x_dapm_widgets[] = {
 			   &aic3x_right_pga_mixer_controls[0],
 			   ARRAY_SIZE(aic3x_right_pga_mixer_controls)),
 	SND_SOC_DAPM_MUX("Right Line1L Mux", SND_SOC_NOPM, 0, 0,
-			 &aic3x_right_line1_mux_controls),
+			 &aic3x_right_line1l_mux_controls),
 	SND_SOC_DAPM_MUX("Right Line1R Mux", SND_SOC_NOPM, 0, 0,
-			 &aic3x_right_line1_mux_controls),
+			 &aic3x_right_line1r_mux_controls),
 	SND_SOC_DAPM_MUX("Right Line2R Mux", SND_SOC_NOPM, 0, 0,
 			 &aic3x_right_line2_mux_controls),
 
-- 
1.7.4.4
