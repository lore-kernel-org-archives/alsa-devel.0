From: Caleb Crome <caleb@crome.org>
Subject: [PATCH RFC 1/1] ASoC: fsl_ssi: Make fifo watermark and maxburst settings device tree options
Date: Thu, 14 Jan 2016 08:29:42 -0800
Message-ID: <1452788982-11583-1-git-send-email-caleb@crome.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Caleb Crome <caleb@crome.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tuning the SSI fifo watermark & maxburst settings needs to be
optimized differently depending on the demands on the system.  The
current default of 2 is too low for high data-rate systems.  This
patch maintains exactly the same behavior by default (i.e defaults to
2), but adds device tree options to set maxburst & fifo depth from the
device tree.  This is necessary because a setting of 2 simply doesn't
work at higher data rates.

Signed-off-by: Caleb Crome <caleb@crome.org>
---
 .../devicetree/bindings/sound/fsl,ssi.txt          | 10 +++
 sound/soc/fsl/fsl_ssi.c                            | 87 ++++++++++++++--------
 2 files changed, 68 insertions(+), 29 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,ssi.txt b/Documentation/devicetree/bindings/sound/fsl,ssi.txt
index 5b76be4..7af62b9 100644
--- a/Documentation/devicetree/bindings/sound/fsl,ssi.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,ssi.txt
@@ -61,6 +61,16 @@ Optional properties:
 - fsl,mode:         The operating mode for the AC97 interface only.
                     "ac97-slave" - AC97 mode, SSI is clock slave
                     "ac97-master" - AC97 mode, SSI is clock master
