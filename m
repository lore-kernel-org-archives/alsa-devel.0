From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 031/102] ASoC: cs42l52: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:37:47 +0100
Message-ID: <1392723517-12772-4-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 46A5F2655B8
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
 sound/soc/codecs/cs42l52.c | 92 ++++++++++++++++++++++------------------------
 1 file changed, 43 insertions(+), 49 deletions(-)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index 0bac6d5a4ac8..be455ea5f2fe 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -210,13 +210,11 @@ static const char * const cs42l52_adca_text[] = {
 static const char * const cs42l52_adcb_text[] = {
 	"Input1B", "Input2B", "Input3B", "Input4B", "PGA Input Right"};
 
-static const struct soc_enum adca_enum =
-	SOC_ENUM_SINGLE(CS42L52_ADC_PGA_A, 5,
-		ARRAY_SIZE(cs42l52_adca_text), cs42l52_adca_text);
+static SOC_ENUM_SINGLE_DECL(adca_enum,
+			    CS42L52_ADC_PGA_A, 5, cs42l52_adca_text);
 
-static const struct soc_enum adcb_enum =
-	SOC_ENUM_SINGLE(CS42L52_ADC_PGA_B, 5,
-		ARRAY_SIZE(cs42l52_adcb_text), cs42l52_adcb_text);
+static SOC_ENUM_SINGLE_DECL(adcb_enum,
+			    CS42L52_ADC_PGA_B, 5, cs42l52_adcb_text);
 
 static const struct snd_kcontrol_new adca_mux =
 	SOC_DAPM_ENUM("Left ADC Input Capture Mux", adca_enum);
@@ -229,26 +227,22 @@ static const char * const mic_bias_level_text[] = {
 	"0.8 +VA", "0.83 +VA", "0.91 +VA"
 };
 
-static const struct soc_enum mic_bias_level_enum =
-	SOC_ENUM_SINGLE(CS42L52_IFACE_CTL2, 0,
-			ARRAY_SIZE(mic_bias_level_text), mic_bias_level_text);
+static SOC_ENUM_SINGLE_DECL(mic_bias_level_enum,
+			    CS42L52_IFACE_CTL2, 0, mic_bias_level_text);
 
 static const char * const cs42l52_mic_text[] = { "MIC1", "MIC2" };
 
-static const struct soc_enum mica_enum =
-	SOC_ENUM_SINGLE(CS42L52_MICA_CTL, 5,
-			ARRAY_SIZE(cs42l52_mic_text), cs42l52_mic_text);
+static SOC_ENUM_SINGLE_DECL(mica_enum,
+			    CS42L52_MICA_CTL, 5, cs42l52_mic_text);
 
-static const struct soc_enum micb_enum =
-	SOC_ENUM_SINGLE(CS42L52_MICB_CTL, 5,
-			ARRAY_SIZE(cs42l52_mic_text), cs42l52_mic_text);
+static SOC_ENUM_SINGLE_DECL(micb_enum,
+			    CS42L52_MICB_CTL, 5, cs42l52_mic_text);
 
 static const char * const digital_output_mux_text[] = {"ADC", "DSP"};
 
-static const struct soc_enum digital_output_mux_enum =
-	SOC_ENUM_SINGLE(CS42L52_ADC_MISC_CTL, 6,
-			ARRAY_SIZE(digital_output_mux_text),
-			digital_output_mux_text);
+static SOC_ENUM_SINGLE_DECL(digital_output_mux_enum,
+			    CS42L52_ADC_MISC_CTL, 6,
+			    digital_output_mux_text);
 
 static const struct snd_kcontrol_new digital_output_mux =
 	SOC_DAPM_ENUM("Digital Output Mux", digital_output_mux_enum);
@@ -258,18 +252,18 @@ static const char * const hp_gain_num_text[] = {
 	"0.7099", "0.8399", "1.000", "1.1430"
 };
 
-static const struct soc_enum hp_gain_enum =
-	SOC_ENUM_SINGLE(CS42L52_PB_CTL1, 5,
-		ARRAY_SIZE(hp_gain_num_text), hp_gain_num_text);
+static SOC_ENUM_SINGLE_DECL(hp_gain_enum,
+			    CS42L52_PB_CTL1, 5,
+			    hp_gain_num_text);
 
 static const char * const beep_pitch_text[] = {
 	"C4", "C5", "D5", "E5", "F5", "G5", "A5", "B5",
 	"C6", "D6", "E6", "F6", "G6", "A6", "B6", "C7"
 };
 
-static const struct soc_enum beep_pitch_enum =
-	SOC_ENUM_SINGLE(CS42L52_BEEP_FREQ, 4,
-			ARRAY_SIZE(beep_pitch_text), beep_pitch_text);
+static SOC_ENUM_SINGLE_DECL(beep_pitch_enum,
+			    CS42L52_BEEP_FREQ, 4,
+			    beep_pitch_text);
 
 static const char * const beep_ontime_text[] = {
 	"86 ms", "430 ms", "780 ms", "1.20 s", "1.50 s",
@@ -277,66 +271,66 @@ static const char * const beep_ontime_text[] = {
 	"3.50 s", "3.80 s", "4.20 s", "4.50 s", "4.80 s", "5.20 s"
 };
 
-static const struct soc_enum beep_ontime_enum =
-	SOC_ENUM_SINGLE(CS42L52_BEEP_FREQ, 0,
-			ARRAY_SIZE(beep_ontime_text), beep_ontime_text);
+static SOC_ENUM_SINGLE_DECL(beep_ontime_enum,
+			    CS42L52_BEEP_FREQ, 0,
+			    beep_ontime_text);
 
 static const char * const beep_offtime_text[] = {
 	"1.23 s", "2.58 s", "3.90 s", "5.20 s",
 	"6.60 s", "8.05 s", "9.35 s", "10.80 s"
 };
 
-static const struct soc_enum beep_offtime_enum =
-	SOC_ENUM_SINGLE(CS42L52_BEEP_VOL, 5,
-			ARRAY_SIZE(beep_offtime_text), beep_offtime_text);
+static SOC_ENUM_SINGLE_DECL(beep_offtime_enum,
+			    CS42L52_BEEP_VOL, 5,
+			    beep_offtime_text);
 
 static const char * const beep_config_text[] = {
 	"Off", "Single", "Multiple", "Continuous"
 };
 
-static const struct soc_enum beep_config_enum =
-	SOC_ENUM_SINGLE(CS42L52_BEEP_TONE_CTL, 6,
-			ARRAY_SIZE(beep_config_text), beep_config_text);
+static SOC_ENUM_SINGLE_DECL(beep_config_enum,
+			    CS42L52_BEEP_TONE_CTL, 6,
+			    beep_config_text);
 
 static const char * const beep_bass_text[] = {
 	"50 Hz", "100 Hz", "200 Hz", "250 Hz"
 };
 
-static const struct soc_enum beep_bass_enum =
-	SOC_ENUM_SINGLE(CS42L52_BEEP_TONE_CTL, 1,
-			ARRAY_SIZE(beep_bass_text), beep_bass_text);
+static SOC_ENUM_SINGLE_DECL(beep_bass_enum,
+			    CS42L52_BEEP_TONE_CTL, 1,
+			    beep_bass_text);
 
 static const char * const beep_treble_text[] = {
 	"5 kHz", "7 kHz", "10 kHz", " 15 kHz"
 };
 
-static const struct soc_enum beep_treble_enum =
-	SOC_ENUM_SINGLE(CS42L52_BEEP_TONE_CTL, 3,
-			ARRAY_SIZE(beep_treble_text), beep_treble_text);
+static SOC_ENUM_SINGLE_DECL(beep_treble_enum,
+			    CS42L52_BEEP_TONE_CTL, 3,
+			    beep_treble_text);
 
 static const char * const ng_threshold_text[] = {
 	"-34dB", "-37dB", "-40dB", "-43dB",
 	"-46dB", "-52dB", "-58dB", "-64dB"
 };
 
-static const struct soc_enum ng_threshold_enum =
-	SOC_ENUM_SINGLE(CS42L52_NOISE_GATE_CTL, 2,
-		ARRAY_SIZE(ng_threshold_text), ng_threshold_text);
+static SOC_ENUM_SINGLE_DECL(ng_threshold_enum,
+			    CS42L52_NOISE_GATE_CTL, 2,
+			    ng_threshold_text);
 
 static const char * const cs42l52_ng_delay_text[] = {
 	"50ms", "100ms", "150ms", "200ms"};
 
-static const struct soc_enum ng_delay_enum =
-	SOC_ENUM_SINGLE(CS42L52_NOISE_GATE_CTL, 0,
-		ARRAY_SIZE(cs42l52_ng_delay_text), cs42l52_ng_delay_text);
+static SOC_ENUM_SINGLE_DECL(ng_delay_enum,
+			    CS42L52_NOISE_GATE_CTL, 0,
+			    cs42l52_ng_delay_text);
 
 static const char * const cs42l52_ng_type_text[] = {
 	"Apply Specific", "Apply All"
 };
 
-static const struct soc_enum ng_type_enum =
-	SOC_ENUM_SINGLE(CS42L52_NOISE_GATE_CTL, 6,
-		ARRAY_SIZE(cs42l52_ng_type_text), cs42l52_ng_type_text);
+static SOC_ENUM_SINGLE_DECL(ng_type_enum,
+			    CS42L52_NOISE_GATE_CTL, 6,
+			    cs42l52_ng_type_text);
 
 static const char * const left_swap_text[] = {
 	"Left", "LR 2", "Right"};
-- 
1.8.5.2
