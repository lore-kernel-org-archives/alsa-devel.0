From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 063/102] ASoC: 88pm860x: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:38:19 +0100
Message-ID: <1392723517-12772-36-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A07EF2655D7
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
 sound/soc/codecs/88pm860x-codec.c | 116 +++++++++++++++++++-------------------
 1 file changed, 58 insertions(+), 58 deletions(-)

diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index 75d0ad5d2dcb..697d24be7897 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -448,38 +448,38 @@ static const char *pm860x_opamp_texts[] = {"-50%", "-25%", "0%", "75%"};
 
 static const char *pm860x_pa_texts[] = {"-33%", "0%", "33%", "66%"};
 
-static const struct soc_enum pm860x_hs1_opamp_enum =
-	SOC_ENUM_SINGLE(PM860X_HS1_CTRL, 5, 4, pm860x_opamp_texts);
+static SOC_ENUM_SINGLE_DECL(pm860x_hs1_opamp_enum,
+			    PM860X_HS1_CTRL, 5, pm860x_opamp_texts);
 
-static const struct soc_enum pm860x_hs2_opamp_enum =
-	SOC_ENUM_SINGLE(PM860X_HS2_CTRL, 5, 4, pm860x_opamp_texts);
+static SOC_ENUM_SINGLE_DECL(pm860x_hs2_opamp_enum,
+			    PM860X_HS2_CTRL, 5, pm860x_opamp_texts);
 
-static const struct soc_enum pm860x_hs1_pa_enum =
-	SOC_ENUM_SINGLE(PM860X_HS1_CTRL, 3, 4, pm860x_pa_texts);
+static SOC_ENUM_SINGLE_DECL(pm860x_hs1_pa_enum,
+			    PM860X_HS1_CTRL, 3, pm860x_pa_texts);
 
-static const struct soc_enum pm860x_hs2_pa_enum =
-	SOC_ENUM_SINGLE(PM860X_HS2_CTRL, 3, 4, pm860x_pa_texts);
+static SOC_ENUM_SINGLE_DECL(pm860x_hs2_pa_enum,
+			    PM860X_HS2_CTRL, 3, pm860x_pa_texts);
 
-static const struct soc_enum pm860x_lo1_opamp_enum =
-	SOC_ENUM_SINGLE(PM860X_LO1_CTRL, 5, 4, pm860x_opamp_texts);
+static SOC_ENUM_SINGLE_DECL(pm860x_lo1_opamp_enum,
+			    PM860X_LO1_CTRL, 5, pm860x_opamp_texts);
 
-static const struct soc_enum pm860x_lo2_opamp_enum =
-	SOC_ENUM_SINGLE(PM860X_LO2_CTRL, 5, 4, pm860x_opamp_texts);
+static SOC_ENUM_SINGLE_DECL(pm860x_lo2_opamp_enum,
+			    PM860X_LO2_CTRL, 5, pm860x_opamp_texts);
 
-static const struct soc_enum pm860x_lo1_pa_enum =
-	SOC_ENUM_SINGLE(PM860X_LO1_CTRL, 3, 4, pm860x_pa_texts);
+static SOC_ENUM_SINGLE_DECL(pm860x_lo1_pa_enum,
+			    PM860X_LO1_CTRL, 3, pm860x_pa_texts);
 
-static const struct soc_enum pm860x_lo2_pa_enum =
-	SOC_ENUM_SINGLE(PM860X_LO2_CTRL, 3, 4, pm860x_pa_texts);
+static SOC_ENUM_SINGLE_DECL(pm860x_lo2_pa_enum,
+			    PM860X_LO2_CTRL, 3, pm860x_pa_texts);
 
-static const struct soc_enum pm860x_spk_pa_enum =
-	SOC_ENUM_SINGLE(PM860X_EAR_CTRL_1, 5, 4, pm860x_pa_texts);
+static SOC_ENUM_SINGLE_DECL(pm860x_spk_pa_enum,
+			    PM860X_EAR_CTRL_1, 5, pm860x_pa_texts);
 
-static const struct soc_enum pm860x_ear_pa_enum =
-	SOC_ENUM_SINGLE(PM860X_EAR_CTRL_2, 0, 4, pm860x_pa_texts);
+static SOC_ENUM_SINGLE_DECL(pm860x_ear_pa_enum,
+			    PM860X_EAR_CTRL_2, 0, pm860x_pa_texts);
 
