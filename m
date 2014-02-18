From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 033/102] ASoC: da7213: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:37:49 +0100
Message-ID: <1392723517-12772-6-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 49D5E2655BA
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
 sound/soc/codecs/da7213.c | 151 ++++++++++++++++++++++++----------------------
 1 file changed, 80 insertions(+), 71 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 0c77e7ad7423..439d10387f10 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -63,30 +63,30 @@ static const char * const da7213_voice_hpf_corner_txt[] = {
 	"2.5Hz", "25Hz", "50Hz", "100Hz", "150Hz", "200Hz", "300Hz", "400Hz"
 };
 
-static const struct soc_enum da7213_dac_voice_hpf_corner =
-	SOC_ENUM_SINGLE(DA7213_DAC_FILTERS1, DA7213_VOICE_HPF_CORNER_SHIFT,
-			DA7213_VOICE_HPF_CORNER_MAX,
-			da7213_voice_hpf_corner_txt);
+static SOC_ENUM_SINGLE_DECL(da7213_dac_voice_hpf_corner,
+			    DA7213_DAC_FILTERS1,
+			    DA7213_VOICE_HPF_CORNER_SHIFT,
+			    da7213_voice_hpf_corner_txt);
 
-static const struct soc_enum da7213_adc_voice_hpf_corner =
-	SOC_ENUM_SINGLE(DA7213_ADC_FILTERS1, DA7213_VOICE_HPF_CORNER_SHIFT,
-			DA7213_VOICE_HPF_CORNER_MAX,
-			da7213_voice_hpf_corner_txt);
+static SOC_ENUM_SINGLE_DECL(da7213_adc_voice_hpf_corner,
+			    DA7213_ADC_FILTERS1,
+			    DA7213_VOICE_HPF_CORNER_SHIFT,
+			    da7213_voice_hpf_corner_txt);
 
 /* ADC and DAC high pass filter cutoff value */
 static const char * const da7213_audio_hpf_corner_txt[] = {
 	"Fs/24000", "Fs/12000", "Fs/6000", "Fs/3000"
 };
 
-static const struct soc_enum da7213_dac_audio_hpf_corner =
-	SOC_ENUM_SINGLE(DA7213_DAC_FILTERS1, DA7213_AUDIO_HPF_CORNER_SHIFT,
-			DA7213_AUDIO_HPF_CORNER_MAX,
-			da7213_audio_hpf_corner_txt);
+static SOC_ENUM_SINGLE_DECL(da7213_dac_audio_hpf_corner,
+			    DA7213_DAC_FILTERS1
+			    , DA7213_AUDIO_HPF_CORNER_SHIFT,
+			    da7213_audio_hpf_corner_txt);
 
