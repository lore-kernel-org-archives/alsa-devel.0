From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: davinci-mcasp: Fix dra7 DMA offset when
	using CFG port
Date: Thu, 2 Jun 2016 12:55:05 +0300
Message-ID: <20160602095505.6867-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CB0C26047C
 for <alsa-devel@alsa-project.org>; Thu,  2 Jun 2016 11:55:12 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, misael.lopez@ti.com
List-Id: alsa-devel@alsa-project.org

The TX and RX offset is different for each serializers when using the CFG
port for DMA access.
When using the CFG port only one serializer can be used per direction so
print error message and only configure the first serializer's offset.

Reported-by: Misael Lopez Cruz <misael.lopez@ti.com>
Suggested-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 56 ++++++++++++++++++++++++++++++++++++---
 sound/soc/davinci/davinci-mcasp.h |  4 +--
 2 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index e060798d94cb..f8cb3c7d3c45 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1534,8 +1534,9 @@ static struct davinci_mcasp_pdata am33xx_mcasp_pdata = {
 };
 
 static struct davinci_mcasp_pdata dra7_mcasp_pdata = {
-	.tx_dma_offset = 0x200,
-	.rx_dma_offset = 0x284,
+	/* The CFG port offset will be calculated if it is needed */
+	.tx_dma_offset = 0,
+	.rx_dma_offset = 0,
 	.version = MCASP_VERSION_4,
 };
 
@@ -1755,6 +1756,52 @@ static int davinci_mcasp_get_dma_type(struct davinci_mcasp *mcasp)
 	return PCM_EDMA;
 }
 
+static u32 davinci_mcasp_txdma_offset(struct davinci_mcasp_pdata *pdata)
+{
+	int i;
+	u32 offset = 0;
+
+	if (pdata->version != MCASP_VERSION_4)
+		return pdata->tx_dma_offset;
+
+	for (i = 0; i < pdata->num_serializer; i++) {
+		if (pdata->serial_dir[i] == TX_MODE) {
+			if (!offset) {
+				offset = DAVINCI_MCASP_TXBUF_REG(i);
+			} else {
+				pr_err("%s: Only one serializer allowed!\n",
+				       __func__);
+				break;
+			}
+		}
+	}
+
+	return offset;
+}
+
+static u32 davinci_mcasp_rxdma_offset(struct davinci_mcasp_pdata *pdata)
+{
+	int i;
+	u32 offset = 0;
+
+	if (pdata->version != MCASP_VERSION_4)
+		return pdata->rx_dma_offset;
+
+	for (i = 0; i < pdata->num_serializer; i++) {
+		if (pdata->serial_dir[i] == RX_MODE) {
+			if (!offset) {
+				offset = DAVINCI_MCASP_RXBUF_REG(i);
+			} else {
+				pr_err("%s: Only one serializer allowed!\n",
+				       __func__);
+				break;
+			}
+		}
+	}
+
+	return offset;
+}
+
 static int davinci_mcasp_probe(struct platform_device *pdev)
 {
 	struct snd_dmaengine_dai_dma_data *dma_data;
@@ -1883,7 +1930,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	if (dat)
 		dma_data->addr = dat->start;
 	else
-		dma_data->addr = mem->start + pdata->tx_dma_offset;
+		dma_data->addr = mem->start + davinci_mcasp_txdma_offset(pdata);
 
 	dma = &mcasp->dma_request[SNDRV_PCM_STREAM_PLAYBACK];
 	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
@@ -1904,7 +1951,8 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		if (dat)
 			dma_data->addr = dat->start;
 		else
-			dma_data->addr = mem->start + pdata->rx_dma_offset;
+			dma_data->addr =
+				mem->start + davinci_mcasp_rxdma_offset(pdata);
 
 		dma = &mcasp->dma_request[SNDRV_PCM_STREAM_CAPTURE];
 		res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
diff --git a/sound/soc/davinci/davinci-mcasp.h b/sound/soc/davinci/davinci-mcasp.h
index a3be108a8c17..10b52d6bdeca 100644
--- a/sound/soc/davinci/davinci-mcasp.h
+++ b/sound/soc/davinci/davinci-mcasp.h
@@ -85,9 +85,9 @@
 						(n << 2))
 
 /* Transmit Buffer for Serializer n */
-#define DAVINCI_MCASP_TXBUF_REG		0x200
+#define DAVINCI_MCASP_TXBUF_REG(n)	(0x200 + (n << 2))
 /* Receive Buffer for Serializer n */
-#define DAVINCI_MCASP_RXBUF_REG		0x280
+#define DAVINCI_MCASP_RXBUF_REG(n)	(0x280 + (n << 2))
 
 /* McASP FIFO Registers */
 #define DAVINCI_MCASP_V2_AFIFO_BASE	(0x1010)
-- 
2.8.3
