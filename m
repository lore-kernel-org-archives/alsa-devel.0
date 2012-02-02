From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] regulator: wm8350: Don't specify consumer
	supplies with struct device
Date: Thu,  2 Feb 2012 13:45:39 +0000
Message-ID: <1328190339-21718-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 110A4103C18
	for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2012 14:45:46 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Very, very deprecated.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/regulator/wm8350-regulator.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/wm8350-regulator.c b/drivers/regulator/wm8350-regulator.c
index 6894009..4f46067 100644
--- a/drivers/regulator/wm8350-regulator.c
+++ b/drivers/regulator/wm8350-regulator.c
@@ -1544,7 +1544,7 @@ int wm8350_register_led(struct wm8350 *wm8350, int lednum, int dcdc, int isink,
 		return -ENOMEM;
 	}
 
-	led->isink_consumer.dev = &pdev->dev;
+	led->isink_consumer.dev_name = dev_name(&pdev->dev);
 	led->isink_consumer.supply = "led_isink";
 	led->isink_init.num_consumer_supplies = 1;
 	led->isink_init.consumer_supplies = &led->isink_consumer;
@@ -1559,7 +1559,7 @@ int wm8350_register_led(struct wm8350 *wm8350, int lednum, int dcdc, int isink,
 		return ret;
 	}
 
-	led->dcdc_consumer.dev = &pdev->dev;
+	led->dcdc_consumer.dev_name = dev_name(&pdev->dev);
 	led->dcdc_consumer.supply = "led_vcc";
 	led->dcdc_init.num_consumer_supplies = 1;
 	led->dcdc_init.consumer_supplies = &led->dcdc_consumer;
-- 
1.7.9.rc1
