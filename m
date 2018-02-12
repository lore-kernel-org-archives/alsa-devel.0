From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5659: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:45:08 +0000
Message-ID: <E1elDTo-0005Gf-5C@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B694D267CBC
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:45:10 +0100 (CET)
In-Reply-To: 
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

   ASoC: rt5659: replace codec to component

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

>From de86a33253d07675abbb1fa294ffb4f3df6f219e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 03:45:50 +0000
Subject: [PATCH] ASoC: rt5659: replace codec to component

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
 sound/soc/codecs/rt5659.c | 307 ++++++++++++++++++++++------------------------
 sound/soc/codecs/rt5659.h |   4 +-
 2 files changed, 151 insertions(+), 160 deletions(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index c4a704e9a4db..ef3a44d6386b 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -1238,26 +1238,26 @@ static SOC_VALUE_ENUM_SINGLE_DECL(
 static int rt5659_hp_vol_put(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	int ret = snd_soc_put_volsw(kcontrol, ucontrol);
 
-	if (snd_soc_read(codec, RT5659_STO_NG2_CTRL_1) & RT5659_NG2_EN) {
-		snd_soc_update_bits(codec, RT5659_STO_NG2_CTRL_1,
+	if (snd_soc_component_read32(component, RT5659_STO_NG2_CTRL_1) & RT5659_NG2_EN) {
+		snd_soc_component_update_bits(component, RT5659_STO_NG2_CTRL_1,
 			RT5659_NG2_EN_MASK, RT5659_NG2_DIS);
-		snd_soc_update_bits(codec, RT5659_STO_NG2_CTRL_1,
+		snd_soc_component_update_bits(component, RT5659_STO_NG2_CTRL_1,
 			RT5659_NG2_EN_MASK, RT5659_NG2_EN);
 	}
 
 	return ret;
 }
 
-static void rt5659_enable_push_button_irq(struct snd_soc_codec *codec,
+static void rt5659_enable_push_button_irq(struct snd_soc_component *component,
 	bool enable)
 {
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 
 	if (enable) {
-		snd_soc_write(codec, RT5659_4BTN_IL_CMD_1, 0x000b);
+		snd_soc_component_write(component, RT5659_4BTN_IL_CMD_1, 0x000b);
 
 		/* MICBIAS1 and Mic Det Power for button detect*/
 		snd_soc_dapm_force_enable_pin(dapm, "MICBIAS1");
@@ -1265,19 +1265,19 @@ static void rt5659_enable_push_button_irq(struct snd_soc_codec *codec,
 			"Mic Det Power");
 		snd_soc_dapm_sync(dapm);
 
-		snd_soc_update_bits(codec, RT5659_PWR_ANLG_2,
+		snd_soc_component_update_bits(component, RT5659_PWR_ANLG_2,
 			RT5659_PWR_MB1, RT5659_PWR_MB1);
-		snd_soc_update_bits(codec, RT5659_PWR_VOL,
+		snd_soc_component_update_bits(component, RT5659_PWR_VOL,
 			RT5659_PWR_MIC_DET, RT5659_PWR_MIC_DET);
 
-		snd_soc_update_bits(codec, RT5659_IRQ_CTRL_2,
+		snd_soc_component_update_bits(component, RT5659_IRQ_CTRL_2,
 				RT5659_IL_IRQ_MASK, RT5659_IL_IRQ_EN);
-		snd_soc_update_bits(codec, RT5659_4BTN_IL_CMD_2,
+		snd_soc_component_update_bits(component, RT5659_4BTN_IL_CMD_2,
 				RT5659_4BTN_IL_MASK, RT5659_4BTN_IL_EN);
 	} else {
-		snd_soc_update_bits(codec, RT5659_4BTN_IL_CMD_2,
+		snd_soc_component_update_bits(component, RT5659_4BTN_IL_CMD_2,
 				RT5659_4BTN_IL_MASK, RT5659_4BTN_IL_DIS);
-		snd_soc_update_bits(codec, RT5659_IRQ_CTRL_2,
+		snd_soc_component_update_bits(component, RT5659_IRQ_CTRL_2,
 				RT5659_IL_IRQ_MASK, RT5659_IL_IRQ_DIS);
 		/* MICBIAS1 and Mic Det Power for button detect*/
 		snd_soc_dapm_disable_pin(dapm, "MICBIAS1");
@@ -1288,7 +1288,7 @@ static void rt5659_enable_push_button_irq(struct snd_soc_codec *codec,
 
 /**
  * rt5659_headset_detect - Detect headset.
- * @codec: SoC audio codec device.
+ * @component: SoC audio component device.
  * @jack_insert: Jack insert or not.
  *
  * Detect whether is headset or not when jack inserted.
@@ -1296,37 +1296,37 @@ static void rt5659_enable_push_button_irq(struct snd_soc_codec *codec,
  * Returns detect status.
  */
 
-static int rt5659_headset_detect(struct snd_soc_codec *codec, int jack_insert)
+static int rt5659_headset_detect(struct snd_soc_component *component, int jack_insert)
 {
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 	int val, i = 0, sleep_time[5] = {300, 150, 100, 50, 30};
 	int reg_63;
 
-	struct rt5659_priv *rt5659 = snd_soc_codec_get_drvdata(codec);
+	struct rt5659_priv *rt5659 = snd_soc_component_get_drvdata(component);
 
 	if (jack_insert) {
 		snd_soc_dapm_force_enable_pin(dapm,
 			"Mic Det Power");
 		snd_soc_dapm_sync(dapm);
-		reg_63 = snd_soc_read(codec, RT5659_PWR_ANLG_1);
+		reg_63 = snd_soc_component_read32(component, RT5659_PWR_ANLG_1);
 
-		snd_soc_update_bits(codec, RT5659_PWR_ANLG_1,
+		snd_soc_component_update_bits(component, RT5659_PWR_ANLG_1,
 			RT5659_PWR_VREF2 | RT5659_PWR_MB,
 			RT5659_PWR_VREF2 | RT5659_PWR_MB);
 		msleep(20);
-		snd_soc_update_bits(codec, RT5659_PWR_ANLG_1,
+		snd_soc_component_update_bits(component, RT5659_PWR_ANLG_1,
 			RT5659_PWR_FV2, RT5659_PWR_FV2);
 
-		snd_soc_write(codec, RT5659_EJD_CTRL_2, 0x4160);
-		snd_soc_update_bits(codec, RT5659_EJD_CTRL_1,
+		snd_soc_component_write(component, RT5659_EJD_CTRL_2, 0x4160);
+		snd_soc_component_update_bits(component, RT5659_EJD_CTRL_1,
 			0x20, 0x0);
 		msleep(20);
-		snd_soc_update_bits(codec, RT5659_EJD_CTRL_1,
+		snd_soc_component_update_bits(component, RT5659_EJD_CTRL_1,
 			0x20, 0x20);
 
 		while (i < 5) {
 			msleep(sleep_time[i]);
-			val = snd_soc_read(codec, RT5659_EJD_CTRL_2) & 0x0003;
+			val = snd_soc_component_read32(component, RT5659_EJD_CTRL_2) & 0x0003;
 			i++;
 			if (val == 0x1 || val == 0x2 || val == 0x3)
 				break;
@@ -1335,10 +1335,10 @@ static int rt5659_headset_detect(struct snd_soc_codec *codec, int jack_insert)
 		switch (val) {
 		case 1:
 			rt5659->jack_type = SND_JACK_HEADSET;
-			rt5659_enable_push_button_irq(codec, true);
+			rt5659_enable_push_button_irq(component, true);
 			break;
 		default:
-			snd_soc_write(codec, RT5659_PWR_ANLG_1, reg_63);
+			snd_soc_component_write(component, RT5659_PWR_ANLG_1, reg_63);
 			rt5659->jack_type = SND_JACK_HEADPHONE;
 			snd_soc_dapm_disable_pin(dapm, "Mic Det Power");
 			snd_soc_dapm_sync(dapm);
@@ -1348,21 +1348,21 @@ static int rt5659_headset_detect(struct snd_soc_codec *codec, int jack_insert)
 		snd_soc_dapm_disable_pin(dapm, "Mic Det Power");
 		snd_soc_dapm_sync(dapm);
 		if (rt5659->jack_type == SND_JACK_HEADSET)
-			rt5659_enable_push_button_irq(codec, false);
+			rt5659_enable_push_button_irq(component, false);
 		rt5659->jack_type = 0;
 	}
 
-	dev_dbg(codec->dev, "jack_type = %d\n", rt5659->jack_type);
+	dev_dbg(component->dev, "jack_type = %d\n", rt5659->jack_type);
 	return rt5659->jack_type;
 }
 
-static int rt5659_button_detect(struct snd_soc_codec *codec)
+static int rt5659_button_detect(struct snd_soc_component *component)
 {
 	int btn_type, val;
 
-	val = snd_soc_read(codec, RT5659_4BTN_IL_CMD_1);
+	val = snd_soc_component_read32(component, RT5659_4BTN_IL_CMD_1);
 	btn_type = val & 0xfff0;
-	snd_soc_write(codec, RT5659_4BTN_IL_CMD_1, val);
+	snd_soc_component_write(component, RT5659_4BTN_IL_CMD_1, val);
 
 	return btn_type;
 }
@@ -1377,10 +1377,10 @@ static irqreturn_t rt5659_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-int rt5659_set_jack_detect(struct snd_soc_codec *codec,
+int rt5659_set_jack_detect(struct snd_soc_component *component,
 	struct snd_soc_jack *hs_jack)
 {
-	struct rt5659_priv *rt5659 = snd_soc_codec_get_drvdata(codec);
+	struct rt5659_priv *rt5659 = snd_soc_component_get_drvdata(component);
 
 	rt5659->hs_jack = hs_jack;
 
@@ -1396,19 +1396,19 @@ static void rt5659_jack_detect_work(struct work_struct *work)
 		container_of(work, struct rt5659_priv, jack_detect_work.work);
 	int val, btn_type, report = 0;
 
-	if (!rt5659->codec)
+	if (!rt5659->component)
 		return;
 
-	val = snd_soc_read(rt5659->codec, RT5659_INT_ST_1) & 0x0080;
+	val = snd_soc_component_read32(rt5659->component, RT5659_INT_ST_1) & 0x0080;
 	if (!val) {
 		/* jack in */
 		if (rt5659->jack_type == 0) {
 			/* jack was out, report jack type */
-			report = rt5659_headset_detect(rt5659->codec, 1);
+			report = rt5659_headset_detect(rt5659->component, 1);
 		} else {
 			/* jack is already in, report button event */
 			report = SND_JACK_HEADSET;
-			btn_type = rt5659_button_detect(rt5659->codec);
+			btn_type = rt5659_button_detect(rt5659->component);
 			/**
 			 * rt5659 can report three kinds of button behavior,
 			 * one click, double click and hold. However,
@@ -1441,7 +1441,7 @@ static void rt5659_jack_detect_work(struct work_struct *work)
 				break;
 			default:
 				btn_type = 0;
-				dev_err(rt5659->codec->dev,
+				dev_err(rt5659->component->dev,
 					"Unexpected button code 0x%04x\n",
 					btn_type);
 				break;
@@ -1453,7 +1453,7 @@ static void rt5659_jack_detect_work(struct work_struct *work)
 		}
 	} else {
 		/* jack out */
-		report = rt5659_headset_detect(rt5659->codec, 0);
+		report = rt5659_headset_detect(rt5659->component, 0);
 	}
 
 	snd_soc_jack_report(rt5659->hs_jack, report, SND_JACK_HEADSET |
@@ -1605,8 +1605,8 @@ static const struct snd_kcontrol_new rt5659_snd_controls[] = {
 static int set_dmic_clk(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct rt5659_priv *rt5659 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct rt5659_priv *rt5659 = snd_soc_component_get_drvdata(component);
 	int pd, idx = -EINVAL;
 
 	pd = rl6231_get_pre_div(rt5659->regmap,
@@ -1614,9 +1614,9 @@ static int set_dmic_clk(struct snd_soc_dapm_widget *w,
 	idx = rl6231_calc_dmic_clk(rt5659->sysclk / pd);
 
 	if (idx < 0)
-		dev_err(codec->dev, "Failed to set DMIC clock\n");
+		dev_err(component->dev, "Failed to set DMIC clock\n");
 	else {
-		snd_soc_update_bits(codec, RT5659_DMIC_CTRL_1,
+		snd_soc_component_update_bits(component, RT5659_DMIC_CTRL_1,
 			RT5659_DMIC_CLK_MASK, idx << RT5659_DMIC_CLK_SFT);
 	}
 	return idx;
@@ -1625,17 +1625,17 @@ static int set_dmic_clk(struct snd_soc_dapm_widget *w,
 static int set_adc_clk(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-		snd_soc_update_bits(codec, RT5659_CHOP_ADC,
+		snd_soc_component_update_bits(component, RT5659_CHOP_ADC,
 			RT5659_CKXEN_ADCC_MASK | RT5659_CKGEN_ADCC_MASK,
 			RT5659_CKXEN_ADCC_MASK | RT5659_CKGEN_ADCC_MASK);
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
-		snd_soc_update_bits(codec, RT5659_CHOP_ADC,
+		snd_soc_component_update_bits(component, RT5659_CHOP_ADC,
 			RT5659_CKXEN_ADCC_MASK | RT5659_CKGEN_ADCC_MASK, 0);
 		break;
 
@@ -1650,15 +1650,15 @@ static int set_adc_clk(struct snd_soc_dapm_widget *w,
 static int rt5659_charge_pump_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		/* Depop */
-		snd_soc_write(codec, RT5659_DEPOP_1, 0x0009);
+		snd_soc_component_write(component, RT5659_DEPOP_1, 0x0009);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
-		snd_soc_write(codec, RT5659_HP_CHARGE_PUMP_1, 0x0c16);
+		snd_soc_component_write(component, RT5659_HP_CHARGE_PUMP_1, 0x0c16);
 		break;
 	default:
 		return 0;
@@ -1671,9 +1671,9 @@ static int is_sys_clk_from_pll(struct snd_soc_dapm_widget *w,
 			 struct snd_soc_dapm_widget *sink)
 {
 	unsigned int val;
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 
-	val = snd_soc_read(codec, RT5659_GLB_CLK);
+	val = snd_soc_component_read32(component, RT5659_GLB_CLK);
 	val &= RT5659_SCLK_SRC_MASK;
 	if (val == RT5659_SCLK_SRC_PLL1)
 		return 1;
@@ -1685,7 +1685,7 @@ static int is_using_asrc(struct snd_soc_dapm_widget *w,
 			 struct snd_soc_dapm_widget *sink)
 {
 	unsigned int reg, shift, val;
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 
 	switch (w->shift) {
 	case RT5659_ADC_MONO_R_ASRC_SFT:
@@ -1716,13 +1716,13 @@ static int is_using_asrc(struct snd_soc_dapm_widget *w,
 		return 0;
 	}
 
-	val = (snd_soc_read(codec, reg) >> shift) & 0xf;
+	val = (snd_soc_component_read32(component, reg) >> shift) & 0xf;
 	switch (val) {
 	case 1:
 	case 2:
 	case 3:
 		/* I2S_Pre_Div1 should be 1 in asrc mode */
-		snd_soc_update_bits(codec, RT5659_ADDA_CLK_1,
+		snd_soc_component_update_bits(component, RT5659_ADDA_CLK_1,
 			RT5659_I2S_PD1_MASK, RT5659_I2S_PD1_2);
 		return 1;
 	default:
@@ -2358,24 +2358,24 @@ static const struct snd_kcontrol_new pdm_r_switch =
 static int rt5659_spk_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		snd_soc_update_bits(codec, RT5659_CLASSD_CTRL_1,
+		snd_soc_component_update_bits(component, RT5659_CLASSD_CTRL_1,
 			RT5659_POW_CLSD_DB_MASK, RT5659_POW_CLSD_DB_EN);
-		snd_soc_update_bits(codec, RT5659_CLASSD_2,
+		snd_soc_component_update_bits(component, RT5659_CLASSD_2,
 			RT5659_M_RI_DIG, RT5659_M_RI_DIG);
-		snd_soc_write(codec, RT5659_CLASSD_1, 0x0803);
-		snd_soc_write(codec, RT5659_SPK_DC_CAILB_CTRL_3, 0x0000);
+		snd_soc_component_write(component, RT5659_CLASSD_1, 0x0803);
+		snd_soc_component_write(component, RT5659_SPK_DC_CAILB_CTRL_3, 0x0000);
 		break;
 
 	case SND_SOC_DAPM_POST_PMD:
-		snd_soc_write(codec, RT5659_CLASSD_1, 0x0011);
-		snd_soc_update_bits(codec, RT5659_CLASSD_2,
+		snd_soc_component_write(component, RT5659_CLASSD_1, 0x0011);
+		snd_soc_component_update_bits(component, RT5659_CLASSD_2,
 			RT5659_M_RI_DIG, 0x0);
-		snd_soc_write(codec, RT5659_SPK_DC_CAILB_CTRL_3, 0x0003);
-		snd_soc_update_bits(codec, RT5659_CLASSD_CTRL_1,
+		snd_soc_component_write(component, RT5659_SPK_DC_CAILB_CTRL_3, 0x0003);
+		snd_soc_component_update_bits(component, RT5659_CLASSD_CTRL_1,
 			RT5659_POW_CLSD_DB_MASK, RT5659_POW_CLSD_DB_DIS);
 		break;
 
@@ -2390,15 +2390,15 @@ static int rt5659_spk_event(struct snd_soc_dapm_widget *w,
 static int rt5659_mono_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		snd_soc_write(codec, RT5659_MONO_AMP_CALIB_CTRL_1, 0x1e00);
+		snd_soc_component_write(component, RT5659_MONO_AMP_CALIB_CTRL_1, 0x1e00);
 		break;
 
 	case SND_SOC_DAPM_POST_PMD:
-		snd_soc_write(codec, RT5659_MONO_AMP_CALIB_CTRL_1, 0x1e04);
+		snd_soc_component_write(component, RT5659_MONO_AMP_CALIB_CTRL_1, 0x1e04);
 		break;
 
 	default:
@@ -2412,16 +2412,16 @@ static int rt5659_mono_event(struct snd_soc_dapm_widget *w,
 static int rt5659_hp_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-		snd_soc_write(codec, RT5659_HP_CHARGE_PUMP_1, 0x0e1e);
-		snd_soc_update_bits(codec, RT5659_DEPOP_1, 0x0010, 0x0010);
+		snd_soc_component_write(component, RT5659_HP_CHARGE_PUMP_1, 0x0e1e);
+		snd_soc_component_update_bits(component, RT5659_DEPOP_1, 0x0010, 0x0010);
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
-		snd_soc_write(codec, RT5659_DEPOP_1, 0x0000);
+		snd_soc_component_write(component, RT5659_DEPOP_1, 0x0000);
 		break;
 
 	default:
@@ -3287,21 +3287,21 @@ static const struct snd_soc_dapm_route rt5659_dapm_routes[] = {
 static int rt5659_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct rt5659_priv *rt5659 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct rt5659_priv *rt5659 = snd_soc_component_get_drvdata(component);
 	unsigned int val_len = 0, val_clk, mask_clk;
 	int pre_div, frame_size;
 
 	rt5659->lrck[dai->id] = params_rate(params);
 	pre_div = rl6231_get_clk_info(rt5659->sysclk, rt5659->lrck[dai->id]);
 	if (pre_div < 0) {
-		dev_err(codec->dev, "Unsupported clock setting %d for DAI %d\n",
+		dev_err(component->dev, "Unsupported clock setting %d for DAI %d\n",
 			rt5659->lrck[dai->id], dai->id);
 		return -EINVAL;
 	}
 	frame_size = snd_soc_params_to_frame_size(params);
 	if (frame_size < 0) {
-		dev_err(codec->dev, "Unsupported frame size: %d\n", frame_size);
+		dev_err(component->dev, "Unsupported frame size: %d\n", frame_size);
 		return -EINVAL;
 	}
 
@@ -3328,39 +3328,39 @@ static int rt5659_hw_params(struct snd_pcm_substream *substream,
 	case RT5659_AIF1:
 		mask_clk = RT5659_I2S_PD1_MASK;
 		val_clk = pre_div << RT5659_I2S_PD1_SFT;
-		snd_soc_update_bits(codec, RT5659_I2S1_SDP,
+		snd_soc_component_update_bits(component, RT5659_I2S1_SDP,
 			RT5659_I2S_DL_MASK, val_len);
 		break;
 	case RT5659_AIF2:
 		mask_clk = RT5659_I2S_PD2_MASK;
 		val_clk = pre_div << RT5659_I2S_PD2_SFT;
-		snd_soc_update_bits(codec, RT5659_I2S2_SDP,
+		snd_soc_component_update_bits(component, RT5659_I2S2_SDP,
 			RT5659_I2S_DL_MASK, val_len);
 		break;
 	case RT5659_AIF3:
 		mask_clk = RT5659_I2S_PD3_MASK;
 		val_clk = pre_div << RT5659_I2S_PD3_SFT;
-		snd_soc_update_bits(codec, RT5659_I2S3_SDP,
+		snd_soc_component_update_bits(component, RT5659_I2S3_SDP,
 			RT5659_I2S_DL_MASK, val_len);
 		break;
 	default:
-		dev_err(codec->dev, "Invalid dai->id: %d\n", dai->id);
+		dev_err(component->dev, "Invalid dai->id: %d\n", dai->id);
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, RT5659_ADDA_CLK_1, mask_clk, val_clk);
+	snd_soc_component_update_bits(component, RT5659_ADDA_CLK_1, mask_clk, val_clk);
 
 	switch (rt5659->lrck[dai->id]) {
 	case 192000:
-		snd_soc_update_bits(codec, RT5659_ADDA_CLK_1,
+		snd_soc_component_update_bits(component, RT5659_ADDA_CLK_1,
 			RT5659_DAC_OSR_MASK, RT5659_DAC_OSR_32);
 		break;
 	case 96000:
-		snd_soc_update_bits(codec, RT5659_ADDA_CLK_1,
+		snd_soc_component_update_bits(component, RT5659_ADDA_CLK_1,
 			RT5659_DAC_OSR_MASK, RT5659_DAC_OSR_64);
 		break;
 	default:
-		snd_soc_update_bits(codec, RT5659_ADDA_CLK_1,
+		snd_soc_component_update_bits(component, RT5659_ADDA_CLK_1,
 			RT5659_DAC_OSR_MASK, RT5659_DAC_OSR_128);
 		break;
 	}
@@ -3370,8 +3370,8 @@ static int rt5659_hw_params(struct snd_pcm_substream *substream,
 
 static int rt5659_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct rt5659_priv *rt5659 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct rt5659_priv *rt5659 = snd_soc_component_get_drvdata(component);
 	unsigned int reg_val = 0;
 
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -3414,31 +3414,31 @@ static int rt5659_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 
 	switch (dai->id) {
 	case RT5659_AIF1:
-		snd_soc_update_bits(codec, RT5659_I2S1_SDP,
+		snd_soc_component_update_bits(component, RT5659_I2S1_SDP,
 			RT5659_I2S_MS_MASK | RT5659_I2S_BP_MASK |
 			RT5659_I2S_DF_MASK, reg_val);
 		break;
 	case RT5659_AIF2:
-		snd_soc_update_bits(codec, RT5659_I2S2_SDP,
+		snd_soc_component_update_bits(component, RT5659_I2S2_SDP,
 			RT5659_I2S_MS_MASK | RT5659_I2S_BP_MASK |
 			RT5659_I2S_DF_MASK, reg_val);
 		break;
 	case RT5659_AIF3:
-		snd_soc_update_bits(codec, RT5659_I2S3_SDP,
+		snd_soc_component_update_bits(component, RT5659_I2S3_SDP,
 			RT5659_I2S_MS_MASK | RT5659_I2S_BP_MASK |
 			RT5659_I2S_DF_MASK, reg_val);
 		break;
 	default:
-		dev_err(codec->dev, "Invalid dai->id: %d\n", dai->id);
+		dev_err(component->dev, "Invalid dai->id: %d\n", dai->id);
 		return -EINVAL;
 	}
 	return 0;
 }
 
-static int rt5659_set_codec_sysclk(struct snd_soc_codec *codec, int clk_id,
+static int rt5659_set_component_sysclk(struct snd_soc_component *component, int clk_id,
 				   int source, unsigned int freq, int dir)
 {
-	struct rt5659_priv *rt5659 = snd_soc_codec_get_drvdata(codec);
+	struct rt5659_priv *rt5659 = snd_soc_component_get_drvdata(component);
 	unsigned int reg_val = 0;
 
 	if (freq == rt5659->sysclk && clk_id == rt5659->sysclk_src)
@@ -3455,25 +3455,25 @@ static int rt5659_set_codec_sysclk(struct snd_soc_codec *codec, int clk_id,
 		reg_val |= RT5659_SCLK_SRC_RCCLK;
 		break;
 	default:
-		dev_err(codec->dev, "Invalid clock id (%d)\n", clk_id);
+		dev_err(component->dev, "Invalid clock id (%d)\n", clk_id);
 		return -EINVAL;
 	}
-	snd_soc_update_bits(codec, RT5659_GLB_CLK,
+	snd_soc_component_update_bits(component, RT5659_GLB_CLK,
 		RT5659_SCLK_SRC_MASK, reg_val);
 	rt5659->sysclk = freq;
 	rt5659->sysclk_src = clk_id;
 
-	dev_dbg(codec->dev, "Sysclk is %dHz and clock id is %d\n",
+	dev_dbg(component->dev, "Sysclk is %dHz and clock id is %d\n",
 		freq, clk_id);
 
 	return 0;
 }
 
-static int rt5659_set_codec_pll(struct snd_soc_codec *codec, int pll_id,
+static int rt5659_set_component_pll(struct snd_soc_component *component, int pll_id,
 				int source, unsigned int freq_in,
 				unsigned int freq_out)
 {
-	struct rt5659_priv *rt5659 = snd_soc_codec_get_drvdata(codec);
+	struct rt5659_priv *rt5659 = snd_soc_component_get_drvdata(component);
 	struct rl6231_pll_code pll_code;
 	int ret;
 
@@ -3482,50 +3482,50 @@ static int rt5659_set_codec_pll(struct snd_soc_codec *codec, int pll_id,
 		return 0;
 
 	if (!freq_in || !freq_out) {
-		dev_dbg(codec->dev, "PLL disabled\n");
+		dev_dbg(component->dev, "PLL disabled\n");
 
 		rt5659->pll_in = 0;
 		rt5659->pll_out = 0;
-		snd_soc_update_bits(codec, RT5659_GLB_CLK,
+		snd_soc_component_update_bits(component, RT5659_GLB_CLK,
 			RT5659_SCLK_SRC_MASK, RT5659_SCLK_SRC_MCLK);
 		return 0;
 	}
 
 	switch (source) {
 	case RT5659_PLL1_S_MCLK:
-		snd_soc_update_bits(codec, RT5659_GLB_CLK,
+		snd_soc_component_update_bits(component, RT5659_GLB_CLK,
 			RT5659_PLL1_SRC_MASK, RT5659_PLL1_SRC_MCLK);
 		break;
 	case RT5659_PLL1_S_BCLK1:
-		snd_soc_update_bits(codec, RT5659_GLB_CLK,
+		snd_soc_component_update_bits(component, RT5659_GLB_CLK,
 				RT5659_PLL1_SRC_MASK, RT5659_PLL1_SRC_BCLK1);
 		break;
 	case RT5659_PLL1_S_BCLK2:
-		snd_soc_update_bits(codec, RT5659_GLB_CLK,
+		snd_soc_component_update_bits(component, RT5659_GLB_CLK,
 				RT5659_PLL1_SRC_MASK, RT5659_PLL1_SRC_BCLK2);
 		break;
 	case RT5659_PLL1_S_BCLK3:
-		snd_soc_update_bits(codec, RT5659_GLB_CLK,
+		snd_soc_component_update_bits(component, RT5659_GLB_CLK,
 				RT5659_PLL1_SRC_MASK, RT5659_PLL1_SRC_BCLK3);
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
 
-	snd_soc_write(codec, RT5659_PLL_CTRL_1,
+	snd_soc_component_write(component, RT5659_PLL_CTRL_1,
 		pll_code.n_code << RT5659_PLL_N_SFT | pll_code.k_code);
-	snd_soc_write(codec, RT5659_PLL_CTRL_2,
+	snd_soc_component_write(component, RT5659_PLL_CTRL_2,
 		(pll_code.m_bp ? 0 : pll_code.m_code) << RT5659_PLL_M_SFT |
 		pll_code.m_bp << RT5659_PLL_M_BP_SFT);
 
@@ -3539,7 +3539,7 @@ static int rt5659_set_codec_pll(struct snd_soc_codec *codec, int pll_id,
 static int rt5659_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 			unsigned int rx_mask, int slots, int slot_width)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	unsigned int val = 0;
 
 	if (rx_mask || tx_mask)
@@ -3583,29 +3583,29 @@ static int rt5659_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, RT5659_TDM_CTRL_1, 0x8ff0, val);
+	snd_soc_component_update_bits(component, RT5659_TDM_CTRL_1, 0x8ff0, val);
 
 	return 0;
 }
 
 static int rt5659_set_bclk_ratio(struct snd_soc_dai *dai, unsigned int ratio)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct rt5659_priv *rt5659 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct rt5659_priv *rt5659 = snd_soc_component_get_drvdata(component);
 
-	dev_dbg(codec->dev, "%s ratio=%d\n", __func__, ratio);
+	dev_dbg(component->dev, "%s ratio=%d\n", __func__, ratio);
 
 	rt5659->bclk[dai->id] = ratio;
 
 	if (ratio == 64) {
 		switch (dai->id) {
 		case RT5659_AIF2:
-			snd_soc_update_bits(codec, RT5659_ADDA_CLK_1,
+			snd_soc_component_update_bits(component, RT5659_ADDA_CLK_1,
 				RT5659_I2S_BCLK_MS2_MASK,
 				RT5659_I2S_BCLK_MS2_64);
 			break;
 		case RT5659_AIF3:
-			snd_soc_update_bits(codec, RT5659_ADDA_CLK_1,
+			snd_soc_component_update_bits(component, RT5659_ADDA_CLK_1,
 				RT5659_I2S_BCLK_MS3_MASK,
 				RT5659_I2S_BCLK_MS3_64);
 			break;
@@ -3615,11 +3615,11 @@ static int rt5659_set_bclk_ratio(struct snd_soc_dai *dai, unsigned int ratio)
 	return 0;
 }
 
-static int rt5659_set_bias_level(struct snd_soc_codec *codec,
+static int rt5659_set_bias_level(struct snd_soc_component *component,
 			enum snd_soc_bias_level level)
 {
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
-	struct rt5659_priv *rt5659 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	struct rt5659_priv *rt5659 = snd_soc_component_get_drvdata(component);
 	int ret;
 
 	switch (level) {
@@ -3641,7 +3641,7 @@ static int rt5659_set_bias_level(struct snd_soc_codec *codec,
 		if (dapm->bias_level == SND_SOC_BIAS_OFF) {
 			ret = clk_prepare_enable(rt5659->mclk);
 			if (ret) {
-				dev_err(codec->dev,
+				dev_err(component->dev,
 					"failed to enable MCLK: %d\n", ret);
 				return ret;
 			}
@@ -3667,37 +3667,35 @@ static int rt5659_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static int rt5659_probe(struct snd_soc_codec *codec)
+static int rt5659_probe(struct snd_soc_component *component)
 {
-	struct rt5659_priv *rt5659 = snd_soc_codec_get_drvdata(codec);
+	struct rt5659_priv *rt5659 = snd_soc_component_get_drvdata(component);
 
-	rt5659->codec = codec;
+	rt5659->component = component;
 
 	return 0;
 }
 
-static int rt5659_remove(struct snd_soc_codec *codec)
+static void rt5659_remove(struct snd_soc_component *component)
 {
-	struct rt5659_priv *rt5659 = snd_soc_codec_get_drvdata(codec);
+	struct rt5659_priv *rt5659 = snd_soc_component_get_drvdata(component);
 
 	regmap_write(rt5659->regmap, RT5659_RESET, 0);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
-static int rt5659_suspend(struct snd_soc_codec *codec)
+static int rt5659_suspend(struct snd_soc_component *component)
 {
-	struct rt5659_priv *rt5659 = snd_soc_codec_get_drvdata(codec);
+	struct rt5659_priv *rt5659 = snd_soc_component_get_drvdata(component);
 
 	regcache_cache_only(rt5659->regmap, true);
 	regcache_mark_dirty(rt5659->regmap);
 	return 0;
 }
 
-static int rt5659_resume(struct snd_soc_codec *codec)
+static int rt5659_resume(struct snd_soc_component *component)
 {
-	struct rt5659_priv *rt5659 = snd_soc_codec_get_drvdata(codec);
+	struct rt5659_priv *rt5659 = snd_soc_component_get_drvdata(component);
 
 	regcache_cache_only(rt5659->regmap, false);
 	regcache_sync(rt5659->regmap);
@@ -3780,23 +3778,23 @@ static struct snd_soc_dai_driver rt5659_dai[] = {
 	},
 };
 
-static const struct snd_soc_codec_driver soc_codec_dev_rt5659 = {
-	.probe = rt5659_probe,
-	.remove = rt5659_remove,
-	.suspend = rt5659_suspend,
-	.resume = rt5659_resume,
-	.set_bias_level = rt5659_set_bias_level,
-	.idle_bias_off = true,
-	.component_driver = {
-		.controls		= rt5659_snd_controls,
-		.num_controls		= ARRAY_SIZE(rt5659_snd_controls),
-		.dapm_widgets		= rt5659_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(rt5659_dapm_widgets),
-		.dapm_routes		= rt5659_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(rt5659_dapm_routes),
-	},
-	.set_sysclk = rt5659_set_codec_sysclk,
-	.set_pll = rt5659_set_codec_pll,
+static const struct snd_soc_component_driver soc_component_dev_rt5659 = {
+	.probe			= rt5659_probe,
+	.remove			= rt5659_remove,
+	.suspend		= rt5659_suspend,
+	.resume			= rt5659_resume,
+	.set_bias_level		= rt5659_set_bias_level,
+	.controls		= rt5659_snd_controls,
+	.num_controls		= ARRAY_SIZE(rt5659_snd_controls),
+	.dapm_widgets		= rt5659_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(rt5659_dapm_widgets),
+	.dapm_routes		= rt5659_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(rt5659_dapm_routes),
+	.set_sysclk		= rt5659_set_component_sysclk,
+	.set_pll		= rt5659_set_component_pll,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 
@@ -3899,7 +3897,7 @@ static void rt5659_calibrate(struct rt5659_priv *rt5659)
 			break;
 
 		if (count > 30) {
-			dev_err(rt5659->codec->dev,
+			dev_err(rt5659->component->dev,
 				"HP Calibration 1 Failure\n");
 			return;
 		}
@@ -3924,7 +3922,7 @@ static void rt5659_calibrate(struct rt5659_priv *rt5659)
 			break;
 
 		if (count > 85) {
-			dev_err(rt5659->codec->dev,
+			dev_err(rt5659->component->dev,
 				"HP Calibration 2 Failure\n");
 			return;
 		}
@@ -3972,7 +3970,7 @@ static void rt5659_calibrate(struct rt5659_priv *rt5659)
 			break;
 
 		if (count > 10) {
-			dev_err(rt5659->codec->dev,
+			dev_err(rt5659->component->dev,
 				"SPK Calibration Failure\n");
 			return;
 		}
@@ -4005,7 +4003,7 @@ static void rt5659_calibrate(struct rt5659_priv *rt5659)
 			break;
 
 		if (count > 35) {
-			dev_err(rt5659->codec->dev,
+			dev_err(rt5659->component->dev,
 				"Mono Calibration Failure\n");
 			return;
 		}
@@ -4301,17 +4299,11 @@ static int rt5659_i2c_probe(struct i2c_client *i2c,
 				   RT5659_GP1_PIN_MASK, RT5659_GP1_PIN_IRQ);
 	}
 
-	return snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5659,
+	return devm_snd_soc_register_component(&i2c->dev,
+			&soc_component_dev_rt5659,
 			rt5659_dai, ARRAY_SIZE(rt5659_dai));
 }
 
-static int rt5659_i2c_remove(struct i2c_client *i2c)
-{
-	snd_soc_unregister_codec(&i2c->dev);
-
-	return 0;
-}
-
 static void rt5659_i2c_shutdown(struct i2c_client *client)
 {
 	struct rt5659_priv *rt5659 = i2c_get_clientdata(client);
@@ -4344,7 +4336,6 @@ static struct i2c_driver rt5659_i2c_driver = {
 		.acpi_match_table = ACPI_PTR(rt5659_acpi_match),
 	},
 	.probe = rt5659_i2c_probe,
-	.remove = rt5659_i2c_remove,
 	.shutdown = rt5659_i2c_shutdown,
 	.id_table = rt5659_i2c_id,
 };
diff --git a/sound/soc/codecs/rt5659.h b/sound/soc/codecs/rt5659.h
index bea0433c164c..73969ef5029f 100644
--- a/sound/soc/codecs/rt5659.h
+++ b/sound/soc/codecs/rt5659.h
@@ -1789,7 +1789,7 @@ struct rt5659_pll_code {
 };
 
 struct rt5659_priv {
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 	struct rt5659_platform_data pdata;
 	struct regmap *regmap;
 	struct gpio_desc *gpiod_ldo1_en;
@@ -1814,7 +1814,7 @@ struct rt5659_priv {
 	bool hda_mic_plugged;
 };
 
-int rt5659_set_jack_detect(struct snd_soc_codec *codec,
+int rt5659_set_jack_detect(struct snd_soc_component *component,
 	struct snd_soc_jack *hs_jack);
 
 #endif /* __RT5659_H__ */
-- 
2.16.1