+- fsl,fifo-watermark: Sets the fifo watermark.  The default is
+                    fifo_depth-2 words, meaning 'initiate dma transfer
+                    when 2 words are left in the fifo'.  At higher
+                    data rates (48kHz, 16-channels for example), this
+                    causes silent but deadly DMA xruns and channel
+                    slips.  For 15 word FIFOs (like on MX5, MX6) 8 is
+                    a good value when running at high data rates
+- fsl,dma-maxburst: sets the max number of words to transfer in DMA.
+                    This defaults to the same value as
+                    fsl,fifo-watermark.
 
 Child 'codec' node required properties:
 - compatible:       Compatible list, contains the name of the codec
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 5cfc540..94d8b5d7 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -221,6 +221,12 @@ struct fsl_ssi_soc_data {
  * @dbg_stats: Debugging statistics
  *
  * @soc: SoC specific data
+ *
+ * @fifo_watermark: the FIFO watermark setting.  Notifies DMA when
+ *             there are @fifo_watermark or fewer words in TX fifo or
+ *             @fifo_watermark or more empty words in RX fifo.
+ * @dma_maxburst: max number of words to transfer in one go.  So far,
+ *             this is always the same as fifo_watermark.
  */
 struct fsl_ssi_private {
 	struct regmap *regs;
@@ -259,6 +265,9 @@ struct fsl_ssi_private {
 
 	const struct fsl_ssi_soc_data *soc;
 	struct device *dev;
+
+	u32 fifo_watermark;
+	u32 dma_maxburst;
 };
 
 /*
@@ -1037,21 +1046,7 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 	regmap_write(regs, CCSR_SSI_SRCR, srcr);
 	regmap_write(regs, CCSR_SSI_SCR, scr);
 
-	/*
-	 * Set the watermark for transmit FIFI 0 and receive FIFO 0. We don't
-	 * use FIFO 1. We program the transmit water to signal a DMA transfer
-	 * if there are only two (or fewer) elements left in the FIFO. Two
-	 * elements equals one frame (left channel, right channel). This value,
-	 * however, depends on the depth of the transmit buffer.
-	 *
-	 * We set the watermark on the same level as the DMA burstsize.  For
-	 * fiq it is probably better to use the biggest possible watermark
-	 * size.
-	 */
-	if (ssi_private->use_dma)
-		wm = ssi_private->fifo_depth - 2;
-	else
-		wm = ssi_private->fifo_depth;
+	wm = ssi_private->fifo_watermark;
 
 	regmap_write(regs, CCSR_SSI_SFCSR,
 			CCSR_SSI_SFCSR_TFWM0(wm) | CCSR_SSI_SFCSR_RFWM0(wm) |
@@ -1359,12 +1354,8 @@ static int fsl_ssi_imx_probe(struct platform_device *pdev,
 		dev_dbg(&pdev->dev, "could not get baud clock: %ld\n",
 			 PTR_ERR(ssi_private->baudclk));
 
-	/*
-	 * We have burstsize be "fifo_depth - 2" to match the SSI
-	 * watermark setting in fsl_ssi_startup().
-	 */
-	ssi_private->dma_params_tx.maxburst = ssi_private->fifo_depth - 2;
-	ssi_private->dma_params_rx.maxburst = ssi_private->fifo_depth - 2;
+	ssi_private->dma_params_tx.maxburst = ssi_private->dma_maxburst;
+	ssi_private->dma_params_rx.maxburst = ssi_private->dma_maxburst;
 	ssi_private->dma_params_tx.addr = ssi_private->ssi_phys + CCSR_SSI_STX0;
 	ssi_private->dma_params_rx.addr = ssi_private->ssi_phys + CCSR_SSI_SRX0;
 
@@ -1421,6 +1412,51 @@ static void fsl_ssi_imx_clean(struct platform_device *pdev,
 		clk_disable_unprepare(ssi_private->clk);
 }
 
+static void fsl_ssi_set_fifo_settings(
+	struct device_node *np,
+	struct fsl_ssi_private *ssi_private)
+{
+	const uint32_t *iprop;
+	/*
+	 * Determine the FIFO depth. & watermark
+	 *
+	 * Set the watermark for transmit FIFO 0/1 and receive FIFO
+	 * 0/1. We program the transmit water to signal a DMA transfer
+	 * when this many words are left to be transmitted (or
+	 * received).  Previous setting was 2 elements, which was
+	 * assumed to be one frame.  Such a small value causes silent
+	 * DMA xruns at high data rates.  8 seems to be a good
+	 * tradeoff between xruns & number of DMA transfers.
+	 *
+	 * We set the watermark on the same level as the DMA burstsize.  For
+	 * fiq it is probably better to use the biggest possible watermark
+	 * size.
+	 */
+	iprop = of_get_property(np, "fsl,fifo-depth", NULL);
+	if (iprop)
+		ssi_private->fifo_depth = be32_to_cpup(iprop);
+	else
+		/* Older 8610 DTs didn't have the fifo-depth property */
+		ssi_private->fifo_depth = 8;
+
+	iprop = of_get_property(np, "fsl,fifo-watermark", NULL);
+	if (iprop)
+		ssi_private->fifo_watermark = be32_to_cpup(iprop);
+	else
+		/* Default to old value of 2, which is too
+		 * small at high data rates, but it's the
+		 * default that's been there for years.
+		 */
+		ssi_private->fifo_watermark = ssi_private->fifo_depth - 2;
+
+	iprop = of_get_property(np, "fsl,dma-maxburst", NULL);
+
+	if (iprop)
+		ssi_private->dma_maxburst = be32_to_cpup(iprop);
+	else
+		ssi_private->dma_maxburst = ssi_private->fifo_watermark;
+}
+
 static int fsl_ssi_probe(struct platform_device *pdev)
 {
 	struct fsl_ssi_private *ssi_private;
@@ -1428,7 +1464,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *of_id;
 	const char *p, *sprop;
-	const uint32_t *iprop;
 	struct resource *res;
 	void __iomem *iomem;
 	char name[64];
@@ -1510,13 +1545,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		ssi_private->cpu_dai_drv.symmetric_samplebits = 1;
 	}
 
-	/* Determine the FIFO depth. */
-	iprop = of_get_property(np, "fsl,fifo-depth", NULL);
-	if (iprop)
-		ssi_private->fifo_depth = be32_to_cpup(iprop);
-	else
-                /* Older 8610 DTs didn't have the fifo-depth property */
-		ssi_private->fifo_depth = 8;
+	fsl_ssi_set_fifo_settings(np, ssi_private);
 
 	dev_set_drvdata(&pdev->dev, ssi_private);
 
-- 
2.1.4
