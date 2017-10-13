From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH] dmaengine: imx-sdma: advertise all supported
	slave bus widths
Date: Fri, 13 Oct 2017 12:43:46 +0200
Message-ID: <20171013104346.16818-1-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.4.pengutronix.de (metis.ext.4.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 5CBF6266EE0
 for <alsa-devel@alsa-project.org>; Fri, 13 Oct 2017 12:43:51 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org
Cc: alsa-devel@alsa-project.org, patchwork-lst@pengutronix.de, broonie@kernel.org, kernel@pengutronix.de, peter.seiderer.ext@zeiss.com, LW@KARO-electronics.de
List-Id: alsa-devel@alsa-project.org

The commit [1] which changed imx-pcm-dma to derive the pcm_config from the
attached dmaengine introduced a regression on the supported sample formats,
as imx-sdma doesn't properly advertise all the supported slave bus widths.

Fix this to restore full functionality of the imx sound subsystem.

[1] 70d435ba1cd6 ("ASoC: imx-pcm-dma: simplify pcm_config")
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/dma/imx-sdma.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index a67ec1bdc4e0..e374183f19d0 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1851,8 +1851,12 @@ static int sdma_probe(struct platform_device *pdev)
 	sdma->dma_device.device_prep_dma_cyclic = sdma_prep_dma_cyclic;
 	sdma->dma_device.device_config = sdma_config;
 	sdma->dma_device.device_terminate_all = sdma_disable_channel_with_delay;
-	sdma->dma_device.src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
-	sdma->dma_device.dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	sdma->dma_device.src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
+					   BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
+					   BIT(DMA_SLAVE_BUSWIDTH_1_BYTE);
+	sdma->dma_device.dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
+					   BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
+					   BIT(DMA_SLAVE_BUSWIDTH_1_BYTE);
 	sdma->dma_device.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	sdma->dma_device.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
 	sdma->dma_device.device_issue_pending = sdma_issue_pending;
-- 
2.11.0
