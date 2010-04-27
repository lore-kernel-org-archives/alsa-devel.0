From: Jassi Brar <jassi.brar@samsung.com>
Subject: [PATCH 01/11] ASoC: S3C: I2Sv2: Move defines closer to
	driver
Date: Tue, 27 Apr 2010 15:55:21 +0900
Message-ID: <1272351321-3688-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A7762482E
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

The header for I2Sv2
   linux/arch/arm/plat-s3c/include/plat/regs-s3c2412-iis.h
contains only controller specific definitions and nothing
SoC specific. So, it could be moved to sound/soc/s3c24xx/

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 .../plat-samsung/include/plat/regs-s3c2412-iis.h   |   82 --------------------
 sound/soc/s3c24xx/regs-i2s-v2.h                    |   82 ++++++++++++++++++++
 sound/soc/s3c24xx/s3c-i2s-v2.c                     |    3 +-
 sound/soc/s3c24xx/s3c2412-i2s.c                    |    3 +-
 sound/soc/s3c24xx/s3c64xx-i2s.c                    |    2 +-
 5 files changed, 85 insertions(+), 87 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/include/plat/regs-s3c2412-iis.h
 create mode 100644 sound/soc/s3c24xx/regs-i2s-v2.h

diff --git a/arch/arm/plat-samsung/include/plat/regs-s3c2412-iis.h b/arch/arm/plat-samsung/include/plat/regs-s3c2412-iis.h
deleted file mode 100644
index abf2fbc..0000000
--- a/arch/arm/plat-samsung/include/plat/regs-s3c2412-iis.h
+++ /dev/null
@@ -1,82 +0,0 @@
-/* linux/include/asm-arm/plat-s3c24xx/regs-s3c2412-iis.h
- *
- * Copyright 2007 Simtec Electronics <linux@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * S3C2412 IIS register definition
-*/
-
-#ifndef __ASM_ARCH_REGS_S3C2412_IIS_H
-#define __ASM_ARCH_REGS_S3C2412_IIS_H
-
-#define S3C2412_IISCON			(0x00)
-#define S3C2412_IISMOD			(0x04)
-#define S3C2412_IISFIC			(0x08)
-#define S3C2412_IISPSR			(0x0C)
-#define S3C2412_IISTXD			(0x10)
-#define S3C2412_IISRXD			(0x14)
-
-#define S3C2412_IISCON_LRINDEX		(1 << 11)
-#define S3C2412_IISCON_TXFIFO_EMPTY	(1 << 10)
-#define S3C2412_IISCON_RXFIFO_EMPTY	(1 << 9)
-#define S3C2412_IISCON_TXFIFO_FULL	(1 << 8)
-#define S3C2412_IISCON_RXFIFO_FULL	(1 << 7)
-#define S3C2412_IISCON_TXDMA_PAUSE	(1 << 6)
-#define S3C2412_IISCON_RXDMA_PAUSE	(1 << 5)
-#define S3C2412_IISCON_TXCH_PAUSE	(1 << 4)
-#define S3C2412_IISCON_RXCH_PAUSE	(1 << 3)
-#define S3C2412_IISCON_TXDMA_ACTIVE	(1 << 2)
-#define S3C2412_IISCON_RXDMA_ACTIVE	(1 << 1)
-#define S3C2412_IISCON_IIS_ACTIVE	(1 << 0)
-
-#define S3C64XX_IISMOD_BLC_16BIT	(0 << 13)
-#define S3C64XX_IISMOD_BLC_8BIT		(1 << 13)
-#define S3C64XX_IISMOD_BLC_24BIT	(2 << 13)
-#define S3C64XX_IISMOD_BLC_MASK		(3 << 13)
-
-#define S3C64XX_IISMOD_IMS_PCLK		(0 << 10)
-#define S3C64XX_IISMOD_IMS_SYSMUX	(1 << 10)
-
-#define S3C2412_IISMOD_MASTER_INTERNAL	(0 << 10)
-#define S3C2412_IISMOD_MASTER_EXTERNAL	(1 << 10)
-#define S3C2412_IISMOD_SLAVE		(2 << 10)
-#define S3C2412_IISMOD_MASTER_MASK	(3 << 10)
-#define S3C2412_IISMOD_MODE_TXONLY	(0 << 8)
-#define S3C2412_IISMOD_MODE_RXONLY	(1 << 8)
-#define S3C2412_IISMOD_MODE_TXRX	(2 << 8)
-#define S3C2412_IISMOD_MODE_MASK	(3 << 8)
-#define S3C2412_IISMOD_LR_LLOW		(0 << 7)
-#define S3C2412_IISMOD_LR_RLOW		(1 << 7)
-#define S3C2412_IISMOD_SDF_IIS		(0 << 5)
-#define S3C2412_IISMOD_SDF_MSB		(1 << 5)
-#define S3C2412_IISMOD_SDF_LSB		(2 << 5)
-#define S3C2412_IISMOD_SDF_MASK		(3 << 5)
-#define S3C2412_IISMOD_RCLK_256FS	(0 << 3)
-#define S3C2412_IISMOD_RCLK_512FS	(1 << 3)
-#define S3C2412_IISMOD_RCLK_384FS	(2 << 3)
-#define S3C2412_IISMOD_RCLK_768FS	(3 << 3)
-#define S3C2412_IISMOD_RCLK_MASK 	(3 << 3)
-#define S3C2412_IISMOD_BCLK_32FS	(0 << 1)
-#define S3C2412_IISMOD_BCLK_48FS	(1 << 1)
-#define S3C2412_IISMOD_BCLK_16FS	(2 << 1)
-#define S3C2412_IISMOD_BCLK_24FS	(3 << 1)
-#define S3C2412_IISMOD_BCLK_MASK	(3 << 1)
-#define S3C2412_IISMOD_8BIT		(1 << 0)
-
-#define S3C64XX_IISMOD_CDCLKCON		(1 << 12)
-
-#define S3C2412_IISPSR_PSREN		(1 << 15)
-
-#define S3C2412_IISFIC_TXFLUSH		(1 << 15)
-#define S3C2412_IISFIC_RXFLUSH		(1 << 7)
-#define S3C2412_IISFIC_TXCOUNT(x)	(((x) >>  8) & 0xf)
-#define S3C2412_IISFIC_RXCOUNT(x)	(((x) >>  0) & 0xf)
-
-
-
-#endif /* __ASM_ARCH_REGS_S3C2412_IIS_H */
-
diff --git a/sound/soc/s3c24xx/regs-i2s-v2.h b/sound/soc/s3c24xx/regs-i2s-v2.h
new file mode 100644
index 0000000..abf2fbc
--- /dev/null
+++ b/sound/soc/s3c24xx/regs-i2s-v2.h
@@ -0,0 +1,82 @@
+/* linux/include/asm-arm/plat-s3c24xx/regs-s3c2412-iis.h
+ *
+ * Copyright 2007 Simtec Electronics <linux@simtec.co.uk>
+ *	http://armlinux.simtec.co.uk/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * S3C2412 IIS register definition
+*/
+
+#ifndef __ASM_ARCH_REGS_S3C2412_IIS_H
+#define __ASM_ARCH_REGS_S3C2412_IIS_H
+
+#define S3C2412_IISCON			(0x00)
+#define S3C2412_IISMOD			(0x04)
+#define S3C2412_IISFIC			(0x08)
+#define S3C2412_IISPSR			(0x0C)
+#define S3C2412_IISTXD			(0x10)
+#define S3C2412_IISRXD			(0x14)
+
+#define S3C2412_IISCON_LRINDEX		(1 << 11)
+#define S3C2412_IISCON_TXFIFO_EMPTY	(1 << 10)
+#define S3C2412_IISCON_RXFIFO_EMPTY	(1 << 9)
+#define S3C2412_IISCON_TXFIFO_FULL	(1 << 8)
+#define S3C2412_IISCON_RXFIFO_FULL	(1 << 7)
+#define S3C2412_IISCON_TXDMA_PAUSE	(1 << 6)
+#define S3C2412_IISCON_RXDMA_PAUSE	(1 << 5)
+#define S3C2412_IISCON_TXCH_PAUSE	(1 << 4)
+#define S3C2412_IISCON_RXCH_PAUSE	(1 << 3)
+#define S3C2412_IISCON_TXDMA_ACTIVE	(1 << 2)
+#define S3C2412_IISCON_RXDMA_ACTIVE	(1 << 1)
+#define S3C2412_IISCON_IIS_ACTIVE	(1 << 0)
+
+#define S3C64XX_IISMOD_BLC_16BIT	(0 << 13)
+#define S3C64XX_IISMOD_BLC_8BIT		(1 << 13)
+#define S3C64XX_IISMOD_BLC_24BIT	(2 << 13)
+#define S3C64XX_IISMOD_BLC_MASK		(3 << 13)
+
+#define S3C64XX_IISMOD_IMS_PCLK		(0 << 10)
+#define S3C64XX_IISMOD_IMS_SYSMUX	(1 << 10)
+
+#define S3C2412_IISMOD_MASTER_INTERNAL	(0 << 10)
+#define S3C2412_IISMOD_MASTER_EXTERNAL	(1 << 10)
+#define S3C2412_IISMOD_SLAVE		(2 << 10)
+#define S3C2412_IISMOD_MASTER_MASK	(3 << 10)
+#define S3C2412_IISMOD_MODE_TXONLY	(0 << 8)
+#define S3C2412_IISMOD_MODE_RXONLY	(1 << 8)
+#define S3C2412_IISMOD_MODE_TXRX	(2 << 8)
+#define S3C2412_IISMOD_MODE_MASK	(3 << 8)
+#define S3C2412_IISMOD_LR_LLOW		(0 << 7)
+#define S3C2412_IISMOD_LR_RLOW		(1 << 7)
+#define S3C2412_IISMOD_SDF_IIS		(0 << 5)
+#define S3C2412_IISMOD_SDF_MSB		(1 << 5)
+#define S3C2412_IISMOD_SDF_LSB		(2 << 5)
+#define S3C2412_IISMOD_SDF_MASK		(3 << 5)
+#define S3C2412_IISMOD_RCLK_256FS	(0 << 3)
+#define S3C2412_IISMOD_RCLK_512FS	(1 << 3)
+#define S3C2412_IISMOD_RCLK_384FS	(2 << 3)
+#define S3C2412_IISMOD_RCLK_768FS	(3 << 3)
+#define S3C2412_IISMOD_RCLK_MASK 	(3 << 3)
+#define S3C2412_IISMOD_BCLK_32FS	(0 << 1)
+#define S3C2412_IISMOD_BCLK_48FS	(1 << 1)
+#define S3C2412_IISMOD_BCLK_16FS	(2 << 1)
+#define S3C2412_IISMOD_BCLK_24FS	(3 << 1)
+#define S3C2412_IISMOD_BCLK_MASK	(3 << 1)
+#define S3C2412_IISMOD_8BIT		(1 << 0)
+
+#define S3C64XX_IISMOD_CDCLKCON		(1 << 12)
+
+#define S3C2412_IISPSR_PSREN		(1 << 15)
+
+#define S3C2412_IISFIC_TXFLUSH		(1 << 15)
+#define S3C2412_IISFIC_RXFLUSH		(1 << 7)
+#define S3C2412_IISFIC_TXCOUNT(x)	(((x) >>  8) & 0xf)
+#define S3C2412_IISFIC_RXCOUNT(x)	(((x) >>  0) & 0xf)
+
+
+
+#endif /* __ASM_ARCH_REGS_S3C2412_IIS_H */
+
diff --git a/sound/soc/s3c24xx/s3c-i2s-v2.c b/sound/soc/s3c24xx/s3c-i2s-v2.c
index 865f931..cb3652e 100644
--- a/sound/soc/s3c24xx/s3c-i2s-v2.c
+++ b/sound/soc/s3c24xx/s3c-i2s-v2.c
@@ -24,10 +24,9 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 
-#include <plat/regs-s3c2412-iis.h>
-
 #include <mach/dma.h>
 
