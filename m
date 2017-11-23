From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH v6 08/17] regulator: arizona-ldo1: Add support
	for Cirrus Logic Madera codecs
Date: Thu, 23 Nov 2017 17:13:07 +0000
Message-ID: <20171123171316.10868-9-rf@opensource.wolfsonmicro.com>
References: <20171123171316.10868-1-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id A93AF267345
 for <alsa-devel@alsa-project.org>; Thu, 23 Nov 2017 18:13:26 +0100 (CET)
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This adds a new driver identity "madera-ldo1" and probe function
so that this driver can be used to control the LDO1 regulator on
some Cirrus Logic Madera codecs.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 drivers/regulator/Kconfig        |  8 ++--
 drivers/regulator/arizona-ldo1.c | 82 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 85 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 53639a6bd888..3db4f994aea8 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -126,12 +126,12 @@ config REGULATOR_AB8500
 	  signal AB8500 PMIC
 
 config REGULATOR_ARIZONA_LDO1
-	tristate "Wolfson Arizona class devices LDO1"
-	depends on MFD_ARIZONA
+	tristate "Cirrus Madera and Wolfson Arizona class devices LDO1"
+	depends on MFD_ARIZONA || MFD_MADERA
 	depends on SND_SOC
 	help
-	  Support for the LDO1 regulators found on Wolfson Arizona class
-	  devices.
+	  Support for the LDO1 regulators found on Cirrus Logic Madera codecs
+	  and Wolfson Arizona codecs.
 
 config REGULATOR_ARIZONA_MICSUPP
 	tristate "Cirrus Madera and Wolfson Arizona class devices MICSUPP"
diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index 96fddfff5dc4..c64625e76124 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -31,6 +31,10 @@
 #include <linux/mfd/arizona/pdata.h>
 #include <linux/mfd/arizona/registers.h>
 
+#include <linux/mfd/madera/core.h>
+#include <linux/mfd/madera/pdata.h>
+#include <linux/mfd/madera/registers.h>
+
 struct arizona_ldo1 {
 	struct regulator_dev *regulator;
 	struct regmap *regmap;
@@ -188,6 +192,31 @@ static const struct regulator_init_data arizona_ldo1_wm5110 = {
 	.num_consumer_supplies = 1,
 };
 
+static const struct regulator_desc madera_ldo1 = {
+	.name = "LDO1",
+	.supply_name = "LDOVDD",
+	.type = REGULATOR_VOLTAGE,
+	.ops = &arizona_ldo1_ops,
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
 static int arizona_ldo1_of_get_pdata(struct arizona_ldo1_pdata *pdata,
 				     struct regulator_config *config,
 				     const struct regulator_desc *desc,
@@ -341,6 +370,32 @@ static int arizona_ldo1_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int madera_ldo1_probe(struct platform_device *pdev)
+{
+	struct madera *madera = dev_get_drvdata(pdev->dev.parent);
+	struct arizona_ldo1 *ldo1;
+	bool external_dcvdd;
+	int ret;
+
+	ldo1 = devm_kzalloc(&pdev->dev, sizeof(*ldo1), GFP_KERNEL);
+	if (!ldo1)
+		return -ENOMEM;
+
+	ldo1->regmap = madera->regmap;
+
+	ldo1->init_data = madera_ldo1_default;
+
+	ret = arizona_ldo1_common_init(pdev, ldo1, &arizona_ldo1,
+				       &madera->pdata.ldo1,
+				       &external_dcvdd);
+	if (ret)
+		return ret;
+
+	madera->internal_dcvdd = !external_dcvdd;
+
+	return 0;
+}
+
 static struct platform_driver arizona_ldo1_driver = {
 	.probe = arizona_ldo1_probe,
 	.driver		= {
@@ -348,10 +403,35 @@ static struct platform_driver arizona_ldo1_driver = {
 	},
 };
 
-module_platform_driver(arizona_ldo1_driver);
+static struct platform_driver madera_ldo1_driver = {
+	.probe = madera_ldo1_probe,
+	.driver		= {
+		.name	= "madera-ldo1",
+	},
+};
+
+static struct platform_driver * const madera_ldo1_drivers[] = {
+	&arizona_ldo1_driver,
+	&madera_ldo1_driver,
+};
+
+static int __init arizona_ldo1_init(void)
+{
+	return platform_register_drivers(madera_ldo1_drivers,
+					 ARRAY_SIZE(madera_ldo1_drivers));
+}
+module_init(arizona_ldo1_init);
+
+static void __exit madera_ldo1_exit(void)
+{
+	platform_unregister_drivers(madera_ldo1_drivers,
+				    ARRAY_SIZE(madera_ldo1_drivers));
+}
+module_exit(madera_ldo1_exit);
 
 /* Module information */
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
 MODULE_DESCRIPTION("Arizona LDO1 driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:arizona-ldo1");
+MODULE_ALIAS("platform:madera-ldo1");
-- 
2.11.0
