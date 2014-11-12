From: <bardliao@realtek.com>
Subject: [PATCH 4/4] ASoC: rt5670: add codec irq support
Date: Wed, 12 Nov 2014 14:28:01 +0800
Message-ID: <1415773681-2394-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id AAB8126527F
 for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2014 07:28:31 +0100 (CET)
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, mengdong.lin@intel.com, Bard Liao <bardliao@realtek.com>, yao.jin@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

This patch provide the jack function of rt5670. We use a irq pin
to notice the jack event. rt5670_irq_detection will determine
which status should be reported.
We can get gpio information from gpio number or gpiod_dev. That's
why we define both on platform data.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 include/sound/rt5670.h    |   2 +
 sound/soc/codecs/rt5670.c | 176 +++++++++++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/rt5670.h |   2 +
 3 files changed, 178 insertions(+), 2 deletions(-)

diff --git a/include/sound/rt5670.h b/include/sound/rt5670.h
index bd31119..bb5cf6d 100644
--- a/include/sound/rt5670.h
+++ b/include/sound/rt5670.h
@@ -14,6 +14,8 @@
 struct rt5670_platform_data {
 	int jd_mode;
 	bool in2_diff;
+	int codec_gpio;
+	bool dev_gpio;
 
 	bool dmic_en;
 	unsigned int dmic1_data_pin;
diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 89fa507..cb5a91c 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -401,6 +401,144 @@ static bool rt5670_readable_register(struct device *dev, unsigned int reg)
 	}
 }
 
