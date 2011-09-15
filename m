From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 04/17] MFD: twl6040: Fix power on GPIO handling
Date: Thu, 15 Sep 2011 15:39:26 +0300
Message-ID: <1316090379-30760-5-git-send-email-peter.ujfalusi@ti.com>
References: <1316090379-30760-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog125.obsmtp.com (na3sys009aog125.obsmtp.com
	[74.125.149.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 70BBA103B63
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Sep 2011 14:40:18 +0200 (CEST)
Received: by mail-bw0-f45.google.com with SMTP id zv15so2811689bkb.32
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2011 05:40:17 -0700 (PDT)
In-Reply-To: <1316090379-30760-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <samuel.ortiz@intel.com>, Dmitry Torokhov <dtor@mail.ru>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Avoid requesting the audpwron gpio in case of ES1.0
revision.
In the past we requested the gpio, but we did not
free it up, since we made the check for the revision
later. This results later checks for gpio validity to
fail, leaving the gpio reserved (even after the driver
has been removed).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mfd/twl6040-core.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/twl6040-core.c b/drivers/mfd/twl6040-core.c
index 51c3b47..7dc8c47 100644
--- a/drivers/mfd/twl6040-core.c
+++ b/drivers/mfd/twl6040-core.c
@@ -470,7 +470,6 @@ static int __devinit twl6040_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, twl6040);
 
 	twl6040->dev = &pdev->dev;
-	twl6040->audpwron = pdata->audpwron_gpio;
 	twl6040->irq = pdata->naudint_irq;
 	twl6040->irq_base = pdata->irq_base;
 
@@ -480,6 +479,12 @@ static int __devinit twl6040_probe(struct platform_device *pdev)
 
 	twl6040->rev = twl6040_reg_read(twl6040, TWL6040_REG_ASICREV);
 
+	/* ERRATA: Automatic power-up is not possible in ES1.0 */
+	if (twl6040_get_revid(twl6040) > TWL6040_REV_ES1_0)
+		twl6040->audpwron = pdata->audpwron_gpio;
+	else
+		twl6040->audpwron = -EINVAL;
+
 	if (gpio_is_valid(twl6040->audpwron)) {
 		ret = gpio_request(twl6040->audpwron, "audpwron");
 		if (ret)
@@ -490,10 +495,6 @@ static int __devinit twl6040_probe(struct platform_device *pdev)
 			goto gpio2_err;
 	}
 
-	/* ERRATA: Automatic power-up is not possible in ES1.0 */
-	if (twl6040_get_revid(twl6040) == TWL6040_REV_ES1_0)
-		twl6040->audpwron = -EINVAL;
-
 	/* codec interrupt */
 	ret = twl6040_irq_init(twl6040);
 	if (ret)
-- 
1.7.6.1
