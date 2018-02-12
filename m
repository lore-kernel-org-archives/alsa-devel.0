From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5640: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:45:32 +0000
Message-ID: <E1elDUC-0005Jn-LS@debutante>
References: <87372p2uxs.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AF55267CE7
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:45:35 +0100 (CET)
In-Reply-To: <87372p2uxs.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5640: replace codec to component

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From d5a41b5d5f883b659e2f5bac13867e0b75837e70 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:42:46 +0000
Subject: [PATCH] ASoC: rt5640: replace codec to component

Now we can replace Codec to Component. Let's do it.

Note:
	xxx_codec_xxx()		->	xxx_component_xxx()
	.idle_bias_off = 1	->	.idle_bias_on = 0
	.ignore_pmdown_time = 0	->	.use_pmdown_time = 1
	-			->	.endianness = 1
	-			->	.non_legacy_dai_naming = 1

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5640.c             | 260 ++++++++++++++++------------------
 sound/soc/codecs/rt5640.h             |   6 +-
 sound/soc/intel/boards/byt-rt5640.c   |   4 +-
 sound/soc/intel/boards/bytcr_rt5640.c |   8 +-
 4 files changed, 135 insertions(+), 143 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 438fe52a12df..05567426f211 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -166,9 +166,9 @@ static const struct reg_default rt5640_reg[] = {
 	{ 0xff, 0x6231 },
 };
 
-static int rt5640_reset(struct snd_soc_codec *codec)
+static int rt5640_reset(struct snd_soc_component *component)
 {
-	return snd_soc_write(codec, RT5640_RESET, 0);
+	return snd_soc_component_write(component, RT5640_RESET, 0);
 }
 
 static bool rt5640_volatile_register(struct device *dev, unsigned int reg)
