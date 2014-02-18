From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 034/102] ASoC: da9055: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:37:50 +0100
Message-ID: <1392723517-12772-7-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D1FC2655BC
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
 sound/soc/codecs/da9055.c | 84 +++++++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/sound/soc/codecs/da9055.c b/sound/soc/codecs/da9055.c
index be31f3cfd46e..f118daa91234 100644
--- a/sound/soc/codecs/da9055.c
+++ b/sound/soc/codecs/da9055.c
@@ -323,22 +323,22 @@ static const char * const da9055_hpf_cutoff_txt[] = {
 	"Fs/24000", "Fs/12000", "Fs/6000", "Fs/3000"
 };
 
-static const struct soc_enum da9055_dac_hpf_cutoff =
-	SOC_ENUM_SINGLE(DA9055_DAC_FILTERS1, 4, 4, da9055_hpf_cutoff_txt);
+static SOC_ENUM_SINGLE_DECL(da9055_dac_hpf_cutoff,
+			    DA9055_DAC_FILTERS1, 4, da9055_hpf_cutoff_txt);
 
-static const struct soc_enum da9055_adc_hpf_cutoff =
-	SOC_ENUM_SINGLE(DA9055_ADC_FILTERS1, 4, 4, da9055_hpf_cutoff_txt);
+static SOC_ENUM_SINGLE_DECL(da9055_adc_hpf_cutoff,
+			    DA9055_ADC_FILTERS1, 4, da9055_hpf_cutoff_txt);
 
 /* ADC and DAC voice mode (8kHz) high pass cutoff value */
 static const char * const da9055_vf_cutoff_txt[] = {
 	"2.5Hz", "25Hz", "50Hz", "100Hz", "150Hz", "200Hz", "300Hz", "400Hz"
 };
 
-static const struct soc_enum da9055_dac_vf_cutoff =
-	SOC_ENUM_SINGLE(DA9055_DAC_FILTERS1, 0, 8, da9055_vf_cutoff_txt);
+static SOC_ENUM_SINGLE_DECL(da9055_dac_vf_cutoff,
+			    DA9055_DAC_FILTERS1, 0, da9055_vf_cutoff_txt);
 
