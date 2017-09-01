From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/2] ALSA: atmel: convert AC97c driver to
	GPIO descriptor API
Date: Fri,  1 Sep 2017 19:15:06 +0300
Message-ID: <20170901161507.70966-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 59F27266998
 for <alsa-devel@alsa-project.org>; Fri,  1 Sep 2017 18:15:50 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolas Ferre <nicolas.ferre@microchip.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Convert the driver to use GPIO descriptor API.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/atmel/ac97c.c | 70 ++++++++---------------------------------------------
 1 file changed, 10 insertions(+), 60 deletions(-)

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index 5ffefac2fa8f..380025887aef 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -12,16 +12,15 @@
 #include <linux/bitmap.h>
 #include <linux/device.h>
 #include <linux/atmel_pdc.h>
+#include <linux/gpio/consumer.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
-#include <linux/gpio.h>
 #include <linux/types.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/of_device.h>
 
 #include <sound/core.h>
@@ -29,7 +28,6 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/ac97_codec.h>
-#include <sound/atmel-ac97c.h>
 #include <sound/memalloc.h>
 
 #include "ac97c.h"
@@ -56,7 +54,7 @@ struct atmel_ac97c {
 	void __iomem			*regs;
 	int				irq;
 	int				opened;
-	int				reset_pin;
+	struct gpio_desc		*reset_pin;
 };
 
 #define get_chip(card) ((struct atmel_ac97c *)(card)->private_data)
@@ -700,11 +698,11 @@ static void atmel_ac97c_reset(struct atmel_ac97c *chip)
 	ac97c_writel(chip, CAMR, 0);
 	ac97c_writel(chip, COMR, 0);
 
-	if (gpio_is_valid(chip->reset_pin)) {
-		gpio_set_value(chip->reset_pin, 0);
+	if (!IS_ERR(chip->reset_pin)) {
+		gpiod_set_value(chip->reset_pin, 0);
 		/* AC97 v2.2 specifications says minimum 1 us. */
 		udelay(2);
-		gpio_set_value(chip->reset_pin, 1);
+		gpiod_set_value(chip->reset_pin, 1);
 	} else {
 		ac97c_writel(chip, MR, AC97C_MR_WRST | AC97C_MR_ENA);
 		udelay(2);
@@ -712,45 +710,18 @@ static void atmel_ac97c_reset(struct atmel_ac97c *chip)
 	}
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id atmel_ac97c_dt_ids[] = {
 	{ .compatible = "atmel,at91sam9263-ac97c", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, atmel_ac97c_dt_ids);
 
-static struct ac97c_platform_data *atmel_ac97c_probe_dt(struct device *dev)
-{
-	struct ac97c_platform_data *pdata;
-	struct device_node *node = dev->of_node;
-
-	if (!node) {
-		dev_err(dev, "Device does not have associated DT data\n");
-		return ERR_PTR(-EINVAL);
-	}
-
-	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata)
-		return ERR_PTR(-ENOMEM);
-
-	pdata->reset_pin = of_get_named_gpio(dev->of_node, "ac97-gpios", 2);
-
-	return pdata;
-}
-#else
-static struct ac97c_platform_data *atmel_ac97c_probe_dt(struct device *dev)
-{
-	dev_err(dev, "no platform data defined\n");
-	return ERR_PTR(-ENXIO);
-}
-#endif
-
 static int atmel_ac97c_probe(struct platform_device *pdev)
 {
+	struct device			*dev = &pdev->dev;
 	struct snd_card			*card;
 	struct atmel_ac97c		*chip;
 	struct resource			*regs;
-	struct ac97c_platform_data	*pdata;
 	struct clk			*pclk;
 	static struct snd_ac97_bus_ops	ops = {
 		.write	= atmel_ac97c_write,
@@ -765,13 +736,6 @@ static int atmel_ac97c_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	pdata = dev_get_platdata(&pdev->dev);
-	if (!pdata) {
-		pdata = atmel_ac97c_probe_dt(&pdev->dev);
-		if (IS_ERR(pdata))
-			return PTR_ERR(pdata);
-	}
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_dbg(&pdev->dev, "could not get irq: %d\n", irq);
@@ -821,17 +785,9 @@ static int atmel_ac97c_probe(struct platform_device *pdev)
 		goto err_ioremap;
 	}
 
-	if (gpio_is_valid(pdata->reset_pin)) {
-		if (gpio_request(pdata->reset_pin, "reset_pin")) {
-			dev_dbg(&pdev->dev, "reset pin not available\n");
-			chip->reset_pin = -ENODEV;
-		} else {
-			gpio_direction_output(pdata->reset_pin, 1);
-			chip->reset_pin = pdata->reset_pin;
-		}
-	} else {
-		chip->reset_pin = -EINVAL;
-	}
+	chip->reset_pin = devm_gpiod_get_index(dev, "ac97", 2, GPIOD_OUT_HIGH);
+	if (IS_ERR(chip->reset_pin))
+		dev_dbg(dev, "reset pin not available\n");
 
 	atmel_ac97c_reset(chip);
 
@@ -871,9 +827,6 @@ static int atmel_ac97c_probe(struct platform_device *pdev)
 	return 0;
 
 err_ac97_bus:
-	if (gpio_is_valid(chip->reset_pin))
-		gpio_free(chip->reset_pin);
-
 	iounmap(chip->regs);
 err_ioremap:
 	free_irq(irq, chip);
@@ -916,9 +869,6 @@ static int atmel_ac97c_remove(struct platform_device *pdev)
 	struct snd_card *card = platform_get_drvdata(pdev);
 	struct atmel_ac97c *chip = get_chip(card);
 
-	if (gpio_is_valid(chip->reset_pin))
-		gpio_free(chip->reset_pin);
-
 	ac97c_writel(chip, CAMR, 0);
 	ac97c_writel(chip, COMR, 0);
 	ac97c_writel(chip, MR,   0);
@@ -939,7 +889,7 @@ static struct platform_driver atmel_ac97c_driver = {
 	.driver		= {
 		.name	= "atmel_ac97c",
 		.pm	= ATMEL_AC97C_PM_OPS,
-		.of_match_table = of_match_ptr(atmel_ac97c_dt_ids),
+		.of_match_table = atmel_ac97c_dt_ids,
 	},
 };
 module_platform_driver(atmel_ac97c_driver);
-- 
2.14.1
