From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 16/20] ASoC: davinci-mcasp: Data source (bus)
	selection support
Date: Thu, 14 Nov 2013 11:35:32 +0200
Message-ID: <1384421737-4467-17-git-send-email-peter.ujfalusi@ti.com>
References: <1384421737-4467-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 117A1261A40
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 10:36:18 +0100 (CET)
In-Reply-To: <1384421737-4467-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Michal Bachraty <michal.bachraty@streamunlimited.com>, nsekhar@ti.com, jsarha@ti.com, gururaja.hebbar@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

The audio data to/from McASP can be sent/received via two method:
Via the data port (preferred) or via the configuration bus.
Currently the driver assumes that all data communication will be done via
the data port.
This patch adds support for selecting the configuration port as data
interface.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 72ea458..35a6292 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -53,6 +53,8 @@ struct davinci_mcasp {
 	u8	txnumevt;
 	u8	rxnumevt;
 
+	bool	dat_port;
+
 #ifdef CONFIG_PM_SLEEP
 	struct {
 		u32	txfmtctl;
@@ -482,6 +484,7 @@ static void davinci_hw_param(struct davinci_mcasp *mcasp, int stream)
 {
 	int i, active_slots;
 	u32 mask = 0;
+	u32 busel = 0;
 
 	active_slots = (mcasp->tdm_slots > 31) ? 32 : mcasp->tdm_slots;
 	for (i = 0; i < active_slots; i++)
@@ -489,11 +492,15 @@ static void davinci_hw_param(struct davinci_mcasp *mcasp, int stream)
 
 	mcasp_clr_bits(mcasp->base + DAVINCI_MCASP_ACLKXCTL_REG, TX_ASYNC);
 
+	if (!mcasp->dat_port)
+		busel = TXSEL;
+
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		/* bit stream is MSB first  with no delay */
 		/* DSP_B mode */
 		mcasp_set_reg(mcasp->base + DAVINCI_MCASP_TXTDM_REG, mask);
-		mcasp_set_bits(mcasp->base + DAVINCI_MCASP_TXFMT_REG, TXORD);
+		mcasp_set_bits(mcasp->base + DAVINCI_MCASP_TXFMT_REG,
+			       busel | TXORD);
 
 		if ((mcasp->tdm_slots >= 2) && (mcasp->tdm_slots <= 32))
 			mcasp_mod_bits(mcasp->base + DAVINCI_MCASP_TXFMCTL_REG,
@@ -504,7 +511,8 @@ static void davinci_hw_param(struct davinci_mcasp *mcasp, int stream)
 	} else {
 		/* bit stream is MSB first with no delay */
 		/* DSP_B mode */
-		mcasp_set_bits(mcasp->base + DAVINCI_MCASP_RXFMT_REG, RXORD);
+		mcasp_set_bits(mcasp->base + DAVINCI_MCASP_RXFMT_REG,
+			       busel | RXORD);
 		mcasp_set_reg(mcasp->base + DAVINCI_MCASP_RXTDM_REG, mask);
 
 		if ((mcasp->tdm_slots >= 2) && (mcasp->tdm_slots <= 32))
@@ -928,23 +936,22 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	mcasp->version = pdata->version;
 	mcasp->txnumevt = pdata->txnumevt;
 	mcasp->rxnumevt = pdata->rxnumevt;
-	if (mcasp->version < MCASP_VERSION_3)
-		mcasp->fifo_base = DAVINCI_MCASP_V2_AFIFO_BASE;
-	else
-		mcasp->fifo_base = DAVINCI_MCASP_V3_AFIFO_BASE;
 
 	mcasp->dev = &pdev->dev;
 
 	dat = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dat");
-	if (!dat)
-		dat = mem;
+	if (dat)
+		mcasp->dat_port = true;
 
 	dma_data = &mcasp->dma_params[SNDRV_PCM_STREAM_PLAYBACK];
 	dma_data->asp_chan_q = pdata->asp_chan_q;
 	dma_data->ram_chan_q = pdata->ram_chan_q;
 	dma_data->sram_pool = pdata->sram_pool;
 	dma_data->sram_size = pdata->sram_size_playback;
-	dma_data->dma_addr = dat->start + pdata->tx_dma_offset;
+	if (dat)
+		dma_data->dma_addr = dat->start;
+	else
+		dma_data->dma_addr = mem->start + pdata->tx_dma_offset;
 
 	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 	if (res)
@@ -957,7 +964,18 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	dma_data->ram_chan_q = pdata->ram_chan_q;
 	dma_data->sram_pool = pdata->sram_pool;
 	dma_data->sram_size = pdata->sram_size_capture;
-	dma_data->dma_addr = dat->start + pdata->rx_dma_offset;
+	if (dat)
+		dma_data->dma_addr = dat->start;
+	else
+		dma_data->dma_addr = mem->start + pdata->rx_dma_offset;
+
+	if (mcasp->version < MCASP_VERSION_3) {
+		mcasp->fifo_base = DAVINCI_MCASP_V2_AFIFO_BASE;
+		/* dma_data->dma_addr is pointing to the data port address */
+		mcasp->dat_port = true;
+	} else {
+		mcasp->fifo_base = DAVINCI_MCASP_V3_AFIFO_BASE;
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
 	if (res)
-- 
1.8.4.2
