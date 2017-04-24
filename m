From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH v2 12/18] gpio: madera: Support Cirrus Logic Madera class codecs
Date: Mon, 24 Apr 2017 17:08:38 +0100
Message-ID: <1493050124-5970-13-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1493050124-5970-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1493050124-5970-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-gpio-owner@vger.kernel.org
To: lee.jones@linaro.org, broonie@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, robh+dt@kernel.org, tglx@linutronix.de, jason@lakedaemon.net
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This adds support for the GPIOs on Cirrus Logic Madera class codecs.
Any pins not used for special functions (see the pinctrl driver) can be
used as general single-bit input or output lines. The number of available
GPIOs varies between codecs.

Signed-off-by: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
Changes from V1:
- dt bindings moved to a separate patch
- dependent on pinctrl driver instead of parent MFD
- added get_direction function
- added .request / .free / .set_config to work with pinctrl driver
- register range with pinctrl driver

 MAINTAINERS                |   2 +
 drivers/gpio/Kconfig       |   6 ++
 drivers/gpio/Makefile      |   1 +
 drivers/gpio/gpio-madera.c | 196 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 205 insertions(+)
 create mode 100644 drivers/gpio/gpio-madera.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e42a03..66c5263 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3304,10 +3304,12 @@ L:	patches@opensource.wolfsonmicro.com
 T:	git https://github.com/CirrusLogic/linux-drivers.git
 W:	https://github.com/CirrusLogic/linux-drivers/wiki
 S:	Supported
