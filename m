From: Dylan Reid <dgreid@chromium.org>
Subject: [RFC 3/5] ASoC: Add GPIO based jack device
Date: Fri, 22 May 2015 15:09:21 -0700
Message-ID: <1432332563-15447-4-git-send-email-dgreid@chromium.org>
References: <1432332563-15447-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vn0-f73.google.com (mail-vn0-f73.google.com
 [209.85.216.73])
 by alsa0.perex.cz (Postfix) with ESMTP id CD0B126042F
 for <alsa-devel@alsa-project.org>; Sat, 23 May 2015 00:10:55 +0200 (CEST)
Received: by vnbf129 with SMTP id f129so1014789vnb.1
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2015 15:10:54 -0700 (PDT)
In-Reply-To: <1432332563-15447-1-git-send-email-dgreid@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: lars@metafoo.de, zhengxing@rock-chips.com, tiwai@suse.de, lgirdwood@gmail.com, broonie@kernel.org, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

Add a jack device that allows for separate headphone and mic detect
GPIOs.  This device will be used as an aux device and will registered
the jack with the card at init time.

The gpios are each optional allowing for a headphone, microphone, or
combination devices to be created depending on the board configuration.
A board will be able to have several of these jacks, one for each
physical connection.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 .../devicetree/bindings/sound/gpio-audio-jack.txt  |  39 +++++
 sound/soc/codecs/Kconfig                           |   4 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/gpio-audio-jack.c                 | 191 +++++++++++++++++++++
 4 files changed, 236 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/gpio-audio-jack.txt
 create mode 100644 sound/soc/codecs/gpio-audio-jack.c

