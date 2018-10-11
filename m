From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [RFC PATCH 4/4] ASoC: arizona: Add rate domain support
Date: Thu, 11 Oct 2018 17:28:31 +0100
Message-ID: <20181011162831.26351-5-ckeepax@opensource.cirrus.com>
References: <20181011162831.26351-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id D455A267943
 for <alsa-devel@alsa-project.org>; Thu, 11 Oct 2018 18:28:38 +0200 (CEST)
In-Reply-To: <20181011162831.26351-1-ckeepax@opensource.cirrus.com>
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
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Move to using sample rate domains on the Arizona CODECs. Rate domain
group widgets are added and these are connected to all the widgets they
supply.

arizona_hw_params_rate is updated significantly, it now manually
attached the AIF sample rate domain group to a domain at the rate
requested by the params. This ensures that any widgets powering up that
are connected to the audio interface will be placed on the same sample
rate domain.

Whilst the SLIMbus technically supports a different sample rate on each
channel the driver currently only supports sample rates for capture and
playback on each DAI, as such the SLIMBus channels that are grouped onto
a single DAI are manually connected together as peers.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

This one is obviously not quite finished yet, the other CODECs
in Arizona need updated and the macros that are duplicated will
obviously just be updated in that case.

Thanks,
Charles

 sound/soc/codecs/arizona.c | 255 ++++++++++++++++++++++------
 sound/soc/codecs/arizona.h |  76 ++++++++-
 sound/soc/codecs/wm5110.c  | 414 ++++++++++++++++++++++++++++++++++-----------
 3 files changed, 591 insertions(+), 154 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 5727ea079ad7a..37ce772691739 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -633,12 +633,12 @@ const char *arizona_sample_rate_val_to_name(unsigned int rate_val)
 EXPORT_SYMBOL_GPL(arizona_sample_rate_val_to_name);
 
 const char * const arizona_rate_text[ARIZONA_RATE_ENUM_SIZE] = {
-	"SYNCCLK rate", "8kHz", "16kHz", "ASYNCCLK rate",
+	"SYNCCLK rate", "8kHz", "16kHz", "ASYNCCLK rate", "ASYNCCLK rate 2",
 };
 EXPORT_SYMBOL_GPL(arizona_rate_text);
 
 const unsigned int arizona_rate_val[ARIZONA_RATE_ENUM_SIZE] = {
-	0, 1, 2, 8,
+	0, 1, 2, 8, 9,
 };
 EXPORT_SYMBOL_GPL(arizona_rate_val);
 