+/**
+ * rt5670_headset_detect - Detect headset.
+ * @codec: SoC audio codec device.
+ * @jack_insert: Jack insert or not.
+ *
+ * Detect whether is headset or not when jack inserted.
+ *
+ * Returns detect status.
+ */
+
+static int rt5670_headset_detect(struct snd_soc_codec *codec, int jack_insert)
+{
+	int val;
+	struct rt5670_priv *rt5670 = snd_soc_codec_get_drvdata(codec);
+
+	if (jack_insert) {
+		snd_soc_dapm_force_enable_pin(&codec->dapm,
+						       "Mic Det Power");
+		snd_soc_dapm_sync(&codec->dapm);
+		snd_soc_update_bits(codec, RT5670_GEN_CTRL3, 0x4, 0x0);
+		snd_soc_update_bits(codec, RT5670_CJ_CTRL2,
+			RT5670_CBJ_DET_MODE | RT5670_CBJ_MN_JD,
+			RT5670_CBJ_MN_JD);
+		snd_soc_write(codec, RT5670_GPIO_CTRL2, 0x0004);
+		snd_soc_update_bits(codec, RT5670_GPIO_CTRL1,
+			RT5670_GP1_PIN_MASK, RT5670_GP1_PIN_IRQ);
+		snd_soc_update_bits(codec, RT5670_CJ_CTRL1,
+			RT5670_CBJ_BST1_EN, RT5670_CBJ_BST1_EN);
+		snd_soc_write(codec, RT5670_JD_CTRL3, 0x00f0);
+		snd_soc_update_bits(codec, RT5670_CJ_CTRL2,
+			RT5670_CBJ_MN_JD, RT5670_CBJ_MN_JD);
+		snd_soc_update_bits(codec, RT5670_CJ_CTRL2,
+			RT5670_CBJ_MN_JD, 0);
+		msleep(300);
+		val = snd_soc_read(codec, RT5670_CJ_CTRL3) & 0x7;
+		if (val == 0x1 || val == 0x2) {
+			rt5670->jack_type = SND_JACK_HEADSET;
+			/* for push button */
+			snd_soc_update_bits(codec, RT5670_INT_IRQ_ST, 0x8, 0x8);
+			snd_soc_update_bits(codec, RT5670_IL_CMD, 0x40, 0x40);
+			snd_soc_read(codec, RT5670_IL_CMD);
+		} else {
+			snd_soc_update_bits(codec, RT5670_GEN_CTRL3, 0x4, 0x4);
+			rt5670->jack_type = SND_JACK_HEADPHONE;
+			snd_soc_dapm_disable_pin(&codec->dapm, "Mic Det Power");
+			snd_soc_dapm_sync(&codec->dapm);
+		}
+	} else {
+		snd_soc_update_bits(codec, RT5670_INT_IRQ_ST, 0x8, 0x0);
+		snd_soc_update_bits(codec, RT5670_GEN_CTRL3, 0x4, 0x4);
+		rt5670->jack_type = 0;
+		snd_soc_dapm_disable_pin(&codec->dapm, "Mic Det Power");
+		snd_soc_dapm_sync(&codec->dapm);
+	}
+
+	return rt5670->jack_type;
+}
+
+static int rt5670_button_detect(struct snd_soc_codec *codec)
+{
+	int btn_type, val;
+
+	val = snd_soc_read(codec, RT5670_IL_CMD);
+	btn_type = val & 0xff80;
+	snd_soc_write(codec, RT5670_IL_CMD, val);
+	if (btn_type != 0) {
+		msleep(20);
+		val = snd_soc_read(codec, RT5670_IL_CMD);
+		snd_soc_write(codec, RT5670_IL_CMD, val);
+	}
+
+	return btn_type;
+}
+
+static int rt5670_irq_detection(void *data)
+{
+	struct rt5670_priv *rt5670 = (struct rt5670_priv *)data;
+	struct snd_soc_jack_gpio *gpio = &rt5670->hp_gpio;
+	struct snd_soc_jack *jack = &rt5670->jack;
+	int val, btn_type, report = jack->status;
+
+	if (rt5670->pdata.jd_mode == 1) /* 2 port */
+		val = snd_soc_read(rt5670->codec, RT5670_A_JD_CTRL1) & 0x0070;
+	else
+		val = snd_soc_read(rt5670->codec, RT5670_A_JD_CTRL1) & 0x0020;
+
+	switch (val) {
+	/* jack in */
+	case 0x30: /* 2 port */
+	case 0x0: /* 1 port or 2 port */
+		if (rt5670->jack_type == 0) {
+			report = rt5670_headset_detect(rt5670->codec, 1);
+			/* for push button and jack out */
+			gpio->debounce_time = 25;
+			break;
+		}
+		btn_type = 0;
+		if (snd_soc_read(rt5670->codec, RT5670_INT_IRQ_ST) & 0x4) {
+			/* button pressed */
+			report = SND_JACK_HEADSET;
+			btn_type = rt5670_button_detect(rt5670->codec);
+			switch (btn_type) {
+			case 0x2000: /* up */
+				report |= SND_JACK_BTN_1;
+				break;
+			case 0x0400: /* center */
+				report |= SND_JACK_BTN_0;
+				break;
+			case 0x0080: /* down */
+				report |= SND_JACK_BTN_2;
+				break;
+			default:
+				dev_err(rt5670->codec->dev,
+					"Unexpected button code 0x%04x\n",
+					btn_type);
+				break;
+			}
+		}
+		if (btn_type == 0)/* button release */
+			report =  rt5670->jack_type;
+
+		break;
+	/* jack out */
+	case 0x70: /* 2 port */
+	case 0x10: /* 2 port */
+	case 0x20: /* 1 port */
+		report = 0;
+		snd_soc_update_bits(rt5670->codec, RT5670_INT_IRQ_ST, 0x1, 0x0);
+		rt5670_headset_detect(rt5670->codec, 0);
+		gpio->debounce_time = 150; /* for jack in */
+		break;
+	default:
+		break;
+	}
+
+	return report;
+}
+
 static const DECLARE_TLV_DB_SCALE(out_vol_tlv, -4650, 150, 0);
 static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, -65625, 375, 0);
 static const DECLARE_TLV_DB_SCALE(in_vol_tlv, -3450, 150, 0);
