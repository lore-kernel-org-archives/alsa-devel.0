From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH 4/8] arm: ux500: Add support for MSP I2S-devices
Date: Fri, 20 Apr 2012 11:32:59 +0200
Message-ID: <1334914379-27445-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog116.obsmtp.com (eu1sys200aog116.obsmtp.com
	[207.126.144.141])
	by alsa0.perex.cz (Postfix) with ESMTP id ED313103F90
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Apr 2012 11:33:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

Create devices for the MSP-blocks (MSP0, MSP1, MSP2 and MSP3)
and associate it with the correct clocks in the clock-framework.

Signed-off-by: Ola Lilja <ola.o.lilja@stericsson.com>
---
 arch/arm/mach-ux500/Makefile           |    3 +-
 arch/arm/mach-ux500/board-mop500-msp.c |  250 ++++++++++++++++++++++++++++++++
 arch/arm/mach-ux500/board-mop500-msp.h |   14 ++
 arch/arm/mach-ux500/board-mop500.c     |    4 +
 arch/arm/mach-ux500/clock.c            |    8 +-
 arch/arm/mach-ux500/devices-db8500.h   |   10 --
 arch/arm/mach-ux500/include/mach/msp.h |   29 ++++
 7 files changed, 304 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm/mach-ux500/board-mop500-msp.c
 create mode 100644 arch/arm/mach-ux500/board-mop500-msp.h
 create mode 100644 arch/arm/mach-ux500/include/mach/msp.h

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 465b9ec..11729bc 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -11,7 +11,8 @@ obj-$(CONFIG_MACH_MOP500)	+= board-mop500.o board-mop500-sdi.o \
 				board-mop500-regulators.o \
 				board-mop500-uib.o board-mop500-stuib.o \
 				board-mop500-u8500uib.o \
-				board-mop500-pins.o
+				board-mop500-pins.o \
+				board-mop500-msp.o
 obj-$(CONFIG_MACH_U5500)	+= board-u5500.o board-u5500-sdi.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
