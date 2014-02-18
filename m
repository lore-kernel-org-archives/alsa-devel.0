From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 068/102] ASoC: da732x: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:38:24 +0100
Message-ID: <1392723517-12772-41-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A80A12655DB
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:38:39 +0100 (CET)
In-Reply-To: <1392723517-12772-2-git-send-email-tiwai@suse.de>
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

Just replace with the helper macro.  No functional change at all.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/da732x.c | 160 +++++++++++++++++++++-------------------------
 1 file changed, 72 insertions(+), 88 deletions(-)

diff --git a/sound/soc/codecs/da732x.c b/sound/soc/codecs/da732x.c
index f295b6569910..3219fa1f3cf5 100644
--- a/sound/soc/codecs/da732x.c
+++ b/sound/soc/codecs/da732x.c
@@ -269,81 +269,65 @@ static const char *da732x_hpf_voice[] = {
 	"150Hz", "200Hz", "300Hz", "400Hz"
 };
 
-static const struct soc_enum da732x_dac1_hpf_mode_enum[] = {
-	SOC_ENUM_SINGLE(DA732X_REG_DAC1_HPF, DA732X_HPF_MODE_SHIFT,
-			DA732X_HPF_MODE_MAX, da732x_hpf_mode)
-};
-
-static const struct soc_enum da732x_dac2_hpf_mode_enum[] = {
-	SOC_ENUM_SINGLE(DA732X_REG_DAC2_HPF, DA732X_HPF_MODE_SHIFT,
-			DA732X_HPF_MODE_MAX, da732x_hpf_mode)
-};
+static SOC_ENUM_SINGLE_DECL(da732x_dac1_hpf_mode_enum,
+			    DA732X_REG_DAC1_HPF, DA732X_HPF_MODE_SHIFT,
+			    da732x_hpf_mode);
 
-static const struct soc_enum da732x_dac3_hpf_mode_enum[] = {
-	SOC_ENUM_SINGLE(DA732X_REG_DAC3_HPF, DA732X_HPF_MODE_SHIFT,
-			DA732X_HPF_MODE_MAX, da732x_hpf_mode)
-};
+static SOC_ENUM_SINGLE_DECL(da732x_dac2_hpf_mode_enum,
+			    DA732X_REG_DAC2_HPF, DA732X_HPF_MODE_SHIFT,
+			    da732x_hpf_mode);
 
-static const struct soc_enum da732x_adc1_hpf_mode_enum[] = {
-	SOC_ENUM_SINGLE(DA732X_REG_ADC1_HPF, DA732X_HPF_MODE_SHIFT,
-			DA732X_HPF_MODE_MAX, da732x_hpf_mode)
-};
+static SOC_ENUM_SINGLE_DECL(da732x_dac3_hpf_mode_enum,
+			    DA732X_REG_DAC3_HPF, DA732X_HPF_MODE_SHIFT,
+			    da732x_hpf_mode);
 
-static const struct soc_enum da732x_adc2_hpf_mode_enum[] = {
-	SOC_ENUM_SINGLE(DA732X_REG_ADC2_HPF, DA732X_HPF_MODE_SHIFT,
-			DA732X_HPF_MODE_MAX, da732x_hpf_mode)
-};
+static SOC_ENUM_SINGLE_DECL(da732x_adc1_hpf_mode_enum,
+			    DA732X_REG_ADC1_HPF, DA732X_HPF_MODE_SHIFT,
+			    da732x_hpf_mode);
 
-static const struct soc_enum da732x_dac1_hp_filter_enum[] = {
-	SOC_ENUM_SINGLE(DA732X_REG_DAC1_HPF, DA732X_HPF_MUSIC_SHIFT,
-			DA732X_HPF_MUSIC_MAX, da732x_hpf_music)
-};
+static SOC_ENUM_SINGLE_DECL(da732x_adc2_hpf_mode_enum,
+			    DA732X_REG_ADC2_HPF, DA732X_HPF_MODE_SHIFT,
+			    da732x_hpf_mode);
 
-static const struct soc_enum da732x_dac2_hp_filter_enum[] = {
-	SOC_ENUM_SINGLE(DA732X_REG_DAC2_HPF, DA732X_HPF_MUSIC_SHIFT,
-			DA732X_HPF_MUSIC_MAX, da732x_hpf_music)
-};
+static SOC_ENUM_SINGLE_DECL(da732x_dac1_hp_filter_enum,
+			    DA732X_REG_DAC1_HPF, DA732X_HPF_MUSIC_SHIFT,
+			    da732x_hpf_music);
 
-static const struct soc_enum da732x_dac3_hp_filter_enum[] = {
-	SOC_ENUM_SINGLE(DA732X_REG_DAC3_HPF, DA732X_HPF_MUSIC_SHIFT,
-			DA732X_HPF_MUSIC_MAX, da732x_hpf_music)
-};
+static SOC_ENUM_SINGLE_DECL(da732x_dac2_hp_filter_enum,
+			    DA732X_REG_DAC2_HPF, DA732X_HPF_MUSIC_SHIFT,
+			    da732x_hpf_music);
 
