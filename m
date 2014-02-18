From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 008/102] ASoC: rt5631: Remove superfluous const
Date: Tue, 18 Feb 2014 12:32:20 +0100
Message-ID: <1392723148-12597-6-git-send-email-tiwai@suse.de>
References: <1392723148-12597-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F69B26533D
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:32:33 +0100 (CET)
In-Reply-To: <1392723148-12597-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

As SOC_ENUM_SINGLE_DECL() itself contains const modifier now, we can
reduce const from its users.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/rt5631.c | 75 +++++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 45 deletions(-)

diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
index 912c9cbc2724..ce199d375209 100644
--- a/sound/soc/codecs/rt5631.c
+++ b/sound/soc/codecs/rt5631.c
@@ -210,26 +210,22 @@ static int rt5631_dmic_put(struct snd_kcontrol *kcontrol,
 static const char *rt5631_input_mode[] = {
 	"Single ended", "Differential"};
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5631_mic1_mode_enum, RT5631_MIC_CTRL_1,
-	RT5631_MIC1_DIFF_INPUT_SHIFT, rt5631_input_mode);
+static SOC_ENUM_SINGLE_DECL(rt5631_mic1_mode_enum, RT5631_MIC_CTRL_1,
+			    RT5631_MIC1_DIFF_INPUT_SHIFT, rt5631_input_mode);
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5631_mic2_mode_enum, RT5631_MIC_CTRL_1,
-	RT5631_MIC2_DIFF_INPUT_SHIFT, rt5631_input_mode);
+static SOC_ENUM_SINGLE_DECL(rt5631_mic2_mode_enum, RT5631_MIC_CTRL_1,
+			    RT5631_MIC2_DIFF_INPUT_SHIFT, rt5631_input_mode);
 
 /* MONO Input Type */
-static const SOC_ENUM_SINGLE_DECL(
-	rt5631_monoin_mode_enum, RT5631_MONO_INPUT_VOL,
-	RT5631_MONO_DIFF_INPUT_SHIFT, rt5631_input_mode);
+static SOC_ENUM_SINGLE_DECL(rt5631_monoin_mode_enum, RT5631_MONO_INPUT_VOL,
+			    RT5631_MONO_DIFF_INPUT_SHIFT, rt5631_input_mode);
 
 /* SPK Ratio Gain Control */
 static const char *rt5631_spk_ratio[] = {"1.00x", "1.09x", "1.27x", "1.44x",
 			"1.56x", "1.68x", "1.99x", "2.34x"};
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5631_spk_ratio_enum, RT5631_GEN_PUR_CTRL_REG,
-	RT5631_SPK_AMP_RATIO_CTRL_SHIFT, rt5631_spk_ratio);
+static SOC_ENUM_SINGLE_DECL(rt5631_spk_ratio_enum, RT5631_GEN_PUR_CTRL_REG,
+			    RT5631_SPK_AMP_RATIO_CTRL_SHIFT, rt5631_spk_ratio);
 
 static const struct snd_kcontrol_new rt5631_snd_controls[] = {
 	/* MIC */
@@ -759,9 +755,8 @@ static const struct snd_kcontrol_new rt5631_monomix_mixer_controls[] = {
 /* Left SPK Volume Input */
 static const char *rt5631_spkvoll_sel[] = {"Vmid", "SPKMIXL"};
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5631_spkvoll_enum, RT5631_SPK_OUT_VOL,
-	RT5631_L_EN_SHIFT, rt5631_spkvoll_sel);
+static SOC_ENUM_SINGLE_DECL(rt5631_spkvoll_enum, RT5631_SPK_OUT_VOL,
+			    RT5631_L_EN_SHIFT, rt5631_spkvoll_sel);
 
 static const struct snd_kcontrol_new rt5631_spkvoll_mux_control =
 	SOC_DAPM_ENUM("Left SPKVOL SRC", rt5631_spkvoll_enum);
@@ -769,9 +764,8 @@ static const struct snd_kcontrol_new rt5631_spkvoll_mux_control =
 /* Left HP Volume Input */
 static const char *rt5631_hpvoll_sel[] = {"Vmid", "OUTMIXL"};
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5631_hpvoll_enum, RT5631_HP_OUT_VOL,
-	RT5631_L_EN_SHIFT, rt5631_hpvoll_sel);
+static SOC_ENUM_SINGLE_DECL(rt5631_hpvoll_enum, RT5631_HP_OUT_VOL,
+			    RT5631_L_EN_SHIFT, rt5631_hpvoll_sel);
 
 static const struct snd_kcontrol_new rt5631_hpvoll_mux_control =
 	SOC_DAPM_ENUM("Left HPVOL SRC", rt5631_hpvoll_enum);
