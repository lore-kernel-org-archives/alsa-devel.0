From: apatard@mandriva.com
Subject: [patch 1/6] kirkwood: add audio functions.
Date: Tue, 11 May 2010 18:23:43 +0200
Message-ID: <20100511162601.375878707@mandriva.com>
References: <20100511162342.640158675@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jules.rtp-net.org (sat78-1-82-232-42-61.fbx.proxad.net
	[82.232.42.61]) by alsa0.perex.cz (Postfix) with ESMTP id 74D0F248EB
	for <alsa-devel@alsa-project.org>;
	Tue, 11 May 2010 18:26:01 +0200 (CEST)
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
Cc: Arnaud Patard <apatard@mandriva.com>, broonie@opensource.wolfsonmicro.com, saeed@marvell.com, nico@fluxnic.net, tbm@cyrius.com
List-Id: alsa-devel@alsa-project.org

This patch add audio related definitions and functions


Signed-off-by: Arnaud Patard <apatard@mandriva.com>
---
 arch/arm/mach-kirkwood/common.c                |    9 	9 +	0 -	0 !
 arch/arm/mach-kirkwood/common.h                |    2 	2 +	0 -	0 !
 arch/arm/mach-kirkwood/include/mach/audio.h    |   13 	13 +	0 -	0 !
 arch/arm/mach-kirkwood/include/mach/kirkwood.h |    3 	3 +	0 -	0 !
 4 files changed, 27 insertions(+)
 create mode 100644 include/linux/mv88fx_audio.h
 create mode 100644 sound/soc/kirkwood/Kconfig
 create mode 100644 sound/soc/kirkwood/Makefile
 create mode 100644 sound/soc/kirkwood/cs42l51.c
 create mode 100644 sound/soc/kirkwood/cs42l51.h
 create mode 100644 sound/soc/kirkwood/kirkwood_audio_hal.c
 create mode 100644 sound/soc/kirkwood/kirkwood_audio_hal.h
 create mode 100644 sound/soc/kirkwood/kirkwood_audio_regs.h
 create mode 100644 sound/soc/kirkwood/kirkwood_pcm.c

Index: linux-2.6.33/arch/arm/mach-kirkwood/common.c
===================================================================
--- linux-2.6.33.orig/arch/arm/mach-kirkwood/common.c	2010-05-11 17:51:25.537649820 +0200
+++ linux-2.6.33/arch/arm/mach-kirkwood/common.c	2010-05-11 17:52:39.790150263 +0200
@@ -25,6 +25,7 @@
 #include <asm/mach/time.h>
 #include <mach/kirkwood.h>
 #include <mach/bridge-regs.h>
+#include <mach/audio.h>
 #include <plat/cache-feroceon-l2.h>
 #include <plat/ehci-orion.h>
 #include <plat/mvsdio.h>
@@ -977,3 +978,11 @@ static int __init kirkwood_clock_gate(vo
 	return 0;
 }
 late_initcall(kirkwood_clock_gate);
+
+/*****************************************************************************
+ * Audio
+ ****************************************************************************/
+void __init kirkwood_audio_init(struct kirkwood_soc_platform_data *audio_data)
+{
+	kirkwood_clk_ctrl |= CGC_AUDIO;
+}
Index: linux-2.6.33/arch/arm/mach-kirkwood/common.h
===================================================================
--- linux-2.6.33.orig/arch/arm/mach-kirkwood/common.h	2010-05-11 17:51:25.641649839 +0200
+++ linux-2.6.33/arch/arm/mach-kirkwood/common.h	2010-05-11 17:52:39.790150263 +0200
@@ -16,6 +16,7 @@ struct mv643xx_eth_platform_data;
 struct mv_sata_platform_data;
 struct mvsdio_platform_data;
 struct mtd_partition;
+struct kirkwood_soc_platform_data;
 
 /*
  * Basic Kirkwood init functions used early by machine-setup.
@@ -41,6 +42,7 @@ void kirkwood_i2c_init(void);
 void kirkwood_uart0_init(void);
 void kirkwood_uart1_init(void);
 void kirkwood_nand_init(struct mtd_partition *parts, int nr_parts, int delay);
+void kirkwood_audio_init(struct kirkwood_soc_platform_data *audio_data);
 
 extern int kirkwood_tclk;
 extern struct sys_timer kirkwood_timer;
Index: linux-2.6.33/arch/arm/mach-kirkwood/include/mach/kirkwood.h
===================================================================
--- linux-2.6.33.orig/arch/arm/mach-kirkwood/include/mach/kirkwood.h	2010-05-11 17:51:25.585649926 +0200
+++ linux-2.6.33/arch/arm/mach-kirkwood/include/mach/kirkwood.h	2010-05-11 17:52:39.790150263 +0200
@@ -96,6 +96,9 @@
 
 #define SDIO_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE | 0x90000)
 
+#define AUDIO_PHYS_BASE		(KIRKWOOD_REGS_PHYS_BASE | 0xA0000)
+#define AUDIO_VIRT_BASE		(KIRKWOOD_REGS_VIRT_BASE | 0xA0000)
+
 /*
  * Supported devices and revisions.
  */
Index: linux-2.6.33/arch/arm/mach-kirkwood/include/mach/audio.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.33/arch/arm/mach-kirkwood/include/mach/audio.h	2010-05-11 17:52:39.790150263 +0200
@@ -0,0 +1,13 @@
+#ifndef __MACH_AUDIO_H
+#define __MACH_AUDIO_H
+
+#include <linux/mbus.h>
+
+struct kirkwood_soc_platform_data {
+	u32 tclk;
+	struct mbus_dram_target_info *dram;
+};
+
+extern struct kirkwood_soc_platform_data kirkwood_soc_data;
+
+#endif
