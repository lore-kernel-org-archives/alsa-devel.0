From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 07/16] regulator: madera-micsupp: Mic supply
	for Cirrus Logic Madera codecs
Date: Wed, 5 Apr 2017 11:07:55 +0100
Message-ID: <1491386884-30689-8-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1491386884-30689-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 83EAA266FF3
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 12:08:10 +0200 (CEST)
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

The adds a driver for the microphone supply regulator on Cirrus Logic
Madera class codecs.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 .../bindings/regulator/madera-micsupp.txt          |  27 +++
 drivers/regulator/Kconfig                          |   8 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/madera-micsupp.c                 | 260 +++++++++++++++++++++
 include/linux/regulator/madera-micsupp.h           |  21 ++
 5 files changed, 317 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/madera-micsupp.txt
 create mode 100644 drivers/regulator/madera-micsupp.c
 create mode 100644 include/linux/regulator/madera-micsupp.h

diff --git a/Documentation/devicetree/bindings/regulator/madera-micsupp.txt b/Documentation/devicetree/bindings/regulator/madera-micsupp.txt
new file mode 100644
index 0000000..08aec7f
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/madera-micsupp.txt
@@ -0,0 +1,27 @@
+Cirrus Logic Madera class audio codecs mic supply regulator driver
+
+Only required if the codec has an internal mic supply regulator.
+This is a subnode of the parent mfd node.
+
+See also the core bindings for the parent MFD driver:
+See Documentation/devicetree/bindings/mfd/madera.txt
+
+Required properties:
+  - compatible :  must be "cirrus,madera-micsupp"
+
+Optional subnodes:
+  Standard regulator bindings as described in bindings/regulator/regulator.txt
+
+Example:
+
+codec: cs47l85@0 {
+	compatible = "cirrus,cs47l85";
+
+	micvdd {
+		compatible = "cirrus,madera-micsupp";
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-allow-bypass = <1>;
+	};
+};
+
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index c96d9a6..4f4b531 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -376,6 +376,14 @@ config REGULATOR_MADERA_LDO1
 	  to supply DCVDD you must include this driver. If you are using an
 	  external DCVDD regulator you do not need this driver.
 
+config REGULATOR_MADERA_MICSUPP
+	tristate "Cirrus Logic Madera codecs mic supply regulator"
+	depends on MFD_MADERA
+	depends on SND_SOC
+	help
+	  Support for the microphone supply regulator on Cirrus Logic
+	  Madera class codecs
+
 config REGULATOR_MAX14577
 	tristate "Maxim 14577/77836 regulator"
 	depends on MFD_MAX14577
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 2db3592..28cdf6e 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_REGULATOR_LP8755) += lp8755.o
 obj-$(CONFIG_REGULATOR_LTC3589) += ltc3589.o
 obj-$(CONFIG_REGULATOR_LTC3676) += ltc3676.o
 obj-$(CONFIG_REGULATOR_MADERA_LDO1) += madera-ldo1.o
+obj-$(CONFIG_REGULATOR_MADERA_MICSUPP) += madera-micsupp.o
 obj-$(CONFIG_REGULATOR_MAX14577) += max14577-regulator.o
 obj-$(CONFIG_REGULATOR_MAX1586) += max1586.o
 obj-$(CONFIG_REGULATOR_MAX77620) += max77620-regulator.o
