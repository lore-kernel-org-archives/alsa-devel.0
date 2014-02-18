From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 037/102] ASoC: max98090: Use
	SOC_ENUM_SINGLE_DECL()
Date: Tue, 18 Feb 2014 12:37:53 +0100
Message-ID: <1392723517-12772-10-git-send-email-tiwai@suse.de>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F1002655BF
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
 sound/soc/codecs/max98090.c | 172 +++++++++++++++++++++++++-------------------
 1 file changed, 97 insertions(+), 75 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 9f714ea86613..a75752fc91a1 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -513,65 +513,75 @@ static const char *max98090_perf_pwr_text[] =
 static const char *max98090_pwr_perf_text[] =
 	{ "Low Power", "High Performance" };
 
-static const struct soc_enum max98090_vcmbandgap_enum =
-	SOC_ENUM_SINGLE(M98090_REG_BIAS_CONTROL, M98090_VCM_MODE_SHIFT,
-		ARRAY_SIZE(max98090_pwr_perf_text), max98090_pwr_perf_text);
+static SOC_ENUM_SINGLE_DECL(max98090_vcmbandgap_enum,
+			    M98090_REG_BIAS_CONTROL,
+			    M98090_VCM_MODE_SHIFT,
+			    max98090_pwr_perf_text);
 
 static const char *max98090_osr128_text[] = { "64*fs", "128*fs" };
 
-static const struct soc_enum max98090_osr128_enum =
-	SOC_ENUM_SINGLE(M98090_REG_ADC_CONTROL, M98090_OSR128_SHIFT,
-		ARRAY_SIZE(max98090_osr128_text), max98090_osr128_text);
+static SOC_ENUM_SINGLE_DECL(max98090_osr128_enum,
+			    M98090_REG_ADC_CONTROL,
+			    M98090_OSR128_SHIFT,
+			    max98090_osr128_text);
 
 static const char *max98090_mode_text[] = { "Voice", "Music" };
 
-static const struct soc_enum max98090_mode_enum =
-	SOC_ENUM_SINGLE(M98090_REG_FILTER_CONFIG, M98090_MODE_SHIFT,
-		ARRAY_SIZE(max98090_mode_text), max98090_mode_text);
+static SOC_ENUM_SINGLE_DECL(max98090_mode_enum,
+			    M98090_REG_FILTER_CONFIG,
+			    M98090_MODE_SHIFT,
+			    max98090_mode_text);
 
-static const struct soc_enum max98090_filter_dmic34mode_enum =
-	SOC_ENUM_SINGLE(M98090_REG_FILTER_CONFIG,
-		M98090_FLT_DMIC34MODE_SHIFT,
-		ARRAY_SIZE(max98090_mode_text), max98090_mode_text);
+static SOC_ENUM_SINGLE_DECL(max98090_filter_dmic34mode_enum,
+			    M98090_REG_FILTER_CONFIG,
+			    M98090_FLT_DMIC34MODE_SHIFT,
+			    max98090_mode_text);
 
 static const char *max98090_drcatk_text[] =
 	{ "0.5ms", "1ms", "5ms", "10ms", "25ms", "50ms", "100ms", "200ms" };
 
-static const struct soc_enum max98090_drcatk_enum =
-	SOC_ENUM_SINGLE(M98090_REG_DRC_TIMING, M98090_DRCATK_SHIFT,
-		ARRAY_SIZE(max98090_drcatk_text), max98090_drcatk_text);
+static SOC_ENUM_SINGLE_DECL(max98090_drcatk_enum,
+			    M98090_REG_DRC_TIMING,
+			    M98090_DRCATK_SHIFT,
+			    max98090_drcatk_text);
 
 static const char *max98090_drcrls_text[] =
 	{ "8s", "4s", "2s", "1s", "0.5s", "0.25s", "0.125s", "0.0625s" };
 
-static const struct soc_enum max98090_drcrls_enum =
-	SOC_ENUM_SINGLE(M98090_REG_DRC_TIMING, M98090_DRCRLS_SHIFT,
-		ARRAY_SIZE(max98090_drcrls_text), max98090_drcrls_text);
+static SOC_ENUM_SINGLE_DECL(max98090_drcrls_enum,
+			    M98090_REG_DRC_TIMING,
+			    M98090_DRCRLS_SHIFT,
+			    max98090_drcrls_text);
 
 static const char *max98090_alccmp_text[] =
 	{ "1:1", "1:1.5", "1:2", "1:4", "1:INF" };
 
