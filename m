From: Ben Dooks <ben-alsa@fluff.org>
Subject: [patch 1/9] S3C24XX: Move and update IIS headers
Date: Wed, 04 Mar 2009 00:49:26 +0000
Message-ID: <20090304005138.236616450@fluff.org.uk>
References: <20090304004925.530566010@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from teyla.home.fluff.org (aeryn.fluff.org.uk [87.194.8.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 5529E2440A
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2009 01:54:04 +0100 (CET)
Content-Disposition: inline; filename=audio/audio-header-fixes.patch
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
Cc: broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

From: Ben Dooks <ben@simtec.co.uk>

Move the IIS headers to their correct place.

Signed-off-by: Ben Dooks <ben@simtec.co.uk>

diff --git a/arch/arm/mach-s3c2410/dma.c b/arch/arm/mach-s3c2410/dma.c
index 552b4c7..440c014 100644
--- a/arch/arm/mach-s3c2410/dma.c
+++ b/arch/arm/mach-s3c2410/dma.c
@@ -28,7 +28,7 @@
 #include <mach/regs-mem.h>
 #include <mach/regs-lcd.h>
 #include <mach/regs-sdi.h>
-#include <asm/plat-s3c24xx/regs-iis.h>
+#include <plat/regs-iis.h>
 #include <plat/regs-spi.h>
 
 static struct s3c24xx_dma_map __initdata s3c2410_dma_mappings[] = {
diff --git a/arch/arm/mach-s3c2410/include/mach/hardware.h b/arch/arm/mach-s3c2410/include/mach/hardware.h
index 74d5a1a..db72beb 100644
--- a/arch/arm/mach-s3c2410/include/mach/hardware.h
+++ b/arch/arm/mach-s3c2410/include/mach/hardware.h
@@ -131,7 +131,4 @@ extern int s3c2412_gpio_set_sleepcfg(unsigned int pin, unsigned int state);
 
 /* machine specific hardware definitions should go after this */
 
-/* currently here until moved into config (todo) */
-#define CONFIG_NO_MULTIWORD_IO
-
 #endif /* __ASM_ARCH_HARDWARE_H */
diff --git a/arch/arm/mach-s3c2410/include/mach/io.h b/arch/arm/mach-s3c2410/include/mach/io.h
index 9813dbf..c477771 100644
--- a/arch/arm/mach-s3c2410/include/mach/io.h
+++ b/arch/arm/mach-s3c2410/include/mach/io.h
@@ -9,7 +9,7 @@
 #ifndef __ASM_ARM_ARCH_IO_H
 #define __ASM_ARM_ARCH_IO_H
 
-#include <mach/hardware.h>
+#include <mach/map.h>
 
 #define IO_SPACE_LIMIT 0xffffffff
 
diff --git a/arch/arm/mach-s3c2412/dma.c b/arch/arm/mach-s3c2412/dma.c
index 919856c..9e34785 100644
--- a/arch/arm/mach-s3c2412/dma.c
+++ b/arch/arm/mach-s3c2412/dma.c
@@ -29,8 +29,8 @@
 #include <mach/regs-mem.h>
 #include <mach/regs-lcd.h>
 #include <mach/regs-sdi.h>
-#include <asm/plat-s3c24xx/regs-s3c2412-iis.h>
-#include <asm/plat-s3c24xx/regs-iis.h>
+#include <plat/regs-s3c2412-iis.h>
+#include <plat/regs-iis.h>
 #include <plat/regs-spi.h>
 
 #define MAP(x) { (x)| DMA_CH_VALID, (x)| DMA_CH_VALID, (x)| DMA_CH_VALID, (x)| DMA_CH_VALID }
diff --git a/arch/arm/mach-s3c2440/dma.c b/arch/arm/mach-s3c2440/dma.c
index 5b5ee0b..69b6cf3 100644
--- a/arch/arm/mach-s3c2440/dma.c
+++ b/arch/arm/mach-s3c2440/dma.c
@@ -28,7 +28,7 @@
 #include <mach/regs-mem.h>
 #include <mach/regs-lcd.h>
 #include <mach/regs-sdi.h>
-#include <asm/plat-s3c24xx/regs-iis.h>
+#include <plat/regs-iis.h>
 #include <plat/regs-spi.h>
 
 static struct s3c24xx_dma_map __initdata s3c2440_dma_mappings[] = {
diff --git a/arch/arm/mach-s3c2443/dma.c b/arch/arm/mach-s3c2443/dma.c
index 2a58a4d..8430e58 100644
--- a/arch/arm/mach-s3c2443/dma.c
+++ b/arch/arm/mach-s3c2443/dma.c
@@ -29,7 +29,7 @@
 #include <mach/regs-mem.h>
 #include <mach/regs-lcd.h>
 #include <mach/regs-sdi.h>
-#include <asm/plat-s3c24xx/regs-iis.h>
+#include <plat/regs-iis.h>
 #include <plat/regs-spi.h>
 
 #define MAP(x) { \
diff --git a/arch/arm/mach-shark/include/mach/io.h b/arch/arm/mach-shark/include/mach/io.h
index c5cee82..8ca7d7f 100644
--- a/arch/arm/mach-shark/include/mach/io.h
+++ b/arch/arm/mach-shark/include/mach/io.h
@@ -14,7 +14,7 @@
 #define PCIO_BASE	0xe0000000
 #define IO_SPACE_LIMIT	0xffffffff
 
-#define __io(a)		((void __iomem *)(PCIO_BASE + (a)))
+#define __io(a)		__typesafe_io(PCIO_BASE + (a))
 #define __mem_pci(addr)	(addr)
 
 #endif
diff --git a/arch/arm/plat-s3c/include/plat/regs-s3c2412-iis.h b/arch/arm/plat-s3c/include/plat/regs-s3c2412-iis.h
new file mode 100644
index 0000000..25d4058
--- /dev/null
+++ b/arch/arm/plat-s3c/include/plat/regs-s3c2412-iis.h
@@ -0,0 +1,72 @@
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
+#define S3C2412_IISMOD_SDF_MSB		(0 << 5)
+#define S3C2412_IISMOD_SDF_LSB		(0 << 5)
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
diff --git a/arch/arm/plat-s3c24xx/clock-dclk.c b/arch/arm/plat-s3c24xx/clock-dclk.c
index 5b75a79..35219dc 100644
--- a/arch/arm/plat-s3c24xx/clock-dclk.c
+++ b/arch/arm/plat-s3c24xx/clock-dclk.c
@@ -18,6 +18,7 @@
 
 #include <mach/regs-clock.h>
 #include <mach/regs-gpio.h>
+#include <mach/hardware.h>
 
 #include <plat/clock.h>
 #include <plat/cpu.h>
diff --git a/arch/arm/plat-s3c24xx/include/plat/regs-iis.h b/arch/arm/plat-s3c24xx/include/plat/regs-iis.h
new file mode 100644
index 0000000..a6f1d5d
--- /dev/null
+++ b/arch/arm/plat-s3c24xx/include/plat/regs-iis.h
@@ -0,0 +1,77 @@
+/* arch/arm/mach-s3c2410/include/mach/regs-iis.h
+ *
+ * Copyright (c) 2003 Simtec Electronics <linux@simtec.co.uk>
+ *		      http://www.simtec.co.uk/products/SWLINUX/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * S3C2410 IIS register definition
+*/
+
+#ifndef __ASM_ARCH_REGS_IIS_H
+#define __ASM_ARCH_REGS_IIS_H
+
+#define S3C2410_IISCON	 (0x00)
+
+#define S3C2410_IISCON_LRINDEX	  (1<<8)
+#define S3C2410_IISCON_TXFIFORDY  (1<<7)
+#define S3C2410_IISCON_RXFIFORDY  (1<<6)
+#define S3C2410_IISCON_TXDMAEN	  (1<<5)
+#define S3C2410_IISCON_RXDMAEN	  (1<<4)
+#define S3C2410_IISCON_TXIDLE	  (1<<3)
+#define S3C2410_IISCON_RXIDLE	  (1<<2)
+#define S3C2410_IISCON_PSCEN	  (1<<1)
+#define S3C2410_IISCON_IISEN	  (1<<0)
+
+#define S3C2410_IISMOD	 (0x04)
+
+#define S3C2440_IISMOD_MPLL	  (1<<9)
+#define S3C2410_IISMOD_SLAVE	  (1<<8)
+#define S3C2410_IISMOD_NOXFER	  (0<<6)
+#define S3C2410_IISMOD_RXMODE	  (1<<6)
+#define S3C2410_IISMOD_TXMODE	  (2<<6)
+#define S3C2410_IISMOD_TXRXMODE	  (3<<6)
+#define S3C2410_IISMOD_LR_LLOW	  (0<<5)
+#define S3C2410_IISMOD_LR_RLOW	  (1<<5)
+#define S3C2410_IISMOD_IIS	  (0<<4)
+#define S3C2410_IISMOD_MSB	  (1<<4)
+#define S3C2410_IISMOD_8BIT	  (0<<3)
+#define S3C2410_IISMOD_16BIT	  (1<<3)
+#define S3C2410_IISMOD_BITMASK	  (1<<3)
+#define S3C2410_IISMOD_256FS	  (0<<2)
+#define S3C2410_IISMOD_384FS	  (1<<2)
+#define S3C2410_IISMOD_16FS	  (0<<0)
+#define S3C2410_IISMOD_32FS	  (1<<0)
+#define S3C2410_IISMOD_48FS	  (2<<0)
+#define S3C2410_IISMOD_FS_MASK	  (3<<0)
+
+#define S3C2410_IISPSR		(0x08)
+#define S3C2410_IISPSR_INTMASK	(31<<5)
+#define S3C2410_IISPSR_INTSHIFT	(5)
+#define S3C2410_IISPSR_EXTMASK	(31<<0)
+#define S3C2410_IISPSR_EXTSHFIT	(0)
+
+#define S3C2410_IISFCON  (0x0c)
+
+#define S3C2410_IISFCON_TXDMA	  (1<<15)
+#define S3C2410_IISFCON_RXDMA	  (1<<14)
+#define S3C2410_IISFCON_TXENABLE  (1<<13)
+#define S3C2410_IISFCON_RXENABLE  (1<<12)
+#define S3C2410_IISFCON_TXMASK	  (0x3f << 6)
+#define S3C2410_IISFCON_TXSHIFT	  (6)
+#define S3C2410_IISFCON_RXMASK	  (0x3f)
+#define S3C2410_IISFCON_RXSHIFT	  (0)
+
+#define S3C2400_IISFCON_TXDMA     (1<<11)
+#define S3C2400_IISFCON_RXDMA     (1<<10)
+#define S3C2400_IISFCON_TXENABLE  (1<<9)
+#define S3C2400_IISFCON_RXENABLE  (1<<8)
+#define S3C2400_IISFCON_TXMASK	  (0x07 << 4)
+#define S3C2400_IISFCON_TXSHIFT	  (4)
+#define S3C2400_IISFCON_RXMASK	  (0x07)
+#define S3C2400_IISFCON_RXSHIFT	  (0)
+
+#define S3C2410_IISFIFO  (0x10)
+#endif /* __ASM_ARCH_REGS_IIS_H */
diff --git a/include/asm-arm/plat-s3c24xx/regs-iis.h b/include/asm-arm/plat-s3c24xx/regs-iis.h
deleted file mode 100644
index a6f1d5d..0000000
--- a/include/asm-arm/plat-s3c24xx/regs-iis.h
+++ /dev/null
@@ -1,77 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/regs-iis.h
- *
- * Copyright (c) 2003 Simtec Electronics <linux@simtec.co.uk>
- *		      http://www.simtec.co.uk/products/SWLINUX/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * S3C2410 IIS register definition
-*/
-
-#ifndef __ASM_ARCH_REGS_IIS_H
-#define __ASM_ARCH_REGS_IIS_H
-
-#define S3C2410_IISCON	 (0x00)
-
-#define S3C2410_IISCON_LRINDEX	  (1<<8)
-#define S3C2410_IISCON_TXFIFORDY  (1<<7)
-#define S3C2410_IISCON_RXFIFORDY  (1<<6)
-#define S3C2410_IISCON_TXDMAEN	  (1<<5)
-#define S3C2410_IISCON_RXDMAEN	  (1<<4)
-#define S3C2410_IISCON_TXIDLE	  (1<<3)
-#define S3C2410_IISCON_RXIDLE	  (1<<2)
-#define S3C2410_IISCON_PSCEN	  (1<<1)
-#define S3C2410_IISCON_IISEN	  (1<<0)
-
-#define S3C2410_IISMOD	 (0x04)
-
-#define S3C2440_IISMOD_MPLL	  (1<<9)
-#define S3C2410_IISMOD_SLAVE	  (1<<8)
-#define S3C2410_IISMOD_NOXFER	  (0<<6)
-#define S3C2410_IISMOD_RXMODE	  (1<<6)
-#define S3C2410_IISMOD_TXMODE	  (2<<6)
-#define S3C2410_IISMOD_TXRXMODE	  (3<<6)
-#define S3C2410_IISMOD_LR_LLOW	  (0<<5)
-#define S3C2410_IISMOD_LR_RLOW	  (1<<5)
-#define S3C2410_IISMOD_IIS	  (0<<4)
-#define S3C2410_IISMOD_MSB	  (1<<4)
-#define S3C2410_IISMOD_8BIT	  (0<<3)
-#define S3C2410_IISMOD_16BIT	  (1<<3)
-#define S3C2410_IISMOD_BITMASK	  (1<<3)
-#define S3C2410_IISMOD_256FS	  (0<<2)
-#define S3C2410_IISMOD_384FS	  (1<<2)
-#define S3C2410_IISMOD_16FS	  (0<<0)
-#define S3C2410_IISMOD_32FS	  (1<<0)
-#define S3C2410_IISMOD_48FS	  (2<<0)
-#define S3C2410_IISMOD_FS_MASK	  (3<<0)
-
-#define S3C2410_IISPSR		(0x08)
-#define S3C2410_IISPSR_INTMASK	(31<<5)
-#define S3C2410_IISPSR_INTSHIFT	(5)
-#define S3C2410_IISPSR_EXTMASK	(31<<0)
-#define S3C2410_IISPSR_EXTSHFIT	(0)
-
-#define S3C2410_IISFCON  (0x0c)
-
-#define S3C2410_IISFCON_TXDMA	  (1<<15)
-#define S3C2410_IISFCON_RXDMA	  (1<<14)
-#define S3C2410_IISFCON_TXENABLE  (1<<13)
-#define S3C2410_IISFCON_RXENABLE  (1<<12)
-#define S3C2410_IISFCON_TXMASK	  (0x3f << 6)
-#define S3C2410_IISFCON_TXSHIFT	  (6)
-#define S3C2410_IISFCON_RXMASK	  (0x3f)
-#define S3C2410_IISFCON_RXSHIFT	  (0)
-
-#define S3C2400_IISFCON_TXDMA     (1<<11)
-#define S3C2400_IISFCON_RXDMA     (1<<10)
-#define S3C2400_IISFCON_TXENABLE  (1<<9)
-#define S3C2400_IISFCON_RXENABLE  (1<<8)
-#define S3C2400_IISFCON_TXMASK	  (0x07 << 4)
-#define S3C2400_IISFCON_TXSHIFT	  (4)
-#define S3C2400_IISFCON_RXMASK	  (0x07)
-#define S3C2400_IISFCON_RXSHIFT	  (0)
-
-#define S3C2410_IISFIFO  (0x10)
-#endif /* __ASM_ARCH_REGS_IIS_H */
diff --git a/include/asm-arm/plat-s3c24xx/regs-s3c2412-iis.h b/include/asm-arm/plat-s3c24xx/regs-s3c2412-iis.h
deleted file mode 100644
index 25d4058..0000000
--- a/include/asm-arm/plat-s3c24xx/regs-s3c2412-iis.h
+++ /dev/null
@@ -1,72 +0,0 @@
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
-#define S3C2412_IISMOD_SDF_MSB		(0 << 5)
-#define S3C2412_IISMOD_SDF_LSB		(0 << 5)
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
diff --git a/sound/soc/s3c24xx/neo1973_wm8753.c b/sound/soc/s3c24xx/neo1973_wm8753.c
index 45bb12e..286ff44 100644
--- a/sound/soc/s3c24xx/neo1973_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_wm8753.c
@@ -33,7 +33,7 @@
 #include <linux/io.h>
 #include <mach/spi-gpio.h>
 
-#include <asm/plat-s3c24xx/regs-iis.h>
+#include <plat/regs-iis.h>
 
 #include "../codecs/wm8753.h"
 #include "lm4857.h"
diff --git a/sound/soc/s3c24xx/s3c2412-i2s.c b/sound/soc/s3c24xx/s3c2412-i2s.c
index f3fc0ab..36b927d 100644
--- a/sound/soc/s3c24xx/s3c2412-i2s.c
+++ b/sound/soc/s3c24xx/s3c2412-i2s.c
@@ -22,6 +22,7 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/kernel.h>
+#include <linux/io.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -30,10 +31,7 @@
 #include <sound/soc.h>
 #include <mach/hardware.h>
 
-#include <linux/io.h>
-#include <asm/dma.h>
-
-#include <asm/plat-s3c24xx/regs-s3c2412-iis.h>
+#include <plat/regs-s3c2412-iis.h>
 
 #include <mach/regs-gpio.h>
 #include <mach/audio.h>
diff --git a/sound/soc/s3c24xx/s3c24xx-i2s.c b/sound/soc/s3c24xx/s3c24xx-i2s.c
index 6f4d439..2569b91 100644
--- a/sound/soc/s3c24xx/s3c24xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c24xx-i2s.c
@@ -34,7 +34,7 @@
 #include <asm/dma.h>
 #include <mach/dma.h>
 
-#include <asm/plat-s3c24xx/regs-iis.h>
+#include <plat/regs-iis.h>
 
 #include "s3c24xx-pcm.h"
 #include "s3c24xx-i2s.h"
diff --git a/sound/soc/s3c24xx/s3c24xx_uda134x.c b/sound/soc/s3c24xx/s3c24xx_uda134x.c
index a0a4d18..8e79a41 100644
--- a/sound/soc/s3c24xx/s3c24xx_uda134x.c
+++ b/sound/soc/s3c24xx/s3c24xx_uda134x.c
@@ -22,7 +22,7 @@
 #include <sound/s3c24xx_uda134x.h>
 #include <sound/uda134x.h>
 
-#include <asm/plat-s3c24xx/regs-iis.h>
+#include <plat/regs-iis.h>
 
 #include "s3c24xx-pcm.h"
 #include "s3c24xx-i2s.h"

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
