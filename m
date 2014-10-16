From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: [PATCH] ASoC: rt5677: add GPIO IRQ support
Date: Thu, 16 Oct 2014 11:24:26 -0700
Message-ID: <1413483866-38815-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f74.google.com (mail-pa0-f74.google.com
 [209.85.220.74])
 by alsa0.perex.cz (Postfix) with ESMTP id A8AB52605F6
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 20:24:48 +0200 (CEST)
Received: by mail-pa0-f74.google.com with SMTP id kq14so708264pab.3
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 11:24:47 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, oder_chiou@realtek.com
Cc: alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org

This allows to enable Mic Jack detection feature

Author: Oder Chiou <oder_chiou@realtek.com>
Modified-by: Anatol Pomozov <anatol.pomozov@gmail.com>
Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 Documentation/devicetree/bindings/sound/rt5677.txt |  10 ++
 include/sound/rt5677.h                             |   7 ++
 sound/soc/codecs/rt5677.c                          | 134 +++++++++++++++++++++
 sound/soc/codecs/rt5677.h                          |  49 ++++++++
 4 files changed, 200 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rt5677.txt b/Documentation/devicetree/bindings/sound/rt5677.txt
index f82f0e9..740ff77 100644
--- a/Documentation/devicetree/bindings/sound/rt5677.txt
+++ b/Documentation/devicetree/bindings/sound/rt5677.txt
@@ -33,6 +33,15 @@ Optional properties:
     1 - pull down
     2 - pull up
 
+- realtek,jd1-gpio
+  Configures GPIO Mic Jack detection 1.
+  Select 0 ~ 3 as OFF, GPIO1, GPIO2 and GPIO3 respectively.
+
+- realtek,jd2-gpio
+- realtek,jd3-gpio
+  Configures GPIO Mic Jack detection 2 and 3.
+  Select 0 ~ 3 as OFF, GPIO4, GPIO5 and GPIO6 respectively.
+
 Pins on the device (for linking into audio routes):
 
   * IN1P
@@ -63,4 +72,5 @@ rt5677 {
 		<&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
 	realtek,in1-differential = "true";
 	realtek,gpio-config = /bits/ 8  <0 0 0 0 0 2>;   /* pull up GPIO6 */
+	realtek,jd2-gpio = <3>;  /* Enables Jack detection for GPIO6 */
 };
diff --git a/include/sound/rt5677.h b/include/sound/rt5677.h
index a56b429..d9eb7d8 100644
--- a/include/sound/rt5677.h
+++ b/include/sound/rt5677.h
@@ -30,6 +30,13 @@ struct rt5677_platform_data {
 
 	/* configures GPIO, 0 - floating, 1 - pulldown, 2 - pullup */
 	u8 gpio_config[6];
+
+	/* jd1 can select 0 ~ 3 as OFF, GPIO1, GPIO2 and GPIO3 respectively */
+	unsigned int jd1_gpio;
+	/* jd2 and jd3 can select 0 ~ 3 as
+		OFF, GPIO4, GPIO5 and GPIO6 respectively */
+	unsigned int jd2_gpio;
+	unsigned int jd3_gpio;
 };
 
 #endif
diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index f6df276..1f5897f 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -3614,6 +3614,46 @@ static void rt5677_gpio_config(struct rt5677_priv *rt5677, unsigned offset,
 	}
 }
 
