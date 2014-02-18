From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 053/102] ASoC: wm8904: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:38:09 +0100
Message-ID: <1392723517-12772-26-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A005F2655D6
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
 sound/soc/codecs/wm8904.c | 73 ++++++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 36 deletions(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index b2664ec901b9..27299cda0e99 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -552,18 +552,20 @@ static const char *input_mode_text[] = {
 	"Single-Ended", "Differential Line", "Differential Mic"
 };
 
-static const struct soc_enum lin_mode =
-	SOC_ENUM_SINGLE(WM8904_ANALOGUE_LEFT_INPUT_1, 0, 3, input_mode_text);
+static SOC_ENUM_SINGLE_DECL(lin_mode,
+			    WM8904_ANALOGUE_LEFT_INPUT_1, 0,
+			    input_mode_text);
 
-static const struct soc_enum rin_mode =
-	SOC_ENUM_SINGLE(WM8904_ANALOGUE_RIGHT_INPUT_1, 0, 3, input_mode_text);
+static SOC_ENUM_SINGLE_DECL(rin_mode,
+			    WM8904_ANALOGUE_RIGHT_INPUT_1, 0,
+			    input_mode_text);
 
 static const char *hpf_mode_text[] = {
 	"Hi-fi", "Voice 1", "Voice 2", "Voice 3"
 };
 
-static const struct soc_enum hpf_mode =
-	SOC_ENUM_SINGLE(WM8904_ADC_DIGITAL_0, 5, 4, hpf_mode_text);
+static SOC_ENUM_SINGLE_DECL(hpf_mode, WM8904_ADC_DIGITAL_0, 5,
+			    hpf_mode_text);
 
 static int wm8904_adc_osr_put(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
@@ -611,8 +613,7 @@ static const char *drc_path_text[] = {
 	"ADC", "DAC"
 };
 
-static const struct soc_enum drc_path =
-	SOC_ENUM_SINGLE(WM8904_DRC_0, 14, 2, drc_path_text);
+static SOC_ENUM_SINGLE_DECL(drc_path, WM8904_DRC_0, 14, drc_path_text);
 
 static const struct snd_kcontrol_new wm8904_dac_snd_controls[] = {
 SOC_SINGLE_TLV("Digital Playback Boost Volume", 
@@ -858,14 +859,14 @@ static const char *lin_text[] = {
 	"IN1L", "IN2L", "IN3L"
 };
 
-static const struct soc_enum lin_enum =
-	SOC_ENUM_SINGLE(WM8904_ANALOGUE_LEFT_INPUT_1, 2, 3, lin_text);
+static SOC_ENUM_SINGLE_DECL(lin_enum, WM8904_ANALOGUE_LEFT_INPUT_1, 2,
+			    lin_text);
 
 static const struct snd_kcontrol_new lin_mux =
 	SOC_DAPM_ENUM("Left Capture Mux", lin_enum);
 
-static const struct soc_enum lin_inv_enum =
-	SOC_ENUM_SINGLE(WM8904_ANALOGUE_LEFT_INPUT_1, 4, 3, lin_text);
+static SOC_ENUM_SINGLE_DECL(lin_inv_enum, WM8904_ANALOGUE_LEFT_INPUT_1, 4,
+			    lin_text);
 
 static const struct snd_kcontrol_new lin_inv_mux =
 	SOC_DAPM_ENUM("Left Capture Inveting Mux", lin_inv_enum);
@@ -874,14 +875,14 @@ static const char *rin_text[] = {
 	"IN1R", "IN2R", "IN3R"
 };
 
-static const struct soc_enum rin_enum =
-	SOC_ENUM_SINGLE(WM8904_ANALOGUE_RIGHT_INPUT_1, 2, 3, rin_text);
+static SOC_ENUM_SINGLE_DECL(rin_enum, WM8904_ANALOGUE_RIGHT_INPUT_1, 2,
+			    rin_text);
 
 static const struct snd_kcontrol_new rin_mux =
 	SOC_DAPM_ENUM("Right Capture Mux", rin_enum);
 
-static const struct soc_enum rin_inv_enum =
-	SOC_ENUM_SINGLE(WM8904_ANALOGUE_RIGHT_INPUT_1, 4, 3, rin_text);
+static SOC_ENUM_SINGLE_DECL(rin_inv_enum, WM8904_ANALOGUE_RIGHT_INPUT_1, 4,
+			    rin_text);
 
 static const struct snd_kcontrol_new rin_inv_mux =
 	SOC_DAPM_ENUM("Right Capture Inveting Mux", rin_inv_enum);
@@ -890,26 +891,26 @@ static const char *aif_text[] = {
 	"Left", "Right"
 };
 
-static const struct soc_enum aifoutl_enum =
-	SOC_ENUM_SINGLE(WM8904_AUDIO_INTERFACE_0, 7, 2, aif_text);
+static SOC_ENUM_SINGLE_DECL(aifoutl_enum, WM8904_AUDIO_INTERFACE_0, 7,
+			    aif_text);
 
 static const struct snd_kcontrol_new aifoutl_mux =
 	SOC_DAPM_ENUM("AIFOUTL Mux", aifoutl_enum);
 
-static const struct soc_enum aifoutr_enum =
-	SOC_ENUM_SINGLE(WM8904_AUDIO_INTERFACE_0, 6, 2, aif_text);
+static SOC_ENUM_SINGLE_DECL(aifoutr_enum, WM8904_AUDIO_INTERFACE_0, 6,
+			    aif_text);
 
 static const struct snd_kcontrol_new aifoutr_mux =
 	SOC_DAPM_ENUM("AIFOUTR Mux", aifoutr_enum);
 
-static const struct soc_enum aifinl_enum =
-	SOC_ENUM_SINGLE(WM8904_AUDIO_INTERFACE_0, 5, 2, aif_text);
+static SOC_ENUM_SINGLE_DECL(aifinl_enum, WM8904_AUDIO_INTERFACE_0, 5,
+			    aif_text);
 
 static const struct snd_kcontrol_new aifinl_mux =
 	SOC_DAPM_ENUM("AIFINL Mux", aifinl_enum);
 
-static const struct soc_enum aifinr_enum =
-	SOC_ENUM_SINGLE(WM8904_AUDIO_INTERFACE_0, 4, 2, aif_text);
+static SOC_ENUM_SINGLE_DECL(aifinr_enum, WM8904_AUDIO_INTERFACE_0, 4,
+			    aif_text);
 
 static const struct snd_kcontrol_new aifinr_mux =
 	SOC_DAPM_ENUM("AIFINR Mux", aifinr_enum);
@@ -991,26 +992,26 @@ static const char *out_mux_text[] = {
 	"DAC", "Bypass"
 };
 
-static const struct soc_enum hpl_enum =
-	SOC_ENUM_SINGLE(WM8904_ANALOGUE_OUT12_ZC, 3, 2, out_mux_text);
+static SOC_ENUM_SINGLE_DECL(hpl_enum, WM8904_ANALOGUE_OUT12_ZC, 3,
+			    out_mux_text);
 
 static const struct snd_kcontrol_new hpl_mux =
 	SOC_DAPM_ENUM("HPL Mux", hpl_enum);
 
-static const struct soc_enum hpr_enum =
-	SOC_ENUM_SINGLE(WM8904_ANALOGUE_OUT12_ZC, 2, 2, out_mux_text);
+static SOC_ENUM_SINGLE_DECL(hpr_enum, WM8904_ANALOGUE_OUT12_ZC, 2,
+			    out_mux_text);
 
 static const struct snd_kcontrol_new hpr_mux =
 	SOC_DAPM_ENUM("HPR Mux", hpr_enum);
 
-static const struct soc_enum linel_enum =
-	SOC_ENUM_SINGLE(WM8904_ANALOGUE_OUT12_ZC, 1, 2, out_mux_text);
+static SOC_ENUM_SINGLE_DECL(linel_enum, WM8904_ANALOGUE_OUT12_ZC, 1,
+			    out_mux_text);
 
 static const struct snd_kcontrol_new linel_mux =
 	SOC_DAPM_ENUM("LINEL Mux", linel_enum);
 
-static const struct soc_enum liner_enum =
-	SOC_ENUM_SINGLE(WM8904_ANALOGUE_OUT12_ZC, 0, 2, out_mux_text);
+static SOC_ENUM_SINGLE_DECL(liner_enum, WM8904_ANALOGUE_OUT12_ZC, 0,
+			    out_mux_text);
 
 static const struct snd_kcontrol_new liner_mux =
 	SOC_DAPM_ENUM("LINER Mux", liner_enum);
@@ -1019,14 +1020,14 @@ static const char *sidetone_text[] = {
 	"None", "Left", "Right"
 };
 
-static const struct soc_enum dacl_sidetone_enum =
-	SOC_ENUM_SINGLE(WM8904_DAC_DIGITAL_0, 2, 3, sidetone_text);
+static SOC_ENUM_SINGLE_DECL(dacl_sidetone_enum, WM8904_DAC_DIGITAL_0, 2,
+			    sidetone_text);
 
 static const struct snd_kcontrol_new dacl_sidetone_mux =
 	SOC_DAPM_ENUM("Left Sidetone Mux", dacl_sidetone_enum);
 
-static const struct soc_enum dacr_sidetone_enum =
-	SOC_ENUM_SINGLE(WM8904_DAC_DIGITAL_0, 0, 3, sidetone_text);
+static SOC_ENUM_SINGLE_DECL(dacr_sidetone_enum, WM8904_DAC_DIGITAL_0, 0,
+			    sidetone_text);
 
 static const struct snd_kcontrol_new dacr_sidetone_mux =
 	SOC_DAPM_ENUM("Right Sidetone Mux", dacr_sidetone_enum);
-- 
1.8.5.2
