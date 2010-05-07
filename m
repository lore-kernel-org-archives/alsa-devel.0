From: Jassi Brar <jassi.brar@samsung.com>
Subject: [PATCH] ARM: S3C2412: DMA: Remove I2S FIFO address
Date: Fri,  7 May 2010 10:21:39 +0900
Message-ID: <1273195299-12181-1-git-send-email-jassi.brar@samsung.com>
References: <20100505140039.GC7139@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id E39652414D
	for <alsa-devel@alsa-project.org>;
	Fri,  7 May 2010 03:28:44 +0200 (CEST)
In-Reply-To: <20100505140039.GC7139@rakim.wolfsonmicro.main>
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

The S3C DMA API doesn't make use of hw_addr.to/from and also
the FIFO addresses are provided from the I2S drivers. So these
fields are redundant.
This patch removes the hw_addr.to/from fields for I2S and the
inclusion of header, paving way for the header to be moved closer
to the I2S controller drivers.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s3c2412/dma.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c2412/dma.c b/arch/arm/mach-s3c2412/dma.c
index e880524..7abecfc 100644
--- a/arch/arm/mach-s3c2412/dma.c
+++ b/arch/arm/mach-s3c2412/dma.c
@@ -30,7 +30,6 @@
 #include <mach/regs-mem.h>
 #include <mach/regs-lcd.h>
 #include <mach/regs-sdi.h>
-#include <plat/regs-s3c2412-iis.h>
 #include <plat/regs-iis.h>
 #include <plat/regs-spi.h>
 
@@ -119,13 +118,11 @@ static struct s3c24xx_dma_map __initdata s3c2412_dma_mappings[] = {
 		.name		= "i2s-sdi",
 		.channels	= MAP(S3C2412_DMAREQSEL_I2SRX),
 		.channels_rx	= MAP(S3C2412_DMAREQSEL_I2SRX),
-		.hw_addr.from	= S3C2410_PA_IIS + S3C2412_IISRXD,
 	},
 	[DMACH_I2S_OUT] = {
 		.name		= "i2s-sdo",
 		.channels	= MAP(S3C2412_DMAREQSEL_I2STX),
 		.channels_rx	= MAP(S3C2412_DMAREQSEL_I2STX),
-		.hw_addr.to	= S3C2410_PA_IIS + S3C2412_IISTXD,
 	},
 	[DMACH_USB_EP1] = {
 		.name		= "usb-ep1",
-- 
1.6.2.5