-static const struct soc_enum da732x_adc1_hp_filter_enum[] = {
-	SOC_ENUM_SINGLE(DA732X_REG_ADC1_HPF, DA732X_HPF_MUSIC_SHIFT,
-			DA732X_HPF_MUSIC_MAX, da732x_hpf_music)
-};
+static SOC_ENUM_SINGLE_DECL(da732x_dac3_hp_filter_enum,
+			    DA732X_REG_DAC3_HPF, DA732X_HPF_MUSIC_SHIFT,
+			    da732x_hpf_music);
 
-static const struct soc_enum da732x_adc2_hp_filter_enum[] = {
-	SOC_ENUM_SINGLE(DA732X_REG_ADC2_HPF, DA732X_HPF_MUSIC_SHIFT,
-			DA732X_HPF_MUSIC_MAX, da732x_hpf_music)
-};
+static SOC_ENUM_SINGLE_DECL(da732x_adc1_hp_filter_enum,
+			    DA732X_REG_ADC1_HPF, DA732X_HPF_MUSIC_SHIFT,
+			    da732x_hpf_music);
 
-static const struct soc_enum da732x_dac1_voice_filter_enum[] = {
-	SOC_ENUM_SINGLE(DA732X_REG_DAC1_HPF, DA732X_HPF_VOICE_SHIFT,
-			DA732X_HPF_VOICE_MAX, da732x_hpf_voice)
-};
+static SOC_ENUM_SINGLE_DECL(da732x_adc2_hp_filter_enum,
+			    DA732X_REG_ADC2_HPF, DA732X_HPF_MUSIC_SHIFT,
+			    da732x_hpf_music);
 
-static const struct soc_enum da732x_dac2_voice_filter_enum[] = {
-	SOC_ENUM_SINGLE(DA732X_REG_DAC2_HPF, DA732X_HPF_VOICE_SHIFT,
-			DA732X_HPF_VOICE_MAX, da732x_hpf_voice)
-};
+static SOC_ENUM_SINGLE_DECL(da732x_dac1_voice_filter_enum,
+			    DA732X_REG_DAC1_HPF, DA732X_HPF_VOICE_SHIFT,
+			    da732x_hpf_voice);
 
-static const struct soc_enum da732x_dac3_voice_filter_enum[] = {
-	SOC_ENUM_SINGLE(DA732X_REG_DAC3_HPF, DA732X_HPF_VOICE_SHIFT,
-			DA732X_HPF_VOICE_MAX, da732x_hpf_voice)
-};
+static SOC_ENUM_SINGLE_DECL(da732x_dac2_voice_filter_enum,
+			    DA732X_REG_DAC2_HPF, DA732X_HPF_VOICE_SHIFT,
+			    da732x_hpf_voice);
 
-static const struct soc_enum da732x_adc1_voice_filter_enum[] = {
-	SOC_ENUM_SINGLE(DA732X_REG_ADC1_HPF, DA732X_HPF_VOICE_SHIFT,
-			DA732X_HPF_VOICE_MAX, da732x_hpf_voice)
-};
+static SOC_ENUM_SINGLE_DECL(da732x_dac3_voice_filter_enum,
+			    DA732X_REG_DAC3_HPF, DA732X_HPF_VOICE_SHIFT,
+			    da732x_hpf_voice);
 
-static const struct soc_enum da732x_adc2_voice_filter_enum[] = {
-	SOC_ENUM_SINGLE(DA732X_REG_ADC2_HPF, DA732X_HPF_VOICE_SHIFT,
-			DA732X_HPF_VOICE_MAX, da732x_hpf_voice)
-};
+static SOC_ENUM_SINGLE_DECL(da732x_adc1_voice_filter_enum,
+			    DA732X_REG_ADC1_HPF, DA732X_HPF_VOICE_SHIFT,
+			    da732x_hpf_voice);
 
