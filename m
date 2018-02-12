From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8904: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:47:04 +0000
Message-ID: <E1elDVg-0005aY-Fo@debutante>
References: <87tvv52wh4.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 13A3B267A70
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:47:07 +0100 (CET)
In-Reply-To: <87tvv52wh4.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: wm8904: replace codec to component

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

>From 46a9100c8a94a01bb2d6780b19c9258e9aec323c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:09:37 +0000
Subject: [PATCH] ASoC: wm8904: replace codec to component

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
 sound/soc/codecs/wm8904.c | 355 +++++++++++++++++++++++-----------------------
 1 file changed, 174 insertions(+), 181 deletions(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 4fd350e8420d..20fdcae06c6b 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -316,31 +316,31 @@ static bool wm8904_readable_register(struct device *dev, unsigned int reg)
 	}
 }
 
-static int wm8904_configure_clocking(struct snd_soc_codec *codec)
+static int wm8904_configure_clocking(struct snd_soc_component *component)
 {
-	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
+	struct wm8904_priv *wm8904 = snd_soc_component_get_drvdata(component);
 	unsigned int clock0, clock2, rate;
 
 	/* Gate the clock while we're updating to avoid misclocking */
-	clock2 = snd_soc_read(codec, WM8904_CLOCK_RATES_2);
-	snd_soc_update_bits(codec, WM8904_CLOCK_RATES_2,
+	clock2 = snd_soc_component_read32(component, WM8904_CLOCK_RATES_2);
+	snd_soc_component_update_bits(component, WM8904_CLOCK_RATES_2,
 			    WM8904_SYSCLK_SRC, 0);
 
 	/* This should be done on init() for bypass paths */
 	switch (wm8904->sysclk_src) {
 	case WM8904_CLK_MCLK:
-		dev_dbg(codec->dev, "Using %dHz MCLK\n", wm8904->mclk_rate);
+		dev_dbg(component->dev, "Using %dHz MCLK\n", wm8904->mclk_rate);
 
 		clock2 &= ~WM8904_SYSCLK_SRC;
 		rate = wm8904->mclk_rate;
 
 		/* Ensure the FLL is stopped */
-		snd_soc_update_bits(codec, WM8904_FLL_CONTROL_1,
+		snd_soc_component_update_bits(component, WM8904_FLL_CONTROL_1,
 				    WM8904_FLL_OSC_ENA | WM8904_FLL_ENA, 0);
 		break;
 
 	case WM8904_CLK_FLL:
-		dev_dbg(codec->dev, "Using %dHz FLL clock\n",
+		dev_dbg(component->dev, "Using %dHz FLL clock\n",
 			wm8904->fll_fout);
 
 		clock2 |= WM8904_SYSCLK_SRC;
@@ -348,7 +348,7 @@ static int wm8904_configure_clocking(struct snd_soc_codec *codec)
 		break;
 
 	default:
-		dev_err(codec->dev, "System clock not configured\n");
+		dev_err(component->dev, "System clock not configured\n");
 		return -EINVAL;
 	}
 
@@ -361,40 +361,40 @@ static int wm8904_configure_clocking(struct snd_soc_codec *codec)
 		wm8904->sysclk_rate = rate;
 	}
 
-	snd_soc_update_bits(codec, WM8904_CLOCK_RATES_0, WM8904_MCLK_DIV,
+	snd_soc_component_update_bits(component, WM8904_CLOCK_RATES_0, WM8904_MCLK_DIV,
 			    clock0);
 
-	snd_soc_update_bits(codec, WM8904_CLOCK_RATES_2,
+	snd_soc_component_update_bits(component, WM8904_CLOCK_RATES_2,
 			    WM8904_CLK_SYS_ENA | WM8904_SYSCLK_SRC, clock2);
 
-	dev_dbg(codec->dev, "CLK_SYS is %dHz\n", wm8904->sysclk_rate);
+	dev_dbg(component->dev, "CLK_SYS is %dHz\n", wm8904->sysclk_rate);
 
 	return 0;
 }
 
-static void wm8904_set_drc(struct snd_soc_codec *codec)
+static void wm8904_set_drc(struct snd_soc_component *component)
 {
-	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
+	struct wm8904_priv *wm8904 = snd_soc_component_get_drvdata(component);
 	struct wm8904_pdata *pdata = wm8904->pdata;
 	int save, i;
 
 	/* Save any enables; the configuration should clear them. */
-	save = snd_soc_read(codec, WM8904_DRC_0);
+	save = snd_soc_component_read32(component, WM8904_DRC_0);
 
 	for (i = 0; i < WM8904_DRC_REGS; i++)
-		snd_soc_update_bits(codec, WM8904_DRC_0 + i, 0xffff,
+		snd_soc_component_update_bits(component, WM8904_DRC_0 + i, 0xffff,
 				    pdata->drc_cfgs[wm8904->drc_cfg].regs[i]);
 
 	/* Reenable the DRC */
-	snd_soc_update_bits(codec, WM8904_DRC_0,
+	snd_soc_component_update_bits(component, WM8904_DRC_0,
 			    WM8904_DRC_ENA | WM8904_DRC_DAC_PATH, save);
 }
 
 static int wm8904_put_drc_enum(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm8904_priv *wm8904 = snd_soc_component_get_drvdata(component);
 	struct wm8904_pdata *pdata = wm8904->pdata;
 	int value = ucontrol->value.enumerated.item[0];
 
@@ -403,7 +403,7 @@ static int wm8904_put_drc_enum(struct snd_kcontrol *kcontrol,
 
 	wm8904->drc_cfg = value;
 
-	wm8904_set_drc(codec);
+	wm8904_set_drc(component);
 
 	return 0;
 }
@@ -411,17 +411,17 @@ static int wm8904_put_drc_enum(struct snd_kcontrol *kcontrol,
 static int wm8904_get_drc_enum(struct snd_kcontrol *kcontrol,
 			       struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm8904_priv *wm8904 = snd_soc_component_get_drvdata(component);
 
 	ucontrol->value.enumerated.item[0] = wm8904->drc_cfg;
 
 	return 0;
 }
 
-static void wm8904_set_retune_mobile(struct snd_soc_codec *codec)
+static void wm8904_set_retune_mobile(struct snd_soc_component *component)
 {
-	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
+	struct wm8904_priv *wm8904 = snd_soc_component_get_drvdata(component);
 	struct wm8904_pdata *pdata = wm8904->pdata;
 	int best, best_val, save, i, cfg;
 
@@ -444,7 +444,7 @@ static void wm8904_set_retune_mobile(struct snd_soc_codec *codec)
 		}
 	}
 
-	dev_dbg(codec->dev, "ReTune Mobile %s/%dHz for %dHz sample rate\n",
+	dev_dbg(component->dev, "ReTune Mobile %s/%dHz for %dHz sample rate\n",
 		pdata->retune_mobile_cfgs[best].name,
 		pdata->retune_mobile_cfgs[best].rate,
 		wm8904->fs);
@@ -452,20 +452,20 @@ static void wm8904_set_retune_mobile(struct snd_soc_codec *codec)
 	/* The EQ will be disabled while reconfiguring it, remember the
 	 * current configuration. 
 	 */
-	save = snd_soc_read(codec, WM8904_EQ1);
+	save = snd_soc_component_read32(component, WM8904_EQ1);
 
 	for (i = 0; i < WM8904_EQ_REGS; i++)
-		snd_soc_update_bits(codec, WM8904_EQ1 + i, 0xffff,
+		snd_soc_component_update_bits(component, WM8904_EQ1 + i, 0xffff,
 				pdata->retune_mobile_cfgs[best].regs[i]);
 
-	snd_soc_update_bits(codec, WM8904_EQ1, WM8904_EQ_ENA, save);
+	snd_soc_component_update_bits(component, WM8904_EQ1, WM8904_EQ_ENA, save);
 }
 
 static int wm8904_put_retune_mobile_enum(struct snd_kcontrol *kcontrol,
 					 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm8904_priv *wm8904 = snd_soc_component_get_drvdata(component);
 	struct wm8904_pdata *pdata = wm8904->pdata;
 	int value = ucontrol->value.enumerated.item[0];
 
@@ -474,7 +474,7 @@ static int wm8904_put_retune_mobile_enum(struct snd_kcontrol *kcontrol,
 
 	wm8904->retune_mobile_cfg = value;
 
-	wm8904_set_retune_mobile(codec);
+	wm8904_set_retune_mobile(component);
 
 	return 0;
 }
@@ -482,8 +482,8 @@ static int wm8904_put_retune_mobile_enum(struct snd_kcontrol *kcontrol,
 static int wm8904_get_retune_mobile_enum(struct snd_kcontrol *kcontrol,
 					 struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm8904_priv *wm8904 = snd_soc_component_get_drvdata(component);
 
 	ucontrol->value.enumerated.item[0] = wm8904->retune_mobile_cfg;
 
@@ -492,9 +492,9 @@ static int wm8904_get_retune_mobile_enum(struct snd_kcontrol *kcontrol,
 
 static int deemph_settings[] = { 0, 32000, 44100, 48000 };
 
-static int wm8904_set_deemph(struct snd_soc_codec *codec)
+static int wm8904_set_deemph(struct snd_soc_component *component)
 {
-	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
+	struct wm8904_priv *wm8904 = snd_soc_component_get_drvdata(component);
 	int val, i, best;
 
 	/* If we're using deemphasis select the nearest available sample 
@@ -513,17 +513,17 @@ static int wm8904_set_deemph(struct snd_soc_codec *codec)
 		val = 0;
 	}
 
-	dev_dbg(codec->dev, "Set deemphasis %d\n", val);
+	dev_dbg(component->dev, "Set deemphasis %d\n", val);
 
-	return snd_soc_update_bits(codec, WM8904_DAC_DIGITAL_1,
+	return snd_soc_component_update_bits(component, WM8904_DAC_DIGITAL_1,
 				   WM8904_DEEMPH_MASK, val);
 }
 
 static int wm8904_get_deemph(struct snd_kcontrol *kcontrol,
 			     struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm8904_priv *wm8904 = snd_soc_component_get_drvdata(component);
 
 	ucontrol->value.integer.value[0] = wm8904->deemph;
 	return 0;
@@ -532,8 +532,8 @@ static int wm8904_get_deemph(struct snd_kcontrol *kcontrol,
 static int wm8904_put_deemph(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
-	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct wm8904_priv *wm8904 = snd_soc_component_get_drvdata(component);
 	unsigned int deemph = ucontrol->value.integer.value[0];
 
 	if (deemph > 1)
@@ -541,7 +541,7 @@ static int wm8904_put_deemph(struct snd_kcontrol *kcontrol,
 
 	wm8904->deemph = deemph;
 
-	return wm8904_set_deemph(codec);
+	return wm8904_set_deemph(component);
 }
 
 static const DECLARE_TLV_DB_SCALE(dac_boost_tlv, 0, 600, 0);
@@ -572,7 +572,7 @@ static SOC_ENUM_SINGLE_DECL(hpf_mode, WM8904_ADC_DIGITAL_0, 5,
 static int wm8904_adc_osr_put(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	unsigned int val;
 	int ret;
 
@@ -585,7 +585,7 @@ static int wm8904_adc_osr_put(struct snd_kcontrol *kcontrol,
 	else
 		val = WM8904_ADC_128_OSR_TST_MODE | WM8904_ADC_BIASX1P5;
 
-	snd_soc_update_bits(codec, WM8904_ADC_TEST_0,
+	snd_soc_component_update_bits(component, WM8904_ADC_TEST_0,
 			    WM8904_ADC_128_OSR_TST_MODE | WM8904_ADC_BIASX1P5,
 			    val);
 
@@ -673,8 +673,8 @@ static int cp_event(struct snd_soc_dapm_widget *w,
 static int sysclk_event(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct wm8904_priv *wm8904 = snd_soc_component_get_drvdata(component);
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -685,11 +685,11 @@ static int sysclk_event(struct snd_soc_dapm_widget *w,
 		 */
 		switch (wm8904->sysclk_src) {
 		case WM8904_CLK_FLL:
-			snd_soc_update_bits(codec, WM8904_FLL_CONTROL_1,
+			snd_soc_component_update_bits(component, WM8904_FLL_CONTROL_1,
 					    WM8904_FLL_OSC_ENA,
 					    WM8904_FLL_OSC_ENA);
 
-			snd_soc_update_bits(codec, WM8904_FLL_CONTROL_1,
+			snd_soc_component_update_bits(component, WM8904_FLL_CONTROL_1,
 					    WM8904_FLL_ENA,
 					    WM8904_FLL_ENA);
 			break;
@@ -700,7 +700,7 @@ static int sysclk_event(struct snd_soc_dapm_widget *w,
 		break;
 
 	case SND_SOC_DAPM_POST_PMD:
-		snd_soc_update_bits(codec, WM8904_FLL_CONTROL_1,
+		snd_soc_component_update_bits(component, WM8904_FLL_CONTROL_1,
 				    WM8904_FLL_OSC_ENA | WM8904_FLL_ENA, 0);
 		break;
 	}
@@ -711,8 +711,8 @@ static int sysclk_event(struct snd_soc_dapm_widget *w,
 static int out_pga_event(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct wm8904_priv *wm8904 = snd_soc_component_get_drvdata(component);
 	int reg, val;
 	int dcs_mask;
 	int dcs_l, dcs_r;
@@ -751,43 +751,43 @@ static int out_pga_event(struct snd_soc_dapm_widget *w,
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		/* Power on the PGAs */
-		snd_soc_update_bits(codec, pwr_reg,
+		snd_soc_component_update_bits(component, pwr_reg,
 				    WM8904_HPL_PGA_ENA | WM8904_HPR_PGA_ENA,
 				    WM8904_HPL_PGA_ENA | WM8904_HPR_PGA_ENA);
 
 		/* Power on the amplifier */
-		snd_soc_update_bits(codec, reg,
+		snd_soc_component_update_bits(component, reg,
 				    WM8904_HPL_ENA | WM8904_HPR_ENA,
 				    WM8904_HPL_ENA | WM8904_HPR_ENA);
 
 
 		/* Enable the first stage */
-		snd_soc_update_bits(codec, reg,
+		snd_soc_component_update_bits(component, reg,
 				    WM8904_HPL_ENA_DLY | WM8904_HPR_ENA_DLY,
 				    WM8904_HPL_ENA_DLY | WM8904_HPR_ENA_DLY);
 
 		/* Power up the DC servo */
-		snd_soc_update_bits(codec, WM8904_DC_SERVO_0,
+		snd_soc_component_update_bits(component, WM8904_DC_SERVO_0,
 				    dcs_mask, dcs_mask);
 
 		/* Either calibrate the DC servo or restore cached state
 		 * if we have that.
 		 */
 		if (wm8904->dcs_state[dcs_l] || wm8904->dcs_state[dcs_r]) {
-			dev_dbg(codec->dev, "Restoring DC servo state\n");
+			dev_dbg(component->dev, "Restoring DC servo state\n");
 
-			snd_soc_write(codec, dcs_l_reg,
+			snd_soc_component_write(component, dcs_l_reg,
 				      wm8904->dcs_state[dcs_l]);
-			snd_soc_write(codec, dcs_r_reg,
+			snd_soc_component_write(component, dcs_r_reg,
 				      wm8904->dcs_state[dcs_r]);
 
-			snd_soc_write(codec, WM8904_DC_SERVO_1, dcs_mask);
+			snd_soc_component_write(component, WM8904_DC_SERVO_1, dcs_mask);
 
 			timeout = 20;
 		} else {
-			dev_dbg(codec->dev, "Calibrating DC servo\n");
+			dev_dbg(component->dev, "Calibrating DC servo\n");
 
-			snd_soc_write(codec, WM8904_DC_SERVO_1,
+			snd_soc_component_write(component, WM8904_DC_SERVO_1,
 				dcs_mask << WM8904_DCS_TRIG_STARTUP_0_SHIFT);
 
 			timeout = 500;
@@ -796,7 +796,7 @@ static int out_pga_event(struct snd_soc_dapm_widget *w,
 		/* Wait for DC servo to complete */
 		dcs_mask <<= WM8904_DCS_CAL_COMPLETE_SHIFT;
 		do {
-			val = snd_soc_read(codec, WM8904_DC_SERVO_READBACK_0);
+			val = snd_soc_component_read32(component, WM8904_DC_SERVO_READBACK_0);
 			if ((val & dcs_mask) == dcs_mask)
 				break;
 
@@ -804,19 +804,19 @@ static int out_pga_event(struct snd_soc_dapm_widget *w,
 		} while (--timeout);
 
 		if ((val & dcs_mask) != dcs_mask)
-			dev_warn(codec->dev, "DC servo timed out\n");
+			dev_warn(component->dev, "DC servo timed out\n");
 		else
-			dev_dbg(codec->dev, "DC servo ready\n");
+			dev_dbg(component->dev, "DC servo ready\n");
 
 		/* Enable the output stage */
-		snd_soc_update_bits(codec, reg,
+		snd_soc_component_update_bits(component, reg,
 				    WM8904_HPL_ENA_OUTP | WM8904_HPR_ENA_OUTP,
 				    WM8904_HPL_ENA_OUTP | WM8904_HPR_ENA_OUTP);
 		break;
 
 	case SND_SOC_DAPM_POST_PMU:
 		/* Unshort the output itself */
-		snd_soc_update_bits(codec, reg,
+		snd_soc_component_update_bits(component, reg,
 				    WM8904_HPL_RMV_SHORT |
 				    WM8904_HPR_RMV_SHORT,
 				    WM8904_HPL_RMV_SHORT |
@@ -826,7 +826,7 @@ static int out_pga_event(struct snd_soc_dapm_widget *w,
 
 	case SND_SOC_DAPM_PRE_PMD:
 		/* Short the output */
-		snd_soc_update_bits(codec, reg,
+		snd_soc_component_update_bits(component, reg,
 				    WM8904_HPL_RMV_SHORT |
 				    WM8904_HPR_RMV_SHORT, 0);
 		break;
@@ -834,21 +834,21 @@ static int out_pga_event(struct snd_soc_dapm_widget *w,
 	case SND_SOC_DAPM_POST_PMD:
 		/* Cache the DC servo configuration; this will be
 		 * invalidated if we change the configuration. */
-		wm8904->dcs_state[dcs_l] = snd_soc_read(codec, dcs_l_reg);
-		wm8904->dcs_state[dcs_r] = snd_soc_read(codec, dcs_r_reg);
+		wm8904->dcs_state[dcs_l] = snd_soc_component_read32(component, dcs_l_reg);
+		wm8904->dcs_state[dcs_r] = snd_soc_component_read32(component, dcs_r_reg);
 
-		snd_soc_update_bits(codec, WM8904_DC_SERVO_0,
+		snd_soc_component_update_bits(component, WM8904_DC_SERVO_0,
 				    dcs_mask, 0);
 
 		/* Disable the amplifier input and output stages */
-		snd_soc_update_bits(codec, reg,
+		snd_soc_component_update_bits(component, reg,
 				    WM8904_HPL_ENA | WM8904_HPR_ENA |
 				    WM8904_HPL_ENA_DLY | WM8904_HPR_ENA_DLY |
 				    WM8904_HPL_ENA_OUTP | WM8904_HPR_ENA_OUTP,
 				    0);
 
 		/* PGAs too */
-		snd_soc_update_bits(codec, pwr_reg,
+		snd_soc_component_update_bits(component, pwr_reg,
 				    WM8904_HPL_PGA_ENA | WM8904_HPR_PGA_ENA,
 				    0);
 		break;
@@ -1165,10 +1165,10 @@ static const struct snd_soc_dapm_route wm8912_intercon[] = {
 	{ "LINER PGA", NULL, "DACR" },
 };
 
-static int wm8904_add_widgets(struct snd_soc_codec *codec)
+static int wm8904_add_widgets(struct snd_soc_component *component)
 {
-	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	struct wm8904_priv *wm8904 = snd_soc_component_get_drvdata(component);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 
 	snd_soc_dapm_new_controls(dapm, wm8904_core_dapm_widgets,
 				  ARRAY_SIZE(wm8904_core_dapm_widgets));
@@ -1177,11 +1177,11 @@ static int wm8904_add_widgets(struct snd_soc_codec *codec)
 
 	switch (wm8904->devtype) {
 	case WM8904:
-		snd_soc_add_codec_controls(codec, wm8904_adc_snd_controls,
+		snd_soc_add_component_controls(component, wm8904_adc_snd_controls,
 				     ARRAY_SIZE(wm8904_adc_snd_controls));
-		snd_soc_add_codec_controls(codec, wm8904_dac_snd_controls,
+		snd_soc_add_component_controls(component, wm8904_dac_snd_controls,
 				     ARRAY_SIZE(wm8904_dac_snd_controls));
-		snd_soc_add_codec_controls(codec, wm8904_snd_controls,
+		snd_soc_add_component_controls(component, wm8904_snd_controls,
 				     ARRAY_SIZE(wm8904_snd_controls));
 
 		snd_soc_dapm_new_controls(dapm, wm8904_adc_dapm_widgets,
@@ -1200,7 +1200,7 @@ static int wm8904_add_widgets(struct snd_soc_codec *codec)
 		break;
 
 	case WM8912:
-		snd_soc_add_codec_controls(codec, wm8904_dac_snd_controls,
+		snd_soc_add_component_controls(component, wm8904_dac_snd_controls,
 				     ARRAY_SIZE(wm8904_dac_snd_controls));
 
 		snd_soc_dapm_new_controls(dapm, wm8904_dac_dapm_widgets,
@@ -1278,8 +1278,8 @@ static int wm8904_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct wm8904_priv *wm8904 = snd_soc_component_get_drvdata(component);
 	int ret, i, best, best_val, cur_val;
 	unsigned int aif1 = 0;
 	unsigned int aif2 = 0;
@@ -1290,7 +1290,7 @@ static int wm8904_hw_params(struct snd_pcm_substream *substream,
 	/* What BCLK do we need? */
 	wm8904->fs = params_rate(params);
 	if (wm8904->tdm_slots) {
-		dev_dbg(codec->dev, "Configuring for %d %d bit TDM slots\n",
+		dev_dbg(component->dev, "Configuring for %d %d bit TDM slots\n",
 			wm8904->tdm_slots, wm8904->tdm_width);
 		wm8904->bclk = snd_soc_calc_bclk(wm8904->fs,
 						 wm8904->tdm_width, 2,
@@ -1316,9 +1316,9 @@ static int wm8904_hw_params(struct snd_pcm_substream *substream,
 	}
 
 
-	dev_dbg(codec->dev, "Target BCLK is %dHz\n", wm8904->bclk);
+	dev_dbg(component->dev, "Target BCLK is %dHz\n", wm8904->bclk);
 
-	ret = wm8904_configure_clocking(codec);
+	ret = wm8904_configure_clocking(component);
 	if (ret != 0)
 		return ret;
 
@@ -1334,7 +1334,7 @@ static int wm8904_hw_params(struct snd_pcm_substream *substream,
 			best_val = cur_val;
 		}
 	}
-	dev_dbg(codec->dev, "Selected CLK_SYS_RATIO of %d\n",
+	dev_dbg(component->dev, "Selected CLK_SYS_RATIO of %d\n",
 		clk_sys_rates[best].ratio);
 	clock1 |= (clk_sys_rates[best].clk_sys_rate
 		   << WM8904_CLK_SYS_RATE_SHIFT);
@@ -1350,7 +1350,7 @@ static int wm8904_hw_params(struct snd_pcm_substream *substream,
 			best_val = cur_val;
 		}
 	}
-	dev_dbg(codec->dev, "Selected SAMPLE_RATE of %dHz\n",
+	dev_dbg(component->dev, "Selected SAMPLE_RATE of %dHz\n",
 		sample_rates[best].rate);
 	clock1 |= (sample_rates[best].sample_rate
 		   << WM8904_SAMPLE_RATE_SHIFT);
@@ -1373,30 +1373,30 @@ static int wm8904_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 	wm8904->bclk = (wm8904->sysclk_rate * 10) / bclk_divs[best].div;
-	dev_dbg(codec->dev, "Selected BCLK_DIV of %d for %dHz BCLK\n",
+	dev_dbg(component->dev, "Selected BCLK_DIV of %d for %dHz BCLK\n",
 		bclk_divs[best].div, wm8904->bclk);
 	aif2 |= bclk_divs[best].bclk_div;
 
 	/* LRCLK is a simple fraction of BCLK */
-	dev_dbg(codec->dev, "LRCLK_RATE is %d\n", wm8904->bclk / wm8904->fs);
+	dev_dbg(component->dev, "LRCLK_RATE is %d\n", wm8904->bclk / wm8904->fs);
 	aif3 |= wm8904->bclk / wm8904->fs;
 
 	/* Apply the settings */
-	snd_soc_update_bits(codec, WM8904_DAC_DIGITAL_1,
+	snd_soc_component_update_bits(component, WM8904_DAC_DIGITAL_1,
 			    WM8904_DAC_SB_FILT, dac_digital1);
-	snd_soc_update_bits(codec, WM8904_AUDIO_INTERFACE_1,
+	snd_soc_component_update_bits(component, WM8904_AUDIO_INTERFACE_1,
 			    WM8904_AIF_WL_MASK, aif1);
-	snd_soc_update_bits(codec, WM8904_AUDIO_INTERFACE_2,
+	snd_soc_component_update_bits(component, WM8904_AUDIO_INTERFACE_2,
 			    WM8904_BCLK_DIV_MASK, aif2);
-	snd_soc_update_bits(codec, WM8904_AUDIO_INTERFACE_3,
+	snd_soc_component_update_bits(component, WM8904_AUDIO_INTERFACE_3,
 			    WM8904_LRCLK_RATE_MASK, aif3);
-	snd_soc_update_bits(codec, WM8904_CLOCK_RATES_1,
+	snd_soc_component_update_bits(component, WM8904_CLOCK_RATES_1,
 			    WM8904_SAMPLE_RATE_MASK |
 			    WM8904_CLK_SYS_RATE_MASK, clock1);
 
 	/* Update filters for the new settings */
-	wm8904_set_retune_mobile(codec);
-	wm8904_set_deemph(codec);
+	wm8904_set_retune_mobile(component);
+	wm8904_set_deemph(component);
 
 	return 0;
 }
@@ -1405,8 +1405,8 @@ static int wm8904_hw_params(struct snd_pcm_substream *substream,
 static int wm8904_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 			     unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm8904_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct wm8904_priv *priv = snd_soc_component_get_drvdata(component);
 
 	switch (clk_id) {
 	case WM8904_CLK_MCLK:
@@ -1424,14 +1424,14 @@ static int wm8904_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 
 	dev_dbg(dai->dev, "Clock source is %d at %uHz\n", clk_id, freq);
 
-	wm8904_configure_clocking(codec);
+	wm8904_configure_clocking(component);
 
 	return 0;
 }
 
 static int wm8904_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	unsigned int aif1 = 0;
 	unsigned int aif3 = 0;
 
@@ -1508,10 +1508,10 @@ static int wm8904_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, WM8904_AUDIO_INTERFACE_1,
+	snd_soc_component_update_bits(component, WM8904_AUDIO_INTERFACE_1,
 			    WM8904_AIF_BCLK_INV | WM8904_AIF_LRCLK_INV |
 			    WM8904_AIF_FMT_MASK | WM8904_BCLK_DIR, aif1);
-	snd_soc_update_bits(codec, WM8904_AUDIO_INTERFACE_3,
+	snd_soc_component_update_bits(component, WM8904_AUDIO_INTERFACE_3,
 			    WM8904_LRCLK_DIR, aif3);
 
 	return 0;
@@ -1521,8 +1521,8 @@ static int wm8904_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 static int wm8904_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 			       unsigned int rx_mask, int slots, int slot_width)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct wm8904_priv *wm8904 = snd_soc_component_get_drvdata(component);
 	int aif1 = 0;
 
 	/* Don't need to validate anything if we're turning off TDM */
@@ -1560,7 +1560,7 @@ static int wm8904_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 	wm8904->tdm_width = slot_width;
 	wm8904->tdm_slots = slots / 2;
 
-	snd_soc_update_bits(codec, WM8904_AUDIO_INTERFACE_1,
+	snd_soc_component_update_bits(component, WM8904_AUDIO_INTERFACE_1,
 			    WM8904_AIFADC_TDM | WM8904_AIFADC_TDM_CHAN |
 			    WM8904_AIFDAC_TDM | WM8904_AIFDAC_TDM_CHAN, aif1);
 
@@ -1678,8 +1678,8 @@ static int fll_factors(struct _fll_div *fll_div, unsigned int Fref,
 static int wm8904_set_fll(struct snd_soc_dai *dai, int fll_id, int source,
 			  unsigned int Fref, unsigned int Fout)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct wm8904_priv *wm8904 = snd_soc_component_get_drvdata(component);
 	struct _fll_div fll_div;
 	int ret, val;
 	int clock2, fll1;
@@ -1689,19 +1689,19 @@ static int wm8904_set_fll(struct snd_soc_dai *dai, int fll_id, int source,
 	    Fout == wm8904->fll_fout)
 		return 0;
 
-	clock2 = snd_soc_read(codec, WM8904_CLOCK_RATES_2);
+	clock2 = snd_soc_component_read32(component, WM8904_CLOCK_RATES_2);
 
 	if (Fout == 0) {
-		dev_dbg(codec->dev, "FLL disabled\n");
+		dev_dbg(component->dev, "FLL disabled\n");
 
 		wm8904->fll_fref = 0;
 		wm8904->fll_fout = 0;
 
 		/* Gate SYSCLK to avoid glitches */
-		snd_soc_update_bits(codec, WM8904_CLOCK_RATES_2,
+		snd_soc_component_update_bits(component, WM8904_CLOCK_RATES_2,
 				    WM8904_CLK_SYS_ENA, 0);
 
-		snd_soc_update_bits(codec, WM8904_FLL_CONTROL_1,
+		snd_soc_component_update_bits(component, WM8904_FLL_CONTROL_1,
 				    WM8904_FLL_OSC_ENA | WM8904_FLL_ENA, 0);
 
 		goto out;
@@ -1718,7 +1718,7 @@ static int wm8904_set_fll(struct snd_soc_dai *dai, int fll_id, int source,
 		break;
 
 	case WM8904_FLL_FREE_RUNNING:
-		dev_dbg(codec->dev, "Using free running FLL\n");
+		dev_dbg(component->dev, "Using free running FLL\n");
 		/* Force 12MHz and output/4 for now */
 		Fout = 12000000;
 		Fref = 12000000;
@@ -1728,20 +1728,20 @@ static int wm8904_set_fll(struct snd_soc_dai *dai, int fll_id, int source,
 		break;
 
 	default:
-		dev_err(codec->dev, "Unknown FLL ID %d\n", fll_id);
+		dev_err(component->dev, "Unknown FLL ID %d\n", fll_id);
 		return -EINVAL;
 	}
 
 	/* Save current state then disable the FLL and SYSCLK to avoid
 	 * misclocking */
-	fll1 = snd_soc_read(codec, WM8904_FLL_CONTROL_1);
-	snd_soc_update_bits(codec, WM8904_CLOCK_RATES_2,
+	fll1 = snd_soc_component_read32(component, WM8904_FLL_CONTROL_1);
+	snd_soc_component_update_bits(component, WM8904_CLOCK_RATES_2,
 			    WM8904_CLK_SYS_ENA, 0);
-	snd_soc_update_bits(codec, WM8904_FLL_CONTROL_1,
+	snd_soc_component_update_bits(component, WM8904_FLL_CONTROL_1,
 			    WM8904_FLL_OSC_ENA | WM8904_FLL_ENA, 0);
 
 	/* Unlock forced oscilator control to switch it on/off */
-	snd_soc_update_bits(codec, WM8904_CONTROL_INTERFACE_TEST_1,
+	snd_soc_component_update_bits(component, WM8904_CONTROL_INTERFACE_TEST_1,
 			    WM8904_USER_KEY, WM8904_USER_KEY);
 
 	if (fll_id == WM8904_FLL_FREE_RUNNING) {
@@ -1750,24 +1750,24 @@ static int wm8904_set_fll(struct snd_soc_dai *dai, int fll_id, int source,
 		val = 0;
 	}
 
-	snd_soc_update_bits(codec, WM8904_FLL_NCO_TEST_1, WM8904_FLL_FRC_NCO,
+	snd_soc_component_update_bits(component, WM8904_FLL_NCO_TEST_1, WM8904_FLL_FRC_NCO,
 			    val);
-	snd_soc_update_bits(codec, WM8904_CONTROL_INTERFACE_TEST_1,
+	snd_soc_component_update_bits(component, WM8904_CONTROL_INTERFACE_TEST_1,
 			    WM8904_USER_KEY, 0);
 
 	switch (fll_id) {
 	case WM8904_FLL_MCLK:
-		snd_soc_update_bits(codec, WM8904_FLL_CONTROL_5,
+		snd_soc_component_update_bits(component, WM8904_FLL_CONTROL_5,
 				    WM8904_FLL_CLK_REF_SRC_MASK, 0);
 		break;
 
 	case WM8904_FLL_LRCLK:
-		snd_soc_update_bits(codec, WM8904_FLL_CONTROL_5,
+		snd_soc_component_update_bits(component, WM8904_FLL_CONTROL_5,
 				    WM8904_FLL_CLK_REF_SRC_MASK, 1);
 		break;
 
 	case WM8904_FLL_BCLK:
-		snd_soc_update_bits(codec, WM8904_FLL_CONTROL_5,
+		snd_soc_component_update_bits(component, WM8904_FLL_CONTROL_5,
 				    WM8904_FLL_CLK_REF_SRC_MASK, 2);
 		break;
 	}
@@ -1776,39 +1776,39 @@ static int wm8904_set_fll(struct snd_soc_dai *dai, int fll_id, int source,
 		val = WM8904_FLL_FRACN_ENA;
 	else
 		val = 0;
-	snd_soc_update_bits(codec, WM8904_FLL_CONTROL_1,
+	snd_soc_component_update_bits(component, WM8904_FLL_CONTROL_1,
 			    WM8904_FLL_FRACN_ENA, val);
 
-	snd_soc_update_bits(codec, WM8904_FLL_CONTROL_2,
+	snd_soc_component_update_bits(component, WM8904_FLL_CONTROL_2,
 			    WM8904_FLL_OUTDIV_MASK | WM8904_FLL_FRATIO_MASK,
 			    (fll_div.fll_outdiv << WM8904_FLL_OUTDIV_SHIFT) |
 			    (fll_div.fll_fratio << WM8904_FLL_FRATIO_SHIFT));
 
-	snd_soc_write(codec, WM8904_FLL_CONTROL_3, fll_div.k);
+	snd_soc_component_write(component, WM8904_FLL_CONTROL_3, fll_div.k);
 
-	snd_soc_update_bits(codec, WM8904_FLL_CONTROL_4, WM8904_FLL_N_MASK,
+	snd_soc_component_update_bits(component, WM8904_FLL_CONTROL_4, WM8904_FLL_N_MASK,
 			    fll_div.n << WM8904_FLL_N_SHIFT);
 
-	snd_soc_update_bits(codec, WM8904_FLL_CONTROL_5,
+	snd_soc_component_update_bits(component, WM8904_FLL_CONTROL_5,
 			    WM8904_FLL_CLK_REF_DIV_MASK,
 			    fll_div.fll_clk_ref_div 
 			    << WM8904_FLL_CLK_REF_DIV_SHIFT);
 
-	dev_dbg(codec->dev, "FLL configured for %dHz->%dHz\n", Fref, Fout);
+	dev_dbg(component->dev, "FLL configured for %dHz->%dHz\n", Fref, Fout);
 
 	wm8904->fll_fref = Fref;
 	wm8904->fll_fout = Fout;
 	wm8904->fll_src = source;
 
 	/* Enable the FLL if it was previously active */
-	snd_soc_update_bits(codec, WM8904_FLL_CONTROL_1,
+	snd_soc_component_update_bits(component, WM8904_FLL_CONTROL_1,
 			    WM8904_FLL_OSC_ENA, fll1);
-	snd_soc_update_bits(codec, WM8904_FLL_CONTROL_1,
+	snd_soc_component_update_bits(component, WM8904_FLL_CONTROL_1,
 			    WM8904_FLL_ENA, fll1);
 
 out:
 	/* Reenable SYSCLK if it was previously active */
-	snd_soc_update_bits(codec, WM8904_CLOCK_RATES_2,
+	snd_soc_component_update_bits(component, WM8904_CLOCK_RATES_2,
 			    WM8904_CLK_SYS_ENA, clock2);
 
 	return 0;
@@ -1816,7 +1816,7 @@ static int wm8904_set_fll(struct snd_soc_dai *dai, int fll_id, int source,
 
 static int wm8904_digital_mute(struct snd_soc_dai *codec_dai, int mute)
 {
-	struct snd_soc_codec *codec = codec_dai->codec;
+	struct snd_soc_component *component = codec_dai->component;
 	int val;
 
 	if (mute)
@@ -1824,15 +1824,15 @@ static int wm8904_digital_mute(struct snd_soc_dai *codec_dai, int mute)
 	else
 		val = 0;
 
-	snd_soc_update_bits(codec, WM8904_DAC_DIGITAL_1, WM8904_DAC_MUTE, val);
+	snd_soc_component_update_bits(component, WM8904_DAC_DIGITAL_1, WM8904_DAC_MUTE, val);
 
 	return 0;
 }
 
-static int wm8904_set_bias_level(struct snd_soc_codec *codec,
+static int wm8904_set_bias_level(struct snd_soc_component *component,
 				 enum snd_soc_bias_level level)
 {
-	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
+	struct wm8904_priv *wm8904 = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	switch (level) {
@@ -1844,21 +1844,21 @@ static int wm8904_set_bias_level(struct snd_soc_codec *codec,
 
 	case SND_SOC_BIAS_PREPARE:
 		/* VMID resistance 2*50k */
-		snd_soc_update_bits(codec, WM8904_VMID_CONTROL_0,
+		snd_soc_component_update_bits(component, WM8904_VMID_CONTROL_0,
 				    WM8904_VMID_RES_MASK,
 				    0x1 << WM8904_VMID_RES_SHIFT);
 
 		/* Normal bias current */
-		snd_soc_update_bits(codec, WM8904_BIAS_CONTROL_0,
+		snd_soc_component_update_bits(component, WM8904_BIAS_CONTROL_0,
 				    WM8904_ISEL_MASK, 2 << WM8904_ISEL_SHIFT);
 		break;
 
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
 			ret = regulator_bulk_enable(ARRAY_SIZE(wm8904->supplies),
 						    wm8904->supplies);
 			if (ret != 0) {
-				dev_err(codec->dev,
+				dev_err(component->dev,
 					"Failed to enable supplies: %d\n",
 					ret);
 				return ret;
@@ -1868,11 +1868,11 @@ static int wm8904_set_bias_level(struct snd_soc_codec *codec,
 			regcache_sync(wm8904->regmap);
 
 			/* Enable bias */
-			snd_soc_update_bits(codec, WM8904_BIAS_CONTROL_0,
+			snd_soc_component_update_bits(component, WM8904_BIAS_CONTROL_0,
 					    WM8904_BIAS_ENA, WM8904_BIAS_ENA);
 
 			/* Enable VMID, VMID buffering, 2*5k resistance */
-			snd_soc_update_bits(codec, WM8904_VMID_CONTROL_0,
+			snd_soc_component_update_bits(component, WM8904_VMID_CONTROL_0,
 					    WM8904_VMID_ENA |
 					    WM8904_VMID_RES_MASK,
 					    WM8904_VMID_ENA |
@@ -1883,22 +1883,22 @@ static int wm8904_set_bias_level(struct snd_soc_codec *codec,
 		}
 
 		/* Maintain VMID with 2*250k */
-		snd_soc_update_bits(codec, WM8904_VMID_CONTROL_0,
+		snd_soc_component_update_bits(component, WM8904_VMID_CONTROL_0,
 				    WM8904_VMID_RES_MASK,
 				    0x2 << WM8904_VMID_RES_SHIFT);
 
 		/* Bias current *0.5 */
-		snd_soc_update_bits(codec, WM8904_BIAS_CONTROL_0,
+		snd_soc_component_update_bits(component, WM8904_BIAS_CONTROL_0,
 				    WM8904_ISEL_MASK, 0);
 		break;
 
 	case SND_SOC_BIAS_OFF:
 		/* Turn off VMID */
-		snd_soc_update_bits(codec, WM8904_VMID_CONTROL_0,
+		snd_soc_component_update_bits(component, WM8904_VMID_CONTROL_0,
 				    WM8904_VMID_RES_MASK | WM8904_VMID_ENA, 0);
 
 		/* Stop bias generation */
-		snd_soc_update_bits(codec, WM8904_BIAS_CONTROL_0,
+		snd_soc_component_update_bits(component, WM8904_BIAS_CONTROL_0,
 				    WM8904_BIAS_ENA, 0);
 
 		regcache_cache_only(wm8904->regmap, true);
@@ -1946,9 +1946,9 @@ static struct snd_soc_dai_driver wm8904_dai = {
 	.symmetric_rates = 1,
 };
 
-static void wm8904_handle_retune_mobile_pdata(struct snd_soc_codec *codec)
+static void wm8904_handle_retune_mobile_pdata(struct snd_soc_component *component)
 {
-	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
+	struct wm8904_priv *wm8904 = snd_soc_component_get_drvdata(component);
 	struct wm8904_pdata *pdata = wm8904->pdata;
 	struct snd_kcontrol_new control =
 		SOC_ENUM_EXT("EQ Mode",
@@ -1991,31 +1991,31 @@ static void wm8904_handle_retune_mobile_pdata(struct snd_soc_codec *codec)
 		wm8904->retune_mobile_texts = t;
 	}
 
-	dev_dbg(codec->dev, "Allocated %d unique ReTune Mobile names\n",
+	dev_dbg(component->dev, "Allocated %d unique ReTune Mobile names\n",
 		wm8904->num_retune_mobile_texts);
 
 	wm8904->retune_mobile_enum.items = wm8904->num_retune_mobile_texts;
 	wm8904->retune_mobile_enum.texts = wm8904->retune_mobile_texts;
 
-	ret = snd_soc_add_codec_controls(codec, &control, 1);
+	ret = snd_soc_add_component_controls(component, &control, 1);
 	if (ret != 0)
-		dev_err(codec->dev,
+		dev_err(component->dev,
 			"Failed to add ReTune Mobile control: %d\n", ret);
 }
 
-static void wm8904_handle_pdata(struct snd_soc_codec *codec)
+static void wm8904_handle_pdata(struct snd_soc_component *component)
 {
-	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
+	struct wm8904_priv *wm8904 = snd_soc_component_get_drvdata(component);
 	struct wm8904_pdata *pdata = wm8904->pdata;
 	int ret, i;
 
 	if (!pdata) {
-		snd_soc_add_codec_controls(codec, wm8904_eq_controls,
+		snd_soc_add_component_controls(component, wm8904_eq_controls,
 				     ARRAY_SIZE(wm8904_eq_controls));
 		return;
 	}
 
-	dev_dbg(codec->dev, "%d DRC configurations\n", pdata->num_drc_cfgs);
+	dev_dbg(component->dev, "%d DRC configurations\n", pdata->num_drc_cfgs);
 
 	if (pdata->num_drc_cfgs) {
 		struct snd_kcontrol_new control =
@@ -2034,28 +2034,28 @@ static void wm8904_handle_pdata(struct snd_soc_codec *codec)
 		wm8904->drc_enum.items = pdata->num_drc_cfgs;
 		wm8904->drc_enum.texts = wm8904->drc_texts;
 
-		ret = snd_soc_add_codec_controls(codec, &control, 1);
+		ret = snd_soc_add_component_controls(component, &control, 1);
 		if (ret != 0)
-			dev_err(codec->dev,
+			dev_err(component->dev,
 				"Failed to add DRC mode control: %d\n", ret);
 
-		wm8904_set_drc(codec);
+		wm8904_set_drc(component);
 	}
 
-	dev_dbg(codec->dev, "%d ReTune Mobile configurations\n",
+	dev_dbg(component->dev, "%d ReTune Mobile configurations\n",
 		pdata->num_retune_mobile_cfgs);
 
 	if (pdata->num_retune_mobile_cfgs)
-		wm8904_handle_retune_mobile_pdata(codec);
+		wm8904_handle_retune_mobile_pdata(component);
 	else
-		snd_soc_add_codec_controls(codec, wm8904_eq_controls,
+		snd_soc_add_component_controls(component, wm8904_eq_controls,
 				     ARRAY_SIZE(wm8904_eq_controls));
 }
 
 
-static int wm8904_probe(struct snd_soc_codec *codec)
+static int wm8904_probe(struct snd_soc_component *component)
 {
-	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
+	struct wm8904_priv *wm8904 = snd_soc_component_get_drvdata(component);
 
 	switch (wm8904->devtype) {
 	case WM8904:
@@ -2064,33 +2064,33 @@ static int wm8904_probe(struct snd_soc_codec *codec)
 		memset(&wm8904_dai.capture, 0, sizeof(wm8904_dai.capture));
 		break;
 	default:
-		dev_err(codec->dev, "Unknown device type %d\n",
+		dev_err(component->dev, "Unknown device type %d\n",
 			wm8904->devtype);
 		return -EINVAL;
 	}
 
-	wm8904_handle_pdata(codec);
+	wm8904_handle_pdata(component);
 
-	wm8904_add_widgets(codec);
+	wm8904_add_widgets(component);
 
 	return 0;
 }
 
-static int wm8904_remove(struct snd_soc_codec *codec)
+static void wm8904_remove(struct snd_soc_component *component)
 {
-	struct wm8904_priv *wm8904 = snd_soc_codec_get_drvdata(codec);
+	struct wm8904_priv *wm8904 = snd_soc_component_get_drvdata(component);
 
 	kfree(wm8904->retune_mobile_texts);
 	kfree(wm8904->drc_texts);
-
-	return 0;
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_wm8904 = {
-	.probe =	wm8904_probe,
-	.remove =	wm8904_remove,
-	.set_bias_level = wm8904_set_bias_level,
-	.idle_bias_off = true,
+static const struct snd_soc_component_driver soc_component_dev_wm8904 = {
+	.probe			= wm8904_probe,
+	.remove			= wm8904_remove,
+	.set_bias_level		= wm8904_set_bias_level,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static const struct regmap_config wm8904_regmap = {
@@ -2265,8 +2265,8 @@ static int wm8904_i2c_probe(struct i2c_client *i2c,
 	regcache_cache_only(wm8904->regmap, true);
 	regulator_bulk_disable(ARRAY_SIZE(wm8904->supplies), wm8904->supplies);
 
-	ret = snd_soc_register_codec(&i2c->dev,
-			&soc_codec_dev_wm8904, &wm8904_dai, 1);
+	ret = devm_snd_soc_register_component(&i2c->dev,
+			&soc_component_dev_wm8904, &wm8904_dai, 1);
 	if (ret != 0)
 		return ret;
 
@@ -2277,12 +2277,6 @@ static int wm8904_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
-static int wm8904_i2c_remove(struct i2c_client *client)
-{
-	snd_soc_unregister_codec(&client->dev);
-	return 0;
-}
-
 static const struct i2c_device_id wm8904_i2c_id[] = {
 	{ "wm8904", WM8904 },
 	{ "wm8912", WM8912 },
@@ -2297,7 +2291,6 @@ static struct i2c_driver wm8904_i2c_driver = {
 		.of_match_table = of_match_ptr(wm8904_of_match),
 	},
 	.probe =    wm8904_i2c_probe,
-	.remove =   wm8904_i2c_remove,
 	.id_table = wm8904_i2c_id,
 };
 
-- 
2.16.1
