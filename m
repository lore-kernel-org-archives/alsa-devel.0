From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 060/102] ASoC: wm8996: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:38:16 +0100
Message-ID: <1392723517-12772-33-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CA8C2655D2
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
 sound/soc/codecs/wm8996.c | 56 +++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index ea6b587f65c1..25acbd897e9f 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -311,28 +311,28 @@ static const char *sidetone_hpf_text[] = {
 	"2.9kHz", "1.5kHz", "735Hz", "403Hz", "196Hz", "98Hz", "49Hz"
 };
 
-static const struct soc_enum sidetone_hpf =
-	SOC_ENUM_SINGLE(WM8996_SIDETONE, 7, 7, sidetone_hpf_text);
+static SOC_ENUM_SINGLE_DECL(sidetone_hpf,
+			    WM8996_SIDETONE, 7, sidetone_hpf_text);
 
 static const char *hpf_mode_text[] = {
 	"HiFi", "Custom", "Voice"
 };
 
-static const struct soc_enum dsp1tx_hpf_mode =
-	SOC_ENUM_SINGLE(WM8996_DSP1_TX_FILTERS, 3, 3, hpf_mode_text);
+static SOC_ENUM_SINGLE_DECL(dsp1tx_hpf_mode,
+			    WM8996_DSP1_TX_FILTERS, 3, hpf_mode_text);
 
-static const struct soc_enum dsp2tx_hpf_mode =
-	SOC_ENUM_SINGLE(WM8996_DSP2_TX_FILTERS, 3, 3, hpf_mode_text);
+static SOC_ENUM_SINGLE_DECL(dsp2tx_hpf_mode,
+			    WM8996_DSP2_TX_FILTERS, 3, hpf_mode_text);
 
 static const char *hpf_cutoff_text[] = {
 	"50Hz", "75Hz", "100Hz", "150Hz", "200Hz", "300Hz", "400Hz"
 };
 
-static const struct soc_enum dsp1tx_hpf_cutoff =
-	SOC_ENUM_SINGLE(WM8996_DSP1_TX_FILTERS, 0, 7, hpf_cutoff_text);
+static SOC_ENUM_SINGLE_DECL(dsp1tx_hpf_cutoff,
+			    WM8996_DSP1_TX_FILTERS, 0, hpf_cutoff_text);
 
