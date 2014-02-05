From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 4/8] regulator: da9055: Add DT support
Date: Wed, 5 Feb 2014 17:48:35 +0000
Message-ID: <6d76ae40cd435eaae0323f3e806515130b06a376.1391614923.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1391614923.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com
 [193.109.254.107])
 by alsa0.perex.cz (Postfix) with ESMTP id 10020265025
 for <alsa-devel@alsa-project.org>; Wed,  5 Feb 2014 18:48:39 +0100 (CET)
In-Reply-To: <cover.1391614923.git.Adam.Thomson.Opensource@diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Alessandro Zummo <a.zummo@towertech.it>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Guenter Roeck <linux@roeck-us.net>
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 drivers/regulator/da9055-regulator.c |   59 +++++++++++++++++++++++++++++++---
 1 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/da9055-regulator.c b/drivers/regulator/da9055-regulator.c
index 7f34020..bc41137 100644
--- a/drivers/regulator/da9055-regulator.c
+++ b/drivers/regulator/da9055-regulator.c
@@ -19,6 +19,10 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
+#ifdef CONFIG_OF
+#include <linux/of.h>
+#include <linux/regulator/of_regulator.h>
+#endif /* CONFIG_OF */

 #include <linux/mfd/da9055/core.h>
 #include <linux/mfd/da9055/reg.h>
@@ -446,6 +450,9 @@ static int da9055_gpio_init(struct da9055_regulator *regulator,
 	struct da9055_regulator_info *info = regulator->info;
 	int ret = 0;

+	if (!pdata)
+		return 0;
+
 	if (pdata->gpio_ren && pdata->gpio_ren[id]) {
 		char name[18];
 		int gpio_mux = pdata->gpio_ren[id];
@@ -530,6 +537,46 @@ static inline struct da9055_regulator_info *find_regulator_info(int id)
 	return NULL;
 }

+#ifdef CONFIG_OF
+static int da9055_regulator_dt_init(struct platform_device *pdev,
+				    struct da9055_regulator *regulator,
+				    struct regulator_config *config)
+{
+	struct device_node *nproot, *np;
+
+	nproot = of_node_get(pdev->dev.parent->of_node);
+	if (!nproot)
+		return -ENODEV;
+
+	nproot = of_find_node_by_name(nproot, "regulators");
+	if (!nproot)
+		return -ENODEV;
+
+	for_each_child_of_node(nproot, np) {
+		if (!of_node_cmp(np->name,
+				 regulator->info->reg_desc.name)) {
+			config->init_data = of_get_regulator_init_data(
+				&pdev->dev, np);
+			config->of_node = np;
+			break;
+		}
+	}
+	of_node_put(nproot);
+
+	if (!config->of_node)
+		return -ENODEV;
+
+	return 0;
+}
+#else
+static inline da9055_regulator_dt_init(struct platform_device *pdev,
+				       struct da9055_regulator *regulator,
+				       struct regulator_config *config)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_OF */
+
 static int da9055_regulator_probe(struct platform_device *pdev)
 {
 	struct regulator_config config = { };
@@ -538,9 +585,6 @@ static int da9055_regulator_probe(struct platform_device *pdev)
 	struct da9055_pdata *pdata = dev_get_platdata(da9055->dev);
 	int ret, irq;

-	if (pdata == NULL || pdata->regulators[pdev->id] == NULL)
-		return -ENODEV;
-
 	regulator = devm_kzalloc(&pdev->dev, sizeof(struct da9055_regulator),
 				 GFP_KERNEL);
 	if (!regulator)
@@ -559,6 +603,11 @@ static int da9055_regulator_probe(struct platform_device *pdev)

 	if (pdata && pdata->regulators)
 		config.init_data = pdata->regulators[pdev->id];
+	else {
+		ret = da9055_regulator_dt_init(pdev, regulator, &config);
+		if (ret < 0)
+			return ret;
+	}

 	ret = da9055_gpio_init(regulator, &config, pdata, pdev->id);
 	if (ret < 0)
@@ -575,8 +624,8 @@ static int da9055_regulator_probe(struct platform_device *pdev)

 	/* Only LDO 5 and 6 has got the over current interrupt */
 	if (pdev->id == DA9055_ID_LDO5 || pdev->id ==  DA9055_ID_LDO6) {
-		irq = platform_get_irq_byname(pdev, "REGULATOR");
-		irq = regmap_irq_get_virq(da9055->irq_data, irq);
+		irq = regmap_irq_get_virq(da9055->irq_data,
+					  DA9055_IRQ_REGULATOR);
 		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 						da9055_ldo5_6_oc_irq,
 						IRQF_TRIGGER_HIGH |
--
1.7.0.4
