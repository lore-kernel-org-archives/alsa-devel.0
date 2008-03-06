From: Sebastian Siewior <al+sa@ml.breakpoint.cc>
Subject: Re: [RFC] add a "private" field to the ac97 struct
Date: Thu, 6 Mar 2008 18:22:25 +0100
Message-ID: <20080306172225.GA8492@Chamillionaire.breakpoint.cc>
References: <20080306164211.GA8205@Chamillionaire.breakpoint.cc>
	<1204823557.2939.5.camel@petrie.sacredspiral.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	by alsa0.perex.cz (Postfix) with ESMTP id 6498F103904
	for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2008 18:22:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1204823557.2939.5.camel@petrie.sacredspiral.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: William Pitcock <nenolod@sacredspiral.co.uk>
Cc: alsa-devel@alsa-project.org, Nicolas Pitre <nico@cam.org>
List-Id: alsa-devel@alsa-project.org

* William Pitcock | 2008-03-06 11:12:37 [-0600]:

>Hi,
Hi,

>Why not modify ucb1400_detect_irq() to get an openfirmware handle on
>PowerPC and read the resource tree at that time? This seems like a
>better approach.

That was my first approach:

---
 drivers/input/touchscreen/Kconfig      |    7 ++++
 drivers/input/touchscreen/ucb1400_ts.c |   57 +++++++++++++++++++++++++++++++-
 2 files changed, 63 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 90e8e92..8f4d752 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -185,6 +185,13 @@ config TOUCHSCREEN_UCB1400
 	  To compile this driver as a module, choose M here: the
 	  module will be called ucb1400_ts.
 
+config TOUCHSCREEN_UCB1400_OF
+	bool "Get device informations via the device tree"
+	depends on TOUCHSCREEN_UCB1400 && OF
+	help
+	  Select this option if you want to obtain interrupt information from
+	  the device tree instead of auto probing.
+
 config TOUCHSCREEN_USB_COMPOSITE
 	tristate "USB Touchscreen Driver"
 	depends on USB_ARCH_HAS_HCD
diff --git a/drivers/input/touchscreen/ucb1400_ts.c b/drivers/input/touchscreen/ucb1400_ts.c
index 607f993..9337352 100644
--- a/drivers/input/touchscreen/ucb1400_ts.c
+++ b/drivers/input/touchscreen/ucb1400_ts.c
@@ -26,6 +26,11 @@
 #include <linux/kthread.h>
 #include <linux/freezer.h>
 
+#ifdef CONFIG_TOUCHSCREEN_UCB1400_OF
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#endif
+
 #include <sound/core.h>
 #include <sound/ac97_codec.h>
 
@@ -418,6 +423,9 @@ static int ucb1400_ts_resume(struct device *dev)
 #define NO_IRQ	0
 #endif
 
+#ifdef CONFIG_TOUCHSCREEN_UCB1400_OF
+static int ucb1400_irq;
+#else
 /*
  * Try to probe our interrupt, rather than relying on lots of
  * hard-coded machine dependencies.
@@ -467,6 +475,7 @@ static int ucb1400_detect_irq(struct ucb1400 *ucb)
 
 	return 0;
 }
+#endif
 
 static int ucb1400_ts_probe(struct device *dev)
 {
@@ -491,12 +500,15 @@ static int ucb1400_ts_probe(struct device *dev)
 		error = -ENODEV;
 		goto err_free_devs;
 	}
-
+#ifdef CONFIG_TOUCHSCREEN_UCB1400_OF
+	ucb->irq = ucb1400_irq;
+#else
 	error = ucb1400_detect_irq(ucb);
 	if (error) {
 		printk(KERN_ERR "UCB1400: IRQ probe failed\n");
 		goto err_free_devs;
 	}
+#endif
 
 	error = request_irq(ucb->irq, ucb1400_hard_irq, IRQF_TRIGGER_RISING,
 				"UCB1400", ucb);
@@ -562,14 +574,57 @@ static struct device_driver ucb1400_ts_driver = {
 	.resume		= ucb1400_ts_resume,
 };
 
+#ifdef CONFIG_TOUCHSCREEN_UCB1400_OF
+static int __devinit of_ucb_probe(struct of_device *dev,
+		const struct of_device_id *match)
+{
+	struct device_node *dp = dev->node;
+
+	ucb1400_irq = irq_of_parse_and_map(dp, 0);
+	if (ucb1400_irq == IRQ_NONE)
+		return -ENODEV;
+
+	return driver_register(&ucb1400_ts_driver);
+}
+
+static int of_ucb_remove(struct of_device *dev)
+{
+	driver_unregister(&ucb1400_ts_driver);
+	return 0;
+}
+
+static struct of_device_id of_ucb_match[] = {
+	{
+		.compatible = "Phillips-ucb1400_ts",
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, of_ucb_match);
+
+static struct of_platform_driver of_ucb1400_ts_driver = {
+	.name           = "of-ucb1400_ts",
+	.match_table    = of_ucb_match,
+	.probe          = of_ucb_probe,
+	.remove         = of_ucb_remove,
+};
+#endif
+
 static int __init ucb1400_ts_init(void)
 {
+#ifdef CONFIG_TOUCHSCREEN_UCB1400_OF
+	return of_register_platform_driver(&of_ucb1400_ts_driver);
+#else
 	return driver_register(&ucb1400_ts_driver);
+#endif
 }
 
 static void __exit ucb1400_ts_exit(void)
 {
+#ifdef CONFIG_TOUCHSCREEN_UCB1400_OF
+	of_unregister_platform_driver(&of_ucb1400_ts_driver);
+#else
 	driver_unregister(&ucb1400_ts_driver);
+#endif
 }
 
 module_param(adcsync, bool, 0444);
-- 
1.5.3.5

The problem is more or less that I can't pass the value to the other
probe function and the global variable doesn't look all that pretty. Am
I missing something here?

>William

Sebastian
