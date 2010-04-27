From: Jassi Brar <jassi.brar@samsung.com>
Subject: [PATCH 02/11] ASoC: SAMSUNG: I2S: Add bit definitions
Date: Tue, 27 Apr 2010 15:56:03 +0900
Message-ID: <1272351363-3724-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 93DA72482C
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Apr 2010 09:00:24 +0200 (CEST)
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
Cc: broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Define more bit definitions in the order of mainline
support for the SoC.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/regs-i2s-v2.h |   42 +++++++++++++++++++++++++++++++++++++-
 1 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/sound/soc/s3c24xx/regs-i2s-v2.h b/sound/soc/s3c24xx/regs-i2s-v2.h
index abf2fbc..f3d9028 100644
--- a/sound/soc/s3c24xx/regs-i2s-v2.h
+++ b/sound/soc/s3c24xx/regs-i2s-v2.h
@@ -20,6 +20,24 @@
 #define S3C2412_IISTXD			(0x10)
 #define S3C2412_IISRXD			(0x14)
 
+#define S5PC1XX_IISFICS		0x18
+#define S5PC1XX_IISTXDS		0x1C
+
+#define S5PC1XX_IISCON_SW_RST		(1 << 31)
+#define S5PC1XX_IISCON_FRXOFSTATUS	(1 << 26)
+#define S5PC1XX_IISCON_FRXORINTEN	(1 << 25)
+#define S5PC1XX_IISCON_FTXSURSTAT	(1 << 24)
+#define S5PC1XX_IISCON_FTXSURINTEN	(1 << 23)
+#define S5PC1XX_IISCON_TXSDMAPAUSE	(1 << 20)
+#define S5PC1XX_IISCON_TXSDMACTIVE	(1 << 18)
+
+#define S3C64XX_IISCON_FTXURSTATUS	(1 << 17)
+#define S3C64XX_IISCON_FTXURINTEN	(1 << 16)
+#define S3C64XX_IISCON_TXFIFO2_EMPTY	(1 << 15)
+#define S3C64XX_IISCON_TXFIFO1_EMPTY	(1 << 14)
+#define S3C64XX_IISCON_TXFIFO2_FULL	(1 << 13)
+#define S3C64XX_IISCON_TXFIFO1_FULL	(1 << 12)
+
 #define S3C2412_IISCON_LRINDEX		(1 << 11)
 #define S3C2412_IISCON_TXFIFO_EMPTY	(1 << 10)
 #define S3C2412_IISCON_RXFIFO_EMPTY	(1 << 9)
@@ -33,6 +51,23 @@
 #define S3C2412_IISCON_RXDMA_ACTIVE	(1 << 1)
 #define S3C2412_IISCON_IIS_ACTIVE	(1 << 0)
 
+#define S5PC1XX_IISMOD_OPCLK_CDCLK_OUT	(0 << 30)
+#define S5PC1XX_IISMOD_OPCLK_CDCLK_IN	(1 << 30)
+#define S5PC1XX_IISMOD_OPCLK_BCLK_OUT	(2 << 30)
+#define S5PC1XX_IISMOD_OPCLK_PCLK	(3 << 30)
+#define S5PC1XX_IISMOD_OPCLK_MASK	(3 << 30)
+#define S5PC1XX_IISMOD_TXS_IDMA		(1 << 28) /* Sec_TXFIFO use I-DMA */
+#define S5PC1XX_IISMOD_BLCS_MASK	0x3
+#define S5PC1XX_IISMOD_BLCS_SHIFT	26
+#define S5PC1XX_IISMOD_BLCP_MASK	0x3
+#define S5PC1XX_IISMOD_BLCP_SHIFT	24
+
+#define S3C64XX_IISMOD_C2DD_HHALF	(1 << 21) /* Discard Higher-half */
+#define S3C64XX_IISMOD_C2DD_LHALF	(1 << 20) /* Discard Lower-half */
+#define S3C64XX_IISMOD_C1DD_HHALF	(1 << 19)
+#define S3C64XX_IISMOD_C1DD_LHALF	(1 << 18)
+#define S3C64XX_IISMOD_DC2_EN		(1 << 17)
+#define S3C64XX_IISMOD_DC1_EN		(1 << 16)
 #define S3C64XX_IISMOD_BLC_16BIT	(0 << 13)
 #define S3C64XX_IISMOD_BLC_8BIT		(1 << 13)
 #define S3C64XX_IISMOD_BLC_24BIT	(2 << 13)
@@ -71,12 +106,15 @@
 
 #define S3C2412_IISPSR_PSREN		(1 << 15)
 
+#define S3C64XX_IISFIC_TX2COUNT(x)	(((x) >>  24) & 0xf)
+#define S3C64XX_IISFIC_TX1COUNT(x)	(((x) >>  16) & 0xf)
+
 #define S3C2412_IISFIC_TXFLUSH		(1 << 15)
 #define S3C2412_IISFIC_RXFLUSH		(1 << 7)
 #define S3C2412_IISFIC_TXCOUNT(x)	(((x) >>  8) & 0xf)
 #define S3C2412_IISFIC_RXCOUNT(x)	(((x) >>  0) & 0xf)
 
-
+#define S5PC1XX_IISFICS_TXFLUSH		(1 << 15)
+#define S5PC1XX_IISFICS_TXCOUNT(x)	(((x) >>  8) & 0x7f)
 
 #endif /* __ASM_ARCH_REGS_S3C2412_IIS_H */
-
-- 
1.6.2.5