-static const struct soc_enum dsp2tx_hpf_cutoff =
-	SOC_ENUM_SINGLE(WM8996_DSP2_TX_FILTERS, 0, 7, hpf_cutoff_text);
+static SOC_ENUM_SINGLE_DECL(dsp2tx_hpf_cutoff,
+			    WM8996_DSP2_TX_FILTERS, 0, hpf_cutoff_text);
 
 static void wm8996_set_retune_mobile(struct snd_soc_codec *codec, int block)
 {
@@ -780,14 +780,14 @@ static const char *sidetone_text[] = {
 	"IN1", "IN2",
 };
 
-static const struct soc_enum left_sidetone_enum =
-	SOC_ENUM_SINGLE(WM8996_SIDETONE, 0, 2, sidetone_text);
+static SOC_ENUM_SINGLE_DECL(left_sidetone_enum,
+			    WM8996_SIDETONE, 0, sidetone_text);
 
 static const struct snd_kcontrol_new left_sidetone =
 	SOC_DAPM_ENUM("Left Sidetone", left_sidetone_enum);
 
-static const struct soc_enum right_sidetone_enum =
-	SOC_ENUM_SINGLE(WM8996_SIDETONE, 1, 2, sidetone_text);
+static SOC_ENUM_SINGLE_DECL(right_sidetone_enum,
+			    WM8996_SIDETONE, 1, sidetone_text);
 
 static const struct snd_kcontrol_new right_sidetone =
 	SOC_DAPM_ENUM("Right Sidetone", right_sidetone_enum);
@@ -796,14 +796,14 @@ static const char *spk_text[] = {
 	"DAC1L", "DAC1R", "DAC2L", "DAC2R"
 };
 
-static const struct soc_enum spkl_enum =
-	SOC_ENUM_SINGLE(WM8996_LEFT_PDM_SPEAKER, 0, 4, spk_text);
+static SOC_ENUM_SINGLE_DECL(spkl_enum,
+			    WM8996_LEFT_PDM_SPEAKER, 0, spk_text);
 
 static const struct snd_kcontrol_new spkl_mux =
 	SOC_DAPM_ENUM("SPKL", spkl_enum);
 
-static const struct soc_enum spkr_enum =
-	SOC_ENUM_SINGLE(WM8996_RIGHT_PDM_SPEAKER, 0, 4, spk_text);
+static SOC_ENUM_SINGLE_DECL(spkr_enum,
+			    WM8996_RIGHT_PDM_SPEAKER, 0, spk_text);
 
 static const struct snd_kcontrol_new spkr_mux =
 	SOC_DAPM_ENUM("SPKR", spkr_enum);
@@ -812,8 +812,8 @@ static const char *dsp1rx_text[] = {
 	"AIF1", "AIF2"
 };
 
-static const struct soc_enum dsp1rx_enum =
-	SOC_ENUM_SINGLE(WM8996_POWER_MANAGEMENT_8, 0, 2, dsp1rx_text);
+static SOC_ENUM_SINGLE_DECL(dsp1rx_enum,
+			    WM8996_POWER_MANAGEMENT_8, 0, dsp1rx_text);
 
 static const struct snd_kcontrol_new dsp1rx =
 	SOC_DAPM_ENUM("DSP1RX", dsp1rx_enum);
@@ -822,8 +822,8 @@ static const char *dsp2rx_text[] = {
 	 "AIF2", "AIF1"
 };
 
-static const struct soc_enum dsp2rx_enum =
-	SOC_ENUM_SINGLE(WM8996_POWER_MANAGEMENT_8, 4, 2, dsp2rx_text);
+static SOC_ENUM_SINGLE_DECL(dsp2rx_enum,
+			    WM8996_POWER_MANAGEMENT_8, 4, dsp2rx_text);
 
 static const struct snd_kcontrol_new dsp2rx =
 	SOC_DAPM_ENUM("DSP2RX", dsp2rx_enum);
@@ -832,8 +832,8 @@ static const char *aif2tx_text[] = {
 	"DSP2", "DSP1", "AIF1"
 };
 
-static const struct soc_enum aif2tx_enum =
-	SOC_ENUM_SINGLE(WM8996_POWER_MANAGEMENT_8, 6, 3, aif2tx_text);
+static SOC_ENUM_SINGLE_DECL(aif2tx_enum,
+			    WM8996_POWER_MANAGEMENT_8, 6, aif2tx_text);
 
 static const struct snd_kcontrol_new aif2tx =
 	SOC_DAPM_ENUM("AIF2TX", aif2tx_enum);
@@ -842,14 +842,14 @@ static const char *inmux_text[] = {
 	"ADC", "DMIC1", "DMIC2"
 };
 
-static const struct soc_enum in1_enum =
-	SOC_ENUM_SINGLE(WM8996_POWER_MANAGEMENT_7, 0, 3, inmux_text);
+static SOC_ENUM_SINGLE_DECL(in1_enum,
+			    WM8996_POWER_MANAGEMENT_7, 0, inmux_text);
 
 static const struct snd_kcontrol_new in1_mux =
 	SOC_DAPM_ENUM("IN1 Mux", in1_enum);
 
-static const struct soc_enum in2_enum =
-	SOC_ENUM_SINGLE(WM8996_POWER_MANAGEMENT_7, 4, 3, inmux_text);
+static SOC_ENUM_SINGLE_DECL(in2_enum,
+			    WM8996_POWER_MANAGEMENT_7, 4, inmux_text);
 
 static const struct snd_kcontrol_new in2_mux =
 	SOC_DAPM_ENUM("IN2 Mux", in2_enum);
-- 
1.8.5.2
