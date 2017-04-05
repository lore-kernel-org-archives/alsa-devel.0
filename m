From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 10/16] gpio: madera: Support Cirrus Logic
	Madera class codecs
Date: Wed, 5 Apr 2017 11:07:58 +0100
Message-ID: <1491386884-30689-11-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1491386884-30689-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A04D267019
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 12:08:11 +0200 (CEST)
In-Reply-To: <1491386884-30689-1-git-send-email-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linus.walleij@linaro.org, gnurou@gmail.com, robh+dt@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, lee.jones@linaro.org, broonie@kernel.org
Cc: linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This adds support for the GPIOs on Cirrus Logic Madera class codecs.

Signed-off-by: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 .../devicetree/bindings/gpio/gpio-madera.txt       |  24 +++
 MAINTAINERS                                        |   2 +
 drivers/gpio/Kconfig                               |   6 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-madera.c                         | 173 +++++++++++++++++++++
 5 files changed, 206 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-madera.txt
 create mode 100644 drivers/gpio/gpio-madera.c

diff --git a/Documentation/devicetree/bindings/gpio/gpio-madera.txt b/Documentation/devicetree/bindings/gpio/gpio-madera.txt
new file mode 100644
index 0000000..eb01c6d
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-madera.txt
@@ -0,0 +1,24 @@
+Cirrus Logic Madera class audio codecs gpio driver
+
+This is a subnode of the parent mfd node.
+
+See also the core bindings for the parent MFD driver:
+See Documentation/devicetree/bindings/mfd/madera.txt
+
+Required properties:
+  - compatible : must be "cirrus,madera-gpio"
+  - gpio-controller : Indicates this device is a GPIO controller.
+  - #gpio-cells : Must be 2. The first cell is the pin number. The second cell
+    is reserved for future use and must be zero
+
+Example:
+
+codec: cs47l85@0 {
+	compatible = "cirrus,cs47l85";
+
+	gpio {
+		compatible = "cirrus,madera-gpio";
+		gpio-controller;
+		#gpio-cells = <2>;
+	}
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 85af1f9..0183692 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3266,6 +3266,7 @@ L:	patches@opensource.wolfsonmicro.com
 T:	git https://github.com/CirrusLogic/linux-drivers.git
 W:	https://github.com/CirrusLogic/linux-drivers/wiki
 S:	Supported
+F:	Documentation/devicetree/bindings/gpio/gpio-madera.txt
 F:	Documentation/devicetree/bindings/interrupt-controller/cirrus,madera.txt
 F:	Documentation/devicetree/bindings/mfd/madera.txt
 F:	Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt
@@ -3273,6 +3274,7 @@ F:	Documentation/devicetree/bindings/regulator/madera*
 F:	include/linux/irqchip/irq-madera*
 F:	include/linux/mfd/madera/*
 F:	include/linux/regulator/madera*
+F:	drivers/gpio/gpio-madera*
 F:	drivers/irqchip/irq-madera*
 F:	drivers/mfd/madera*
 F:	drivers/mfd/cs47l*
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 63ceed2..1386728 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -844,6 +844,12 @@ config GPIO_ARIZONA
 	help
 	  Support for GPIOs on Wolfson Arizona class devices.
 
+config GPIO_MADERA
+	tristate "Cirrus Logic Madera class codecs"
+	depends on MFD_MADERA
+	help
+	  Support for GPIOs on Cirrus Logic Madera class codecs.
+
 config GPIO_CRYSTAL_COVE
 	tristate "GPIO support for Crystal Cove PMIC"
 	depends on (X86 || COMPILE_TEST) && INTEL_SOC_PMIC
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
index 0000000..b4fa082
--- /dev/null
+++ b/drivers/gpio/gpio-madera.c
@@ -0,0 +1,173 @@
+/*
+ * gpio-madera.c - GPIO support for Cirrus Logic Madera codecs
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
+	if (val & MADERA_GP1_LVL_MASK)
+		return 1;
+	else
+		return 0;
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
+			   MADERA_GPIO1_CTRL_1 + (2 * offset),
+			   MADERA_GP1_LVL_MASK, regval);
+	if (ret)
+		dev_warn(madera->dev, "Failed to write to 0x%x (%d)\n",
+			 MADERA_GPIO1_CTRL_1 + (2 * offset), ret);
+}
+
+static struct gpio_chip template_chip = {
+	.label			= "madera",
+	.owner			= THIS_MODULE,
+	.direction_input	= madera_gpio_direction_in,
+	.get			= madera_gpio_get,
+	.direction_output	= madera_gpio_direction_out,
+	.set			= madera_gpio_set,
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
+		dev_err(&pdev->dev, "Unknown chip variant %d\n",
+			madera->type);
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
