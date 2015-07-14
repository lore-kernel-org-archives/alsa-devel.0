From: Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCH v2 3/3] ASoC: rt5645: Remove codec dependency
	in workqueue handler
Date: Tue, 14 Jul 2015 14:51:27 +0800
Message-ID: <1436856687-31550-4-git-send-email-drinkcat@chromium.org>
References: <1436856687-31550-1-git-send-email-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com
 [209.85.192.169])
 by alsa0.perex.cz (Postfix) with ESMTP id D76BB2650FA
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2015 08:52:12 +0200 (CEST)
Received: by pdbep18 with SMTP id ep18so703788pdb.1
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2015 23:52:11 -0700 (PDT)
In-Reply-To: <1436856687-31550-1-git-send-email-drinkcat@chromium.org>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, koro.chen@mediatek.com, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The workqueue handler rt5645_jack_detect_work (and functions it calls) uses
rt5645->codec, which may be uninitialized when the workqueue is first executed.

Actually, rt5645->codec is never required, and regmap functions can be used
instead of snd_soc functions.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 sound/soc/codecs/rt5645.c | 87 ++++++++++++++++++++++++++---------------------
 sound/soc/codecs/rt5645.h |  1 +
 2 files changed, 49 insertions(+), 39 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index ef6d3ad..4f62988 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2759,14 +2759,14 @@ static int rt5650_calibration(struct rt5645_priv *rt5645)
 	return ret;
 }
 
