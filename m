From: Mark Brown <broonie@kernel.org>
Subject: Applied "ALSA: ac97: Switch to dev_pm_ops" to the asoc
	tree
Date: Thu, 20 Aug 2015 09:35:44 -0700
Message-ID: <E1ZSSoa-0005yW-Tu@finisterre>
References: <1438890129-32621-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6704526520A
 for <alsa-devel@alsa-project.org>; Thu, 20 Aug 2015 18:35:56 +0200 (CEST)
In-Reply-To: <1438890129-32621-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ALSA: ac97: Switch to dev_pm_ops

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From ef3c79ff372b17a407b72e26d32af28919abdf39 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Thu, 6 Aug 2015 21:42:09 +0200
Subject: [PATCH] ALSA: ac97: Switch to dev_pm_ops

Convert the ac97_bus from legacy suspend/resume callbacks to dev_pm_ops.

Since there isn't anything special to do at the bus level the bus driver
does not have to implement any callbacks. The device driver core will
automatically pick up and execute the device's PM ops.

As there is only a single AC'97 driver implementing suspend and resume,
update both the core and driver at the same time to avoid unnecessary code
churn.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/input/touchscreen/wm97xx-core.c | 13 +++++++------
 sound/ac97_bus.c                        | 26 --------------------------
 2 files changed, 7 insertions(+), 32 deletions(-)

diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
index b1ae779..1d11fd8 100644
--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -732,8 +732,8 @@ static int wm97xx_remove(struct device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int wm97xx_suspend(struct device *dev, pm_message_t state)
+#ifdef CONFIG_PM_SLEEP
+static int wm97xx_suspend(struct device *dev)
 {
 	struct wm97xx *wm = dev_get_drvdata(dev);
 	u16 reg;
@@ -799,9 +799,11 @@ static int wm97xx_resume(struct device *dev)
 	return 0;
 }
 
+static SIMPLE_DEV_PM_OPS(wm97xx_pm_ops, wm97xx_suspend, wm97xx_resume);
+#define WM97XX_PM_OPS (&wm97xx_pm_ops)
+
 #else
-#define wm97xx_suspend		NULL
-#define wm97xx_resume		NULL
+#define WM97XX_PM_OPS NULL
 #endif
 
 /*
@@ -836,8 +838,7 @@ static struct device_driver wm97xx_driver = {
 	.owner =	THIS_MODULE,
 	.probe =	wm97xx_probe,
 	.remove =	wm97xx_remove,
-	.suspend =	wm97xx_suspend,
-	.resume =	wm97xx_resume,
+	.pm =		WM97XX_PM_OPS,
 };
 
 static int __init wm97xx_init(void)
diff --git a/sound/ac97_bus.c b/sound/ac97_bus.c
index 55791a0..52e4bc5 100644
--- a/sound/ac97_bus.c
+++ b/sound/ac97_bus.c
@@ -89,35 +89,9 @@ static int ac97_bus_match(struct device *dev, struct device_driver *drv)
 	return 1;
 }
 
-#ifdef CONFIG_PM
-static int ac97_bus_suspend(struct device *dev, pm_message_t state)
-{
-	int ret = 0;
-
-	if (dev->driver && dev->driver->suspend)
-		ret = dev->driver->suspend(dev, state);
-
-	return ret;
-}
-
-static int ac97_bus_resume(struct device *dev)
-{
-	int ret = 0;
-
-	if (dev->driver && dev->driver->resume)
-		ret = dev->driver->resume(dev);
-
-	return ret;
-}
-#endif /* CONFIG_PM */
-
 struct bus_type ac97_bus_type = {
 	.name		= "ac97",
 	.match		= ac97_bus_match,
-#ifdef CONFIG_PM
-	.suspend	= ac97_bus_suspend,
-	.resume		= ac97_bus_resume,
-#endif /* CONFIG_PM */
 };
 
 static int __init ac97_bus_init(void)
-- 
2.5.0
