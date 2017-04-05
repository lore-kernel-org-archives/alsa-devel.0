From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 06/16] regulator: madera-ldo1: LDO1 driver for
	Cirrus Logic Madera codecs
Date: Wed, 5 Apr 2017 11:07:54 +0100
Message-ID: <1491386884-30689-7-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1491386884-30689-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 08A47266FEB
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 12:08:09 +0200 (CEST)
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

This patch adds a driver for the internal LDO1 regulator on
some Cirrus Logic Madera class codecs.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 .../devicetree/bindings/regulator/madera-ldo1.txt  |  29 +++
 MAINTAINERS                                        |   3 +
 drivers/regulator/Kconfig                          |   8 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/madera-ldo1.c                    | 198 +++++++++++++++++++++
 include/linux/regulator/madera-ldo1.h              |  24 +++
 6 files changed, 263 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/madera-ldo1.txt
 create mode 100644 drivers/regulator/madera-ldo1.c
 create mode 100644 include/linux/regulator/madera-ldo1.h

diff --git a/Documentation/devicetree/bindings/regulator/madera-ldo1.txt b/Documentation/devicetree/bindings/regulator/madera-ldo1.txt
new file mode 100644
index 0000000..688f21d
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/madera-ldo1.txt
@@ -0,0 +1,29 @@
+Cirrus Logic Madera class audio codecs LDO1 regulator driver
+
+Only required if you are using the codec internal LDO1 regulator.
+This is a subnode of the parent mfd node.
+
+See also the core bindings for the parent MFD driver:
+See Documentation/devicetree/bindings/mfd/madera.txt
+
+Required properties:
+  - compatible :  must be "cirrus,madera-ldo1"
+  - LDOVDD-supply : Power supply for the LDO1 regulator.
+
+  - enable-gpio	: GPIO to use to enable/disable the regulator.
+    As defined in bindings/gpio.txt.
+
+Optional subnodes:
+  Standard regulator bindings as described in bindings/regulator/regulator.txt
+
+Example:
+
+codec: cs47l85@0 {
+	compatible = "cirrus,cs47l85";
+
+	ldo1 {
+		compatible = "cirrus,madera-ldo1";
+		LDOVDD-supply = <&pmic_vdd1>;
+		enable-gpio = <&gpio 0>;
+	};
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index d28e53f..1207c9c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3267,9 +3267,12 @@ T:	git https://github.com/CirrusLogic/linux-drivers.git
 W:	https://github.com/CirrusLogic/linux-drivers/wiki
 S:	Supported
 F:	Documentation/devicetree/bindings/mfd/madera.txt
+F:	Documentation/devicetree/bindings/regulator/madera*
 F:	include/linux/mfd/madera/*
+F:	include/linux/regulator/madera*
 F:	drivers/mfd/madera*
 F:	drivers/mfd/cs47l*
+F:	drivers/regulator/madera*
 
 CLEANCACHE API
 M:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index be06eb2..c96d9a6 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -368,6 +368,14 @@ config REGULATOR_LTC3676
 	  This enables support for the LTC3676
 	  8-output regulators controlled via I2C.
 
+config REGULATOR_MADERA_LDO1
+	tristate "Cirrus Logic Madera codecs LDO1 regulator"
+	depends on MFD_MADERA
+	help
+	  If you want to use the internal LDO1 regulator on CS47L85 and WM1840
+	  to supply DCVDD you must include this driver. If you are using an
+	  external DCVDD regulator you do not need this driver.
+
 config REGULATOR_MAX14577
 	tristate "Maxim 14577/77836 regulator"
 	depends on MFD_MAX14577
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index ef7725e..2db3592 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_REGULATOR_LP8788) += lp8788-ldo.o
 obj-$(CONFIG_REGULATOR_LP8755) += lp8755.o
 obj-$(CONFIG_REGULATOR_LTC3589) += ltc3589.o
 obj-$(CONFIG_REGULATOR_LTC3676) += ltc3676.o
+obj-$(CONFIG_REGULATOR_MADERA_LDO1) += madera-ldo1.o
 obj-$(CONFIG_REGULATOR_MAX14577) += max14577-regulator.o
 obj-$(CONFIG_REGULATOR_MAX1586) += max1586.o
 obj-$(CONFIG_REGULATOR_MAX77620) += max77620-regulator.o
diff --git a/drivers/regulator/madera-ldo1.c b/drivers/regulator/madera-ldo1.c
new file mode 100644
index 0000000..6504d6f
--- /dev/null
+++ b/drivers/regulator/madera-ldo1.c
@@ -0,0 +1,198 @@
+/*
+ * madera-ldo1.c  --  Driver for the LDO1 regulator on Madera codecs
+ *
+ * Copyright 2015-2017 Cirrus Logic
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+
+#include <linux/regulator/madera-ldo1.h>
+
+#include <linux/mfd/madera/core.h>
+#include <linux/mfd/madera/pdata.h>
+#include <linux/mfd/madera/registers.h>
+
+struct madera_ldo1 {
+	struct regulator_dev *regulator;
+
+	struct regulator_consumer_supply supply;
+	struct regulator_init_data init_data;
+};
+
+static const struct regulator_ops madera_ldo1_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.map_voltage = regulator_map_voltage_linear,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+};
+
+static const struct regulator_desc madera_ldo1 = {
+	.name = "LDO1",
+	.supply_name = "LDOVDD",
+	.type = REGULATOR_VOLTAGE,
+	.ops = &madera_ldo1_ops,
+
+	.vsel_reg = MADERA_LDO1_CONTROL_1,
+	.vsel_mask = MADERA_LDO1_VSEL_MASK,
+	.min_uV = 900000,
+	.uV_step = 25000,
+	.n_voltages = 13,
+	.enable_time = 3000,
+
+	.owner = THIS_MODULE,
+};
+
+static const struct regulator_init_data madera_ldo1_default = {
+	.constraints = {
+		.min_uV = 1200000,
+		.max_uV = 1200000,
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies = 1,
+};
+
+static int madera_ldo1_of_get_pdata(struct madera *madera,
+				    struct regulator_config *config,
+				    const struct regulator_desc *desc)
+{
+	struct madera_pdata *pdata = &madera->pdata;
+	struct madera_ldo1 *ldo1 = config->driver_data;
+	struct device_node *dcvdd_node;
+	struct regulator_init_data *init_data;
+
+	dcvdd_node = of_parse_phandle(madera->dev->of_node, "DCVDD-supply", 0);
+
+	init_data = of_get_regulator_init_data(config->dev,
+					       config->dev->of_node,
+					       desc);
+	if (init_data) {
+		init_data->consumer_supplies = &ldo1->supply;
+		init_data->num_consumer_supplies = 1;
+		pdata->ldo1.init_data = init_data;
+
+		/* Check whether we're supplying the codec's DCVDD */
+		if (dcvdd_node && dcvdd_node != config->dev->of_node)
+			madera->internal_dcvdd = false;
+	} else if (dcvdd_node) {
+		madera->internal_dcvdd = false;
+	}
+
+	of_node_put(dcvdd_node);
+
+	if (madera->internal_dcvdd) {
+		pdata->ldo1.ldoena = of_get_named_gpio(madera->dev->of_node,
+						       "enable-gpio", 0);
+		if (pdata->ldo1.ldoena < 0)
+			if (pdata->ldo1.ldoena != -ENOENT)
+				dev_warn(madera->dev,
+					 "Malformed enable-gpio ignored: %d\n",
+					 pdata->ldo1.ldoena);
+	}
+
+	return 0;
+}
+
+static int madera_ldo1_probe(struct platform_device *pdev)
+{
+	struct madera *madera = dev_get_drvdata(pdev->dev.parent);
+	const struct regulator_desc *desc;
+	struct regulator_config config = { };
+	struct madera_ldo1 *ldo1;
+	int ret;
+
+	madera->internal_dcvdd = true;
+
+	ldo1 = devm_kzalloc(&pdev->dev, sizeof(*ldo1), GFP_KERNEL);
+	if (!ldo1)
+		return -ENOMEM;
+
+	/*
+	 * Since the chip usually supplies itself we provide some
+	 * default init_data for it.  This will be overridden with
+	 * platform data if provided.
+	 */
+	desc = &madera_ldo1;
+	ldo1->init_data = madera_ldo1_default;
+
+	ldo1->init_data.consumer_supplies = &ldo1->supply;
+	ldo1->supply.supply = "DCVDD";
+	ldo1->supply.dev_name = dev_name(madera->dev);
+
+	config.dev = &pdev->dev;
+	config.of_node = config.dev->of_node;
+	config.driver_data = ldo1;
+	config.regmap = madera->regmap;
+
+	/* pdata defaults to 0 if not explicitly set. Convert to invalid. */
+	if (madera->pdata.ldo1.ldoena == 0)
+		madera->pdata.ldo1.ldoena = -EINVAL;
+
+	if (IS_ENABLED(CONFIG_OF)) {
+		if (!dev_get_platdata(madera->dev)) {
+			ret = madera_ldo1_of_get_pdata(madera, &config, desc);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	if (madera->pdata.ldo1.init_data)
+		ldo1->init_data = *madera->pdata.ldo1.init_data;
+
+	if (gpio_is_valid(madera->pdata.ldo1.ldoena)) {
+		config.ena_gpio = madera->pdata.ldo1.ldoena;
+		config.ena_gpio_initialized = true;
+	} else {
+		dev_warn(madera->dev,
+			 "Running without LDOENA is not recommended\n");
+	}
+	config.ena_gpio_flags = GPIOF_OUT_INIT_LOW;
+	config.init_data = &ldo1->init_data;
+
+	/*
+	 * LDO1 can only be used to supply DCVDD so if it has no
+	 * consumers then DCVDD is supplied externally.
+	 */
+	if (config.init_data->num_consumer_supplies == 0)
+		madera->internal_dcvdd = false;
+
+	ldo1->regulator = devm_regulator_register(&pdev->dev, desc, &config);
+
+	of_node_put(config.of_node);
+
+	if (IS_ERR(ldo1->regulator)) {
+		ret = PTR_ERR(ldo1->regulator);
+		dev_err(madera->dev, "Failed to register LDO1 supply: %d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct platform_driver madera_ldo1_driver = {
+	.probe = madera_ldo1_probe,
+	.driver		= {
+		.name	= "madera-ldo1",
+	},
+};
+
+module_platform_driver(madera_ldo1_driver);
+
+MODULE_DESCRIPTION("Madera LDO1 driver");
+MODULE_AUTHOR("Charles Keepax <ckeepax@opensource.wolfsonmicro.com>");
+MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.wolfsonmicro.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:madera-ldo1");
diff --git a/include/linux/regulator/madera-ldo1.h b/include/linux/regulator/madera-ldo1.h
new file mode 100644
index 0000000..9435021
--- /dev/null
+++ b/include/linux/regulator/madera-ldo1.h
@@ -0,0 +1,24 @@
+/*
+ * Platform data for Madera codecs LDO1 regulator
+ *
+ * Copyright 2016-2017 Cirrus Logic
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef MADERA_LDO1_H
+#define MADERA_LDO1_H
+
+struct regulator_init_data;
+
+struct madera_ldo1_pdata {
+	/** GPIO controlling LODENA, if any */
+	int ldoena;
+
+	/** Regulator configuration for LDO1 */
+	const struct regulator_init_data *init_data;
+};
+
+#endif
-- 
1.9.1
