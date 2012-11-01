From: Alexandre Belloni <alexandre.belloni@piout.net>
Subject: [PATCH] ASoC: atmel_ssc_dai: make module reloadable
Date: Thu,  1 Nov 2012 14:18:02 +0100
Message-ID: <1351775882-15834-1-git-send-email-alexandre.belloni@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from narya.piout.net (128-79-244-21.hfc.dyn.abo.bbox.fr
 [128.79.244.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 916D92625ED
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2012 19:42:06 +0100 (CET)
Resent-Message-ID: <20121101184151.GA14207@piout.net>
Resent-To: alsa-devel@alsa-project.org
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Alexandre Belloni <alexandre.belloni@piout.net>, Nicolas Ferre <nicolas.ferre@atmel.com>
List-Id: alsa-devel@alsa-project.org

As the platform_devices were never unregistered, it was not possible to
unload/reload the module.

Signed-off-by: Alexandre Belloni <alexandre.belloni@piout.net>
---
 sound/soc/atmel/atmel_ssc_dai.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 354341e..07ee57b 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -155,6 +155,8 @@ static struct atmel_ssc_info ssc_info[NUM_SSC_DEVICES] = {
 #endif
 };
 
+static struct platform_device *dma_pdev;
+static struct platform_device *ssc_pdevs[NUM_SSC_DEVICES];
 
 /*
  * SSC interrupt handler.  Passes PDC interrupts to the DMA
@@ -796,6 +798,12 @@ static __devinit int asoc_ssc_probe(struct platform_device *pdev)
 
 static int __devexit asoc_ssc_remove(struct platform_device *pdev)
 {
+	int i;
+	platform_device_unregister(dma_pdev);
+
+	for(i = 0; i < NUM_SSC_DEVICES; i++)
+		platform_device_unregister(ssc_pdevs[i]);
+
 	snd_soc_unregister_dai(&pdev->dev);
 	return 0;
 }
@@ -816,7 +824,6 @@ static struct platform_driver asoc_ssc_driver = {
 int atmel_ssc_set_audio(int ssc_id)
 {
 	struct ssc_device *ssc;
-	static struct platform_device *dma_pdev;
 	struct platform_device *ssc_pdev;
 	int ret;
 
@@ -855,6 +862,8 @@ int atmel_ssc_set_audio(int ssc_id)
 	if (ret < 0)
 		platform_device_put(ssc_pdev);
 
+	ssc_pdevs[ssc_id] = ssc_pdev;
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(atmel_ssc_set_audio);
-- 
1.7.9.5
