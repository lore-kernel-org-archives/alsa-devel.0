From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH 2/2] ASoC: atmel-ssc: use
	module_platform_driver macro
Date: Tue, 16 Oct 2012 11:56:59 +0800
Message-ID: <1350359819-2461-2-git-send-email-voice.shen@atmel.com>
References: <1350359819-2461-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
 by alsa0.perex.cz (Postfix) with ESMTP id 57D322650A7
 for <alsa-devel@alsa-project.org>; Tue, 16 Oct 2012 05:59:20 +0200 (CEST)
In-Reply-To: <1350359819-2461-1-git-send-email-voice.shen@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, nicolas.ferre@atmel.com, linux-sound@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, plagnioj@jcrosoft.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This patch removes some code duplication by using module_platform_driver

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 drivers/misc/atmel-ssc.c |   18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index 23dcb76..ac00f83 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -68,7 +68,7 @@ void ssc_free(struct ssc_device *ssc)
 }
 EXPORT_SYMBOL(ssc_free);
 
-static int __init ssc_probe(struct platform_device *pdev)
+static int ssc_probe(struct platform_device *pdev)
 {
 	struct resource *regs;
 	struct ssc_device *ssc;
@@ -135,24 +135,14 @@ static int __devexit ssc_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver ssc_driver = {
-	.remove		= __devexit_p(ssc_remove),
 	.driver		= {
 		.name		= "ssc",
 		.owner		= THIS_MODULE,
 	},
+	.probe		= ssc_probe,
+	.remove		= __devexit_p(ssc_remove),
 };
-
-static int __init ssc_init(void)
-{
-	return platform_driver_probe(&ssc_driver, ssc_probe);
-}
-module_init(ssc_init);
-
-static void __exit ssc_exit(void)
-{
-	platform_driver_unregister(&ssc_driver);
-}
-module_exit(ssc_exit);
+module_platform_driver(ssc_driver);
 
 MODULE_AUTHOR("Hans-Christian Egtvedt <hcegtvedt@atmel.com>");
 MODULE_DESCRIPTION("SSC driver for Atmel AVR32 and AT91");
-- 
1.7.9.5
