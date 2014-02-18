From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 027/102] ASoC: wm8994: Fix the wrong number of
	enum items
Date: Tue, 18 Feb 2014 12:37:02 +0100
Message-ID: <1392723422-12689-12-git-send-email-tiwai@suse.de>
References: <1392723422-12689-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 645FE265590
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:37:06 +0100 (CET)
In-Reply-To: <1392723422-12689-1-git-send-email-tiwai@suse.de>
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

wm8994 codec driver has a few places wrongly defining the number of
enum items.

Use SOC_ENUM_SINGLE_DECL() macro and they are automatically fixed.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm8994.c | 135 ++++++++++++++++++++++++----------------------
 1 file changed, 70 insertions(+), 65 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 8253c3c6db0e..e5695d2644b3 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -265,21 +265,21 @@ static const char *sidetone_hpf_text[] = {
 	"2.7kHz", "1.35kHz", "675Hz", "370Hz", "180Hz", "90Hz", "45Hz"
 };
 
-static const struct soc_enum sidetone_hpf =
-	SOC_ENUM_SINGLE(WM8994_SIDETONE, 7, 7, sidetone_hpf_text);
+static SOC_ENUM_SINGLE_DECL(sidetone_hpf,
+			    WM8994_SIDETONE, 7, sidetone_hpf_text);
 
 static const char *adc_hpf_text[] = {
 	"HiFi", "Voice 1", "Voice 2", "Voice 3"
 };
 
-static const struct soc_enum aif1adc1_hpf =
-	SOC_ENUM_SINGLE(WM8994_AIF1_ADC1_FILTERS, 13, 4, adc_hpf_text);
+static SOC_ENUM_SINGLE_DECL(aif1adc1_hpf,
+			    WM8994_AIF1_ADC1_FILTERS, 13, adc_hpf_text);
 
-static const struct soc_enum aif1adc2_hpf =
-	SOC_ENUM_SINGLE(WM8994_AIF1_ADC2_FILTERS, 13, 4, adc_hpf_text);
+static SOC_ENUM_SINGLE_DECL(aif1adc2_hpf,
+			    WM8994_AIF1_ADC2_FILTERS, 13, adc_hpf_text);
 
-static const struct soc_enum aif2adc_hpf =
-	SOC_ENUM_SINGLE(WM8994_AIF2_ADC_FILTERS, 13, 4, adc_hpf_text);
+static SOC_ENUM_SINGLE_DECL(aif2adc_hpf,
+			    WM8994_AIF2_ADC_FILTERS, 13, adc_hpf_text);
 
 static const DECLARE_TLV_DB_SCALE(aif_tlv, 0, 600, 0);
 static const DECLARE_TLV_DB_SCALE(digital_tlv, -7200, 75, 1);
@@ -501,39 +501,39 @@ static const char *aif_chan_src_text[] = {
 	"Left", "Right"
 };
 
-static const struct soc_enum aif1adcl_src =
-	SOC_ENUM_SINGLE(WM8994_AIF1_CONTROL_1, 15, 2, aif_chan_src_text);
+static SOC_ENUM_SINGLE_DECL(aif1adcl_src,
+			    WM8994_AIF1_CONTROL_1, 15, aif_chan_src_text);
 
-static const struct soc_enum aif1adcr_src =
-	SOC_ENUM_SINGLE(WM8994_AIF1_CONTROL_1, 14, 2, aif_chan_src_text);
+static SOC_ENUM_SINGLE_DECL(aif1adcr_src,
+			    WM8994_AIF1_CONTROL_1, 14, aif_chan_src_text);
 
-static const struct soc_enum aif2adcl_src =
-	SOC_ENUM_SINGLE(WM8994_AIF2_CONTROL_1, 15, 2, aif_chan_src_text);
+static SOC_ENUM_SINGLE_DECL(aif2adcl_src,
+			    WM8994_AIF2_CONTROL_1, 15, aif_chan_src_text);
 
-static const struct soc_enum aif2adcr_src =
-	SOC_ENUM_SINGLE(WM8994_AIF2_CONTROL_1, 14, 2, aif_chan_src_text);
+static SOC_ENUM_SINGLE_DECL(aif2adcr_src,
+			    WM8994_AIF2_CONTROL_1, 14, aif_chan_src_text);
 
