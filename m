From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 2/2] ASoC: rt5645: Add headset detect function
Date: Fri, 19 Sep 2014 19:15:45 +0800
Message-ID: <1411125345-16935-2-git-send-email-oder_chiou@realtek.com>
References: <1411125345-16935-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 119BF261A0E
 for <alsa-devel@alsa-project.org>; Fri, 19 Sep 2014 13:16:19 +0200 (CEST)
In-Reply-To: <1411125345-16935-1-git-send-email-oder_chiou@realtek.com>
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
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Add headset detect function

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 include/sound/rt5645.h    |  3 ++
 sound/soc/codecs/rt5645.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/rt5645.h |  5 +++
 3 files changed, 107 insertions(+)

diff --git a/include/sound/rt5645.h b/include/sound/rt5645.h
index 1de744c..a535271 100644
--- a/include/sound/rt5645.h
+++ b/include/sound/rt5645.h
@@ -20,6 +20,9 @@ struct rt5645_platform_data {
 	/* 0 = IN2N; 1 = GPIO5; 2 = GPIO11 */
 	unsigned int dmic2_data_pin;
 	/* 0 = IN2P; 1 = GPIO6; 2 = GPIO10; 3 = GPIO12 */
+
+	unsigned int hp_det_gpio;
+	bool gpio_hp_det_active_high;
 };
 
 #endif
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index dfbe74a..cfe1eff 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -17,6 +17,7 @@
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
+#include <linux/gpio.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -2103,6 +2104,77 @@ static int rt5645_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
+static int rt5645_jack_detect(struct snd_soc_codec *codec,
+	struct snd_soc_jack *jack)
+{
+	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
+	int gpio_state, jack_type = 0;
+	unsigned int val;
+
+	gpio_state = gpio_get_value(rt5645->pdata.hp_det_gpio);
+
+	dev_dbg(codec->dev, "gpio = %d(%d)\n", rt5645->pdata.hp_det_gpio,
+		gpio_state);
+
+	if ((rt5645->pdata.gpio_hp_det_active_high && gpio_state) ||
+		(!rt5645->pdata.gpio_hp_det_active_high && !gpio_state)) {
+		snd_soc_dapm_force_enable_pin(&codec->dapm, "micbias1");
+		snd_soc_dapm_force_enable_pin(&codec->dapm, "micbias2");
+		snd_soc_dapm_force_enable_pin(&codec->dapm, "LDO2");
+		snd_soc_dapm_force_enable_pin(&codec->dapm, "Mic Det Power");
+		snd_soc_dapm_sync(&codec->dapm);
+
+		snd_soc_write(codec, RT5645_IN1_CTRL1, 0x0006);
+		snd_soc_write(codec, RT5645_JD_CTRL3, 0x00b0);
+
+		snd_soc_update_bits(codec, RT5645_IN1_CTRL2,
+			RT5645_CBJ_MN_JD, 0);
+		snd_soc_update_bits(codec, RT5645_IN1_CTRL2,
+			RT5645_CBJ_MN_JD, RT5645_CBJ_MN_JD);
+
+		msleep(400);
+		val = snd_soc_read(codec, RT5645_IN1_CTRL3) & 0x7;
+		dev_dbg(codec->dev, "val = %d\n", val);
+
+		if (val == 1 || val == 2)
+			jack_type = SND_JACK_HEADSET;
+		else
+			jack_type = SND_JACK_HEADPHONE;
+
+		snd_soc_dapm_disable_pin(&codec->dapm, "micbias1");
+		snd_soc_dapm_disable_pin(&codec->dapm, "micbias2");
+		snd_soc_dapm_disable_pin(&codec->dapm, "LDO2");
+		snd_soc_dapm_disable_pin(&codec->dapm, "Mic Det Power");
+		snd_soc_dapm_sync(&codec->dapm);
+	}
+
+	snd_soc_jack_report(rt5645->jack, jack_type, SND_JACK_HEADSET);
+
+	return 0;
+}
+
+int rt5645_set_jack_detect(struct snd_soc_codec *codec,
+	struct snd_soc_jack *jack)
+{
+	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
+
+	rt5645->jack = jack;
+
+	rt5645_jack_detect(codec, rt5645->jack);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rt5645_set_jack_detect);
+
+static irqreturn_t rt5645_irq(int irq, void *data)
+{
+	struct rt5645_priv *rt5645 = data;
+
+	rt5645_jack_detect(rt5645->codec, rt5645->jack);
+
+	return IRQ_HANDLED;
+}
+
 static int rt5645_probe(struct snd_soc_codec *codec)
 {
 	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
@@ -2250,6 +2322,7 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 	if (rt5645 == NULL)
 		return -ENOMEM;
 
+	rt5645->i2c = i2c;
 	i2c_set_clientdata(i2c, rt5645);
 
 	if (pdata)
@@ -2345,12 +2418,38 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 
 	}
 
+	if (rt5645->i2c->irq) {
+		ret = request_threaded_irq(rt5645->i2c->irq, NULL, rt5645_irq,
+			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
+			| IRQF_ONESHOT, "rt5645", rt5645);
+		if (ret)
+			dev_err(&i2c->dev, "Failed to reguest IRQ: %d\n", ret);
+	}
+
+	if (gpio_is_valid(rt5645->pdata.hp_det_gpio)) {
+		ret = gpio_request(rt5645->pdata.hp_det_gpio, "rt5645");
+		if (ret)
+			dev_err(&i2c->dev, "Fail gpio_request hp_det_gpio\n");
+
+		ret = gpio_direction_input(rt5645->pdata.hp_det_gpio);
+		if (ret)
+			dev_err(&i2c->dev, "Fail gpio_direction hp_det_gpio\n");
+	}
+
 	return snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5645,
 				      rt5645_dai, ARRAY_SIZE(rt5645_dai));
 }
 
 static int rt5645_i2c_remove(struct i2c_client *i2c)
 {
+	struct rt5645_priv *rt5645 = i2c_get_clientdata(i2c);
+
+	if (i2c->irq)
+		free_irq(i2c->irq, rt5645);
+
+	if (gpio_is_valid(rt5645->pdata.hp_det_gpio))
+		gpio_free(rt5645->pdata.hp_det_gpio);
+
 	snd_soc_unregister_codec(&i2c->dev);
 
 	return 0;
diff --git a/sound/soc/codecs/rt5645.h b/sound/soc/codecs/rt5645.h
index 355b7e9..50c62c5 100644
--- a/sound/soc/codecs/rt5645.h
+++ b/sound/soc/codecs/rt5645.h
@@ -2166,6 +2166,8 @@ struct rt5645_priv {
 	struct snd_soc_codec *codec;
 	struct rt5645_platform_data pdata;
 	struct regmap *regmap;
+	struct i2c_client *i2c;
+	struct snd_soc_jack *jack;
 
 	int sysclk;
 	int sysclk_src;
@@ -2178,4 +2180,7 @@ struct rt5645_priv {
 	int pll_out;
 };
 
+int rt5645_set_jack_detect(struct snd_soc_codec *codec,
+	struct snd_soc_jack *jack);
+
 #endif /* __RT5645_H__ */
-- 
1.8.1.1.439.g50a6b54
