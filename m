From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 052/102] ASoC: wm8903: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:38:08 +0100
Message-ID: <1392723517-12772-25-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DF452655CC
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
 sound/soc/codecs/wm8903.c | 108 +++++++++++++++++++++++-----------------------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index eebcb1da3b7b..b82b70a3b3d3 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -489,28 +489,28 @@ static const char *hpf_mode_text[] = {
 	"Hi-fi", "Voice 1", "Voice 2", "Voice 3"
 };
 
-static const struct soc_enum hpf_mode =
-	SOC_ENUM_SINGLE(WM8903_ADC_DIGITAL_0, 5, 4, hpf_mode_text);
+static SOC_ENUM_SINGLE_DECL(hpf_mode,
+			    WM8903_ADC_DIGITAL_0, 5, hpf_mode_text);
 
 static const char *osr_text[] = {
 	"Low power", "High performance"
 };
 
-static const struct soc_enum adc_osr =
-	SOC_ENUM_SINGLE(WM8903_ANALOGUE_ADC_0, 0, 2, osr_text);
+static SOC_ENUM_SINGLE_DECL(adc_osr,
+			    WM8903_ANALOGUE_ADC_0, 0, osr_text);
 
-static const struct soc_enum dac_osr =
-	SOC_ENUM_SINGLE(WM8903_DAC_DIGITAL_1, 0, 2, osr_text);
+static SOC_ENUM_SINGLE_DECL(dac_osr,
+			    WM8903_DAC_DIGITAL_1, 0, osr_text);
 
 static const char *drc_slope_text[] = {
 	"1", "1/2", "1/4", "1/8", "1/16", "0"
 };
 
-static const struct soc_enum drc_slope_r0 =
-	SOC_ENUM_SINGLE(WM8903_DRC_2, 3, 6, drc_slope_text);
+static SOC_ENUM_SINGLE_DECL(drc_slope_r0,
+			    WM8903_DRC_2, 3, drc_slope_text);
 