@@ -1681,40 +1681,15 @@ static int arizona_hw_params_rate(struct snd_pcm_substream *substream,
 	struct snd_soc_component *component = dai->component;
 	struct arizona_priv *priv = snd_soc_component_get_drvdata(component);
 	struct arizona_dai_priv *dai_priv = &priv->dai[dai->id - 1];
-	int base = dai->driver->base;
-	int i, sr_val, ret;
-
-	/*
-	 * We will need to be more flexible than this in future,
-	 * currently we use a single sample rate for SYSCLK.
-	 */
-	for (i = 0; i < ARRAY_SIZE(arizona_sr_vals); i++)
-		if (arizona_sr_vals[i] == params_rate(params))
-			break;
-	if (i == ARRAY_SIZE(arizona_sr_vals)) {
-		arizona_aif_err(dai, "Unsupported sample rate %dHz\n",
-				params_rate(params));
-		return -EINVAL;
-	}
-	sr_val = i;
-
-	switch (priv->arizona->type) {
-	case WM5102:
-	case WM8997:
-		if (arizona_sr_vals[sr_val] >= 88200)
-			ret = arizona_dvfs_up(component, ARIZONA_DVFS_SR1_RQ);
-		else
-			ret = arizona_dvfs_down(component, ARIZONA_DVFS_SR1_RQ);
+	int ret;
+	struct snd_soc_domain_group *dgrp;
 
-		if (ret) {
-			arizona_aif_err(dai, "Failed to change DVFS %d\n", ret);
-			return ret;
-		}
-		break;
-	default:
-		break;
-	}
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		dgrp = dai->playback_widget->dgroup;
+	else
+		dgrp = dai->capture_widget->dgroup;
 
+	/* TODO: This should be handled on power up of the OUT_RATE widget */
 	switch (dai_priv->clk) {
 	case ARIZONA_CLK_SYSCLK:
 		switch (priv->arizona->type) {
@@ -1725,31 +1700,38 @@ static int arizona_hw_params_rate(struct snd_pcm_substream *substream,
 		default:
 			break;
 		}
-
-		snd_soc_component_update_bits(component, ARIZONA_SAMPLE_RATE_1,
-					      ARIZONA_SAMPLE_RATE_1_MASK,
-					      sr_val);
-		if (base)
-			snd_soc_component_update_bits(component,
-					base + ARIZONA_AIF_RATE_CTRL,
-					ARIZONA_AIF1_RATE_MASK, 0);
 		break;
 	case ARIZONA_CLK_ASYNCCLK:
-		snd_soc_component_update_bits(component,
-					      ARIZONA_ASYNC_SAMPLE_RATE_1,
-					      ARIZONA_ASYNC_SAMPLE_RATE_1_MASK,
-					      sr_val);
-		if (base)
-			snd_soc_component_update_bits(component,
-					base + ARIZONA_AIF_RATE_CTRL,
-					ARIZONA_AIF1_RATE_MASK,
-					8 << ARIZONA_AIF1_RATE_SHIFT);
 		break;
 	default:
 		arizona_aif_err(dai, "Invalid clock %d\n", dai_priv->clk);
 		return -EINVAL;
 	}
 
+	/* TODO: Needs updated to handle multiple calls of hw_params */
+	ret = snd_soc_domain_attach(dgrp);
+	if (ret)
+		return ret;
+
+	ret = snd_soc_domain_set_rate(dgrp, params_rate(params));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int arizona_hw_free(struct snd_pcm_substream *substream,
+			   struct snd_soc_dai *dai)
+{
+	struct snd_soc_domain_group *dgrp;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		dgrp = dai->playback_widget->dgroup;
+	else
+		dgrp = dai->capture_widget->dgroup;
+
+	snd_soc_domain_detach(dgrp);
+
 	return 0;
 }
 
@@ -2029,6 +2011,7 @@ const struct snd_soc_dai_ops arizona_dai_ops = {
 	.set_fmt = arizona_set_fmt,
 	.set_tdm_slot = arizona_set_tdm_slot,
 	.hw_params = arizona_hw_params,
+	.hw_free = arizona_hw_free,
 	.set_sysclk = arizona_dai_set_sysclk,
 	.set_tristate = arizona_set_tristate,
 };
@@ -2858,6 +2841,176 @@ int arizona_of_get_audio_pdata(struct arizona *arizona)
 }
 EXPORT_SYMBOL_GPL(arizona_of_get_audio_pdata);
 
+static int arizona_set_rate(struct snd_soc_domain *dom, int rate)
+{
+	struct snd_soc_component *component = dom->component;
+	struct arizona *arizona = dev_get_drvdata(component->dev->parent);
+	const struct arizona_rate_dom_priv *dpriv = dom->driver->private_data;
+	int i, ret;
+
+	dev_dbg(arizona->dev, "Set %s to %d Hz\n", dom->driver->name, rate);
+
+	switch (arizona->type) {
+	case WM5102:
+	case WM8997:
+		if (rate >= 88200)
+			ret = arizona_dvfs_up(component, dpriv->dvfs_mask);
+		else
+			ret = arizona_dvfs_down(component, dpriv->dvfs_mask);
+
+		if (ret) {
+			dev_err(arizona->dev,
+				"Failed to change DVFS for %s: %d\n",
+				dom->driver->name, ret);
+			return ret;
+		}
+		break;
+	default:
+		break;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(arizona_sr_vals); i++) {
+		if (arizona_sr_vals[i] == rate)
+			break;
+	}
+
+	if (i == ARRAY_SIZE(arizona_sr_vals)) {
+		dev_err(arizona->dev, "Invalid sample rate: %d Hz\n", rate);
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(arizona->regmap, dpriv->reg,
+				  ARIZONA_SAMPLE_RATE_1_MASK, i);
+}
+
+static int arizona_get_rate(struct snd_soc_domain *dom)
+{
+	struct snd_soc_component *component = dom->component;
+	struct arizona *arizona = dev_get_drvdata(component->dev->parent);
+	const struct arizona_rate_dom_priv *dpriv = dom->driver->private_data;
+	unsigned int rate;
+	int ret;
+
+	ret = regmap_read(arizona->regmap, dpriv->reg, &rate);
+	if (ret)
+		return ret;
+
+	rate &= ARIZONA_SAMPLE_RATE_1_MASK;
+
+	if (rate >= ARRAY_SIZE(arizona_sr_vals)) {
+		dev_err(arizona->dev, "Read bad sample rate: 0x%x\n", rate);
+		return -EINVAL;
+	}
+
+	rate = arizona_sr_vals[rate];
+
+	dev_dbg(arizona->dev, "Got %u Hz for %s\n", rate, dom->driver->name);
+
+	return (int)rate;
+}
+
+static const struct snd_soc_domain_ops arizona_dom_ops = {
+	.set_rate = arizona_set_rate,
+	.get_rate = arizona_get_rate,
+};
+
+const struct snd_soc_domain_driver arizona_rate_domains[ARIZONA_RATE_ENUM_SIZE] = {
+	{
+		.name = "Sample Rate 1",
+		.ops = &arizona_dom_ops,
+		.private_data = &(struct arizona_rate_dom_priv){
+			.reg = ARIZONA_SAMPLE_RATE_1,
+			.val = 0,
+			.dvfs_mask = ARIZONA_DVFS_SR1_RQ,
+		},
+	},
+	{
+		.name = "Sample Rate 2",
+		.ops = &arizona_dom_ops,
+		.private_data = &(struct arizona_rate_dom_priv){
+			.reg = ARIZONA_SAMPLE_RATE_2,
+			.val = 1,
+			.dvfs_mask = ARIZONA_DVFS_SR2_RQ,
+		},
+	},
+	{
+		.name = "Sample Rate 3",
+		.ops = &arizona_dom_ops,
+		.private_data = &(struct arizona_rate_dom_priv){
+			.reg = ARIZONA_SAMPLE_RATE_3,
+			.val = 2,
+			.dvfs_mask = ARIZONA_DVFS_SR3_RQ,
+		},
+	},
+	{
+		.name = "Async Sample Rate 1",
+		.ops = &arizona_dom_ops,
+		.private_data = &(struct arizona_rate_dom_priv){
+			.reg = ARIZONA_ASYNC_SAMPLE_RATE_1,
+			.val = 8,
+			.dvfs_mask = ARIZONA_DVFS_ASR1_RQ,
+		},
+	},
+	{
+		.name = "Async Sample Rate 2",
+		.ops = &arizona_dom_ops,
+		.private_data = &(struct arizona_rate_dom_priv){
+			.reg = ARIZONA_ASYNC_SAMPLE_RATE_2,
+			.val = 9,
+			.dvfs_mask = ARIZONA_DVFS_ASR2_RQ,
+		},
+	},
+};
+
+int arizona_set_domain(struct snd_soc_domain_group *dgrp, int dom)
+{
+	struct arizona *arizona = dev_get_drvdata(dgrp->component->dev->parent);
+	const struct arizona_rate_grp_priv *gpriv = dgrp->driver->private_data;
+	const struct arizona_rate_dom_priv *dpriv = arizona_rate_domains[dom].private_data;
+
+	return regmap_update_bits(arizona->regmap, gpriv->reg, gpriv->mask,
+			dpriv->val << gpriv->shift);
+}
+
+int arizona_mask_domain(struct snd_soc_domain_group *dgrp, unsigned long *mask)
+{
+	const struct arizona_rate_grp_priv *gpriv = dgrp->driver->private_data;
+	struct snd_soc_component *component = dgrp->component;
+	struct arizona_priv *priv = snd_soc_component_get_drvdata(component);
+	unsigned long supported = 0;
+
+	switch (gpriv->reg) {
+	case ARIZONA_AIF1_RATE_CTRL:
+	case ARIZONA_AIF2_RATE_CTRL:
+	case ARIZONA_AIF3_RATE_CTRL:
+		switch (priv->dai[ARIZONA_AIF1_RATE_CTRL - gpriv->reg].clk) {
+		case ARIZONA_CLK_ASYNCCLK:
+			supported |= 0x18;
+			break;
+		default:
+			supported |= 0x7;
+			break;
+		}
+		break;
+	default:
+		if (gpriv->sync)
+			supported |= 0x7;
+		if (gpriv->async)
+			supported |= 0x18;
+		break;
+	}
+
+	*mask &= supported;
+
+	return 0;
+}
+
+const struct snd_soc_domain_group_ops arizona_dgrp_ops = {
+	.set_domain = arizona_set_domain,
+	.mask_domains = arizona_mask_domain,
+};
+EXPORT_SYMBOL_GPL(arizona_dgrp_ops);
+
 MODULE_DESCRIPTION("ASoC Wolfson Arizona class device support");
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index e3ccee5627c6b..734a90648224f 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -63,6 +63,10 @@
 #define ARIZONA_MAX_ADSP 4
 
 #define ARIZONA_DVFS_SR1_RQ	0x001
+#define ARIZONA_DVFS_SR2_RQ	0x002
+#define ARIZONA_DVFS_SR3_RQ	0x004
+#define ARIZONA_DVFS_ASR1_RQ	0x008
+#define ARIZONA_DVFS_ASR2_RQ	0x010
 #define ARIZONA_DVFS_ADSP1_RQ	0x100
 
 /* Notifier events */
@@ -189,6 +193,26 @@ extern unsigned int arizona_mixer_values[ARIZONA_NUM_MIXER_INPUTS];
 	ARIZONA_MIXER_INPUT_ROUTES(name " Input 3"), \
 	ARIZONA_MIXER_INPUT_ROUTES(name " Input 4")
 
+#define ARIZONA_MUX_ROUTES_R(widget, name, rate) \
+	{ widget, NULL, name " Input" }, \
+	{ name " Input", NULL, rate }, \
+	ARIZONA_MIXER_INPUT_ROUTES(name " Input")
+
+#define ARIZONA_MIXER_ROUTES_R(widget, name, rate) \
+	{ widget, NULL, name " Mixer" },         \
+	{ name " Mixer", NULL, name " Input 1" }, \
+	{ name " Mixer", NULL, name " Input 2" }, \
+	{ name " Mixer", NULL, name " Input 3" }, \
+	{ name " Mixer", NULL, name " Input 4" }, \
+	{ name " Input 1", NULL, rate }, \
+	{ name " Input 2", NULL, rate }, \
+	{ name " Input 3", NULL, rate }, \
+	{ name " Input 4", NULL, rate }, \
+	ARIZONA_MIXER_INPUT_ROUTES(name " Input 1"), \
+	ARIZONA_MIXER_INPUT_ROUTES(name " Input 2"), \
+	ARIZONA_MIXER_INPUT_ROUTES(name " Input 3"), \
+	ARIZONA_MIXER_INPUT_ROUTES(name " Input 4")
+
 #define ARIZONA_DSP_ROUTES(name) \
 	{ name, NULL, name " Preloader"}, \
 	{ name " Preloader", NULL, "SYSCLK" }, \
@@ -208,6 +232,32 @@ extern unsigned int arizona_mixer_values[ARIZONA_NUM_MIXER_INPUTS];
 	ARIZONA_MIXER_ROUTES(name, name "L"), \
 	ARIZONA_MIXER_ROUTES(name, name "R")
 
+#define ARIZONA_DSP_ROUTES_R(name, rate) \
+	{ name, NULL, rate }, \
+	{ name, NULL, name " Preloader"}, \
+	{ name " Preloader", NULL, "SYSCLK" }, \
+	{ name " Preload", NULL, name " Preloader"}, \
+	{ name, NULL, name " Aux 1" }, \
+	{ name, NULL, name " Aux 2" }, \
+	{ name, NULL, name " Aux 3" }, \
+	{ name, NULL, name " Aux 4" }, \
+	{ name, NULL, name " Aux 5" }, \
+	{ name, NULL, name " Aux 6" }, \
+	{ name " Aux 1", NULL, rate }, \
+	{ name " Aux 2", NULL, rate }, \
+	{ name " Aux 3", NULL, rate }, \
+	{ name " Aux 4", NULL, rate }, \
+	{ name " Aux 5", NULL, rate }, \
+	{ name " Aux 6", NULL, rate }, \
+	ARIZONA_MIXER_INPUT_ROUTES(name " Aux 1"), \
+	ARIZONA_MIXER_INPUT_ROUTES(name " Aux 2"), \
+	ARIZONA_MIXER_INPUT_ROUTES(name " Aux 3"), \
+	ARIZONA_MIXER_INPUT_ROUTES(name " Aux 4"), \
+	ARIZONA_MIXER_INPUT_ROUTES(name " Aux 5"), \
+	ARIZONA_MIXER_INPUT_ROUTES(name " Aux 6"), \
+	ARIZONA_MIXER_ROUTES_R(name, name "L", rate), \
+	ARIZONA_MIXER_ROUTES_R(name, name "R", rate)
+
 #define ARIZONA_EQ_CONTROL(xname, xbase)                      \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname,   \
 	.info = snd_soc_bytes_info, .get = snd_soc_bytes_get, \
@@ -222,7 +272,7 @@ extern unsigned int arizona_mixer_values[ARIZONA_NUM_MIXER_INPUTS];
 	((unsigned long)&(struct soc_bytes) { .base = xbase,  \
 	 .num_regs = 1 }) }
 
-#define ARIZONA_RATE_ENUM_SIZE 4
+#define ARIZONA_RATE_ENUM_SIZE 5
 #define ARIZONA_SAMPLE_RATE_ENUM_SIZE 14
 
 extern const char * const arizona_rate_text[ARIZONA_RATE_ENUM_SIZE];
@@ -354,4 +404,28 @@ static inline int arizona_unregister_notifier(struct snd_soc_component *componen
 
 int arizona_of_get_audio_pdata(struct arizona *arizona);
 
+struct arizona_rate_dom_priv {
+	unsigned int reg;
+	unsigned int val;
+	int dvfs_mask;
+};
+
+struct arizona_rate_grp_priv {
+	unsigned int reg;
+	unsigned int mask;
+	unsigned int shift;
+
+	bool sync;
+	bool async;
+};
+
+#define ARIZONA_RATE_WIDGET(rname, rsync, rasync, rreg, rmask) \
+	SND_SOC_DAPM_RATE(rname, SND_SOC_NOPM, 0, 0, &arizona_dgrp_ops, \
+		(&(struct arizona_rate_grp_priv){ .reg = rreg, \
+		.mask = rmask##_MASK, .shift = rmask##_SHIFT, \
+		.sync = rsync, .async = rasync}))
+
+extern const struct snd_soc_domain_group_ops arizona_dgrp_ops;
+extern const struct snd_soc_domain_driver arizona_rate_domains[ARIZONA_RATE_ENUM_SIZE];
+
 #endif
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index b0789a03d699b..930092370735e 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -1092,6 +1092,88 @@ static const struct snd_kcontrol_new wm5110_output_anc_src[] = {
 };
 
 static const struct snd_soc_dapm_widget wm5110_dapm_widgets[] = {
+ARIZONA_RATE_WIDGET("In Rate", 1, 0, ARIZONA_INPUT_RATE, ARIZONA_IN_RATE),
+
+ARIZONA_RATE_WIDGET("Out Rate", 1, 0, ARIZONA_OUTPUT_RATE_1, ARIZONA_OUT_RATE),
+ARIZONA_RATE_WIDGET("PWM Rate", 1, 0, ARIZONA_PWM_DRIVE_1, ARIZONA_PWM_RATE),
+
+ARIZONA_RATE_WIDGET("Tone Rate", 1, 1, ARIZONA_TONE_GENERATOR_1,
+		    ARIZONA_TONE_RATE),
+ARIZONA_RATE_WIDGET("Noise Rate", 1, 1, ARIZONA_COMFORT_NOISE_GENERATOR,
+		    ARIZONA_NOISE_GEN_RATE),
+ARIZONA_RATE_WIDGET("Haptics Rate", 1, 0, ARIZONA_HAPTICS_CONTROL_1,
+		    ARIZONA_HAP_RATE),
+ARIZONA_RATE_WIDGET("FX Rate", 1, 1, ARIZONA_FX_CTRL1, ARIZONA_FX_RATE),
+
+ARIZONA_RATE_WIDGET("AIF1 Rate", 1, 1, ARIZONA_AIF1_RATE_CTRL,
+		    ARIZONA_AIF1_RATE),
+ARIZONA_RATE_WIDGET("AIF2 Rate", 1, 1, ARIZONA_AIF2_RATE_CTRL,
+		    ARIZONA_AIF2_RATE),
+ARIZONA_RATE_WIDGET("AIF3 Rate", 1, 1, ARIZONA_AIF3_RATE_CTRL,
+		    ARIZONA_AIF3_RATE),
+
+ARIZONA_RATE_WIDGET("ASRC Rate", 1, 0, ARIZONA_ASRC_RATE1, ARIZONA_ASRC_RATE1),
+ARIZONA_RATE_WIDGET("ASRC Async Rate", 0, 1, ARIZONA_ASRC_RATE2,
+		    ARIZONA_ASRC_RATE2),
+
+ARIZONA_RATE_WIDGET("Mic Mute Rate", 1, 1, ARIZONA_MIC_NOISE_MIX_CONTROL_1,
+		    ARIZONA_MICMUTE_RATE),
+
+ARIZONA_RATE_WIDGET("ISRC1 FSH", 1, 1, ARIZONA_ISRC_1_CTRL_1,
+		    ARIZONA_ISRC1_FSH),
+ARIZONA_RATE_WIDGET("ISRC1 FSL", 1, 1, ARIZONA_ISRC_1_CTRL_2,
+		    ARIZONA_ISRC1_FSL),
+ARIZONA_RATE_WIDGET("ISRC2 FSH", 1, 1, ARIZONA_ISRC_2_CTRL_1,
+		    ARIZONA_ISRC2_FSH),
+ARIZONA_RATE_WIDGET("ISRC2 FSL", 1, 1, ARIZONA_ISRC_2_CTRL_2,
+		    ARIZONA_ISRC2_FSL),
+ARIZONA_RATE_WIDGET("ISRC3 FSH", 1, 1, ARIZONA_ISRC_3_CTRL_1,
+		    ARIZONA_ISRC3_FSH),
+ARIZONA_RATE_WIDGET("ISRC3 FSL", 1, 1, ARIZONA_ISRC_3_CTRL_2,
+		    ARIZONA_ISRC3_FSL),
+
+ARIZONA_RATE_WIDGET("DSP1 Rate", 1, 1, ARIZONA_DSP1_CONTROL_1,
+		    ARIZONA_DSP1_RATE),
+ARIZONA_RATE_WIDGET("DSP2 Rate", 1, 1, ARIZONA_DSP2_CONTROL_1,
+		    ARIZONA_DSP1_RATE),
+ARIZONA_RATE_WIDGET("DSP3 Rate", 1, 1, ARIZONA_DSP3_CONTROL_1,
+		    ARIZONA_DSP1_RATE),
+ARIZONA_RATE_WIDGET("DSP4 Rate", 1, 1, ARIZONA_DSP4_CONTROL_1,
+		    ARIZONA_DSP1_RATE),
+
+ARIZONA_RATE_WIDGET("SLIMRX1 Rate", 1, 1, ARIZONA_SLIMBUS_RATES_1,
+		    ARIZONA_SLIMRX1_RATE),
+ARIZONA_RATE_WIDGET("SLIMRX2 Rate", 1, 1, ARIZONA_SLIMBUS_RATES_1,
+		    ARIZONA_SLIMRX2_RATE),
+ARIZONA_RATE_WIDGET("SLIMRX3 Rate", 1, 1, ARIZONA_SLIMBUS_RATES_2,
+		    ARIZONA_SLIMRX3_RATE),
+ARIZONA_RATE_WIDGET("SLIMRX4 Rate", 1, 1, ARIZONA_SLIMBUS_RATES_2,
+		    ARIZONA_SLIMRX4_RATE),
+ARIZONA_RATE_WIDGET("SLIMRX5 Rate", 1, 1, ARIZONA_SLIMBUS_RATES_3,
+		    ARIZONA_SLIMRX5_RATE),
+ARIZONA_RATE_WIDGET("SLIMRX6 Rate", 1, 1, ARIZONA_SLIMBUS_RATES_3,
+		    ARIZONA_SLIMRX6_RATE),
+ARIZONA_RATE_WIDGET("SLIMRX7 Rate", 1, 1, ARIZONA_SLIMBUS_RATES_4,
+		    ARIZONA_SLIMRX7_RATE),
+ARIZONA_RATE_WIDGET("SLIMRX8 Rate", 1, 1, ARIZONA_SLIMBUS_RATES_4,
+		    ARIZONA_SLIMRX8_RATE),
+ARIZONA_RATE_WIDGET("SLIMTX1 Rate", 1, 1, ARIZONA_SLIMBUS_RATES_5,
+		    ARIZONA_SLIMTX1_RATE),
+ARIZONA_RATE_WIDGET("SLIMTX2 Rate", 1, 1, ARIZONA_SLIMBUS_RATES_5,
+		    ARIZONA_SLIMTX2_RATE),
+ARIZONA_RATE_WIDGET("SLIMTX3 Rate", 1, 1, ARIZONA_SLIMBUS_RATES_6,
+		    ARIZONA_SLIMTX3_RATE),
+ARIZONA_RATE_WIDGET("SLIMTX4 Rate", 1, 1, ARIZONA_SLIMBUS_RATES_6,
+		    ARIZONA_SLIMTX4_RATE),
+ARIZONA_RATE_WIDGET("SLIMTX5 Rate", 1, 1, ARIZONA_SLIMBUS_RATES_7,
+		    ARIZONA_SLIMTX5_RATE),
+ARIZONA_RATE_WIDGET("SLIMTX6 Rate", 1, 1, ARIZONA_SLIMBUS_RATES_7,
+		    ARIZONA_SLIMTX6_RATE),
+ARIZONA_RATE_WIDGET("SLIMTX7 Rate", 1, 1, ARIZONA_SLIMBUS_RATES_8,
+		    ARIZONA_SLIMTX7_RATE),
+ARIZONA_RATE_WIDGET("SLIMTX8 Rate", 1, 1, ARIZONA_SLIMBUS_RATES_8,
+		    ARIZONA_SLIMTX8_RATE),
+
 SND_SOC_DAPM_SUPPLY("SYSCLK", ARIZONA_SYSTEM_CLOCK_1, ARIZONA_SYSCLK_ENA_SHIFT,
 		    0, wm5110_sysclk_ev, SND_SOC_DAPM_POST_PMU |
 		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
@@ -1728,6 +1810,119 @@ SND_SOC_DAPM_OUTPUT("MICSUPP"),
 	{ name, "DSP4.6", "DSP4" }
 
 static const struct snd_soc_dapm_route wm5110_dapm_routes[] = {
+	{ "IN1L PGA", NULL, "In Rate" },
+	{ "IN1R PGA", NULL, "In Rate" },
+	{ "IN2L PGA", NULL, "In Rate" },
+	{ "IN2R PGA", NULL, "In Rate" },
+	{ "IN3L PGA", NULL, "In Rate" },
+	{ "IN3R PGA", NULL, "In Rate" },
+	{ "IN4L PGA", NULL, "In Rate" },
+	{ "IN4R PGA", NULL, "In Rate" },
+
+	{ "AIF1 Playback", NULL, "AIF1 Rate" },
+	{ "AIF1 Capture", NULL, "AIF1 Rate" },
+	{ "AIF1RX1", NULL, "AIF1 Rate" },
+	{ "AIF1RX2", NULL, "AIF1 Rate" },
+	{ "AIF1RX3", NULL, "AIF1 Rate" },
+	{ "AIF1RX4", NULL, "AIF1 Rate" },
+	{ "AIF1RX5", NULL, "AIF1 Rate" },
+	{ "AIF1RX6", NULL, "AIF1 Rate" },
+	{ "AIF1RX7", NULL, "AIF1 Rate" },
+	{ "AIF1RX8", NULL, "AIF1 Rate" },
+
+	{ "AIF2 Playback", NULL, "AIF2 Rate" },
+	{ "AIF2 Capture", NULL, "AIF2 Rate" },
+	{ "AIF2RX1", NULL, "AIF2 Rate" },
+	{ "AIF2RX2", NULL, "AIF2 Rate" },
+	{ "AIF2RX3", NULL, "AIF2 Rate" },
+	{ "AIF2RX4", NULL, "AIF2 Rate" },
+	{ "AIF2RX5", NULL, "AIF2 Rate" },
+	{ "AIF2RX6", NULL, "AIF2 Rate" },
+
+	{ "AIF3 Playback", NULL, "AIF3 Rate" },
+	{ "AIF3 Capture", NULL, "AIF3 Rate" },
+	{ "AIF3RX1", NULL, "AIF3 Rate" },
+	{ "AIF3RX2", NULL, "AIF3 Rate" },
+
+	{ "EQ1", NULL, "FX Rate" },
+	{ "EQ2", NULL, "FX Rate" },
+	{ "EQ3", NULL, "FX Rate" },
+	{ "EQ4", NULL, "FX Rate" },
+
+	{ "DRC1L", NULL, "FX Rate" },
+	{ "DRC1R", NULL, "FX Rate" },
+	{ "DRC2L", NULL, "FX Rate" },
+	{ "DRC2R", NULL, "FX Rate" },
+
+	{ "LHPF1", NULL, "FX Rate" },
+	{ "LHPF2", NULL, "FX Rate" },
+	{ "LHPF3", NULL, "FX Rate" },
+	{ "LHPF4", NULL, "FX Rate" },
+
+	{ "PWM1 Driver", NULL, "PWM Rate" },
+	{ "PWM2 Driver", NULL, "PWM Rate" },
+
+	{ "HAPTICS", NULL, "Haptics Rate" },
+
+	{ "Noise Generator", NULL, "Noise Rate" },
+	{ "Tone Generator 1", NULL, "Tone Rate" },
+	{ "Tone Generator 2", NULL, "Tone Rate" },
+
+	{ "Mic Mute Mixer", NULL, "Mic Mute Rate" },
+
+	{ "ASRC1L", NULL, "ASRC Async Rate" },
+	{ "ASRC1R", NULL, "ASRC Async Rate" },
+	{ "ASRC2L", NULL, "ASRC Rate" },
+	{ "ASRC2R", NULL, "ASRC Rate" },
+
+	{ "ISRC1INT1", NULL, "ISRC1 FSH" },
+	{ "ISRC1INT2", NULL, "ISRC1 FSH" },
+	{ "ISRC1INT3", NULL, "ISRC1 FSH" },
+	{ "ISRC1INT4", NULL, "ISRC1 FSH" },
+
+	{ "ISRC1DEC1", NULL, "ISRC1 FSL" },
+	{ "ISRC1DEC2", NULL, "ISRC1 FSL" },
+	{ "ISRC1DEC3", NULL, "ISRC1 FSL" },
+	{ "ISRC1DEC4", NULL, "ISRC1 FSL" },
+
+	{ "ISRC2INT1", NULL, "ISRC2 FSH" },
+	{ "ISRC2INT2", NULL, "ISRC2 FSH" },
+	{ "ISRC2INT3", NULL, "ISRC2 FSH" },
+	{ "ISRC2INT4", NULL, "ISRC2 FSH" },
+
+	{ "ISRC2DEC1", NULL, "ISRC2 FSL" },
+	{ "ISRC2DEC2", NULL, "ISRC2 FSL" },
+	{ "ISRC2DEC3", NULL, "ISRC2 FSL" },
+	{ "ISRC2DEC4", NULL, "ISRC2 FSL" },
+
+	{ "ISRC3INT1", NULL, "ISRC3 FSH" },
+	{ "ISRC3INT2", NULL, "ISRC3 FSH" },
+	{ "ISRC3INT3", NULL, "ISRC3 FSH" },
+	{ "ISRC3INT4", NULL, "ISRC3 FSH" },
+
+	{ "ISRC3DEC1", NULL, "ISRC3 FSL" },
+	{ "ISRC3DEC2", NULL, "ISRC3 FSL" },
+	{ "ISRC3DEC3", NULL, "ISRC3 FSL" },
+	{ "ISRC3DEC4", NULL, "ISRC3 FSL" },
+
+	{ "SLIMRX1", NULL, "SLIMRX1 Rate" },
+	{ "SLIMRX2", NULL, "SLIMRX2 Rate" },
+	{ "SLIMRX3", NULL, "SLIMRX3 Rate" },
+	{ "SLIMRX4", NULL, "SLIMRX4 Rate" },
+	{ "SLIMRX5", NULL, "SLIMRX5 Rate" },
+	{ "SLIMRX6", NULL, "SLIMRX6 Rate" },
+	{ "SLIMRX7", NULL, "SLIMRX7 Rate" },
+	{ "SLIMRX8", NULL, "SLIMRX8 Rate" },
+
+	{ "Slim1 Playback", NULL, "SLIMRX1 Rate" },
+	{ "Slim1 Capture", NULL, "SLIMTX1 Rate" },
+
+	{ "Slim2 Playback", NULL, "SLIMRX5 Rate" },
+	{ "Slim2 Capture", NULL, "SLIMTX5 Rate" },
+
+	{ "Slim3 Playback", NULL, "SLIMRX7 Rate" },
+	{ "Slim3 Capture", NULL, "SLIMTX7 Rate" },
+
 	{ "AIF2 Capture", NULL, "DBVDD2" },
 	{ "AIF2 Playback", NULL, "DBVDD2" },
 
@@ -1878,108 +2073,108 @@ static const struct snd_soc_dapm_route wm5110_dapm_routes[] = {
 	{ "IN4L PGA", NULL, "IN4L" },
 	{ "IN4R PGA", NULL, "IN4R" },
 
-	ARIZONA_MIXER_ROUTES("OUT1L", "HPOUT1L"),
-	ARIZONA_MIXER_ROUTES("OUT1R", "HPOUT1R"),
-	ARIZONA_MIXER_ROUTES("OUT2L", "HPOUT2L"),
-	ARIZONA_MIXER_ROUTES("OUT2R", "HPOUT2R"),
-	ARIZONA_MIXER_ROUTES("OUT3L", "HPOUT3L"),
-	ARIZONA_MIXER_ROUTES("OUT3R", "HPOUT3R"),
-
-	ARIZONA_MIXER_ROUTES("OUT4L", "SPKOUTL"),
-	ARIZONA_MIXER_ROUTES("OUT4R", "SPKOUTR"),
-	ARIZONA_MIXER_ROUTES("OUT5L", "SPKDAT1L"),
-	ARIZONA_MIXER_ROUTES("OUT5R", "SPKDAT1R"),
-	ARIZONA_MIXER_ROUTES("OUT6L", "SPKDAT2L"),
-	ARIZONA_MIXER_ROUTES("OUT6R", "SPKDAT2R"),
-
-	ARIZONA_MIXER_ROUTES("PWM1 Driver", "PWM1"),
-	ARIZONA_MIXER_ROUTES("PWM2 Driver", "PWM2"),
-
-	ARIZONA_MIXER_ROUTES("AIF1TX1", "AIF1TX1"),
-	ARIZONA_MIXER_ROUTES("AIF1TX2", "AIF1TX2"),
-	ARIZONA_MIXER_ROUTES("AIF1TX3", "AIF1TX3"),
-	ARIZONA_MIXER_ROUTES("AIF1TX4", "AIF1TX4"),
-	ARIZONA_MIXER_ROUTES("AIF1TX5", "AIF1TX5"),
-	ARIZONA_MIXER_ROUTES("AIF1TX6", "AIF1TX6"),
-	ARIZONA_MIXER_ROUTES("AIF1TX7", "AIF1TX7"),
-	ARIZONA_MIXER_ROUTES("AIF1TX8", "AIF1TX8"),
-
-	ARIZONA_MIXER_ROUTES("AIF2TX1", "AIF2TX1"),
-	ARIZONA_MIXER_ROUTES("AIF2TX2", "AIF2TX2"),
-	ARIZONA_MIXER_ROUTES("AIF2TX3", "AIF2TX3"),
-	ARIZONA_MIXER_ROUTES("AIF2TX4", "AIF2TX4"),
-	ARIZONA_MIXER_ROUTES("AIF2TX5", "AIF2TX5"),
-	ARIZONA_MIXER_ROUTES("AIF2TX6", "AIF2TX6"),
-
-	ARIZONA_MIXER_ROUTES("AIF3TX1", "AIF3TX1"),
-	ARIZONA_MIXER_ROUTES("AIF3TX2", "AIF3TX2"),
-
-	ARIZONA_MIXER_ROUTES("SLIMTX1", "SLIMTX1"),
-	ARIZONA_MIXER_ROUTES("SLIMTX2", "SLIMTX2"),
-	ARIZONA_MIXER_ROUTES("SLIMTX3", "SLIMTX3"),
-	ARIZONA_MIXER_ROUTES("SLIMTX4", "SLIMTX4"),
-	ARIZONA_MIXER_ROUTES("SLIMTX5", "SLIMTX5"),
-	ARIZONA_MIXER_ROUTES("SLIMTX6", "SLIMTX6"),
-	ARIZONA_MIXER_ROUTES("SLIMTX7", "SLIMTX7"),
-	ARIZONA_MIXER_ROUTES("SLIMTX8", "SLIMTX8"),
-
-	ARIZONA_MIXER_ROUTES("EQ1", "EQ1"),
-	ARIZONA_MIXER_ROUTES("EQ2", "EQ2"),
-	ARIZONA_MIXER_ROUTES("EQ3", "EQ3"),
-	ARIZONA_MIXER_ROUTES("EQ4", "EQ4"),
-
-	ARIZONA_MIXER_ROUTES("DRC1L", "DRC1L"),
-	ARIZONA_MIXER_ROUTES("DRC1R", "DRC1R"),
-	ARIZONA_MIXER_ROUTES("DRC2L", "DRC2L"),
-	ARIZONA_MIXER_ROUTES("DRC2R", "DRC2R"),
-
-	ARIZONA_MIXER_ROUTES("LHPF1", "LHPF1"),
-	ARIZONA_MIXER_ROUTES("LHPF2", "LHPF2"),
-	ARIZONA_MIXER_ROUTES("LHPF3", "LHPF3"),
-	ARIZONA_MIXER_ROUTES("LHPF4", "LHPF4"),
-
-	ARIZONA_MIXER_ROUTES("Mic Mute Mixer", "Noise"),
-	ARIZONA_MIXER_ROUTES("Mic Mute Mixer", "Mic"),
-
-	ARIZONA_MUX_ROUTES("ASRC1L", "ASRC1L"),
-	ARIZONA_MUX_ROUTES("ASRC1R", "ASRC1R"),
-	ARIZONA_MUX_ROUTES("ASRC2L", "ASRC2L"),
-	ARIZONA_MUX_ROUTES("ASRC2R", "ASRC2R"),
-
-	ARIZONA_DSP_ROUTES("DSP1"),
-	ARIZONA_DSP_ROUTES("DSP2"),
-	ARIZONA_DSP_ROUTES("DSP3"),
-	ARIZONA_DSP_ROUTES("DSP4"),
-
-	ARIZONA_MUX_ROUTES("ISRC1INT1", "ISRC1INT1"),
-	ARIZONA_MUX_ROUTES("ISRC1INT2", "ISRC1INT2"),
-	ARIZONA_MUX_ROUTES("ISRC1INT3", "ISRC1INT3"),
-	ARIZONA_MUX_ROUTES("ISRC1INT4", "ISRC1INT4"),
-
-	ARIZONA_MUX_ROUTES("ISRC1DEC1", "ISRC1DEC1"),
-	ARIZONA_MUX_ROUTES("ISRC1DEC2", "ISRC1DEC2"),
-	ARIZONA_MUX_ROUTES("ISRC1DEC3", "ISRC1DEC3"),
-	ARIZONA_MUX_ROUTES("ISRC1DEC4", "ISRC1DEC4"),
-
-	ARIZONA_MUX_ROUTES("ISRC2INT1", "ISRC2INT1"),
-	ARIZONA_MUX_ROUTES("ISRC2INT2", "ISRC2INT2"),
-	ARIZONA_MUX_ROUTES("ISRC2INT3", "ISRC2INT3"),
-	ARIZONA_MUX_ROUTES("ISRC2INT4", "ISRC2INT4"),
-
-	ARIZONA_MUX_ROUTES("ISRC2DEC1", "ISRC2DEC1"),
-	ARIZONA_MUX_ROUTES("ISRC2DEC2", "ISRC2DEC2"),
-	ARIZONA_MUX_ROUTES("ISRC2DEC3", "ISRC2DEC3"),
-	ARIZONA_MUX_ROUTES("ISRC2DEC4", "ISRC2DEC4"),
-
-	ARIZONA_MUX_ROUTES("ISRC3INT1", "ISRC3INT1"),
-	ARIZONA_MUX_ROUTES("ISRC3INT2", "ISRC3INT2"),
-	ARIZONA_MUX_ROUTES("ISRC3INT3", "ISRC3INT3"),
-	ARIZONA_MUX_ROUTES("ISRC3INT4", "ISRC3INT4"),
-
-	ARIZONA_MUX_ROUTES("ISRC3DEC1", "ISRC3DEC1"),
-	ARIZONA_MUX_ROUTES("ISRC3DEC2", "ISRC3DEC2"),
-	ARIZONA_MUX_ROUTES("ISRC3DEC3", "ISRC3DEC3"),
-	ARIZONA_MUX_ROUTES("ISRC3DEC4", "ISRC3DEC4"),
+	ARIZONA_MIXER_ROUTES_R("OUT1L", "HPOUT1L", "Out Rate"),
+	ARIZONA_MIXER_ROUTES_R("OUT1R", "HPOUT1R", "Out Rate"),
+	ARIZONA_MIXER_ROUTES_R("OUT2L", "HPOUT2L", "Out Rate"),
+	ARIZONA_MIXER_ROUTES_R("OUT2R", "HPOUT2R", "Out Rate"),
+	ARIZONA_MIXER_ROUTES_R("OUT3L", "HPOUT3L", "Out Rate"),
+	ARIZONA_MIXER_ROUTES_R("OUT3R", "HPOUT3R", "Out Rate"),
+
+	ARIZONA_MIXER_ROUTES_R("OUT4L", "SPKOUTL", "Out Rate"),
+	ARIZONA_MIXER_ROUTES_R("OUT4R", "SPKOUTR", "Out Rate"),
+	ARIZONA_MIXER_ROUTES_R("OUT5L", "SPKDAT1L", "Out Rate"),
+	ARIZONA_MIXER_ROUTES_R("OUT5R", "SPKDAT1R", "Out Rate"),
+	ARIZONA_MIXER_ROUTES_R("OUT6L", "SPKDAT2L", "Out Rate"),
+	ARIZONA_MIXER_ROUTES_R("OUT6R", "SPKDAT2R", "Out Rate"),
+
+	ARIZONA_MIXER_ROUTES_R("PWM1 Driver", "PWM1", "PWM Rate"),
+	ARIZONA_MIXER_ROUTES_R("PWM2 Driver", "PWM2", "PWM Rate"),
+
+	ARIZONA_MIXER_ROUTES_R("AIF1TX1", "AIF1TX1", "AIF1 Rate"),
+	ARIZONA_MIXER_ROUTES_R("AIF1TX2", "AIF1TX2", "AIF1 Rate"),
+	ARIZONA_MIXER_ROUTES_R("AIF1TX3", "AIF1TX3", "AIF1 Rate"),
+	ARIZONA_MIXER_ROUTES_R("AIF1TX4", "AIF1TX4", "AIF1 Rate"),
+	ARIZONA_MIXER_ROUTES_R("AIF1TX5", "AIF1TX5", "AIF1 Rate"),
+	ARIZONA_MIXER_ROUTES_R("AIF1TX6", "AIF1TX6", "AIF1 Rate"),
+	ARIZONA_MIXER_ROUTES_R("AIF1TX7", "AIF1TX7", "AIF1 Rate"),
+	ARIZONA_MIXER_ROUTES_R("AIF1TX8", "AIF1TX8", "AIF1 Rate"),
+
+	ARIZONA_MIXER_ROUTES_R("AIF2TX1", "AIF2TX1", "AIF2 Rate"),
+	ARIZONA_MIXER_ROUTES_R("AIF2TX2", "AIF2TX2", "AIF2 Rate"),
+	ARIZONA_MIXER_ROUTES_R("AIF2TX3", "AIF2TX3", "AIF2 Rate"),
+	ARIZONA_MIXER_ROUTES_R("AIF2TX4", "AIF2TX4", "AIF2 Rate"),
+	ARIZONA_MIXER_ROUTES_R("AIF2TX5", "AIF2TX5", "AIF2 Rate"),
+	ARIZONA_MIXER_ROUTES_R("AIF2TX6", "AIF2TX6", "AIF2 Rate"),
+
+	ARIZONA_MIXER_ROUTES_R("AIF3TX1", "AIF3TX1", "AIF3 Rate"),
+	ARIZONA_MIXER_ROUTES_R("AIF3TX2", "AIF3TX2", "AIF3 Rate"),
+
+	ARIZONA_MIXER_ROUTES_R("SLIMTX1", "SLIMTX1", "SLIMTX1 Rate"),
+	ARIZONA_MIXER_ROUTES_R("SLIMTX2", "SLIMTX2", "SLIMTX2 Rate"),
+	ARIZONA_MIXER_ROUTES_R("SLIMTX3", "SLIMTX3", "SLIMTX3 Rate"),
+	ARIZONA_MIXER_ROUTES_R("SLIMTX4", "SLIMTX4", "SLIMTX4 Rate"),
+	ARIZONA_MIXER_ROUTES_R("SLIMTX5", "SLIMTX5", "SLIMTX5 Rate"),
+	ARIZONA_MIXER_ROUTES_R("SLIMTX6", "SLIMTX6", "SLIMTX6 Rate"),
+	ARIZONA_MIXER_ROUTES_R("SLIMTX7", "SLIMTX7", "SLIMTX7 Rate"),
+	ARIZONA_MIXER_ROUTES_R("SLIMTX8", "SLIMTX8", "SLIMTX8 Rate"),
+
+	ARIZONA_MIXER_ROUTES_R("EQ1", "EQ1", "FX Rate"),
+	ARIZONA_MIXER_ROUTES_R("EQ2", "EQ2", "FX Rate"),
+	ARIZONA_MIXER_ROUTES_R("EQ3", "EQ3", "FX Rate"),
+	ARIZONA_MIXER_ROUTES_R("EQ4", "EQ4", "FX Rate"),
+
+	ARIZONA_MIXER_ROUTES_R("DRC1L", "DRC1L", "FX Rate"),
+	ARIZONA_MIXER_ROUTES_R("DRC1R", "DRC1R", "FX Rate"),
+	ARIZONA_MIXER_ROUTES_R("DRC2L", "DRC2L", "FX Rate"),
+	ARIZONA_MIXER_ROUTES_R("DRC2R", "DRC2R", "FX Rate"),
+
+	ARIZONA_MIXER_ROUTES_R("LHPF1", "LHPF1", "FX Rate"),
+	ARIZONA_MIXER_ROUTES_R("LHPF2", "LHPF2", "FX Rate"),
+	ARIZONA_MIXER_ROUTES_R("LHPF3", "LHPF3", "FX Rate"),
+	ARIZONA_MIXER_ROUTES_R("LHPF4", "LHPF4", "FX Rate"),
+
+	ARIZONA_MIXER_ROUTES_R("Mic Mute Mixer", "Noise", "Mic Mute Rate"),
+	ARIZONA_MIXER_ROUTES_R("Mic Mute Mixer", "Mic", "Mic Mute Rate"),
+
+	ARIZONA_MUX_ROUTES_R("ASRC1L", "ASRC1L", "ASRC Rate"),
+	ARIZONA_MUX_ROUTES_R("ASRC1R", "ASRC1R", "ASRC Rate"),
+	ARIZONA_MUX_ROUTES_R("ASRC2L", "ASRC2L", "ASRC Async Rate"),
+	ARIZONA_MUX_ROUTES_R("ASRC2R", "ASRC2R", "ASRC Async Rate"),
+
+	ARIZONA_DSP_ROUTES_R("DSP1", "DSP1 Rate"),
+	ARIZONA_DSP_ROUTES_R("DSP2", "DSP2 Rate"),
+	ARIZONA_DSP_ROUTES_R("DSP3", "DSP3 Rate"),
+	ARIZONA_DSP_ROUTES_R("DSP4", "DSP4 Rate"),
+
+	ARIZONA_MUX_ROUTES_R("ISRC1INT1", "ISRC1INT1", "ISRC1 FSL"),
+	ARIZONA_MUX_ROUTES_R("ISRC1INT2", "ISRC1INT2", "ISRC1 FSL"),
+	ARIZONA_MUX_ROUTES_R("ISRC1INT3", "ISRC1INT3", "ISRC1 FSL"),
+	ARIZONA_MUX_ROUTES_R("ISRC1INT4", "ISRC1INT4", "ISRC1 FSL"),
+
+	ARIZONA_MUX_ROUTES_R("ISRC1DEC1", "ISRC1DEC1", "ISRC1 FSH"),
+	ARIZONA_MUX_ROUTES_R("ISRC1DEC2", "ISRC1DEC2", "ISRC1 FSH"),
+	ARIZONA_MUX_ROUTES_R("ISRC1DEC3", "ISRC1DEC3", "ISRC1 FSH"),
+	ARIZONA_MUX_ROUTES_R("ISRC1DEC4", "ISRC1DEC4", "ISRC1 FSH"),
+
+	ARIZONA_MUX_ROUTES_R("ISRC2INT1", "ISRC2INT1", "ISRC2 FSL"),
+	ARIZONA_MUX_ROUTES_R("ISRC2INT2", "ISRC2INT2", "ISRC2 FSL"),
+	ARIZONA_MUX_ROUTES_R("ISRC2INT3", "ISRC2INT3", "ISRC2 FSL"),
+	ARIZONA_MUX_ROUTES_R("ISRC2INT4", "ISRC2INT4", "ISRC2 FSL"),
+
+	ARIZONA_MUX_ROUTES_R("ISRC2DEC1", "ISRC2DEC1", "ISRC2 FSH"),
+	ARIZONA_MUX_ROUTES_R("ISRC2DEC2", "ISRC2DEC2", "ISRC2 FSH"),
+	ARIZONA_MUX_ROUTES_R("ISRC2DEC3", "ISRC2DEC3", "ISRC2 FSH"),
+	ARIZONA_MUX_ROUTES_R("ISRC2DEC4", "ISRC2DEC4", "ISRC2 FSH"),
+
+	ARIZONA_MUX_ROUTES_R("ISRC3INT1", "ISRC3INT1", "ISRC3 FSL"),
+	ARIZONA_MUX_ROUTES_R("ISRC3INT2", "ISRC3INT2", "ISRC3 FSL"),
+	ARIZONA_MUX_ROUTES_R("ISRC3INT3", "ISRC3INT3", "ISRC3 FSL"),
+	ARIZONA_MUX_ROUTES_R("ISRC3INT4", "ISRC3INT4", "ISRC3 FSL"),
+
+	ARIZONA_MUX_ROUTES_R("ISRC3DEC1", "ISRC3DEC1", "ISRC3 FSH"),
+	ARIZONA_MUX_ROUTES_R("ISRC3DEC2", "ISRC3DEC2", "ISRC3 FSH"),
+	ARIZONA_MUX_ROUTES_R("ISRC3DEC3", "ISRC3DEC3", "ISRC3 FSH"),
+	ARIZONA_MUX_ROUTES_R("ISRC3DEC4", "ISRC3DEC4", "ISRC3 FSH"),
 
 	{ "AEC Loopback", "HPOUT1L", "OUT1L" },
 	{ "AEC Loopback", "HPOUT1R", "OUT1R" },
@@ -2319,6 +2514,19 @@ static int wm5110_component_probe(struct snd_soc_component *component)
 
 	snd_soc_component_disable_pin(component, "HAPTICS");
 
+	snd_soc_dapm_connect_domains(dapm, "SLIMRX1 Rate", "SLIMRX2 Rate");
+	snd_soc_dapm_connect_domains(dapm, "SLIMRX1 Rate", "SLIMRX3 Rate");
+	snd_soc_dapm_connect_domains(dapm, "SLIMRX1 Rate", "SLIMRX4 Rate");
+	snd_soc_dapm_connect_domains(dapm, "SLIMTX1 Rate", "SLIMTX2 Rate");
+	snd_soc_dapm_connect_domains(dapm, "SLIMTX1 Rate", "SLIMTX3 Rate");
+	snd_soc_dapm_connect_domains(dapm, "SLIMTX1 Rate", "SLIMTX4 Rate");
+
+	snd_soc_dapm_connect_domains(dapm, "SLIMRX5 Rate", "SLIMRX6 Rate");
+	snd_soc_dapm_connect_domains(dapm, "SLIMTX5 Rate", "SLIMTX6 Rate");
+
+	snd_soc_dapm_connect_domains(dapm, "SLIMRX7 Rate", "SLIMRX8 Rate");
+	snd_soc_dapm_connect_domains(dapm, "SLIMTX7 Rate", "SLIMTX8 Rate");
+
 	return 0;
 
 err_adsp2_codec_probe:
@@ -2379,6 +2587,8 @@ static const struct snd_soc_component_driver soc_component_dev_wm5110 = {
 	.num_dapm_widgets	= ARRAY_SIZE(wm5110_dapm_widgets),
 	.dapm_routes		= wm5110_dapm_routes,
 	.num_dapm_routes	= ARRAY_SIZE(wm5110_dapm_routes),
+	.domains		= arizona_rate_domains,
+	.num_domains		= ARRAY_SIZE(arizona_rate_domains),
 	.use_pmdown_time	= 1,
 	.endianness		= 1,
 	.non_legacy_dai_naming	= 1,
-- 
2.11.0
