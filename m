From: Alexander Stein <alexanders83@web.de>
Subject: [PATCH v2] ALSA: sound/atmel/ac97c.c: Add device tree
	support
Date: Wed, 10 Dec 2014 20:59:36 +0100
Message-ID: <1418241578-17049-1-git-send-email-alexanders83@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by alsa0.perex.cz (Postfix) with ESMTP id E9CB32605A3
 for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2014 20:59:55 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Alexander Stein <alexanders83@web.de>, alsa-devel@alsa-project.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

This adds device tree support for the AC97 controller. It uses the
soc-ac97link bindings, but actually only ac97-reset is used.

Signed-off-by: Alexander Stein <alexanders83@web.de>
---
Changes in v2:
* It now uses the soc-ac97link bindings (partly) instead of defining its own.
  This should ease the transition to ASoC once a new driver has been written.

 sound/atmel/ac97c.c | 45 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index cb44c74..73b61b2 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -22,6 +22,9 @@
 #include <linux/gpio.h>
 #include <linux/types.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/of_device.h>
 
 #include <sound/core.h>
 #include <sound/initval.h>
@@ -902,6 +905,40 @@ static void atmel_ac97c_reset(struct atmel_ac97c *chip)
 	}
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id atmel_ac97c_dt_ids[] = {
+	{ .compatible = "atmel,atmel_ac97c", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, atmel_ac97c_dt_ids);
+
+static struct ac97c_platform_data *atmel_ac97c_probe_dt(struct device *dev)
+{
+	struct ac97c_platform_data *pdata;
+	struct device_node *node = dev->of_node;
+	const struct of_device_id *match;
+
+	if (!node) {
+		dev_err(dev, "Device does not have associated DT data\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	pdata->reset_pin = of_get_named_gpio(dev->of_node, "ac97-gpios", 2);
+
+	return pdata;
+}
+#else
+static struct ac97c_platform_data *atmel_ac97c_probe_dt(struct device *dev)
+{
+	dev_err(dev, "no platform data defined\n");
+	return ERR_PTR(-ENXIO);
+}
+#endif
+
 static int atmel_ac97c_probe(struct platform_device *pdev)
 {
 	struct snd_card			*card;
@@ -922,10 +959,11 @@ static int atmel_ac97c_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	pdata = pdev->dev.platform_data;
+	pdata = dev_get_platdata(&pdev->dev);
 	if (!pdata) {
-		dev_dbg(&pdev->dev, "no platform data\n");
-		return -ENXIO;
+		pdata = atmel_ac97c_probe_dt(&pdev->dev);
+		if (IS_ERR(pdata))
+			return PTR_ERR(pdata);
 	}
 
 	irq = platform_get_irq(pdev, 0);
@@ -1205,6 +1243,7 @@ static struct platform_driver atmel_ac97c_driver = {
 		.name	= "atmel_ac97c",
 		.owner	= THIS_MODULE,
 		.pm	= ATMEL_AC97C_PM_OPS,
+		.of_match_table = of_match_ptr(atmel_ac97c_dt_ids),
 	},
 };
 module_platform_driver(atmel_ac97c_driver);
-- 
2.2.0