-static const struct soc_enum max98090_alccmp_enum =
-	SOC_ENUM_SINGLE(M98090_REG_DRC_COMPRESSOR, M98090_DRCCMP_SHIFT,
-		ARRAY_SIZE(max98090_alccmp_text), max98090_alccmp_text);
+static SOC_ENUM_SINGLE_DECL(max98090_alccmp_enum,
+			    M98090_REG_DRC_COMPRESSOR,
+			    M98090_DRCCMP_SHIFT,
+			    max98090_alccmp_text);
 
 static const char *max98090_drcexp_text[] = { "1:1", "2:1", "3:1" };
 
-static const struct soc_enum max98090_drcexp_enum =
-	SOC_ENUM_SINGLE(M98090_REG_DRC_EXPANDER, M98090_DRCEXP_SHIFT,
-		ARRAY_SIZE(max98090_drcexp_text), max98090_drcexp_text);
+static SOC_ENUM_SINGLE_DECL(max98090_drcexp_enum,
+			    M98090_REG_DRC_EXPANDER,
+			    M98090_DRCEXP_SHIFT,
+			    max98090_drcexp_text);
 
-static const struct soc_enum max98090_dac_perfmode_enum =
-	SOC_ENUM_SINGLE(M98090_REG_DAC_CONTROL, M98090_PERFMODE_SHIFT,
-		ARRAY_SIZE(max98090_perf_pwr_text), max98090_perf_pwr_text);
+static SOC_ENUM_SINGLE_DECL(max98090_dac_perfmode_enum,
+			    M98090_REG_DAC_CONTROL,
+			    M98090_PERFMODE_SHIFT,
+			    max98090_perf_pwr_text);
 
-static const struct soc_enum max98090_dachp_enum =
-	SOC_ENUM_SINGLE(M98090_REG_DAC_CONTROL, M98090_DACHP_SHIFT,
-		ARRAY_SIZE(max98090_pwr_perf_text), max98090_pwr_perf_text);
+static SOC_ENUM_SINGLE_DECL(max98090_dachp_enum,
+			    M98090_REG_DAC_CONTROL,
+			    M98090_DACHP_SHIFT,
+			    max98090_pwr_perf_text);
 
