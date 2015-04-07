From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt5645: Adds push button support for
	rt5650
Date: Tue, 7 Apr 2015 19:55:18 +0800
Message-ID: <1428407718-10641-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 594092604FD
 for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2015 13:55:30 +0200 (CEST)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, koro.chen@mediatek.com, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

This patch exports rt5650_set_button_detect function for machine
driver to support rt5650 headset button detection function.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.c | 147 +++++++++++++++++++++++++++++++++++++++++++---
 sound/soc/codecs/rt5645.h |   7 ++-
 2 files changed, 146 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 69528ae..e547a994 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2368,6 +2368,8 @@ static int rt5645_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 static int rt5645_set_bias_level(struct snd_soc_codec *codec,
 			enum snd_soc_bias_level level)
 {
+	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
+
 	switch (level) {
 	case SND_SOC_BIAS_PREPARE:
 		if (SND_SOC_BIAS_STANDBY == codec->dapm.bias_level) {
@@ -2398,8 +2400,9 @@ static int rt5645_set_bias_level(struct snd_soc_codec *codec,
 
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
@@ -2414,6 +2417,37 @@ static int rt5645_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
+static void rt5645_enable_push_button_irq(struct snd_soc_codec *codec,
+	bool enable)
+{
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
+		snd_soc_update_bits(codec, RT5645_INT_IRQ_ST, 0x8, 0x8);
+		snd_soc_update_bits(codec, RT5650_4BTN_IL_CMD2, 0x8000, 0x8000);
+		snd_soc_read(codec, RT5650_4BTN_IL_CMD1);
+	} else {
+		snd_soc_update_bits(codec, RT5650_4BTN_IL_CMD2, 0x8000, 0x0);
+		snd_soc_update_bits(codec, RT5645_INT_IRQ_ST, 0x8, 0x0);
+		snd_soc_dapm_disable_pin_unlocked(&codec->dapm,
+							"ADC L power");
+		snd_soc_dapm_disable_pin_unlocked(&codec->dapm,
+							"ADC R power");
+		snd_soc_dapm_disable_pin_unlocked(&codec->dapm,
+							"LDO2");
+		snd_soc_dapm_disable_pin_unlocked(&codec->dapm,
+							"Mic Det Power");
+		snd_soc_dapm_sync_unlocked(&codec->dapm);
+	}
+}
+
 static int rt5645_jack_detect(struct snd_soc_codec *codec)
 {
 	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
@@ -2449,17 +2483,24 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec)
 		val = snd_soc_read(codec, RT5645_IN1_CTRL3) & 0x7;
 		dev_dbg(codec->dev, "val = %d\n", val);
 
-		if (val == 1 || val == 2)
-			jack_type = SND_JACK_HEADSET;
-		else
-			jack_type = SND_JACK_HEADPHONE;
-
 		snd_soc_dapm_disable_pin(&codec->dapm, "micbias1");
 		snd_soc_dapm_disable_pin(&codec->dapm, "micbias2");
 		if (rt5645->pdata.jd_mode == 0)
 			snd_soc_dapm_disable_pin(&codec->dapm, "LDO2");
 		snd_soc_dapm_disable_pin(&codec->dapm, "Mic Det Power");
 		snd_soc_dapm_sync(&codec->dapm);
+
+		if (val == 1 || val == 2) {
+			jack_type = SND_JACK_HEADSET;
+			if (rt5645->en_button_func)
+				rt5645_enable_push_button_irq(codec, true);
+		} else {
+			jack_type = SND_JACK_HEADPHONE;
+		}
+
+	} else { /* jack out */
+		if (rt5645->en_button_func)
+			rt5645_enable_push_button_irq(codec, false);
 	}
 
 	snd_soc_jack_report(rt5645->hp_jack, jack_type, SND_JACK_HEADPHONE);
@@ -2480,6 +2521,42 @@ int rt5645_set_jack_detect(struct snd_soc_codec *codec,
 }
 EXPORT_SYMBOL_GPL(rt5645_set_jack_detect);
 
+int rt5650_set_button_detect(struct snd_soc_codec *codec,
+	struct snd_soc_jack *jack)
+{
+	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	rt5645->jack = jack;
+	rt5645->codec_irq.gpiod_dev = codec->dev;
+	rt5645->codec_irq.name = "rt5650 irq";
+	rt5645->codec_irq.report = SND_JACK_HEADSET |
+		SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+		SND_JACK_BTN_2 | SND_JACK_BTN_3;
+	rt5645->codec_irq.debounce_time = 150;
+	rt5645->codec_irq.wake = true;
+	rt5645->codec_irq.data = (struct rt5645_priv *)rt5645;
+	rt5645->codec_irq.jack_status_check = rt5645_irq_detection;
+
+	ret = snd_soc_jack_add_gpios(rt5645->jack, 1,
+			&rt5645->codec_irq);
+	if (ret) {
+		dev_err(codec->dev, "Adding jack GPIO failed\n");
+		return ret;
+	}
+
+	regmap_update_bits(rt5645->regmap, RT5645_GPIO_CTRL1,
+			RT5645_GP1_PIN_IRQ, RT5645_GP1_PIN_IRQ);
+	regmap_update_bits(rt5645->regmap, RT5645_DEPOP_M1,
+			RT5645_HP_CB_MASK, RT5645_HP_CB_PU);
+	regmap_update_bits(rt5645->regmap, RT5645_GEN_CTRL1,
+			RT5645_DIG_GATE_CTRL, RT5645_DIG_GATE_CTRL);
+	rt5645->en_button_func = true;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rt5650_set_button_detect);
+
 static void rt5645_jack_detect_work(struct work_struct *work)
 {
 	struct rt5645_priv *rt5645 =
@@ -2498,6 +2575,62 @@ static irqreturn_t rt5645_irq(int irq, void *data)
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
+static int rt5645_irq_detection(void *data)
+{
+	struct rt5645_priv *rt5645 = (struct rt5645_priv *)data;
+	struct snd_soc_jack *jack = &rt5645->jack;
+	int btn_type, report = SND_JACK_HEADSET;
+
+	btn_type = rt5645_button_detect(rt5645->codec);
+	switch (btn_type) {
+	case 0x8000:
+	case 0x4000:
+	case 0x2000:
+		report |= SND_JACK_BTN_0;
+		break;
+	case 0x1000:
+	case 0x0800:
+	case 0x0400:
+		report |= SND_JACK_BTN_1;
+		break;
+	case 0x0200:
+	case 0x0100:
+	case 0x0080:
+		report |= SND_JACK_BTN_2;
+		break;
+	case 0x0040:
+	case 0x0020:
+	case 0x0010:
+		report |= SND_JACK_BTN_3;
+		break;
+	case 0x0000: /* unpressed */
+		break;
+	default:
+		dev_err(rt5645->codec->dev,
+			"Unexpected button code 0x%04x\n",
+			btn_type);
+		/* keep the jack status */
+		report = jack->status;
+		break;
+	}
+
+	pr_debug("report=%x\n", report);
+
+	return report;
+}
+
 static int rt5645_probe(struct snd_soc_codec *codec)
 {
 	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index db78e94..bf29d8b 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -2184,7 +2184,9 @@ struct rt5645_priv {
 	struct i2c_client *i2c;
 	struct snd_soc_jack *hp_jack;
 	struct snd_soc_jack *mic_jack;
+	struct snd_soc_jack *jack;
 	struct delayed_work jack_detect_work;
+	struct snd_soc_jack_gpio codec_irq;
 
 	int codec_type;
 	int sysclk;
@@ -2196,9 +2198,12 @@ struct rt5645_priv {
 	int pll_src;
 	int pll_in;
 	int pll_out;
+
+	bool en_button_func;
 };
 
 int rt5645_set_jack_detect(struct snd_soc_codec *codec,
 	struct snd_soc_jack *hp_jack, struct snd_soc_jack *mic_jack);
-
+int rt5650_set_button_detect(struct snd_soc_codec *codec,
+	struct snd_soc_jack *jack);
 #endif /* __RT5645_H__ */
-- 
1.8.1.1.439.g50a6b54