-static const struct soc_enum aif1dacl_src =
-	SOC_ENUM_SINGLE(WM8994_AIF1_CONTROL_2, 15, 2, aif_chan_src_text);
+static SOC_ENUM_SINGLE_DECL(aif1dacl_src,
+			    WM8994_AIF1_CONTROL_2, 15, aif_chan_src_text);
 
-static const struct soc_enum aif1dacr_src =
-	SOC_ENUM_SINGLE(WM8994_AIF1_CONTROL_2, 14, 2, aif_chan_src_text);
+static SOC_ENUM_SINGLE_DECL(aif1dacr_src,
+			    WM8994_AIF1_CONTROL_2, 14, aif_chan_src_text);
 
-static const struct soc_enum aif2dacl_src =
-	SOC_ENUM_SINGLE(WM8994_AIF2_CONTROL_2, 15, 2, aif_chan_src_text);
+static SOC_ENUM_SINGLE_DECL(aif2dacl_src,
+			    WM8994_AIF2_CONTROL_2, 15, aif_chan_src_text);
 
-static const struct soc_enum aif2dacr_src =
-	SOC_ENUM_SINGLE(WM8994_AIF2_CONTROL_2, 14, 2, aif_chan_src_text);
+static SOC_ENUM_SINGLE_DECL(aif2dacr_src,
+			    WM8994_AIF2_CONTROL_2, 14, aif_chan_src_text);
 
 static const char *osr_text[] = {
 	"Low Power", "High Performance",
 };
 
-static const struct soc_enum dac_osr =
-	SOC_ENUM_SINGLE(WM8994_OVERSAMPLING, 0, 2, osr_text);
+static SOC_ENUM_SINGLE_DECL(dac_osr,
+			    WM8994_OVERSAMPLING, 0, osr_text);
 
