From: Jassi Brar <jassi.brar@samsung.com>
Subject: [PATCH 11/20] ASoC: SAMSUNG: I2S: Add bit definitions
Date: Wed, 10 Mar 2010 16:49:00 +0900
Message-ID: <1268207349-9979-11-git-send-email-jassi.brar@samsung.com>
References: <1268207349-9979-1-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-2-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-3-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-4-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-5-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-6-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-7-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-8-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-9-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-10-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A8CC103849
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 09:23:01 +0100 (CET)
In-Reply-To: <1268207349-9979-10-git-send-email-jassi.brar@samsung.com>
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
Cc: broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

Define more bit definitions in the order of mainline support for the
SoC.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/regs-i2s-v2.h |   41 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/sound/soc/s3c24xx/regs-i2s-v2.h b/sound/soc/s3c24xx/regs-i2s-v2.h
index 8e1a585..dea199e 100644
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
@@ -71,9 +106,15 @@
 
 #define S3C2412_IISPSR_PSREN		(1 << 15)
 
+#define S3C64XX_IISFIC_TX2COUNT(x)	(((x) >>  24) & 0xf)
+#define S3C64XX_IISFIC_TX1COUNT(x)	(((x) >>  16) & 0xf)
+
 #define S3C2412_IISFIC_TXFLUSH		(1 << 15)
 #define S3C2412_IISFIC_RXFLUSH		(1 << 7)
 #define S3C2412_IISFIC_TXCOUNT(x)	(((x) >>  8) & 0xf)
 #define S3C2412_IISFIC_RXCOUNT(x)	(((x) >>  0) & 0xf)
 
+#define S5PC1XX_IISFICS_TXFLUSH		(1 << 15)
+#define S5PC1XX_IISFICS_TXCOUNT(x)	(((x) >>  8) & 0x7f)
+
 #endif /* __REGS_IISV2_H */
-- 
1.6.2.5
