From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 058/102] ASoC: wm8993: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:38:14 +0100
Message-ID: <1392723517-12772-31-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9AF1B2655D1
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
 sound/soc/codecs/wm8993.c | 64 +++++++++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 433d59a0f3ef..0b4c42173c19 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -646,8 +646,8 @@ static const char *dac_deemph_text[] = {
 	"48kHz",
 };
 
-static const struct soc_enum dac_deemph =
-	SOC_ENUM_SINGLE(WM8993_DAC_CTRL, 4, 4, dac_deemph_text);
+static SOC_ENUM_SINGLE_DECL(dac_deemph,
+			    WM8993_DAC_CTRL, 4, dac_deemph_text);
 
 static const char *adc_hpf_text[] = {
 	"Hi-Fi",
@@ -656,16 +656,16 @@ static const char *adc_hpf_text[] = {
 	"Voice 3",
 };
 
-static const struct soc_enum adc_hpf =
-	SOC_ENUM_SINGLE(WM8993_ADC_CTRL, 5, 4, adc_hpf_text);
+static SOC_ENUM_SINGLE_DECL(adc_hpf,
+			    WM8993_ADC_CTRL, 5, adc_hpf_text);
 
 static const char *drc_path_text[] = {
 	"ADC",
 	"DAC"
 };
 
-static const struct soc_enum drc_path =
-	SOC_ENUM_SINGLE(WM8993_DRC_CONTROL_1, 14, 2, drc_path_text);
+static SOC_ENUM_SINGLE_DECL(drc_path,
+			    WM8993_DRC_CONTROL_1, 14, drc_path_text);
 
 static const char *drc_r0_text[] = {
 	"1",
@@ -676,8 +676,8 @@ static const char *drc_r0_text[] = {
 	"0",
 };
 
-static const struct soc_enum drc_r0 =
-	SOC_ENUM_SINGLE(WM8993_DRC_CONTROL_3, 8, 6, drc_r0_text);
+static SOC_ENUM_SINGLE_DECL(drc_r0,
+			    WM8993_DRC_CONTROL_3, 8, drc_r0_text);
 
 static const char *drc_r1_text[] = {
 	"1",
@@ -687,8 +687,8 @@ static const char *drc_r1_text[] = {
 	"0",
 };
 
-static const struct soc_enum drc_r1 =
-	SOC_ENUM_SINGLE(WM8993_DRC_CONTROL_4, 13, 5, drc_r1_text);
+static SOC_ENUM_SINGLE_DECL(drc_r1,
+			    WM8993_DRC_CONTROL_4, 13, drc_r1_text);
 
 static const char *drc_attack_text[] = {
 	"Reserved",
@@ -705,8 +705,8 @@ static const char *drc_attack_text[] = {
 	"185.6ms",
 };
 
-static const struct soc_enum drc_attack =
-	SOC_ENUM_SINGLE(WM8993_DRC_CONTROL_2, 12, 12, drc_attack_text);
+static SOC_ENUM_SINGLE_DECL(drc_attack,
+			    WM8993_DRC_CONTROL_2, 12, drc_attack_text);
 
 static const char *drc_decay_text[] = {
 	"186ms",
@@ -720,16 +720,16 @@ static const char *drc_decay_text[] = {
 	"47.56ms",
 };
 
-static const struct soc_enum drc_decay =
-	SOC_ENUM_SINGLE(WM8993_DRC_CONTROL_2, 8, 9, drc_decay_text);
+static SOC_ENUM_SINGLE_DECL(drc_decay,
+			    WM8993_DRC_CONTROL_2, 8, drc_decay_text);
 
 static const char *drc_ff_text[] = {
 	"5 samples",
 	"9 samples",
 };
 
-static const struct soc_enum drc_ff =
-	SOC_ENUM_SINGLE(WM8993_DRC_CONTROL_3, 7, 2, drc_ff_text);
+static SOC_ENUM_SINGLE_DECL(drc_ff,
+			    WM8993_DRC_CONTROL_3, 7, drc_ff_text);
 
 static const char *drc_qr_rate_text[] = {
 	"0.725ms",
@@ -737,8 +737,8 @@ static const char *drc_qr_rate_text[] = {
 	"5.8ms",
 };
 
-static const struct soc_enum drc_qr_rate =
-	SOC_ENUM_SINGLE(WM8993_DRC_CONTROL_3, 0, 3, drc_qr_rate_text);
+static SOC_ENUM_SINGLE_DECL(drc_qr_rate,
+			    WM8993_DRC_CONTROL_3, 0, drc_qr_rate_text);
 
 static const char *drc_smooth_text[] = {
 	"Low",
@@ -746,8 +746,8 @@ static const char *drc_smooth_text[] = {
 	"High",
 };
 
-static const struct soc_enum drc_smooth =
-	SOC_ENUM_SINGLE(WM8993_DRC_CONTROL_1, 4, 3, drc_smooth_text);
+static SOC_ENUM_SINGLE_DECL(drc_smooth,
+			    WM8993_DRC_CONTROL_1, 4, drc_smooth_text);
 
 static const struct snd_kcontrol_new wm8993_snd_controls[] = {
 SOC_DOUBLE_TLV("Digital Sidetone Volume", WM8993_DIGITAL_SIDE_TONE,
@@ -841,26 +841,26 @@ static const char *aif_text[] = {
 	"Left", "Right"
 };
 
-static const struct soc_enum aifoutl_enum =
-	SOC_ENUM_SINGLE(WM8993_AUDIO_INTERFACE_1, 15, 2, aif_text);
+static SOC_ENUM_SINGLE_DECL(aifoutl_enum,
+			    WM8993_AUDIO_INTERFACE_1, 15, aif_text);
 
 static const struct snd_kcontrol_new aifoutl_mux =
 	SOC_DAPM_ENUM("AIFOUTL Mux", aifoutl_enum);
 
-static const struct soc_enum aifoutr_enum =
-	SOC_ENUM_SINGLE(WM8993_AUDIO_INTERFACE_1, 14, 2, aif_text);
+static SOC_ENUM_SINGLE_DECL(aifoutr_enum,
+			    WM8993_AUDIO_INTERFACE_1, 14, aif_text);
 
 static const struct snd_kcontrol_new aifoutr_mux =
 	SOC_DAPM_ENUM("AIFOUTR Mux", aifoutr_enum);
 
-static const struct soc_enum aifinl_enum =
-	SOC_ENUM_SINGLE(WM8993_AUDIO_INTERFACE_2, 15, 2, aif_text);
+static SOC_ENUM_SINGLE_DECL(aifinl_enum,
+			    WM8993_AUDIO_INTERFACE_2, 15, aif_text);
 
 static const struct snd_kcontrol_new aifinl_mux =
 	SOC_DAPM_ENUM("AIFINL Mux", aifinl_enum);
 
-static const struct soc_enum aifinr_enum =
-	SOC_ENUM_SINGLE(WM8993_AUDIO_INTERFACE_2, 14, 2, aif_text);
+static SOC_ENUM_SINGLE_DECL(aifinr_enum,
+			    WM8993_AUDIO_INTERFACE_2, 14, aif_text);
 
 static const struct snd_kcontrol_new aifinr_mux =
 	SOC_DAPM_ENUM("AIFINR Mux", aifinr_enum);
@@ -869,14 +869,14 @@ static const char *sidetone_text[] = {
 	"None", "Left", "Right"
 };
 
-static const struct soc_enum sidetonel_enum =
-	SOC_ENUM_SINGLE(WM8993_DIGITAL_SIDE_TONE, 2, 3, sidetone_text);
+static SOC_ENUM_SINGLE_DECL(sidetonel_enum,
+			    WM8993_DIGITAL_SIDE_TONE, 2, sidetone_text);
 
 static const struct snd_kcontrol_new sidetonel_mux =
 	SOC_DAPM_ENUM("Left Sidetone", sidetonel_enum);
 
-static const struct soc_enum sidetoner_enum =
-	SOC_ENUM_SINGLE(WM8993_DIGITAL_SIDE_TONE, 0, 3, sidetone_text);
+static SOC_ENUM_SINGLE_DECL(sidetoner_enum,
+			    WM8993_DIGITAL_SIDE_TONE, 0, sidetone_text);
 
 static const struct snd_kcontrol_new sidetoner_mux =
 	SOC_DAPM_ENUM("Right Sidetone", sidetoner_enum);
-- 
1.8.5.2