@@ -779,9 +773,8 @@ static const struct snd_kcontrol_new rt5631_hpvoll_mux_control =
 /* Left Out Volume Input */
 static const char *rt5631_outvoll_sel[] = {"Vmid", "OUTMIXL"};
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5631_outvoll_enum, RT5631_MONO_AXO_1_2_VOL,
-	RT5631_L_EN_SHIFT, rt5631_outvoll_sel);
+static SOC_ENUM_SINGLE_DECL(rt5631_outvoll_enum, RT5631_MONO_AXO_1_2_VOL,
+			    RT5631_L_EN_SHIFT, rt5631_outvoll_sel);
 
 static const struct snd_kcontrol_new rt5631_outvoll_mux_control =
 	SOC_DAPM_ENUM("Left OUTVOL SRC", rt5631_outvoll_enum);
@@ -789,9 +782,8 @@ static const struct snd_kcontrol_new rt5631_outvoll_mux_control =
 /* Right Out Volume Input */
 static const char *rt5631_outvolr_sel[] = {"Vmid", "OUTMIXR"};
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5631_outvolr_enum, RT5631_MONO_AXO_1_2_VOL,
-	RT5631_R_EN_SHIFT, rt5631_outvolr_sel);
+static SOC_ENUM_SINGLE_DECL(rt5631_outvolr_enum, RT5631_MONO_AXO_1_2_VOL,
+			    RT5631_R_EN_SHIFT, rt5631_outvolr_sel);
 
 static const struct snd_kcontrol_new rt5631_outvolr_mux_control =
 	SOC_DAPM_ENUM("Right OUTVOL SRC", rt5631_outvolr_enum);
@@ -799,9 +791,8 @@ static const struct snd_kcontrol_new rt5631_outvolr_mux_control =
 /* Right HP Volume Input */
 static const char *rt5631_hpvolr_sel[] = {"Vmid", "OUTMIXR"};
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5631_hpvolr_enum, RT5631_HP_OUT_VOL,
-	RT5631_R_EN_SHIFT, rt5631_hpvolr_sel);
+static SOC_ENUM_SINGLE_DECL(rt5631_hpvolr_enum, RT5631_HP_OUT_VOL,
+			    RT5631_R_EN_SHIFT, rt5631_hpvolr_sel);
 
 static const struct snd_kcontrol_new rt5631_hpvolr_mux_control =
 	SOC_DAPM_ENUM("Right HPVOL SRC", rt5631_hpvolr_enum);
@@ -809,9 +800,8 @@ static const struct snd_kcontrol_new rt5631_hpvolr_mux_control =
 /* Right SPK Volume Input */
 static const char *rt5631_spkvolr_sel[] = {"Vmid", "SPKMIXR"};
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5631_spkvolr_enum, RT5631_SPK_OUT_VOL,
-	RT5631_R_EN_SHIFT, rt5631_spkvolr_sel);
+static SOC_ENUM_SINGLE_DECL(rt5631_spkvolr_enum, RT5631_SPK_OUT_VOL,
+			    RT5631_R_EN_SHIFT, rt5631_spkvolr_sel);
 
 static const struct snd_kcontrol_new rt5631_spkvolr_mux_control =
 	SOC_DAPM_ENUM("Right SPKVOL SRC", rt5631_spkvolr_enum);
