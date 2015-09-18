From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: davinci-mcasp: Fix devm_kasprintf format
	string
Date: Fri, 18 Sep 2015 15:02:50 +0300
Message-ID: <1442577770-30650-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 86198260412
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2015 14:02:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, jsarha@ti.com, daniel@zonque.org
List-Id: alsa-devel@alsa-project.org

The '\n' at the end of the format string is not needed. It adds an extra
line break when doing
cat /proc/interrupts

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 1260b315a96c..e631f96f9cf7 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1684,7 +1684,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq_byname(pdev, "common");
 	if (irq >= 0) {
-		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_common\n",
+		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_common",
 					  dev_name(&pdev->dev));
 		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 						davinci_mcasp_common_irq_handler,
@@ -1701,7 +1701,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq_byname(pdev, "rx");
 	if (irq >= 0) {
-		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_rx\n",
+		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_rx",
 					  dev_name(&pdev->dev));
 		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 						davinci_mcasp_rx_irq_handler,
@@ -1716,7 +1716,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq_byname(pdev, "tx");
 	if (irq >= 0) {
-		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_tx\n",
+		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_tx",
 					  dev_name(&pdev->dev));
 		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 						davinci_mcasp_tx_irq_handler,
-- 
2.5.2