-static const struct soc_enum max98090_adchp_enum =
-	SOC_ENUM_SINGLE(M98090_REG_ADC_CONTROL, M98090_ADCHP_SHIFT,
-		ARRAY_SIZE(max98090_pwr_perf_text), max98090_pwr_perf_text);
+static SOC_ENUM_SINGLE_DECL(max98090_adchp_enum,
+			    M98090_REG_ADC_CONTROL,
+			    M98090_ADCHP_SHIFT,
+			    max98090_pwr_perf_text);
 
 static const struct snd_kcontrol_new max98090_snd_controls[] = {
 	SOC_ENUM("MIC Bias VCM Bandgap", max98090_vcmbandgap_enum),
@@ -842,39 +852,42 @@ static int max98090_micinput_event(struct snd_soc_dapm_widget *w,
 
 static const char *mic1_mux_text[] = { "IN12", "IN56" };
 
-static const struct soc_enum mic1_mux_enum =
-	SOC_ENUM_SINGLE(M98090_REG_INPUT_MODE, M98090_EXTMIC1_SHIFT,
-		ARRAY_SIZE(mic1_mux_text), mic1_mux_text);
+static SOC_ENUM_SINGLE_DECL(mic1_mux_enum,
+			    M98090_REG_INPUT_MODE,
+			    M98090_EXTMIC1_SHIFT,
+			    mic1_mux_text);
 
 static const struct snd_kcontrol_new max98090_mic1_mux =
 	SOC_DAPM_ENUM("MIC1 Mux", mic1_mux_enum);
 
 static const char *mic2_mux_text[] = { "IN34", "IN56" };
 
-static const struct soc_enum mic2_mux_enum =
-	SOC_ENUM_SINGLE(M98090_REG_INPUT_MODE, M98090_EXTMIC2_SHIFT,
-		ARRAY_SIZE(mic2_mux_text), mic2_mux_text);
+static SOC_ENUM_SINGLE_DECL(mic2_mux_enum,
+			    M98090_REG_INPUT_MODE,
+			    M98090_EXTMIC2_SHIFT,
+			    mic2_mux_text);
 
 static const struct snd_kcontrol_new max98090_mic2_mux =
 	SOC_DAPM_ENUM("MIC2 Mux", mic2_mux_enum);
 
 static const char *dmic_mux_text[] = { "ADC", "DMIC" };
 
-static const struct soc_enum dmic_mux_enum =
-	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(dmic_mux_text), dmic_mux_text);
+static SOC_ENUM_SINGLE_EXT_DECL(dmic_mux_enum, dmic_mux_text);
 
 static const struct snd_kcontrol_new max98090_dmic_mux =
 	SOC_DAPM_ENUM_VIRT("DMIC Mux", dmic_mux_enum);
 
 static const char *max98090_micpre_text[] = { "Off", "On" };
 
-static const struct soc_enum max98090_pa1en_enum =
-	SOC_ENUM_SINGLE(M98090_REG_MIC1_INPUT_LEVEL, M98090_MIC_PA1EN_SHIFT,
-		ARRAY_SIZE(max98090_micpre_text), max98090_micpre_text);
+static SOC_ENUM_SINGLE_DECL(max98090_pa1en_enum,
+			    M98090_REG_MIC1_INPUT_LEVEL,
+			    M98090_MIC_PA1EN_SHIFT,
+			    max98090_micpre_text);
 
-static const struct soc_enum max98090_pa2en_enum =
-	SOC_ENUM_SINGLE(M98090_REG_MIC2_INPUT_LEVEL, M98090_MIC_PA2EN_SHIFT,
-		ARRAY_SIZE(max98090_micpre_text), max98090_micpre_text);
+static SOC_ENUM_SINGLE_DECL(max98090_pa2en_enum,
+			    M98090_REG_MIC2_INPUT_LEVEL,
+			    M98090_MIC_PA2EN_SHIFT,
+			    max98090_micpre_text);
 
 /* LINEA mixer switch */
 static const struct snd_kcontrol_new max98090_linea_mixer_controls[] = {
@@ -938,13 +951,15 @@ static const struct snd_kcontrol_new max98090_right_adc_mixer_controls[] = {
 
 static const char *lten_mux_text[] = { "Normal", "Loopthrough" };
 
-static const struct soc_enum ltenl_mux_enum =
-	SOC_ENUM_SINGLE(M98090_REG_IO_CONFIGURATION, M98090_LTEN_SHIFT,
-		ARRAY_SIZE(lten_mux_text), lten_mux_text);
+static SOC_ENUM_SINGLE_DECL(ltenl_mux_enum,
+			    M98090_REG_IO_CONFIGURATION,
+			    M98090_LTEN_SHIFT,
+			    lten_mux_text);
 
-static const struct soc_enum ltenr_mux_enum =
-	SOC_ENUM_SINGLE(M98090_REG_IO_CONFIGURATION, M98090_LTEN_SHIFT,
-		ARRAY_SIZE(lten_mux_text), lten_mux_text);
+static SOC_ENUM_SINGLE_DECL(ltenr_mux_enum,
+			    M98090_REG_IO_CONFIGURATION,
+			    M98090_LTEN_SHIFT,
+			    lten_mux_text);
 
 static const struct snd_kcontrol_new max98090_ltenl_mux =
 	SOC_DAPM_ENUM("LTENL Mux", ltenl_mux_enum);
@@ -954,13 +969,15 @@ static const struct snd_kcontrol_new max98090_ltenr_mux =
 
 static const char *lben_mux_text[] = { "Normal", "Loopback" };
 
-static const struct soc_enum lbenl_mux_enum =
-	SOC_ENUM_SINGLE(M98090_REG_IO_CONFIGURATION, M98090_LBEN_SHIFT,
-		ARRAY_SIZE(lben_mux_text), lben_mux_text);
+static SOC_ENUM_SINGLE_DECL(lbenl_mux_enum,
+			    M98090_REG_IO_CONFIGURATION,
+			    M98090_LBEN_SHIFT,
+			    lben_mux_text);
 
-static const struct soc_enum lbenr_mux_enum =
-	SOC_ENUM_SINGLE(M98090_REG_IO_CONFIGURATION, M98090_LBEN_SHIFT,
-		ARRAY_SIZE(lben_mux_text), lben_mux_text);
+static SOC_ENUM_SINGLE_DECL(lbenr_mux_enum,
+			    M98090_REG_IO_CONFIGURATION,
+			    M98090_LBEN_SHIFT,
+			    lben_mux_text);
 
 static const struct snd_kcontrol_new max98090_lbenl_mux =
 	SOC_DAPM_ENUM("LBENL Mux", lbenl_mux_enum);
@@ -972,13 +989,15 @@ static const char *stenl_mux_text[] = { "Normal", "Sidetone Left" };
 
 static const char *stenr_mux_text[] = { "Normal", "Sidetone Right" };
 
-static const struct soc_enum stenl_mux_enum =
-	SOC_ENUM_SINGLE(M98090_REG_ADC_SIDETONE, M98090_DSTSL_SHIFT,
-		ARRAY_SIZE(stenl_mux_text), stenl_mux_text);
+static SOC_ENUM_SINGLE_DECL(stenl_mux_enum,
+			    M98090_REG_ADC_SIDETONE,
+			    M98090_DSTSL_SHIFT,
+			    stenl_mux_text);
 
-static const struct soc_enum stenr_mux_enum =
-	SOC_ENUM_SINGLE(M98090_REG_ADC_SIDETONE, M98090_DSTSR_SHIFT,
-		ARRAY_SIZE(stenr_mux_text), stenr_mux_text);
+static SOC_ENUM_SINGLE_DECL(stenr_mux_enum,
+			    M98090_REG_ADC_SIDETONE,
+			    M98090_DSTSR_SHIFT,
+			    stenr_mux_text);
 
 static const struct snd_kcontrol_new max98090_stenl_mux =
 	SOC_DAPM_ENUM("STENL Mux", stenl_mux_enum);
@@ -1086,9 +1105,10 @@ static const struct snd_kcontrol_new max98090_right_rcv_mixer_controls[] = {
 
 static const char *linmod_mux_text[] = { "Left Only", "Left and Right" };
 
-static const struct soc_enum linmod_mux_enum =
-	SOC_ENUM_SINGLE(M98090_REG_LOUTR_MIXER, M98090_LINMOD_SHIFT,
-		ARRAY_SIZE(linmod_mux_text), linmod_mux_text);
+static SOC_ENUM_SINGLE_DECL(linmod_mux_enum,
+			    M98090_REG_LOUTR_MIXER,
+			    M98090_LINMOD_SHIFT,
+			    linmod_mux_text);
 
 static const struct snd_kcontrol_new max98090_linmod_mux =
 	SOC_DAPM_ENUM("LINMOD Mux", linmod_mux_enum);
@@ -1098,16 +1118,18 @@ static const char *mixhpsel_mux_text[] = { "DAC Only", "HP Mixer" };
 /*
  * This is a mux as it selects the HP output, but to DAPM it is a Mixer enable
  */
-static const struct soc_enum mixhplsel_mux_enum =
-	SOC_ENUM_SINGLE(M98090_REG_HP_CONTROL, M98090_MIXHPLSEL_SHIFT,
-		ARRAY_SIZE(mixhpsel_mux_text), mixhpsel_mux_text);
+static SOC_ENUM_SINGLE_DECL(mixhplsel_mux_enum,
+			    M98090_REG_HP_CONTROL,
+			    M98090_MIXHPLSEL_SHIFT,
+			    mixhpsel_mux_text);
 
 static const struct snd_kcontrol_new max98090_mixhplsel_mux =
 	SOC_DAPM_ENUM("MIXHPLSEL Mux", mixhplsel_mux_enum);
 
-static const struct soc_enum mixhprsel_mux_enum =
-	SOC_ENUM_SINGLE(M98090_REG_HP_CONTROL, M98090_MIXHPRSEL_SHIFT,
-		ARRAY_SIZE(mixhpsel_mux_text), mixhpsel_mux_text);
+static SOC_ENUM_SINGLE_DECL(mixhprsel_mux_enum,
+			    M98090_REG_HP_CONTROL,
+			    M98090_MIXHPRSEL_SHIFT,
+			    mixhpsel_mux_text);
 
 static const struct snd_kcontrol_new max98090_mixhprsel_mux =
 	SOC_DAPM_ENUM("MIXHPRSEL Mux", mixhprsel_mux_enum);
-- 
1.8.5.2