diff --git a/drivers/regulator/madera-micsupp.c b/drivers/regulator/madera-micsupp.c
new file mode 100644
index 0000000..ac8bcbd
--- /dev/null
+++ b/drivers/regulator/madera-micsupp.c
@@ -0,0 +1,260 @@
+/*
+ * madera-micsupp.c  --  Driver for the mic supply regulator on Madera codecs
+ *
+ * Copyright 2015-2017 Cirrus Logic
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/workqueue.h>
+#include <sound/soc.h>
+
+#include <linux/regulator/madera-micsupp.h>
+
+#include <linux/mfd/madera/core.h>
+#include <linux/mfd/madera/pdata.h>
+#include <linux/mfd/madera/registers.h>
+
+struct madera_micsupp {
+	struct regulator_dev *regulator;
+	struct madera *madera;
+
+	struct regulator_consumer_supply supply;
+	struct regulator_init_data init_data;
+
+	struct work_struct check_cp_work;
+};
+
+static void madera_micsupp_check_cp(struct work_struct *work)
+{
+	struct madera_micsupp *micsupp =
+		container_of(work, struct madera_micsupp, check_cp_work);
+	struct snd_soc_dapm_context *dapm = micsupp->madera->dapm;
+	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
+	struct madera *madera = micsupp->madera;
+	struct regmap *regmap = madera->regmap;
+	unsigned int reg;
+	int ret;
+
+	if (dapm) {
+		ret = regmap_read(regmap, MADERA_MIC_CHARGE_PUMP_1, &reg);
+		if (ret) {
+			dev_err(madera->dev,
+				"Failed to read CP state: %d\n", ret);
+			return;
+		}
+
+		reg &= MADERA_CPMIC_ENA | MADERA_CPMIC_BYPASS;
+		if (reg == MADERA_CPMIC_ENA)
+			snd_soc_component_force_enable_pin(component,
+							   "MICSUPP");
+		else
+			snd_soc_component_disable_pin(component, "MICSUPP");
+
+		snd_soc_dapm_sync(dapm);
+	}
+}
+
+static int madera_micsupp_enable(struct regulator_dev *rdev)
+{
+	struct madera_micsupp *micsupp = rdev_get_drvdata(rdev);
+	int ret;
+
+	ret = regulator_enable_regmap(rdev);
+	if (ret == 0)
+		schedule_work(&micsupp->check_cp_work);
+
+	return ret;
+}
+
+static int madera_micsupp_disable(struct regulator_dev *rdev)
+{
+	struct madera_micsupp *micsupp = rdev_get_drvdata(rdev);
+	int ret;
+
+	ret = regulator_disable_regmap(rdev);
+	if (ret == 0)
+		schedule_work(&micsupp->check_cp_work);
+
+	return ret;
+}
+
+static int madera_micsupp_set_bypass(struct regulator_dev *rdev, bool ena)
+{
+	struct madera_micsupp *micsupp = rdev_get_drvdata(rdev);
+	int ret;
+
+	ret = regulator_set_bypass_regmap(rdev, ena);
+	if (ret == 0)
+		schedule_work(&micsupp->check_cp_work);
+
+	return ret;
+}
+
+static const struct regulator_ops madera_micsupp_ops = {
+	.enable = madera_micsupp_enable,
+	.disable = madera_micsupp_disable,
+	.is_enabled = regulator_is_enabled_regmap,
+
+	.list_voltage = regulator_list_voltage_linear_range,
+	.map_voltage = regulator_map_voltage_linear_range,
+
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+
+	.get_bypass = regulator_get_bypass_regmap,
+	.set_bypass = madera_micsupp_set_bypass,
+};
+
+static const struct regulator_linear_range madera_micsupp_ranges[] = {
+	REGULATOR_LINEAR_RANGE(900000,  0,    0x14, 25000),
+	REGULATOR_LINEAR_RANGE(1500000, 0x15, 0x27, 100000),
+};
+
+static const struct regulator_desc madera_micsupp = {
+	.name = "MICVDD",
+	.supply_name = "CPVDD1",
+	.type = REGULATOR_VOLTAGE,
+	.n_voltages = 40,
+	.ops = &madera_micsupp_ops,
+
+	.vsel_reg = MADERA_LDO2_CONTROL_1,
+	.vsel_mask = MADERA_LDO2_VSEL_MASK,
+	.enable_reg = MADERA_MIC_CHARGE_PUMP_1,
+	.enable_mask = MADERA_CPMIC_ENA,
+	.bypass_reg = MADERA_MIC_CHARGE_PUMP_1,
+	.bypass_mask = MADERA_CPMIC_BYPASS,
+
+	.linear_ranges = madera_micsupp_ranges,
+	.n_linear_ranges = ARRAY_SIZE(madera_micsupp_ranges),
+
+	.enable_time = 3000,
+
+	.owner = THIS_MODULE,
+};
+
+static const struct regulator_init_data madera_micsupp_default = {
+	.constraints = {
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS |
+				REGULATOR_CHANGE_VOLTAGE |
+				REGULATOR_CHANGE_BYPASS,
+		.min_uV = 900000,
+		.max_uV = 3300000,
+	},
+
+	.num_consumer_supplies = 1,
+};
+
+static int madera_micsupp_of_get_pdata(struct madera *madera,
+					struct regulator_config *config,
+					const struct regulator_desc *desc)
+{
+	struct madera_pdata *pdata = &madera->pdata;
+	struct madera_micsupp *micsupp = config->driver_data;
+	struct regulator_init_data *init_data;
+
+	init_data = of_get_regulator_init_data(config->dev, config->of_node,
+						desc);
+
+	if (init_data) {
+		init_data->consumer_supplies = &micsupp->supply;
+		init_data->num_consumer_supplies = 1;
+		pdata->micsupp.init_data = init_data;
+	}
+
+	return 0;
+}
+
+static int madera_micsupp_probe(struct platform_device *pdev)
+{
+	struct madera *madera = dev_get_drvdata(pdev->dev.parent);
+	const struct regulator_desc *desc;
+	struct regulator_config config = { };
+	struct madera_micsupp *micsupp;
+	int ret;
+
+	micsupp = devm_kzalloc(&pdev->dev, sizeof(*micsupp), GFP_KERNEL);
+	if (!micsupp)
+		return -ENOMEM;
+
+	micsupp->madera = madera;
+	INIT_WORK(&micsupp->check_cp_work, madera_micsupp_check_cp);
+
+	/*
+	 * Since the chip usually supplies itself we provide some
+	 * default init_data for it.  This will be overridden with
+	 * platform data if provided.
+	 */
+	desc = &madera_micsupp;
+	micsupp->init_data = madera_micsupp_default;
+
+	micsupp->init_data.consumer_supplies = &micsupp->supply;
+	micsupp->supply.supply = "MICVDD";
+	micsupp->supply.dev_name = dev_name(madera->dev);
+
+	config.dev = madera->dev;
+	config.of_node = config.dev->of_node;
+	config.driver_data = micsupp;
+	config.regmap = madera->regmap;
+
+	if (IS_ENABLED(CONFIG_OF)) {
+		if (!dev_get_platdata(madera->dev)) {
+			ret = madera_micsupp_of_get_pdata(madera, &config,
+							  desc);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	if (madera->pdata.micsupp.init_data)
+		config.init_data = madera->pdata.micsupp.init_data;
+	else
+		config.init_data = &micsupp->init_data;
+
+	/* Default to regulated mode, in case bypass is not in constraints */
+	regmap_update_bits(madera->regmap, MADERA_MIC_CHARGE_PUMP_1,
+			   MADERA_CPMIC_BYPASS, 0);
+
+	micsupp->regulator = devm_regulator_register(&pdev->dev, desc,
+						     &config);
+
+	of_node_put(config.of_node);
+
+	if (IS_ERR(micsupp->regulator)) {
+		ret = PTR_ERR(micsupp->regulator);
+		dev_err(madera->dev, "Failed to register mic supply: %d\n",
+			ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, micsupp);
+
+	return 0;
+}
+
+static struct platform_driver madera_micsupp_driver = {
+	.probe = madera_micsupp_probe,
+	.driver		= {
+		.name	= "madera-micsupp",
+	},
+};
+
+module_platform_driver(madera_micsupp_driver);
+
+/* Module information */
+MODULE_DESCRIPTION("Madera microphone supply driver");
+MODULE_AUTHOR("Charles Keepax <ckeepax@opensource.wolfsonmicro.com>");
+MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.wolfsonmicro.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:madera-micsupp");
diff --git a/include/linux/regulator/madera-micsupp.h b/include/linux/regulator/madera-micsupp.h
new file mode 100644
index 0000000..9913bc6
--- /dev/null
+++ b/include/linux/regulator/madera-micsupp.h
@@ -0,0 +1,21 @@
+/*
+ * Platform data for Madera codecs MICSUPP regulator
+ *
+ * Copyright 2016-2017 Cirrus Logic
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef MADERA_MICSUPP_H
+#define MADERA_MICSUPP_H
+
+struct regulator_init_data;
+
+struct madera_micsupp_pdata {
+	/** Regulator configuration for MICSUPP */
+	const struct regulator_init_data *init_data;
+};
+
+#endif
-- 
1.9.1