+static int rt5677_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	struct rt5677_priv *rt5677 = gpio_to_rt5677(chip);
+	struct regmap_irq_chip_data *data = rt5677->irq_data;
+	int irq;
+
+	if (offset >= RT5677_GPIO1 && offset <= RT5677_GPIO3) {
+		if ((rt5677->pdata.jd1_gpio == 1 && offset == RT5677_GPIO1) ||
+			(rt5677->pdata.jd1_gpio == 2 &&
+				offset == RT5677_GPIO2) ||
+			(rt5677->pdata.jd1_gpio == 3 &&
+				offset == RT5677_GPIO3)) {
+			irq = RT5677_IRQ_JD1;
+		} else {
+			return -ENXIO;
+		}
+	}
+
+	if (offset >= RT5677_GPIO4 && offset <= RT5677_GPIO6) {
+		if ((rt5677->pdata.jd2_gpio == 1 && offset == RT5677_GPIO4) ||
+			(rt5677->pdata.jd2_gpio == 2 &&
+				offset == RT5677_GPIO5) ||
+			(rt5677->pdata.jd2_gpio == 3 &&
+				offset == RT5677_GPIO6)) {
+			irq = RT5677_IRQ_JD2;
+		} else if ((rt5677->pdata.jd3_gpio == 1 &&
+				offset == RT5677_GPIO4) ||
+			(rt5677->pdata.jd3_gpio == 2 &&
+				offset == RT5677_GPIO5) ||
+			(rt5677->pdata.jd3_gpio == 3 &&
+				offset == RT5677_GPIO6)) {
+			irq = RT5677_IRQ_JD3;
+		} else {
+			return -ENXIO;
+		}
+	}
+
+	return regmap_irq_get_virq(data, irq);
+}
+
 static struct gpio_chip rt5677_template_chip = {
 	.label			= "rt5677",
 	.owner			= THIS_MODULE,
@@ -3621,6 +3661,7 @@ static struct gpio_chip rt5677_template_chip = {
 	.set			= rt5677_gpio_set,
 	.direction_input	= rt5677_gpio_direction_in,
 	.get			= rt5677_gpio_get,
+	.to_irq			= rt5677_to_irq,
 	.can_sleep		= 1,
 };
 
@@ -3688,6 +3729,31 @@ static int rt5677_probe(struct snd_soc_codec *codec)
 	for (i = 0; i < RT5677_GPIO_NUM; i++)
 		rt5677_gpio_config(rt5677, i, rt5677->pdata.gpio_config[i]);
 
+	if (rt5677->irq_data) {
+		regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL1, 0x8000,
+			0x8000);
+		regmap_update_bits(rt5677->regmap, RT5677_DIG_MISC, 0x0018,
+			0x0008);
+
+		if (rt5677->pdata.jd1_gpio)
+			regmap_update_bits(rt5677->regmap, RT5677_JD_CTRL1,
+				RT5677_SEL_GPIO_JD1_MASK,
+				rt5677->pdata.jd1_gpio <<
+				RT5677_SEL_GPIO_JD1_SFT);
+
+		if (rt5677->pdata.jd2_gpio)
+			regmap_update_bits(rt5677->regmap, RT5677_JD_CTRL1,
+				RT5677_SEL_GPIO_JD2_MASK,
+				rt5677->pdata.jd2_gpio <<
+				RT5677_SEL_GPIO_JD2_SFT);
+
+		if (rt5677->pdata.jd3_gpio)
+			regmap_update_bits(rt5677->regmap, RT5677_JD_CTRL1,
+				RT5677_SEL_GPIO_JD3_MASK,
+				rt5677->pdata.jd3_gpio <<
+				RT5677_SEL_GPIO_JD3_SFT);
+	}
+
 	mutex_init(&rt5677->dsp_cmd_lock);
 
 	return 0;
@@ -3918,9 +3984,74 @@ static int rt5677_parse_dt(struct rt5677_priv *rt5677, struct device_node *np)
 	of_property_read_u8_array(np, "realtek,gpio-config",
 		rt5677->pdata.gpio_config, RT5677_GPIO_NUM);
 
+	of_property_read_u32(np, "realtek,jd1-gpio", &rt5677->pdata.jd1_gpio);
+	of_property_read_u32(np, "realtek,jd2-gpio", &rt5677->pdata.jd2_gpio);
+	of_property_read_u32(np, "realtek,jd3-gpio", &rt5677->pdata.jd3_gpio);
+
 	return 0;
 }
 
