From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH 10/16] arm: ux500: Add support for MSP
	I2S-devices
Date: Tue, 13 Mar 2012 16:11:37 +0100
Message-ID: <1331651503-16917-11-git-send-email-ola.o.lilja@stericsson.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog119.obsmtp.com (eu1sys200aog119.obsmtp.com
	[207.126.144.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 407B5104383
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 16:12:48 +0100 (CET)
In-Reply-To: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
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
 arch/arm/mach-ux500/board-mop500-msp.c |  194 ++++++++++++++++++++++++++++++++
 arch/arm/mach-ux500/board-mop500.c     |    7 +-
 arch/arm/mach-ux500/board-mop500.h     |    1 +
 arch/arm/mach-ux500/clock.c            |    8 +-
 arch/arm/mach-ux500/devices-common.h   |    4 +-
 arch/arm/mach-ux500/include/mach/msp.h |   29 +++++
 7 files changed, 237 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/mach-ux500/board-mop500-msp.c
 create mode 100644 arch/arm/mach-ux500/include/mach/msp.h

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 6bd2f45..6ee4e84 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -11,7 +11,8 @@ obj-$(CONFIG_MACH_U8500)	+= board-mop500.o board-mop500-sdi.o \
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
index 0000000..4223b14
--- /dev/null
+++ b/arch/arm/mach-ux500/board-mop500-msp.c
@@ -0,0 +1,194 @@
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
+void __init mop500_msp_init(void)
+{
+	pr_info("Initialize MSP I2S-devices.\n");
+	db8500_add_msp0_i2s(&msp0_platform_data);
+	db8500_add_msp1_i2s(&msp1_platform_data);
+	db8500_add_msp2_i2s(&msp2_platform_data);
+	db8500_add_msp3_i2s(&msp3_platform_data);
+}
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 2df23ed..4b017a1 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -604,7 +604,6 @@ static struct platform_device *snowball_platform_devs[] __initdata = {
 static void __init mop500_init_machine(void)
 {
 	int i2c0_devs;
-
 	mop500_gpio_keys[0].gpio = GPIO_PROX_SENSOR;
 
 	u8500_init_devices();
@@ -613,12 +612,11 @@ static void __init mop500_init_machine(void)
 
 	platform_add_devices(mop500_platform_devs,
 			ARRAY_SIZE(mop500_platform_devs));
-
 	mop500_i2c_init();
 	mop500_sdi_init();
+	mop500_msp_init();
 	mop500_spi_init();
 	mop500_uart_init();
-
 	i2c0_devs = ARRAY_SIZE(mop500_i2c0_devices);
 
 	i2c_register_board_info(0, mop500_i2c0_devices, i2c0_devs);
@@ -642,6 +640,7 @@ static void __init snowball_init_machine(void)
 
 	mop500_i2c_init();
 	snowball_sdi_init();
+	mop500_msp_init();
 	mop500_spi_init();
 	mop500_uart_init();
 
@@ -657,7 +656,6 @@ static void __init snowball_init_machine(void)
 static void __init hrefv60_init_machine(void)
 {
 	int i2c0_devs;
-
 	/*
 	 * The HREFv60 board removed a GPIO expander and routed
 	 * all these GPIO pins to the internal GPIO controller
@@ -674,6 +672,7 @@ static void __init hrefv60_init_machine(void)
 
 	mop500_i2c_init();
 	hrefv60_sdi_init();
+	mop500_msp_init();
 	mop500_spi_init();
 	mop500_uart_init();
 
diff --git a/arch/arm/mach-ux500/board-mop500.h b/arch/arm/mach-ux500/board-mop500.h
index f926d3d..b377bbe 100644
--- a/arch/arm/mach-ux500/board-mop500.h
+++ b/arch/arm/mach-ux500/board-mop500.h
@@ -81,6 +81,7 @@ extern void hrefv60_sdi_init(void);
 extern void mop500_sdi_tc35892_init(void);
 void __init mop500_u8500uib_init(void);
 void __init mop500_stuib_init(void);
+void __init mop500_msp_init(void);
 void __init mop500_pins_init(void);
 void __init hrefv60_pins_init(void);
 void __init snowball_pins_init(void);
diff --git a/arch/arm/mach-ux500/clock.c b/arch/arm/mach-ux500/clock.c
index 7379075..8e93f1a 100644
--- a/arch/arm/mach-ux500/clock.c
+++ b/arch/arm/mach-ux500/clock.c
@@ -329,6 +329,7 @@ static DEFINE_PRCMU_CLK(uiccclk,	0x4, 1, UICCCLK); /* v1 */
  */
 
 /* Peripheral Cluster #1 */
+static DEFINE_PRCC_CLK(1, msp3,		11, 10, &clk_msp1clk);
 static DEFINE_PRCC_CLK(1, i2c4,		10, 9, &clk_i2cclk);
 static DEFINE_PRCC_CLK(1, gpio0,	9, -1, NULL);
 static DEFINE_PRCC_CLK(1, slimbus0,	8,  8, &clk_slimclk);
@@ -398,7 +399,7 @@ static struct clk_lookup u8500_clks[] = {
 	CLK(slimbus0,	"slimbus0",	NULL),
 	CLK(i2c2,	"nmk-i2c.2",	NULL),
 	CLK(sdi0,	"sdi0",		NULL),
-	CLK(msp0,	"msp0",		NULL),
+	CLK(msp0,	"ux500-msp-i2s.0",	NULL),
 	CLK(i2c1,	"nmk-i2c.1",	NULL),
 	CLK(uart1,	"uart1",	NULL),
 	CLK(uart0,	"uart0",	NULL),
@@ -448,7 +449,8 @@ static struct clk_lookup u8500_clks[] = {
 	/* Peripheral Cluster #1 */
 	CLK(i2c4,	"nmk-i2c.4",	NULL),
 	CLK(spi3,	"spi3",		NULL),
-	CLK(msp1,	"msp1",		NULL),
+	CLK(msp1,	"ux500-msp-i2s.1",	NULL),
+	CLK(msp3,	"ux500-msp-i2s.3",	NULL),
 
 	/* Peripheral Cluster #2 */
 	CLK(gpio1,	"gpio.6",	NULL),
@@ -458,7 +460,7 @@ static struct clk_lookup u8500_clks[] = {
 	CLK(spi0,	"spi0",		NULL),
 	CLK(sdi3,	"sdi3",		NULL),
 	CLK(sdi1,	"sdi1",		NULL),
-	CLK(msp2,	"msp2",		NULL),
+	CLK(msp2,	"ux500-msp-i2s.2",	NULL),
 	CLK(sdi4,	"sdi4",		NULL),
 	CLK(pwl,	"pwl",		NULL),
 	CLK(spi1,	"spi1",		NULL),
diff --git a/arch/arm/mach-ux500/devices-common.h b/arch/arm/mach-ux500/devices-common.h
index 7825705..024d51b 100644
--- a/arch/arm/mach-ux500/devices-common.h
+++ b/arch/arm/mach-ux500/devices-common.h
@@ -69,7 +69,9 @@ static inline struct platform_device *
 dbx500_add_msp_i2s(int id, resource_size_t base, int irq,
 		   struct msp_i2s_platform_data *pdata)
 {
-	return dbx500_add_platform_device_4k1irq("MSP_I2S", id, base, irq,
+	pr_info("Add platform-device 'ux500-msp-i2s', id %d, irq %d\n",
+		id, irq);
+	return dbx500_add_platform_device_4k1irq("ux500-msp-i2s", id, base, irq,
 						 pdata);
 }
 
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
