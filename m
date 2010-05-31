From: apatard@mandriva.com
Subject: [patch 1/4] orion/kirkwood: add audio functions.
Date: Mon, 31 May 2010 13:49:12 +0200
Message-ID: <20100531115003.236348260@mandriva.com>
References: <20100527125737.524554667@mandriva.com>
	<20100527130337.925751129@mandriva.com>
	<20100531111422.GF3489@rakim.wolfsonmicro.main>
	<20100531114911.487732770@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jules.rtp-net.org (sat78-1-82-232-42-61.fbx.proxad.net
	[82.232.42.61]) by alsa0.perex.cz (Postfix) with ESMTP id EE63524151
	for <alsa-devel@alsa-project.org>;
	Mon, 31 May 2010 13:50:19 +0200 (CEST)
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
--- sound-2.6.orig/arch/arm/mach-kirkwood/common.c	2010-05-31 13:30:24.000000000 +0200
+++ sound-2.6/arch/arm/mach-kirkwood/common.c	2010-05-31 13:35:21.567036892 +0200
@@ -25,6 +25,7 @@
 #include <asm/mach/time.h>
 #include <mach/kirkwood.h>
 #include <mach/bridge-regs.h>
+#include <plat/audio.h>
 #include <plat/cache-feroceon-l2.h>
 #include <plat/ehci-orion.h>
 #include <plat/mvsdio.h>
@@ -864,6 +865,42 @@ struct sys_timer kirkwood_timer = {
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
+static struct kirkwood_asoc_platform_data kirkwood_i2s_data = {
+	.dram        = &kirkwood_mbus_dram_info,
+	.burst       = 128,
+};
+
+static struct platform_device kirkwood_i2s_device = {
+	.name		= "kirkwood-i2s",
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
@@ -923,6 +960,7 @@ void __init kirkwood_init(void)
 	kirkwood_spi_plat_data.tclk = kirkwood_tclk;
 	kirkwood_uart0_data[0].uartclk = kirkwood_tclk;
 	kirkwood_uart1_data[0].uartclk = kirkwood_tclk;
+	kirkwood_i2s_data.tclk = kirkwood_tclk;
 
 	/*
 	 * Disable propagation of mbus errors to the CPU local bus,
Index: sound-2.6/arch/arm/mach-kirkwood/common.h
===================================================================
--- sound-2.6.orig/arch/arm/mach-kirkwood/common.h	2010-05-31 13:30:24.000000000 +0200
+++ sound-2.6/arch/arm/mach-kirkwood/common.h	2010-05-31 13:35:21.579077473 +0200
@@ -17,6 +17,7 @@ struct mv_sata_platform_data;
 struct mvsdio_platform_data;
 struct mtd_partition;
 struct mtd_info;
+struct kirkwood_asoc_platform_data;
 
 /*
  * Basic Kirkwood init functions used early by machine-setup.
@@ -43,6 +44,7 @@ void kirkwood_uart0_init(void);
 void kirkwood_uart1_init(void);
 void kirkwood_nand_init(struct mtd_partition *parts, int nr_parts, int delay);
 void kirkwood_nand_init_rnb(struct mtd_partition *parts, int nr_parts, int (*dev_ready)(struct mtd_info *));
+void kirkwood_audio_init(void);
 
 extern int kirkwood_tclk;
 extern struct sys_timer kirkwood_timer;
Index: sound-2.6/arch/arm/mach-kirkwood/include/mach/kirkwood.h
===================================================================
--- sound-2.6.orig/arch/arm/mach-kirkwood/include/mach/kirkwood.h	2010-05-31 13:25:39.000000000 +0200
+++ sound-2.6/arch/arm/mach-kirkwood/include/mach/kirkwood.h	2010-05-31 13:35:21.611577218 +0200
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
+++ sound-2.6/arch/arm/plat-orion/include/plat/audio.h	2010-05-31 13:35:21.623077514 +0200
@@ -0,0 +1,11 @@
+#ifndef __PLAT_AUDIO_H
+#define __PLAT_AUDIO_H
+
+#include <linux/mbus.h>
+
+struct kirkwood_asoc_platform_data {
+	u32 tclk;
+	struct mbus_dram_target_info *dram;
+	int burst;
+};
+#endif
