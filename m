From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v5 7/8] ASoC: fsl-ssi: reorder and document fsl_ssi_private
Date: Tue, 27 May 2014 10:24:24 +0200
Message-ID: <1401179065-31195-8-git-send-email-mpa@pengutronix.de>
References: <1401179065-31195-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1401179065-31195-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Alexander Shiyan <shc_work@mail.ru>, Timur Tabi <timur@tabi.org>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, kernel@pengutronix.de, Nicolin Chen <Guangyu.Chen@freescale.com>, Markus Pargmann <mpa@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Reorder all variables in struct fsl_ssi_private to have groups that make
sense together. The patch also updates the struct documentation.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Tested-By: Michael Grzeschik <mgr@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 58 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 43 insertions(+), 15 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index ac78660..9fe3a10 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -141,36 +141,64 @@ struct fsl_ssi_soc_data {
 /**
  * fsl_ssi_private: per-SSI private data
  *
- * @ssi: pointer to the SSI's registers
- * @ssi_phys: physical address of the SSI registers
+ * @ssi: Pointer to the memory area
  * @irq: IRQ of this SSI
- * @playback: the number of playback streams opened
- * @capture: the number of capture streams opened
- * @cpu_dai: the CPU DAI for this device
- * @dev_attr: the sysfs device attribute structure
- * @stats: SSI statistics
+ * @cpu_dai_drv: CPU DAI driver for this device
+ *
+ * @dai_fmt: DAI configuration this device is currently used with
+ * @i2s_mode: i2s and network mode configuration of the device. Is used to
+ * switch between normal and i2s/network mode
+ * mode depending on the number of channels
+ * @use_dma: DMA is used or FIQ with stream filter
+ * @use_dual_fifo: DMA with support for both FIFOs used
+ * @fifo_deph: Depth of the SSI FIFOs
+ * @rxtx_reg_val: Specific register settings for receive/transmit configuration
+ *
+ * @clk: SSI clock
+ * @baudclk: SSI baud clock for master mode
+ * @baudclk_streams: Active streams that are using baudclk
+ * @bitclk_freq: bitclock frequency set by .set_dai_sysclk
+ *
+ * @dma_params_tx: DMA transmit parameters
+ * @dma_params_rx: DMA receive parameters
+ * @ssi_phys: physical address of the SSI registers
+ *
+ * @fiq_params: FIQ stream filtering parameters
+ *
+ * @pdev: Pointer to pdev used for deprecated fsl-ssi sound card
+ *
+ * @dbg_stats: Debugging statistics
+ *
+ * @soc: SoC specifc data
  */
 struct fsl_ssi_private {
 	struct ccsr_ssi __iomem *ssi;
-	dma_addr_t ssi_phys;
 	unsigned int irq;
-	unsigned int fifo_depth;
 	struct snd_soc_dai_driver cpu_dai_drv;
-	struct platform_device *pdev;
-	unsigned int dai_fmt;
 
+	unsigned int dai_fmt;
+	u8 i2s_mode;
 	bool use_dma;
 	bool use_dual_fifo;
-	u8 i2s_mode;
-	struct clk *baudclk;
+	unsigned int fifo_depth;
+	struct fsl_ssi_rxtx_reg_val rxtx_reg_val;
+
 	struct clk *clk;
+	struct clk *baudclk;
 	unsigned int baudclk_streams;
 	unsigned int bitclk_freq;
+
+	/* DMA params */
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
+	dma_addr_t ssi_phys;
+
+	/* params for non-dma FIQ stream filtered mode */
 	struct imx_pcm_fiq_params fiq_params;
-	/* Register values for rx/tx configuration */
-	struct fsl_ssi_rxtx_reg_val rxtx_reg_val;
+
+	/* Used when using fsl-ssi as sound-card. This is only used by ppc and
+	 * should be replaced with simple-sound-card. */
+	struct platform_device *pdev;
 
 	struct fsl_ssi_dbg dbg_stats;
 
-- 
2.0.0.rc2