+F:	Documentation/devicetree/bindings/gpio/gpio-madera.txt
 F:	Documentation/devicetree/bindings/mfd/madera.txt
 F:	Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt
 F:	include/linux/irqchip/irq-madera*
 F:	include/linux/mfd/madera/*
+F:	drivers/gpio/gpio-madera*
 F:	drivers/irqchip/irq-madera*
 F:	drivers/mfd/madera*
 F:	drivers/mfd/cs47l*
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 05e8fbf..9488abe 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -941,6 +941,12 @@ config GPIO_LP873X
 	  This driver can also be built as a module. If so, the module will be
           called gpio-lp873x.
 
+config GPIO_MADERA
+	bool "Cirrus Logic Madera class codecs"
+	depends on PINCTRL_MADERA
+	help
+	  Support for GPIOs on Cirrus Logic Madera class codecs.
+
 config GPIO_MAX77620
 	tristate "GPIO support for PMIC MAX77620 and MAX20024"
 	depends on MFD_MAX77620
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 095598e..d4b6c30 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_GPIO_LPC18XX)	+= gpio-lpc18xx.o
 obj-$(CONFIG_ARCH_LPC32XX)	+= gpio-lpc32xx.o
 obj-$(CONFIG_GPIO_LP873X)	+= gpio-lp873x.o
 obj-$(CONFIG_GPIO_LYNXPOINT)	+= gpio-lynxpoint.o
+obj-$(CONFIG_GPIO_MADERA)	+= gpio-madera.o
 obj-$(CONFIG_GPIO_MAX730X)	+= gpio-max730x.o
 obj-$(CONFIG_GPIO_MAX7300)	+= gpio-max7300.o
 obj-$(CONFIG_GPIO_MAX7301)	+= gpio-max7301.o
diff --git a/drivers/gpio/gpio-madera.c b/drivers/gpio/gpio-madera.c
new file mode 100644
index 0000000..37ac706
--- /dev/null
+++ b/drivers/gpio/gpio-madera.c
@@ -0,0 +1,196 @@
+/*
+ * GPIO support for Cirrus Logic Madera codecs
+ *
+ * Copyright 2015-2017 Cirrus Logic
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/device.h>
+#include <linux/gpio.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <linux/mfd/madera/core.h>
+#include <linux/mfd/madera/pdata.h>
+#include <linux/mfd/madera/registers.h>
+
+struct madera_gpio {
+	struct madera *madera;
+	struct gpio_chip gpio_chip;
+};
+
+static int madera_gpio_get_direction(struct gpio_chip *chip,
+				     unsigned int offset)
+{
+	struct madera_gpio *madera_gpio = gpiochip_get_data(chip);
+	struct madera *madera = madera_gpio->madera;
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(madera->regmap,
+			  MADERA_GPIO1_CTRL_2 + (2 * offset), &val);
+	if (ret < 0)
+		return ret;
+
+	return (val & MADERA_GP1_DIR_MASK) >> MADERA_GP1_DIR_SHIFT;
+}
+
+static int madera_gpio_direction_in(struct gpio_chip *chip, unsigned int offset)
+{
+	struct madera_gpio *madera_gpio = gpiochip_get_data(chip);
+	struct madera *madera = madera_gpio->madera;
+
+	return regmap_update_bits(madera->regmap,
+				  MADERA_GPIO1_CTRL_2 + (2 * offset),
+				  MADERA_GP1_DIR_MASK, MADERA_GP1_DIR);
+}
+
+static int madera_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct madera_gpio *madera_gpio = gpiochip_get_data(chip);
+	struct madera *madera = madera_gpio->madera;
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(madera->regmap,
+			  MADERA_GPIO1_CTRL_1 + (2 * offset), &val);
+	if (ret < 0)
+		return ret;
+
+	return !!(val & MADERA_GP1_LVL_MASK);
+}
+
+static int madera_gpio_direction_out(struct gpio_chip *chip,
+				     unsigned int offset, int value)
+{
+	struct madera_gpio *madera_gpio = gpiochip_get_data(chip);
+	struct madera *madera = madera_gpio->madera;
+	unsigned int regval;
+	int ret;
+
+	if (value)
+		regval = MADERA_GP1_LVL;
+	else
+		regval = 0;
+
+	ret = regmap_update_bits(madera->regmap,
+				 MADERA_GPIO1_CTRL_2 + (2 * offset),
+				 MADERA_GP1_DIR_MASK, 0);
+	if (ret < 0)
+		return ret;
+
+	return regmap_update_bits(madera->regmap,
+				  MADERA_GPIO1_CTRL_1 + (2 * offset),
+				  MADERA_GP1_LVL_MASK, regval);
+}
+
+static void madera_gpio_set(struct gpio_chip *chip, unsigned int offset,
+			    int value)
+{
+	struct madera_gpio *madera_gpio = gpiochip_get_data(chip);
+	struct madera *madera = madera_gpio->madera;
+	unsigned int regval;
+	int ret;
+
+	if (value)
+		regval = MADERA_GP1_LVL;
+	else
+		regval = 0;
+
+	ret = regmap_update_bits(madera->regmap,
+				 MADERA_GPIO1_CTRL_1 + (2 * offset),
+				 MADERA_GP1_LVL_MASK, regval);
+	if (ret)
+		dev_warn(madera->dev, "Failed to write to 0x%x (%d)\n",
+			 MADERA_GPIO1_CTRL_1 + (2 * offset), ret);
+}
+
+static struct gpio_chip template_chip = {
+	.label			= "madera",
+	.owner			= THIS_MODULE,
+	.request		= gpiochip_generic_request,
+	.free			= gpiochip_generic_free,
+	.get_direction		= madera_gpio_get_direction,
+	.direction_input	= madera_gpio_direction_in,
+	.get			= madera_gpio_get,
+	.direction_output	= madera_gpio_direction_out,
+	.set			= madera_gpio_set,
+	.set_config		= gpiochip_generic_config,
+	.can_sleep		= true,
+};
+
+static int madera_gpio_probe(struct platform_device *pdev)
+{
+	struct madera *madera = dev_get_drvdata(pdev->dev.parent);
+	struct madera_pdata *pdata = dev_get_platdata(madera->dev);
+	struct madera_gpio *madera_gpio;
+	int ret;
+
+	madera_gpio = devm_kzalloc(&pdev->dev, sizeof(*madera_gpio),
+				   GFP_KERNEL);
+	if (!madera_gpio)
+		return -ENOMEM;
+
+	madera_gpio->madera = madera;
+	madera_gpio->gpio_chip = template_chip;
+	madera_gpio->gpio_chip.parent = &pdev->dev;
+
+	if (IS_ENABLED(CONFIG_OF_GPIO))
+		madera_gpio->gpio_chip.of_node = pdev->dev.of_node;
+
+	switch (madera->type) {
+	case CS47L35:
+		madera_gpio->gpio_chip.ngpio = CS47L35_NUM_GPIOS;
+		break;
+	case CS47L85:
+	case WM1840:
+		madera_gpio->gpio_chip.ngpio = CS47L85_NUM_GPIOS;
+		break;
+	case CS47L90:
+	case CS47L91:
+		madera_gpio->gpio_chip.ngpio = CS47L90_NUM_GPIOS;
+		break;
+	default:
+		dev_err(&pdev->dev, "Unknown chip variant %d\n", madera->type);
+		return -EINVAL;
+	}
+
+	if (pdata && pdata->gpio_base)
+		madera_gpio->gpio_chip.base = pdata->gpio_base;
+	else
+		madera_gpio->gpio_chip.base = -1;
+
+	ret = devm_gpiochip_add_data(&pdev->dev, &madera_gpio->gpio_chip,
+				     madera_gpio);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Could not register gpiochip, %d\n", ret);
+		return ret;
+	}
+
+	ret = gpiochip_add_pin_range(&madera_gpio->gpio_chip, "madera-pinctrl",
+				     0, 0, madera_gpio->gpio_chip.ngpio);
+	if (ret) {
+		dev_warn(&pdev->dev, "Failed to add pin range (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct platform_driver madera_gpio_driver = {
+	.driver.name	= "madera-gpio",
+	.driver.owner	= THIS_MODULE,
+	.probe		= madera_gpio_probe,
+};
+
+module_platform_driver(madera_gpio_driver);
+
+MODULE_DESCRIPTION("GPIO interface for Madera codecs");
+MODULE_AUTHOR("Nariman Poushin <nariman@opensource.wolfsonmicro.com>");
+MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.wolfsonmicro.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:madera-gpio");
-- 
1.9.1

