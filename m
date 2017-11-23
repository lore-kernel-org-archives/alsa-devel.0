From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH v6 12/17] gpio: madera: Support Cirrus Logic
	Madera class codecs
Date: Thu, 23 Nov 2017 17:13:11 +0000
Message-ID: <20171123171316.10868-13-rf@opensource.wolfsonmicro.com>
References: <20171123171316.10868-1-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 98715267356
 for <alsa-devel@alsa-project.org>; Thu, 23 Nov 2017 18:13:28 +0100 (CET)
In-Reply-To: <20171123171316.10868-1-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lee.jones@linaro.org, broonie@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, robh+dt@kernel.org, tglx@linutronix.de, jason@lakedaemon.net
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, Nariman Poushin <nariman@opensource.wolfsonmicro.com>, linux-gpio@vger.kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This adds support for the GPIOs on Cirrus Logic Madera class codecs.
Any pins not used for special functions (see the pinctrl driver) can be
used as general single-bit input or output lines. The number of available
GPIOs varies between codecs.

Signed-off-by: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 MAINTAINERS                |   1 +
 drivers/gpio/Kconfig       |   6 ++
 drivers/gpio/Makefile      |   1 +
 drivers/gpio/gpio-madera.c | 196 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 204 insertions(+)
 create mode 100644 drivers/gpio/gpio-madera.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2c6772f81d88..7f3f2de4cc44 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3490,6 +3490,7 @@ F:	Documentation/devicetree/bindings/mfd/madera.txt
 F:	Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt
 F:	include/linux/irqchip/irq-madera*
 F:	include/linux/mfd/madera/*
+F:	drivers/gpio/gpio-madera*
 F:	drivers/irqchip/irq-madera*
 F:	drivers/mfd/madera*
 F:	drivers/mfd/cs47l*
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index d6a8e851ad13..95e4bbcf9bf7 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -993,6 +993,12 @@ config GPIO_LP87565
 	  This driver can also be built as a module. If so, the module will be
 	  called gpio-lp87565.
 
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
index 4bc24febb889..765125eb7d4c 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_ARCH_LPC32XX)	+= gpio-lpc32xx.o
 obj-$(CONFIG_GPIO_LP873X)	+= gpio-lp873x.o
 obj-$(CONFIG_GPIO_LP87565)	+= gpio-lp87565.o
 obj-$(CONFIG_GPIO_LYNXPOINT)	+= gpio-lynxpoint.o
+obj-$(CONFIG_GPIO_MADERA)	+= gpio-madera.o
 obj-$(CONFIG_GPIO_MAX3191X)	+= gpio-max3191x.o
 obj-$(CONFIG_GPIO_MAX730X)	+= gpio-max730x.o
 obj-$(CONFIG_GPIO_MAX7300)	+= gpio-max7300.o
diff --git a/drivers/gpio/gpio-madera.c b/drivers/gpio/gpio-madera.c
new file mode 100644
index 000000000000..e45905d59238
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
+		madera_gpio->gpio_chip.of_node = madera->dev->of_node;
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
2.11.0
