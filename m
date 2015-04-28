From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH v3] ASoC: rt5645: Adds push button support for
	rt5650
Date: Tue, 28 Apr 2015 09:59:43 +0800
Message-ID: <1430186383-2168-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 69947264F50
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2015 03:59:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, zhengxing@rock-chips.com, yang.a.fang@intel.com, koro.chen@mediatek.com, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, jason.ym.lin@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

rt5650 support headset button detection. Currently, the button detection
is only implemented for rt5650 codec. The button detection configuration
register's default value is different from rt5645.
And we didn't touch the register in the driver, so we will get the wrong
value when we dump the registers. We will fix it in another patch.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
* redo the using of rt5645_set_jack_detect base on the latest code base.
---
 sound/soc/codecs/rt5645.c               | 266 +++++++++++++++++++++++++++-----
 sound/soc/codecs/rt5645.h               |   8 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c |   2 +-
 3 files changed, 237 insertions(+), 39 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 2cab2eb..a81a24f 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2371,6 +2371,8 @@ static int rt5645_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 static int rt5645_set_bias_level(struct snd_soc_codec *codec,
 			enum snd_soc_bias_level level)
 {
+	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
+
 	switch (level) {
 	case SND_SOC_BIAS_PREPARE:
 		if (SND_SOC_BIAS_STANDBY == codec->dapm.bias_level) {
@@ -2401,8 +2403,9 @@ static int rt5645_set_bias_level(struct snd_soc_codec *codec,
 
 	case SND_SOC_BIAS_OFF:
 		snd_soc_write(codec, RT5645_DEPOP_M2, 0x1100);
-		snd_soc_update_bits(codec, RT5645_GEN_CTRL1,
-				RT5645_DIG_GATE_CTRL, 0);
+		if (!rt5645->en_button_func)
+			snd_soc_update_bits(codec, RT5645_GEN_CTRL1,
+					RT5645_DIG_GATE_CTRL, 0);
 		snd_soc_update_bits(codec, RT5645_PWR_ANLG1,
 				RT5645_PWR_VREF1 | RT5645_PWR_MB |
 				RT5645_PWR_BG | RT5645_PWR_VREF2 |
@@ -2417,28 +2420,71 @@ static int rt5645_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static int rt5645_jack_detect(struct snd_soc_codec *codec)
+static void rt5645_enable_push_button_irq(struct snd_soc_codec *codec,
+	bool enable)
 {
 	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
-	int gpio_state, jack_type = 0;
-	unsigned int val;
 
-	if (!gpio_is_valid(rt5645->pdata.hp_det_gpio)) {
-		dev_err(codec->dev, "invalid gpio\n");
-		return -EINVAL;
+	if (enable) {
+		snd_soc_dapm_force_enable_pin_unlocked(&codec->dapm,
+							"ADC L power");
+		snd_soc_dapm_force_enable_pin_unlocked(&codec->dapm,
+							"ADC R power");
+		snd_soc_dapm_force_enable_pin_unlocked(&codec->dapm,
+							"LDO2");
+		snd_soc_dapm_force_enable_pin_unlocked(&codec->dapm,
+							"Mic Det Power");
+		snd_soc_dapm_sync_unlocked(&codec->dapm);
+		snd_soc_update_bits(codec,
+					RT5645_INT_IRQ_ST, 0x8, 0x8);
+		snd_soc_update_bits(codec,
+					RT5650_4BTN_IL_CMD2, 0x8000, 0x8000);
+		snd_soc_read(codec, RT5650_4BTN_IL_CMD1);
+		pr_debug("%s read %x = %x\n", __func__, RT5650_4BTN_IL_CMD1,
+			snd_soc_read(codec, RT5650_4BTN_IL_CMD1));
+	} else {
+		snd_soc_update_bits(codec, RT5650_4BTN_IL_CMD2, 0x8000, 0x0);
+		snd_soc_update_bits(codec, RT5645_INT_IRQ_ST, 0x8, 0x0);
+		snd_soc_dapm_disable_pin_unlocked(&codec->dapm,
+							"ADC L power");
+		snd_soc_dapm_disable_pin_unlocked(&codec->dapm,
+							"ADC R power");
+		if (rt5645->pdata.jd_mode == 0)
+			snd_soc_dapm_disable_pin_unlocked(&codec->dapm,
+								"LDO2");
+		snd_soc_dapm_disable_pin_unlocked(&codec->dapm,
+							"Mic Det Power");
+		snd_soc_dapm_sync_unlocked(&codec->dapm);
 	}
-	gpio_state = gpio_get_value(rt5645->pdata.hp_det_gpio);
+}
 
-	dev_dbg(codec->dev, "gpio = %d(%d)\n", rt5645->pdata.hp_det_gpio,
-		gpio_state);
+static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
+{
+	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
+	unsigned int val;
 
-	if ((rt5645->pdata.gpio_hp_det_active_high && gpio_state) ||
-		(!rt5645->pdata.gpio_hp_det_active_high && !gpio_state)) {
-		snd_soc_dapm_force_enable_pin(&codec->dapm, "micbias1");
-		snd_soc_dapm_force_enable_pin(&codec->dapm, "micbias2");
-		snd_soc_dapm_force_enable_pin(&codec->dapm, "LDO2");
-		snd_soc_dapm_force_enable_pin(&codec->dapm, "Mic Det Power");
-		snd_soc_dapm_sync(&codec->dapm);
+	if (jack_insert) {
+		if (codec->component.card->instantiated) {
+			snd_soc_dapm_force_enable_pin(&codec->dapm,
+				"micbias1");
+			snd_soc_dapm_force_enable_pin(&codec->dapm,
+				"micbias2");
+			snd_soc_dapm_force_enable_pin(&codec->dapm,
+				"LDO2");
+			snd_soc_dapm_force_enable_pin(&codec->dapm,
+				"Mic Det Power");
+			snd_soc_dapm_sync(&codec->dapm);
+		} else {
+			/* Power up necessary bits for JD if dapm is
+			   not ready yet */
+			snd_soc_update_bits(codec, RT5645_PWR_ANLG2,
+				RT5645_PWR_MB1 | RT5645_PWR_MB2,
+				RT5645_PWR_MB1 | RT5645_PWR_MB2);
+			snd_soc_update_bits(codec, RT5645_PWR_MIXER,
+				RT5645_PWR_LDO2, RT5645_PWR_LDO2);
+			snd_soc_update_bits(codec, RT5645_PWR_VOL,
+				RT5645_PWR_MIC_DET, RT5645_PWR_MIC_DET);
+		}
 
 		snd_soc_write(codec, RT5645_IN1_CTRL1, 0x0006);
 		snd_soc_write(codec, RT5645_JD_CTRL3, 0x00b0);
@@ -2452,32 +2498,62 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec)
 		val = snd_soc_read(codec, RT5645_IN1_CTRL3) & 0x7;
 		dev_dbg(codec->dev, "val = %d\n", val);
 
-		if (val == 1 || val == 2)
-			jack_type = SND_JACK_HEADSET;
-		else
-			jack_type = SND_JACK_HEADPHONE;
+		if (codec->component.card->instantiated) {
+			snd_soc_dapm_disable_pin(&codec->dapm, "micbias1");
+			snd_soc_dapm_disable_pin(&codec->dapm, "micbias2");
+			if (rt5645->pdata.jd_mode == 0)
+				snd_soc_dapm_disable_pin(&codec->dapm, "LDO2");
+			snd_soc_dapm_disable_pin(&codec->dapm,
+				"Mic Det Power");
+			snd_soc_dapm_sync(&codec->dapm);
+		} else {
+			snd_soc_update_bits(codec, RT5645_PWR_ANLG2,
+				RT5645_PWR_MB1 | RT5645_PWR_MB2, 0);
+			if (rt5645->pdata.jd_mode == 0)
+				snd_soc_update_bits(codec, RT5645_PWR_MIXER,
+					RT5645_PWR_LDO2, 0);
+			snd_soc_update_bits(codec, RT5645_PWR_VOL,
+				RT5645_PWR_MIC_DET, 0);
+		}
 
-		snd_soc_dapm_disable_pin(&codec->dapm, "micbias1");
-		snd_soc_dapm_disable_pin(&codec->dapm, "micbias2");
-		if (rt5645->pdata.jd_mode == 0)
-			snd_soc_dapm_disable_pin(&codec->dapm, "LDO2");
-		snd_soc_dapm_disable_pin(&codec->dapm, "Mic Det Power");
-		snd_soc_dapm_sync(&codec->dapm);
+		if (val == 1 || val == 2) {
+			rt5645->jack_type = SND_JACK_HEADSET;
+			if (rt5645->en_button_func) {
+				msleep(100);
+				rt5645_enable_push_button_irq(codec, true);
+			}
+		} else {
+			rt5645->jack_type = SND_JACK_HEADPHONE;
+		}
+
+	} else { /* jack out */
+		rt5645->jack_type = 0;
+		if (rt5645->en_button_func)
+			rt5645_enable_push_button_irq(codec, false);
 	}
 
-	snd_soc_jack_report(rt5645->hp_jack, jack_type, SND_JACK_HEADPHONE);
-	snd_soc_jack_report(rt5645->mic_jack, jack_type, SND_JACK_MICROPHONE);
-	return 0;
+	return rt5645->jack_type;
 }
 
 int rt5645_set_jack_detect(struct snd_soc_codec *codec,
-	struct snd_soc_jack *hp_jack, struct snd_soc_jack *mic_jack)
+	struct snd_soc_jack *hp_jack, struct snd_soc_jack *mic_jack,
+	struct snd_soc_jack *btn_jack)
 {
 	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
 
 	rt5645->hp_jack = hp_jack;
 	rt5645->mic_jack = mic_jack;
-	rt5645_jack_detect(codec);
+	rt5645->btn_jack = btn_jack;
+	if (rt5645->btn_jack && rt5645->codec_type == CODEC_TYPE_RT5650) {
+		rt5645->en_button_func = true;
+		regmap_update_bits(rt5645->regmap, RT5645_GPIO_CTRL1,
+				RT5645_GP1_PIN_IRQ, RT5645_GP1_PIN_IRQ);
+		regmap_update_bits(rt5645->regmap, RT5645_DEPOP_M1,
+				RT5645_HP_CB_MASK, RT5645_HP_CB_PU);
+		regmap_update_bits(rt5645->regmap, RT5645_GEN_CTRL1,
+				RT5645_DIG_GATE_CTRL, RT5645_DIG_GATE_CTRL);
+	}
+	rt5645_irq_detection(rt5645);
 
 	return 0;
 }
@@ -2488,7 +2564,7 @@ static void rt5645_jack_detect_work(struct work_struct *work)
 	struct rt5645_priv *rt5645 =
 		container_of(work, struct rt5645_priv, jack_detect_work.work);
 
-	rt5645_jack_detect(rt5645->codec);
+	rt5645_irq_detection(rt5645);
 }
 
 static irqreturn_t rt5645_irq(int irq, void *data)
@@ -2501,6 +2577,125 @@ static irqreturn_t rt5645_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static int rt5645_button_detect(struct snd_soc_codec *codec)
+{
+	int btn_type, val;
+
+	val = snd_soc_read(codec, RT5650_4BTN_IL_CMD1);
+	pr_debug("val=0x%x\n", val);
+	btn_type = val & 0xfff0;
+	snd_soc_write(codec, RT5650_4BTN_IL_CMD1, val);
+
+	return btn_type;
+}
+
+static int rt5645_irq_detection(struct rt5645_priv *rt5645)
+{
+	int val, btn_type, gpio_state = 0, report = 0;
+
+	switch (rt5645->pdata.jd_mode) {
+	case 0: /* Not using rt5645 JD */
+		if (gpio_is_valid(rt5645->pdata.hp_det_gpio)) {
+			gpio_state = gpio_get_value(rt5645->pdata.hp_det_gpio);
+			dev_dbg(rt5645->codec->dev, "gpio = %d(%d)\n",
+				rt5645->pdata.hp_det_gpio, gpio_state);
+		}
+		if ((rt5645->pdata.gpio_hp_det_active_high && gpio_state) ||
+			(!rt5645->pdata.gpio_hp_det_active_high &&
+			 !gpio_state)) {
+			report = rt5645_jack_detect(rt5645->codec, 1);
+		} else {
+			report = rt5645_jack_detect(rt5645->codec, 0);
+		}
+		snd_soc_jack_report(rt5645->hp_jack,
+				    report, SND_JACK_HEADPHONE);
+		snd_soc_jack_report(rt5645->mic_jack,
+				    report, SND_JACK_MICROPHONE);
+		return report;
+	case 1: /* 2 port */
+		val = snd_soc_read(rt5645->codec, RT5645_A_JD_CTRL1) & 0x0070;
+		break;
+	default: /* 1 port */
+		val = snd_soc_read(rt5645->codec, RT5645_A_JD_CTRL1) & 0x0020;
+		break;
+
+	}
+
+	switch (val) {
+	/* jack in */
+	case 0x30: /* 2 port */
+	case 0x0: /* 1 port or 2 port */
+		if (rt5645->jack_type == 0) {
+			report = rt5645_jack_detect(rt5645->codec, 1);
+			/* for push button and jack out */
+			break;
+		}
+		btn_type = 0;
+		if (snd_soc_read(rt5645->codec, RT5645_INT_IRQ_ST) & 0x4) {
+			/* button pressed */
+			report = SND_JACK_HEADSET;
+			btn_type = rt5645_button_detect(rt5645->codec);
+			/* rt5650 can report three kinds of button behavior,
+			   one click, double click and hold. However,
+			   currently we will report button pressed/released
+			   event. So all the three button behaviors are
+			   treated as button pressed. */
+			switch (btn_type) {
+			case 0x8000:
+			case 0x4000:
+			case 0x2000:
+				report |= SND_JACK_BTN_0;
+				break;
+			case 0x1000:
+			case 0x0800:
+			case 0x0400:
+				report |= SND_JACK_BTN_1;
+				break;
+			case 0x0200:
+			case 0x0100:
+			case 0x0080:
+				report |= SND_JACK_BTN_2;
+				break;
+			case 0x0040:
+			case 0x0020:
+			case 0x0010:
+				report |= SND_JACK_BTN_3;
+				break;
+			case 0x0000: /* unpressed */
+				break;
+			default:
+				dev_err(rt5645->codec->dev,
+					"Unexpected button code 0x%04x\n",
+					btn_type);
+				break;
+			}
+		}
+		if (btn_type == 0)/* button release */
+			report =  rt5645->jack_type;
+
+		break;
+	/* jack out */
+	case 0x70: /* 2 port */
+	case 0x10: /* 2 port */
+	case 0x20: /* 1 port */
+		report = 0;
+		snd_soc_update_bits(rt5645->codec,
+				    RT5645_INT_IRQ_ST, 0x1, 0x0);
+		rt5645_jack_detect(rt5645->codec, 0);
+		break;
+	default:
+		break;
+	}
+
+	snd_soc_jack_report(rt5645->hp_jack, report, SND_JACK_HEADPHONE);
+	snd_soc_jack_report(rt5645->mic_jack, report, SND_JACK_MICROPHONE);
+	if (rt5645->en_button_func)
+		snd_soc_jack_report(rt5645->btn_jack,
+			report, SND_JACK_MICROPHONE);
+
+	return report;
+}
+
 static int rt5645_probe(struct snd_soc_codec *codec)
 {
 	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
@@ -2840,8 +3035,7 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 
 	if (rt5645->pdata.en_jd_func) {
 		regmap_update_bits(rt5645->regmap, RT5645_GEN_CTRL3,
-			RT5645_IRQ_CLK_GATE_CTRL | RT5645_MICINDET_MANU,
-			RT5645_IRQ_CLK_GATE_CTRL | RT5645_MICINDET_MANU);
+			RT5645_IRQ_CLK_GATE_CTRL, RT5645_IRQ_CLK_GATE_CTRL);
 		regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL1,
 			RT5645_CBJ_BST1_EN, RT5645_CBJ_BST1_EN);
 		regmap_update_bits(rt5645->regmap, RT5645_JD_CTRL3,
diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index db78e94..4473636 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -2184,6 +2184,7 @@ struct rt5645_priv {
 	struct i2c_client *i2c;
 	struct snd_soc_jack *hp_jack;
 	struct snd_soc_jack *mic_jack;
+	struct snd_soc_jack *btn_jack;
 	struct delayed_work jack_detect_work;
 
 	int codec_type;
@@ -2196,9 +2197,12 @@ struct rt5645_priv {
 	int pll_src;
 	int pll_in;
 	int pll_out;
+
+	int jack_type;
+	bool en_button_func;
 };
 
 int rt5645_set_jack_detect(struct snd_soc_codec *codec,
-	struct snd_soc_jack *hp_jack, struct snd_soc_jack *mic_jack);
-
+	struct snd_soc_jack *hp_jack, struct snd_soc_jack *mic_jack,
+	struct snd_soc_jack *btn_jack);
 #endif /* __RT5645_H__ */
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index 20a28b2..26e01f3 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -185,7 +185,7 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 		return ret;
 	}
 
-	rt5645_set_jack_detect(codec, &ctx->hp_jack, &ctx->mic_jack);
+	rt5645_set_jack_detect(codec, &ctx->hp_jack, &ctx->mic_jack, NULL);
 
 	return ret;
 }
-- 
1.8.1.1.439.g50a6b54
