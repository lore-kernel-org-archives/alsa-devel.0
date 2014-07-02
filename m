From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 5/5] dma: edma: Declare DMA_SLAVE_BUSWIDTH_3_BYTES as supported buswidth
Date: Wed, 2 Jul 2014 16:29:23 +0300
Message-ID: <1404307763-30557-6-git-send-email-peter.ujfalusi@ti.com>
References: <1404307763-30557-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404307763-30557-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, dan.j.williams@intel.com, lars@metafoo.de, tiwai@suse.de, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, joelf@ti.com, nsekhar@ti.com
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, dmaengine@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

eDMA can be configured for 3bytes word size for source and destination.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index d08c4dedef35..b512caf46944 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -982,6 +982,7 @@ static void __init edma_chan_init(struct edma_cc *ecc,
 
 #define EDMA_DMA_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
+				 BIT(DMA_SLAVE_BUSWIDTH_3_BYTES) | \
 				 BIT(DMA_SLAVE_BUSWIDTH_4_BYTES))
 
 static int edma_dma_device_slave_caps(struct dma_chan *dchan,
-- 
2.0.0