@@ -820,9 +810,8 @@ static const struct snd_kcontrol_new rt5631_spkvolr_mux_control =
 static const char *rt5631_spol_src_sel[] = {
 	"SPOLMIX", "MONOIN_RX", "VDAC", "DACL"};
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5631_spol_src_enum, RT5631_SPK_MONO_HP_OUT_CTRL,
-	RT5631_SPK_L_MUX_SEL_SHIFT, rt5631_spol_src_sel);
+static SOC_ENUM_SINGLE_DECL(rt5631_spol_src_enum, RT5631_SPK_MONO_HP_OUT_CTRL,
+			    RT5631_SPK_L_MUX_SEL_SHIFT, rt5631_spol_src_sel);
 
 static const struct snd_kcontrol_new rt5631_spol_mux_control =
 	SOC_DAPM_ENUM("SPOL SRC", rt5631_spol_src_enum);
@@ -831,9 +820,8 @@ static const struct snd_kcontrol_new rt5631_spol_mux_control =
 static const char *rt5631_spor_src_sel[] = {
 	"SPORMIX", "MONOIN_RX", "VDAC", "DACR"};
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5631_spor_src_enum, RT5631_SPK_MONO_HP_OUT_CTRL,
-	RT5631_SPK_R_MUX_SEL_SHIFT, rt5631_spor_src_sel);
+static SOC_ENUM_SINGLE_DECL(rt5631_spor_src_enum, RT5631_SPK_MONO_HP_OUT_CTRL,
+			    RT5631_SPK_R_MUX_SEL_SHIFT, rt5631_spor_src_sel);
 
 static const struct snd_kcontrol_new rt5631_spor_mux_control =
 	SOC_DAPM_ENUM("SPOR SRC", rt5631_spor_src_enum);
@@ -841,9 +829,8 @@ static const struct snd_kcontrol_new rt5631_spor_mux_control =
 /* MONO Input */
 static const char *rt5631_mono_src_sel[] = {"MONOMIX", "MONOIN_RX", "VDAC"};
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5631_mono_src_enum, RT5631_SPK_MONO_HP_OUT_CTRL,
-	RT5631_MONO_MUX_SEL_SHIFT, rt5631_mono_src_sel);
+static SOC_ENUM_SINGLE_DECL(rt5631_mono_src_enum, RT5631_SPK_MONO_HP_OUT_CTRL,
+			    RT5631_MONO_MUX_SEL_SHIFT, rt5631_mono_src_sel);
 
 static const struct snd_kcontrol_new rt5631_mono_mux_control =
 	SOC_DAPM_ENUM("MONO SRC", rt5631_mono_src_enum);
@@ -851,9 +838,8 @@ static const struct snd_kcontrol_new rt5631_mono_mux_control =
 /* Left HPO Input */
 static const char *rt5631_hpl_src_sel[] = {"Left HPVOL", "Left DAC"};
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5631_hpl_src_enum, RT5631_SPK_MONO_HP_OUT_CTRL,
-	RT5631_HP_L_MUX_SEL_SHIFT, rt5631_hpl_src_sel);
+static SOC_ENUM_SINGLE_DECL(rt5631_hpl_src_enum, RT5631_SPK_MONO_HP_OUT_CTRL,
+			    RT5631_HP_L_MUX_SEL_SHIFT, rt5631_hpl_src_sel);
 
 static const struct snd_kcontrol_new rt5631_hpl_mux_control =
 	SOC_DAPM_ENUM("HPL SRC", rt5631_hpl_src_enum);
@@ -861,9 +847,8 @@ static const struct snd_kcontrol_new rt5631_hpl_mux_control =
 /* Right HPO Input */
 static const char *rt5631_hpr_src_sel[] = {"Right HPVOL", "Right DAC"};
 
-static const SOC_ENUM_SINGLE_DECL(
-	rt5631_hpr_src_enum, RT5631_SPK_MONO_HP_OUT_CTRL,
-	RT5631_HP_R_MUX_SEL_SHIFT, rt5631_hpr_src_sel);
+static SOC_ENUM_SINGLE_DECL(rt5631_hpr_src_enum, RT5631_SPK_MONO_HP_OUT_CTRL,
+			    RT5631_HP_R_MUX_SEL_SHIFT, rt5631_hpr_src_sel);
 
 static const struct snd_kcontrol_new rt5631_hpr_mux_control =
 	SOC_DAPM_ENUM("HPR SRC", rt5631_hpr_src_enum);
-- 
1.8.5.2