@@ -2413,6 +2551,34 @@ static int rt5670_probe(struct snd_soc_codec *codec)
 		return -ENODEV;
 	}
 	rt5670->codec = codec;
+	if ((rt5670->pdata.codec_gpio != -1) || (rt5670->pdata.dev_gpio)) {
+		if (rt5670->pdata.dev_gpio)
+			rt5670->hp_gpio.gpiod_dev = codec->dev;
+		else
+			rt5670->hp_gpio.gpio = rt5670->pdata.codec_gpio;
+
+		rt5670->hp_gpio.name = "headphone detect";
+		rt5670->hp_gpio.report = SND_JACK_HEADSET |
+			SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_BTN_2;
+		rt5670->hp_gpio.debounce_time = 150,
+		rt5670->hp_gpio.wake = true,
+		rt5670->hp_gpio.data = (struct rt5670_priv *)rt5670,
+		rt5670->hp_gpio.jack_status_check = rt5670_irq_detection,
+		ret = snd_soc_jack_new(codec, rt5670->hp_gpio.name,
+				rt5670->hp_gpio.report,
+				&rt5670->jack);
+		if (ret) {
+			dev_err(codec->dev, "Jack creation failed\n");
+			return ret;
+		}
+
+		ret = snd_soc_jack_add_gpios(&rt5670->jack, 1,
+				&rt5670->hp_gpio);
+		if (ret) {
+			dev_err(codec->dev, "Adding jack GPIO failed\n");
+			return ret;
+		}
+	}
 
 	return 0;
 }
@@ -2422,6 +2588,7 @@ static int rt5670_remove(struct snd_soc_codec *codec)
 	struct rt5670_priv *rt5670 = snd_soc_codec_get_drvdata(codec);
 
 	regmap_write(rt5670->regmap, RT5670_RESET, 0);
+	snd_soc_jack_free_gpios(&rt5670->jack, 1, &rt5670->hp_gpio);
 	return 0;
 }
 
@@ -2590,12 +2757,17 @@ static int rt5670_i2c_probe(struct i2c_client *i2c,
 		regmap_update_bits(rt5670->regmap, RT5670_IN2,
 					RT5670_IN_DF2, RT5670_IN_DF2);
 
-	if (i2c->irq) {
+	if ((rt5670->pdata.codec_gpio != -1) || (rt5670->pdata.dev_gpio)) {
+		/* for push button */
+		regmap_write(rt5670->regmap, RT5670_IL_CMD, 0x0000);
+		regmap_write(rt5670->regmap, RT5670_IL_CMD2, 0x0010);
+		regmap_write(rt5670->regmap, RT5670_IL_CMD3, 0x0014);
+		/* for irq */
 		regmap_update_bits(rt5670->regmap, RT5670_GPIO_CTRL1,
 				   RT5670_GP1_PIN_MASK, RT5670_GP1_PIN_IRQ);
 		regmap_update_bits(rt5670->regmap, RT5670_GPIO_CTRL2,
 				   RT5670_GP1_PF_MASK, RT5670_GP1_PF_OUT);
-
+		regmap_update_bits(rt5670->regmap, RT5670_DIG_MISC, 0x8, 0x8);
 	}
 
 	if (rt5670->pdata.jd_mode) {
diff --git a/sound/soc/codecs/rt5670.h b/sound/soc/codecs/rt5670.h
index d11b9c2..54933f3 100644
--- a/sound/soc/codecs/rt5670.h
+++ b/sound/soc/codecs/rt5670.h
@@ -1987,6 +1987,8 @@ struct rt5670_priv {
 	struct snd_soc_codec *codec;
 	struct rt5670_platform_data pdata;
 	struct regmap *regmap;
+	struct snd_soc_jack jack;
+	struct snd_soc_jack_gpio hp_gpio;
 
 	int sysclk;
 	int sysclk_src;
-- 
1.8.1.1.439.g50a6b54