diff --git a/Documentation/devicetree/bindings/sound/gpio-audio-jack.txt b/Documentation/devicetree/bindings/sound/gpio-audio-jack.txt
new file mode 100644
index 0000000..17a4501
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/gpio-audio-jack.txt
@@ -0,0 +1,39 @@
+Gpio-Audio-Jack:
+
+GPIO based audio jacks.  This can represent a headphone, mic, or combo jack.
+
+Required properties:
+
+- compatible				: "gpio-audio-jack"
+
+Optional properties:
+
+- gpio-audio-jack,jack-name		: Name of the jack. Normally
+					  'Headphone Jack', 'Mic Jack', or
+					  'Headset Jack'
+- gpio-audio-jack,sw-det-gpios		: Reference to GPIOs that signals when
+					  a jack is plugged.
+- gpio-audio-jack,gpio-names		: Names of the GPIOs. Must provide one
+					  per sw-det-gpio entry.
+- gpio-audio-jack,report-masks		: Jack report mask from
+					  dt-bindings/sound/audio-jack-events.h.
+					  Must have one per sw-det-gpio entry.
+- gpio-audio-jack,debounce-times	: Debounce time for each sw-det-gpio
+					  entry.
+
+Example of Headphone/Mic combo jack:
+
+audio_jack: gpio-audio-jack {
+	compatible = "gpio-audio-jack";
+	gpio-audio-jack,jack-name = "Headset Jack";
+	gpio-audio-jack,sw-det-gpios =
+			<&gpio TEGRA_GPIO(I, 7) GPIO_ACTIVE_HIGH>,
+			<&gpio TEGRA_GPIO(R, 7) GPIO_ACTIVE_LOW>;
+	gpio-audio-jack,gpio-names = "Headphones", "Mic Jack";
+	gpio-audio-jack,report-masks = <JACK_HEADPHONE>, <JACK_MICROPHONE>;
+	gpio-audio-jack,debounce-times = <150>, <150>;
+};
+
+sound {
+	nvidia,headset-dev = <&audio_jack>;
+	...
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 061c465..c9e96a7 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -62,6 +62,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_BT_SCO
 	select SND_SOC_ES8328_SPI if SPI_MASTER
 	select SND_SOC_ES8328_I2C if I2C
+	select SND_SOC_GPIO_AUDIO_JACK
 	select SND_SOC_ISABELLE if I2C
 	select SND_SOC_JZ4740_CODEC
 	select SND_SOC_LM4857 if I2C
@@ -444,6 +445,9 @@ config SND_SOC_ES8328_SPI
 	tristate
 	select SND_SOC_ES8328
 
+config SND_SOC_GPIO_AUDIO_JACK
+        tristate "GPIO based audio jack detection"
+
 config SND_SOC_ISABELLE
         tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index abe2d7e..ae570f5 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -55,6 +55,7 @@ snd-soc-dmic-objs := dmic.o
 snd-soc-es8328-objs := es8328.o
 snd-soc-es8328-i2c-objs := es8328-i2c.o
 snd-soc-es8328-spi-objs := es8328-spi.o
+snd-soc-gpio-audio-jack-objs := gpio-audio-jack.o
 snd-soc-isabelle-objs := isabelle.o
 snd-soc-jz4740-codec-objs := jz4740.o
 snd-soc-l3-objs := l3.o
@@ -240,6 +241,7 @@ obj-$(CONFIG_SND_SOC_DMIC)	+= snd-soc-dmic.o
 obj-$(CONFIG_SND_SOC_ES8328)	+= snd-soc-es8328.o
 obj-$(CONFIG_SND_SOC_ES8328_I2C)+= snd-soc-es8328-i2c.o
 obj-$(CONFIG_SND_SOC_ES8328_SPI)+= snd-soc-es8328-spi.o
+obj-$(CONFIG_SND_SOC_GPIO_AUDIO_JACK)	+= snd-soc-gpio-audio-jack.o
 obj-$(CONFIG_SND_SOC_ISABELLE)	+= snd-soc-isabelle.o
 obj-$(CONFIG_SND_SOC_JZ4740_CODEC)	+= snd-soc-jz4740-codec.o
 obj-$(CONFIG_SND_SOC_L3)	+= snd-soc-l3.o
diff --git a/sound/soc/codecs/gpio-audio-jack.c b/sound/soc/codecs/gpio-audio-jack.c
new file mode 100644
index 0000000..61662cf
--- /dev/null
+++ b/sound/soc/codecs/gpio-audio-jack.c
@@ -0,0 +1,191 @@
+/*
+ * GPIO based audio jack detection
+ *
+ * Copyright (C) 2015 Google, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/gpio.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <dt-bindings/sound/audio-jack-events.h>
+
+#include <sound/core.h>
+#include <sound/jack.h>
+#include <sound/soc.h>
+
+#define JACK_NAME_CON_ID "gpio-audio-jack,jack-name"
+#define GPIO_CON_ID "gpio-audio-jack,sw-det"
+#define NAME_CON_ID "gpio-audio-jack,gpio-names"
+#define REPORT_MASK_CON_ID "gpio-audio-jack,report-masks"
+#define DEBOUNCE_CON_ID "gpio-audio-jack,debounce-times"
+
+struct gpio_audio_jack {
+	struct snd_soc_component_driver component_drv;
+	struct snd_soc_jack jack;
+	struct snd_soc_jack_gpio *gpios;
+	int gpio_count;
+};
+
+static int dt_jack_to_alsa_report(int dt_jack)
+{
+	switch (dt_jack) {
+	case JACK_HEADPHONE:
+		return SND_JACK_HEADPHONE;
+	case JACK_MICROPHONE:
+		return SND_JACK_MICROPHONE;
+	case JACK_LINEOUT:
+		return SND_JACK_LINEOUT;
+	case JACK_LINEIN:
+		return SND_JACK_LINEIN;
+	default:
+		return 0;
+	}
+}
+
+static int gpio_audio_component_probe(struct snd_soc_component *component)
+{
+	struct device *dev = component->dev;
+	struct gpio_audio_jack *priv = container_of(component->driver,
+			struct gpio_audio_jack, component_drv);
+	const char *jack_name;
+	const char **gpio_names;
+	u32 *debounce;
+	u32 *gpio_report;
+	int report_mask = 0;
+	int ret;
+	int i;
+
+	ret = device_property_read_string(dev, JACK_NAME_CON_ID, &jack_name);
+	if (ret < 0) {
+		dev_err(dev, "Failed to read jack name %d\n", ret);
+		return ret;
+	}
+
+	priv->gpio_count = gpiod_count(dev, GPIO_CON_ID);
+	if (priv->gpio_count <= 0)
+		return priv->gpio_count;
+
+	gpio_names = devm_kzalloc(dev, sizeof(*gpio_names) * priv->gpio_count,
+				  GFP_KERNEL);
+	if (!gpio_names)
+		return -ENOMEM;
+	gpio_report = devm_kzalloc(dev, sizeof(*gpio_report) * priv->gpio_count,
+				   GFP_KERNEL);
+	if (!gpio_report)
+		return -ENOMEM;
+	debounce = devm_kzalloc(dev, sizeof(*debounce) * priv->gpio_count,
+				GFP_KERNEL);
+	if (!debounce)
+		return -ENOMEM;
+	priv->gpios = devm_kzalloc(dev,
+			sizeof(*priv->gpios) * priv->gpio_count, GFP_KERNEL);
+	if (!priv->gpios)
+		return -ENOMEM;
+
+	ret = device_property_read_string_array(dev, NAME_CON_ID, gpio_names,
+						priv->gpio_count);
+	if (ret < 0) {
+		dev_err(dev, "Failed to read gpio names %d\n", ret);
+		return ret;
+	}
+
+	ret = device_property_read_u32_array(dev, REPORT_MASK_CON_ID,
+					     gpio_report, priv->gpio_count);
+	if (ret < 0) {
+		dev_err(dev, "Failed to read gpio masks %d\n", ret);
+		return ret;
+	}
+
+	ret = device_property_read_u32_array(dev, DEBOUNCE_CON_ID,
+					     debounce, priv->gpio_count);
+	if (ret < 0) {
+		dev_err(dev, "Failed to read gpio debounce times %d\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < priv->gpio_count; i++) {
+		priv->gpios[i].desc = gpiod_get_index(dev, GPIO_CON_ID,
+						      i, GPIOD_IN);
+		if (IS_ERR(priv->gpios[i].desc)) {
+			ret = PTR_ERR(priv->gpios[i].desc);
+			dev_err(priv->gpios[i].gpiod_dev,
+				"Cannot get jack gpio at index %d: %d",
+				i, ret);
+			goto gpio_err;
+		}
+
+		priv->gpios[i].name = gpio_names[i];
+		priv->gpios[i].report = dt_jack_to_alsa_report(gpio_report[i]);
+		priv->gpios[i].debounce_time = debounce[i];
+		report_mask |= gpio_report[i];
+	}
+
+	snd_soc_card_jack_new(component->card, jack_name, report_mask,
+			      &priv->jack, NULL, 0);
+
+	devm_kfree(dev, gpio_names);
+	devm_kfree(dev, gpio_report);
+	devm_kfree(dev, debounce);
+
+	return snd_soc_jack_add_gpiods(dev, &priv->jack,
+				       priv->gpio_count, priv->gpios);
+
+gpio_err:
+	for (i = 0; i < priv->gpio_count; i++) {
+		if (!IS_ERR(priv->gpios[i].desc))
+			gpiod_put(priv->gpios[i].desc);
+	}
+	return ret;
+}
+
+static void gpio_audio_component_remove(struct snd_soc_component *component)
+{
+	struct gpio_audio_jack *priv = container_of(component->driver,
+			struct gpio_audio_jack, component_drv);
+	int i;
+
+	for (i = 0; i < priv->gpio_count; i++) {
+		if (!IS_ERR(priv->gpios[i].desc))
+			gpiod_put(priv->gpios[i].desc);
+	}
+}
+
+static int gpio_audio_jack_probe(struct platform_device *pdev)
+{
+	struct gpio_audio_jack *priv;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	dev_set_drvdata(&pdev->dev, priv);
+
+	priv->component_drv.probe = gpio_audio_component_probe;
+	priv->component_drv.remove = gpio_audio_component_remove;
+
+	return devm_snd_soc_register_component(&pdev->dev, &priv->component_drv,
+					       NULL, 0);
+}
+
+static const struct of_device_id gpio_audio_of_match[] = {
+	{ .compatible = "gpio-audio-jack", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, gpio_audio_of_match);
+
+static struct platform_driver gpio_audio_jack = {
+	.driver = {
+		.name = "gpio-audio-jack",
+		.of_match_table = gpio_audio_of_match,
+	},
+	.probe = gpio_audio_jack_probe,
+};
+module_platform_driver(gpio_audio_jack);
+
+MODULE_DESCRIPTION("ASoC GPIO audio jack driver");
+MODULE_AUTHOR("Dylan Reid <dgreid@chromium.org>");
+MODULE_LICENSE("GPL v2");
-- 
2.2.1.62.g3f15098
