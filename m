From: Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: [PATCH v2 07/18] regulator: arizona-micsupp: Add support for Cirrus Logic Madera codecs
Date: Mon, 24 Apr 2017 17:08:33 +0100
Message-ID: <1493050124-5970-8-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1493050124-5970-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1493050124-5970-1-git-send-email-rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

This adds a new driver identity "madera-micsupp" and probe function
so that this driver can be used to control the micsupp regulator on
Cirrus Logic Madera codecs.

Signed-off-by: Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
---
Replaces the madera-specific driver from V1 patchset

 .../bindings/regulator/arizona-regulator.txt       |  3 +-
 drivers/regulator/Kconfig                          |  7 ++-
 drivers/regulator/arizona-micsupp.c                | 71 +++++++++++++++++++++-
 3 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/arizona-regulator.txt b/Documentation/devicetree/bindings/regulator/arizona-regulator.txt
index 443564d..91b00f9 100644
--- a/Documentation/devicetree/bindings/regulator/arizona-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/arizona-regulator.txt
@@ -5,7 +5,8 @@ of analogue I/O.
 
 This document lists regulator specific bindings, see the primary binding
 document:
-  ../mfd/arizona.txt
+  For Wolfson Arizona codecs: ../mfd/arizona.txt
+  For Cirrus Logic Madera codecs: ../mfd/madera.txt
 
 Optional properties:
   - wlf,ldoena : GPIO specifier for the GPIO controlling LDOENA
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 8647538..05e6aae 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -134,11 +134,12 @@ config REGULATOR_ARIZONA_LDO1
 	  devices.
 
 config REGULATOR_ARIZONA_MICSUPP
-	tristate "Wolfson Arizona class devices MICSUPP"
-	depends on MFD_ARIZONA
+	tristate "Cirrus Madera and Wolfson Arizona class devices MICSUPP"
+	depends on MFD_ARIZONA || MFD_MADERA
 	depends on SND_SOC
 	help
-	  Support for the MICSUPP regulators found on Wolfson Arizona class
+	  Support for the MICSUPP regulators found on Cirrus Logic Madera codecs
+	  and Wolfson Arizona codecs
 	  devices.
 
 config REGULATOR_AS3711
diff --git a/drivers/regulator/arizona-micsupp.c b/drivers/regulator/arizona-micsupp.c
index 120de94..36bf73c 100644
--- a/drivers/regulator/arizona-micsupp.c
+++ b/drivers/regulator/arizona-micsupp.c
@@ -30,6 +30,10 @@
 #include <linux/mfd/arizona/pdata.h>
 #include <linux/mfd/arizona/registers.h>
 
+#include <linux/mfd/madera/core.h>
+#include <linux/mfd/madera/pdata.h>
+#include <linux/mfd/madera/registers.h>
+
 #include <linux/regulator/arizona-micsupp.h>
 
 struct arizona_micsupp {
@@ -205,6 +209,28 @@ static int arizona_micsupp_set_bypass(struct regulator_dev *rdev, bool ena)
 	.num_consumer_supplies = 1,
 };
 
+static const struct regulator_desc madera_micsupp = {
+	.name = "MICVDD",
+	.supply_name = "CPVDD1",
+	.type = REGULATOR_VOLTAGE,
+	.n_voltages = 40,
+	.ops = &arizona_micsupp_ops,
+
+	.vsel_reg = MADERA_LDO2_CONTROL_1,
+	.vsel_mask = MADERA_LDO2_VSEL_MASK,
+	.enable_reg = MADERA_MIC_CHARGE_PUMP_1,
+	.enable_mask = MADERA_CPMIC_ENA,
+	.bypass_reg = MADERA_MIC_CHARGE_PUMP_1,
+	.bypass_mask = MADERA_CPMIC_BYPASS,
+
+	.linear_ranges = arizona_micsupp_ext_ranges,
+	.n_linear_ranges = ARRAY_SIZE(arizona_micsupp_ext_ranges),
+
+	.enable_time = 3000,
+
+	.owner = THIS_MODULE,
+};
+
 static int arizona_micsupp_of_get_pdata(struct arizona_micsupp_pdata *pdata,
 					struct regulator_config *config,
 					const struct regulator_desc *desc)
@@ -321,6 +347,24 @@ static int arizona_micsupp_probe(struct platform_device *pdev)
 					   &arizona->pdata.micvdd);
 }
 
+static int madera_micsupp_probe(struct platform_device *pdev)
+{
+	struct madera *madera = dev_get_drvdata(pdev->dev.parent);
+	struct arizona_micsupp *micsupp;
+
+	micsupp = devm_kzalloc(&pdev->dev, sizeof(*micsupp), GFP_KERNEL);
+	if (!micsupp)
+		return -ENOMEM;
+
+	micsupp->regmap = madera->regmap;
+	micsupp->dapm = &madera->dapm;
+	micsupp->dev = madera->dev;
+	micsupp->init_data = arizona_micsupp_ext_default;
+
+	return arizona_micsupp_common_init(pdev, micsupp, &madera_micsupp,
+					   &madera->pdata.micvdd);
+}
+
 static struct platform_driver arizona_micsupp_driver = {
 	.probe = arizona_micsupp_probe,
 	.driver		= {
@@ -328,10 +372,35 @@ static int arizona_micsupp_probe(struct platform_device *pdev)
 	},
 };
 
-module_platform_driver(arizona_micsupp_driver);
+static struct platform_driver madera_micsupp_driver = {
+	.probe = madera_micsupp_probe,
+	.driver		= {
+		.name	= "madera-micsupp",
+	},
+};
+
+static struct platform_driver * const arizona_micsupp_drivers[] = {
+	&arizona_micsupp_driver,
+	&madera_micsupp_driver,
+};
+
+static int __init arizona_micsupp_init(void)
+{
+	return platform_register_drivers(arizona_micsupp_drivers,
+					 ARRAY_SIZE(arizona_micsupp_drivers));
+}
+module_init(arizona_micsupp_init);
+
+static void __exit arizona_micsupp_exit(void)
+{
+	platform_unregister_drivers(arizona_micsupp_drivers,
+				    ARRAY_SIZE(arizona_micsupp_drivers));
+}
+module_exit(arizona_micsupp_exit);
 
 /* Module information */
 MODULE_AUTHOR("Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>");
 MODULE_DESCRIPTION("Arizona microphone supply driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:arizona-micsupp");
+MODULE_ALIAS("platform:madera-micsupp");
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
