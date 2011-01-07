From: Seungwhan Youn <sw.youn@samsung.com>
Subject: [PATCH 3/4] ASoC: SAMSUNG: Move PCM specific
	definitions into pcm.c
Date: Fri,  7 Jan 2011 13:57:23 +0900
Message-ID: <1294376243-18334-1-git-send-email-sw.youn@samsung.com>
References: <1294375429-16729-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id EA44E24640
	for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2011 06:21:07 +0100 (CET)
In-Reply-To: <1294375429-16729-1-git-send-email-sw.youn@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Seungwhan Youn <sw.youn@samsung.com>, broonie@opensource.wolfsonmicro.com, jassi.brar@samsung.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch moves PCM specific definitions, they doesn't need to be
shared, into 'pcm.c' from 'pcm.h'.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
---
 sound/soc/samsung/pcm.c |  107 +++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/samsung/pcm.h |  107 -----------------------------------------------
 2 files changed, 107 insertions(+), 107 deletions(-)

diff --git a/sound/soc/samsung/pcm.c b/sound/soc/samsung/pcm.c
index 48d0b75..091db5d 100644
--- a/sound/soc/samsung/pcm.c
+++ b/sound/soc/samsung/pcm.c
@@ -32,6 +32,113 @@
 #include "dma.h"
 #include "pcm.h"
 