-static const struct soc_enum da7213_adc_audio_hpf_corner =
-	SOC_ENUM_SINGLE(DA7213_ADC_FILTERS1, DA7213_AUDIO_HPF_CORNER_SHIFT,
-			DA7213_AUDIO_HPF_CORNER_MAX,
-			da7213_audio_hpf_corner_txt);
+static SOC_ENUM_SINGLE_DECL(da7213_adc_audio_hpf_corner,
+			    DA7213_ADC_FILTERS1,
+			    DA7213_AUDIO_HPF_CORNER_SHIFT,
+			    da7213_audio_hpf_corner_txt);
 
 /* Gain ramping rate value */
 static const char * const da7213_gain_ramp_rate_txt[] = {
@@ -94,52 +94,50 @@ static const char * const da7213_gain_ramp_rate_txt[] = {
 	"nominal rate / 32"
 };
 
-static const struct soc_enum da7213_gain_ramp_rate =
-	SOC_ENUM_SINGLE(DA7213_GAIN_RAMP_CTRL, DA7213_GAIN_RAMP_RATE_SHIFT,
-			DA7213_GAIN_RAMP_RATE_MAX, da7213_gain_ramp_rate_txt);
+static SOC_ENUM_SINGLE_DECL(da7213_gain_ramp_rate,
+			    DA7213_GAIN_RAMP_CTRL,
+			    DA7213_GAIN_RAMP_RATE_SHIFT,
+			    da7213_gain_ramp_rate_txt);
 
 /* DAC noise gate setup time value */
 static const char * const da7213_dac_ng_setup_time_txt[] = {
 	"256 samples", "512 samples", "1024 samples", "2048 samples"
 };
 
-static const struct soc_enum da7213_dac_ng_setup_time =
-	SOC_ENUM_SINGLE(DA7213_DAC_NG_SETUP_TIME,
-			DA7213_DAC_NG_SETUP_TIME_SHIFT,
-			DA7213_DAC_NG_SETUP_TIME_MAX,
-			da7213_dac_ng_setup_time_txt);
+static SOC_ENUM_SINGLE_DECL(da7213_dac_ng_setup_time,
+			    DA7213_DAC_NG_SETUP_TIME,
+			    DA7213_DAC_NG_SETUP_TIME_SHIFT,
+			    da7213_dac_ng_setup_time_txt);
 
 /* DAC noise gate rampup rate value */
 static const char * const da7213_dac_ng_rampup_txt[] = {
 	"0.02 ms/dB", "0.16 ms/dB"
 };
 
-static const struct soc_enum da7213_dac_ng_rampup_rate =
-	SOC_ENUM_SINGLE(DA7213_DAC_NG_SETUP_TIME,
-			DA7213_DAC_NG_RAMPUP_RATE_SHIFT,
-			DA7213_DAC_NG_RAMP_RATE_MAX,
-			da7213_dac_ng_rampup_txt);
+static SOC_ENUM_SINGLE_DECL(da7213_dac_ng_rampup_rate,
+			    DA7213_DAC_NG_SETUP_TIME,
+			    DA7213_DAC_NG_RAMPUP_RATE_SHIFT,
+			    da7213_dac_ng_rampup_txt);
 
 /* DAC noise gate rampdown rate value */
 static const char * const da7213_dac_ng_rampdown_txt[] = {
 	"0.64 ms/dB", "20.48 ms/dB"
 };
 
-static const struct soc_enum da7213_dac_ng_rampdown_rate =
-	SOC_ENUM_SINGLE(DA7213_DAC_NG_SETUP_TIME,
-			DA7213_DAC_NG_RAMPDN_RATE_SHIFT,
-			DA7213_DAC_NG_RAMP_RATE_MAX,
-			da7213_dac_ng_rampdown_txt);
+static SOC_ENUM_SINGLE_DECL(da7213_dac_ng_rampdown_rate,
+			    DA7213_DAC_NG_SETUP_TIME,
+			    DA7213_DAC_NG_RAMPDN_RATE_SHIFT,
+			    da7213_dac_ng_rampdown_txt);
 
 /* DAC soft mute rate value */
 static const char * const da7213_dac_soft_mute_rate_txt[] = {
 	"1", "2", "4", "8", "16", "32", "64"
 };
 
-static const struct soc_enum da7213_dac_soft_mute_rate =
-	SOC_ENUM_SINGLE(DA7213_DAC_FILTERS5, DA7213_DAC_SOFTMUTE_RATE_SHIFT,
-			DA7213_DAC_SOFTMUTE_RATE_MAX,
-			da7213_dac_soft_mute_rate_txt);
+static SOC_ENUM_SINGLE_DECL(da7213_dac_soft_mute_rate,
+			    DA7213_DAC_FILTERS5,
+			    DA7213_DAC_SOFTMUTE_RATE_SHIFT,
+			    da7213_dac_soft_mute_rate_txt);
 
 /* ALC Attack Rate select */
 static const char * const da7213_alc_attack_rate_txt[] = {
@@ -147,9 +145,10 @@ static const char * const da7213_alc_attack_rate_txt[] = {
 	"5632/fs", "11264/fs", "22528/fs", "45056/fs", "90112/fs", "180224/fs"
 };
 
-static const struct soc_enum da7213_alc_attack_rate =
-	SOC_ENUM_SINGLE(DA7213_ALC_CTRL2, DA7213_ALC_ATTACK_SHIFT,
-			DA7213_ALC_ATTACK_MAX, da7213_alc_attack_rate_txt);
+static SOC_ENUM_SINGLE_DECL(da7213_alc_attack_rate,
+			    DA7213_ALC_CTRL2,
+			    DA7213_ALC_ATTACK_SHIFT,
+			    da7213_alc_attack_rate_txt);
 
 /* ALC Release Rate select */
 static const char * const da7213_alc_release_rate_txt[] = {
@@ -157,9 +156,10 @@ static const char * const da7213_alc_release_rate_txt[] = {
 	"11264/fs", "22528/fs", "45056/fs", "90112/fs", "180224/fs"
 };
 
-static const struct soc_enum da7213_alc_release_rate =
-	SOC_ENUM_SINGLE(DA7213_ALC_CTRL2, DA7213_ALC_RELEASE_SHIFT,
-			DA7213_ALC_RELEASE_MAX, da7213_alc_release_rate_txt);
+static SOC_ENUM_SINGLE_DECL(da7213_alc_release_rate,
+			    DA7213_ALC_CTRL2,
+			    DA7213_ALC_RELEASE_SHIFT,
+			    da7213_alc_release_rate_txt);
 
 /* ALC Hold Time select */
 static const char * const da7213_alc_hold_time_txt[] = {
@@ -168,22 +168,25 @@ static const char * const da7213_alc_hold_time_txt[] = {
 	"253952/fs", "507904/fs", "1015808/fs", "2031616/fs"
 };
 
-static const struct soc_enum da7213_alc_hold_time =
-	SOC_ENUM_SINGLE(DA7213_ALC_CTRL3, DA7213_ALC_HOLD_SHIFT,
-			DA7213_ALC_HOLD_MAX, da7213_alc_hold_time_txt);
+static SOC_ENUM_SINGLE_DECL(da7213_alc_hold_time,
+			    DA7213_ALC_CTRL3,
+			    DA7213_ALC_HOLD_SHIFT,
+			    da7213_alc_hold_time_txt);
 
 /* ALC Input Signal Tracking rate select */
 static const char * const da7213_alc_integ_rate_txt[] = {
 	"1/4", "1/16", "1/256", "1/65536"
 };
 
-static const struct soc_enum da7213_alc_integ_attack_rate =
-	SOC_ENUM_SINGLE(DA7213_ALC_CTRL3, DA7213_ALC_INTEG_ATTACK_SHIFT,
-			DA7213_ALC_INTEG_MAX, da7213_alc_integ_rate_txt);
+static SOC_ENUM_SINGLE_DECL(da7213_alc_integ_attack_rate,
+			    DA7213_ALC_CTRL3,
+			    DA7213_ALC_INTEG_ATTACK_SHIFT,
+			    da7213_alc_integ_rate_txt);
 
-static const struct soc_enum da7213_alc_integ_release_rate =
-	SOC_ENUM_SINGLE(DA7213_ALC_CTRL3, DA7213_ALC_INTEG_RELEASE_SHIFT,
-			DA7213_ALC_INTEG_MAX, da7213_alc_integ_rate_txt);
+static SOC_ENUM_SINGLE_DECL(da7213_alc_integ_release_rate,
+			    DA7213_ALC_CTRL3,
+			    DA7213_ALC_INTEG_RELEASE_SHIFT,
+			    da7213_alc_integ_rate_txt);
 
 
 /*
@@ -584,15 +587,17 @@ static const char * const da7213_mic_amp_in_sel_txt[] = {
 	"Differential", "MIC_P", "MIC_N"
 };
 
-static const struct soc_enum da7213_mic_1_amp_in_sel =
-	SOC_ENUM_SINGLE(DA7213_MIC_1_CTRL, DA7213_MIC_AMP_IN_SEL_SHIFT,
-			DA7213_MIC_AMP_IN_SEL_MAX, da7213_mic_amp_in_sel_txt);
+static SOC_ENUM_SINGLE_DECL(da7213_mic_1_amp_in_sel,
+			    DA7213_MIC_1_CTRL,
+			    DA7213_MIC_AMP_IN_SEL_SHIFT,
+			    da7213_mic_amp_in_sel_txt);
 static const struct snd_kcontrol_new da7213_mic_1_amp_in_sel_mux =
 	SOC_DAPM_ENUM("Mic 1 Amp Source MUX", da7213_mic_1_amp_in_sel);
 
-static const struct soc_enum da7213_mic_2_amp_in_sel =
-	SOC_ENUM_SINGLE(DA7213_MIC_2_CTRL, DA7213_MIC_AMP_IN_SEL_SHIFT,
-			DA7213_MIC_AMP_IN_SEL_MAX, da7213_mic_amp_in_sel_txt);
+static SOC_ENUM_SINGLE_DECL(da7213_mic_2_amp_in_sel,
+			    DA7213_MIC_2_CTRL,
+			    DA7213_MIC_AMP_IN_SEL_SHIFT,
+			    da7213_mic_amp_in_sel_txt);
 static const struct snd_kcontrol_new da7213_mic_2_amp_in_sel_mux =
 	SOC_DAPM_ENUM("Mic 2 Amp Source MUX", da7213_mic_2_amp_in_sel);
 
@@ -601,15 +606,17 @@ static const char * const da7213_dai_src_txt[] = {
 	"ADC Left", "ADC Right", "DAI Input Left", "DAI Input Right"
 };
 
-static const struct soc_enum da7213_dai_l_src =
-	SOC_ENUM_SINGLE(DA7213_DIG_ROUTING_DAI, DA7213_DAI_L_SRC_SHIFT,
-			DA7213_DAI_SRC_MAX, da7213_dai_src_txt);
+static SOC_ENUM_SINGLE_DECL(da7213_dai_l_src,
+			    DA7213_DIG_ROUTING_DAI,
+			    DA7213_DAI_L_SRC_SHIFT,
+			    da7213_dai_src_txt);
 static const struct snd_kcontrol_new da7213_dai_l_src_mux =
 	SOC_DAPM_ENUM("DAI Left Source MUX", da7213_dai_l_src);
 
-static const struct soc_enum da7213_dai_r_src =
-	SOC_ENUM_SINGLE(DA7213_DIG_ROUTING_DAI, DA7213_DAI_R_SRC_SHIFT,
-			DA7213_DAI_SRC_MAX, da7213_dai_src_txt);
+static SOC_ENUM_SINGLE_DECL(da7213_dai_r_src,
+			    DA7213_DIG_ROUTING_DAI,
+			    DA7213_DAI_R_SRC_SHIFT,
+			    da7213_dai_src_txt);
 static const struct snd_kcontrol_new da7213_dai_r_src_mux =
 	SOC_DAPM_ENUM("DAI Right Source MUX", da7213_dai_r_src);
 
@@ -619,15 +626,17 @@ static const char * const da7213_dac_src_txt[] = {
 	"DAI Input Right"
 };
 
-static const struct soc_enum da7213_dac_l_src =
-	SOC_ENUM_SINGLE(DA7213_DIG_ROUTING_DAC, DA7213_DAC_L_SRC_SHIFT,
-			DA7213_DAC_SRC_MAX, da7213_dac_src_txt);
+static SOC_ENUM_SINGLE_DECL(da7213_dac_l_src,
+			    DA7213_DIG_ROUTING_DAC,
+			    DA7213_DAC_L_SRC_SHIFT,
+			    da7213_dac_src_txt);
 static const struct snd_kcontrol_new da7213_dac_l_src_mux =
 	SOC_DAPM_ENUM("DAC Left Source MUX", da7213_dac_l_src);
 
-static const struct soc_enum da7213_dac_r_src =
-	SOC_ENUM_SINGLE(DA7213_DIG_ROUTING_DAC, DA7213_DAC_R_SRC_SHIFT,
-			DA7213_DAC_SRC_MAX, da7213_dac_src_txt);
+static SOC_ENUM_SINGLE_DECL(da7213_dac_r_src,
+			    DA7213_DIG_ROUTING_DAC,
+			    DA7213_DAC_R_SRC_SHIFT,
+			    da7213_dac_src_txt);
 static const struct snd_kcontrol_new da7213_dac_r_src_mux =
 	SOC_DAPM_ENUM("DAC Right Source MUX", da7213_dac_r_src);
 
-- 
1.8.5.2
