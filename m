From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 2/2] ASoC: rt5677: Add the GPIO function
Date: Mon, 15 Sep 2014 19:58:45 +0800
Message-ID: <1410782325-10541-2-git-send-email-oder_chiou@realtek.com>
References: <1410782325-10541-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 55E34261B31
 for <alsa-devel@alsa-project.org>; Mon, 15 Sep 2014 13:59:05 +0200 (CEST)
In-Reply-To: <1410782325-10541-1-git-send-email-oder_chiou@realtek.com>
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

The patch adds the GPIO function.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5677.c | 230 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/rt5677.h | 112 ++++++++++++++++++++++
 2 files changed, 342 insertions(+)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index f0b751b..c85d020 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -19,6 +19,7 @@
 #include <linux/i2c.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
+#include <linux/gpio.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -3160,6 +3161,232 @@ static int rt5677_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
+#ifdef CONFIG_GPIOLIB
+static inline struct rt5677_priv *gpio_to_rt5677(struct gpio_chip *chip)
+{
+	return container_of(chip, struct rt5677_priv, gpio_chip);
+}
+
+static void rt5677_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	struct rt5677_priv *rt5677 = gpio_to_rt5677(chip);
+
+	switch (offset) {
+	case RT5677_GPIO1:
+		regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL2,
+			RT5677_GPIO1_OUT_MASK, !!value << RT5677_GPIO1_OUT_SFT);
+		break;
+
+	case RT5677_GPIO2:
+		regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL2,
+			RT5677_GPIO2_OUT_MASK, !!value << RT5677_GPIO2_OUT_SFT);
+		break;
+
+	case RT5677_GPIO3:
+		regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL2,
+			RT5677_GPIO3_OUT_MASK, !!value << RT5677_GPIO3_OUT_SFT);
+		break;
+
+	case RT5677_GPIO4:
+		regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL2,
+			RT5677_GPIO4_OUT_MASK, !!value << RT5677_GPIO4_OUT_SFT);
+		break;
+
+	case RT5677_GPIO5:
+		regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL2,
+			RT5677_GPIO5_OUT_MASK, !!value << RT5677_GPIO5_OUT_SFT);
+		break;
+
+	case RT5677_GPIO6:
+		regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL3,
+			RT5677_GPIO6_OUT_MASK, !!value << RT5677_GPIO6_OUT_SFT);
+		break;
+
+	default:
+		break;
+	}
+}
+
+static int rt5677_gpio_direction_out(struct gpio_chip *chip,
+				     unsigned offset, int value)
+{
+	struct rt5677_priv *rt5677 = gpio_to_rt5677(chip);
+
+	switch (offset) {
+	case RT5677_GPIO1:
+		regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL2,
+			RT5677_GPIO1_DIR_MASK | RT5677_GPIO1_OUT_MASK,
+			RT5677_GPIO1_DIR_OUT | !!value << RT5677_GPIO1_OUT_SFT);
+		break;
+
+	case RT5677_GPIO2:
+		regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL2,
+			RT5677_GPIO2_DIR_MASK | RT5677_GPIO2_OUT_MASK,
+			RT5677_GPIO2_DIR_OUT | !!value << RT5677_GPIO2_OUT_SFT);
+		break;
+
+	case RT5677_GPIO3:
+		regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL2,
+			RT5677_GPIO3_DIR_MASK | RT5677_GPIO3_OUT_MASK,
+			RT5677_GPIO3_DIR_OUT | !!value << RT5677_GPIO3_OUT_SFT);
+		break;
+
+	case RT5677_GPIO4:
+		regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL2,
+			RT5677_GPIO4_DIR_MASK | RT5677_GPIO4_OUT_MASK,
+			RT5677_GPIO4_DIR_OUT | !!value << RT5677_GPIO4_OUT_SFT);
+		break;
+
+	case RT5677_GPIO5:
+		regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL2,
+			RT5677_GPIO5_DIR_MASK | RT5677_GPIO5_OUT_MASK,
+			RT5677_GPIO5_DIR_OUT | !!value << RT5677_GPIO5_OUT_SFT);
+		break;
+
+	case RT5677_GPIO6:
+		regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL3,
+			RT5677_GPIO6_DIR_MASK | RT5677_GPIO6_OUT_MASK,
+			RT5677_GPIO6_DIR_OUT | !!value << RT5677_GPIO6_OUT_SFT);
+		break;
+
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int rt5677_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	struct rt5677_priv *rt5677 = gpio_to_rt5677(chip);
+	unsigned int value = 0;
+
+	regmap_read(rt5677->regmap, RT5677_GPIO_ST, &value);
+
+	switch (offset) {
+	case RT5677_GPIO1:
+		value = (value & RT5677_GPIO1_STATUS_MASK)
+			>> RT5677_GPIO1_STATUS_SFT;
+		break;
+
+	case RT5677_GPIO2:
+		value = (value & RT5677_GPIO2_STATUS_MASK)
+			>> RT5677_GPIO2_STATUS_SFT;
+		break;
+
+	case RT5677_GPIO3:
+		value = (value & RT5677_GPIO3_STATUS_MASK)
+			>> RT5677_GPIO3_STATUS_SFT;
+		break;
+
+	case RT5677_GPIO4:
+		value = (value & RT5677_GPIO4_STATUS_MASK)
+			>> RT5677_GPIO4_STATUS_SFT;
+		break;
+
+	case RT5677_GPIO5:
+		value = (value & RT5677_GPIO5_STATUS_MASK)
+			>> RT5677_GPIO5_STATUS_SFT;
+		break;
+
+	case RT5677_GPIO6:
+		value = (value & RT5677_GPIO6_STATUS_MASK)
+			>> RT5677_GPIO6_STATUS_SFT;
+		break;
+
+	default:
+		break;
+	}
+
+	return value;
+}
+
+static int rt5677_gpio_direction_in(struct gpio_chip *chip, unsigned offset)
+{
+	struct rt5677_priv *rt5677 = gpio_to_rt5677(chip);
+
+	switch (offset) {
+	case RT5677_GPIO1:
+		regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL2,
+			RT5677_GPIO1_DIR_MASK, RT5677_GPIO1_DIR_IN);
+		break;
+
+	case RT5677_GPIO2:
+		regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL2,
+			RT5677_GPIO2_DIR_MASK, RT5677_GPIO2_DIR_IN);
+		break;
+
+	case RT5677_GPIO3:
+		regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL2,
+			RT5677_GPIO3_DIR_MASK, RT5677_GPIO3_DIR_IN);
+		break;
+
+	case RT5677_GPIO4:
+		regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL2,
+			RT5677_GPIO4_DIR_MASK, RT5677_GPIO4_DIR_IN);
+		break;
+
+	case RT5677_GPIO5:
+		regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL2,
+			RT5677_GPIO5_DIR_MASK, RT5677_GPIO5_DIR_IN);
+		break;
+
+	case RT5677_GPIO6:
+		regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL3,
+			RT5677_GPIO6_DIR_MASK, RT5677_GPIO6_DIR_IN);
+		break;
+
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static struct gpio_chip rt5677_template_chip = {
+	.label			= "rt5677",
+	.owner			= THIS_MODULE,
+	.direction_output	= rt5677_gpio_direction_out,
+	.set			= rt5677_gpio_set,
+	.direction_input	= rt5677_gpio_direction_in,
+	.get			= rt5677_gpio_get,
+	.can_sleep		= 1,
+};
+
+static void rt5677_init_gpio(struct i2c_client *i2c)
+{
+	struct rt5677_priv *rt5677 = i2c_get_clientdata(i2c);
+	int ret;
+
+	rt5677->gpio_chip = rt5677_template_chip;
+	rt5677->gpio_chip.ngpio = RT5677_GPIO_NUM;
+	rt5677->gpio_chip.dev = &i2c->dev;
+	rt5677->gpio_chip.base = -1;
+
+	ret = gpiochip_add(&rt5677->gpio_chip);
+	if (ret != 0)
+		dev_err(&i2c->dev, "Failed to add GPIOs: %d\n", ret);
+}
+
+static void rt5677_free_gpio(struct i2c_client *i2c)
+{
+	struct rt5677_priv *rt5677 = i2c_get_clientdata(i2c);
+	int ret;
+
+	ret = gpiochip_remove(&rt5677->gpio_chip);
+	if (ret != 0)
+		dev_err(&i2c->dev, "Failed to remove GPIOs: %d\n", ret);
+}
+#else
+static void rt5677_init_gpio(struct i2c_client *i2c)
+{
+}
+
+static void rt5677_free_gpio(struct i2c_client *i2c)
+{
+}
+#endif
+
 static int rt5677_probe(struct snd_soc_codec *codec)
 {
 	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
@@ -3422,6 +3649,8 @@ static int rt5677_i2c_probe(struct i2c_client *i2c,
 					RT5677_GPIO5_DIR_OUT);
 	}
 
