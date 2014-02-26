From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 10/15] ASoC: fsl-ssi: reorder and document fsl_ssi_private
Date: Wed, 26 Feb 2014 17:02:13 +0100
Message-ID: <1393430538-32333-11-git-send-email-mpa@pengutronix.de>
References: <1393430538-32333-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1393430538-32333-1-git-send-email-mpa@pengutronix.de>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, kernel@pengutronix.de, Nicolin Chen <Guangyu.Chen@freescale.com>, Markus Pargmann <mpa@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Reorder all variables in struct fsl_ssi_private to have groups that make
sense together. The patch also updates the struct documentation.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 56 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 28bde80..f5e43bb 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -125,36 +125,60 @@ static const struct regmap_config fsl_ssi_regconfig = {
 /**
  * fsl_ssi_private: per-SSI private data
  *
- * @ssi: pointer to the SSI's registers
- * @ssi_phys: physical address of the SSI registers
+ * @regs: Registers regmap pointer
  * @irq: IRQ of this SSI
- * @playback: the number of playback streams opened
- * @capture: the number of capture streams opened
- * @cpu_dai: the CPU DAI for this device
- * @dev_attr: the sysfs device attribute structure
- * @stats: SSI statistics
+ * @cpu_dai_drv: CPU DAI driver for this device
+ *
+ * @hw_type: Hardware type this device is used in
+ * @dai_fmt: DAI configuration this device is currently used with
+ * @use_dma: DMA is used or FIQ with stream filter
+ * @use_dual_fifo: DMA with support for both FIFOs used
+ * @fifo_deph: Depth of the SSI FIFOs
+ * @rxtx_reg_val: Specific register settings for receive/transmit configuration
+ *
+ * @clk: SSI clock
+ * @baudclk: SSI baud clock for master mode
+ * @baudclk_locked: SSI baudclk is locked because it is in use
+ * @baudclk_lock: spinlock for baudclk_locked variable
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
  */
 struct fsl_ssi_private {
 	struct regmap *regs;
-	dma_addr_t ssi_phys;
 	unsigned int irq;
-	unsigned int fifo_depth;
 	struct snd_soc_dai_driver cpu_dai_drv;
-	struct platform_device *pdev;
-	unsigned int dai_fmt;
 
 	enum fsl_ssi_type hw_type;
+	unsigned int dai_fmt;
 	bool use_dma;
-	bool baudclk_locked;
 	bool use_dual_fifo;
-	spinlock_t baudclk_lock;
-	struct clk *baudclk;
+	unsigned int fifo_depth;
+	struct fsl_ssi_rxtx_reg_val rxtx_reg_val;
+
 	struct clk *clk;
+	struct clk *baudclk;
+	bool baudclk_locked;
+	spinlock_t baudclk_lock;
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
 };
-- 
1.8.5.3
