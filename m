From: apatard@mandriva.com
Subject: [patch 1/5] orion/kirkwood: add audio functions.
Date: Tue, 25 May 2010 14:22:37 +0200
Message-ID: <20100525122340.490882159@mandriva.com>
References: <20100525122236.841941526@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jules.rtp-net.org (sat78-1-82-232-42-61.fbx.proxad.net
	[82.232.42.61]) by alsa0.perex.cz (Postfix) with ESMTP id F4188244F1
	for <alsa-devel@alsa-project.org>;
	Tue, 25 May 2010 14:22:54 +0200 (CEST)
Content-Disposition: inline; filename=kirkwood_add_audio_dev.patch
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
Cc: nico@fluxnic.net, broonie@opensource.wolfsonmicro.com, saeed@marvell.com, Arnaud Patard <apatard@mandriva.com>, tbm@cyrius.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch add audio related definitions and functions


Signed-off-by: Arnaud Patard <apatard@mandriva.com>

Index: sound-2.6/arch/arm/mach-kirkwood/common.c
===================================================================
--- sound-2.6.orig/arch/arm/mach-kirkwood/common.c	2010-05-15 17:03:59.990086774 +0200
+++ sound-2.6/arch/arm/mach-kirkwood/common.c	2010-05-15 17:04:04.998087735 +0200
@@ -25,6 +25,7 @@
 #include <asm/mach/time.h>
 #include <mach/kirkwood.h>
 #include <mach/bridge-regs.h>
+#include <plat/audio.h>
 #include <plat/cache-feroceon-l2.h>
 #include <plat/ehci-orion.h>
 #include <plat/mvsdio.h>
@@ -855,6 +856,42 @@ struct sys_timer kirkwood_timer = {
 	.init = kirkwood_timer_init,
 };
 
+/*****************************************************************************
+ * Audio
+ ****************************************************************************/
+static struct resource kirkwood_i2s_resources[] = {
+	[0] = {
+		.start  = AUDIO_PHYS_BASE,
+		.end    = AUDIO_PHYS_BASE + SZ_16K - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = IRQ_KIRKWOOD_I2S,
+		.end    = IRQ_KIRKWOOD_I2S,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct orion_asoc_platform_data kirkwood_i2s_data = {
+	.dram        = &kirkwood_mbus_dram_info,
+	.burst       = 128,
+};
+
+static struct platform_device kirkwood_i2s_device = {
+	.name		= "orion-i2s",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(kirkwood_i2s_resources),
+	.resource	= kirkwood_i2s_resources,
+	.dev		= {
+		.platform_data	= &kirkwood_i2s_data,
+	},
+};
+
+void __init kirkwood_audio_init(void)
+{
+	kirkwood_clk_ctrl |= CGC_AUDIO;
+	platform_device_register(&kirkwood_i2s_device);
+}
 
 /*****************************************************************************
  * General
@@ -914,6 +951,7 @@ void __init kirkwood_init(void)
 	kirkwood_spi_plat_data.tclk = kirkwood_tclk;
 	kirkwood_uart0_data[0].uartclk = kirkwood_tclk;
 	kirkwood_uart1_data[0].uartclk = kirkwood_tclk;
+	kirkwood_i2s_data.tclk = kirkwood_tclk;
 
 	/*
 	 * Disable propagation of mbus errors to the CPU local bus,
Index: sound-2.6/arch/arm/mach-kirkwood/common.h
===================================================================
--- sound-2.6.orig/arch/arm/mach-kirkwood/common.h	2010-05-15 17:03:59.970086925 +0200
+++ sound-2.6/arch/arm/mach-kirkwood/common.h	2010-05-15 17:04:05.014086284 +0200
@@ -16,6 +16,7 @@ struct mv643xx_eth_platform_data;
 struct mv_sata_platform_data;
 struct mvsdio_platform_data;
 struct mtd_partition;
+struct orion_asoc_platform_data;
 
 /*
  * Basic Kirkwood init functions used early by machine-setup.
@@ -41,6 +42,7 @@ void kirkwood_i2c_init(void);
 void kirkwood_uart0_init(void);
 void kirkwood_uart1_init(void);
 void kirkwood_nand_init(struct mtd_partition *parts, int nr_parts, int delay);
+void kirkwood_audio_init(void);
 
 extern int kirkwood_tclk;
 extern struct sys_timer kirkwood_timer;
Index: sound-2.6/arch/arm/mach-kirkwood/include/mach/kirkwood.h
===================================================================
--- sound-2.6.orig/arch/arm/mach-kirkwood/include/mach/kirkwood.h	2010-05-15 17:03:59.954086213 +0200
+++ sound-2.6/arch/arm/mach-kirkwood/include/mach/kirkwood.h	2010-05-15 17:04:05.054086065 +0200
@@ -96,6 +96,9 @@
 
 #define SDIO_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE | 0x90000)
 
+#define AUDIO_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE | 0xA0000)
+#define AUDIO_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE | 0xA0000)
+
 /*
  * Supported devices and revisions.
  */
Index: sound-2.6/arch/arm/plat-orion/include/plat/audio.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ sound-2.6/arch/arm/plat-orion/include/plat/audio.h	2010-05-15 17:04:05.070087019 +0200
@@ -0,0 +1,11 @@
+#ifndef __PLAT_AUDIO_H
+#define __PLAT_AUDIO_H
+
+#include <linux/mbus.h>
+
+struct orion_asoc_platform_data {
+	u32 tclk;
+	struct mbus_dram_target_info *dram;
+	int burst;
+};
+#endif