+	rt5677_init_gpio(i2c);
+
 	return snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5677,
 				      rt5677_dai, ARRAY_SIZE(rt5677_dai));
 }
@@ -3429,6 +3658,7 @@ static int rt5677_i2c_probe(struct i2c_client *i2c,
 static int rt5677_i2c_remove(struct i2c_client *i2c)
 {
 	snd_soc_unregister_codec(&i2c->dev);
+	rt5677_free_gpio(i2c);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
index a334eb6..b61b72c 100644
--- a/sound/soc/codecs/rt5677.h
+++ b/sound/soc/codecs/rt5677.h
@@ -1363,10 +1363,109 @@
 #define RT5677_SEL_SRC_IB01			(0x1 << 0)
 #define RT5677_SEL_SRC_IB01_SFT			0
 
+/* GPIO status (0xbf) */
+#define RT5677_GPIO6_STATUS_MASK		(0x1 << 5)
+#define RT5677_GPIO6_STATUS_SFT			5
+#define RT5677_GPIO5_STATUS_MASK		(0x1 << 4)
+#define RT5677_GPIO5_STATUS_SFT			4
+#define RT5677_GPIO4_STATUS_MASK		(0x1 << 3)
+#define RT5677_GPIO4_STATUS_SFT			3
+#define RT5677_GPIO3_STATUS_MASK		(0x1 << 2)
+#define RT5677_GPIO3_STATUS_SFT			2
+#define RT5677_GPIO2_STATUS_MASK		(0x1 << 1)
+#define RT5677_GPIO2_STATUS_SFT			1
+#define RT5677_GPIO1_STATUS_MASK		(0x1 << 0)
+#define RT5677_GPIO1_STATUS_SFT			0
+
+/* GPIO Control 1 (0xc0) */
+#define RT5677_GPIO1_PIN_MASK			(0x1 << 15)
+#define RT5677_GPIO1_PIN_SFT			15
+#define RT5677_GPIO1_PIN_GPIO1			(0x0 << 15)
+#define RT5677_GPIO1_PIN_IRQ			(0x1 << 15)
+#define RT5677_IPTV_MODE_MASK			(0x1 << 14)
+#define RT5677_IPTV_MODE_SFT			14
+#define RT5677_IPTV_MODE_GPIO			(0x0 << 14)
+#define RT5677_IPTV_MODE_IPTV			(0x1 << 14)
+#define RT5677_FUNC_MODE_MASK			(0x1 << 13)
+#define RT5677_FUNC_MODE_SFT			13
+#define RT5677_FUNC_MODE_DMIC_GPIO		(0x0 << 13)
+#define RT5677_FUNC_MODE_JTAG			(0x1 << 13)
+
 /* GPIO Control 2 (0xc1) */
 #define RT5677_GPIO5_DIR_MASK			(0x1 << 14)
+#define RT5677_GPIO5_DIR_SFT			14
 #define RT5677_GPIO5_DIR_IN			(0x0 << 14)
 #define RT5677_GPIO5_DIR_OUT			(0x1 << 14)
+#define RT5677_GPIO5_OUT_MASK			(0x1 << 13)
+#define RT5677_GPIO5_OUT_SFT			13
+#define RT5677_GPIO5_OUT_LO			(0x0 << 13)
+#define RT5677_GPIO5_OUT_HI			(0x1 << 13)
+#define RT5677_GPIO5_P_MASK			(0x1 << 12)
+#define RT5677_GPIO5_P_SFT			12
+#define RT5677_GPIO5_P_NOR			(0x0 << 12)
+#define RT5677_GPIO5_P_INV			(0x1 << 12)
+#define RT5677_GPIO4_DIR_MASK			(0x1 << 11)
+#define RT5677_GPIO4_DIR_SFT			11
+#define RT5677_GPIO4_DIR_IN			(0x0 << 11)
+#define RT5677_GPIO4_DIR_OUT			(0x1 << 11)
+#define RT5677_GPIO4_OUT_MASK			(0x1 << 10)
+#define RT5677_GPIO4_OUT_SFT			10
+#define RT5677_GPIO4_OUT_LO			(0x0 << 10)
+#define RT5677_GPIO4_OUT_HI			(0x1 << 10)
+#define RT5677_GPIO4_P_MASK			(0x1 << 9)
+#define RT5677_GPIO4_P_SFT			9
+#define RT5677_GPIO4_P_NOR			(0x0 << 9)
+#define RT5677_GPIO4_P_INV			(0x1 << 9)
+#define RT5677_GPIO3_DIR_MASK			(0x1 << 8)
+#define RT5677_GPIO3_DIR_SFT			8
+#define RT5677_GPIO3_DIR_IN			(0x0 << 8)
+#define RT5677_GPIO3_DIR_OUT			(0x1 << 8)
+#define RT5677_GPIO3_OUT_MASK			(0x1 << 7)
+#define RT5677_GPIO3_OUT_SFT			7
+#define RT5677_GPIO3_OUT_LO			(0x0 << 7)
+#define RT5677_GPIO3_OUT_HI			(0x1 << 7)
+#define RT5677_GPIO3_P_MASK			(0x1 << 6)
+#define RT5677_GPIO3_P_SFT			6
+#define RT5677_GPIO3_P_NOR			(0x0 << 6)
+#define RT5677_GPIO3_P_INV			(0x1 << 6)
+#define RT5677_GPIO2_DIR_MASK			(0x1 << 5)
+#define RT5677_GPIO2_DIR_SFT			5
+#define RT5677_GPIO2_DIR_IN			(0x0 << 5)
+#define RT5677_GPIO2_DIR_OUT			(0x1 << 5)
+#define RT5677_GPIO2_OUT_MASK			(0x1 << 4)
+#define RT5677_GPIO2_OUT_SFT			4
+#define RT5677_GPIO2_OUT_LO			(0x0 << 4)
+#define RT5677_GPIO2_OUT_HI			(0x1 << 4)
+#define RT5677_GPIO2_P_MASK			(0x1 << 3)
+#define RT5677_GPIO2_P_SFT			3
+#define RT5677_GPIO2_P_NOR			(0x0 << 3)
+#define RT5677_GPIO2_P_INV			(0x1 << 3)
+#define RT5677_GPIO1_DIR_MASK			(0x1 << 2)
+#define RT5677_GPIO1_DIR_SFT			2
+#define RT5677_GPIO1_DIR_IN			(0x0 << 2)
+#define RT5677_GPIO1_DIR_OUT			(0x1 << 2)
+#define RT5677_GPIO1_OUT_MASK			(0x1 << 1)
+#define RT5677_GPIO1_OUT_SFT			1
+#define RT5677_GPIO1_OUT_LO			(0x0 << 1)
+#define RT5677_GPIO1_OUT_HI			(0x1 << 1)
+#define RT5677_GPIO1_P_MASK			(0x1 << 0)
+#define RT5677_GPIO1_P_SFT			0
+#define RT5677_GPIO1_P_NOR			(0x0 << 0)
+#define RT5677_GPIO1_P_INV			(0x1 << 0)
+
+/* GPIO Control 3 (0xc2) */
+#define RT5677_GPIO6_DIR_MASK			(0x1 << 2)
+#define RT5677_GPIO6_DIR_SFT			2
+#define RT5677_GPIO6_DIR_IN			(0x0 << 2)
+#define RT5677_GPIO6_DIR_OUT			(0x1 << 2)
+#define RT5677_GPIO6_OUT_MASK			(0x1 << 1)
+#define RT5677_GPIO6_OUT_SFT			1
+#define RT5677_GPIO6_OUT_LO			(0x0 << 1)
+#define RT5677_GPIO6_OUT_HI			(0x1 << 1)
+#define RT5677_GPIO6_P_MASK			(0x1 << 0)
+#define RT5677_GPIO6_P_SFT			0
+#define RT5677_GPIO6_P_NOR			(0x0 << 0)
+#define RT5677_GPIO6_P_INV			(0x1 << 0)
 
 /* Virtual DSP Mixer Control (0xf7 0xf8 0xf9) */
 #define RT5677_DSP_IB_01_H			(0x1 << 15)
@@ -1428,6 +1527,16 @@ enum {
 	RT5677_AIFS,
 };
 
+enum {
+	RT5677_GPIO1,
+	RT5677_GPIO2,
+	RT5677_GPIO3,
+	RT5677_GPIO4,
+	RT5677_GPIO5,
+	RT5677_GPIO6,
+	RT5677_GPIO_NUM,
+};
+
 struct rt5677_priv {
 	struct snd_soc_codec *codec;
 	struct rt5677_platform_data pdata;
@@ -1441,6 +1550,9 @@ struct rt5677_priv {
 	int pll_src;
 	int pll_in;
 	int pll_out;
+#ifdef CONFIG_GPIOLIB
+	struct gpio_chip gpio_chip;
+#endif
 };
 
 #endif /* __RT5677_H__ */
-- 
1.8.1.1.439.g50a6b54
