From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [RFC PATCH 2/5] OMAP3: McBSP: Change the way how the
	FIFO is handled
Date: Mon, 31 May 2010 11:03:23 +0300
Message-ID: <1275293006-31594-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1275293006-31594-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id A520D24335
	for <alsa-devel@alsa-project.org>;
	Mon, 31 May 2010 10:03:50 +0200 (CEST)
In-Reply-To: <1275293006-31594-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-oamp@vger.kernel.org
Cc: tony@atomide.com, broonie@opensource.wolfsonmicro.com, eduardo.valentin@nokia.com, ext-eero.nurkkala@nokia.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Use the actual FIFO size in words as buffer_size on OMAP2.
Change the threshold configuration to use 1 based numbering, when
specifying the allowed threshold maximum or the McBSP threshold value.
Set the default maximum threshold to (buffer_size - 0x10) intialy.
>From users of McBSP, now it is expected to use this method.
Asking for threshold 1 means that the value written to threshold registers
are going to be 0, which means 1 word threshold.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 arch/arm/mach-omap2/mcbsp.c |   10 +++++-----
 arch/arm/plat-omap/mcbsp.c  |   10 ++++++----
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index 016fe60..9139958 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -132,7 +132,7 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP1_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP1_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.buffer_size	= 0x6F,
+		.buffer_size	= 0x80,
 	},
 	{
 		.phys_base	= OMAP34XX_MCBSP2_BASE,
@@ -142,7 +142,7 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP2_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.buffer_size	= 0x3FF,
+		.buffer_size	= 0x500,
 	},
 	{
 		.phys_base	= OMAP34XX_MCBSP3_BASE,
@@ -152,7 +152,7 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP3_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP3_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.buffer_size	= 0x6F,
+		.buffer_size	= 0x80,
 	},
 	{
 		.phys_base	= OMAP34XX_MCBSP4_BASE,
@@ -161,7 +161,7 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP4_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP4_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.buffer_size	= 0x6F,
+		.buffer_size	= 0x80,
 	},
 	{
 		.phys_base	= OMAP34XX_MCBSP5_BASE,
@@ -170,7 +170,7 @@ static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
 		.rx_irq		= INT_24XX_MCBSP5_IRQ_RX,
 		.tx_irq		= INT_24XX_MCBSP5_IRQ_TX,
 		.ops		= &omap2_mcbsp_ops,
-		.buffer_size	= 0x6F,
+		.buffer_size	= 0x80,
 	},
 };
 #define OMAP34XX_MCBSP_PDATA_SZ		ARRAY_SIZE(omap34xx_mcbsp_pdata)
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 51d8abf..6462968 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -497,7 +497,8 @@ void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold)
 	}
 	mcbsp = id_to_mcbsp_ptr(id);
 
-	MCBSP_WRITE(mcbsp, THRSH2, threshold);
+	if (threshold && threshold <= mcbsp->max_tx_thres)
+		MCBSP_WRITE(mcbsp, THRSH2, threshold - 1);
 }
 EXPORT_SYMBOL(omap_mcbsp_set_tx_threshold);
 
@@ -519,7 +520,8 @@ void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold)
 	}
 	mcbsp = id_to_mcbsp_ptr(id);
 
-	MCBSP_WRITE(mcbsp, THRSH1, threshold);
+	if (threshold && threshold <= mcbsp->max_rx_thres)
+		MCBSP_WRITE(mcbsp, THRSH1, threshold - 1);
 }
 EXPORT_SYMBOL(omap_mcbsp_set_rx_threshold);
 
@@ -1696,8 +1698,8 @@ static inline void __devinit omap34xx_device_init(struct omap_mcbsp *mcbsp)
 {
 	mcbsp->dma_op_mode = MCBSP_DMA_MODE_ELEMENT;
 	if (cpu_is_omap34xx()) {
-		mcbsp->max_tx_thres = max_thres(mcbsp);
-		mcbsp->max_rx_thres = max_thres(mcbsp);
+		mcbsp->max_tx_thres = max_thres(mcbsp) - 0x10;
+		mcbsp->max_rx_thres = max_thres(mcbsp) - 0x10;
 		/*
 		 * REVISIT: Set dmap_op_mode to THRESHOLD as default
 		 * for mcbsp2 instances.
-- 
1.7.1