-static const struct soc_enum drc_slope_r1 =
-	SOC_ENUM_SINGLE(WM8903_DRC_2, 0, 6, drc_slope_text);
+static SOC_ENUM_SINGLE_DECL(drc_slope_r1,
+			    WM8903_DRC_2, 0, drc_slope_text);
 
 static const char *drc_attack_text[] = {
 	"instantaneous",
@@ -518,125 +518,125 @@ static const char *drc_attack_text[] = {
 	"46.4ms", "92.8ms", "185.6ms"
 };
 
-static const struct soc_enum drc_attack =
-	SOC_ENUM_SINGLE(WM8903_DRC_1, 12, 11, drc_attack_text);
+static SOC_ENUM_SINGLE_DECL(drc_attack,
+			    WM8903_DRC_1, 12, drc_attack_text);
 
 static const char *drc_decay_text[] = {
 	"186ms", "372ms", "743ms", "1.49s", "2.97s", "5.94s", "11.89s",
 	"23.87s", "47.56s"
 };
 
-static const struct soc_enum drc_decay =
-	SOC_ENUM_SINGLE(WM8903_DRC_1, 8, 9, drc_decay_text);
+static SOC_ENUM_SINGLE_DECL(drc_decay,
+			    WM8903_DRC_1, 8, drc_decay_text);
 
 static const char *drc_ff_delay_text[] = {
 	"5 samples", "9 samples"
 };
 
-static const struct soc_enum drc_ff_delay =
-	SOC_ENUM_SINGLE(WM8903_DRC_0, 5, 2, drc_ff_delay_text);
+static SOC_ENUM_SINGLE_DECL(drc_ff_delay,
+			    WM8903_DRC_0, 5, drc_ff_delay_text);
 
 static const char *drc_qr_decay_text[] = {
 	"0.725ms", "1.45ms", "5.8ms"
 };
 
-static const struct soc_enum drc_qr_decay =
-	SOC_ENUM_SINGLE(WM8903_DRC_1, 4, 3, drc_qr_decay_text);
+static SOC_ENUM_SINGLE_DECL(drc_qr_decay,
+			    WM8903_DRC_1, 4, drc_qr_decay_text);
 
 static const char *drc_smoothing_text[] = {
 	"Low", "Medium", "High"
 };
 
-static const struct soc_enum drc_smoothing =
-	SOC_ENUM_SINGLE(WM8903_DRC_0, 11, 3, drc_smoothing_text);
+static SOC_ENUM_SINGLE_DECL(drc_smoothing,
+			    WM8903_DRC_0, 11, drc_smoothing_text);
 
 static const char *soft_mute_text[] = {
 	"Fast (fs/2)", "Slow (fs/32)"
 };
 
-static const struct soc_enum soft_mute =
-	SOC_ENUM_SINGLE(WM8903_DAC_DIGITAL_1, 10, 2, soft_mute_text);
+static SOC_ENUM_SINGLE_DECL(soft_mute,
+			    WM8903_DAC_DIGITAL_1, 10, soft_mute_text);
 
 static const char *mute_mode_text[] = {
 	"Hard", "Soft"
 };
 
-static const struct soc_enum mute_mode =
-	SOC_ENUM_SINGLE(WM8903_DAC_DIGITAL_1, 9, 2, mute_mode_text);
+static SOC_ENUM_SINGLE_DECL(mute_mode,
+			    WM8903_DAC_DIGITAL_1, 9, mute_mode_text);
 
 static const char *companding_text[] = {
 	"ulaw", "alaw"
 };
 
-static const struct soc_enum dac_companding =
-	SOC_ENUM_SINGLE(WM8903_AUDIO_INTERFACE_0, 0, 2, companding_text);
+static SOC_ENUM_SINGLE_DECL(dac_companding,
+			    WM8903_AUDIO_INTERFACE_0, 0, companding_text);
 
-static const struct soc_enum adc_companding =
-	SOC_ENUM_SINGLE(WM8903_AUDIO_INTERFACE_0, 2, 2, companding_text);
+static SOC_ENUM_SINGLE_DECL(adc_companding,
+			    WM8903_AUDIO_INTERFACE_0, 2, companding_text);
 
 static const char *input_mode_text[] = {
 	"Single-Ended", "Differential Line", "Differential Mic"
 };
 
-static const struct soc_enum linput_mode_enum =
-	SOC_ENUM_SINGLE(WM8903_ANALOGUE_LEFT_INPUT_1, 0, 3, input_mode_text);
+static SOC_ENUM_SINGLE_DECL(linput_mode_enum,
+			    WM8903_ANALOGUE_LEFT_INPUT_1, 0, input_mode_text);
 
-static const struct soc_enum rinput_mode_enum =
-	SOC_ENUM_SINGLE(WM8903_ANALOGUE_RIGHT_INPUT_1, 0, 3, input_mode_text);
+static SOC_ENUM_SINGLE_DECL(rinput_mode_enum,
+			    WM8903_ANALOGUE_RIGHT_INPUT_1, 0, input_mode_text);
 
 static const char *linput_mux_text[] = {
 	"IN1L", "IN2L", "IN3L"
 };
 
-static const struct soc_enum linput_enum =
-	SOC_ENUM_SINGLE(WM8903_ANALOGUE_LEFT_INPUT_1, 2, 3, linput_mux_text);
+static SOC_ENUM_SINGLE_DECL(linput_enum,
+			    WM8903_ANALOGUE_LEFT_INPUT_1, 2, linput_mux_text);
 
-static const struct soc_enum linput_inv_enum =
-	SOC_ENUM_SINGLE(WM8903_ANALOGUE_LEFT_INPUT_1, 4, 3, linput_mux_text);
+static SOC_ENUM_SINGLE_DECL(linput_inv_enum,
+			    WM8903_ANALOGUE_LEFT_INPUT_1, 4, linput_mux_text);
 
 static const char *rinput_mux_text[] = {
 	"IN1R", "IN2R", "IN3R"
 };
 
-static const struct soc_enum rinput_enum =
-	SOC_ENUM_SINGLE(WM8903_ANALOGUE_RIGHT_INPUT_1, 2, 3, rinput_mux_text);
+static SOC_ENUM_SINGLE_DECL(rinput_enum,
+			    WM8903_ANALOGUE_RIGHT_INPUT_1, 2, rinput_mux_text);
 
-static const struct soc_enum rinput_inv_enum =
-	SOC_ENUM_SINGLE(WM8903_ANALOGUE_RIGHT_INPUT_1, 4, 3, rinput_mux_text);
+static SOC_ENUM_SINGLE_DECL(rinput_inv_enum,
+			    WM8903_ANALOGUE_RIGHT_INPUT_1, 4, rinput_mux_text);
 
 
 static const char *sidetone_text[] = {
 	"None", "Left", "Right"
 };
 
-static const struct soc_enum lsidetone_enum =
-	SOC_ENUM_SINGLE(WM8903_DAC_DIGITAL_0, 2, 3, sidetone_text);
+static SOC_ENUM_SINGLE_DECL(lsidetone_enum,
+			    WM8903_DAC_DIGITAL_0, 2, sidetone_text);
 
-static const struct soc_enum rsidetone_enum =
-	SOC_ENUM_SINGLE(WM8903_DAC_DIGITAL_0, 0, 3, sidetone_text);
+static SOC_ENUM_SINGLE_DECL(rsidetone_enum,
+			    WM8903_DAC_DIGITAL_0, 0, sidetone_text);
 
 static const char *adcinput_text[] = {
 	"ADC", "DMIC"
 };
 
-static const struct soc_enum adcinput_enum =
-	SOC_ENUM_SINGLE(WM8903_CLOCK_RATE_TEST_4, 9, 2, adcinput_text);
+static SOC_ENUM_SINGLE_DECL(adcinput_enum,
+			    WM8903_CLOCK_RATE_TEST_4, 9, adcinput_text);
 
 static const char *aif_text[] = {
 	"Left", "Right"
 };
 
-static const struct soc_enum lcapture_enum =
-	SOC_ENUM_SINGLE(WM8903_AUDIO_INTERFACE_0, 7, 2, aif_text);
+static SOC_ENUM_SINGLE_DECL(lcapture_enum,
+			    WM8903_AUDIO_INTERFACE_0, 7, aif_text);
 
-static const struct soc_enum rcapture_enum =
-	SOC_ENUM_SINGLE(WM8903_AUDIO_INTERFACE_0, 6, 2, aif_text);
+static SOC_ENUM_SINGLE_DECL(rcapture_enum,
+			    WM8903_AUDIO_INTERFACE_0, 6, aif_text);
 
-static const struct soc_enum lplay_enum =
-	SOC_ENUM_SINGLE(WM8903_AUDIO_INTERFACE_0, 5, 2, aif_text);
+static SOC_ENUM_SINGLE_DECL(lplay_enum,
+			    WM8903_AUDIO_INTERFACE_0, 5, aif_text);
 
-static const struct soc_enum rplay_enum =
-	SOC_ENUM_SINGLE(WM8903_AUDIO_INTERFACE_0, 4, 2, aif_text);
+static SOC_ENUM_SINGLE_DECL(rplay_enum,
+			    WM8903_AUDIO_INTERFACE_0, 4, aif_text);
 
 static const struct snd_kcontrol_new wm8903_snd_controls[] = {
 
-- 
1.8.5.2