diff --git a/arch/arm/mach-ux500/board-mop500-msp.c b/arch/arm/mach-ux500/board-mop500-msp.c
new file mode 100644
index 0000000..c8f6300
--- /dev/null
+++ b/arch/arm/mach-ux500/board-mop500-msp.c
@@ -0,0 +1,250 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * License terms: GNU General Public License (GPL), version 2
+ */
+
+#include <linux/platform_device.h>
+#include <linux/init.h>
+#include <linux/gpio.h>
+#include <plat/gpio-nomadik.h>
+
+#include <plat/pincfg.h>
+#include <plat/ste_dma40.h>
+
+#include <mach/devices.h>
+#include <ste-dma40-db8500.h>
+#include <mach/hardware.h>
+#include <mach/irqs.h>
+#include <mach/msp.h>
+
+#include "board-mop500.h"
+#include "devices-db8500.h"
+#include "pins-db8500.h"
+
+/* MSP1/3 Tx/Rx usage protection */
+static DEFINE_SPINLOCK(msp_rxtx_lock);
+
+/* Reference Count */
+static int msp_rxtx_ref;
+
+static pin_cfg_t mop500_msp1_pins_init[] = {
+		GPIO33_MSP1_TXD | PIN_OUTPUT_LOW   | PIN_SLPM_WAKEUP_DISABLE,
+		GPIO34_MSP1_TFS | PIN_INPUT_NOPULL | PIN_SLPM_WAKEUP_DISABLE,
+		GPIO35_MSP1_TCK | PIN_INPUT_NOPULL | PIN_SLPM_WAKEUP_DISABLE,
+		GPIO36_MSP1_RXD | PIN_INPUT_NOPULL | PIN_SLPM_WAKEUP_DISABLE,
+};
+
+static pin_cfg_t mop500_msp1_pins_exit[] = {
+		GPIO33_MSP1_TXD | PIN_OUTPUT_LOW   | PIN_SLPM_WAKEUP_ENABLE,
+		GPIO34_MSP1_TFS | PIN_INPUT_NOPULL | PIN_SLPM_WAKEUP_ENABLE,
+		GPIO35_MSP1_TCK | PIN_INPUT_NOPULL | PIN_SLPM_WAKEUP_ENABLE,
+		GPIO36_MSP1_RXD | PIN_INPUT_NOPULL | PIN_SLPM_WAKEUP_ENABLE,
+};
+
+int msp13_i2s_init(void)
+{
+	int retval = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&msp_rxtx_lock, flags);
+	if (msp_rxtx_ref == 0)
+		retval = nmk_config_pins(
+				ARRAY_AND_SIZE(mop500_msp1_pins_init));
+	if (!retval)
+		msp_rxtx_ref++;
+	spin_unlock_irqrestore(&msp_rxtx_lock, flags);
+
+	return retval;
+}
+
+int msp13_i2s_exit(void)
+{
+	int retval = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&msp_rxtx_lock, flags);
+	WARN_ON(!msp_rxtx_ref);
+	msp_rxtx_ref--;
+	if (msp_rxtx_ref == 0)
+		retval = nmk_config_pins_sleep(
+				ARRAY_AND_SIZE(mop500_msp1_pins_exit));
+	spin_unlock_irqrestore(&msp_rxtx_lock, flags);
+
+	return retval;
+}
+
+static struct stedma40_chan_cfg msp0_dma_rx = {
+	.high_priority = true,
+	.dir = STEDMA40_PERIPH_TO_MEM,
+
+	.src_dev_type = DB8500_DMA_DEV31_MSP0_RX_SLIM0_CH0_RX,
+	.dst_dev_type = STEDMA40_DEV_DST_MEMORY,
+
+	.src_info.psize = STEDMA40_PSIZE_LOG_4,
+	.dst_info.psize = STEDMA40_PSIZE_LOG_4,
+
+	/* data_width is set during configuration */
+};
+
+static struct stedma40_chan_cfg msp0_dma_tx = {
+	.high_priority = true,
+	.dir = STEDMA40_MEM_TO_PERIPH,
+
+	.src_dev_type = STEDMA40_DEV_DST_MEMORY,
+	.dst_dev_type = DB8500_DMA_DEV31_MSP0_TX_SLIM0_CH0_TX,
+
+	.src_info.psize = STEDMA40_PSIZE_LOG_4,
+	.dst_info.psize = STEDMA40_PSIZE_LOG_4,
+
+	/* data_width is set during configuration */
+};
+
+static struct msp_i2s_platform_data msp0_platform_data = {
+	.id = MSP_I2S_0,
+	.msp_i2s_dma_rx = &msp0_dma_rx,
+	.msp_i2s_dma_tx = &msp0_dma_tx,
+};
+
+static struct stedma40_chan_cfg msp1_dma_rx = {
+	.high_priority = true,
+	.dir = STEDMA40_PERIPH_TO_MEM,
+
+	.src_dev_type = DB8500_DMA_DEV30_MSP3_RX,
+	.dst_dev_type = STEDMA40_DEV_DST_MEMORY,
+
+	.src_info.psize = STEDMA40_PSIZE_LOG_4,
+	.dst_info.psize = STEDMA40_PSIZE_LOG_4,
+
+	/* data_width is set during configuration */
+};
+
+static struct stedma40_chan_cfg msp1_dma_tx = {
+	.high_priority = true,
+	.dir = STEDMA40_MEM_TO_PERIPH,
+
+	.src_dev_type = STEDMA40_DEV_DST_MEMORY,
+	.dst_dev_type = DB8500_DMA_DEV30_MSP1_TX,
+
+	.src_info.psize = STEDMA40_PSIZE_LOG_4,
+	.dst_info.psize = STEDMA40_PSIZE_LOG_4,
+
+	/* data_width is set during configuration */
+};
+
+static struct msp_i2s_platform_data msp1_platform_data = {
+	.id = MSP_I2S_1,
+	.msp_i2s_dma_rx = NULL,
+	.msp_i2s_dma_tx = &msp1_dma_tx,
+	.msp_i2s_init = msp13_i2s_init,
+	.msp_i2s_exit = msp13_i2s_exit,
+};
+
+static struct stedma40_chan_cfg msp2_dma_rx = {
+	.high_priority = true,
+	.dir = STEDMA40_PERIPH_TO_MEM,
+
+	.src_dev_type = DB8500_DMA_DEV14_MSP2_RX,
+	.dst_dev_type = STEDMA40_DEV_DST_MEMORY,
+
+	/* MSP2 DMA doesn't work with PSIZE == 4 on DB8500v2 */
+	.src_info.psize = STEDMA40_PSIZE_LOG_1,
+	.dst_info.psize = STEDMA40_PSIZE_LOG_1,
+
+	/* data_width is set during configuration */
+};
+
+static struct stedma40_chan_cfg msp2_dma_tx = {
+	.high_priority = true,
+	.dir = STEDMA40_MEM_TO_PERIPH,
+
+	.src_dev_type = STEDMA40_DEV_DST_MEMORY,
+	.dst_dev_type = DB8500_DMA_DEV14_MSP2_TX,
+
+	.src_info.psize = STEDMA40_PSIZE_LOG_4,
+	.dst_info.psize = STEDMA40_PSIZE_LOG_4,
+
+	.use_fixed_channel = true,
+	.phy_channel = 1,
+
+	/* data_width is set during configuration */
+};
+
+static int db8500_add_msp_i2s(struct device *parent, int id,
+			resource_size_t base, int irq,
+			struct msp_i2s_platform_data *pdata)
+{
+	struct platform_device *pdev;
+	struct resource res[] = {
+		DEFINE_RES_MEM(base, SZ_4K),
+		DEFINE_RES_IRQ(irq),
+	};
+
+	pr_info("Register platform-device 'ux500-msp-i2s', id %d, irq %d\n",
+		id, irq);
+	pdev = platform_device_register_resndata(parent, "ux500-msp-i2s", id,
+						res, ARRAY_SIZE(res),
+						pdata, sizeof(*pdata));
+	if (!pdev) {
+		pr_err("Failed to register platform-device 'ux500-msp-i2s.%d'!\n",
+			id);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/* Platform device for ASoC U8500 machine */
+static struct platform_device snd_soc_u8500 = {
+		.name = "snd-soc-u8500",
+		.id = 0,
+		.dev = {
+			.platform_data = NULL,
+		},
+};
+
+/* Platform device for Ux500-PCM */
+static struct platform_device ux500_pcm = {
+		.name = "ux500-pcm",
+		.id = 0,
+		.dev = {
+			.platform_data = NULL,
+		},
+};
+
+static struct msp_i2s_platform_data msp2_platform_data = {
+	.id = MSP_I2S_2,
+	.msp_i2s_dma_rx = &msp2_dma_rx,
+	.msp_i2s_dma_tx = &msp2_dma_tx,
+};
+
+static struct msp_i2s_platform_data msp3_platform_data = {
+	.id		= MSP_I2S_3,
+	.msp_i2s_dma_rx	= &msp1_dma_rx,
+	.msp_i2s_dma_tx	= NULL,
+	.msp_i2s_init = msp13_i2s_init,
+	.msp_i2s_exit = msp13_i2s_exit,
+};
+
+int mop500_msp_init(struct device *parent)
+{
+	int ret;
+
+	pr_info("%s: Register platform-device 'snd-soc-u8500'.\n", __func__);
+	platform_device_register(&snd_soc_u8500);
+
+	pr_info("Initialize MSP I2S-devices.\n");
+	ret = db8500_add_msp_i2s(parent, 0, U8500_MSP0_BASE, IRQ_DB8500_MSP0,
+				&msp0_platform_data);
+	ret |= db8500_add_msp_i2s(parent, 1, U8500_MSP1_BASE, IRQ_DB8500_MSP1,
+				&msp1_platform_data);
+	ret |= db8500_add_msp_i2s(parent, 2, U8500_MSP2_BASE, IRQ_DB8500_MSP2,
+				&msp2_platform_data);
+	ret |= db8500_add_msp_i2s(parent, 3, U8500_MSP3_BASE, IRQ_DB8500_MSP1,
+				&msp3_platform_data);
+
+	pr_info("%s: Register platform-device 'ux500-pcm'\n", __func__);
+	platform_device_register(&ux500_pcm);
+
+	return ret;
+}
diff --git a/arch/arm/mach-ux500/board-mop500-msp.h b/arch/arm/mach-ux500/board-mop500-msp.h
new file mode 100644
index 0000000..6fcfb5e
--- /dev/null
+++ b/arch/arm/mach-ux500/board-mop500-msp.h
@@ -0,0 +1,14 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2012
+ *
+ * Author: Ola Lilja <ola.o.lilja@stericsson.com>,
+ *         for ST-Ericsson.
+ *
+ * License terms:
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+void mop500_msp_init(struct device *parent);
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 9dfaab3..4cbed08 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -53,6 +53,7 @@
 #include "devices-db8500.h"
 #include "board-mop500.h"
 #include "board-mop500-regulators.h"
+#include "board-mop500-msp.h"
 
 static struct gpio_led snowball_led_array[] = {
 	{
@@ -631,6 +632,7 @@ static void __init mop500_init_machine(void)
 	mop500_i2c_init(parent);
 	mop500_sdi_init(parent);
 	mop500_spi_init(parent);
+	mop500_msp_init(parent);
 	mop500_uart_init(parent);
 
 	i2c0_devs = ARRAY_SIZE(mop500_i2c0_devices);
@@ -662,6 +664,7 @@ static void __init snowball_init_machine(void)
 	mop500_i2c_init(parent);
 	snowball_sdi_init(parent);
 	mop500_spi_init(parent);
+	mop500_msp_init(parent);
 	mop500_uart_init(parent);
 
 	i2c0_devs = ARRAY_SIZE(mop500_i2c0_devices);
@@ -699,6 +702,7 @@ static void __init hrefv60_init_machine(void)
 	mop500_i2c_init(parent);
 	hrefv60_sdi_init(parent);
 	mop500_spi_init(parent);
+	mop500_msp_init(parent);
 	mop500_uart_init(parent);
 
 	i2c0_devs = ARRAY_SIZE(mop500_i2c0_devices);
diff --git a/arch/arm/mach-ux500/clock.c b/arch/arm/mach-ux500/clock.c
index cc87f77..9c2ffcdf 100644
--- a/arch/arm/mach-ux500/clock.c
+++ b/arch/arm/mach-ux500/clock.c
@@ -336,6 +336,7 @@ static DEFINE_PRCMU_CLK(uiccclk,	0x4, 1, UICCCLK); /* v1 */
  */
 
 /* Peripheral Cluster #1 */
+static DEFINE_PRCC_CLK(1, msp3,		11, 10, &clk_msp1clk);
 static DEFINE_PRCC_CLK(1, i2c4,		10, 9, &clk_i2cclk);
 static DEFINE_PRCC_CLK(1, gpio0,	9, -1, NULL);
 static DEFINE_PRCC_CLK(1, slimbus0,	8,  8, &clk_slimclk);
@@ -405,7 +406,7 @@ static struct clk_lookup u8500_clks[] = {
 	CLK(slimbus0,	"slimbus0",	NULL),
 	CLK(i2c2,	"nmk-i2c.2",	NULL),
 	CLK(sdi0,	"sdi0",		NULL),
-	CLK(msp0,	"msp0",		NULL),
+	CLK(msp0,	"ux500-msp-i2s.0",	NULL),
 	CLK(i2c1,	"nmk-i2c.1",	NULL),
 	CLK(uart1,	"uart1",	NULL),
 	CLK(uart0,	"uart0",	NULL),
@@ -455,7 +456,8 @@ static struct clk_lookup u8500_clks[] = {
 	/* Peripheral Cluster #1 */
 	CLK(i2c4,	"nmk-i2c.4",	NULL),
 	CLK(spi3,	"spi3",		NULL),
-	CLK(msp1,	"msp1",		NULL),
+	CLK(msp1,	"ux500-msp-i2s.1",	NULL),
+	CLK(msp3,	"ux500-msp-i2s.3",	NULL),
 
 	/* Peripheral Cluster #2 */
 	CLK(gpio1,	"gpio.6",	NULL),
@@ -465,7 +467,7 @@ static struct clk_lookup u8500_clks[] = {
 	CLK(spi0,	"spi0",		NULL),
 	CLK(sdi3,	"sdi3",		NULL),
 	CLK(sdi1,	"sdi1",		NULL),
-	CLK(msp2,	"msp2",		NULL),
+	CLK(msp2,	"ux500-msp-i2s.2",	NULL),
 	CLK(sdi4,	"sdi4",		NULL),
 	CLK(pwl,	"pwl",		NULL),
 	CLK(spi1,	"spi1",		NULL),
diff --git a/arch/arm/mach-ux500/devices-db8500.h b/arch/arm/mach-ux500/devices-db8500.h
index 9fd93e9..e22b786 100644
--- a/arch/arm/mach-ux500/devices-db8500.h
+++ b/arch/arm/mach-ux500/devices-db8500.h
@@ -34,7 +34,6 @@ db8500_add_ssp(struct device *parent, const char *name, resource_size_t base,
 	return dbx500_add_amba_device(parent, name, base, irq, pdata, 0);
 }
 
-
 #define db8500_add_i2c0(parent, pdata) \
 	dbx500_add_i2c(parent, 0, U8500_I2C0_BASE, IRQ_DB8500_I2C0, pdata)
 #define db8500_add_i2c1(parent, pdata) \
@@ -46,15 +45,6 @@ db8500_add_ssp(struct device *parent, const char *name, resource_size_t base,
 #define db8500_add_i2c4(parent, pdata) \
 	dbx500_add_i2c(parent, 4, U8500_I2C4_BASE, IRQ_DB8500_I2C4, pdata)
 
-#define db8500_add_msp0_i2s(parent, pdata) \
-	dbx500_add_msp_i2s(parent, 0, U8500_MSP0_BASE, IRQ_DB8500_MSP0, pdata)
-#define db8500_add_msp1_i2s(parent, pdata) \
-	dbx500_add_msp_i2s(parent, 1, U8500_MSP1_BASE, IRQ_DB8500_MSP1, pdata)
-#define db8500_add_msp2_i2s(parent, pdata) \
-	dbx500_add_msp_i2s(parent, 2, U8500_MSP2_BASE, IRQ_DB8500_MSP2, pdata)
-#define db8500_add_msp3_i2s(parent, pdata) \
-	dbx500_add_msp_i2s(parent, 3, U8500_MSP3_BASE, IRQ_DB8500_MSP1, pdata)
-
 #define db8500_add_msp0_spi(parent, pdata) \
 	dbx500_add_msp_spi(parent, "msp0", U8500_MSP0_BASE, \
 			   IRQ_DB8500_MSP0, pdata)
diff --git a/arch/arm/mach-ux500/include/mach/msp.h b/arch/arm/mach-ux500/include/mach/msp.h
new file mode 100644
index 0000000..798be19
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/msp.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
+ * License terms: GNU General Public License (GPL), version 2.
+ */
+
+#ifndef __MSP_H
+#define __MSP_H
+
+#include <plat/ste_dma40.h>
+
+enum msp_i2s_id {
+	MSP_I2S_0 = 0,
+	MSP_I2S_1,
+	MSP_I2S_2,
+	MSP_I2S_3,
+};
+
+/* Platform data structure for a MSP I2S-device */
+struct msp_i2s_platform_data {
+	enum msp_i2s_id id;
+	struct stedma40_chan_cfg *msp_i2s_dma_rx;
+	struct stedma40_chan_cfg *msp_i2s_dma_tx;
+	int (*msp_i2s_init) (void);
+	int (*msp_i2s_exit) (void);
+};
+
+#endif
-- 
1.7.8.3
