From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 02/16] mfd: madera: Add common support for
	Cirrus Logic Madera codecs
Date: Wed, 5 Apr 2017 11:07:50 +0100
Message-ID: <1491386884-30689-3-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1491386884-30689-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 5909B26702B
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 12:08:16 +0200 (CEST)
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

This adds the generic core support for Cirrus Logic "Madera" class codecs.
These are complex audio codec SoCs with a variety of digital and analogue
I/O, onboard audio processing and DSPs, and other features.

These codecs are all based off a common set of hardware IP so can be
supported by a core of common code (with a few minor device-to-device
variations).

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Nikesh Oswal <Nikesh.Oswal@wolfsonmicro.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 Documentation/devicetree/bindings/mfd/madera.txt |  79 +++
 MAINTAINERS                                      |   3 +
 drivers/mfd/Kconfig                              |  23 +
 drivers/mfd/Makefile                             |   4 +
 drivers/mfd/madera-core.c                        | 689 +++++++++++++++++++++++
 drivers/mfd/madera-i2c.c                         | 130 +++++
 drivers/mfd/madera-spi.c                         | 131 +++++
 drivers/mfd/madera.h                             |  52 ++
 include/linux/mfd/madera/core.h                  | 175 ++++++
 include/linux/mfd/madera/pdata.h                 |  88 +++
 10 files changed, 1374 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/madera.txt
 create mode 100644 drivers/mfd/madera-core.c
 create mode 100644 drivers/mfd/madera-i2c.c
 create mode 100644 drivers/mfd/madera-spi.c
 create mode 100644 drivers/mfd/madera.h
 create mode 100644 include/linux/mfd/madera/core.h
 create mode 100644 include/linux/mfd/madera/pdata.h

