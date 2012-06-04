From: Richard Zhao <richard.zhao@freescale.com>
Subject: [PATCH v2 REBASE] ASoC: fsl_ssi: convert to use
	devm_clk_get
Date: Mon, 4 Jun 2012 09:42:53 +0800
Message-ID: <1338774174-3960-1-git-send-email-richard.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db3outboundpool.messaging.microsoft.com
	(db3ehsobe003.messaging.microsoft.com [213.199.154.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 48746103EDF
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jun 2012 03:43:03 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Cc: shawn.guo@linaro.org, broonie@opensource.wolfsonmicro.com, Richard Zhao <richard.zhao@freescale.com>, kernel@pengutronix.de, dong.aisheng@linaro.org, timur@freescale.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
Acked-by: Timur Tabi <timur@freescale.com>
---

Rebase to 3.5rc1.

 sound/soc/fsl/fsl_ssi.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 4ed2afd..b10a427 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -725,7 +725,7 @@ static int __devinit fsl_ssi_probe(struct platform_device *pdev)
 		u32 dma_events[2];
 		ssi_private->ssi_on_imx = true;
 
-		ssi_private->clk = clk_get(&pdev->dev, NULL);
+		ssi_private->clk = devm_clk_get(&pdev->dev, NULL);
 		if (IS_ERR(ssi_private->clk)) {
 			ret = PTR_ERR(ssi_private->clk);
 			dev_err(&pdev->dev, "could not get clock: %d\n", ret);
@@ -842,10 +842,8 @@ error_dev:
 	device_remove_file(&pdev->dev, dev_attr);
 
 error_clk:
-	if (ssi_private->ssi_on_imx) {
+	if (ssi_private->ssi_on_imx)
 		clk_disable_unprepare(ssi_private->clk);
-		clk_put(ssi_private->clk);
-	}
 
 error_irq:
 	free_irq(ssi_private->irq, ssi_private);
@@ -871,7 +869,6 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 	if (ssi_private->ssi_on_imx) {
 		platform_device_unregister(ssi_private->imx_pcm_pdev);
 		clk_disable_unprepare(ssi_private->clk);
-		clk_put(ssi_private->clk);
 	}
 	snd_soc_unregister_dai(&pdev->dev);
 	device_remove_file(&pdev->dev, &ssi_private->dev_attr);
-- 
1.7.5.4