+static SOC_ENUM_SINGLE_DECL(da732x_adc2_voice_filter_enum,
+			    DA732X_REG_ADC2_HPF, DA732X_HPF_VOICE_SHIFT,
+			    da732x_hpf_voice);
 
 static int da732x_hpf_set(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
@@ -714,65 +698,65 @@ static const char *enable_text[] = {
 };
 
 /* ADC1LMUX */
-static const struct soc_enum adc1l_enum =
-	SOC_ENUM_SINGLE(DA732X_REG_INP_MUX, DA732X_ADC1L_MUX_SEL_SHIFT,
-			DA732X_ADCL_MUX_MAX, adcl_text);
+static SOC_ENUM_SINGLE_DECL(adc1l_enum,
+			    DA732X_REG_INP_MUX, DA732X_ADC1L_MUX_SEL_SHIFT,
+			    adcl_text);
 static const struct snd_kcontrol_new adc1l_mux =
 	SOC_DAPM_ENUM("ADC Route", adc1l_enum);
 
 /* ADC1RMUX */
-static const struct soc_enum adc1r_enum =
-	SOC_ENUM_SINGLE(DA732X_REG_INP_MUX, DA732X_ADC1R_MUX_SEL_SHIFT,
-			DA732X_ADCR_MUX_MAX, adcr_text);
+static SOC_ENUM_SINGLE_DECL(adc1r_enum,
+			    DA732X_REG_INP_MUX, DA732X_ADC1R_MUX_SEL_SHIFT,
+			    adcr_text);
 static const struct snd_kcontrol_new adc1r_mux =
 	SOC_DAPM_ENUM("ADC Route", adc1r_enum);
 
 /* ADC2LMUX */
-static const struct soc_enum adc2l_enum =
-	SOC_ENUM_SINGLE(DA732X_REG_INP_MUX, DA732X_ADC2L_MUX_SEL_SHIFT,
-			DA732X_ADCL_MUX_MAX, adcl_text);
+static SOC_ENUM_SINGLE_DECL(adc2l_enum,
+			    DA732X_REG_INP_MUX, DA732X_ADC2L_MUX_SEL_SHIFT,
+			    adcl_text);
 static const struct snd_kcontrol_new adc2l_mux =
 	SOC_DAPM_ENUM("ADC Route", adc2l_enum);
 
 /* ADC2RMUX */
-static const struct soc_enum adc2r_enum =
-	SOC_ENUM_SINGLE(DA732X_REG_INP_MUX, DA732X_ADC2R_MUX_SEL_SHIFT,
-			DA732X_ADCR_MUX_MAX, adcr_text);
+static SOC_ENUM_SINGLE_DECL(adc2r_enum,
+			    DA732X_REG_INP_MUX, DA732X_ADC2R_MUX_SEL_SHIFT,
+			    adcr_text);
 
 static const struct snd_kcontrol_new adc2r_mux =
 	SOC_DAPM_ENUM("ADC Route", adc2r_enum);
 
-static const struct soc_enum da732x_hp_left_output =
-	SOC_ENUM_SINGLE(DA732X_REG_HPL, DA732X_HP_OUT_DAC_EN_SHIFT,
-			DA732X_DAC_EN_MAX, enable_text);
+static SOC_ENUM_SINGLE_DECL(da732x_hp_left_output,
+			    DA732X_REG_HPL, DA732X_HP_OUT_DAC_EN_SHIFT,
+			    enable_text);
 
 static const struct snd_kcontrol_new hpl_mux =
 	SOC_DAPM_ENUM("HPL Switch", da732x_hp_left_output);
 
-static const struct soc_enum da732x_hp_right_output =
-	SOC_ENUM_SINGLE(DA732X_REG_HPR, DA732X_HP_OUT_DAC_EN_SHIFT,
-			DA732X_DAC_EN_MAX, enable_text);
+static SOC_ENUM_SINGLE_DECL(da732x_hp_right_output,
+			    DA732X_REG_HPR, DA732X_HP_OUT_DAC_EN_SHIFT,
+			    enable_text);
 
 static const struct snd_kcontrol_new hpr_mux =
 	SOC_DAPM_ENUM("HPR Switch", da732x_hp_right_output);
 
-static const struct soc_enum da732x_speaker_output =
-	SOC_ENUM_SINGLE(DA732X_REG_LIN3, DA732X_LOUT_DAC_EN_SHIFT,
-			DA732X_DAC_EN_MAX, enable_text);
+static SOC_ENUM_SINGLE_DECL(da732x_speaker_output,
+			    DA732X_REG_LIN3, DA732X_LOUT_DAC_EN_SHIFT,
+			    enable_text);
 
 static const struct snd_kcontrol_new spk_mux =
 	SOC_DAPM_ENUM("SPK Switch", da732x_speaker_output);
 
-static const struct soc_enum da732x_lout4_output =
-	SOC_ENUM_SINGLE(DA732X_REG_LIN4, DA732X_LOUT_DAC_EN_SHIFT,
-			DA732X_DAC_EN_MAX, enable_text);
+static SOC_ENUM_SINGLE_DECL(da732x_lout4_output,
+			    DA732X_REG_LIN4, DA732X_LOUT_DAC_EN_SHIFT,
+			    enable_text);
 
 static const struct snd_kcontrol_new lout4_mux =
 	SOC_DAPM_ENUM("LOUT4 Switch", da732x_lout4_output);
 
-static const struct soc_enum da732x_lout2_output =
-	SOC_ENUM_SINGLE(DA732X_REG_LIN2, DA732X_LOUT_DAC_EN_SHIFT,
-			DA732X_DAC_EN_MAX, enable_text);
+static SOC_ENUM_SINGLE_DECL(da732x_lout2_output,
+			    DA732X_REG_LIN2, DA732X_LOUT_DAC_EN_SHIFT,
+			    enable_text);
 
 static const struct snd_kcontrol_new lout2_mux =
 	SOC_DAPM_ENUM("LOUT2 Switch", da732x_lout2_output);
-- 
1.8.5.2
