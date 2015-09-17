From: Inha Song <ideal.song@samsung.com>
Subject: [alsa-devel] [PATCH] mfd: arizona: Call the runtime PM function if the
 state is runtime resumed
Date: Thu, 17 Sep 2015 17:28:47 +0900
Message-ID: <1442478527-29304-1-git-send-email-ideal.song@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, sameo@linux.intel.com, Inha Song <ideal.song@samsung.com>
List-Id: alsa-devel@alsa-project.org

This patch call runtiem PM function manually if the state is runtime resumed
before enter suspend.

This case has occurred when wake-up by the resume after entering to
suspend during the playback.
$ aplay -> runtime_resume() -> suspend() -> resume()

In this case, Can occurred an error when enter suspend.
--
[   82.559234] PM: suspend of devices complete after 57.252 msecs
[   82.567978] arizona spi1.0: Failed to read IRQ status: -108
[   82.567989] arizona spi1.0: Failed to read main IRQ status: -108
[   82.568027] arizona spi1.0: Failed to read IRQ status: -108
[   82.568036] arizona spi1.0: Failed to read main IRQ status: -108
....
So, we should call runtime_suspend() manually when enter suspend
if the state is runtime resume.

Also should call runtime_resume() when wake-up by resume if the state
was runtime resume before entering suspend.

Signed-off-by: Inha Song <ideal.song@samsung.com>
---
 drivers/mfd/arizona-core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index 908c69b..de55706 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -683,6 +683,10 @@ static int arizona_suspend(struct device *dev)
 	struct arizona *arizona = dev_get_drvdata(dev);
 
 	dev_dbg(arizona->dev, "Suspend, disabling IRQ\n");
+
+	if (!pm_runtime_status_suspended(dev))
+		arizona_runtime_suspend(dev);
+
 	disable_irq(arizona->irq);
 
 	return 0;
@@ -713,6 +717,10 @@ static int arizona_resume(struct device *dev)
 	struct arizona *arizona = dev_get_drvdata(dev);
 
 	dev_dbg(arizona->dev, "Late resume, reenabling IRQ\n");
+
+	if (!pm_runtime_status_suspended(dev))
+		arizona_runtime_resume(dev);
+
 	enable_irq(arizona->irq);
 
 	return 0;
-- 
2.0.0.390.gcb682f8