-static const struct soc_enum pm860x_spk_ear_opamp_enum =
-	SOC_ENUM_SINGLE(PM860X_EAR_CTRL_1, 3, 4, pm860x_opamp_texts);
+static SOC_ENUM_SINGLE_DECL(pm860x_spk_ear_opamp_enum,
+			    PM860X_EAR_CTRL_1, 3, pm860x_opamp_texts);
 
 static const struct snd_kcontrol_new pm860x_snd_controls[] = {
 	SOC_DOUBLE_R_TLV("ADC Capture Volume", PM860X_ADC_ANA_2,
@@ -561,8 +561,8 @@ static const char *aif1_text[] = {
 	"PCM L", "PCM R",
 };
 
-static const struct soc_enum aif1_enum =
-	SOC_ENUM_SINGLE(PM860X_PCM_IFACE_3, 6, 2, aif1_text);
+static SOC_ENUM_SINGLE_DECL(aif1_enum,
+			    PM860X_PCM_IFACE_3, 6, aif1_text);
 
 static const struct snd_kcontrol_new aif1_mux =
 	SOC_DAPM_ENUM("PCM Mux", aif1_enum);
@@ -572,8 +572,8 @@ static const char *i2s_din_text[] = {
 	"DIN", "DIN1",
 };
 
-static const struct soc_enum i2s_din_enum =
-	SOC_ENUM_SINGLE(PM860X_I2S_IFACE_3, 1, 2, i2s_din_text);
+static SOC_ENUM_SINGLE_DECL(i2s_din_enum,
+			    PM860X_I2S_IFACE_3, 1, i2s_din_text);
 
 static const struct snd_kcontrol_new i2s_din_mux =
 	SOC_DAPM_ENUM("I2S DIN Mux", i2s_din_enum);
@@ -583,8 +583,8 @@ static const char *i2s_mic_text[] = {
 	"Ex PA", "ADC",
 };
 
-static const struct soc_enum i2s_mic_enum =
-	SOC_ENUM_SINGLE(PM860X_I2S_IFACE_3, 4, 2, i2s_mic_text);
+static SOC_ENUM_SINGLE_DECL(i2s_mic_enum,
+			    PM860X_I2S_IFACE_3, 4, i2s_mic_text);
 
 static const struct snd_kcontrol_new i2s_mic_mux =
 	SOC_DAPM_ENUM("I2S Mic Mux", i2s_mic_enum);
@@ -594,8 +594,8 @@ static const char *adcl_text[] = {
 	"ADCR", "ADCL",
 };
 
-static const struct soc_enum adcl_enum =
-	SOC_ENUM_SINGLE(PM860X_PCM_IFACE_3, 4, 2, adcl_text);
+static SOC_ENUM_SINGLE_DECL(adcl_enum,
+			    PM860X_PCM_IFACE_3, 4, adcl_text);
 
 static const struct snd_kcontrol_new adcl_mux =
 	SOC_DAPM_ENUM("ADC Left Mux", adcl_enum);
@@ -605,8 +605,8 @@ static const char *adcr_text[] = {
 	"ADCL", "ADCR",
 };
 
-static const struct soc_enum adcr_enum =
-	SOC_ENUM_SINGLE(PM860X_PCM_IFACE_3, 2, 2, adcr_text);
+static SOC_ENUM_SINGLE_DECL(adcr_enum,
+			    PM860X_PCM_IFACE_3, 2, adcr_text);
 
 static const struct snd_kcontrol_new adcr_mux =
 	SOC_DAPM_ENUM("ADC Right Mux", adcr_enum);
@@ -616,8 +616,8 @@ static const char *adcr_ec_text[] = {
 	"ADCR", "EC",
 };
 
-static const struct soc_enum adcr_ec_enum =
-	SOC_ENUM_SINGLE(PM860X_ADC_EN_2, 3, 2, adcr_ec_text);
+static SOC_ENUM_SINGLE_DECL(adcr_ec_enum,
+			    PM860X_ADC_EN_2, 3, adcr_ec_text);
 
 static const struct snd_kcontrol_new adcr_ec_mux =
 	SOC_DAPM_ENUM("ADCR EC Mux", adcr_ec_enum);
@@ -627,8 +627,8 @@ static const char *ec_text[] = {
 	"Left", "Right", "Left + Right",
 };
 
-static const struct soc_enum ec_enum =
-	SOC_ENUM_SINGLE(PM860X_EC_PATH, 1, 3, ec_text);
+static SOC_ENUM_SINGLE_DECL(ec_enum,
+			    PM860X_EC_PATH, 1, ec_text);
 
 static const struct snd_kcontrol_new ec_mux =
 	SOC_DAPM_ENUM("EC Mux", ec_enum);
@@ -638,36 +638,36 @@ static const char *dac_text[] = {
 };
 
 /* DAC Headset 1 Mux / Mux10 */
-static const struct soc_enum dac_hs1_enum =
-	SOC_ENUM_SINGLE(PM860X_ANA_INPUT_SEL_1, 0, 4, dac_text);
+static SOC_ENUM_SINGLE_DECL(dac_hs1_enum,
+			    PM860X_ANA_INPUT_SEL_1, 0, dac_text);
 
 static const struct snd_kcontrol_new dac_hs1_mux =
 	SOC_DAPM_ENUM("DAC HS1 Mux", dac_hs1_enum);
 
 /* DAC Headset 2 Mux / Mux11 */
-static const struct soc_enum dac_hs2_enum =
-	SOC_ENUM_SINGLE(PM860X_ANA_INPUT_SEL_1, 2, 4, dac_text);
+static SOC_ENUM_SINGLE_DECL(dac_hs2_enum,
+			    PM860X_ANA_INPUT_SEL_1, 2, dac_text);
 
 static const struct snd_kcontrol_new dac_hs2_mux =
 	SOC_DAPM_ENUM("DAC HS2 Mux", dac_hs2_enum);
 
 /* DAC Lineout 1 Mux / Mux12 */
-static const struct soc_enum dac_lo1_enum =
-	SOC_ENUM_SINGLE(PM860X_ANA_INPUT_SEL_1, 4, 4, dac_text);
+static SOC_ENUM_SINGLE_DECL(dac_lo1_enum,
+			    PM860X_ANA_INPUT_SEL_1, 4, dac_text);
 
 static const struct snd_kcontrol_new dac_lo1_mux =
 	SOC_DAPM_ENUM("DAC LO1 Mux", dac_lo1_enum);
 
 /* DAC Lineout 2 Mux / Mux13 */
-static const struct soc_enum dac_lo2_enum =
-	SOC_ENUM_SINGLE(PM860X_ANA_INPUT_SEL_1, 6, 4, dac_text);
+static SOC_ENUM_SINGLE_DECL(dac_lo2_enum,
+			    PM860X_ANA_INPUT_SEL_1, 6, dac_text);
 
 static const struct snd_kcontrol_new dac_lo2_mux =
 	SOC_DAPM_ENUM("DAC LO2 Mux", dac_lo2_enum);
 
 /* DAC Spearker Earphone Mux / Mux14 */
-static const struct soc_enum dac_spk_ear_enum =
-	SOC_ENUM_SINGLE(PM860X_ANA_INPUT_SEL_2, 0, 4, dac_text);
+static SOC_ENUM_SINGLE_DECL(dac_spk_ear_enum,
+			    PM860X_ANA_INPUT_SEL_2, 0, dac_text);
 
 static const struct snd_kcontrol_new dac_spk_ear_mux =
 	SOC_DAPM_ENUM("DAC SP Mux", dac_spk_ear_enum);
@@ -677,29 +677,29 @@ static const char *in_text[] = {
 	"Digital", "Analog",
 };
 
-static const struct soc_enum hs1_enum =
-	SOC_ENUM_SINGLE(PM860X_ANA_TO_ANA, 0, 2, in_text);
+static SOC_ENUM_SINGLE_DECL(hs1_enum,
+			    PM860X_ANA_TO_ANA, 0, in_text);
 
 static const struct snd_kcontrol_new hs1_mux =
 	SOC_DAPM_ENUM("Headset1 Mux", hs1_enum);
 
 /* Headset 2 Mux / Mux16 */
-static const struct soc_enum hs2_enum =
-	SOC_ENUM_SINGLE(PM860X_ANA_TO_ANA, 1, 2, in_text);
+static SOC_ENUM_SINGLE_DECL(hs2_enum,
+			    PM860X_ANA_TO_ANA, 1, in_text);
 
 static const struct snd_kcontrol_new hs2_mux =
 	SOC_DAPM_ENUM("Headset2 Mux", hs2_enum);
 
 /* Lineout 1 Mux / Mux17 */
-static const struct soc_enum lo1_enum =
-	SOC_ENUM_SINGLE(PM860X_ANA_TO_ANA, 2, 2, in_text);
+static SOC_ENUM_SINGLE_DECL(lo1_enum,
+			    PM860X_ANA_TO_ANA, 2, in_text);
 
 static const struct snd_kcontrol_new lo1_mux =
 	SOC_DAPM_ENUM("Lineout1 Mux", lo1_enum);
 
 /* Lineout 2 Mux / Mux18 */
-static const struct soc_enum lo2_enum =
-	SOC_ENUM_SINGLE(PM860X_ANA_TO_ANA, 3, 2, in_text);
+static SOC_ENUM_SINGLE_DECL(lo2_enum,
+			    PM860X_ANA_TO_ANA, 3, in_text);
 
 static const struct snd_kcontrol_new lo2_mux =
 	SOC_DAPM_ENUM("Lineout2 Mux", lo2_enum);
@@ -709,8 +709,8 @@ static const char *spk_text[] = {
 	"Earpiece", "Speaker",
 };
 
-static const struct soc_enum spk_enum =
-	SOC_ENUM_SINGLE(PM860X_ANA_TO_ANA, 6, 2, spk_text);
+static SOC_ENUM_SINGLE_DECL(spk_enum,
+			    PM860X_ANA_TO_ANA, 6, spk_text);
 
 static const struct snd_kcontrol_new spk_demux =
 	SOC_DAPM_ENUM("Speaker Earpiece Demux", spk_enum);
@@ -720,8 +720,8 @@ static const char *mic_text[] = {
 	"Mic 1", "Mic 2",
 };
 
-static const struct soc_enum mic_enum =
-	SOC_ENUM_SINGLE(PM860X_ADC_ANA_4, 4, 2, mic_text);
+static SOC_ENUM_SINGLE_DECL(mic_enum,
+			    PM860X_ADC_ANA_4, 4, mic_text);
 
 static const struct snd_kcontrol_new mic_mux =
 	SOC_DAPM_ENUM("MIC Mux", mic_enum);
-- 
1.8.5.2
