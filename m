From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH] ASoC: arizona: Fixup some minor formatting
	issues
Date: Tue, 20 Feb 2018 16:08:11 +0000
Message-ID: <20180220160811.6172-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 39B46267502
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 17:08:15 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

Repair any formatting/style issues that can be fixed without major
code refactoring.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/arizona.c | 59 ++++++++++++++++++++++++-------------------
 sound/soc/codecs/cs47l24.c | 22 ++++++++--------
 sound/soc/codecs/wm5102.c  | 20 +++++++--------
 sound/soc/codecs/wm5110.c  | 62 +++++++++++++++++++++++++---------------------
 sound/soc/codecs/wm8997.c  | 14 +++++------
 sound/soc/codecs/wm8998.c  | 33 +++++++++++++-----------
 6 files changed, 113 insertions(+), 97 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index ffcfe8ea1848..5727ea079ad7 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -90,7 +90,8 @@ static int arizona_spk_ev(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-		val = snd_soc_component_read32(component, ARIZONA_INTERRUPT_RAW_STATUS_3);
+		val = snd_soc_component_read32(component,
+					       ARIZONA_INTERRUPT_RAW_STATUS_3);
 		if (val & ARIZONA_SPK_OVERHEAT_STS) {
 			dev_crit(arizona->dev,
 				 "Speaker not enabled due to temperature\n");
@@ -641,7 +642,6 @@ const unsigned int arizona_rate_val[ARIZONA_RATE_ENUM_SIZE] = {
 };
 EXPORT_SYMBOL_GPL(arizona_rate_val);
 
-
 const struct soc_enum arizona_isrc_fsh[] = {
 	SOC_VALUE_ENUM_SINGLE(ARIZONA_ISRC_1_CTRL_1,
 			      ARIZONA_ISRC1_FSH_SHIFT, 0xf,
@@ -923,7 +923,8 @@ int arizona_in_ev(struct snd_soc_dapm_widget *w, struct snd_kcontrol *kcontrol,
 		priv->in_pending++;
 		break;
 	case SND_SOC_DAPM_POST_PMU:
-		snd_soc_component_update_bits(component, reg, ARIZONA_IN1L_MUTE, 0);
+		snd_soc_component_update_bits(component, reg,
+					      ARIZONA_IN1L_MUTE, 0);
 
 		/* If this is the last input pending then allow VU */
 		priv->in_pending--;
@@ -1070,9 +1071,8 @@ int arizona_out_ev(struct snd_soc_dapm_widget *w,
 }
 EXPORT_SYMBOL_GPL(arizona_out_ev);
 
-int arizona_hp_ev(struct snd_soc_dapm_widget *w,
-		   struct snd_kcontrol *kcontrol,
-		   int event)
+int arizona_hp_ev(struct snd_soc_dapm_widget *w, struct snd_kcontrol *kcontrol,
+		  int event)
 {
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	struct arizona_priv *priv = snd_soc_component_get_drvdata(component);
@@ -1275,8 +1275,8 @@ static unsigned int arizona_opclk_ref_44k1_rates[] = {
 	45158400,
 };
 
-static int arizona_set_opclk(struct snd_soc_component *component, unsigned int clk,
-			     unsigned int freq)
+static int arizona_set_opclk(struct snd_soc_component *component,
+			     unsigned int clk, unsigned int freq)
 {
 	struct arizona_priv *priv = snd_soc_component_get_drvdata(component);
 	unsigned int reg;
@@ -1302,7 +1302,7 @@ static int arizona_set_opclk(struct snd_soc_component *component, unsigned int c
 		rates = arizona_opclk_ref_48k_rates;
 
 	for (ref = 0; ref < ARRAY_SIZE(arizona_opclk_ref_48k_rates) &&
-		     rates[ref] <= refclk; ref++) {
+	     rates[ref] <= refclk; ref++) {
 		div = 1;
 		while (rates[ref] / div >= freq && div < 32) {
 			if (rates[ref] / div == freq) {
@@ -1727,18 +1727,23 @@ static int arizona_hw_params_rate(struct snd_pcm_substream *substream,
 		}
 
 		snd_soc_component_update_bits(component, ARIZONA_SAMPLE_RATE_1,
-				    ARIZONA_SAMPLE_RATE_1_MASK, sr_val);
+					      ARIZONA_SAMPLE_RATE_1_MASK,
+					      sr_val);
 		if (base)
-			snd_soc_component_update_bits(component, base + ARIZONA_AIF_RATE_CTRL,
-					    ARIZONA_AIF1_RATE_MASK, 0);
+			snd_soc_component_update_bits(component,
+					base + ARIZONA_AIF_RATE_CTRL,
+					ARIZONA_AIF1_RATE_MASK, 0);
 		break;
 	case ARIZONA_CLK_ASYNCCLK:
-		snd_soc_component_update_bits(component, ARIZONA_ASYNC_SAMPLE_RATE_1,
-				    ARIZONA_ASYNC_SAMPLE_RATE_1_MASK, sr_val);
+		snd_soc_component_update_bits(component,
+					      ARIZONA_ASYNC_SAMPLE_RATE_1,
+					      ARIZONA_ASYNC_SAMPLE_RATE_1_MASK,
+					      sr_val);
 		if (base)
-			snd_soc_component_update_bits(component, base + ARIZONA_AIF_RATE_CTRL,
-					    ARIZONA_AIF1_RATE_MASK,
-					    8 << ARIZONA_AIF1_RATE_SHIFT);
+			snd_soc_component_update_bits(component,
+					base + ARIZONA_AIF_RATE_CTRL,
+					ARIZONA_AIF1_RATE_MASK,
+					8 << ARIZONA_AIF1_RATE_SHIFT);
 		break;
 	default:
 		arizona_aif_err(dai, "Invalid clock %d\n", dai_priv->clk);
@@ -1849,9 +1854,10 @@ static int arizona_hw_params(struct snd_pcm_substream *substream,
 					    base + ARIZONA_AIF_RX_ENABLES);
 		/* Disable AIF TX/RX before reconfiguring it */
 		regmap_update_bits_async(arizona->regmap,
-				    base + ARIZONA_AIF_TX_ENABLES, 0xff, 0x0);
+					 base + ARIZONA_AIF_TX_ENABLES,
+					 0xff, 0x0);
 		regmap_update_bits(arizona->regmap,
-				    base + ARIZONA_AIF_RX_ENABLES, 0xff, 0x0);
+				   base + ARIZONA_AIF_RX_ENABLES, 0xff, 0x0);
 	}
 
 	ret = arizona_hw_params_rate(substream, params, dai);
@@ -1960,8 +1966,9 @@ static int arizona_set_tristate(struct snd_soc_dai *dai, int tristate)
 	else
 		reg = 0;
 
-	return snd_soc_component_update_bits(component, base + ARIZONA_AIF_RATE_CTRL,
-				   ARIZONA_AIF1_TRI, reg);
+	return snd_soc_component_update_bits(component,
+					     base + ARIZONA_AIF_RATE_CTRL,
+					     ARIZONA_AIF1_TRI, reg);
 }
 
 static void arizona_set_channels_to_mask(struct snd_soc_dai *dai,
@@ -2319,7 +2326,6 @@ static int arizona_calc_fll(struct arizona_fll *fll,
 	arizona_fll_dbg(fll, "GAIN=0x%x(%d)\n", cfg->gain, 1 << cfg->gain);
 
 	return 0;
-
 }
 
 static void arizona_apply_fll(struct arizona *arizona, unsigned int base,
@@ -2565,9 +2571,8 @@ int arizona_set_fll_refclk(struct arizona_fll *fll, int source,
 	fll->ref_src = source;
 	fll->ref_freq = Fref;
 
-	if (fll->fout && Fref > 0) {
+	if (fll->fout && Fref > 0)
 		ret = arizona_enable_fll(fll);
-	}
 
 	return ret;
 }
@@ -2656,7 +2661,8 @@ EXPORT_SYMBOL_GPL(arizona_init_fll);
  * Most systems have a single static configuration and should use
  * platform data instead.
  */
-int arizona_set_output_mode(struct snd_soc_component *component, int output, bool diff)
+int arizona_set_output_mode(struct snd_soc_component *component, int output,
+			    bool diff)
 {
 	unsigned int reg, val;
 
@@ -2670,7 +2676,8 @@ int arizona_set_output_mode(struct snd_soc_component *component, int output, boo
 	else
 		val = 0;
 
-	return snd_soc_component_update_bits(component, reg, ARIZONA_OUT1_MONO, val);
+	return snd_soc_component_update_bits(component, reg,
+					     ARIZONA_OUT1_MONO, val);
 }
 EXPORT_SYMBOL_GPL(arizona_set_output_mode);
 
diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index c93d3f7e8e36..196e9c343aeb 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -196,14 +196,13 @@ SOC_SINGLE("HPOUT1 SC Protect Switch", ARIZONA_HP1_SHORT_CIRCUIT_CTRL,
 SOC_DOUBLE_R("HPOUT1 Digital Switch", ARIZONA_DAC_DIGITAL_VOLUME_1L,
 	     ARIZONA_DAC_DIGITAL_VOLUME_1R, ARIZONA_OUT1L_MUTE_SHIFT, 1, 1),
 SOC_SINGLE("Speaker Digital Switch", ARIZONA_DAC_DIGITAL_VOLUME_4L,
-	     ARIZONA_OUT4L_MUTE_SHIFT, 1, 1),
+	   ARIZONA_OUT4L_MUTE_SHIFT, 1, 1),
 
 SOC_DOUBLE_R_TLV("HPOUT1 Digital Volume", ARIZONA_DAC_DIGITAL_VOLUME_1L,
 		 ARIZONA_DAC_DIGITAL_VOLUME_1R, ARIZONA_OUT1L_VOL_SHIFT,
 		 0xbf, 0, digital_tlv),
 SOC_SINGLE_TLV("Speaker Digital Volume", ARIZONA_DAC_DIGITAL_VOLUME_4L,
-		 ARIZONA_OUT4L_VOL_SHIFT,
-		 0xbf, 0, digital_tlv),
+	       ARIZONA_OUT4L_VOL_SHIFT, 0xbf, 0, digital_tlv),
 
 SOC_ENUM("Output Ramp Up", arizona_out_vi_ramp),
 SOC_ENUM("Output Ramp Down", arizona_out_vd_ramp),
@@ -494,8 +493,7 @@ SND_SOC_DAPM_PGA("ISRC3DEC4", ARIZONA_ISRC_3_CTRL_3,
 		 ARIZONA_ISRC3_DEC3_ENA_SHIFT, 0, NULL, 0),
 
 SND_SOC_DAPM_MUX("AEC Loopback", ARIZONA_DAC_AEC_CONTROL_1,
-		       ARIZONA_AEC_LOOPBACK_ENA_SHIFT, 0,
-		       &cs47l24_aec_loopback_mux),
+		 ARIZONA_AEC_LOOPBACK_ENA_SHIFT, 0, &cs47l24_aec_loopback_mux),
 
 SND_SOC_DAPM_AIF_OUT("AIF1TX1", NULL, 0,
 		     ARIZONA_AIF1_TX_ENABLES, ARIZONA_AIF1TX1_ENA_SHIFT, 0),
@@ -931,8 +929,8 @@ static const struct snd_soc_dapm_route cs47l24_dapm_routes[] = {
 	{ "DSP3 Voice Trigger", "Switch", "DSP3" },
 };
 
-static int cs47l24_set_fll(struct snd_soc_component *component, int fll_id, int source,
-			  unsigned int Fref, unsigned int Fout)
+static int cs47l24_set_fll(struct snd_soc_component *component, int fll_id,
+			   int source, unsigned int Fref, unsigned int Fout)
 {
 	struct cs47l24_priv *cs47l24 = snd_soc_component_get_drvdata(component);
 
@@ -1144,7 +1142,8 @@ static int cs47l24_component_probe(struct snd_soc_component *component)
 		goto err_adsp2_codec_probe;
 
 	ret = snd_soc_add_component_controls(component,
-					 &arizona_adsp2_rate_controls[1], 2);
+					     &arizona_adsp2_rate_controls[1],
+					     2);
 	if (ret)
 		goto err_adsp2_codec_probe;
 
@@ -1214,7 +1213,7 @@ static int cs47l24_probe(struct platform_device *pdev)
 	BUILD_BUG_ON(ARRAY_SIZE(cs47l24_dai) > ARIZONA_MAX_DAI);
 
 	cs47l24 = devm_kzalloc(&pdev->dev, sizeof(struct cs47l24_priv),
-			      GFP_KERNEL);
+			       GFP_KERNEL);
 	if (!cs47l24)
 		return -ENOMEM;
 
@@ -1294,8 +1293,9 @@ static int cs47l24_probe(struct platform_device *pdev)
 		goto err_dsp_irq;
 
 	ret = devm_snd_soc_register_component(&pdev->dev,
-				      &soc_component_dev_cs47l24,
-				      cs47l24_dai, ARRAY_SIZE(cs47l24_dai));
+					      &soc_component_dev_cs47l24,
+					      cs47l24_dai,
+					      ARRAY_SIZE(cs47l24_dai));
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register component: %d\n", ret);
 		goto err_spk_irqs;
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 24f19cfc98f5..1ac83388d1b8 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -620,7 +620,7 @@ static int wm5102_sysclk_ev(struct snd_soc_dapm_widget *w,
 }
 
 static int wm5102_adsp_power_ev(struct snd_soc_dapm_widget *w,
-		   struct snd_kcontrol *kcontrol, int event)
+				struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	struct arizona *arizona = dev_get_drvdata(component->dev->parent);
@@ -717,7 +717,7 @@ static int wm5102_out_comp_switch_put(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static const char *wm5102_osr_text[] = {
+static const char * const wm5102_osr_text[] = {
 	"Low power", "Normal", "High performance",
 };
 
@@ -1062,7 +1062,7 @@ ARIZONA_MIXER_ENUMS(DSP1R, ARIZONA_DSP1RMIX_INPUT_1_SOURCE);
 
 ARIZONA_DSP_AUX_ENUMS(DSP1, ARIZONA_DSP1AUX1MIX_INPUT_1_SOURCE);
 
-static const char *wm5102_aec_loopback_texts[] = {
+static const char * const wm5102_aec_loopback_texts[] = {
 	"HPOUT1L", "HPOUT1R", "HPOUT2L", "HPOUT2R", "EPOUT",
 	"SPKOUTL", "SPKOUTR", "SPKDAT1L", "SPKDAT1R",
 };
@@ -1317,8 +1317,7 @@ SND_SOC_DAPM_AIF_IN("SLIMRX8", NULL, 0,
 ARIZONA_DSP_WIDGETS(DSP1, "DSP1"),
 
 SND_SOC_DAPM_MUX("AEC Loopback", ARIZONA_DAC_AEC_CONTROL_1,
-		       ARIZONA_AEC_LOOPBACK_ENA_SHIFT, 0,
-		       &wm5102_aec_loopback_mux),
+		 ARIZONA_AEC_LOOPBACK_ENA_SHIFT, 0, &wm5102_aec_loopback_mux),
 
 SND_SOC_DAPM_PGA_E("OUT1L", SND_SOC_NOPM,
 		   ARIZONA_OUT1L_ENA_SHIFT, 0, NULL, 0, arizona_hp_ev,
@@ -1736,8 +1735,8 @@ static const struct snd_soc_dapm_route wm5102_dapm_routes[] = {
 	{ "DRC1 Signal Activity", NULL, "DRC1R" },
 };
 
-static int wm5102_set_fll(struct snd_soc_component *component, int fll_id, int source,
-			  unsigned int Fref, unsigned int Fout)
+static int wm5102_set_fll(struct snd_soc_component *component, int fll_id,
+			  int source, unsigned int Fref, unsigned int Fout)
 {
 	struct wm5102_priv *wm5102 = snd_soc_component_get_drvdata(component);
 
@@ -1947,7 +1946,7 @@ static int wm5102_component_probe(struct snd_soc_component *component)
 		return ret;
 
 	ret = snd_soc_add_component_controls(component,
-					 arizona_adsp2_rate_controls, 1);
+					     arizona_adsp2_rate_controls, 1);
 	if (ret)
 		goto err_adsp2_codec_probe;
 
@@ -2105,8 +2104,9 @@ static int wm5102_probe(struct platform_device *pdev)
 		goto err_dsp_irq;
 
 	ret = devm_snd_soc_register_component(&pdev->dev,
-				      &soc_component_dev_wm5102,
-				      wm5102_dai, ARRAY_SIZE(wm5102_dai));
+					      &soc_component_dev_wm5102,
+					      wm5102_dai,
+					      ARRAY_SIZE(wm5102_dai));
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register component: %d\n", ret);
 		goto err_spk_irqs;
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index b33cbd0161d3..fb9835dcd836 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -332,19 +332,25 @@ static int wm5110_hp_pre_disable(struct snd_soc_dapm_widget *w)
 	switch (w->shift) {
 	case ARIZONA_OUT1L_ENA_SHIFT:
 		if (!(val & ARIZONA_DRE1L_ENA_MASK)) {
-			snd_soc_component_update_bits(component, ARIZONA_SPARE_TRIGGERS,
-					    ARIZONA_WS_TRG1, ARIZONA_WS_TRG1);
-			snd_soc_component_update_bits(component, ARIZONA_SPARE_TRIGGERS,
-					    ARIZONA_WS_TRG1, 0);
+			snd_soc_component_update_bits(component,
+						      ARIZONA_SPARE_TRIGGERS,
+						      ARIZONA_WS_TRG1,
+						      ARIZONA_WS_TRG1);
+			snd_soc_component_update_bits(component,
+						      ARIZONA_SPARE_TRIGGERS,
+						      ARIZONA_WS_TRG1, 0);
 			priv->out_down_delay += 27;
 		}
 		break;
 	case ARIZONA_OUT1R_ENA_SHIFT:
 		if (!(val & ARIZONA_DRE1R_ENA_MASK)) {
-			snd_soc_component_update_bits(component, ARIZONA_SPARE_TRIGGERS,
-					    ARIZONA_WS_TRG2, ARIZONA_WS_TRG2);
-			snd_soc_component_update_bits(component, ARIZONA_SPARE_TRIGGERS,
-					    ARIZONA_WS_TRG2, 0);
+			snd_soc_component_update_bits(component,
+						      ARIZONA_SPARE_TRIGGERS,
+						      ARIZONA_WS_TRG2,
+						      ARIZONA_WS_TRG2);
+			snd_soc_component_update_bits(component,
+						      ARIZONA_SPARE_TRIGGERS,
+						      ARIZONA_WS_TRG2, 0);
 			priv->out_down_delay += 27;
 		}
 		break;
@@ -539,7 +545,7 @@ static int wm5110_in_analog_ev(struct snd_soc_dapm_widget *w,
 		break;
 	case SND_SOC_DAPM_POST_PMU:
 		snd_soc_component_update_bits(component, reg, mask,
-				    wm5110->in_pga_cache[w->shift]);
+					      wm5110->in_pga_cache[w->shift]);
 
 		wm5110->in_post_pending--;
 		if (wm5110->in_post_pending == 0)
@@ -863,14 +869,14 @@ SOC_DOUBLE("SPKDAT2 Switch", ARIZONA_PDM_SPK2_CTRL_1, ARIZONA_SPK2L_MUTE_SHIFT,
 	   ARIZONA_SPK2R_MUTE_SHIFT, 1, 1),
 
 SOC_DOUBLE_EXT("HPOUT1 DRE Switch", ARIZONA_DRE_ENABLE,
-	   ARIZONA_DRE1L_ENA_SHIFT, ARIZONA_DRE1R_ENA_SHIFT, 1, 0,
-	   snd_soc_get_volsw, wm5110_put_dre),
+	       ARIZONA_DRE1L_ENA_SHIFT, ARIZONA_DRE1R_ENA_SHIFT, 1, 0,
+	       snd_soc_get_volsw, wm5110_put_dre),
 SOC_DOUBLE_EXT("HPOUT2 DRE Switch", ARIZONA_DRE_ENABLE,
-	   ARIZONA_DRE2L_ENA_SHIFT, ARIZONA_DRE2R_ENA_SHIFT, 1, 0,
-	   snd_soc_get_volsw, wm5110_put_dre),
+	       ARIZONA_DRE2L_ENA_SHIFT, ARIZONA_DRE2R_ENA_SHIFT, 1, 0,
+	       snd_soc_get_volsw, wm5110_put_dre),
 SOC_DOUBLE_EXT("HPOUT3 DRE Switch", ARIZONA_DRE_ENABLE,
-	   ARIZONA_DRE3L_ENA_SHIFT, ARIZONA_DRE3R_ENA_SHIFT, 1, 0,
-	   snd_soc_get_volsw, wm5110_put_dre),
+	       ARIZONA_DRE3L_ENA_SHIFT, ARIZONA_DRE3R_ENA_SHIFT, 1, 0,
+	       snd_soc_get_volsw, wm5110_put_dre),
 
 SOC_ENUM("Output Ramp Up", arizona_out_vi_ramp),
 SOC_ENUM("Output Ramp Down", arizona_out_vd_ramp),
@@ -1036,7 +1042,7 @@ ARIZONA_MUX_ENUMS(ISRC3DEC2, ARIZONA_ISRC3DEC2MIX_INPUT_1_SOURCE);
 ARIZONA_MUX_ENUMS(ISRC3DEC3, ARIZONA_ISRC3DEC3MIX_INPUT_1_SOURCE);
 ARIZONA_MUX_ENUMS(ISRC3DEC4, ARIZONA_ISRC3DEC4MIX_INPUT_1_SOURCE);
 
-static const char *wm5110_aec_loopback_texts[] = {
+static const char * const wm5110_aec_loopback_texts[] = {
 	"HPOUT1L", "HPOUT1R", "HPOUT2L", "HPOUT2R", "HPOUT3L", "HPOUT3R",
 	"SPKOUTL", "SPKOUTR", "SPKDAT1L", "SPKDAT1R", "SPKDAT2L", "SPKDAT2R",
 };
@@ -1274,18 +1280,17 @@ SND_SOC_DAPM_PGA("ISRC3DEC4", ARIZONA_ISRC_3_CTRL_3,
 		 ARIZONA_ISRC3_DEC3_ENA_SHIFT, 0, NULL, 0),
 
 SND_SOC_DAPM_MUX("AEC Loopback", ARIZONA_DAC_AEC_CONTROL_1,
-		       ARIZONA_AEC_LOOPBACK_ENA_SHIFT, 0,
-		       &wm5110_aec_loopback_mux),
+		 ARIZONA_AEC_LOOPBACK_ENA_SHIFT, 0, &wm5110_aec_loopback_mux),
 
 SND_SOC_DAPM_SUPPLY("RXANC NG External Clock", SND_SOC_NOPM,
-		   ARIZONA_EXT_NG_SEL_SET_SHIFT, 0, arizona_anc_ev,
-		   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+		    ARIZONA_EXT_NG_SEL_SET_SHIFT, 0, arizona_anc_ev,
+		    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 SND_SOC_DAPM_PGA("RXANCL NG External", SND_SOC_NOPM, 0, 0, NULL, 0),
 SND_SOC_DAPM_PGA("RXANCR NG External", SND_SOC_NOPM, 0, 0, NULL, 0),
 
 SND_SOC_DAPM_SUPPLY("RXANC NG Clock", SND_SOC_NOPM,
-		   ARIZONA_CLK_NG_ENA_SET_SHIFT, 0, arizona_anc_ev,
-		   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+		    ARIZONA_CLK_NG_ENA_SET_SHIFT, 0, arizona_anc_ev,
+		    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 SND_SOC_DAPM_PGA("RXANCL NG Internal", SND_SOC_NOPM, 0, 0, NULL, 0),
 SND_SOC_DAPM_PGA("RXANCR NG Internal", SND_SOC_NOPM, 0, 0, NULL, 0),
 
@@ -2034,8 +2039,8 @@ static const struct snd_soc_dapm_route wm5110_dapm_routes[] = {
 	{ "DSP3 Voice Trigger", "Switch", "DSP3" },
 };
 
-static int wm5110_set_fll(struct snd_soc_component *component, int fll_id, int source,
-			  unsigned int Fref, unsigned int Fout)
+static int wm5110_set_fll(struct snd_soc_component *component, int fll_id,
+			  int source, unsigned int Fref, unsigned int Fout)
 {
 	struct wm5110_priv *wm5110 = snd_soc_component_get_drvdata(component);
 
@@ -2302,8 +2307,8 @@ static int wm5110_component_probe(struct snd_soc_component *component)
 	}
 
 	ret = snd_soc_add_component_controls(component,
-					 arizona_adsp2_rate_controls,
-					 WM5110_NUM_ADSP);
+					     arizona_adsp2_rate_controls,
+					     WM5110_NUM_ADSP);
 	if (ret)
 		goto err_adsp2_codec_probe;
 
@@ -2460,8 +2465,9 @@ static int wm5110_probe(struct platform_device *pdev)
 		goto err_dsp_irq;
 
 	ret = devm_snd_soc_register_component(&pdev->dev,
-				      &soc_component_dev_wm5110,
-				      wm5110_dai, ARRAY_SIZE(wm5110_dai));
+					      &soc_component_dev_wm5110,
+					      wm5110_dai,
+					      ARRAY_SIZE(wm5110_dai));
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register component: %d\n", ret);
 		goto err_spk_irqs;
diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index 45ee1e6bf715..df5b36b8fc5a 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -118,7 +118,7 @@ static int wm8997_sysclk_ev(struct snd_soc_dapm_widget *w,
 	return arizona_dvfs_sysclk_ev(w, kcontrol, event);
 }
 
-static const char *wm8997_osr_text[] = {
+static const char * const wm8997_osr_text[] = {
 	"Low power", "Normal", "High performance",
 };
 
@@ -609,8 +609,7 @@ SND_SOC_DAPM_AIF_IN("SLIMRX8", NULL, 0,
 		    ARIZONA_SLIMRX8_ENA_SHIFT, 0),
 
 SND_SOC_DAPM_MUX("AEC Loopback", ARIZONA_DAC_AEC_CONTROL_1,
-		       ARIZONA_AEC_LOOPBACK_ENA_SHIFT, 0,
-		       &wm8997_aec_loopback_mux),
+		 ARIZONA_AEC_LOOPBACK_ENA_SHIFT, 0, &wm8997_aec_loopback_mux),
 
 SND_SOC_DAPM_PGA_E("OUT1L", SND_SOC_NOPM,
 		   ARIZONA_OUT1L_ENA_SHIFT, 0, NULL, 0, arizona_hp_ev,
@@ -927,8 +926,8 @@ static const struct snd_soc_dapm_route wm8997_dapm_routes[] = {
 	{ "MICSUPP", NULL, "SYSCLK" },
 };
 
-static int wm8997_set_fll(struct snd_soc_component *component, int fll_id, int source,
-			  unsigned int Fref, unsigned int Fout)
+static int wm8997_set_fll(struct snd_soc_component *component, int fll_id,
+			  int source, unsigned int Fref, unsigned int Fout)
 {
 	struct wm8997_priv *wm8997 = snd_soc_component_get_drvdata(component);
 
@@ -1173,8 +1172,9 @@ static int wm8997_probe(struct platform_device *pdev)
 		return ret;
 
 	ret = devm_snd_soc_register_component(&pdev->dev,
-				     &soc_component_dev_wm8997,
-				     wm8997_dai, ARRAY_SIZE(wm8997_dai));
+					      &soc_component_dev_wm8997,
+					      wm8997_dai,
+					      ARRAY_SIZE(wm8997_dai));
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register component: %d\n", ret);
 		goto err_spk_irqs;
diff --git a/sound/soc/codecs/wm8998.c b/sound/soc/codecs/wm8998.c
index 6f3fdd7b095e..61294c787f27 100644
--- a/sound/soc/codecs/wm8998.c
+++ b/sound/soc/codecs/wm8998.c
@@ -137,11 +137,13 @@ static int wm8998_inmux_put(struct snd_kcontrol *kcontrol,
 	if (inmode & ARIZONA_INMODE_SE)
 		src_val |= 1 << ARIZONA_IN1L_SRC_SE_SHIFT;
 
-	snd_soc_component_update_bits(component, mode_reg, ARIZONA_IN1_MODE_MASK, mode_val);
+	snd_soc_component_update_bits(component, mode_reg,
+				      ARIZONA_IN1_MODE_MASK, mode_val);
 
 	snd_soc_component_update_bits(component, e->reg,
-			    ARIZONA_IN1L_SRC_MASK | ARIZONA_IN1L_SRC_SE_MASK,
-			    src_val);
+				      ARIZONA_IN1L_SRC_MASK |
+				      ARIZONA_IN1L_SRC_SE_MASK,
+				      src_val);
 
 	return snd_soc_dapm_mux_update_power(dapm, kcontrol,
 					     ucontrol->value.enumerated.item[0],
@@ -322,7 +324,7 @@ SOC_DOUBLE_R("HPOUT Digital Switch", ARIZONA_DAC_DIGITAL_VOLUME_1L,
 SOC_DOUBLE_R("LINEOUT Digital Switch", ARIZONA_DAC_DIGITAL_VOLUME_2L,
 	     ARIZONA_DAC_DIGITAL_VOLUME_2R, ARIZONA_OUT2L_MUTE_SHIFT, 1, 1),
 SOC_SINGLE("EPOUT Digital Switch", ARIZONA_DAC_DIGITAL_VOLUME_3L,
-	     ARIZONA_OUT3L_MUTE_SHIFT, 1, 1),
+	   ARIZONA_OUT3L_MUTE_SHIFT, 1, 1),
 SOC_DOUBLE_R("Speaker Digital Switch", ARIZONA_DAC_DIGITAL_VOLUME_4L,
 	     ARIZONA_DAC_DIGITAL_VOLUME_4R, ARIZONA_OUT4L_MUTE_SHIFT, 1, 1),
 SOC_DOUBLE_R("SPKDAT Digital Switch", ARIZONA_DAC_DIGITAL_VOLUME_5L,
@@ -335,7 +337,7 @@ SOC_DOUBLE_R_TLV("LINEOUT Digital Volume", ARIZONA_DAC_DIGITAL_VOLUME_2L,
 		 ARIZONA_DAC_DIGITAL_VOLUME_2R, ARIZONA_OUT2L_VOL_SHIFT,
 		 0xbf, 0, digital_tlv),
 SOC_SINGLE_TLV("EPOUT Digital Volume", ARIZONA_DAC_DIGITAL_VOLUME_3L,
-		 ARIZONA_OUT3L_VOL_SHIFT, 0xbf, 0, digital_tlv),
+	       ARIZONA_OUT3L_VOL_SHIFT, 0xbf, 0, digital_tlv),
 SOC_DOUBLE_R_TLV("Speaker Digital Volume", ARIZONA_DAC_DIGITAL_VOLUME_4L,
 		 ARIZONA_DAC_DIGITAL_VOLUME_4R, ARIZONA_OUT4L_VOL_SHIFT,
 		 0xbf, 0, digital_tlv),
@@ -615,12 +617,12 @@ SND_SOC_DAPM_PGA("ISRC2DEC2", ARIZONA_ISRC_2_CTRL_3,
 		 ARIZONA_ISRC2_DEC1_ENA_SHIFT, 0, NULL, 0),
 
 SND_SOC_DAPM_MUX("AEC1 Loopback", ARIZONA_DAC_AEC_CONTROL_1,
-		       ARIZONA_AEC_LOOPBACK_ENA_SHIFT, 0,
-		       &wm8998_aec_loopback_mux[0]),
+		 ARIZONA_AEC_LOOPBACK_ENA_SHIFT, 0,
+		 &wm8998_aec_loopback_mux[0]),
 
 SND_SOC_DAPM_MUX("AEC2 Loopback", ARIZONA_DAC_AEC_CONTROL_2,
-		       ARIZONA_AEC_LOOPBACK_ENA_SHIFT, 0,
-		       &wm8998_aec_loopback_mux[1]),
+		 ARIZONA_AEC_LOOPBACK_ENA_SHIFT, 0,
+		 &wm8998_aec_loopback_mux[1]),
 
 SND_SOC_DAPM_AIF_OUT("AIF1TX1", NULL, 0,
 		     ARIZONA_AIF1_TX_ENABLES, ARIZONA_AIF1TX1_ENA_SHIFT, 0),
@@ -739,9 +741,9 @@ SND_SOC_DAPM_PGA_E("OUT5R", ARIZONA_OUTPUT_ENABLES_1,
 		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMU),
 
 SND_SOC_DAPM_PGA("SPD1TX1", ARIZONA_SPD1_TX_CONTROL,
-		   ARIZONA_SPD1_VAL1_SHIFT, 0, NULL, 0),
+		 ARIZONA_SPD1_VAL1_SHIFT, 0, NULL, 0),
 SND_SOC_DAPM_PGA("SPD1TX2", ARIZONA_SPD1_TX_CONTROL,
-		   ARIZONA_SPD1_VAL2_SHIFT, 0, NULL, 0),
+		 ARIZONA_SPD1_VAL2_SHIFT, 0, NULL, 0),
 SND_SOC_DAPM_OUT_DRV("SPD1", ARIZONA_SPD1_TX_CONTROL,
 		     ARIZONA_SPD1_ENA_SHIFT, 0, NULL, 0),
 
@@ -1249,8 +1251,8 @@ static struct snd_soc_dai_driver wm8998_dai[] = {
 	},
 };
 
-static int wm8998_set_fll(struct snd_soc_component *component, int fll_id, int source,
-			  unsigned int Fref, unsigned int Fout)
+static int wm8998_set_fll(struct snd_soc_component *component, int fll_id,
+			  int source, unsigned int Fref, unsigned int Fout)
 {
 	struct wm8998_priv *wm8998 = snd_soc_component_get_drvdata(component);
 
@@ -1379,8 +1381,9 @@ static int wm8998_probe(struct platform_device *pdev)
 		return ret;
 
 	ret = devm_snd_soc_register_component(&pdev->dev,
-				     &soc_component_dev_wm8998,
-				     wm8998_dai, ARRAY_SIZE(wm8998_dai));
+					      &soc_component_dev_wm8998,
+					      wm8998_dai,
+					      ARRAY_SIZE(wm8998_dai));
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register component: %d\n", ret);
 		goto err_spk_irqs;
-- 
2.11.0