-static const struct soc_enum adc_osr =
-	SOC_ENUM_SINGLE(WM8994_OVERSAMPLING, 1, 2, osr_text);
+static SOC_ENUM_SINGLE_DECL(adc_osr,
+			    WM8994_OVERSAMPLING, 1, osr_text);
 
 static const struct snd_kcontrol_new wm8994_snd_controls[] = {
 SOC_DOUBLE_R_TLV("AIF1ADC1 Volume", WM8994_AIF1_ADC1_LEFT_VOLUME,
@@ -690,17 +690,20 @@ static const char *wm8958_ng_text[] = {
 	"30ms", "125ms", "250ms", "500ms",
 };
 
-static const struct soc_enum wm8958_aif1dac1_ng_hold =
-	SOC_ENUM_SINGLE(WM8958_AIF1_DAC1_NOISE_GATE,
-			WM8958_AIF1DAC1_NG_THR_SHIFT, 4, wm8958_ng_text);
+static SOC_ENUM_SINGLE_DECL(wm8958_aif1dac1_ng_hold,
+			    WM8958_AIF1_DAC1_NOISE_GATE,
+			    WM8958_AIF1DAC1_NG_THR_SHIFT,
+			    wm8958_ng_text);
 
-static const struct soc_enum wm8958_aif1dac2_ng_hold =
-	SOC_ENUM_SINGLE(WM8958_AIF1_DAC2_NOISE_GATE,
-			WM8958_AIF1DAC2_NG_THR_SHIFT, 4, wm8958_ng_text);
+static SOC_ENUM_SINGLE_DECL(wm8958_aif1dac2_ng_hold,
+			    WM8958_AIF1_DAC2_NOISE_GATE,
+			    WM8958_AIF1DAC2_NG_THR_SHIFT,
+			    wm8958_ng_text);
 
-static const struct soc_enum wm8958_aif2dac_ng_hold =
-	SOC_ENUM_SINGLE(WM8958_AIF2_DAC_NOISE_GATE,
-			WM8958_AIF2DAC_NG_THR_SHIFT, 4, wm8958_ng_text);
+static SOC_ENUM_SINGLE_DECL(wm8958_aif2dac_ng_hold,
+			    WM8958_AIF2_DAC_NOISE_GATE,
+			    WM8958_AIF2DAC_NG_THR_SHIFT,
+			    wm8958_ng_text);
 
 static const struct snd_kcontrol_new wm8958_snd_controls[] = {
 SOC_SINGLE_TLV("AIF3 Boost Volume", WM8958_AIF3_CONTROL_2, 10, 3, 0, aif_tlv),
@@ -1341,8 +1344,8 @@ static const char *adc_mux_text[] = {
 	"DMIC",
 };
 
-static const struct soc_enum adc_enum =
-	SOC_ENUM_SINGLE(0, 0, 2, adc_mux_text);
+static SOC_ENUM_SINGLE_DECL(adc_enum,
+			    0, 0, adc_mux_text);
 
 static const struct snd_kcontrol_new adcl_mux =
 	SOC_DAPM_ENUM_VIRT("ADCL Mux", adc_enum);
@@ -1478,14 +1481,14 @@ static const char *sidetone_text[] = {
 	"ADC/DMIC1", "DMIC2",
 };
 
-static const struct soc_enum sidetone1_enum =
-	SOC_ENUM_SINGLE(WM8994_SIDETONE, 0, 2, sidetone_text);
+static SOC_ENUM_SINGLE_DECL(sidetone1_enum,
+			    WM8994_SIDETONE, 0, sidetone_text);
 
 static const struct snd_kcontrol_new sidetone1_mux =
 	SOC_DAPM_ENUM("Left Sidetone Mux", sidetone1_enum);
 
-static const struct soc_enum sidetone2_enum =
-	SOC_ENUM_SINGLE(WM8994_SIDETONE, 1, 2, sidetone_text);
+static SOC_ENUM_SINGLE_DECL(sidetone2_enum,
+			    WM8994_SIDETONE, 1, sidetone_text);
 
 static const struct snd_kcontrol_new sidetone2_mux =
 	SOC_DAPM_ENUM("Right Sidetone Mux", sidetone2_enum);
@@ -1498,22 +1501,24 @@ static const char *loopback_text[] = {
 	"None", "ADCDAT",
 };
 
-static const struct soc_enum aif1_loopback_enum =
-	SOC_ENUM_SINGLE(WM8994_AIF1_CONTROL_2, WM8994_AIF1_LOOPBACK_SHIFT, 2,
-			loopback_text);
+static SOC_ENUM_SINGLE_DECL(aif1_loopback_enum,
+			    WM8994_AIF1_CONTROL_2,
+			    WM8994_AIF1_LOOPBACK_SHIFT,
+			    loopback_text);
 
 static const struct snd_kcontrol_new aif1_loopback =
 	SOC_DAPM_ENUM("AIF1 Loopback", aif1_loopback_enum);
 
-static const struct soc_enum aif2_loopback_enum =
-	SOC_ENUM_SINGLE(WM8994_AIF2_CONTROL_2, WM8994_AIF2_LOOPBACK_SHIFT, 2,
-			loopback_text);
+static SOC_ENUM_SINGLE_DECL(aif2_loopback_enum,
+			    WM8994_AIF2_CONTROL_2,
+			    WM8994_AIF2_LOOPBACK_SHIFT,
+			    loopback_text);
 
 static const struct snd_kcontrol_new aif2_loopback =
 	SOC_DAPM_ENUM("AIF2 Loopback", aif2_loopback_enum);
 
-static const struct soc_enum aif1dac_enum =
-	SOC_ENUM_SINGLE(WM8994_POWER_MANAGEMENT_6, 0, 2, aif1dac_text);
+static SOC_ENUM_SINGLE_DECL(aif1dac_enum,
+			    WM8994_POWER_MANAGEMENT_6, 0, aif1dac_text);
 
 static const struct snd_kcontrol_new aif1dac_mux =
 	SOC_DAPM_ENUM("AIF1DAC Mux", aif1dac_enum);
@@ -1522,8 +1527,8 @@ static const char *aif2dac_text[] = {
 	"AIF2DACDAT", "AIF3DACDAT",
 };
 
-static const struct soc_enum aif2dac_enum =
-	SOC_ENUM_SINGLE(WM8994_POWER_MANAGEMENT_6, 1, 2, aif2dac_text);
+static SOC_ENUM_SINGLE_DECL(aif2dac_enum,
+			    WM8994_POWER_MANAGEMENT_6, 1, aif2dac_text);
 
 static const struct snd_kcontrol_new aif2dac_mux =
 	SOC_DAPM_ENUM("AIF2DAC Mux", aif2dac_enum);
@@ -1532,8 +1537,8 @@ static const char *aif2adc_text[] = {
 	"AIF2ADCDAT", "AIF3DACDAT",
 };
 
-static const struct soc_enum aif2adc_enum =
-	SOC_ENUM_SINGLE(WM8994_POWER_MANAGEMENT_6, 2, 2, aif2adc_text);
+static SOC_ENUM_SINGLE_DECL(aif2adc_enum,
+			    WM8994_POWER_MANAGEMENT_6, 2, aif2adc_text);
 
 static const struct snd_kcontrol_new aif2adc_mux =
 	SOC_DAPM_ENUM("AIF2ADC Mux", aif2adc_enum);
@@ -1542,14 +1547,14 @@ static const char *aif3adc_text[] = {
 	"AIF1ADCDAT", "AIF2ADCDAT", "AIF2DACDAT", "Mono PCM",
 };
 
-static const struct soc_enum wm8994_aif3adc_enum =
-	SOC_ENUM_SINGLE(WM8994_POWER_MANAGEMENT_6, 3, 3, aif3adc_text);
+static SOC_ENUM_SINGLE_DECL(wm8994_aif3adc_enum,
+			    WM8994_POWER_MANAGEMENT_6, 3, aif3adc_text);
 
 static const struct snd_kcontrol_new wm8994_aif3adc_mux =
 	SOC_DAPM_ENUM("AIF3ADC Mux", wm8994_aif3adc_enum);
 
-static const struct soc_enum wm8958_aif3adc_enum =
-	SOC_ENUM_SINGLE(WM8994_POWER_MANAGEMENT_6, 3, 4, aif3adc_text);
+static SOC_ENUM_SINGLE_DECL(wm8958_aif3adc_enum,
+			    WM8994_POWER_MANAGEMENT_6, 3, aif3adc_text);
 
 static const struct snd_kcontrol_new wm8958_aif3adc_mux =
 	SOC_DAPM_ENUM("AIF3ADC Mux", wm8958_aif3adc_enum);
@@ -1558,8 +1563,8 @@ static const char *mono_pcm_out_text[] = {
 	"None", "AIF2ADCL", "AIF2ADCR",
 };
 
-static const struct soc_enum mono_pcm_out_enum =
-	SOC_ENUM_SINGLE(WM8994_POWER_MANAGEMENT_6, 9, 3, mono_pcm_out_text);
+static SOC_ENUM_SINGLE_DECL(mono_pcm_out_enum,
+			    WM8994_POWER_MANAGEMENT_6, 9, mono_pcm_out_text);
 
 static const struct snd_kcontrol_new mono_pcm_out_mux =
 	SOC_DAPM_ENUM("Mono PCM Out Mux", mono_pcm_out_enum);
@@ -1569,14 +1574,14 @@ static const char *aif2dac_src_text[] = {
 };
 
 /* Note that these two control shouldn't be simultaneously switched to AIF3 */
-static const struct soc_enum aif2dacl_src_enum =
-	SOC_ENUM_SINGLE(WM8994_POWER_MANAGEMENT_6, 7, 2, aif2dac_src_text);
+static SOC_ENUM_SINGLE_DECL(aif2dacl_src_enum,
+			    WM8994_POWER_MANAGEMENT_6, 7, aif2dac_src_text);
 
 static const struct snd_kcontrol_new aif2dacl_src_mux =
 	SOC_DAPM_ENUM("AIF2DACL Mux", aif2dacl_src_enum);
 
-static const struct soc_enum aif2dacr_src_enum =
-	SOC_ENUM_SINGLE(WM8994_POWER_MANAGEMENT_6, 8, 2, aif2dac_src_text);
+static SOC_ENUM_SINGLE_DECL(aif2dacr_src_enum,
+			    WM8994_POWER_MANAGEMENT_6, 8, aif2dac_src_text);
 
 static const struct snd_kcontrol_new aif2dacr_src_mux =
 	SOC_DAPM_ENUM("AIF2DACR Mux", aif2dacr_src_enum);
-- 
1.8.5.2