diff --git a/Documentation/devicetree/bindings/mfd/madera.txt b/Documentation/devicetree/bindings/mfd/madera.txt
new file mode 100644
index 0000000..a6c3260
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/madera.txt
@@ -0,0 +1,79 @@
+Cirrus Logic Madera class audio codecs multi-function device
+
+These devices are audio SoCs with extensive digital capabilities and a range
+of analogue I/O.
+
+See also the child driver bindings in:
+bindings/extcon/extcon-madera.txt
+bindings/gpio/gpio-madera.txt
+bindings/interrupt-controller/cirrus,madera.txt
+bindings/pinctrl/cirrus,madera-pinctrl.txt
+bindings/regulator/madera-ldo1.txt
+bindings/regulator/madera-micsupp.txt
+bindings/sound/madera.txt
+
+Required properties:
+
+  - compatible : One of the following chip-specific strings:
+        "cirrus,cs47l35"
+        "cirrus,cs47l85"
+        "cirrus,cs47l90"
+        "cirrus,cs47l91"
+        "cirrus,wm1840"
+
+  - reg : I2C slave address when connected using I2C, chip select number when
+    using SPI.
+
+  - DCVDD-supply : Power supply for the device as defined in
+    bindings/regulator/regulator.txt
+    Mandatory on CS47L35, CS47L90, CS47L91
+    Optional on CS47L85, WM1840
+
+  - AVDD-supply, DBVDD1-supply, DBVDD2-supply, CPVDD1-supply, CPVDD2-supply :
+    Power supplies for the device
+
+  - DBVDD3-supply, DBVDD4-supply : Power supplies for the device
+    (CS47L85, CS47L90, CS47L91, WM1840)
+
+  - SPKVDDL-supply, SPKVDDR-supply : Power supplies for the device
+    (CS47L85, WM1840)
+
+  - SPKVDD-supply : Power supply for the device
+    (CS47L35)
+
+Optional properties:
+
+  - MICVDD-supply : Power supply, only need to be specified if
+    powered externally
+
+  - reset-gpios : One entry specifying the GPIO controlling /RESET.
+    As defined in bindings/gpio.txt.
+    Although optional, it is strongly recommended to use a hardware reset
+
+  - MICBIASx : Initial data for the MICBIAS regulators, as covered in
+    Documentation/devicetree/bindings/regulator/regulator.txt.
+    One for each MICBIAS generator (MICBIAS1, MICBIAS2, ...)
+    (all codecs)
+
+    One for each output pin (MICBIAS1A, MIBCIAS1B, MICBIAS2A, ...)
+    (all except CS47L85, WM1840)
+
+    The following following additional property is supported for the generator
+    nodes:
+      - cirrus,ext-cap : Set to 1 if the MICBIAS has external decoupling
+        capacitors attached.
+
+Example:
+
+codec: cs47l85@0 {
+	compatible = "cirrus,cs47l85";
+	reg = <0>;
+
+	reset-gpios = <&gpio 0>;
+
+	MICBIAS1 {
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <3300000>;
+		cirrus,ext-cap = <1>;
+	};
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 02995c9..d28e53f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3266,7 +3266,10 @@ L:	patches@opensource.wolfsonmicro.com
 T:	git https://github.com/CirrusLogic/linux-drivers.git
 W:	https://github.com/CirrusLogic/linux-drivers/wiki
 S:	Supported
+F:	Documentation/devicetree/bindings/mfd/madera.txt
 F:	include/linux/mfd/madera/*
+F:	drivers/mfd/madera*
+F:	drivers/mfd/cs47l*
 
 CLEANCACHE API
 M:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index ce3a918..f0f9979 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -203,6 +203,29 @@ config MFD_CROS_EC_SPI
 	  response time cannot be guaranteed, we support ignoring
 	  'pre-amble' bytes before the response actually starts.
 
+config MFD_MADERA
+	bool
+	select REGMAP
+	select MFD_CORE
+
+config MFD_MADERA_I2C
+	tristate "Cirrus Logic Madera codecs with I2C"
+	select MFD_MADERA
+	select REGMAP_I2C
+	depends on I2C
+	help
+	  Support for the Cirrus Logic Madera platform audio SoC
+	  core functionality controlled via I2C.
+
+config MFD_MADERA_SPI
+	tristate "Cirrus Logic Madera codecs with SPI"
+	select MFD_MADERA
+	select REGMAP_SPI
+	depends on SPI_MASTER
+	help
+	  Support for the Cirrus Logic Madera platform audio SoC
+	  core functionality controlled via SPI.
+
 config MFD_ASIC3
 	bool "Compaq ASIC3"
 	depends on GPIOLIB && ARM
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index fa86dbe..c41f6c9 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -72,6 +72,10 @@ obj-$(CONFIG_MFD_WM8350_I2C)	+= wm8350-i2c.o
 wm8994-objs			:= wm8994-core.o wm8994-irq.o wm8994-regmap.o
 obj-$(CONFIG_MFD_WM8994)	+= wm8994.o
 
+obj-$(CONFIG_MFD_MADERA)	+= madera-core.o
+obj-$(CONFIG_MFD_MADERA_I2C)	+= madera-i2c.o
+obj-$(CONFIG_MFD_MADERA_SPI)	+= madera-spi.o
+
 obj-$(CONFIG_TPS6105X)		+= tps6105x.o
 obj-$(CONFIG_TPS65010)		+= tps65010.o
 obj-$(CONFIG_TPS6507X)		+= tps6507x.o
diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
new file mode 100644
index 0000000..ab5fe9b
--- /dev/null
+++ b/drivers/mfd/madera-core.c
@@ -0,0 +1,689 @@
+/*
+ * Core MFD support for Cirrus Logic Madera codecs
+ *
+ * Copyright 2015-2017 Cirrus Logic
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+
+#include <linux/mfd/madera/core.h>
+#include <linux/mfd/madera/registers.h>
+
+#include "madera.h"
+
+#define CS47L35_SILICON_ID	0x6360
+#define CS47L85_SILICON_ID	0x6338
+#define CS47L90_SILICON_ID	0x6364
+
+#define MADERA_32KZ_MCLK2	1
+
+static const char * const madera_core_supplies[] = {
+	"AVDD",
+	"DBVDD1",
+};
+
+static const struct mfd_cell madera_ldo1_devs[] = {
+	{ .name = "madera-ldo1", .of_compatible = "cirrus,madera-ldo1" },
+};
+
+static const struct mfd_cell cs47l35_devs[] = {
+	{ .name = "madera-pinctrl", .of_compatible = "cirrus,madera-pinctrl" },
+	{ .name = "madera-irq", },
+	{ .name = "madera-micsupp", .of_compatible = "cirrus,madera-micsupp" },
+	{ .name = "madera-gpio",    .of_compatible = "cirrus,madera-gpio" },
+	{ .name = "madera-extcon",  .of_compatible = "cirrus,madera-extcon" },
+	{ .name = "cs47l35-codec",  .of_compatible = "cirrus,cs47l35-codec" },
+	{ .name = "madera-haptics", .of_compatible = "cirrus,madera-haptics" },
+};
+
+static const struct mfd_cell cs47l85_devs[] = {
+	{ .name = "madera-pinctrl", .of_compatible = "cirrus,madera-pinctrl" },
+	{ .name = "madera-irq", },
+	{ .name = "madera-micsupp", .of_compatible = "cirrus,madera-micsupp" },
+	{ .name = "madera-gpio",    .of_compatible = "cirrus,madera-gpio" },
+	{ .name = "madera-extcon",  .of_compatible = "cirrus,madera-extcon" },
+	{ .name = "cs47l85-codec",  .of_compatible = "cirrus,cs47l85-codec" },
+	{ .name = "madera-haptics", .of_compatible = "cirrus,madera-haptics" },
+};
+
+static const struct mfd_cell cs47l90_devs[] = {
+	{ .name = "madera-pinctrl", .of_compatible = "cirrus,madera-pinctrl" },
+	{ .name = "madera-irq", },
+	{ .name = "madera-micsupp", .of_compatible = "cirrus,madera-micsupp" },
+	{ .name = "madera-gpio",    .of_compatible = "cirrus,madera-gpio" },
+	{ .name = "madera-extcon",  .of_compatible = "cirrus,madera-extcon" },
+	{ .name = "cs47l90-codec",  .of_compatible = "cirrus,cs47l90-codec" },
+	{ .name = "madera-haptics", .of_compatible = "cirrus,madera-haptics" },
+};
+
+const char *madera_name_from_type(enum madera_type type)
+{
+	switch (type) {
+	case CS47L35:
+		return "CS47L35";
+	case CS47L85:
+		return "CS47L85";
+	case CS47L90:
+		return "CS47L90";
+	case CS47L91:
+		return "CS47L91";
+	case WM1840:
+		return "WM1840";
+	default:
+		return "Unknown";
+	}
+}
+EXPORT_SYMBOL_GPL(madera_name_from_type);
+
+#define MADERA_BOOT_POLL_MAX_INTERVAL_US  5000
+#define MADERA_BOOT_POLL_TIMEOUT_US	 25000
+
+static int madera_wait_for_boot(struct madera *madera)
+{
+	unsigned int val;
+	int ret;
+
+	/*
+	 * We can't use an interrupt as we need to runtime resume to do so,
+	 * so we poll the status bit. This won't race with the interrupt
+	 * handler because it will be blocked on runtime resume.
+	 */
+	ret = regmap_read_poll_timeout(madera->regmap,
+				       MADERA_IRQ1_RAW_STATUS_1,
+				       val,
+				       (val & MADERA_BOOT_DONE_STS1),
+				       MADERA_BOOT_POLL_MAX_INTERVAL_US,
+				       MADERA_BOOT_POLL_TIMEOUT_US);
+	/*
+	 * BOOT_DONE defaults to unmasked on boot so we must ack it.
+	 * Do this unconditionally to avoid interrupt storms
+	 */
+	regmap_write(madera->regmap, MADERA_IRQ1_STATUS_1,
+		     MADERA_BOOT_DONE_EINT1);
+
+	if (ret)
+		dev_err(madera->dev, "Polling BOOT_DONE_STS failed: %d\n", ret);
+
+	pm_runtime_mark_last_busy(madera->dev);
+
+	return ret;
+}
+
+static int madera_soft_reset(struct madera *madera)
+{
+	int ret;
+
+	ret = regmap_write(madera->regmap, MADERA_SOFTWARE_RESET, 0);
+	if (ret != 0) {
+		dev_err(madera->dev, "Failed to soft reset device: %d\n", ret);
+		return ret;
+	}
+	usleep_range(1000, 2000);
+
+	return 0;
+}
+
+static void madera_enable_hard_reset(struct madera *madera)
+{
+	if (madera->reset_gpio)
+		gpiod_set_value_cansleep(madera->reset_gpio, 0);
+}
+
+static void madera_disable_hard_reset(struct madera *madera)
+{
+	if (madera->reset_gpio) {
+		gpiod_set_value_cansleep(madera->reset_gpio, 1);
+		usleep_range(1000, 2000);
+	}
+}
+
+#ifdef CONFIG_PM
+static int madera_runtime_resume(struct device *dev)
+{
+	struct madera *madera = dev_get_drvdata(dev);
+	int ret;
+
+	dev_dbg(madera->dev, "Leaving sleep mode\n");
+
+	ret = regulator_enable(madera->dcvdd);
+	if (ret) {
+		dev_err(madera->dev, "Failed to enable DCVDD: %d\n", ret);
+		return ret;
+	}
+
+	regcache_cache_only(madera->regmap, false);
+	regcache_cache_only(madera->regmap_32bit, false);
+
+	ret = madera_wait_for_boot(madera);
+	if (ret)
+		goto err;
+
+	ret = regcache_sync(madera->regmap);
+	if (ret) {
+		dev_err(madera->dev,
+			"Failed to restore 16-bit register cache\n");
+		goto err;
+	}
+
+	ret = regcache_sync(madera->regmap_32bit);
+	if (ret) {
+		dev_err(madera->dev,
+			"Failed to restore 32-bit register cache\n");
+		goto err;
+	}
+
+	return 0;
+
+err:
+	regcache_cache_only(madera->regmap_32bit, true);
+	regcache_cache_only(madera->regmap, true);
+	regulator_disable(madera->dcvdd);
+
+	return ret;
+}
+
+static int madera_runtime_suspend(struct device *dev)
+{
+	struct madera *madera = dev_get_drvdata(dev);
+
+	dev_dbg(madera->dev, "Entering sleep mode\n");
+
+	regcache_cache_only(madera->regmap, true);
+	regcache_mark_dirty(madera->regmap);
+	regcache_cache_only(madera->regmap_32bit, true);
+	regcache_mark_dirty(madera->regmap_32bit);
+
+	regulator_disable(madera->dcvdd);
+
+	return 0;
+}
+#endif
+
+const struct dev_pm_ops madera_pm_ops = {
+	SET_RUNTIME_PM_OPS(madera_runtime_suspend,
+			   madera_runtime_resume,
+			   NULL)
+};
+EXPORT_SYMBOL_GPL(madera_pm_ops);
+
+unsigned int madera_get_num_micbias(struct madera *madera)
+{
+
+	switch (madera->type) {
+	case CS47L35:
+		return 2;
+	case CS47L85:
+	case WM1840:
+		return 4;
+	case CS47L90:
+	case CS47L91:
+		return 2;
+	default:
+		dev_warn(madera->dev, "No micbias known for codec %s\n",
+			 madera_name_from_type(madera->type));
+		return 0;
+	}
+}
+EXPORT_SYMBOL_GPL(madera_get_num_micbias);
+
+unsigned int madera_get_num_childbias(struct madera *madera,
+				      unsigned int micbias)
+{
+	/*
+	 * micbias argument reserved for future codecs that don't
+	 * have the same number of children on each micbias
+	 */
+
+	switch (madera->type) {
+	case CS47L35:
+		return 2;
+	case CS47L85:
+	case WM1840:
+		return 0;
+	case CS47L90:
+	case CS47L91:
+		return 4;
+	default:
+		dev_warn(madera->dev, "No child micbias known for codec %s\n",
+			 madera_name_from_type(madera->type));
+		return 0;
+	}
+}
+EXPORT_SYMBOL_GPL(madera_get_num_childbias);
+
+#ifdef CONFIG_OF
+const struct of_device_id madera_of_match[] = {
+	{ .compatible = "cirrus,cs47l35", .data = (void *)CS47L35 },
+	{ .compatible = "cirrus,cs47l85", .data = (void *)CS47L85 },
+	{ .compatible = "cirrus,cs47l90", .data = (void *)CS47L90 },
+	{ .compatible = "cirrus,cs47l91", .data = (void *)CS47L91 },
+	{ .compatible = "cirrus,wm1840", .data = (void *)WM1840 },
+	{},
+};
+EXPORT_SYMBOL_GPL(madera_of_match);
+
+unsigned long madera_of_get_type(struct device *dev)
+{
+	const struct of_device_id *id = of_match_device(madera_of_match, dev);
+
+	if (id)
+		return (unsigned long)id->data;
+	else
+		return 0;
+}
+EXPORT_SYMBOL_GPL(madera_of_get_type);
+#endif
+
+static int madera_prop_get_core_pdata(struct madera *madera)
+{
+	int ret;
+
+	madera->reset_gpio = devm_gpiod_get_optional(madera->dev,
+						     "reset",
+						     GPIOD_OUT_LOW);
+	if (IS_ERR(madera->reset_gpio)) {
+		ret = PTR_ERR(madera->reset_gpio);
+
+		if (ret == -EPROBE_DEFER)
+			return ret;
+		else if ((ret < 0) && (ret != -EINVAL))
+			dev_warn(madera->dev,
+				 "DT property reset-gpio is malformed: %d\n",
+				 ret);
+	}
+
+	return 0;
+}
+
+static void madera_configure_micbias(struct madera *madera)
+{
+	unsigned int num_micbias = madera_get_num_micbias(madera);
+	struct madera_micbias_pdata *pdata;
+	struct regulator_init_data *init_data;
+	unsigned int num_child_micbias;
+	unsigned int val, mask, reg;
+	int i, j, ret;
+
+	for (i = 0; i < num_micbias; i++) {
+		pdata = &madera->pdata.micbias[i];
+		init_data = &pdata->init_data;
+
+		if (!init_data->constraints.max_uV &&
+		    !init_data->constraints.valid_ops_mask)
+			continue;	/* pdata not set */
+
+		/* Apply default for bypass mode */
+		if (!init_data->constraints.max_uV)
+			init_data->constraints.max_uV = 2800;
+
+		val = (init_data->constraints.max_uV - 1500000) / 100000;
+		val <<= MADERA_MICB1_LVL_SHIFT;
+
+		mask = MADERA_MICB1_LVL_MASK | MADERA_MICB1_EXT_CAP |
+			MADERA_MICB1_BYPASS | MADERA_MICB1_RATE;
+
+		if (pdata->ext_cap)
+			val |= MADERA_MICB1_EXT_CAP;
+
+		/* if no child biases the discharge is set in the parent */
+		num_child_micbias = madera_get_num_childbias(madera, i + 1);
+		if (num_child_micbias == 0) {
+			mask |= MADERA_MICB1_DISCH;
+
+			switch (init_data->constraints.active_discharge) {
+			case REGULATOR_ACTIVE_DISCHARGE_ENABLE:
+				val |= MADERA_MICB1_DISCH;
+				break;
+			default:
+				break;
+			}
+		}
+
+		if (init_data->constraints.soft_start)
+			val |= MADERA_MICB1_RATE;
+
+		if (init_data->constraints.valid_ops_mask &
+		    REGULATOR_CHANGE_BYPASS)
+			val |= MADERA_MICB1_BYPASS;
+
+		reg = MADERA_MIC_BIAS_CTRL_1 + i;
+		ret = regmap_update_bits(madera->regmap, reg, mask, val);
+		if (ret)
+			dev_warn(madera->dev, "Failed to write 0x%x (%d)\n",
+				 reg, ret);
+
+		dev_dbg(madera->dev, "Set MICBIAS_CTRL_%d mask=0x%x val=0x%x\n",
+			i + 1, mask, val);
+
+		/* Configure the child micbias pins */
+		val = 0;
+		mask = 0;
+		for (j = 0; j < num_child_micbias; j++) {
+			mask |= (MADERA_MICB1A_DISCH << (j * 4));
+
+			init_data = &pdata->pin[j].init_data;
+			switch (init_data->constraints.active_discharge) {
+			case REGULATOR_ACTIVE_DISCHARGE_ENABLE:
+				val |= (MADERA_MICB1A_DISCH << (j * 4));
+				break;
+			default:
+				break;
+			}
+		}
+
+		if (mask) {
+			reg = MADERA_MIC_BIAS_CTRL_5 + (i * 2);
+			ret = regmap_update_bits(madera->regmap, reg, mask, val);
+			if (ret)
+				dev_warn(madera->dev,
+					 "Failed to write 0x%x (%d)\n",
+					 reg, ret);
+
+			dev_dbg(madera->dev,
+				"Set MICBIAS_CTRL_%d mask=0x%x val=0x%x\n",
+				i + 5, mask, val);
+		}
+	}
+}
+
+int madera_dev_init(struct madera *madera)
+{
+	struct device *dev = madera->dev;
+	const char *name;
+	unsigned int hwid;
+	int (*patch_fn)(struct madera *) = NULL;
+	const struct mfd_cell *mfd_devs;
+	int n_devs = 0;
+	int i, ret;
+
+	dev_set_drvdata(madera->dev, madera);
+	BLOCKING_INIT_NOTIFIER_HEAD(&madera->notifier);
+
+	if (dev_get_platdata(madera->dev)) {
+		memcpy(&madera->pdata, dev_get_platdata(madera->dev),
+		       sizeof(madera->pdata));
+
+		/* We use 0 in pdata to indicate a GPIO has not been set */
+		if (madera->pdata.reset > 0) {
+			/* Start out with /RESET asserted */
+			ret = devm_gpio_request_one(madera->dev,
+						madera->pdata.reset,
+						GPIOF_DIR_OUT | GPIOF_INIT_LOW,
+						"madera reset");
+			if (ret) {
+				dev_err(dev, "Failed to request /RESET: %d\n",
+					ret);
+				return ret;
+			}
+
+			madera->reset_gpio = gpio_to_desc(madera->pdata.reset);
+		}
+	} else {
+		ret = madera_prop_get_core_pdata(madera);
+		if (ret)
+			return ret;
+	}
+
+	if (!madera->reset_gpio)
+		dev_warn(madera->dev,
+			 "Running without reset GPIO is not recommended\n");
+
+	regcache_cache_only(madera->regmap, true);
+	regcache_cache_only(madera->regmap_32bit, true);
+
+	for (i = 0; i < ARRAY_SIZE(madera_core_supplies); i++)
+		madera->core_supplies[i].supply = madera_core_supplies[i];
+
+	madera->num_core_supplies = ARRAY_SIZE(madera_core_supplies);
+
+	switch (madera->type) {
+	case CS47L35:
+	case CS47L90:
+	case CS47L91:
+		break;
+	case CS47L85:
+	case WM1840:
+		ret = mfd_add_devices(madera->dev, PLATFORM_DEVID_NONE,
+				      madera_ldo1_devs,
+				      ARRAY_SIZE(madera_ldo1_devs),
+				      NULL, 0, NULL);
+		if (ret != 0) {
+			dev_err(dev, "Failed to add LDO1 child: %d\n", ret);
+			return ret;
+		}
+		break;
+	default:
+		dev_err(madera->dev, "Unknown device type %d\n", madera->type);
+		return -ENODEV;
+	}
+
+	ret = devm_regulator_bulk_get(dev, madera->num_core_supplies,
+				      madera->core_supplies);
+	if (ret) {
+		dev_err(dev, "Failed to request core supplies: %d\n", ret);
+		goto err_devs;
+	}
+
+	/*
+	 * Don't use devres here because the only device we have to get
+	 * against is the MFD device and DCVDD will likely be supplied by
+	 * one of its children. Meaning that the regulator will be
+	 * destroyed by the time devres calls regulator put.
+	 */
+	madera->dcvdd = regulator_get_exclusive(madera->dev, "DCVDD");
+	if (IS_ERR(madera->dcvdd)) {
+		ret = PTR_ERR(madera->dcvdd);
+		dev_err(dev, "Failed to request DCVDD: %d\n", ret);
+		goto err_devs;
+	}
+
+	ret = regulator_bulk_enable(madera->num_core_supplies,
+				    madera->core_supplies);
+	if (ret) {
+		dev_err(dev, "Failed to enable core supplies: %d\n", ret);
+		goto err_dcvdd;
+	}
+
+	ret = regulator_enable(madera->dcvdd);
+	if (ret) {
+		dev_err(dev, "Failed to enable DCVDD: %d\n", ret);
+		goto err_enable;
+	}
+
+	madera_disable_hard_reset(madera);
+
+	regcache_cache_only(madera->regmap, false);
+	regcache_cache_only(madera->regmap_32bit, false);
+
+	/*
+	 * Verify that this is a chip we know about before we
+	 * starting doing any writes to its registers
+	 */
+	ret = regmap_read(madera->regmap, MADERA_SOFTWARE_RESET, &hwid);
+	if (ret) {
+		dev_err(dev, "Failed to read ID register: %d\n", ret);
+		goto err_reset;
+	}
+
+	switch (hwid) {
+	case CS47L35_SILICON_ID:
+	case CS47L85_SILICON_ID:
+	case CS47L90_SILICON_ID:
+		break;
+	default:
+		dev_err(madera->dev, "Unknown device ID: %x\n", hwid);
+		ret = -EINVAL;
+		goto err_reset;
+	}
+
+	/* If we don't have a reset GPIO use a soft reset */
+	if (!madera->reset_gpio) {
+		ret = madera_soft_reset(madera);
+		if (ret)
+			goto err_reset;
+	}
+
+	ret = madera_wait_for_boot(madera);
+	if (ret) {
+		dev_err(madera->dev, "Device failed initial boot: %d\n", ret);
+		goto err_reset;
+	}
+
+	ret = regmap_read(madera->regmap, MADERA_HARDWARE_REVISION,
+			  &madera->rev);
+	if (ret) {
+		dev_err(dev, "Failed to read revision register: %d\n", ret);
+		goto err_reset;
+	}
+	madera->rev &= MADERA_HW_REVISION_MASK;
+
+	name = madera_name_from_type(madera->type);
+
+	switch (hwid) {
+	case CS47L35_SILICON_ID:
+		if (IS_ENABLED(CONFIG_MFD_CS47L35)) {
+			switch (madera->type) {
+			case CS47L35:
+				patch_fn = cs47l35_patch;
+				mfd_devs = cs47l35_devs;
+				n_devs = ARRAY_SIZE(cs47l35_devs);
+				break;
+			default:
+				break;
+			}
+		}
+		break;
+	case CS47L85_SILICON_ID:
+		if (IS_ENABLED(CONFIG_MFD_CS47L85)) {
+			switch (madera->type) {
+			case CS47L85:
+			case WM1840:
+				patch_fn = cs47l85_patch;
+				mfd_devs = cs47l85_devs;
+				n_devs = ARRAY_SIZE(cs47l85_devs);
+				break;
+			default:
+				break;
+			}
+		}
+		break;
+	case CS47L90_SILICON_ID:
+		if (IS_ENABLED(CONFIG_MFD_CS47L90)) {
+			switch (madera->type) {
+			case CS47L90:
+			case CS47L91:
+				patch_fn = cs47l90_patch;
+				mfd_devs = cs47l90_devs;
+				n_devs = ARRAY_SIZE(cs47l90_devs);
+				break;
+			default:
+				break;
+			}
+		}
+		break;
+	default:
+		break;
+	}
+
+	if (!n_devs) {
+		dev_err(madera->dev, "Device ID 0x%x not a %s\n", hwid, name);
+		ret = -ENODEV;
+		goto err_reset;
+	}
+
+	dev_info(dev, "%s silicon revision %d\n", name, madera->rev);
+
+	/* Apply hardware patch */
+	if (patch_fn) {
+		ret = patch_fn(madera);
+		if (ret) {
+			dev_err(madera->dev, "Failed to apply patch %d\n", ret);
+			goto err_reset;
+		}
+	}
+
+	/* Init 32k clock sourced from MCLK2 */
+	ret = regmap_update_bits(madera->regmap,
+			MADERA_CLOCK_32K_1,
+			MADERA_CLK_32K_ENA_MASK | MADERA_CLK_32K_SRC_MASK,
+			MADERA_CLK_32K_ENA | MADERA_32KZ_MCLK2);
+	if (ret) {
+		dev_err(madera->dev, "Failed to init 32k clock: %d\n", ret);
+		goto err_reset;
+	}
+
+	madera_configure_micbias(madera);
+
+	pm_runtime_set_active(madera->dev);
+	pm_runtime_enable(madera->dev);
+	pm_runtime_set_autosuspend_delay(madera->dev, 100);
+	pm_runtime_use_autosuspend(madera->dev);
+
+	ret = mfd_add_devices(madera->dev, PLATFORM_DEVID_NONE,
+			      mfd_devs, n_devs,
+			      NULL, 0, NULL);
+	if (ret) {
+		dev_err(madera->dev, "Failed to add subdevices: %d\n", ret);
+		goto err_pm_runtime;
+	}
+
+	return 0;
+
+err_pm_runtime:
+	pm_runtime_disable(madera->dev);
+err_reset:
+	madera_enable_hard_reset(madera);
+	regulator_disable(madera->dcvdd);
+err_enable:
+	regulator_bulk_disable(madera->num_core_supplies,
+			       madera->core_supplies);
+err_dcvdd:
+	regulator_put(madera->dcvdd);
+err_devs:
+	mfd_remove_devices(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(madera_dev_init);
+
+int madera_dev_exit(struct madera *madera)
+{
+	/* Prevent any IRQs being serviced while we clean up */
+	disable_irq(madera->irq);
+
+	/*
+	 * DCVDD could be supplied by a child node, we must disable it before
+	 * removing the children, and prevent PM runtime from turning it back on
+	 */
+	pm_runtime_disable(madera->dev);
+
+	regulator_disable(madera->dcvdd);
+	regulator_put(madera->dcvdd);
+
+	mfd_remove_devices(madera->dev);
+	madera_enable_hard_reset(madera);
+
+	regulator_bulk_disable(madera->num_core_supplies,
+			       madera->core_supplies);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(madera_dev_exit);
diff --git a/drivers/mfd/madera-i2c.c b/drivers/mfd/madera-i2c.c
new file mode 100644
index 0000000..8c90780
--- /dev/null
+++ b/drivers/mfd/madera-i2c.c
@@ -0,0 +1,130 @@
+/*
+ * I2C bus interface to Cirrus Logic Madera codecs
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
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/of.h>
+
+#include <linux/mfd/madera/core.h>
+
+#include "madera.h"
+
+static int madera_i2c_probe(struct i2c_client *i2c,
+			    const struct i2c_device_id *id)
+{
+	struct madera *madera;
+	const struct regmap_config *regmap_16bit_config = NULL;
+	const struct regmap_config *regmap_32bit_config = NULL;
+	unsigned long type;
+	int ret;
+
+	if (i2c->dev.of_node)
+		type = madera_of_get_type(&i2c->dev);
+	else
+		type = id->driver_data;
+
+	switch (type) {
+	case CS47L35:
+		if (IS_ENABLED(CONFIG_MFD_CS47L35)) {
+			regmap_16bit_config = &cs47l35_16bit_i2c_regmap;
+			regmap_32bit_config = &cs47l35_32bit_i2c_regmap;
+		}
+		break;
+	case CS47L85:
+	case WM1840:
+		if (IS_ENABLED(CONFIG_MFD_CS47L85)) {
+			regmap_16bit_config = &cs47l85_16bit_i2c_regmap;
+			regmap_32bit_config = &cs47l85_32bit_i2c_regmap;
+		}
+		break;
+	case CS47L90:
+	case CS47L91:
+		if (IS_ENABLED(CONFIG_MFD_CS47L90)) {
+			regmap_16bit_config = &cs47l90_16bit_i2c_regmap;
+			regmap_32bit_config = &cs47l90_32bit_i2c_regmap;
+		}
+		break;
+	default:
+		dev_err(&i2c->dev,
+			"Unknown Madera I2C device type %ld\n", type);
+		return -EINVAL;
+	}
+
+	if (!regmap_16bit_config) {
+		dev_err(&i2c->dev,
+			"Kernel does not include support for %s\n",
+			madera_name_from_type(type));
+		return -EINVAL;
+	}
+
+	madera = devm_kzalloc(&i2c->dev, sizeof(*madera), GFP_KERNEL);
+	if (!madera)
+		return -ENOMEM;
+
+	madera->regmap = devm_regmap_init_i2c(i2c, regmap_16bit_config);
+	if (IS_ERR(madera->regmap)) {
+		ret = PTR_ERR(madera->regmap);
+		dev_err(&i2c->dev,
+			"Failed to allocate 16-bit register map: %d\n",	ret);
+		return ret;
+	}
+
+	madera->regmap_32bit = devm_regmap_init_i2c(i2c, regmap_32bit_config);
+	if (IS_ERR(madera->regmap_32bit)) {
+		ret = PTR_ERR(madera->regmap_32bit);
+		dev_err(&i2c->dev,
+			"Failed to allocate 32-bit register map: %d\n", ret);
+		return ret;
+	}
+
+	madera->type = type;
+	madera->dev = &i2c->dev;
+	madera->irq = i2c->irq;
+
+	return madera_dev_init(madera);
+}
+
+static int madera_i2c_remove(struct i2c_client *i2c)
+{
+	struct madera *madera = dev_get_drvdata(&i2c->dev);
+
+	madera_dev_exit(madera);
+	return 0;
+}
+
+static const struct i2c_device_id madera_i2c_id[] = {
+	{ "cs47l35", CS47L35 },
+	{ "cs47l85", CS47L85 },
+	{ "cs47l90", CS47L90 },
+	{ "cs47l91", CS47L91 },
+	{ "wm1840", WM1840 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, madera_i2c_id);
+
+static struct i2c_driver madera_i2c_driver = {
+	.driver = {
+		.name	= "madera",
+		.pm	= &madera_pm_ops,
+		.of_match_table	= of_match_ptr(madera_of_match),
+	},
+	.probe		= madera_i2c_probe,
+	.remove		= madera_i2c_remove,
+	.id_table	= madera_i2c_id,
+};
+
+module_i2c_driver(madera_i2c_driver);
+
+MODULE_DESCRIPTION("Madera I2C bus interface");
+MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.wolfsonmicro.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/mfd/madera-spi.c b/drivers/mfd/madera-spi.c
new file mode 100644
index 0000000..e7e13f0
--- /dev/null
+++ b/drivers/mfd/madera-spi.c
@@ -0,0 +1,131 @@
+/*
+ * SPI bus interface to Cirrus Logic Madera codecs
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
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/of.h>
+#include <linux/spi/spi.h>
+
+#include <linux/mfd/madera/core.h>
+
+#include "madera.h"
+
+static int madera_spi_probe(struct spi_device *spi)
+{
+	const struct spi_device_id *id = spi_get_device_id(spi);
+	struct madera *madera;
+	const struct regmap_config *regmap_16bit_config = NULL;
+	const struct regmap_config *regmap_32bit_config = NULL;
+	unsigned long type;
+	int ret;
+
+	if (spi->dev.of_node)
+		type = madera_of_get_type(&spi->dev);
+	else
+		type = id->driver_data;
+
+	switch (type) {
+	case CS47L35:
+		if (IS_ENABLED(CONFIG_MFD_CS47L35)) {
+			regmap_16bit_config = &cs47l35_16bit_spi_regmap;
+			regmap_32bit_config = &cs47l35_32bit_spi_regmap;
+		}
+		break;
+	case CS47L85:
+	case WM1840:
+		if (IS_ENABLED(CONFIG_MFD_CS47L85)) {
+			regmap_16bit_config = &cs47l85_16bit_spi_regmap;
+			regmap_32bit_config = &cs47l85_32bit_spi_regmap;
+		}
+		break;
+	case CS47L90:
+	case CS47L91:
+		if (IS_ENABLED(CONFIG_MFD_CS47L90)) {
+			regmap_16bit_config = &cs47l90_16bit_spi_regmap;
+			regmap_32bit_config = &cs47l90_32bit_spi_regmap;
+		}
+		break;
+	default:
+		dev_err(&spi->dev,
+			"Unknown Madera SPI device type %ld\n", type);
+		return -EINVAL;
+	}
+
+	if (!regmap_16bit_config) {
+		dev_err(&spi->dev,
+			"Kernel does not include support for %s\n",
+			madera_name_from_type(type));
+		return -EINVAL;
+	}
+
+	madera = devm_kzalloc(&spi->dev, sizeof(*madera), GFP_KERNEL);
+	if (!madera)
+		return -ENOMEM;
+
+	madera->regmap = devm_regmap_init_spi(spi, regmap_16bit_config);
+	if (IS_ERR(madera->regmap)) {
+		ret = PTR_ERR(madera->regmap);
+		dev_err(&spi->dev,
+			"Failed to allocate 16-bit register map: %d\n",	ret);
+		return ret;
+	}
+
+	madera->regmap_32bit = devm_regmap_init_spi(spi, regmap_32bit_config);
+	if (IS_ERR(madera->regmap_32bit)) {
+		ret = PTR_ERR(madera->regmap_32bit);
+		dev_err(&spi->dev,
+			"Failed to allocate 32-bit register map: %d\n",	ret);
+		return ret;
+	}
+
+	madera->type = type;
+	madera->dev = &spi->dev;
+	madera->irq = spi->irq;
+
+	return madera_dev_init(madera);
+}
+
+static int madera_spi_remove(struct spi_device *spi)
+{
+	struct madera *madera = spi_get_drvdata(spi);
+
+	madera_dev_exit(madera);
+	return 0;
+}
+
+static const struct spi_device_id madera_spi_ids[] = {
+	{ "cs47l35", CS47L35 },
+	{ "cs47l85", CS47L85 },
+	{ "cs47l90", CS47L90 },
+	{ "cs47l91", CS47L91 },
+	{ "wm1840", WM1840 },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, madera_spi_ids);
+
+static struct spi_driver madera_spi_driver = {
+	.driver = {
+		.name	= "madera",
+		.owner	= THIS_MODULE,
+		.pm	= &madera_pm_ops,
+		.of_match_table	= of_match_ptr(madera_of_match),
+	},
+	.probe		= madera_spi_probe,
+	.remove		= madera_spi_remove,
+	.id_table	= madera_spi_ids,
+};
+
+module_spi_driver(madera_spi_driver);
+
+MODULE_DESCRIPTION("Madera SPI bus interface");
+MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.wolfsonmicro.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/mfd/madera.h b/drivers/mfd/madera.h
new file mode 100644
index 0000000..57f6add
--- /dev/null
+++ b/drivers/mfd/madera.h
@@ -0,0 +1,52 @@
+/*
+ * madera.h  --  MFD internals for Cirrus Logic Madera codecs
+ *
+ * Copyright 2015-2016 Cirrus Logic
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef MADERA_MFD_H
+#define MADERA_MFD_H
+
+#include <linux/pm.h>
+#include <linux/of.h>
+
+struct madera;
+
+extern const struct dev_pm_ops madera_pm_ops;
+extern const struct of_device_id madera_of_match[];
+
+int madera_dev_init(struct madera *madera);
+int madera_dev_exit(struct madera *madera);
+
+#ifdef CONFIG_OF
+unsigned long madera_of_get_type(struct device *dev);
+#else
+static inline unsigned long madera_of_get_type(struct device *dev)
+{
+	return 0;
+}
+#endif
+
+extern const struct regmap_config cs47l35_16bit_spi_regmap;
+extern const struct regmap_config cs47l35_32bit_spi_regmap;
+extern const struct regmap_config cs47l35_16bit_i2c_regmap;
+extern const struct regmap_config cs47l35_32bit_i2c_regmap;
+int cs47l35_patch(struct madera *madera);
+
+extern const struct regmap_config cs47l85_16bit_spi_regmap;
+extern const struct regmap_config cs47l85_32bit_spi_regmap;
+extern const struct regmap_config cs47l85_16bit_i2c_regmap;
+extern const struct regmap_config cs47l85_32bit_i2c_regmap;
+int cs47l85_patch(struct madera *madera);
+
+extern const struct regmap_config cs47l90_16bit_spi_regmap;
+extern const struct regmap_config cs47l90_32bit_spi_regmap;
+extern const struct regmap_config cs47l90_16bit_i2c_regmap;
+extern const struct regmap_config cs47l90_32bit_i2c_regmap;
+int cs47l90_patch(struct madera *madera);
+
+#endif
diff --git a/include/linux/mfd/madera/core.h b/include/linux/mfd/madera/core.h
new file mode 100644
index 0000000..59b05f8
--- /dev/null
+++ b/include/linux/mfd/madera/core.h
@@ -0,0 +1,175 @@
+/*
+ * MFD internals for Cirrus Logic Madera codecs
+ *
+ * Copyright 2015-2017 Cirrus Logic
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef MADERA_CORE_H
+#define MADERA_CORE_H
+
+#include <linux/interrupt.h>
+#include <linux/regmap.h>
+#include <linux/notifier.h>
+#include <linux/gpio/consumer.h>
+#include <linux/regulator/consumer.h>
+#include <linux/mfd/madera/pdata.h>
+#include <linux/irqchip/irq-madera.h>
+#include <sound/madera-pdata.h>
+
+enum madera_type {
+	CS47L35 = 1,
+	CS47L85 = 2,
+	CS47L90 = 3,
+	CS47L91 = 4,
+	WM1840 = 7,
+};
+
+#define MADERA_MAX_CORE_SUPPLIES	2
+#define MADERA_MAX_GPIOS		40
+
+#define CS47L35_NUM_GPIOS		16
+#define CS47L85_NUM_GPIOS		40
+#define CS47L90_NUM_GPIOS		38
+
+
+/* Notifier events */
+#define MADERA_NOTIFY_VOICE_TRIGGER	0x1
+#define MADERA_NOTIFY_HPDET		0x2
+#define MADERA_NOTIFY_MICDET		0x4
+
+/* GPIO Function Definitions */
+#define MADERA_GP_FN_ALTERNATE		0x00
+#define MADERA_GP_FN_GPIO		0x01
+#define MADERA_GP_FN_DSP_GPIO		0x02
+#define MADERA_GP_FN_IRQ1		0x03
+#define MADERA_GP_FN_IRQ2		0x04
+#define MADERA_GP_FN_FLL1_CLOCK		0x10
+#define MADERA_GP_FN_FLL2_CLOCK		0x11
+#define MADERA_GP_FN_FLL3_CLOCK		0x12
+#define MADERA_GP_FN_FLLAO_CLOCK	0x13
+#define MADERA_GP_FN_FLL1_LOCK		0x18
+#define MADERA_GP_FN_FLL2_LOCK		0x19
+#define MADERA_GP_FN_FLL3_LOCK		0x1A
+#define MADERA_GP_FN_FLLAO_LOCK		0x1B
+#define MADERA_GP_FN_OPCLK_OUT		0x40
+#define MADERA_GP_FN_OPCLK_ASYNC_OUT	0x41
+#define MADERA_GP_FN_PWM1		0x48
+#define MADERA_GP_FN_PWM2		0x49
+#define MADERA_GP_FN_SPDIF_OUT		0x4C
+#define MADERA_GP_FN_HEADPHONE_DET	0x50
+#define MADERA_GP_FN_MIC_DET		0x58
+#define MADERA_GP_FN_DRC1_SIGNAL_DETECT	0x80
+#define MADERA_GP_FN_DRC2_SIGNAL_DETECT	0x81
+#define MADERA_GP_FN_ASRC1_IN1_LOCK	0x88
+#define MADERA_GP_FN_ASRC1_IN2_LOCK	0x89
+#define MADERA_GP_FN_ASRC2_IN1_LOCK	0x8A
+#define MADERA_GP_FN_ASRC2_IN2_LOCK	0x8B
+#define MADERA_GP_FN_DSP_IRQ1		0xA0
+#define MADERA_GP_FN_DSP_IRQ2		0xA1
+#define MADERA_GP_FN_DSP_IRQ3		0xA2
+#define MADERA_GP_FN_DSP_IRQ4		0xA3
+#define MADERA_GP_FN_DSP_IRQ5		0xA4
+#define MADERA_GP_FN_DSP_IRQ6		0xA5
+#define MADERA_GP_FN_DSP_IRQ7		0xA6
+#define MADERA_GP_FN_DSP_IRQ8		0xA7
+#define MADERA_GP_FN_DSP_IRQ9		0xA8
+#define MADERA_GP_FN_DSP_IRQ10		0xA9
+#define MADERA_GP_FN_DSP_IRQ11		0xAA
+#define MADERA_GP_FN_DSP_IRQ12		0xAB
+#define MADERA_GP_FN_DSP_IRQ13		0xAC
+#define MADERA_GP_FN_DSP_IRQ14		0xAD
+#define MADERA_GP_FN_DSP_IRQ15		0xAE
+#define MADERA_GP_FN_DSP_IRQ16		0xAF
+#define MADERA_GP_FN_HPOUT1L_SC		0xB0
+#define MADERA_GP_FN_HPOUT1R_SC		0xB1
+#define MADERA_GP_FN_HPOUT2L_SC		0xB2
+#define MADERA_GP_FN_HPOUT2R_SC		0xB3
+#define MADERA_GP_FN_HPOUT3L_SC		0xB4
+#define MADERA_GP_FN_HPOUT4R_SC		0xB5
+#define MADERA_GP_FN_SPKOUTL_SC		0xB6
+#define MADERA_GP_FN_SPKOUTR_SC		0xB7
+#define MADERA_GP_FN_HPOUT1L_ENA	0xC0
+#define MADERA_GP_FN_HPOUT1R_ENA	0xC1
+#define MADERA_GP_FN_HPOUT2L_ENA	0xC2
+#define MADERA_GP_FN_HPOUT2R_ENA	0xC3
+#define MADERA_GP_FN_HPOUT3L_ENA	0xC4
+#define MADERA_GP_FN_HPOUT4R_ENA	0xC5
+#define MADERA_GP_FN_SPKOUTL_ENA	0xC6
+#define MADERA_GP_FN_SPKOUTR_ENA	0xC7
+#define MADERA_GP_FN_HPOUT1L_DIS	0xD0
+#define MADERA_GP_FN_HPOUT1R_DIS	0xD1
+#define MADERA_GP_FN_HPOUT2L_DIS	0xD2
+#define MADERA_GP_FN_HPOUT2R_DIS	0xD3
+#define MADERA_GP_FN_HPOUT3L_DIS	0xD4
+#define MADERA_GP_FN_HPOUT4R_DIS	0xD5
+#define MADERA_GP_FN_SPKOUTL_DIS	0xD6
+#define MADERA_GP_FN_SPKOUTR_DIS	0xD7
+#define MADERA_GP_FN_SPK_SHUTDOWN	0xE0
+#define MADERA_GP_FN_SPK_OVH_SHUTDOWN	0xE1
+#define MADERA_GP_FN_SPK_OVH_WARN	0xE2
+#define MADERA_GP_FN_TIMER1_STATUS	0x140
+#define MADERA_GP_FN_TIMER2_STATUS	0x141
+#define MADERA_GP_FN_TIMER3_STATUS	0x142
+#define MADERA_GP_FN_TIMER4_STATUS	0x143
+#define MADERA_GP_FN_TIMER5_STATUS	0x144
+#define MADERA_GP_FN_TIMER6_STATUS	0x145
+#define MADERA_GP_FN_TIMER7_STATUS	0x146
+#define MADERA_GP_FN_TIMER8_STATUS	0x147
+#define MADERA_GP_FN_EVENTLOG1_FIFO_STS	0x150
+#define MADERA_GP_FN_EVENTLOG2_FIFO_STS	0x151
+#define MADERA_GP_FN_EVENTLOG3_FIFO_STS	0x152
+#define MADERA_GP_FN_EVENTLOG4_FIFO_STS	0x153
+#define MADERA_GP_FN_EVENTLOG5_FIFO_STS	0x154
+#define MADERA_GP_FN_EVENTLOG6_FIFO_STS	0x155
+#define MADERA_GP_FN_EVENTLOG7_FIFO_STS	0x156
+#define MADERA_GP_FN_EVENTLOG8_FIFO_STS	0x157
+
+struct snd_soc_dapm_context;
+
+struct madera {
+	struct regmap *regmap;
+	struct regmap *regmap_32bit;
+
+	struct device *dev;
+
+	enum madera_type type;
+	unsigned int rev;
+
+	struct gpio_desc *reset_gpio;
+
+	int num_core_supplies;
+	struct regulator_bulk_data core_supplies[MADERA_MAX_CORE_SUPPLIES];
+	struct regulator *dcvdd;
+	bool internal_dcvdd;
+
+	struct madera_pdata pdata;
+
+	struct device *irq_dev;
+	int irq;
+
+	unsigned int out_clamp[MADERA_MAX_OUTPUT];
+	unsigned int out_shorted[MADERA_MAX_OUTPUT];
+	unsigned int hp_ena;
+
+	struct snd_soc_dapm_context *dapm;
+
+	struct blocking_notifier_head notifier;
+};
+
+unsigned int madera_get_num_micbias(struct madera *madera);
+unsigned int madera_get_num_childbias(struct madera *madera,
+				      unsigned int micbias);
+
+const char *madera_name_from_type(enum madera_type type);
+
+static inline int madera_call_notifiers(struct madera *madera,
+					unsigned long event,
+					void *data)
+{
+	return blocking_notifier_call_chain(&madera->notifier, event, data);
+}
+#endif
diff --git a/include/linux/mfd/madera/pdata.h b/include/linux/mfd/madera/pdata.h
new file mode 100644
index 0000000..6d930aa
--- /dev/null
+++ b/include/linux/mfd/madera/pdata.h
@@ -0,0 +1,88 @@
+/*
+ * Platform data for Cirrus Logic Madera codecs
+ *
+ * Copyright 2015-2017 Cirrus Logic
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef MADERA_PDATA_H
+#define MADERA_PDATA_H
+
+#include <linux/kernel.h>
+#include <linux/regulator/machine.h>
+
+#include <linux/regulator/madera-ldo1.h>
+#include <linux/regulator/madera-micsupp.h>
+#include <linux/irqchip/irq-madera-pdata.h>
+#include <sound/madera-pdata.h>
+
+#define MADERA_MAX_MICBIAS		4
+#define MADERA_MAX_CHILD_MICBIAS	4
+
+#define MADERA_MAX_GPSW			2
+
+struct pinctrl_map;
+
+/** MICBIAS pin configuration */
+struct madera_micbias_pin_pdata {
+	/** Regulator configuration for pin switch */
+	struct regulator_init_data init_data;
+};
+
+/** Regulator configuration for an on-chip MICBIAS */
+struct madera_micbias_pdata {
+	/** Configuration of the MICBIAS generator */
+	struct regulator_init_data init_data;
+
+	bool ext_cap;    /** External capacitor fitted */
+
+	/**
+	 * Configuration for each output pin from this MICBIAS
+	 * (Not used on CS47L85 and WM1840)
+	 */
+	struct madera_micbias_pin_pdata pin[MADERA_MAX_CHILD_MICBIAS];
+};
+
+struct madera_pdata {
+	/** GPIO controlling /RESET, if any */
+	int reset;
+
+	/** Substruct of pdata for the LDO1 regulator */
+	struct madera_ldo1_pdata ldo1;
+
+	/** Substruct of pdata for the MICSUPP regulator */
+	struct madera_micsupp_pdata micsupp;
+
+	/** Substruct of pdata for the irqchip driver */
+	struct madera_irqchip_pdata irqchip;
+
+	/** Base GPIO */
+	int gpio_base;
+
+	/**
+	 * Array of GPIO configurations
+	 * See Documentation/pinctrl.txt
+	 */
+	const struct pinctrl_map *gpio_configs;
+	int n_gpio_configs;
+
+	/** MICBIAS configurations */
+	struct madera_micbias_pdata micbias[MADERA_MAX_MICBIAS];
+
+	/**
+	 * Substructure of pdata for the ASoC codec driver
+	 * See include/sound/madera-pdata.h
+	 */
+	struct madera_codec_pdata codec;
+
+	/**
+	 * General purpose switch mode setting
+	 * See the SW1_MODE field in the datasheet for the available values
+	 */
+	u32 gpsw[MADERA_MAX_GPSW];
+};
+
+#endif
-- 
1.9.1