+/*Register Offsets */
+#define S3C_PCM_CTL		0x00
+#define S3C_PCM_CLKCTL		0x04
+#define S3C_PCM_TXFIFO		0x08
+#define S3C_PCM_RXFIFO		0x0C
+#define S3C_PCM_IRQCTL		0x10
+#define S3C_PCM_IRQSTAT		0x14
+#define S3C_PCM_FIFOSTAT	0x18
+#define S3C_PCM_CLRINT		0x20
+
+/* PCM_CTL Bit-Fields */
+#define S3C_PCM_CTL_TXDIPSTICK_MASK	0x3f
+#define S3C_PCM_CTL_TXDIPSTICK_SHIFT	13
+#define S3C_PCM_CTL_RXDIPSTICK_MASK	0x3f
+#define S3C_PCM_CTL_RXDIPSTICK_SHIFT	7
+#define S3C_PCM_CTL_TXDMA_EN		(0x1 << 6)
+#define S3C_PCM_CTL_RXDMA_EN		(0x1 << 5)
+#define S3C_PCM_CTL_TXMSB_AFTER_FSYNC	(0x1 << 4)
+#define S3C_PCM_CTL_RXMSB_AFTER_FSYNC	(0x1 << 3)
+#define S3C_PCM_CTL_TXFIFO_EN		(0x1 << 2)
+#define S3C_PCM_CTL_RXFIFO_EN		(0x1 << 1)
+#define S3C_PCM_CTL_ENABLE		(0x1 << 0)
+
+/* PCM_CLKCTL Bit-Fields */
+#define S3C_PCM_CLKCTL_SERCLK_EN	(0x1 << 19)
+#define S3C_PCM_CLKCTL_SERCLKSEL_PCLK	(0x1 << 18)
+#define S3C_PCM_CLKCTL_SCLKDIV_MASK	0x1ff
+#define S3C_PCM_CLKCTL_SYNCDIV_MASK	0x1ff
+#define S3C_PCM_CLKCTL_SCLKDIV_SHIFT	9
+#define S3C_PCM_CLKCTL_SYNCDIV_SHIFT	0
+
+/* PCM_TXFIFO Bit-Fields */
+#define S3C_PCM_TXFIFO_DVALID	(0x1 << 16)
+#define S3C_PCM_TXFIFO_DATA_MSK	(0xffff << 0)
+
+/* PCM_RXFIFO Bit-Fields */
+#define S3C_PCM_RXFIFO_DVALID	(0x1 << 16)
+#define S3C_PCM_RXFIFO_DATA_MSK	(0xffff << 0)
+
+/* PCM_IRQCTL Bit-Fields */
+#define S3C_PCM_IRQCTL_IRQEN		(0x1 << 14)
+#define S3C_PCM_IRQCTL_WRDEN		(0x1 << 12)
+#define S3C_PCM_IRQCTL_TXEMPTYEN	(0x1 << 11)
+#define S3C_PCM_IRQCTL_TXALMSTEMPTYEN	(0x1 << 10)
+#define S3C_PCM_IRQCTL_TXFULLEN		(0x1 << 9)
+#define S3C_PCM_IRQCTL_TXALMSTFULLEN	(0x1 << 8)
+#define S3C_PCM_IRQCTL_TXSTARVEN	(0x1 << 7)
+#define S3C_PCM_IRQCTL_TXERROVRFLEN	(0x1 << 6)
+#define S3C_PCM_IRQCTL_RXEMPTEN		(0x1 << 5)
+#define S3C_PCM_IRQCTL_RXALMSTEMPTEN	(0x1 << 4)
+#define S3C_PCM_IRQCTL_RXFULLEN		(0x1 << 3)
+#define S3C_PCM_IRQCTL_RXALMSTFULLEN	(0x1 << 2)
+#define S3C_PCM_IRQCTL_RXSTARVEN	(0x1 << 1)
+#define S3C_PCM_IRQCTL_RXERROVRFLEN	(0x1 << 0)
+
+/* PCM_IRQSTAT Bit-Fields */
+#define S3C_PCM_IRQSTAT_IRQPND		(0x1 << 13)
+#define S3C_PCM_IRQSTAT_WRD_XFER	(0x1 << 12)
+#define S3C_PCM_IRQSTAT_TXEMPTY		(0x1 << 11)
+#define S3C_PCM_IRQSTAT_TXALMSTEMPTY	(0x1 << 10)
+#define S3C_PCM_IRQSTAT_TXFULL		(0x1 << 9)
+#define S3C_PCM_IRQSTAT_TXALMSTFULL	(0x1 << 8)
+#define S3C_PCM_IRQSTAT_TXSTARV		(0x1 << 7)
+#define S3C_PCM_IRQSTAT_TXERROVRFL	(0x1 << 6)
+#define S3C_PCM_IRQSTAT_RXEMPT		(0x1 << 5)
+#define S3C_PCM_IRQSTAT_RXALMSTEMPT	(0x1 << 4)
+#define S3C_PCM_IRQSTAT_RXFULL		(0x1 << 3)
+#define S3C_PCM_IRQSTAT_RXALMSTFULL	(0x1 << 2)
+#define S3C_PCM_IRQSTAT_RXSTARV		(0x1 << 1)
+#define S3C_PCM_IRQSTAT_RXERROVRFL	(0x1 << 0)
+
+/* PCM_FIFOSTAT Bit-Fields */
+#define S3C_PCM_FIFOSTAT_TXCNT_MSK		(0x3f << 14)
+#define S3C_PCM_FIFOSTAT_TXFIFOEMPTY		(0x1 << 13)
+#define S3C_PCM_FIFOSTAT_TXFIFOALMSTEMPTY	(0x1 << 12)
+#define S3C_PCM_FIFOSTAT_TXFIFOFULL		(0x1 << 11)
+#define S3C_PCM_FIFOSTAT_TXFIFOALMSTFULL	(0x1 << 10)
+#define S3C_PCM_FIFOSTAT_RXCNT_MSK		(0x3f << 4)
+#define S3C_PCM_FIFOSTAT_RXFIFOEMPTY		(0x1 << 3)
+#define S3C_PCM_FIFOSTAT_RXFIFOALMSTEMPTY	(0x1 << 2)
+#define S3C_PCM_FIFOSTAT_RXFIFOFULL		(0x1 << 1)
+#define S3C_PCM_FIFOSTAT_RXFIFOALMSTFULL	(0x1 << 0)
+
+/**
+ * struct s3c_pcm_info - S3C PCM Controller information
+ * @dev: The parent device passed to use from the probe.
+ * @regs: The pointer to the device register block.
+ * @dma_playback: DMA information for playback channel.
+ * @dma_capture: DMA information for capture channel.
+ */
+struct s3c_pcm_info {
+	spinlock_t lock;
+	struct device	*dev;
+	void __iomem	*regs;
+
+	unsigned int sclk_per_fs;
+
+	/* Whether to keep PCMSCLK enabled even when idle(no active xfer) */
+	unsigned int idleclk;
+
+	struct clk	*pclk;
+	struct clk	*cclk;
+
+	struct s3c_dma_params	*dma_playback;
+	struct s3c_dma_params	*dma_capture;
+};
+
 static struct s3c2410_dma_client s3c_pcm_dma_client_out = {
 	.name		= "PCM Stereo out"
 };