-static void rt5645_enable_push_button_irq(struct snd_soc_codec *codec,
-	bool enable)
+static void rt5645_enable_push_button_irq(struct rt5645_priv *rt5645,
+					  struct snd_soc_dapm_context *dapm,
+					  bool enable)
 {
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
-	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
+	unsigned int val;
 
 	if (enable) {
-		if (codec->component.card->instantiated) {
+		if (dapm) {
 			snd_soc_dapm_force_enable_pin(dapm, "ADC L power");
 			snd_soc_dapm_force_enable_pin(dapm, "ADC R power");
 			snd_soc_dapm_sync(dapm);
@@ -2776,18 +2776,18 @@ static void rt5645_enable_push_button_irq(struct snd_soc_codec *codec,
 				RT5645_PWR_ADC_L_BIT | RT5645_PWR_ADC_R_BIT);
 		}
 
-		snd_soc_update_bits(codec,
-					RT5645_INT_IRQ_ST, 0x8, 0x8);
-		snd_soc_update_bits(codec,
-					RT5650_4BTN_IL_CMD2, 0x8000, 0x8000);
-		snd_soc_read(codec, RT5650_4BTN_IL_CMD1);
-		pr_debug("%s read %x = %x\n", __func__, RT5650_4BTN_IL_CMD1,
-			snd_soc_read(codec, RT5650_4BTN_IL_CMD1));
+		regmap_update_bits(rt5645->regmap, RT5645_INT_IRQ_ST, 0x8, 0x8);
+		regmap_update_bits(rt5645->regmap, RT5650_4BTN_IL_CMD2,
+				   0x8000, 0x8000);
+		regmap_read(rt5645->regmap, RT5650_4BTN_IL_CMD1, &val);
+		dev_dbg(rt5645->dev, "%s read %x = %x\n", __func__,
+			RT5650_4BTN_IL_CMD1, val);
 	} else {
-		snd_soc_update_bits(codec, RT5650_4BTN_IL_CMD2, 0x8000, 0x0);
-		snd_soc_update_bits(codec, RT5645_INT_IRQ_ST, 0x8, 0x0);
+		regmap_update_bits(rt5645->regmap, RT5650_4BTN_IL_CMD2,
+				   0x8000, 0x0);
+		regmap_update_bits(rt5645->regmap, RT5645_INT_IRQ_ST, 0x8, 0x0);
 
-		if (codec->component.card->instantiated) {
+		if (dapm) {
 			snd_soc_dapm_disable_pin(dapm, "ADC L power");
 			snd_soc_dapm_disable_pin(dapm, "ADC R power");
 			snd_soc_dapm_sync(dapm);
@@ -2799,16 +2799,19 @@ static void rt5645_enable_push_button_irq(struct snd_soc_codec *codec,
 	}
 }
 
-static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
+static int rt5645_jack_detect(struct rt5645_priv *rt5645, int jack_insert)
 {
-	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
-	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
 	unsigned int val;
+	struct snd_soc_dapm_context *dapm = NULL;
+
+	if (rt5645->codec && rt5645->codec->component.card->instantiated) {
+		dapm = snd_soc_codec_get_dapm(rt5645->codec);
+	}
 
 	if (jack_insert) {
 		regmap_write(rt5645->regmap, RT5645_CHARGE_PUMP, 0x0006);
 
-		if (codec->component.card->instantiated) {
+		if (dapm) {
 			/* for jack type detect */
 			snd_soc_dapm_force_enable_pin(dapm, "LDO2");
 			snd_soc_dapm_force_enable_pin(dapm, "Mic Det Power");
@@ -2836,15 +2839,16 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 		msleep(450);
 		regmap_read(rt5645->regmap, RT5645_IN1_CTRL3, &val);
 		val &= 0x7;
-		dev_dbg(codec->dev, "val = %d\n", val);
+		dev_dbg(rt5645->dev, "val = %d\n", val);
 
 		if (val == 1 || val == 2) {
 			rt5645->jack_type = SND_JACK_HEADSET;
 			if (rt5645->en_button_func) {
-				rt5645_enable_push_button_irq(codec, true);
+				rt5645_enable_push_button_irq(rt5645, dapm,
+							      true);
 			}
 		} else {
-			if (codec->component.card->instantiated) {
+			if (dapm) {
 				snd_soc_dapm_disable_pin(dapm, "Mic Det Power");
 				snd_soc_dapm_sync(dapm);
 			} else
@@ -2857,9 +2861,9 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 		rt5645->jack_type = 0;
 
 		if (rt5645->en_button_func)
-			rt5645_enable_push_button_irq(codec, false);
+			rt5645_enable_push_button_irq(rt5645, dapm, false);
 
-		if (codec->component.card->instantiated) {
+		if (dapm) {
 			if (rt5645->pdata.jd_mode == 0)
 				snd_soc_dapm_disable_pin(dapm, "LDO2");
 			snd_soc_dapm_disable_pin(dapm, "Mic Det Power");
@@ -2877,14 +2881,14 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 	return rt5645->jack_type;
 }
 
-static int rt5645_button_detect(struct snd_soc_codec *codec)
+static int rt5645_button_detect(struct rt5645_priv *rt5645)
 {
 	int btn_type, val;
 
-	val = snd_soc_read(codec, RT5650_4BTN_IL_CMD1);
-	pr_debug("val=0x%x\n", val);
+	regmap_read(rt5645->regmap, RT5650_4BTN_IL_CMD1, &val);
+	dev_dbg(rt5645->dev, "val=0x%x\n", val);
 	btn_type = val & 0xfff0;
-	snd_soc_write(codec, RT5650_4BTN_IL_CMD1, val);
+	regmap_write(rt5645->regmap, RT5650_4BTN_IL_CMD1, val);
 
 	return btn_type;
 }
@@ -2925,9 +2929,9 @@ static void rt5645_jack_detect_work(struct work_struct *work)
 	case 0: /* Not using rt5645 JD */
 		if (rt5645->gpiod_hp_det) {
 			gpio_state = gpiod_get_value(rt5645->gpiod_hp_det);
-			dev_dbg(rt5645->codec->dev, "gpio_state = %d\n",
+			dev_dbg(rt5645->dev, "gpio_state = %d\n",
 				gpio_state);
-			report = rt5645_jack_detect(rt5645->codec, gpio_state);
+			report = rt5645_jack_detect(rt5645, gpio_state);
 		}
 		snd_soc_jack_report(rt5645->hp_jack,
 				    report, SND_JACK_HEADPHONE);
@@ -2935,10 +2939,12 @@ static void rt5645_jack_detect_work(struct work_struct *work)
 				    report, SND_JACK_MICROPHONE);
 		return;
 	case 1: /* 2 port */
-		val = snd_soc_read(rt5645->codec, RT5645_A_JD_CTRL1) & 0x0070;
+		regmap_read(rt5645->regmap, RT5645_A_JD_CTRL1, &val);
+		val &= 0x0070;
 		break;
 	default: /* 1 port */
-		val = snd_soc_read(rt5645->codec, RT5645_A_JD_CTRL1) & 0x0020;
+		regmap_read(rt5645->regmap, RT5645_A_JD_CTRL1, &val);
+		val &= 0x0020;
 		break;
 
 	}
@@ -2948,15 +2954,16 @@ static void rt5645_jack_detect_work(struct work_struct *work)
 	case 0x30: /* 2 port */
 	case 0x0: /* 1 port or 2 port */
 		if (rt5645->jack_type == 0) {
-			report = rt5645_jack_detect(rt5645->codec, 1);
+			report = rt5645_jack_detect(rt5645, 1);
 			/* for push button and jack out */
 			break;
 		}
 		btn_type = 0;
-		if (snd_soc_read(rt5645->codec, RT5645_INT_IRQ_ST) & 0x4) {
+		regmap_read(rt5645->regmap, RT5645_INT_IRQ_ST, &val);
+		if (val & 0x4) {
 			/* button pressed */
 			report = SND_JACK_HEADSET;
-			btn_type = rt5645_button_detect(rt5645->codec);
+			btn_type = rt5645_button_detect(rt5645);
 			/* rt5650 can report three kinds of button behavior,
 			   one click, double click and hold. However,
 			   currently we will report button pressed/released
@@ -2986,7 +2993,7 @@ static void rt5645_jack_detect_work(struct work_struct *work)
 			case 0x0000: /* unpressed */
 				break;
 			default:
-				dev_err(rt5645->codec->dev,
+				dev_err(rt5645->dev,
 					"Unexpected button code 0x%04x\n",
 					btn_type);
 				break;
@@ -3001,9 +3008,9 @@ static void rt5645_jack_detect_work(struct work_struct *work)
 	case 0x10: /* 2 port */
 	case 0x20: /* 1 port */
 		report = 0;
-		snd_soc_update_bits(rt5645->codec,
-				    RT5645_INT_IRQ_ST, 0x1, 0x0);
-		rt5645_jack_detect(rt5645->codec, 0);
+		regmap_update_bits(rt5645->regmap,
+				   RT5645_INT_IRQ_ST, 0x1, 0x0);
+		rt5645_jack_detect(rt5645, 0);
 		break;
 	default:
 		break;
@@ -3252,6 +3259,8 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 	rt5645->i2c = i2c;
 	i2c_set_clientdata(i2c, rt5645);
 
+	rt5645->dev = &i2c->dev;
+
 	if (pdata)
 		rt5645->pdata = *pdata;
 	else if (dmi_check_system(dmi_platform_intel_braswell))
diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index 0353a6a..8517ac6 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -2179,6 +2179,7 @@ int rt5645_sel_asrc_clk_src(struct snd_soc_codec *codec,
 
 struct rt5645_priv {
 	struct snd_soc_codec *codec;
+	struct device *dev;
 	struct rt5645_platform_data pdata;
 	struct regmap *regmap;
 	struct i2c_client *i2c;
-- 
2.4.3.573.g4eafbef