+static struct regmap_irq rt5677_irqs[] = {
+	[RT5677_IRQ_JD1] = {
+		.reg_offset = 0,
+		.mask = RT5677_EN_IRQ_GPIO_JD1,
+	},
+	[RT5677_IRQ_JD2] = {
+		.reg_offset = 0,
+		.mask = RT5677_EN_IRQ_GPIO_JD2,
+	},
+	[RT5677_IRQ_JD3] = {
+		.reg_offset = 0,
+		.mask = RT5677_EN_IRQ_GPIO_JD3,
+	},
+};
+
+static struct regmap_irq_chip rt5677_irq_chip = {
+	.name = "rt5677",
+	.irqs = rt5677_irqs,
+	.num_irqs = ARRAY_SIZE(rt5677_irqs),
+
+	.num_regs = 1,
+	.status_base = RT5677_IRQ_CTRL1,
+	.mask_base = RT5677_IRQ_CTRL1,
+	.mask_invert = 1,
+};
+
+int rt5677_irq_init(struct i2c_client *i2c)
+{
+	int ret;
+	struct rt5677_priv *rt5677 = i2c_get_clientdata(i2c);
+
+	if (!rt5677->pdata.jd1_gpio &&
+		!rt5677->pdata.jd2_gpio &&
+		!rt5677->pdata.jd3_gpio)
+		return 0;
+
+	if (!i2c->irq) {
+		dev_err(&i2c->dev, "No interrupt specified\n");
+		return -EINVAL;
+	}
+
+	ret = regmap_add_irq_chip(rt5677->regmap, i2c->irq,
+		IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT, 0,
+		&rt5677_irq_chip, &rt5677->irq_data);
+
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to register IRQ chip: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+void rt5677_irq_exit(struct i2c_client *i2c)
+{
+	struct rt5677_priv *rt5677 = i2c_get_clientdata(i2c);
+
+	if (rt5677->irq_data)
+		regmap_del_irq_chip(i2c->irq, rt5677->irq_data);
+}
+
 static int rt5677_i2c_probe(struct i2c_client *i2c,
 		    const struct i2c_device_id *id)
 {
@@ -4018,6 +4149,7 @@ static int rt5677_i2c_probe(struct i2c_client *i2c,
 	}
 
 	rt5677_init_gpio(i2c);
+	rt5677_irq_init(i2c);
 
 	return snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5677,
 				      rt5677_dai, ARRAY_SIZE(rt5677_dai));
@@ -4025,6 +4157,8 @@ static int rt5677_i2c_probe(struct i2c_client *i2c,
 
 static int rt5677_i2c_remove(struct i2c_client *i2c)
 {
+	rt5677_irq_exit(i2c);
+
 	snd_soc_unregister_codec(&i2c->dev);
 	rt5677_free_gpio(i2c);
 
diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
index 20efa4a..d2c743c 100644
--- a/sound/soc/codecs/rt5677.h
+++ b/sound/soc/codecs/rt5677.h
@@ -1368,6 +1368,48 @@
 #define RT5677_SEL_SRC_IB01			(0x1 << 0)
 #define RT5677_SEL_SRC_IB01_SFT			0
 
+/* Jack Detect Control 1 (0xb5) */
+#define RT5677_SEL_GPIO_JD1_MASK		(0x3 << 14)
+#define RT5677_SEL_GPIO_JD1_SFT			14
+#define RT5677_SEL_GPIO_JD2_MASK		(0x3 << 12)
+#define RT5677_SEL_GPIO_JD2_SFT			12
+#define RT5677_SEL_GPIO_JD3_MASK		(0x3 << 10)
+#define RT5677_SEL_GPIO_JD3_SFT			10
+
+/* IRQ Control 1 (0xbd) */
+#define RT5677_STA_GPIO_JD1			(0x1 << 15)
+#define RT5677_STA_GPIO_JD1_SFT			15
+#define RT5677_EN_IRQ_GPIO_JD1			(0x1 << 14)
+#define RT5677_EN_IRQ_GPIO_JD1_SFT		14
+#define RT5677_EN_GPIO_JD1_STICKY		(0x1 << 13)
+#define RT5677_EN_GPIO_JD1_STICKY_SFT		13
+#define RT5677_INV_GPIO_JD1			(0x1 << 12)
+#define RT5677_INV_GPIO_JD1_SFT			12
+#define RT5677_STA_GPIO_JD2			(0x1 << 11)
+#define RT5677_STA_GPIO_JD2_SFT			11
+#define RT5677_EN_IRQ_GPIO_JD2			(0x1 << 10)
+#define RT5677_EN_IRQ_GPIO_JD2_SFT		10
+#define RT5677_EN_GPIO_JD2_STICKY		(0x1 << 9)
+#define RT5677_EN_GPIO_JD2_STICKY_SFT		9
+#define RT5677_INV_GPIO_JD2			(0x1 << 8)
+#define RT5677_INV_GPIO_JD2_SFT			8
+#define RT5677_STA_MICBIAS1_OVCD		(0x1 << 7)
+#define RT5677_STA_MICBIAS1_OVCD_SFT		7
+#define RT5677_EN_IRQ_MICBIAS1_OVCD		(0x1 << 6)
+#define RT5677_EN_IRQ_MICBIAS1_OVCD_SFT		6
+#define RT5677_EN_MICBIAS1_OVCD_STICKY		(0x1 << 5)
+#define RT5677_EN_MICBIAS1_OVCD_STICKY_SFT	5
+#define RT5677_INV_MICBIAS1_OVCD		(0x1 << 4)
+#define RT5677_INV_MICBIAS1_OVCD_SFT		4
+#define RT5677_STA_GPIO_JD3			(0x1 << 3)
+#define RT5677_STA_GPIO_JD3_SFT			3
+#define RT5677_EN_IRQ_GPIO_JD3			(0x1 << 2)
+#define RT5677_EN_IRQ_GPIO_JD3_SFT		2
+#define RT5677_EN_GPIO_JD3_STICKY		(0x1 << 1)
+#define RT5677_EN_GPIO_JD3_STICKY_SFT		1
+#define RT5677_INV_GPIO_JD3			(0x1 << 0)
+#define RT5677_INV_GPIO_JD3_SFT			0
+
 /* GPIO status (0xbf) */
 #define RT5677_GPIO6_STATUS_MASK		(0x1 << 5)
 #define RT5677_GPIO6_STATUS_SFT			5
@@ -1545,6 +1587,12 @@ enum {
 	RT5677_GPIO_NUM,
 };
 
+enum {
+	RT5677_IRQ_JD1,
+	RT5677_IRQ_JD2,
+	RT5677_IRQ_JD3,
+};
+
 struct rt5677_priv {
 	struct snd_soc_codec *codec;
 	struct rt5677_platform_data pdata;
@@ -1565,6 +1613,7 @@ struct rt5677_priv {
 	struct gpio_chip gpio_chip;
 #endif
 	bool dsp_vad_en;
+	struct regmap_irq_chip_data *irq_data;
 };
 
 #endif /* __RT5677_H__ */
-- 
2.1.0.rc2.206.gedb03e5
