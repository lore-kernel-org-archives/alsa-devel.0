From: <oku@iki.fi>
Subject: [PATCH RFC 3/8] ASoC: davinci-mcasp: Get DMA related
	properties from DT
Date: Mon, 9 Sep 2013 18:12:14 +0300
Message-ID: <35b6dc24d8a803b97c683d4d2c51db7e3518f7ff.1378738436.git.jsarha@ti.com>
References: <cover.1378738436.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E6812650A0
 for <alsa-devel@alsa-project.org>; Mon,  9 Sep 2013 17:12:29 +0200 (CEST)
In-Reply-To: <cover.1378738436.git.jsarha@ti.com>
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
Cc: Darren Etheridge <detheridge@ti.com>, devicetree-discuss@lists.ozlabs.org, Jyri Sarha <jsarha@ti.com>, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>, liam.r.girdwood@linux.intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

From: Jyri Sarha <jsarha@ti.com>

This patch adds new DMA related properties to mcasp DT bindings. The
new properties may not be needed after davinci audio is updated to use
dmaengine.

Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
Signed-off-by: Darren Etheridge <detheridge@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 .../bindings/sound/davinci-mcasp-audio.txt         |   13 ++++++---
 sound/soc/davinci/davinci-mcasp.c                  |   28 +++++++++++++++++---
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
index 374e145..417d90e 100644
--- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
+++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
@@ -6,7 +6,10 @@ Required properties:
 	"ti,da830-mcasp-audio"	: for both DA830 & DA850 platforms
 	"ti,omap2-mcasp-audio"	: for OMAP2 platforms (TI81xx, AM33xx)
 
-- reg : Should contain McASP registers offset and length
+- reg : Should contain McASP registers offset/address and length
+      	and the following nodes contain offset/addresses and lenghts
+	for TX and RX DMA areas
+- reg-names : First node name should be "mpu" followed by "dma-tx" and "dma-rx"
 - interrupts : Interrupt number for McASP
 - op-mode : I2S/DIT ops mode.
 - tdm-slots : Slots for TDM operation.
@@ -14,7 +17,7 @@ Required properties:
 - serial-dir : A list of serializer pin mode. The list number should be equal
 		to "num-serializer" parameter. Each entry is a number indication
 		serializer pin direction. (0 - INACTIVE, 1 - TX, 2 - RX)
-
+- asp-chan-q : Selects EDMA event queue (transfer controller) to use
 
 Optional properties:
 
@@ -23,6 +26,8 @@ Optional properties:
 - rx-num-evt : FIFO levels.
 - sram-size-playback : size of sram to be allocated during playback
 - sram-size-capture  : size of sram to be allocated during capture
+- ram-chan-q : Selects EDMA event queue (transfer controller) to use for
+  	       ping-pong mode.
 
 Example:
 
@@ -30,7 +35,9 @@ mcasp0: mcasp0@1d00000 {
 	compatible = "ti,da830-mcasp-audio";
 	#address-cells = <1>;
 	#size-cells = <0>;
-	reg = <0x100000 0x3000>;
+	reg = <0x100000 0x3000>,
+	      <0x102000 0x1000>;
+	reg-names "mpu", "dma";
 	interrupts = <82 83>;
 	op-mode = <0>;		/* MCASP_IIS_MODE */
 	tdm-slots = <2>;
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index b849c9d..cc02255 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1095,6 +1095,14 @@ static struct snd_platform_data *davinci_mcasp_set_pdata_from_of(
 		pdata->serial_dir = of_serial_dir;
 	}
 
+	ret = of_property_read_u32(np, "asp-chan-q", &pdata->asp_chan_q);
+	if (ret < 0)
+		goto nodata;
+
+	ret = of_property_read_u32(np, "ram-chan-q", &val);
+	if (ret >= 0)
+		pdata->ram_chan_q = val;
+
 	ret = of_property_read_u32(np, "tx-num-evt", &val);
 	if (ret >= 0)
 		pdata->txnumevt = val;
@@ -1189,13 +1197,26 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	dev->rxnumevt = pdata->rxnumevt;
 	dev->dev = &pdev->dev;
 
+	dma = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dma-tx");
+	if (dma)
+		pdata->tx_dma_offset = dma->start;
+
+	dma = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dma-rx");
+	if (dma)
+		pdata->rx_dma_offset = dma->start;
+
+	if (dev->version == MCASP_VERSION_1 ||
+	    dev->version == MCASP_VERSION_2) {
+		pdata->tx_dma_offset += mem->start;
+		pdata->rx_dma_offset += mem->start;
+	}
+
 	dma_data = &dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK];
 	dma_data->asp_chan_q = pdata->asp_chan_q;
 	dma_data->ram_chan_q = pdata->ram_chan_q;
 	dma_data->sram_pool = pdata->sram_pool;
 	dma_data->sram_size = pdata->sram_size_playback;
-	dma_data->dma_addr = (dma_addr_t) (pdata->tx_dma_offset +
-							mem->start);
+	dma_data->dma_addr = pdata->tx_dma_offset;
 
 	/* first TX, then RX */
 	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
@@ -1212,8 +1233,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	dma_data->ram_chan_q = pdata->ram_chan_q;
 	dma_data->sram_pool = pdata->sram_pool;
 	dma_data->sram_size = pdata->sram_size_capture;
-	dma_data->dma_addr = (dma_addr_t)(pdata->rx_dma_offset +
-							mem->start);
+	dma_data->dma_addr = pdata->rx_dma_offset;
 
 	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
 	if (!res) {
-- 
1.7.9.5