-static const struct soc_enum da9055_adc_vf_cutoff =
-	SOC_ENUM_SINGLE(DA9055_ADC_FILTERS1, 0, 8, da9055_vf_cutoff_txt);
+static SOC_ENUM_SINGLE_DECL(da9055_adc_vf_cutoff,
+			    DA9055_ADC_FILTERS1, 0, da9055_vf_cutoff_txt);
 
 /* Gain ramping rate value */
 static const char * const da9055_gain_ramping_txt[] = {
@@ -346,44 +346,44 @@ static const char * const da9055_gain_ramping_txt[] = {
 	"nominal rate / 8"
 };
 
-static const struct soc_enum da9055_gain_ramping_rate =
-	SOC_ENUM_SINGLE(DA9055_GAIN_RAMP_CTRL, 0, 4, da9055_gain_ramping_txt);
+static SOC_ENUM_SINGLE_DECL(da9055_gain_ramping_rate,
+			    DA9055_GAIN_RAMP_CTRL, 0, da9055_gain_ramping_txt);
 
 /* DAC noise gate setup time value */
 static const char * const da9055_dac_ng_setup_time_txt[] = {
 	"256 samples", "512 samples", "1024 samples", "2048 samples"
 };
 
-static const struct soc_enum da9055_dac_ng_setup_time =
-	SOC_ENUM_SINGLE(DA9055_DAC_NG_SETUP_TIME, 0, 4,
-			da9055_dac_ng_setup_time_txt);
+static SOC_ENUM_SINGLE_DECL(da9055_dac_ng_setup_time,
+			    DA9055_DAC_NG_SETUP_TIME, 0,
+			    da9055_dac_ng_setup_time_txt);
 
 /* DAC noise gate rampup rate value */
 static const char * const da9055_dac_ng_rampup_txt[] = {
 	"0.02 ms/dB", "0.16 ms/dB"
 };
 
-static const struct soc_enum da9055_dac_ng_rampup_rate =
-	SOC_ENUM_SINGLE(DA9055_DAC_NG_SETUP_TIME, 2, 2,
-			da9055_dac_ng_rampup_txt);
+static SOC_ENUM_SINGLE_DECL(da9055_dac_ng_rampup_rate,
+			    DA9055_DAC_NG_SETUP_TIME, 2,
+			    da9055_dac_ng_rampup_txt);
 
 /* DAC noise gate rampdown rate value */
 static const char * const da9055_dac_ng_rampdown_txt[] = {
 	"0.64 ms/dB", "20.48 ms/dB"
 };
 
-static const struct soc_enum da9055_dac_ng_rampdown_rate =
-	SOC_ENUM_SINGLE(DA9055_DAC_NG_SETUP_TIME, 3, 2,
-			da9055_dac_ng_rampdown_txt);
+static SOC_ENUM_SINGLE_DECL(da9055_dac_ng_rampdown_rate,
+			    DA9055_DAC_NG_SETUP_TIME, 3,
+			    da9055_dac_ng_rampdown_txt);
 
 /* DAC soft mute rate value */
 static const char * const da9055_dac_soft_mute_rate_txt[] = {
 	"1", "2", "4", "8", "16", "32", "64"
 };
 
-static const struct soc_enum da9055_dac_soft_mute_rate =
-	SOC_ENUM_SINGLE(DA9055_DAC_FILTERS5, 4, 7,
-			da9055_dac_soft_mute_rate_txt);
+static SOC_ENUM_SINGLE_DECL(da9055_dac_soft_mute_rate,
+			    DA9055_DAC_FILTERS5, 4,
+			    da9055_dac_soft_mute_rate_txt);
 
 /* DAC routing select */
 static const char * const da9055_dac_src_txt[] = {
@@ -391,40 +391,40 @@ static const char * const da9055_dac_src_txt[] = {
 	"AIF input right"
 };
 
-static const struct soc_enum da9055_dac_l_src =
-	SOC_ENUM_SINGLE(DA9055_DIG_ROUTING_DAC, 0, 4, da9055_dac_src_txt);
+static SOC_ENUM_SINGLE_DECL(da9055_dac_l_src,
+			    DA9055_DIG_ROUTING_DAC, 0, da9055_dac_src_txt);
 
-static const struct soc_enum da9055_dac_r_src =
-	SOC_ENUM_SINGLE(DA9055_DIG_ROUTING_DAC, 4, 4, da9055_dac_src_txt);
+static SOC_ENUM_SINGLE_DECL(da9055_dac_r_src,
+			    DA9055_DIG_ROUTING_DAC, 4, da9055_dac_src_txt);
 
 /* MIC PGA Left source select */
 static const char * const da9055_mic_l_src_txt[] = {
 	"MIC1_P_N", "MIC1_P", "MIC1_N", "MIC2_L"
 };
 
-static const struct soc_enum da9055_mic_l_src =
-	SOC_ENUM_SINGLE(DA9055_MIXIN_L_SELECT, 4, 4, da9055_mic_l_src_txt);
+static SOC_ENUM_SINGLE_DECL(da9055_mic_l_src,
+			    DA9055_MIXIN_L_SELECT, 4, da9055_mic_l_src_txt);
 
 /* MIC PGA Right source select */
 static const char * const da9055_mic_r_src_txt[] = {
 	"MIC2_R_L", "MIC2_R", "MIC2_L"
 };
 
-static const struct soc_enum da9055_mic_r_src =
-	SOC_ENUM_SINGLE(DA9055_MIXIN_R_SELECT, 4, 3, da9055_mic_r_src_txt);
+static SOC_ENUM_SINGLE_DECL(da9055_mic_r_src,
+			    DA9055_MIXIN_R_SELECT, 4, da9055_mic_r_src_txt);
 
 /* ALC Input Signal Tracking rate select */
 static const char * const da9055_signal_tracking_rate_txt[] = {
 	"1/4", "1/16", "1/256", "1/65536"
 };
 
-static const struct soc_enum da9055_integ_attack_rate =
-	SOC_ENUM_SINGLE(DA9055_ALC_CTRL3, 4, 4,
-			da9055_signal_tracking_rate_txt);
+static SOC_ENUM_SINGLE_DECL(da9055_integ_attack_rate,
+			    DA9055_ALC_CTRL3, 4,
+			    da9055_signal_tracking_rate_txt);
 
-static const struct soc_enum da9055_integ_release_rate =
-	SOC_ENUM_SINGLE(DA9055_ALC_CTRL3, 6, 4,
-			da9055_signal_tracking_rate_txt);
+static SOC_ENUM_SINGLE_DECL(da9055_integ_release_rate,
+			    DA9055_ALC_CTRL3, 6,
+			    da9055_signal_tracking_rate_txt);
 
 /* ALC Attack Rate select */
 static const char * const da9055_attack_rate_txt[] = {
@@ -432,8 +432,8 @@ static const char * const da9055_attack_rate_txt[] = {
 	"5632/fs", "11264/fs", "22528/fs", "45056/fs", "90112/fs", "180224/fs"
 };
 
-static const struct soc_enum da9055_attack_rate =
-	SOC_ENUM_SINGLE(DA9055_ALC_CTRL2, 0, 13, da9055_attack_rate_txt);
+static SOC_ENUM_SINGLE_DECL(da9055_attack_rate,
+			    DA9055_ALC_CTRL2, 0, da9055_attack_rate_txt);
 
 /* ALC Release Rate select */
 static const char * const da9055_release_rate_txt[] = {
@@ -441,8 +441,8 @@ static const char * const da9055_release_rate_txt[] = {
 	"11264/fs", "22528/fs", "45056/fs", "90112/fs", "180224/fs"
 };
 
-static const struct soc_enum da9055_release_rate =
-	SOC_ENUM_SINGLE(DA9055_ALC_CTRL2, 4, 11, da9055_release_rate_txt);
+static SOC_ENUM_SINGLE_DECL(da9055_release_rate,
+			    DA9055_ALC_CTRL2, 4, da9055_release_rate_txt);
 
 /* ALC Hold Time select */
 static const char * const da9055_hold_time_txt[] = {
@@ -451,8 +451,8 @@ static const char * const da9055_hold_time_txt[] = {
 	"253952/fs", "507904/fs", "1015808/fs", "2031616/fs"
 };
 
-static const struct soc_enum da9055_hold_time =
-	SOC_ENUM_SINGLE(DA9055_ALC_CTRL3, 0, 16, da9055_hold_time_txt);
+static SOC_ENUM_SINGLE_DECL(da9055_hold_time,
+			    DA9055_ALC_CTRL3, 0, da9055_hold_time_txt);
 
 static int da9055_get_alc_data(struct snd_soc_codec *codec, u8 reg_val)
 {
-- 
1.8.5.2