+#include "regs-i2s-v2.h"
 #include "s3c-i2s-v2.h"
 #include "s3c-dma.h"
 
diff --git a/sound/soc/s3c24xx/s3c2412-i2s.c b/sound/soc/s3c24xx/s3c2412-i2s.c
index f3148f9..7134465 100644
--- a/sound/soc/s3c24xx/s3c2412-i2s.c
+++ b/sound/soc/s3c24xx/s3c2412-i2s.c
@@ -32,12 +32,11 @@
 #include <sound/soc.h>
 #include <mach/hardware.h>
 
-#include <plat/regs-s3c2412-iis.h>
-
 #include <mach/regs-gpio.h>
 #include <mach/dma.h>
 
 #include "s3c-dma.h"
+#include "regs-i2s-v2.h"
 #include "s3c2412-i2s.h"
 
 #define S3C2412_I2S_DEBUG 0
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
index ab1fa15..b7e951f 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
@@ -18,7 +18,6 @@
 
 #include <sound/soc.h>
 
-#include <plat/regs-s3c2412-iis.h>
 #include <mach/gpio-bank-d.h>
 #include <mach/gpio-bank-e.h>
 #include <plat/gpio-cfg.h>
@@ -27,6 +26,7 @@
 #include <mach/dma.h>
 
 #include "s3c-dma.h"
+#include "regs-i2s-v2.h"
 #include "s3c64xx-i2s.h"
 
 /* The value should be set to maximum of the total number
-- 
1.6.2.5