@@ -461,17 +461,17 @@ static const struct snd_kcontrol_new rt5640_specific_snd_controls[] = {
 static int set_dmic_clk(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct rt5640_priv *rt5640 = snd_soc_component_get_drvdata(component);
 	int idx, rate;
 
 	rate = rt5640->sysclk / rl6231_get_pre_div(rt5640->regmap,
 		RT5640_ADDA_CLK1, RT5640_I2S_PD1_SFT);
 	idx = rl6231_calc_dmic_clk(rate);
 	if (idx < 0)
-		dev_err(codec->dev, "Failed to set DMIC clock\n");
+		dev_err(component->dev, "Failed to set DMIC clock\n");
 	else
-		snd_soc_update_bits(codec, RT5640_DMIC, RT5640_DMIC_CLK_MASK,
+		snd_soc_component_update_bits(component, RT5640_DMIC, RT5640_DMIC_CLK_MASK,
 					idx << RT5640_DMIC_CLK_SFT);
 	return idx;
 }
@@ -479,10 +479,10 @@ static int set_dmic_clk(struct snd_soc_dapm_widget *w,
 static int is_sys_clk_from_pll(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(source->dapm);
 	unsigned int val;
 
-	val = snd_soc_read(codec, RT5640_GLB_CLK);
+	val = snd_soc_component_read32(component, RT5640_GLB_CLK);
 	val &= RT5640_SCLK_SRC_MASK;
 	if (val == RT5640_SCLK_SRC_PLL1)
 		return 1;
@@ -493,8 +493,8 @@ static int is_sys_clk_from_pll(struct snd_soc_dapm_widget *source,
 static int is_using_asrc(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(source->dapm);
-	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(source->dapm);
+	struct rt5640_priv *rt5640 = snd_soc_component_get_drvdata(component);
 
 	if (!rt5640->asrc_en)
 		return 0;
@@ -930,9 +930,9 @@ static SOC_ENUM_SINGLE_DECL(rt5640_sdi_sel_enum, RT5640_I2S2_SDP,
 static const struct snd_kcontrol_new rt5640_sdi_mux =
 	SOC_DAPM_ENUM("SDI select", rt5640_sdi_sel_enum);
 
-static void hp_amp_power_on(struct snd_soc_codec *codec)
+static void hp_amp_power_on(struct snd_soc_component *component)
 {
-	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
+	struct rt5640_priv *rt5640 = snd_soc_component_get_drvdata(component);
 
 	/* depop parameters */
 	regmap_update_bits(rt5640->regmap, RT5640_PR_BASE +
@@ -956,9 +956,9 @@ static void hp_amp_power_on(struct snd_soc_codec *codec)
 		RT5640_PWR_FV1 | RT5640_PWR_FV2);
 }
 
-static void rt5640_pmu_depop(struct snd_soc_codec *codec)
+static void rt5640_pmu_depop(struct snd_soc_component *component)
 {
-	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
+	struct rt5640_priv *rt5640 = snd_soc_component_get_drvdata(component);
 
 	regmap_update_bits(rt5640->regmap, RT5640_DEPOP_M2,
 		RT5640_DEPOP_MASK | RT5640_DIG_DP_MASK,
@@ -984,12 +984,12 @@ static void rt5640_pmu_depop(struct snd_soc_codec *codec)
 static int rt5640_hp_event(struct snd_soc_dapm_widget *w,
 			   struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct rt5640_priv *rt5640 = snd_soc_component_get_drvdata(component);
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-		rt5640_pmu_depop(codec);
+		rt5640_pmu_depop(component);
 		rt5640->hp_mute = 0;
 		break;
 
@@ -1008,22 +1008,22 @@ static int rt5640_hp_event(struct snd_soc_dapm_widget *w,
 static int rt5640_lout_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-		hp_amp_power_on(codec);
-		snd_soc_update_bits(codec, RT5640_PWR_ANLG1,
+		hp_amp_power_on(component);
+		snd_soc_component_update_bits(component, RT5640_PWR_ANLG1,
 			RT5640_PWR_LM, RT5640_PWR_LM);
-		snd_soc_update_bits(codec, RT5640_OUTPUT,
+		snd_soc_component_update_bits(component, RT5640_OUTPUT,
 			RT5640_L_MUTE | RT5640_R_MUTE, 0);
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
-		snd_soc_update_bits(codec, RT5640_OUTPUT,
+		snd_soc_component_update_bits(component, RT5640_OUTPUT,
 			RT5640_L_MUTE | RT5640_R_MUTE,
 			RT5640_L_MUTE | RT5640_R_MUTE);
-		snd_soc_update_bits(codec, RT5640_PWR_ANLG1,
+		snd_soc_component_update_bits(component, RT5640_PWR_ANLG1,
 			RT5640_PWR_LM, 0);
 		break;
 
@@ -1037,11 +1037,11 @@ static int rt5640_lout_event(struct snd_soc_dapm_widget *w,
 static int rt5640_hp_power_event(struct snd_soc_dapm_widget *w,
 			   struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-		hp_amp_power_on(codec);
+		hp_amp_power_on(component);
 		break;
 	default:
 		return 0;
@@ -1053,8 +1053,8 @@ static int rt5640_hp_power_event(struct snd_soc_dapm_widget *w,
 static int rt5640_hp_post_event(struct snd_soc_dapm_widget *w,
 			   struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct rt5640_priv *rt5640 = snd_soc_component_get_drvdata(component);
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
@@ -1671,14 +1671,14 @@ static const struct snd_soc_dapm_route rt5639_specific_dapm_routes[] = {
 	{"IF2 DAC R", NULL, "DAC R2 Power"},
 };
 
-static int get_sdp_info(struct snd_soc_codec *codec, int dai_id)
+static int get_sdp_info(struct snd_soc_component *component, int dai_id)
 {
 	int ret = 0, val;
 
-	if (codec == NULL)
+	if (component == NULL)
 		return -EINVAL;
 
-	val = snd_soc_read(codec, RT5640_I2S1_SDP);
+	val = snd_soc_component_read32(component, RT5640_I2S1_SDP);
 	val = (val & RT5640_I2S_IF_MASK) >> RT5640_I2S_IF_SFT;
 	switch (dai_id) {
 	case RT5640_AIF1:
@@ -1722,21 +1722,21 @@ static int get_sdp_info(struct snd_soc_codec *codec, int dai_id)
 static int rt5640_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct rt5640_priv *rt5640 = snd_soc_component_get_drvdata(component);
 	unsigned int val_len = 0, val_clk, mask_clk;
 	int dai_sel, pre_div, bclk_ms, frame_size;
 
 	rt5640->lrck[dai->id] = params_rate(params);
 	pre_div = rl6231_get_clk_info(rt5640->sysclk, rt5640->lrck[dai->id]);
 	if (pre_div < 0) {
-		dev_err(codec->dev, "Unsupported clock setting %d for DAI %d\n",
+		dev_err(component->dev, "Unsupported clock setting %d for DAI %d\n",
 			rt5640->lrck[dai->id], dai->id);
 		return -EINVAL;
 	}
 	frame_size = snd_soc_params_to_frame_size(params);
 	if (frame_size < 0) {
-		dev_err(codec->dev, "Unsupported frame size: %d\n", frame_size);
+		dev_err(component->dev, "Unsupported frame size: %d\n", frame_size);
 		return frame_size;
 	}
 	if (frame_size > 32)
@@ -1766,26 +1766,26 @@ static int rt5640_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	dai_sel = get_sdp_info(codec, dai->id);
+	dai_sel = get_sdp_info(component, dai->id);
 	if (dai_sel < 0) {
-		dev_err(codec->dev, "Failed to get sdp info: %d\n", dai_sel);
+		dev_err(component->dev, "Failed to get sdp info: %d\n", dai_sel);
 		return -EINVAL;
 	}
 	if (dai_sel & RT5640_U_IF1) {
 		mask_clk = RT5640_I2S_BCLK_MS1_MASK | RT5640_I2S_PD1_MASK;
 		val_clk = bclk_ms << RT5640_I2S_BCLK_MS1_SFT |
 			pre_div << RT5640_I2S_PD1_SFT;
-		snd_soc_update_bits(codec, RT5640_I2S1_SDP,
+		snd_soc_component_update_bits(component, RT5640_I2S1_SDP,
 			RT5640_I2S_DL_MASK, val_len);
-		snd_soc_update_bits(codec, RT5640_ADDA_CLK1, mask_clk, val_clk);
+		snd_soc_component_update_bits(component, RT5640_ADDA_CLK1, mask_clk, val_clk);
 	}
 	if (dai_sel & RT5640_U_IF2) {
 		mask_clk = RT5640_I2S_BCLK_MS2_MASK | RT5640_I2S_PD2_MASK;
 		val_clk = bclk_ms << RT5640_I2S_BCLK_MS2_SFT |
 			pre_div << RT5640_I2S_PD2_SFT;
-		snd_soc_update_bits(codec, RT5640_I2S2_SDP,
+		snd_soc_component_update_bits(component, RT5640_I2S2_SDP,
 			RT5640_I2S_DL_MASK, val_len);
-		snd_soc_update_bits(codec, RT5640_ADDA_CLK1, mask_clk, val_clk);
+		snd_soc_component_update_bits(component, RT5640_ADDA_CLK1, mask_clk, val_clk);
 	}
 
 	return 0;
@@ -1793,8 +1793,8 @@ static int rt5640_hw_params(struct snd_pcm_substream *substream,
 
 static int rt5640_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct rt5640_priv *rt5640 = snd_soc_component_get_drvdata(component);
 	unsigned int reg_val = 0;
 	int dai_sel;
 
@@ -1836,18 +1836,18 @@ static int rt5640_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	dai_sel = get_sdp_info(codec, dai->id);
+	dai_sel = get_sdp_info(component, dai->id);
 	if (dai_sel < 0) {
-		dev_err(codec->dev, "Failed to get sdp info: %d\n", dai_sel);
+		dev_err(component->dev, "Failed to get sdp info: %d\n", dai_sel);
 		return -EINVAL;
 	}
 	if (dai_sel & RT5640_U_IF1) {
-		snd_soc_update_bits(codec, RT5640_I2S1_SDP,
+		snd_soc_component_update_bits(component, RT5640_I2S1_SDP,
 			RT5640_I2S_MS_MASK | RT5640_I2S_BP_MASK |
 			RT5640_I2S_DF_MASK, reg_val);
 	}
 	if (dai_sel & RT5640_U_IF2) {
-		snd_soc_update_bits(codec, RT5640_I2S2_SDP,
+		snd_soc_component_update_bits(component, RT5640_I2S2_SDP,
 			RT5640_I2S_MS_MASK | RT5640_I2S_BP_MASK |
 			RT5640_I2S_DF_MASK, reg_val);
 	}
@@ -1858,8 +1858,8 @@ static int rt5640_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 static int rt5640_set_dai_sysclk(struct snd_soc_dai *dai,
 		int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct rt5640_priv *rt5640 = snd_soc_component_get_drvdata(component);
 	unsigned int reg_val = 0;
 
 	if (freq == rt5640->sysclk && clk_id == rt5640->sysclk_src)
@@ -1876,10 +1876,10 @@ static int rt5640_set_dai_sysclk(struct snd_soc_dai *dai,
 		reg_val |= RT5640_SCLK_SRC_RCCLK;
 		break;
 	default:
-		dev_err(codec->dev, "Invalid clock id (%d)\n", clk_id);
+		dev_err(component->dev, "Invalid clock id (%d)\n", clk_id);
 		return -EINVAL;
 	}
-	snd_soc_update_bits(codec, RT5640_GLB_CLK,
+	snd_soc_component_update_bits(component, RT5640_GLB_CLK,
 		RT5640_SCLK_SRC_MASK, reg_val);
 	rt5640->sysclk = freq;
 	rt5640->sysclk_src = clk_id;
@@ -1891,8 +1891,8 @@ static int rt5640_set_dai_sysclk(struct snd_soc_dai *dai,
 static int rt5640_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int source,
 			unsigned int freq_in, unsigned int freq_out)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct rt5640_priv *rt5640 = snd_soc_component_get_drvdata(component);
 	struct rl6231_pll_code pll_code;
 	int ret;
 
@@ -1901,46 +1901,46 @@ static int rt5640_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int source,
 		return 0;
 
 	if (!freq_in || !freq_out) {
-		dev_dbg(codec->dev, "PLL disabled\n");
+		dev_dbg(component->dev, "PLL disabled\n");
 
 		rt5640->pll_in = 0;
 		rt5640->pll_out = 0;
-		snd_soc_update_bits(codec, RT5640_GLB_CLK,
+		snd_soc_component_update_bits(component, RT5640_GLB_CLK,
 			RT5640_SCLK_SRC_MASK, RT5640_SCLK_SRC_MCLK);
 		return 0;
 	}
 
 	switch (source) {
 	case RT5640_PLL1_S_MCLK:
-		snd_soc_update_bits(codec, RT5640_GLB_CLK,
+		snd_soc_component_update_bits(component, RT5640_GLB_CLK,
 			RT5640_PLL1_SRC_MASK, RT5640_PLL1_SRC_MCLK);
 		break;
 	case RT5640_PLL1_S_BCLK1:
-		snd_soc_update_bits(codec, RT5640_GLB_CLK,
+		snd_soc_component_update_bits(component, RT5640_GLB_CLK,
 			RT5640_PLL1_SRC_MASK, RT5640_PLL1_SRC_BCLK1);
 		break;
 	case RT5640_PLL1_S_BCLK2:
-		snd_soc_update_bits(codec, RT5640_GLB_CLK,
+		snd_soc_component_update_bits(component, RT5640_GLB_CLK,
 			RT5640_PLL1_SRC_MASK, RT5640_PLL1_SRC_BCLK2);
 		break;
 	default:
-		dev_err(codec->dev, "Unknown PLL source %d\n", source);
+		dev_err(component->dev, "Unknown PLL source %d\n", source);
 		return -EINVAL;
 	}
 
 	ret = rl6231_pll_calc(freq_in, freq_out, &pll_code);
 	if (ret < 0) {
-		dev_err(codec->dev, "Unsupport input clock %d\n", freq_in);
+		dev_err(component->dev, "Unsupport input clock %d\n", freq_in);
 		return ret;
 	}
 
-	dev_dbg(codec->dev, "bypass=%d m=%d n=%d k=%d\n",
+	dev_dbg(component->dev, "bypass=%d m=%d n=%d k=%d\n",
 		pll_code.m_bp, (pll_code.m_bp ? 0 : pll_code.m_code),
 		pll_code.n_code, pll_code.k_code);
 
-	snd_soc_write(codec, RT5640_PLL_CTRL1,
+	snd_soc_component_write(component, RT5640_PLL_CTRL1,
 		pll_code.n_code << RT5640_PLL_N_SFT | pll_code.k_code);
-	snd_soc_write(codec, RT5640_PLL_CTRL2,
+	snd_soc_component_write(component, RT5640_PLL_CTRL2,
 		(pll_code.m_bp ? 0 : pll_code.m_code) << RT5640_PLL_M_SFT |
 		pll_code.m_bp << RT5640_PLL_M_BP_SFT);
 
@@ -1951,10 +1951,10 @@ static int rt5640_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int source,
 	return 0;
 }
 
-static int rt5640_set_bias_level(struct snd_soc_codec *codec,
+static int rt5640_set_bias_level(struct snd_soc_component *component,
 			enum snd_soc_bias_level level)
 {
-	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
+	struct rt5640_priv *rt5640 = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	switch (level) {
@@ -1972,7 +1972,7 @@ static int rt5640_set_bias_level(struct snd_soc_codec *codec,
 		if (IS_ERR(rt5640->mclk))
 			break;
 
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_ON) {
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_ON) {
 			clk_disable_unprepare(rt5640->mclk);
 		} else {
 			ret = clk_prepare_enable(rt5640->mclk);
@@ -1982,33 +1982,33 @@ static int rt5640_set_bias_level(struct snd_soc_codec *codec,
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (SND_SOC_BIAS_OFF == snd_soc_codec_get_bias_level(codec)) {
-			snd_soc_update_bits(codec, RT5640_PWR_ANLG1,
+		if (SND_SOC_BIAS_OFF == snd_soc_component_get_bias_level(component)) {
+			snd_soc_component_update_bits(component, RT5640_PWR_ANLG1,
 				RT5640_PWR_VREF1 | RT5640_PWR_MB |
 				RT5640_PWR_BG | RT5640_PWR_VREF2,
 				RT5640_PWR_VREF1 | RT5640_PWR_MB |
 				RT5640_PWR_BG | RT5640_PWR_VREF2);
 			usleep_range(10000, 15000);
-			snd_soc_update_bits(codec, RT5640_PWR_ANLG1,
+			snd_soc_component_update_bits(component, RT5640_PWR_ANLG1,
 				RT5640_PWR_FV1 | RT5640_PWR_FV2,
 				RT5640_PWR_FV1 | RT5640_PWR_FV2);
-			snd_soc_update_bits(codec, RT5640_DUMMY1,
+			snd_soc_component_update_bits(component, RT5640_DUMMY1,
 						0x0301, 0x0301);
-			snd_soc_update_bits(codec, RT5640_MICBIAS,
+			snd_soc_component_update_bits(component, RT5640_MICBIAS,
 						0x0030, 0x0030);
 		}
 		break;
 
 	case SND_SOC_BIAS_OFF:
-		snd_soc_write(codec, RT5640_DEPOP_M1, 0x0004);
-		snd_soc_write(codec, RT5640_DEPOP_M2, 0x1100);
-		snd_soc_update_bits(codec, RT5640_DUMMY1, 0x1, 0);
-		snd_soc_write(codec, RT5640_PWR_DIG1, 0x0000);
-		snd_soc_write(codec, RT5640_PWR_DIG2, 0x0000);
-		snd_soc_write(codec, RT5640_PWR_VOL, 0x0000);
-		snd_soc_write(codec, RT5640_PWR_MIXER, 0x0000);
-		snd_soc_write(codec, RT5640_PWR_ANLG1, 0x0000);
-		snd_soc_write(codec, RT5640_PWR_ANLG2, 0x0000);
+		snd_soc_component_write(component, RT5640_DEPOP_M1, 0x0004);
+		snd_soc_component_write(component, RT5640_DEPOP_M2, 0x1100);
+		snd_soc_component_update_bits(component, RT5640_DUMMY1, 0x1, 0);
+		snd_soc_component_write(component, RT5640_PWR_DIG1, 0x0000);
+		snd_soc_component_write(component, RT5640_PWR_DIG2, 0x0000);
+		snd_soc_component_write(component, RT5640_PWR_VOL, 0x0000);
+		snd_soc_component_write(component, RT5640_PWR_MIXER, 0x0000);
+		snd_soc_component_write(component, RT5640_PWR_ANLG1, 0x0000);
+		snd_soc_component_write(component, RT5640_PWR_ANLG2, 0x0000);
 		break;
 
 	default:
@@ -2018,10 +2018,10 @@ static int rt5640_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-int rt5640_dmic_enable(struct snd_soc_codec *codec,
+int rt5640_dmic_enable(struct snd_soc_component *component,
 		       bool dmic1_data_pin, bool dmic2_data_pin)
 {
-	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
+	struct rt5640_priv *rt5640 = snd_soc_component_get_drvdata(component);
 
 	regmap_update_bits(rt5640->regmap, RT5640_GPIO_CTRL1,
 		RT5640_GP2_PIN_MASK, RT5640_GP2_PIN_DMIC1_SCL);
@@ -2044,10 +2044,10 @@ int rt5640_dmic_enable(struct snd_soc_codec *codec,
 }
 EXPORT_SYMBOL_GPL(rt5640_dmic_enable);
 
-int rt5640_sel_asrc_clk_src(struct snd_soc_codec *codec,
+int rt5640_sel_asrc_clk_src(struct snd_soc_component *component,
 		unsigned int filter_mask, unsigned int clk_src)
 {
-	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
+	struct rt5640_priv *rt5640 = snd_soc_component_get_drvdata(component);
 	unsigned int asrc2_mask = 0;
 	unsigned int asrc2_value = 0;
 
@@ -2099,43 +2099,43 @@ int rt5640_sel_asrc_clk_src(struct snd_soc_codec *codec,
 			| (clk_src << RT5640_MAD_R_M_SFT);
 	}
 
-	snd_soc_update_bits(codec, RT5640_ASRC_2,
+	snd_soc_component_update_bits(component, RT5640_ASRC_2,
 		asrc2_mask, asrc2_value);
 
-	if (snd_soc_read(codec, RT5640_ASRC_2)) {
+	if (snd_soc_component_read32(component, RT5640_ASRC_2)) {
 		rt5640->asrc_en = true;
-		snd_soc_update_bits(codec, RT5640_JD_CTRL, 0x3, 0x3);
+		snd_soc_component_update_bits(component, RT5640_JD_CTRL, 0x3, 0x3);
 	} else {
 		rt5640->asrc_en = false;
-		snd_soc_update_bits(codec, RT5640_JD_CTRL, 0x3, 0x0);
+		snd_soc_component_update_bits(component, RT5640_JD_CTRL, 0x3, 0x0);
 	}
 
 	return 0;
 }
 EXPORT_SYMBOL_GPL(rt5640_sel_asrc_clk_src);
 
-static int rt5640_probe(struct snd_soc_codec *codec)
+static int rt5640_probe(struct snd_soc_component *component)
 {
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
-	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	struct rt5640_priv *rt5640 = snd_soc_component_get_drvdata(component);
 
 	/* Check if MCLK provided */
-	rt5640->mclk = devm_clk_get(codec->dev, "mclk");
+	rt5640->mclk = devm_clk_get(component->dev, "mclk");
 	if (PTR_ERR(rt5640->mclk) == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 
-	rt5640->codec = codec;
+	rt5640->component = component;
 
-	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_OFF);
+	snd_soc_component_force_bias_level(component, SND_SOC_BIAS_OFF);
 
-	snd_soc_update_bits(codec, RT5640_DUMMY1, 0x0301, 0x0301);
-	snd_soc_update_bits(codec, RT5640_MICBIAS, 0x0030, 0x0030);
-	snd_soc_update_bits(codec, RT5640_DSP_PATH2, 0xfc00, 0x0c00);
+	snd_soc_component_update_bits(component, RT5640_DUMMY1, 0x0301, 0x0301);
+	snd_soc_component_update_bits(component, RT5640_MICBIAS, 0x0030, 0x0030);
+	snd_soc_component_update_bits(component, RT5640_DSP_PATH2, 0xfc00, 0x0c00);
 
-	switch (snd_soc_read(codec, RT5640_RESET) & RT5640_ID_MASK) {
+	switch (snd_soc_component_read32(component, RT5640_RESET) & RT5640_ID_MASK) {
 	case RT5640_ID_5640:
 	case RT5640_ID_5642:
-		snd_soc_add_codec_controls(codec,
+		snd_soc_add_component_controls(component,
 			rt5640_specific_snd_controls,
 			ARRAY_SIZE(rt5640_specific_snd_controls));
 		snd_soc_dapm_new_controls(dapm,
@@ -2154,32 +2154,30 @@ static int rt5640_probe(struct snd_soc_codec *codec)
 			ARRAY_SIZE(rt5639_specific_dapm_routes));
 		break;
 	default:
-		dev_err(codec->dev,
+		dev_err(component->dev,
 			"The driver is for RT5639 RT5640 or RT5642 only\n");
 		return -ENODEV;
 	}
 
 	if (rt5640->pdata.dmic_en)
-		rt5640_dmic_enable(codec, rt5640->pdata.dmic1_data_pin,
+		rt5640_dmic_enable(component, rt5640->pdata.dmic1_data_pin,
 					  rt5640->pdata.dmic2_data_pin);
 
 	return 0;
 }
 
-static int rt5640_remove(struct snd_soc_codec *codec)
+static void rt5640_remove(struct snd_soc_component *component)
 {
-	rt5640_reset(codec);
-
-	return 0;
+	rt5640_reset(component);
 }
 
 #ifdef CONFIG_PM
-static int rt5640_suspend(struct snd_soc_codec *codec)
+static int rt5640_suspend(struct snd_soc_component *component)
 {
-	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
+	struct rt5640_priv *rt5640 = snd_soc_component_get_drvdata(component);
 
-	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_OFF);
-	rt5640_reset(codec);
+	snd_soc_component_force_bias_level(component, SND_SOC_BIAS_OFF);
+	rt5640_reset(component);
 	regcache_cache_only(rt5640->regmap, true);
 	regcache_mark_dirty(rt5640->regmap);
 	if (gpio_is_valid(rt5640->pdata.ldo1_en))
@@ -2188,9 +2186,9 @@ static int rt5640_suspend(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int rt5640_resume(struct snd_soc_codec *codec)
+static int rt5640_resume(struct snd_soc_component *component)
 {
-	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
+	struct rt5640_priv *rt5640 = snd_soc_component_get_drvdata(component);
 
 	if (gpio_is_valid(rt5640->pdata.ldo1_en)) {
 		gpio_set_value_cansleep(rt5640->pdata.ldo1_en, 1);
@@ -2259,21 +2257,22 @@ static struct snd_soc_dai_driver rt5640_dai[] = {
 	},
 };
 
-static const struct snd_soc_codec_driver soc_codec_dev_rt5640 = {
-	.probe = rt5640_probe,
-	.remove = rt5640_remove,
-	.suspend = rt5640_suspend,
-	.resume = rt5640_resume,
-	.set_bias_level = rt5640_set_bias_level,
-	.idle_bias_off = true,
-	.component_driver = {
-		.controls		= rt5640_snd_controls,
-		.num_controls		= ARRAY_SIZE(rt5640_snd_controls),
-		.dapm_widgets		= rt5640_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(rt5640_dapm_widgets),
-		.dapm_routes		= rt5640_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(rt5640_dapm_routes),
-	},
+static const struct snd_soc_component_driver soc_component_dev_rt5640 = {
+	.probe			= rt5640_probe,
+	.remove			= rt5640_remove,
+	.suspend		= rt5640_suspend,
+	.resume			= rt5640_resume,
+	.set_bias_level		= rt5640_set_bias_level,
+	.controls		= rt5640_snd_controls,
+	.num_controls		= ARRAY_SIZE(rt5640_snd_controls),
+	.dapm_widgets		= rt5640_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(rt5640_dapm_widgets),
+	.dapm_routes		= rt5640_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(rt5640_dapm_routes),
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
+
 };
 
 static const struct regmap_config rt5640_regmap = {
@@ -2427,17 +2426,11 @@ static int rt5640_i2c_probe(struct i2c_client *i2c,
 
 	rt5640->hp_mute = 1;
 
-	return snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5640,
+	return devm_snd_soc_register_component(&i2c->dev,
+				      &soc_component_dev_rt5640,
 				      rt5640_dai, ARRAY_SIZE(rt5640_dai));
 }
 
-static int rt5640_i2c_remove(struct i2c_client *i2c)
-{
-	snd_soc_unregister_codec(&i2c->dev);
-
-	return 0;
-}
-
 static struct i2c_driver rt5640_i2c_driver = {
 	.driver = {
 		.name = "rt5640",
@@ -2445,7 +2438,6 @@ static struct i2c_driver rt5640_i2c_driver = {
 		.of_match_table = of_match_ptr(rt5640_of_match),
 	},
 	.probe = rt5640_i2c_probe,
-	.remove   = rt5640_i2c_remove,
 	.id_table = rt5640_i2c_id,
 };
 module_i2c_driver(rt5640_i2c_driver);
diff --git a/sound/soc/codecs/rt5640.h b/sound/soc/codecs/rt5640.h
index b8a811732a52..c473e8ae2eda 100644
--- a/sound/soc/codecs/rt5640.h
+++ b/sound/soc/codecs/rt5640.h
@@ -2102,7 +2102,7 @@ enum {
 };
 
 struct rt5640_priv {
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 	struct rt5640_platform_data pdata;
 	struct regmap *regmap;
 	struct clk *mclk;
@@ -2121,9 +2121,9 @@ struct rt5640_priv {
 	bool asrc_en;
 };
 
-int rt5640_dmic_enable(struct snd_soc_codec *codec,
+int rt5640_dmic_enable(struct snd_soc_component *component,
 		       bool dmic1_data_pin, bool dmic2_data_pin);
-int rt5640_sel_asrc_clk_src(struct snd_soc_codec *codec,
+int rt5640_sel_asrc_clk_src(struct snd_soc_component *component,
 		unsigned int filter_mask, unsigned int clk_src);
 
 #endif
diff --git a/sound/soc/intel/boards/byt-rt5640.c b/sound/soc/intel/boards/byt-rt5640.c
index de9788a3fd06..df902d82145e 100644
--- a/sound/soc/intel/boards/byt-rt5640.c
+++ b/sound/soc/intel/boards/byt-rt5640.c
@@ -131,7 +131,7 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 {
 	int ret;
-	struct snd_soc_codec *codec = runtime->codec;
+	struct snd_soc_component *component = runtime->codec_dai->component;
 	struct snd_soc_card *card = runtime->card;
 	const struct snd_soc_dapm_route *custom_map;
 	int num_routes;
@@ -165,7 +165,7 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 		return ret;
 
 	if (byt_rt5640_quirk & BYT_RT5640_DMIC_EN) {
-		ret = rt5640_dmic_enable(codec, 0, 0);
+		ret = rt5640_dmic_enable(component, 0, 0);
 		if (ret)
 			return ret;
 	}
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index b6a1cfeec830..a8d8bff788e7 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -444,14 +444,14 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 {
 	struct snd_soc_card *card = runtime->card;
 	struct byt_rt5640_private *priv = snd_soc_card_get_drvdata(card);
-	struct snd_soc_codec *codec = runtime->codec;
+	struct snd_soc_component *component = runtime->codec_dai->component;
 	const struct snd_soc_dapm_route *custom_map;
 	int num_routes;
 	int ret;
 
 	card->dapm.idle_bias_off = true;
 
-	rt5640_sel_asrc_clk_src(codec,
+	rt5640_sel_asrc_clk_src(component,
 				RT5640_DA_STEREO_FILTER |
 				RT5640_DA_MONO_L_FILTER	|
 				RT5640_DA_MONO_R_FILTER	|
@@ -522,12 +522,12 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 		return ret;
 
 	if (byt_rt5640_quirk & BYT_RT5640_DIFF_MIC) {
-		snd_soc_update_bits(codec,  RT5640_IN1_IN2, RT5640_IN_DF1,
+		snd_soc_component_update_bits(component,  RT5640_IN1_IN2, RT5640_IN_DF1,
 				    RT5640_IN_DF1);
 	}
 
 	if (byt_rt5640_quirk & BYT_RT5640_DMIC_EN) {
-		ret = rt5640_dmic_enable(codec, 0, 0);
+		ret = rt5640_dmic_enable(component, 0, 0);
 		if (ret)
 			return ret;
 	}
-- 
2.16.1