diff --git a/sound/soc/samsung/pcm.h b/sound/soc/samsung/pcm.h
index 03393dc..726baf8 100644
--- a/sound/soc/samsung/pcm.h
+++ b/sound/soc/samsung/pcm.h
@@ -9,116 +9,9 @@
 #ifndef __S3C_PCM_H
 #define __S3C_PCM_H __FILE__
 
-/*Register Offsets */
-#define S3C_PCM_CTL	(0x00)
-#define S3C_PCM_CLKCTL	(0x04)
-#define S3C_PCM_TXFIFO	(0x08)
-#define S3C_PCM_RXFIFO	(0x0C)
-#define S3C_PCM_IRQCTL	(0x10)
-#define S3C_PCM_IRQSTAT	(0x14)
-#define S3C_PCM_FIFOSTAT	(0x18)
-#define S3C_PCM_CLRINT	(0x20)
-
-/* PCM_CTL Bit-Fields */
-#define S3C_PCM_CTL_TXDIPSTICK_MASK		(0x3f)
-#define S3C_PCM_CTL_TXDIPSTICK_SHIFT	(13)
-#define S3C_PCM_CTL_RXDIPSTICK_MASK		(0x3f)
-#define S3C_PCM_CTL_RXDIPSTICK_SHIFT	(7)
-#define S3C_PCM_CTL_TXDMA_EN		(0x1<<6)
-#define S3C_PCM_CTL_RXDMA_EN		(0x1<<5)
-#define S3C_PCM_CTL_TXMSB_AFTER_FSYNC	(0x1<<4)
-#define S3C_PCM_CTL_RXMSB_AFTER_FSYNC	(0x1<<3)
-#define S3C_PCM_CTL_TXFIFO_EN		(0x1<<2)
-#define S3C_PCM_CTL_RXFIFO_EN		(0x1<<1)
-#define S3C_PCM_CTL_ENABLE			(0x1<<0)
-
-/* PCM_CLKCTL Bit-Fields */
-#define S3C_PCM_CLKCTL_SERCLK_EN		(0x1<<19)
-#define S3C_PCM_CLKCTL_SERCLKSEL_PCLK	(0x1<<18)
-#define S3C_PCM_CLKCTL_SCLKDIV_MASK		(0x1ff)
-#define S3C_PCM_CLKCTL_SYNCDIV_MASK		(0x1ff)
-#define S3C_PCM_CLKCTL_SCLKDIV_SHIFT	(9)
-#define S3C_PCM_CLKCTL_SYNCDIV_SHIFT	(0)
-
-/* PCM_TXFIFO Bit-Fields */
-#define S3C_PCM_TXFIFO_DVALID	(0x1<<16)
-#define S3C_PCM_TXFIFO_DATA_MSK	(0xffff<<0)
-
-/* PCM_RXFIFO Bit-Fields */
-#define S3C_PCM_RXFIFO_DVALID	(0x1<<16)
-#define S3C_PCM_RXFIFO_DATA_MSK	(0xffff<<0)
-
-/* PCM_IRQCTL Bit-Fields */
-#define S3C_PCM_IRQCTL_IRQEN		(0x1<<14)
-#define S3C_PCM_IRQCTL_WRDEN		(0x1<<12)
-#define S3C_PCM_IRQCTL_TXEMPTYEN		(0x1<<11)
-#define S3C_PCM_IRQCTL_TXALMSTEMPTYEN	(0x1<<10)
-#define S3C_PCM_IRQCTL_TXFULLEN		(0x1<<9)
-#define S3C_PCM_IRQCTL_TXALMSTFULLEN	(0x1<<8)
-#define S3C_PCM_IRQCTL_TXSTARVEN		(0x1<<7)
-#define S3C_PCM_IRQCTL_TXERROVRFLEN		(0x1<<6)
-#define S3C_PCM_IRQCTL_RXEMPTEN		(0x1<<5)
-#define S3C_PCM_IRQCTL_RXALMSTEMPTEN	(0x1<<4)
-#define S3C_PCM_IRQCTL_RXFULLEN		(0x1<<3)
-#define S3C_PCM_IRQCTL_RXALMSTFULLEN	(0x1<<2)
-#define S3C_PCM_IRQCTL_RXSTARVEN		(0x1<<1)
-#define S3C_PCM_IRQCTL_RXERROVRFLEN		(0x1<<0)
-
-/* PCM_IRQSTAT Bit-Fields */
-#define S3C_PCM_IRQSTAT_IRQPND		(0x1<<13)
-#define S3C_PCM_IRQSTAT_WRD_XFER		(0x1<<12)
-#define S3C_PCM_IRQSTAT_TXEMPTY		(0x1<<11)
-#define S3C_PCM_IRQSTAT_TXALMSTEMPTY	(0x1<<10)
-#define S3C_PCM_IRQSTAT_TXFULL		(0x1<<9)
-#define S3C_PCM_IRQSTAT_TXALMSTFULL		(0x1<<8)
-#define S3C_PCM_IRQSTAT_TXSTARV		(0x1<<7)
-#define S3C_PCM_IRQSTAT_TXERROVRFL		(0x1<<6)
-#define S3C_PCM_IRQSTAT_RXEMPT		(0x1<<5)
-#define S3C_PCM_IRQSTAT_RXALMSTEMPT		(0x1<<4)
-#define S3C_PCM_IRQSTAT_RXFULL		(0x1<<3)
-#define S3C_PCM_IRQSTAT_RXALMSTFULL		(0x1<<2)
-#define S3C_PCM_IRQSTAT_RXSTARV		(0x1<<1)
-#define S3C_PCM_IRQSTAT_RXERROVRFL		(0x1<<0)
-
-/* PCM_FIFOSTAT Bit-Fields */
-#define S3C_PCM_FIFOSTAT_TXCNT_MSK		(0x3f<<14)
-#define S3C_PCM_FIFOSTAT_TXFIFOEMPTY	(0x1<<13)
-#define S3C_PCM_FIFOSTAT_TXFIFOALMSTEMPTY	(0x1<<12)
-#define S3C_PCM_FIFOSTAT_TXFIFOFULL		(0x1<<11)
-#define S3C_PCM_FIFOSTAT_TXFIFOALMSTFULL	(0x1<<10)
-#define S3C_PCM_FIFOSTAT_RXCNT_MSK		(0x3f<<4)
-#define S3C_PCM_FIFOSTAT_RXFIFOEMPTY	(0x1<<3)
-#define S3C_PCM_FIFOSTAT_RXFIFOALMSTEMPTY	(0x1<<2)
-#define S3C_PCM_FIFOSTAT_RXFIFOFULL		(0x1<<1)
-#define S3C_PCM_FIFOSTAT_RXFIFOALMSTFULL	(0x1<<0)
-
 #define S3C_PCM_CLKSRC_PCLK	0
 #define S3C_PCM_CLKSRC_MUX	1
 
 #define S3C_PCM_SCLK_PER_FS	0
 
-/**
- * struct s3c_pcm_info - S3C PCM Controller information
- * @dev: The parent device passed to use from the probe.
- * @regs: The pointer to the device register block.
- * @dma_playback: DMA information for playback channel.
- * @dma_capture: DMA information for capture channel.
- */
-struct s3c_pcm_info {
-	spinlock_t lock;
-	struct device	*dev;
-	void __iomem	*regs;
-
-	unsigned int sclk_per_fs;
-
-	/* Whether to keep PCMSCLK enabled even when idle(no active xfer) */
-	unsigned int idleclk;
-
-	struct clk	*pclk;
-	struct clk	*cclk;
-
-	struct s3c_dma_params	*dma_playback;
-	struct s3c_dma_params	*dma_capture;
-};
-
 #endif /* __S3C_PCM_H */
-- 
1.6.2.5
