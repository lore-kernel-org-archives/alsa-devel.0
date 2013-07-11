From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 5/6] ASoC: omap-mcbsp: Use different method for
	DMA request when booted with DT
Date: Thu, 11 Jul 2013 12:18:49 +0200
Message-ID: <1373537930-10467-6-git-send-email-peter.ujfalusi@ti.com>
References: <1373537930-10467-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id B5F82265056
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2013 12:19:03 +0200 (CEST)
In-Reply-To: <1373537930-10467-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

The DMA resource no longer available via this API when booting with DT.
When the board is booted with DT do not use platform_get_resource_byname(),
instead configure the dma_data.dma_name so omap-pcm can use different path
to request the DMA channel.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/mcbsp.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index eb68c7d..c2f20d1 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -1012,28 +1012,33 @@ int omap_mcbsp_init(struct platform_device *pdev)
 		}
 	}
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
-	if (!res) {
-		dev_err(&pdev->dev, "invalid rx DMA channel\n");
-		return -ENODEV;
-	}
-	/* RX DMA request number, and port address configuration */
-	mcbsp->dma_req[1] = res->start;
-	mcbsp->dma_data[1].filter_data = &mcbsp->dma_req[1];
-	mcbsp->dma_data[1].addr = omap_mcbsp_dma_reg_params(mcbsp, 1);
-	mcbsp->dma_data[1].maxburst = 4;
+	if (!pdev->dev.of_node) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
+		if (!res) {
+			dev_err(&pdev->dev, "invalid tx DMA channel\n");
+			return -ENODEV;
+		}
+		mcbsp->dma_req[0] = res->start;
+		mcbsp->dma_data[0].filter_data = &mcbsp->dma_req[0];
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
-	if (!res) {
-		dev_err(&pdev->dev, "invalid tx DMA channel\n");
-		return -ENODEV;
+		res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
+		if (!res) {
+			dev_err(&pdev->dev, "invalid rx DMA channel\n");
+			return -ENODEV;
+		}
+		mcbsp->dma_req[1] = res->start;
+		mcbsp->dma_data[1].filter_data = &mcbsp->dma_req[1];
+	} else {
+		mcbsp->dma_data[0].dma_name = "tx";
+		mcbsp->dma_data[1].dma_name = "rx";
 	}
-	/* TX DMA request number, and port address configuration */
-	mcbsp->dma_req[0] = res->start;
-	mcbsp->dma_data[0].filter_data = &mcbsp->dma_req[0];
+
 	mcbsp->dma_data[0].addr = omap_mcbsp_dma_reg_params(mcbsp, 0);
 	mcbsp->dma_data[0].maxburst = 4;
 
+	mcbsp->dma_data[1].addr = omap_mcbsp_dma_reg_params(mcbsp, 1);
+	mcbsp->dma_data[1].maxburst = 4;
+
 	mcbsp->fclk = clk_get(&pdev->dev, "fck");
 	if (IS_ERR(mcbsp->fclk)) {
 		ret = PTR_ERR(mcbsp->fclk);
-- 
1.8.2.1
