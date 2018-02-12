From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8996: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:47:30 +0000
Message-ID: <E1elDW6-0005f3-0A@debutante>
References: <871si94b3r.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9956D267A80
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:47:32 +0100 (CET)
In-Reply-To: <871si94b3r.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: wm8996: replace codec to component

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

>From 5d61ef8b07db82746f61927628730ce0407b8897 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:08:15 +0000
Subject: [PATCH] ASoC: wm8996: replace codec to component

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
 sound/soc/codecs/wm8996.c    | 401 +++++++++++++++++++++----------------------
 sound/soc/codecs/wm8996.h    |   4 +-
 sound/soc/samsung/speyside.c |  12 +-
 3 files changed, 206 insertions(+), 211 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 8affa4969120..d9d206046f8c 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -53,7 +53,7 @@ static const char *wm8996_supply_names[WM8996_NUM_SUPPLIES] = {
 struct wm8996_priv {
 	struct device *dev;
 	struct regmap *regmap;
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 
 	int ldo1ena;
 
@@ -335,9 +335,9 @@ static SOC_ENUM_SINGLE_DECL(dsp1tx_hpf_cutoff,
 static SOC_ENUM_SINGLE_DECL(dsp2tx_hpf_cutoff,
 			    WM8996_DSP2_TX_FILTERS, 0, hpf_cutoff_text);
 
-static void wm8996_set_retune_mobile(struct snd_soc_codec *codec, int block)
+static void wm8996_set_retune_mobile(struct snd_soc_component *component, int block)
 {
-	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
+	struct wm8996_priv *wm8996 = snd_soc_component_get_drvdata(component);
 	struct wm8996_pdata *pdata = &wm8996->pdata;
 	int base, best, best_val, save, i, cfg, iface;
 
@@ -347,7 +347,7 @@ static void wm8996_set_retune_mobile(struct snd_soc_codec *codec, int block)
 	switch (block) {
 	case 0:
 		base = WM8996_DSP1_RX_EQ_GAINS_1;
-		if (snd_soc_read(codec, WM8996_POWER_MANAGEMENT_8) &
+		if (snd_soc_component_read32(component, WM8996_POWER_MANAGEMENT_8) &
 		    WM8996_DSP1RX_SRC)
 			iface = 1;
 		else
@@ -355,7 +355,7 @@ static void wm8996_set_retune_mobile(struct snd_soc_codec *codec, int block)
 		break;
 	case 1:
 		base = WM8996_DSP1_RX_EQ_GAINS_2;
-		if (snd_soc_read(codec, WM8996_POWER_MANAGEMENT_8) &
+		if (snd_soc_component_read32(component, WM8996_POWER_MANAGEMENT_8) &
 		    WM8996_DSP2RX_SRC)
 			iface = 1;
 		else
@@ -381,7 +381,7 @@ static void wm8996_set_retune_mobile(struct snd_soc_codec *codec, int block)
 		}
 	}
 
-	dev_dbg(codec->dev, "ReTune Mobile %d %s/%dHz for %dHz sample rate\n",
+	dev_dbg(component->dev, "ReTune Mobile %d %s/%dHz for %dHz sample rate\n",
 		block,
 		pdata->retune_mobile_cfgs[best].name,
 		pdata->retune_mobile_cfgs[best].rate,
@@ -390,14 +390,14 @@ static void wm8996_set_retune_mobile(struct snd_soc_codec *codec, int block)
 	/* The EQ will be disabled while reconfiguring it, remember the
 	 * current configuration. 
 	 */
-	save = snd_soc_read(codec, base);
+	save = snd_soc_component_read32(component, base);
 	save &= WM8996_DSP1RX_EQ_ENA;
 
 	for (i = 0; i < ARRAY_SIZE(pdata->retune_mobile_cfgs[best].regs); i++)
-		snd_soc_update_bits(codec, base + i, 0xffff,
+		snd_soc_component_update_bits(component, base + i, 0xffff,
 				    pdata->retune_mobile_cfgs[best].regs[i]);
 
-	snd_soc_update_bits(codec, base, WM8996_DSP1RX_EQ_ENA, save);
+	snd_soc_component_update_bits(component, base, WM8996_DSP1RX_EQ_ENA, save);
 }
 
 /* Icky as hell but saves code duplication */
@@ -413,8 +413,8 @@ static int wm8996_get_retune_mobile_block(const char *name)
 static int wm8996_put_retune_mobile_enum(struct snd_kcontrol *kcontrol,
 					 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm8996_priv *wm8996 = snd_soc_component_get_drvdata(component);
 	struct wm8996_pdata *pdata = &wm8996->pdata;
 	int block = wm8996_get_retune_mobile_block(kcontrol->id.name);
 	int value = ucontrol->value.enumerated.item[0];
@@ -427,7 +427,7 @@ static int wm8996_put_retune_mobile_enum(struct snd_kcontrol *kcontrol,
 
 	wm8996->retune_mobile_cfg[block] = value;
 
-	wm8996_set_retune_mobile(codec, block);
+	wm8996_set_retune_mobile(component, block);
 
 	return 0;
 }
@@ -435,8 +435,8 @@ static int wm8996_put_retune_mobile_enum(struct snd_kcontrol *kcontrol,
 static int wm8996_get_retune_mobile_enum(struct snd_kcontrol *kcontrol,
 					 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm8996_priv *wm8996 = snd_soc_component_get_drvdata(component);
 	int block = wm8996_get_retune_mobile_block(kcontrol->id.name);
 
 	if (block < 0)
@@ -575,40 +575,40 @@ SOC_SINGLE_TLV("DSP2 EQ B5 Volume", WM8996_DSP2_RX_EQ_GAINS_2, 6, 31, 0,
 	       eq_tlv),
 };
 
-static void wm8996_bg_enable(struct snd_soc_codec *codec)
+static void wm8996_bg_enable(struct snd_soc_component *component)
 {
-	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
+	struct wm8996_priv *wm8996 = snd_soc_component_get_drvdata(component);
 
 	wm8996->bg_ena++;
 	if (wm8996->bg_ena == 1) {
-		snd_soc_update_bits(codec, WM8996_POWER_MANAGEMENT_1,
+		snd_soc_component_update_bits(component, WM8996_POWER_MANAGEMENT_1,
 				    WM8996_BG_ENA, WM8996_BG_ENA);
 		msleep(2);
 	}
 }
 
-static void wm8996_bg_disable(struct snd_soc_codec *codec)
+static void wm8996_bg_disable(struct snd_soc_component *component)
 {
-	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
+	struct wm8996_priv *wm8996 = snd_soc_component_get_drvdata(component);
 
 	wm8996->bg_ena--;
 	if (!wm8996->bg_ena)
-		snd_soc_update_bits(codec, WM8996_POWER_MANAGEMENT_1,
+		snd_soc_component_update_bits(component, WM8996_POWER_MANAGEMENT_1,
 				    WM8996_BG_ENA, 0);
 }
 
 static int bg_event(struct snd_soc_dapm_widget *w,
 		    struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	int ret = 0;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		wm8996_bg_enable(codec);
+		wm8996_bg_enable(component);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
-		wm8996_bg_disable(codec);
+		wm8996_bg_disable(component);
 		break;
 	default:
 		WARN(1, "Invalid event %d\n", event);
@@ -635,8 +635,8 @@ static int cp_event(struct snd_soc_dapm_widget *w,
 static int rmv_short_event(struct snd_soc_dapm_widget *w,
 			   struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct wm8996_priv *wm8996 = snd_soc_component_get_drvdata(component);
 
 	/* Record which outputs we enabled */
 	switch (event) {
@@ -654,14 +654,14 @@ static int rmv_short_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static void wait_for_dc_servo(struct snd_soc_codec *codec, u16 mask)
+static void wait_for_dc_servo(struct snd_soc_component *component, u16 mask)
 {
-	struct i2c_client *i2c = to_i2c_client(codec->dev);
-	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
+	struct i2c_client *i2c = to_i2c_client(component->dev);
+	struct wm8996_priv *wm8996 = snd_soc_component_get_drvdata(component);
 	int ret;
 	unsigned long timeout = 200;
 
-	snd_soc_write(codec, WM8996_DC_SERVO_2, mask);
+	snd_soc_component_write(component, WM8996_DC_SERVO_2, mask);
 
 	/* Use the interrupt if possible */
 	do {
@@ -669,44 +669,43 @@ static void wait_for_dc_servo(struct snd_soc_codec *codec, u16 mask)
 			timeout = wait_for_completion_timeout(&wm8996->dcs_done,
 							      msecs_to_jiffies(200));
 			if (timeout == 0)
-				dev_err(codec->dev, "DC servo timed out\n");
+				dev_err(component->dev, "DC servo timed out\n");
 
 		} else {
 			msleep(1);
 			timeout--;
 		}
 
-		ret = snd_soc_read(codec, WM8996_DC_SERVO_2);
-		dev_dbg(codec->dev, "DC servo state: %x\n", ret);
+		ret = snd_soc_component_read32(component, WM8996_DC_SERVO_2);
+		dev_dbg(component->dev, "DC servo state: %x\n", ret);
 	} while (timeout && ret & mask);
 
 	if (timeout == 0)
-		dev_err(codec->dev, "DC servo timed out for %x\n", mask);
+		dev_err(component->dev, "DC servo timed out for %x\n", mask);
 	else
-		dev_dbg(codec->dev, "DC servo complete for %x\n", mask);
+		dev_dbg(component->dev, "DC servo complete for %x\n", mask);
 }
 
-static void wm8996_seq_notifier(struct snd_soc_dapm_context *dapm,
+static void wm8996_seq_notifier(struct snd_soc_component *component,
 				enum snd_soc_dapm_type event, int subseq)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(dapm);
-	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
+	struct wm8996_priv *wm8996 = snd_soc_component_get_drvdata(component);
 	u16 val, mask;
 
 	/* Complete any pending DC servo starts */
 	if (wm8996->dcs_pending) {
-		dev_dbg(codec->dev, "Starting DC servo for %x\n",
+		dev_dbg(component->dev, "Starting DC servo for %x\n",
 			wm8996->dcs_pending);
 
 		/* Trigger a startup sequence */
-		wait_for_dc_servo(codec, wm8996->dcs_pending
+		wait_for_dc_servo(component, wm8996->dcs_pending
 				         << WM8996_DCS_TRIG_STARTUP_0_SHIFT);
 
 		wm8996->dcs_pending = 0;
 	}
 
 	if (wm8996->hpout_pending != wm8996->hpout_ena) {
-		dev_dbg(codec->dev, "Applying RMV_SHORTs %x->%x\n",
+		dev_dbg(component->dev, "Applying RMV_SHORTs %x->%x\n",
 			wm8996->hpout_ena, wm8996->hpout_pending);
 
 		val = 0;
@@ -729,7 +728,7 @@ static void wm8996_seq_notifier(struct snd_soc_dapm_context *dapm,
 				WM8996_HPOUT1R_DLY;
 		}
 
-		snd_soc_update_bits(codec, WM8996_ANALOGUE_HP_1, mask, val);
+		snd_soc_component_update_bits(component, WM8996_ANALOGUE_HP_1, mask, val);
 
 		val = 0;
 		mask = 0;
@@ -751,7 +750,7 @@ static void wm8996_seq_notifier(struct snd_soc_dapm_context *dapm,
 				WM8996_HPOUT2R_DLY;
 		}
 
-		snd_soc_update_bits(codec, WM8996_ANALOGUE_HP_2, mask, val);
+		snd_soc_component_update_bits(component, WM8996_ANALOGUE_HP_2, mask, val);
 
 		wm8996->hpout_ena = wm8996->hpout_pending;
 	}
@@ -760,8 +759,8 @@ static void wm8996_seq_notifier(struct snd_soc_dapm_context *dapm,
 static int dcs_start(struct snd_soc_dapm_widget *w,
 		     struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct wm8996_priv *wm8996 = snd_soc_component_get_drvdata(component);
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
@@ -1533,9 +1532,9 @@ static const int bclk_divs[] = {
 	1, 2, 3, 4, 6, 8, 12, 16, 24, 32, 48, 64, 96
 };
 
-static void wm8996_update_bclk(struct snd_soc_codec *codec)
+static void wm8996_update_bclk(struct snd_soc_component *component)
 {
-	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
+	struct wm8996_priv *wm8996 = snd_soc_component_get_drvdata(component);
 	int aif, best, cur_val, bclk_rate, bclk_reg, i;
 
 	/* Don't bother if we're in a low frequency idle mode that
@@ -1565,18 +1564,18 @@ static void wm8996_update_bclk(struct snd_soc_codec *codec)
 			best = i;
 		}
 		bclk_rate = wm8996->sysclk / bclk_divs[best];
-		dev_dbg(codec->dev, "Using BCLK_DIV %d for actual BCLK %dHz\n",
+		dev_dbg(component->dev, "Using BCLK_DIV %d for actual BCLK %dHz\n",
 			bclk_divs[best], bclk_rate);
 
-		snd_soc_update_bits(codec, bclk_reg,
+		snd_soc_component_update_bits(component, bclk_reg,
 				    WM8996_AIF1_BCLK_DIV_MASK, best);
 	}
 }
 
-static int wm8996_set_bias_level(struct snd_soc_codec *codec,
+static int wm8996_set_bias_level(struct snd_soc_component *component,
 				 enum snd_soc_bias_level level)
 {
-	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
+	struct wm8996_priv *wm8996 = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	switch (level) {
@@ -1584,18 +1583,18 @@ static int wm8996_set_bias_level(struct snd_soc_codec *codec,
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		/* Put the MICBIASes into regulating mode */
-		snd_soc_update_bits(codec, WM8996_MICBIAS_1,
+		snd_soc_component_update_bits(component, WM8996_MICBIAS_1,
 				    WM8996_MICB1_MODE, 0);
-		snd_soc_update_bits(codec, WM8996_MICBIAS_2,
+		snd_soc_component_update_bits(component, WM8996_MICBIAS_2,
 				    WM8996_MICB2_MODE, 0);
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
 			ret = regulator_bulk_enable(ARRAY_SIZE(wm8996->supplies),
 						    wm8996->supplies);
 			if (ret != 0) {
-				dev_err(codec->dev,
+				dev_err(component->dev,
 					"Failed to enable supplies: %d\n",
 					ret);
 				return ret;
@@ -1612,9 +1611,9 @@ static int wm8996_set_bias_level(struct snd_soc_codec *codec,
 		}
 
 		/* Bypass the MICBIASes for lowest power */
-		snd_soc_update_bits(codec, WM8996_MICBIAS_1,
+		snd_soc_component_update_bits(component, WM8996_MICBIAS_1,
 				    WM8996_MICB1_MODE, WM8996_MICB1_MODE);
-		snd_soc_update_bits(codec, WM8996_MICBIAS_2,
+		snd_soc_component_update_bits(component, WM8996_MICBIAS_2,
 				    WM8996_MICB2_MODE, WM8996_MICB2_MODE);
 		break;
 
@@ -1634,7 +1633,7 @@ static int wm8996_set_bias_level(struct snd_soc_codec *codec,
 
 static int wm8996_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	int aifctrl = 0;
 	int bclk = 0;
 	int lrclk_tx = 0;
@@ -1711,15 +1710,15 @@ static int wm8996_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, aifctrl_reg, WM8996_AIF1_FMT_MASK, aifctrl);
-	snd_soc_update_bits(codec, bclk_reg,
+	snd_soc_component_update_bits(component, aifctrl_reg, WM8996_AIF1_FMT_MASK, aifctrl);
+	snd_soc_component_update_bits(component, bclk_reg,
 			    WM8996_AIF1_BCLK_INV | WM8996_AIF1_BCLK_MSTR,
 			    bclk);
-	snd_soc_update_bits(codec, lrclk_tx_reg,
+	snd_soc_component_update_bits(component, lrclk_tx_reg,
 			    WM8996_AIF1TX_LRCLK_INV |
 			    WM8996_AIF1TX_LRCLK_MSTR,
 			    lrclk_tx);
-	snd_soc_update_bits(codec, lrclk_rx_reg,
+	snd_soc_component_update_bits(component, lrclk_rx_reg,
 			    WM8996_AIF1RX_LRCLK_INV |
 			    WM8996_AIF1RX_LRCLK_MSTR,
 			    lrclk_rx);
@@ -1735,8 +1734,8 @@ static int wm8996_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct wm8996_priv *wm8996 = snd_soc_component_get_drvdata(component);
 	int bits, i, bclk_rate, best;
 	int aifdata = 0;
 	int lrclk = 0;
@@ -1746,7 +1745,7 @@ static int wm8996_hw_params(struct snd_pcm_substream *substream,
 	switch (dai->id) {
 	case 0:
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK ||
-		    (snd_soc_read(codec, WM8996_GPIO_1)) & WM8996_GP1_FN_MASK) {
+		    (snd_soc_component_read32(component, WM8996_GPIO_1)) & WM8996_GP1_FN_MASK) {
 			aifdata_reg = WM8996_AIF1RX_DATA_CONFIGURATION;
 			lrclk_reg = WM8996_AIF1_RX_LRCLK_1;
 		} else {
@@ -1757,7 +1756,7 @@ static int wm8996_hw_params(struct snd_pcm_substream *substream,
 		break;
 	case 1:
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK ||
-		    (snd_soc_read(codec, WM8996_GPIO_2)) & WM8996_GP2_FN_MASK) {
+		    (snd_soc_component_read32(component, WM8996_GPIO_2)) & WM8996_GP2_FN_MASK) {
 			aifdata_reg = WM8996_AIF2RX_DATA_CONFIGURATION;
 			lrclk_reg = WM8996_AIF2_RX_LRCLK_1;
 		} else {
@@ -1773,7 +1772,7 @@ static int wm8996_hw_params(struct snd_pcm_substream *substream,
 
 	bclk_rate = snd_soc_params_to_bclk(params);
 	if (bclk_rate < 0) {
-		dev_err(codec->dev, "Unsupported BCLK rate: %d\n", bclk_rate);
+		dev_err(component->dev, "Unsupported BCLK rate: %d\n", bclk_rate);
 		return bclk_rate;
 	}
 
@@ -1794,19 +1793,19 @@ static int wm8996_hw_params(struct snd_pcm_substream *substream,
 	}
 	dsp |= i << dsp_shift;
 
-	wm8996_update_bclk(codec);
+	wm8996_update_bclk(component);
 
 	lrclk = bclk_rate / params_rate(params);
 	dev_dbg(dai->dev, "Using LRCLK rate %d for actual LRCLK %dHz\n",
 		lrclk, bclk_rate / lrclk);
 
-	snd_soc_update_bits(codec, aifdata_reg,
+	snd_soc_component_update_bits(component, aifdata_reg,
 			    WM8996_AIF1TX_WL_MASK |
 			    WM8996_AIF1TX_SLOT_LEN_MASK,
 			    aifdata);
-	snd_soc_update_bits(codec, lrclk_reg, WM8996_AIF1RX_RATE_MASK,
+	snd_soc_component_update_bits(component, lrclk_reg, WM8996_AIF1RX_RATE_MASK,
 			    lrclk);
-	snd_soc_update_bits(codec, WM8996_AIF_CLOCKING_2,
+	snd_soc_component_update_bits(component, WM8996_AIF_CLOCKING_2,
 			    WM8996_DSP1_DIV_MASK << dsp_shift, dsp);
 
 	return 0;
@@ -1815,8 +1814,8 @@ static int wm8996_hw_params(struct snd_pcm_substream *substream,
 static int wm8996_set_sysclk(struct snd_soc_dai *dai,
 		int clk_id, unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct wm8996_priv *wm8996 = snd_soc_component_get_drvdata(component);
 	int lfclk = 0;
 	int ratediv = 0;
 	int sync = WM8996_REG_SYNC;
@@ -1827,8 +1826,8 @@ static int wm8996_set_sysclk(struct snd_soc_dai *dai,
 		return 0;
 
 	/* Disable SYSCLK while we reconfigure */
-	old = snd_soc_read(codec, WM8996_AIF_CLOCKING_1) & WM8996_SYSCLK_ENA;
-	snd_soc_update_bits(codec, WM8996_AIF_CLOCKING_1,
+	old = snd_soc_component_read32(component, WM8996_AIF_CLOCKING_1) & WM8996_SYSCLK_ENA;
+	snd_soc_component_update_bits(component, WM8996_AIF_CLOCKING_1,
 			    WM8996_SYSCLK_ENA, 0);
 
 	switch (clk_id) {
@@ -1845,14 +1844,14 @@ static int wm8996_set_sysclk(struct snd_soc_dai *dai,
 		src = 2;
 		break;
 	default:
-		dev_err(codec->dev, "Unsupported clock source %d\n", clk_id);
+		dev_err(component->dev, "Unsupported clock source %d\n", clk_id);
 		return -EINVAL;
 	}
 
 	switch (wm8996->sysclk) {
 	case 5644800:
 	case 6144000:
-		snd_soc_update_bits(codec, WM8996_AIF_RATE,
+		snd_soc_component_update_bits(component, WM8996_AIF_RATE,
 				    WM8996_SYSCLK_RATE, 0);
 		break;
 	case 22579200:
@@ -1861,7 +1860,7 @@ static int wm8996_set_sysclk(struct snd_soc_dai *dai,
 		wm8996->sysclk /= 2;
 	case 11289600:
 	case 12288000:
-		snd_soc_update_bits(codec, WM8996_AIF_RATE,
+		snd_soc_component_update_bits(component, WM8996_AIF_RATE,
 				    WM8996_SYSCLK_RATE, WM8996_SYSCLK_RATE);
 		break;
 	case 32000:
@@ -1870,20 +1869,20 @@ static int wm8996_set_sysclk(struct snd_soc_dai *dai,
 		sync = 0;
 		break;
 	default:
-		dev_warn(codec->dev, "Unsupported clock rate %dHz\n",
+		dev_warn(component->dev, "Unsupported clock rate %dHz\n",
 			 wm8996->sysclk);
 		return -EINVAL;
 	}
 
-	wm8996_update_bclk(codec);
+	wm8996_update_bclk(component);
 
-	snd_soc_update_bits(codec, WM8996_AIF_CLOCKING_1,
+	snd_soc_component_update_bits(component, WM8996_AIF_CLOCKING_1,
 			    WM8996_SYSCLK_SRC_MASK | WM8996_SYSCLK_DIV_MASK,
 			    src << WM8996_SYSCLK_SRC_SHIFT | ratediv);
-	snd_soc_update_bits(codec, WM8996_CLOCKING_1, WM8996_LFCLK_ENA, lfclk);
-	snd_soc_update_bits(codec, WM8996_CONTROL_INTERFACE_1,
+	snd_soc_component_update_bits(component, WM8996_CLOCKING_1, WM8996_LFCLK_ENA, lfclk);
+	snd_soc_component_update_bits(component, WM8996_CONTROL_INTERFACE_1,
 			    WM8996_REG_SYNC, sync);
-	snd_soc_update_bits(codec, WM8996_AIF_CLOCKING_1,
+	snd_soc_component_update_bits(component, WM8996_AIF_CLOCKING_1,
 			    WM8996_SYSCLK_ENA, old);
 
 	wm8996->sysclk_src = clk_id;
@@ -2002,11 +2001,11 @@ static int fll_factors(struct _fll_div *fll_div, unsigned int Fref,
 	return 0;
 }
 
-static int wm8996_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
+static int wm8996_set_fll(struct snd_soc_component *component, int fll_id, int source,
 			  unsigned int Fref, unsigned int Fout)
 {
-	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
-	struct i2c_client *i2c = to_i2c_client(codec->dev);
+	struct wm8996_priv *wm8996 = snd_soc_component_get_drvdata(component);
+	struct i2c_client *i2c = to_i2c_client(component->dev);
 	struct _fll_div fll_div;
 	unsigned long timeout, time_left;
 	int ret, reg, retry;
@@ -2017,15 +2016,15 @@ static int wm8996_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 		return 0;
 
 	if (Fout == 0) {
-		dev_dbg(codec->dev, "FLL disabled\n");
+		dev_dbg(component->dev, "FLL disabled\n");
 
 		wm8996->fll_fref = 0;
 		wm8996->fll_fout = 0;
 
-		snd_soc_update_bits(codec, WM8996_FLL_CONTROL_1,
+		snd_soc_component_update_bits(component, WM8996_FLL_CONTROL_1,
 				    WM8996_FLL_ENA, 0);
 
-		wm8996_bg_disable(codec);
+		wm8996_bg_disable(component);
 
 		return 0;
 	}
@@ -2048,14 +2047,14 @@ static int wm8996_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 		reg = 3;
 		break;
 	default:
-		dev_err(codec->dev, "Unknown FLL source %d\n", ret);
+		dev_err(component->dev, "Unknown FLL source %d\n", ret);
 		return -EINVAL;
 	}
 
 	reg |= fll_div.fll_refclk_div << WM8996_FLL_REFCLK_DIV_SHIFT;
 	reg |= fll_div.fll_ref_freq << WM8996_FLL_REF_FREQ_SHIFT;
 
-	snd_soc_update_bits(codec, WM8996_FLL_CONTROL_5,
+	snd_soc_component_update_bits(component, WM8996_FLL_CONTROL_5,
 			    WM8996_FLL_REFCLK_DIV_MASK | WM8996_FLL_REF_FREQ |
 			    WM8996_FLL_REFCLK_SRC_MASK, reg);
 
@@ -2064,38 +2063,38 @@ static int wm8996_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 		reg |= WM8996_FLL_EFS_ENA | (3 << WM8996_FLL_LFSR_SEL_SHIFT);
 	else
 		reg |= 1 << WM8996_FLL_LFSR_SEL_SHIFT;
-	snd_soc_write(codec, WM8996_FLL_EFS_2, reg);
+	snd_soc_component_write(component, WM8996_FLL_EFS_2, reg);
 
-	snd_soc_update_bits(codec, WM8996_FLL_CONTROL_2,
+	snd_soc_component_update_bits(component, WM8996_FLL_CONTROL_2,
 			    WM8996_FLL_OUTDIV_MASK |
 			    WM8996_FLL_FRATIO_MASK,
 			    (fll_div.fll_outdiv << WM8996_FLL_OUTDIV_SHIFT) |
 			    (fll_div.fll_fratio));
 
-	snd_soc_write(codec, WM8996_FLL_CONTROL_3, fll_div.theta);
+	snd_soc_component_write(component, WM8996_FLL_CONTROL_3, fll_div.theta);
 
-	snd_soc_update_bits(codec, WM8996_FLL_CONTROL_4,
+	snd_soc_component_update_bits(component, WM8996_FLL_CONTROL_4,
 			    WM8996_FLL_N_MASK | WM8996_FLL_LOOP_GAIN_MASK,
 			    (fll_div.n << WM8996_FLL_N_SHIFT) |
 			    fll_div.fll_loop_gain);
 
-	snd_soc_write(codec, WM8996_FLL_EFS_1, fll_div.lambda);
+	snd_soc_component_write(component, WM8996_FLL_EFS_1, fll_div.lambda);
 
 	/* Enable the bandgap if it's not already enabled */
-	ret = snd_soc_read(codec, WM8996_FLL_CONTROL_1);
+	ret = snd_soc_component_read32(component, WM8996_FLL_CONTROL_1);
 	if (!(ret & WM8996_FLL_ENA))
-		wm8996_bg_enable(codec);
+		wm8996_bg_enable(component);
 
 	/* Clear any pending completions (eg, from failed startups) */
 	try_wait_for_completion(&wm8996->fll_lock);
 
-	snd_soc_update_bits(codec, WM8996_FLL_CONTROL_1,
+	snd_soc_component_update_bits(component, WM8996_FLL_CONTROL_1,
 			    WM8996_FLL_ENA, WM8996_FLL_ENA);
 
 	/* The FLL supports live reconfiguration - kick that in case we were
 	 * already enabled.
 	 */
-	snd_soc_write(codec, WM8996_FLL_CONTROL_6, WM8996_FLL_SWITCH_CLK);
+	snd_soc_component_write(component, WM8996_FLL_CONTROL_6, WM8996_FLL_SWITCH_CLK);
 
 	/* Wait for the FLL to lock, using the interrupt if possible */
 	if (Fref > 1000000)
@@ -2121,16 +2120,16 @@ static int wm8996_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 			break;
 		}
 
-		ret = snd_soc_read(codec, WM8996_INTERRUPT_RAW_STATUS_2);
+		ret = snd_soc_component_read32(component, WM8996_INTERRUPT_RAW_STATUS_2);
 		if (ret & WM8996_FLL_LOCK_STS)
 			break;
 	}
 	if (retry == 10) {
-		dev_err(codec->dev, "Timed out waiting for FLL\n");
+		dev_err(component->dev, "Timed out waiting for FLL\n");
 		ret = -ETIMEDOUT;
 	}
 
-	dev_dbg(codec->dev, "FLL configured for %dHz->%dHz\n", Fref, Fout);
+	dev_dbg(component->dev, "FLL configured for %dHz->%dHz\n", Fref, Fout);
 
 	wm8996->fll_fref = Fref;
 	wm8996->fll_fout = Fout;
@@ -2237,11 +2236,11 @@ static void wm8996_free_gpio(struct wm8996_priv *wm8996)
  * will also detect inverted microphone ground connections and update
  * the polarity of the connections.
  */
-int wm8996_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
+int wm8996_detect(struct snd_soc_component *component, struct snd_soc_jack *jack,
 		  wm8996_polarity_fn polarity_cb)
 {
-	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	struct wm8996_priv *wm8996 = snd_soc_component_get_drvdata(component);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 
 	wm8996->jack = jack;
 	wm8996->detecting = true;
@@ -2249,12 +2248,12 @@ int wm8996_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 	wm8996->jack_flips = 0;
 
 	if (wm8996->polarity_cb)
-		wm8996->polarity_cb(codec, 0);
+		wm8996->polarity_cb(component, 0);
 
 	/* Clear discarge to avoid noise during detection */
-	snd_soc_update_bits(codec, WM8996_MICBIAS_1,
+	snd_soc_component_update_bits(component, WM8996_MICBIAS_1,
 			    WM8996_MICB1_DISCH, 0);
-	snd_soc_update_bits(codec, WM8996_MICBIAS_2,
+	snd_soc_component_update_bits(component, WM8996_MICBIAS_2,
 			    WM8996_MICB2_DISCH, 0);
 
 	/* LDO2 powers the microphones, SYSCLK clocks detection */
@@ -2268,26 +2267,26 @@ int wm8996_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 	/* We start off just enabling microphone detection - even a
 	 * plain headphone will trigger detection.
 	 */
-	snd_soc_update_bits(codec, WM8996_MIC_DETECT_1,
+	snd_soc_component_update_bits(component, WM8996_MIC_DETECT_1,
 			    WM8996_MICD_ENA, WM8996_MICD_ENA);
 
 	/* Slowest detection rate, gives debounce for initial detection */
-	snd_soc_update_bits(codec, WM8996_MIC_DETECT_1,
+	snd_soc_component_update_bits(component, WM8996_MIC_DETECT_1,
 			    WM8996_MICD_RATE_MASK,
 			    WM8996_MICD_RATE_MASK);
 
 	/* Enable interrupts and we're off */
-	snd_soc_update_bits(codec, WM8996_INTERRUPT_STATUS_2_MASK,
+	snd_soc_component_update_bits(component, WM8996_INTERRUPT_STATUS_2_MASK,
 			    WM8996_IM_MICD_EINT | WM8996_HP_DONE_EINT, 0);
 
 	return 0;
 }
 EXPORT_SYMBOL_GPL(wm8996_detect);
 
-static void wm8996_hpdet_irq(struct snd_soc_codec *codec)
+static void wm8996_hpdet_irq(struct snd_soc_component *component)
 {
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
-	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	struct wm8996_priv *wm8996 = snd_soc_component_get_drvdata(component);
 	int val, reg, report;
 
 	/* Assume headphone in error conditions; we need to report
@@ -2295,20 +2294,20 @@ static void wm8996_hpdet_irq(struct snd_soc_codec *codec)
 	 */
 	report = SND_JACK_HEADPHONE;
 
-	reg = snd_soc_read(codec, WM8996_HEADPHONE_DETECT_2);
+	reg = snd_soc_component_read32(component, WM8996_HEADPHONE_DETECT_2);
 	if (reg < 0) {
-		dev_err(codec->dev, "Failed to read HPDET status\n");
+		dev_err(component->dev, "Failed to read HPDET status\n");
 		goto out;
 	}
 
 	if (!(reg & WM8996_HP_DONE)) {
-		dev_err(codec->dev, "Got HPDET IRQ but HPDET is busy\n");
+		dev_err(component->dev, "Got HPDET IRQ but HPDET is busy\n");
 		goto out;
 	}
 
 	val = reg & WM8996_HP_LVL_MASK;
 
-	dev_dbg(codec->dev, "HPDET measured %d ohms\n", val);
+	dev_dbg(component->dev, "HPDET measured %d ohms\n", val);
 
 	/* If we've got high enough impedence then report as line,
 	 * otherwise assume headphone.
@@ -2328,28 +2327,28 @@ static void wm8996_hpdet_irq(struct snd_soc_codec *codec)
 	wm8996->detecting = false;
 
 	/* If the output isn't running re-clamp it */
-	if (!(snd_soc_read(codec, WM8996_POWER_MANAGEMENT_1) &
+	if (!(snd_soc_component_read32(component, WM8996_POWER_MANAGEMENT_1) &
 	      (WM8996_HPOUT1L_ENA | WM8996_HPOUT1R_RMV_SHORT)))
-		snd_soc_update_bits(codec, WM8996_ANALOGUE_HP_1,
+		snd_soc_component_update_bits(component, WM8996_ANALOGUE_HP_1,
 				    WM8996_HPOUT1L_RMV_SHORT |
 				    WM8996_HPOUT1R_RMV_SHORT, 0);
 
 	/* Go back to looking at the microphone */
-	snd_soc_update_bits(codec, WM8996_ACCESSORY_DETECT_MODE_1,
+	snd_soc_component_update_bits(component, WM8996_ACCESSORY_DETECT_MODE_1,
 			    WM8996_JD_MODE_MASK, 0);
-	snd_soc_update_bits(codec, WM8996_MIC_DETECT_1, WM8996_MICD_ENA,
+	snd_soc_component_update_bits(component, WM8996_MIC_DETECT_1, WM8996_MICD_ENA,
 			    WM8996_MICD_ENA);
 
 	snd_soc_dapm_disable_pin(dapm, "Bandgap");
 	snd_soc_dapm_sync(dapm);
 }
 
-static void wm8996_hpdet_start(struct snd_soc_codec *codec)
+static void wm8996_hpdet_start(struct snd_soc_component *component)
 {
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 
 	/* Unclamp the output, we can't measure while we're shorting it */
-	snd_soc_update_bits(codec, WM8996_ANALOGUE_HP_1,
+	snd_soc_component_update_bits(component, WM8996_ANALOGUE_HP_1,
 			    WM8996_HPOUT1L_RMV_SHORT |
 			    WM8996_HPOUT1R_RMV_SHORT,
 			    WM8996_HPOUT1L_RMV_SHORT |
@@ -2360,45 +2359,45 @@ static void wm8996_hpdet_start(struct snd_soc_codec *codec)
 	snd_soc_dapm_sync(dapm);
 
 	/* Go into headphone detect left mode */
-	snd_soc_update_bits(codec, WM8996_MIC_DETECT_1, WM8996_MICD_ENA, 0);
-	snd_soc_update_bits(codec, WM8996_ACCESSORY_DETECT_MODE_1,
+	snd_soc_component_update_bits(component, WM8996_MIC_DETECT_1, WM8996_MICD_ENA, 0);
+	snd_soc_component_update_bits(component, WM8996_ACCESSORY_DETECT_MODE_1,
 			    WM8996_JD_MODE_MASK, 1);
 
 	/* Trigger a measurement */
-	snd_soc_update_bits(codec, WM8996_HEADPHONE_DETECT_1,
+	snd_soc_component_update_bits(component, WM8996_HEADPHONE_DETECT_1,
 			    WM8996_HP_POLL, WM8996_HP_POLL);
 }
 
-static void wm8996_report_headphone(struct snd_soc_codec *codec)
+static void wm8996_report_headphone(struct snd_soc_component *component)
 {
-	dev_dbg(codec->dev, "Headphone detected\n");
-	wm8996_hpdet_start(codec);
+	dev_dbg(component->dev, "Headphone detected\n");
+	wm8996_hpdet_start(component);
 
 	/* Increase the detection rate a bit for responsiveness. */
-	snd_soc_update_bits(codec, WM8996_MIC_DETECT_1,
+	snd_soc_component_update_bits(component, WM8996_MIC_DETECT_1,
 			    WM8996_MICD_RATE_MASK |
 			    WM8996_MICD_BIAS_STARTTIME_MASK,
 			    7 << WM8996_MICD_RATE_SHIFT |
 			    7 << WM8996_MICD_BIAS_STARTTIME_SHIFT);
 }
 
-static void wm8996_micd(struct snd_soc_codec *codec)
+static void wm8996_micd(struct snd_soc_component *component)
 {
-	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
+	struct wm8996_priv *wm8996 = snd_soc_component_get_drvdata(component);
 	int val, reg;
 
-	val = snd_soc_read(codec, WM8996_MIC_DETECT_3);
+	val = snd_soc_component_read32(component, WM8996_MIC_DETECT_3);
 
-	dev_dbg(codec->dev, "Microphone event: %x\n", val);
+	dev_dbg(component->dev, "Microphone event: %x\n", val);
 
 	if (!(val & WM8996_MICD_VALID)) {
-		dev_warn(codec->dev, "Microphone detection state invalid\n");
+		dev_warn(component->dev, "Microphone detection state invalid\n");
 		return;
 	}
 
 	/* No accessory, reset everything and report removal */
 	if (!(val & WM8996_MICD_STS)) {
-		dev_dbg(codec->dev, "Jack removal detected\n");
+		dev_dbg(component->dev, "Jack removal detected\n");
 		wm8996->jack_mic = false;
 		wm8996->detecting = true;
 		wm8996->jack_flips = 0;
@@ -2406,7 +2405,7 @@ static void wm8996_micd(struct snd_soc_codec *codec)
 				    SND_JACK_LINEOUT | SND_JACK_HEADSET |
 				    SND_JACK_BTN_0);
 
-		snd_soc_update_bits(codec, WM8996_MIC_DETECT_1,
+		snd_soc_component_update_bits(component, WM8996_MIC_DETECT_1,
 				    WM8996_MICD_RATE_MASK |
 				    WM8996_MICD_BIAS_STARTTIME_MASK,
 				    WM8996_MICD_RATE_MASK |
@@ -2420,19 +2419,19 @@ static void wm8996_micd(struct snd_soc_codec *codec)
 	 */
 	if (val & 0x400) {
 		if (wm8996->detecting) {
-			dev_dbg(codec->dev, "Microphone detected\n");
+			dev_dbg(component->dev, "Microphone detected\n");
 			wm8996->jack_mic = true;
-			wm8996_hpdet_start(codec);
+			wm8996_hpdet_start(component);
 
 			/* Increase poll rate to give better responsiveness
 			 * for buttons */
-			snd_soc_update_bits(codec, WM8996_MIC_DETECT_1,
+			snd_soc_component_update_bits(component, WM8996_MIC_DETECT_1,
 					    WM8996_MICD_RATE_MASK |
 					    WM8996_MICD_BIAS_STARTTIME_MASK,
 					    5 << WM8996_MICD_RATE_SHIFT |
 					    7 << WM8996_MICD_BIAS_STARTTIME_SHIFT);
 		} else {
-			dev_dbg(codec->dev, "Mic button up\n");
+			dev_dbg(component->dev, "Mic button up\n");
 			snd_soc_jack_report(wm8996->jack, 0, SND_JACK_BTN_0);
 		}
 
@@ -2449,22 +2448,22 @@ static void wm8996_micd(struct snd_soc_codec *codec)
 		wm8996->jack_flips++;
 
 		if (wm8996->jack_flips > 1) {
-			wm8996_report_headphone(codec);
+			wm8996_report_headphone(component);
 			return;
 		}
 
-		reg = snd_soc_read(codec, WM8996_ACCESSORY_DETECT_MODE_2);
+		reg = snd_soc_component_read32(component, WM8996_ACCESSORY_DETECT_MODE_2);
 		reg ^= WM8996_HPOUT1FB_SRC | WM8996_MICD_SRC |
 			WM8996_MICD_BIAS_SRC;
-		snd_soc_update_bits(codec, WM8996_ACCESSORY_DETECT_MODE_2,
+		snd_soc_component_update_bits(component, WM8996_ACCESSORY_DETECT_MODE_2,
 				    WM8996_HPOUT1FB_SRC | WM8996_MICD_SRC |
 				    WM8996_MICD_BIAS_SRC, reg);
 
 		if (wm8996->polarity_cb)
-			wm8996->polarity_cb(codec,
+			wm8996->polarity_cb(component,
 					    (reg & WM8996_MICD_SRC) != 0);
 
-		dev_dbg(codec->dev, "Set microphone polarity to %d\n",
+		dev_dbg(component->dev, "Set microphone polarity to %d\n",
 			(reg & WM8996_MICD_SRC) != 0);
 
 		return;
@@ -2475,52 +2474,52 @@ static void wm8996_micd(struct snd_soc_codec *codec)
 	 */
 	if (val & 0x3fc) {
 		if (wm8996->jack_mic) {
-			dev_dbg(codec->dev, "Mic button detected\n");
+			dev_dbg(component->dev, "Mic button detected\n");
 			snd_soc_jack_report(wm8996->jack, SND_JACK_BTN_0,
 					    SND_JACK_BTN_0);
 		} else if (wm8996->detecting) {
-			wm8996_report_headphone(codec);
+			wm8996_report_headphone(component);
 		}
 	}
 }
 
 static irqreturn_t wm8996_irq(int irq, void *data)
 {
-	struct snd_soc_codec *codec = data;
-	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = data;
+	struct wm8996_priv *wm8996 = snd_soc_component_get_drvdata(component);
 	int irq_val;
 
-	irq_val = snd_soc_read(codec, WM8996_INTERRUPT_STATUS_2);
+	irq_val = snd_soc_component_read32(component, WM8996_INTERRUPT_STATUS_2);
 	if (irq_val < 0) {
-		dev_err(codec->dev, "Failed to read IRQ status: %d\n",
+		dev_err(component->dev, "Failed to read IRQ status: %d\n",
 			irq_val);
 		return IRQ_NONE;
 	}
-	irq_val &= ~snd_soc_read(codec, WM8996_INTERRUPT_STATUS_2_MASK);
+	irq_val &= ~snd_soc_component_read32(component, WM8996_INTERRUPT_STATUS_2_MASK);
 
 	if (!irq_val)
 		return IRQ_NONE;
 
-	snd_soc_write(codec, WM8996_INTERRUPT_STATUS_2, irq_val);
+	snd_soc_component_write(component, WM8996_INTERRUPT_STATUS_2, irq_val);
 
 	if (irq_val & (WM8996_DCS_DONE_01_EINT | WM8996_DCS_DONE_23_EINT)) {
-		dev_dbg(codec->dev, "DC servo IRQ\n");
+		dev_dbg(component->dev, "DC servo IRQ\n");
 		complete(&wm8996->dcs_done);
 	}
 
 	if (irq_val & WM8996_FIFOS_ERR_EINT)
-		dev_err(codec->dev, "Digital core FIFO error\n");
+		dev_err(component->dev, "Digital core FIFO error\n");
 
 	if (irq_val & WM8996_FLL_LOCK_EINT) {
-		dev_dbg(codec->dev, "FLL locked\n");
+		dev_dbg(component->dev, "FLL locked\n");
 		complete(&wm8996->fll_lock);
 	}
 
 	if (irq_val & WM8996_MICD_EINT)
-		wm8996_micd(codec);
+		wm8996_micd(component);
 
 	if (irq_val & WM8996_HP_DONE_EINT)
-		wm8996_hpdet_irq(codec);
+		wm8996_hpdet_irq(component);
 
 	return IRQ_HANDLED;
 }
@@ -2539,9 +2538,9 @@ static irqreturn_t wm8996_edge_irq(int irq, void *data)
 	return ret;
 }
 
-static void wm8996_retune_mobile_pdata(struct snd_soc_codec *codec)
+static void wm8996_retune_mobile_pdata(struct snd_soc_component *component)
 {
-	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
+	struct wm8996_priv *wm8996 = snd_soc_component_get_drvdata(component);
 	struct wm8996_pdata *pdata = &wm8996->pdata;
 
 	struct snd_kcontrol_new controls[] = {
@@ -2590,15 +2589,15 @@ static void wm8996_retune_mobile_pdata(struct snd_soc_codec *codec)
 		wm8996->retune_mobile_texts = t;
 	}
 
-	dev_dbg(codec->dev, "Allocated %d unique ReTune Mobile names\n",
+	dev_dbg(component->dev, "Allocated %d unique ReTune Mobile names\n",
 		wm8996->num_retune_mobile_texts);
 
 	wm8996->retune_mobile_enum.items = wm8996->num_retune_mobile_texts;
 	wm8996->retune_mobile_enum.texts = wm8996->retune_mobile_texts;
 
-	ret = snd_soc_add_codec_controls(codec, controls, ARRAY_SIZE(controls));
+	ret = snd_soc_add_component_controls(component, controls, ARRAY_SIZE(controls));
 	if (ret != 0)
-		dev_err(codec->dev,
+		dev_err(component->dev,
 			"Failed to add ReTune Mobile controls: %d\n", ret);
 }
 
@@ -2614,22 +2613,22 @@ static const struct regmap_config wm8996_regmap = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static int wm8996_probe(struct snd_soc_codec *codec)
+static int wm8996_probe(struct snd_soc_component *component)
 {
 	int ret;
-	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
-	struct i2c_client *i2c = to_i2c_client(codec->dev);
+	struct wm8996_priv *wm8996 = snd_soc_component_get_drvdata(component);
+	struct i2c_client *i2c = to_i2c_client(component->dev);
 	int irq_flags;
 
-	wm8996->codec = codec;
+	wm8996->component = component;
 
 	init_completion(&wm8996->dcs_done);
 	init_completion(&wm8996->fll_lock);
 
 	if (wm8996->pdata.num_retune_mobile_cfgs)
-		wm8996_retune_mobile_pdata(codec);
+		wm8996_retune_mobile_pdata(component);
 	else
-		snd_soc_add_codec_controls(codec, wm8996_eq_controls,
+		snd_soc_add_component_controls(component, wm8996_eq_controls,
 				     ARRAY_SIZE(wm8996_eq_controls));
 
 	if (i2c->irq) {
@@ -2643,18 +2642,18 @@ static int wm8996_probe(struct snd_soc_codec *codec)
 		if (irq_flags & (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING))
 			ret = request_threaded_irq(i2c->irq, NULL,
 						   wm8996_edge_irq,
-						   irq_flags, "wm8996", codec);
+						   irq_flags, "wm8996", component);
 		else
 			ret = request_threaded_irq(i2c->irq, NULL, wm8996_irq,
-						   irq_flags, "wm8996", codec);
+						   irq_flags, "wm8996", component);
 
 		if (ret == 0) {
 			/* Unmask the interrupt */
-			snd_soc_update_bits(codec, WM8996_INTERRUPT_CONTROL,
+			snd_soc_component_update_bits(component, WM8996_INTERRUPT_CONTROL,
 					    WM8996_IM_IRQ, 0);
 
 			/* Enable error reporting and DC servo status */
-			snd_soc_update_bits(codec,
+			snd_soc_component_update_bits(component,
 					    WM8996_INTERRUPT_STATUS_2_MASK,
 					    WM8996_IM_DCS_DONE_23_EINT |
 					    WM8996_IM_DCS_DONE_01_EINT |
@@ -2662,7 +2661,7 @@ static int wm8996_probe(struct snd_soc_codec *codec)
 					    WM8996_IM_FIFOS_ERR_EINT,
 					    0);
 		} else {
-			dev_err(codec->dev, "Failed to request IRQ: %d\n",
+			dev_err(component->dev, "Failed to request IRQ: %d\n",
 				ret);
 			return ret;
 		}
@@ -2671,34 +2670,33 @@ static int wm8996_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int wm8996_remove(struct snd_soc_codec *codec)
+static void wm8996_remove(struct snd_soc_component *component)
 {
-	struct i2c_client *i2c = to_i2c_client(codec->dev);
+	struct i2c_client *i2c = to_i2c_client(component->dev);
 
-	snd_soc_update_bits(codec, WM8996_INTERRUPT_CONTROL,
+	snd_soc_component_update_bits(component, WM8996_INTERRUPT_CONTROL,
 			    WM8996_IM_IRQ, WM8996_IM_IRQ);
 
 	if (i2c->irq)
-		free_irq(i2c->irq, codec);
-
-	return 0;
+		free_irq(i2c->irq, component);
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_wm8996 = {
-	.probe =	wm8996_probe,
-	.remove =	wm8996_remove,
-	.set_bias_level = wm8996_set_bias_level,
-	.idle_bias_off	= true,
-	.seq_notifier = wm8996_seq_notifier,
-	.component_driver = {
-		.controls		= wm8996_snd_controls,
-		.num_controls		= ARRAY_SIZE(wm8996_snd_controls),
-		.dapm_widgets		= wm8996_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(wm8996_dapm_widgets),
-		.dapm_routes		= wm8996_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(wm8996_dapm_routes),
-	},
-	.set_pll = wm8996_set_fll,
+static const struct snd_soc_component_driver soc_component_dev_wm8996 = {
+	.probe			= wm8996_probe,
+	.remove			= wm8996_remove,
+	.set_bias_level		= wm8996_set_bias_level,
+	.seq_notifier		= wm8996_seq_notifier,
+	.controls		= wm8996_snd_controls,
+	.num_controls		= ARRAY_SIZE(wm8996_snd_controls),
+	.dapm_widgets		= wm8996_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(wm8996_dapm_widgets),
+	.dapm_routes		= wm8996_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(wm8996_dapm_routes),
+	.set_pll		= wm8996_set_fll,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
+
 };
 
 #define WM8996_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |\
@@ -3046,8 +3044,8 @@ static int wm8996_i2c_probe(struct i2c_client *i2c,
 
 	wm8996_init_gpio(wm8996);
 
-	ret = snd_soc_register_codec(&i2c->dev,
-				     &soc_codec_dev_wm8996, wm8996_dai,
+	ret = devm_snd_soc_register_component(&i2c->dev,
+				     &soc_component_dev_wm8996, wm8996_dai,
 				     ARRAY_SIZE(wm8996_dai));
 	if (ret < 0)
 		goto err_gpiolib;
@@ -3074,7 +3072,6 @@ static int wm8996_i2c_remove(struct i2c_client *client)
 	struct wm8996_priv *wm8996 = i2c_get_clientdata(client);
 	int i;
 
-	snd_soc_unregister_codec(&client->dev);
 	wm8996_free_gpio(wm8996);
 	if (wm8996->pdata.ldo_ena > 0) {
 		gpio_set_value_cansleep(wm8996->pdata.ldo_ena, 0);
diff --git a/sound/soc/codecs/wm8996.h b/sound/soc/codecs/wm8996.h
index de9ac3e44aec..b38769958752 100644
--- a/sound/soc/codecs/wm8996.h
+++ b/sound/soc/codecs/wm8996.h
@@ -22,9 +22,9 @@
 #define WM8996_FLL_DACLRCLK1  3
 #define WM8996_FLL_BCLK1      4
 
-typedef void (*wm8996_polarity_fn)(struct snd_soc_codec *codec, int polarity);
+typedef void (*wm8996_polarity_fn)(struct snd_soc_component *component, int polarity);
 
-int wm8996_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
+int wm8996_detect(struct snd_soc_component *component, struct snd_soc_jack *jack,
 		  wm8996_polarity_fn polarity_cb);
 
 /*
diff --git a/sound/soc/samsung/speyside.c b/sound/soc/samsung/speyside.c
index 083ef5e21b17..4b4147d07804 100644
--- a/sound/soc/samsung/speyside.c
+++ b/sound/soc/samsung/speyside.c
@@ -124,14 +124,14 @@ static int speyside_get_micbias(struct snd_soc_dapm_widget *source,
 	return 0;
 }
 
-static void speyside_set_polarity(struct snd_soc_codec *codec,
+static void speyside_set_polarity(struct snd_soc_component *component,
 				  int polarity)
 {
 	speyside_jack_polarity = !polarity;
 	gpio_direction_output(WM8996_HPSEL_GPIO, speyside_jack_polarity);
 
 	/* Re-run DAPM to make sure we're using the correct mic bias */
-	snd_soc_dapm_sync(snd_soc_codec_get_dapm(codec));
+	snd_soc_dapm_sync(snd_soc_component_get_dapm(component));
 }
 
 static int speyside_wm0010_init(struct snd_soc_pcm_runtime *rtd)
@@ -149,7 +149,7 @@ static int speyside_wm0010_init(struct snd_soc_pcm_runtime *rtd)
 static int speyside_wm8996_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_dai *dai = rtd->codec_dai;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_component *component = dai->component;
 	int ret;
 
 	ret = snd_soc_dai_set_sysclk(dai, WM8996_SYSCLK_MCLK2, 32768, 0);
@@ -168,7 +168,7 @@ static int speyside_wm8996_init(struct snd_soc_pcm_runtime *rtd)
 	if (ret)
 		return ret;
 
-	wm8996_detect(codec, &speyside_headset, speyside_set_polarity);
+	wm8996_detect(component, &speyside_headset, speyside_set_polarity);
 
 	return 0;
 }
@@ -232,10 +232,8 @@ static struct snd_soc_dai_link speyside_dai[] = {
 
 static int speyside_wm9081_init(struct snd_soc_component *component)
 {
-	struct snd_soc_codec *codec = snd_soc_component_to_codec(component);
-
 	/* At any time the WM9081 is active it will have this clock */
-	return snd_soc_codec_set_sysclk(codec, WM9081_SYSCLK_MCLK, 0,
+	return snd_soc_component_set_sysclk(component, WM9081_SYSCLK_MCLK, 0,
 					MCLK_AUDIO_RATE, 0);
 }
 
-- 
2.16.1
