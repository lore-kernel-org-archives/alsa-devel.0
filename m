From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH 3/3] ASoC: Ux500: Add driver for Ux500/AB8500
	platform/codec
Date: Mon, 30 Jan 2012 15:18:30 +0100
Message-ID: <1327933110-22229-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog113.obsmtp.com (eu1sys200aog113.obsmtp.com
	[207.126.144.135])
	by alsa0.perex.cz (Postfix) with ESMTP id 545B310396A
	for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2012 15:18:43 +0100 (CET)
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

Add the ST-Ericsson Ux500 ASoC platform-driver, AB8500 codec-driver and
machine-driver for U8500 hardware.

Signed-off-by: Ola Lilja <ola.o.lilja@stericsson.com>
---
 arch/arm/mach-ux500/Makefile                  |    3 +-
 arch/arm/mach-ux500/board-mop500-msp.c        |  195 ++
 arch/arm/mach-ux500/board-mop500-regulators.c |   28 +
 arch/arm/mach-ux500/board-mop500.c            |    7 +-
 arch/arm/mach-ux500/board-mop500.h            |    1 +
 arch/arm/mach-ux500/clock.c                   |    8 +-
 arch/arm/mach-ux500/devices-common.h          |    2 +-
 arch/arm/mach-ux500/include/mach/msp.h        | 1030 +++++++++
 include/sound/ux500_ab8500.h                  |   36 +
 sound/soc/Kconfig                             |    1 +
 sound/soc/Makefile                            |    1 +
 sound/soc/codecs/Kconfig                      |    4 +
 sound/soc/codecs/Makefile                     |    6 +
 sound/soc/codecs/Makefile.rej                 |   10 +
 sound/soc/codecs/ab8500_audio.c               | 2928 +++++++++++++++++++++++++
 sound/soc/codecs/ab8500_audio.h               |  673 ++++++
 sound/soc/ux500/Kconfig                       |   33 +
 sound/soc/ux500/Makefile                      |   25 +
 sound/soc/ux500/u8500.c                       |  150 ++
 sound/soc/ux500/ux500_ab8500.c                |  790 +++++++
 sound/soc/ux500/ux500_msp_dai.c               |  998 +++++++++
 sound/soc/ux500/ux500_msp_dai.h               |   83 +
 sound/soc/ux500/ux500_msp_i2s.c               | 1004 +++++++++
 sound/soc/ux500/ux500_msp_i2s.h               |   40 +
 sound/soc/ux500/ux500_pcm.c                   |  428 ++++
 sound/soc/ux500/ux500_pcm.h                   |   44 +
 26 files changed, 8519 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/mach-ux500/board-mop500-msp.c
 create mode 100644 arch/arm/mach-ux500/include/mach/msp.h
 create mode 100644 include/sound/ux500_ab8500.h
 create mode 100644 sound/soc/codecs/Makefile.rej
 create mode 100644 sound/soc/codecs/ab8500_audio.c
 create mode 100644 sound/soc/codecs/ab8500_audio.h
 create mode 100644 sound/soc/ux500/Kconfig
 create mode 100644 sound/soc/ux500/Makefile
 create mode 100644 sound/soc/ux500/u8500.c
 create mode 100644 sound/soc/ux500/ux500_ab8500.c
 create mode 100644 sound/soc/ux500/ux500_msp_dai.c
 create mode 100644 sound/soc/ux500/ux500_msp_dai.h
 create mode 100644 sound/soc/ux500/ux500_msp_i2s.c
 create mode 100644 sound/soc/ux500/ux500_msp_i2s.h
 create mode 100644 sound/soc/ux500/ux500_pcm.c
 create mode 100644 sound/soc/ux500/ux500_pcm.h

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
index 0000000..c6a73a0
--- /dev/null
+++ b/arch/arm/mach-ux500/board-mop500-msp.c
@@ -0,0 +1,195 @@
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
+#include <mach/msp.h>
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
+	.id = MSP_0_I2S_CONTROLLER,
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
+	.id = MSP_1_I2S_CONTROLLER,
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
+	.id = MSP_2_I2S_CONTROLLER,
+	.msp_i2s_dma_rx = &msp2_dma_rx,
+	.msp_i2s_dma_tx = &msp2_dma_tx,
+};
+
+static struct msp_i2s_platform_data msp3_platform_data = {
+	.id		= MSP_3_I2S_CONTROLLER,
+	.msp_i2s_dma_rx	= &msp1_dma_rx,
+	.msp_i2s_dma_tx	= NULL,
+	.msp_i2s_init = msp13_i2s_init,
+	.msp_i2s_exit = msp13_i2s_exit,
+};
+
+void __init mop500_msp_init(void)
+{
+	pr_err("DORIAN WAS HERE!\n");
+	db8500_add_msp0_i2s(&msp0_platform_data);
+	db8500_add_msp1_i2s(&msp1_platform_data);
+	db8500_add_msp2_i2s(&msp2_platform_data);
+	db8500_add_msp3_i2s(&msp3_platform_data);
+}
diff --git a/arch/arm/mach-ux500/board-mop500-regulators.c b/arch/arm/mach-ux500/board-mop500-regulators.c
index 2735d03..52426a4 100644
--- a/arch/arm/mach-ux500/board-mop500-regulators.c
+++ b/arch/arm/mach-ux500/board-mop500-regulators.c
@@ -74,6 +74,26 @@ static struct regulator_consumer_supply ab8500_vtvout_consumers[] = {
 	REGULATOR_SUPPLY("vddadc", "ab8500-gpadc.0"),
 };
 
+static struct regulator_consumer_supply ab8500_vaud_consumers[] = {
+	/* AB8500 audio-codec main supply */
+	REGULATOR_SUPPLY("vaud", "ab8500-codec.0"),
+};
+
+static struct regulator_consumer_supply ab8500_vamic1_consumers[] = {
+	/* AB8500 audio-codec Mic1 supply */
+	REGULATOR_SUPPLY("vamic1", "ab8500-codec.0"),
+};
+
+static struct regulator_consumer_supply ab8500_vamic2_consumers[] = {
+	/* AB8500 audio-codec Mic2 supply */
+	REGULATOR_SUPPLY("vamic2", "ab8500-codec.0"),
+};
+
+static struct regulator_consumer_supply ab8500_vdmic_consumers[] = {
+	/* AB8500 audio-codec DMic supply */
+	REGULATOR_SUPPLY("vdmic", "ab8500-codec.0"),
+};
+
 static struct regulator_consumer_supply ab8500_vintcore_consumers[] = {
 	/* SoC core supply, no device */
 	REGULATOR_SUPPLY("v-intcore", NULL),
@@ -323,6 +343,8 @@ struct regulator_init_data ab8500_regulators[AB8500_NUM_REGULATORS] = {
 			.name = "V-AUD",
 			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
 		},
+		.num_consumer_supplies = ARRAY_SIZE(ab8500_vaud_consumers),
+		.consumer_supplies = ab8500_vaud_consumers,
 	},
 	/* supply for v-anamic1 VAMic1-LDO */
 	[AB8500_LDO_ANAMIC1] = {
@@ -330,6 +352,8 @@ struct regulator_init_data ab8500_regulators[AB8500_NUM_REGULATORS] = {
 			.name = "V-AMIC1",
 			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
 		},
+		.num_consumer_supplies = ARRAY_SIZE(ab8500_vamic1_consumers),
+		.consumer_supplies = ab8500_vamic1_consumers,
 	},
 	/* supply for v-amic2, VAMIC2 LDO, reuse constants for AMIC1 */
 	[AB8500_LDO_ANAMIC2] = {
@@ -337,6 +361,8 @@ struct regulator_init_data ab8500_regulators[AB8500_NUM_REGULATORS] = {
 			.name = "V-AMIC2",
 			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
 		},
+		.num_consumer_supplies = ARRAY_SIZE(ab8500_vamic2_consumers),
+		.consumer_supplies = ab8500_vamic2_consumers,
 	},
 	/* supply for v-dmic, VDMIC LDO */
 	[AB8500_LDO_DMIC] = {
@@ -344,6 +370,8 @@ struct regulator_init_data ab8500_regulators[AB8500_NUM_REGULATORS] = {
 			.name = "V-DMIC",
 			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
 		},
+		.num_consumer_supplies = ARRAY_SIZE(ab8500_vdmic_consumers),
+		.consumer_supplies = ab8500_vdmic_consumers,
 	},
 	/* supply for v-intcore12, VINTCORE12 LDO */
 	[AB8500_LDO_INTCORE] = {
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
index ec35f0a..700042c 100644
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
diff --git a/arch/arm/mach-ux500/devices-common.h b/arch/arm/mach-ux500/devices-common.h
index 7825705..3e5bd4b 100644
--- a/arch/arm/mach-ux500/devices-common.h
+++ b/arch/arm/mach-ux500/devices-common.h
@@ -69,7 +69,7 @@ static inline struct platform_device *
 dbx500_add_msp_i2s(int id, resource_size_t base, int irq,
 		   struct msp_i2s_platform_data *pdata)
 {
-	return dbx500_add_platform_device_4k1irq("MSP_I2S", id, base, irq,
+	return dbx500_add_platform_device_4k1irq("ux500-msp-i2s", id, base, irq,
 						 pdata);
 }
 
diff --git a/arch/arm/mach-ux500/include/mach/msp.h b/arch/arm/mach-ux500/include/mach/msp.h
new file mode 100644
index 0000000..9055364
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/msp.h
@@ -0,0 +1,1030 @@
+/*
+ * Copyright (c) 2009 STMicroelectronics
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation.
+ */
+
+#ifndef _STM_MSP_HEADER
+#define _STM_MSP_HEADER
+#include <linux/device.h>
+#include <linux/spinlock.h>
+#include <linux/semaphore.h>
+#include <linux/dmaengine.h>
+#include <linux/irqreturn.h>
+#include <linux/bitops.h>
+#include <plat/ste_dma40.h>
+#include <linux/gpio.h>
+
+enum msp_data_size {
+	MSP_DATA_BITS_DEFAULT = -1,
+	MSP_DATA_BITS_8 = 0x00,
+	MSP_DATA_BITS_10,
+	MSP_DATA_BITS_12,
+	MSP_DATA_BITS_14,
+	MSP_DATA_BITS_16,
+	MSP_DATA_BITS_20,
+	MSP_DATA_BITS_24,
+	MSP_DATA_BITS_32,
+};
+
+enum msp_state {
+	MSP_STATE_IDLE = 0,
+	MSP_STATE_CONFIGURED = 1,
+	MSP_STATE_RUN = 2,
+};
+
+enum msp_rx_comparison_enable_mode {
+	MSP_COMPARISON_DISABLED = 0,
+	MSP_COMPARISON_NONEQUAL_ENABLED = 2,
+	MSP_COMPARISON_EQUAL_ENABLED = 3
+};
+
+#define RMCEN_BIT   0
+#define RMCSF_BIT   1
+#define RCMPM_BIT   3
+#define TMCEN_BIT   5
+#define TNCSF_BIT   6
+
+struct msp_multichannel_config {
+	bool rx_multichannel_enable;
+	bool tx_multichannel_enable;
+	enum msp_rx_comparison_enable_mode rx_comparison_enable_mode;
+	u8 padding;
+	u32 comparison_value;
+	u32 comparison_mask;
+	u32 rx_channel_0_enable;
+	u32 rx_channel_1_enable;
+	u32 rx_channel_2_enable;
+	u32 rx_channel_3_enable;
+	u32 tx_channel_0_enable;
+	u32 tx_channel_1_enable;
+	u32 tx_channel_2_enable;
+	u32 tx_channel_3_enable;
+};
+
+/**
+ * struct msp_protocol_desc- MSP Protocol desc structure per MSP.
+ * @rx_phase_mode: rx_phase_mode whether single or dual.
+ * @tx_phase_mode: tx_phase_mode whether single or dual.
+ * @rx_phase2_start_mode: rx_phase2_start_mode whether imediate or after
+ * some delay.
+ * @tx_phase2_start_mode: tx_phase2_start_mode whether imediate or after
+ * some delay.
+ * @rx_bit_transfer_format: MSP or LSB.
+ * @tx_bit_transfer_format: MSP or LSB.
+ * @rx_frame_length_1: Frame1 length 1,2,3..
+ * @rx_frame_length_2: Frame2 length 1,2,3..
+ * @tx_frame_length_1: Frame1 length 1,2,3..
+ * @tx_frame_length_2: Frame2 length 1,2,3..
+ * @rx_element_length_1: Element1 length 1,2,...
+ * @rx_element_length_2: Element2 length 1,2,...
+ * @tx_element_length_1: Element1 length 1,2,...
+ * @tx_element_length_2: Element2 length 1,2,...
+ * @rx_data_delay: Delay in clk cycle after frame sync
+ * @tx_data_delay: Delay in clk cycle after frame sync
+ * @rx_clock_pol: Rxpol whether rising or falling.It indicates pol of bit clock.
+ * @tx_clock_pol: Txpol whether rising or falling.It indicates pol of bit clock.
+ * @rx_frame_sync_pol: Frame sync pol whether rising or Falling.
+ * @tx_frame_sync_pol: Frame sync pol whether rising or Falling.
+ * @rx_half_word_swap: Word swap half word, full word.
+ * @tx_half_word_swap: Word swap half word, full word.
+ * @compression_mode: Compression mode whether Alaw or Ulaw or disabled.
+ * @expansion_mode: Compression mode whether Alaw or Ulaw or disabled.
+ * @spi_clk_mode: Spi clock mode to be enabled or not.
+ * @spi_burst_mode: Spi burst mode to be enabled or not.
+ * @frame_sync_ignore: Frame sync to be ignored or not. Ignore in case of Audio
+ * codec acting as Master.
+ * @frame_period: Frame period (clk cycles) after which new frame sync occurs.
+ * @frame_width: Frame width (clk cycles) after which frame sycn changes state.
+ * @total_clocks_for_one_frame: No. of clk cycles per frame.
+ *
+ * Main Msp protocol descriptor data structure to be used to store various info
+ * in transmit or recevie configuration registers of an MSP.
+ */
+
+struct msp_protocol_desc {
+	u32 rx_phase_mode;
+	u32 tx_phase_mode;
+	u32 rx_phase2_start_mode;
+	u32 tx_phase2_start_mode;
+	u32 rx_bit_transfer_format;
+	u32 tx_bit_transfer_format;
+	u32 rx_frame_length_1;
+	u32 rx_frame_length_2;
+	u32 tx_frame_length_1;
+	u32 tx_frame_length_2;
+	u32 rx_element_length_1;
+	u32 rx_element_length_2;
+	u32 tx_element_length_1;
+	u32 tx_element_length_2;
+	u32 rx_data_delay;
+	u32 tx_data_delay;
+	u32 rx_clock_pol;
+	u32 tx_clock_pol;
+	u32 rx_frame_sync_pol;
+	u32 tx_frame_sync_pol;
+	u32 rx_half_word_swap;
+	u32 tx_half_word_swap;
+	u32 compression_mode;
+	u32 expansion_mode;
+	u32 spi_clk_mode;
+	u32 spi_burst_mode;
+	u32 frame_sync_ignore;
+	u32 frame_period;
+	u32 frame_width;
+	u32 total_clocks_for_one_frame;
+};
+
+enum i2s_direction_t {
+	I2S_DIRECTION_TX = 0,
+	I2S_DIRECTION_RX = 1,
+	I2S_DIRECTION_BOTH = 2
+};
+
+enum i2s_transfer_mode_t {
+	I2S_TRANSFER_MODE_SINGLE_DMA = 0,
+	I2S_TRANSFER_MODE_CYCLIC_DMA = 1,
+	I2S_TRANSFER_MODE_INF_LOOPBACK = 2,
+	I2S_TRANSFER_MODE_NON_DMA = 4,
+};
+
+struct i2s_message {
+	enum i2s_direction_t i2s_direction;
+	void *txdata;
+	void *rxdata;
+	size_t txbytes;
+	size_t rxbytes;
+	int dma_flag;
+	int tx_offset;
+	int rx_offset;
+	/* cyclic dma */
+	bool cyclic_dma;
+	dma_addr_t buf_addr;
+	size_t buf_len;
+	size_t period_len;
+};
+
+enum i2s_flag {
+	DISABLE_ALL = 0,
+	DISABLE_TRANSMIT = 1,
+	DISABLE_RECEIVE = 2,
+};
+
+struct i2s_controller {
+	struct module *owner;
+	unsigned int id;
+	unsigned int class;
+	const struct i2s_algorithm *algo; /* the algorithm to access the bus */
+	void *data;
+	struct mutex bus_lock;
+	struct device dev; /* the controller device */
+	char name[48];
+};
+#define to_i2s_controller(d) container_of(d, struct i2s_controller, dev)
+
+/**
+ * struct trans_data - MSP transfer data structure used during xfer.
+ * @message: i2s message.
+ * @msp: msp structure.
+ * @tx_handler: callback handler for transmit path.
+ * @rx_handler: callback handler for receive path.
+ * @tx_callback_data: callback data for transmit.
+ * @rx_callback_data: callback data for receive.
+ *
+ */
+struct trans_data {
+	struct i2s_message message;
+	struct msp *msp;
+	void (*tx_handler) (void *data);
+	void (*rx_handler) (void *data);
+	void *tx_callback_data;
+	void *rx_callback_data;
+};
+
+/**
+ * struct msp_config- MSP configuration structure used by i2s client.
+ * @input_clock_freq: Input clock frequency default is 48MHz.
+ * @rx_clock_sel: Receive clock selection (Provided by Sample Gen or external
+ * source).
+ * @tx_clock_sel: Transmit clock selection (Provided by Sample Gen or external.
+ * source).
+ * @srg_clock_sel: APB clock or clock dervied from Slave (Audio codec).
+ * @rx_frame_sync_pol: Receive frame sync polarity.
+ * @tx_frame_sync_pol: Transmit frame sync polarity.
+ * @rx_frame_sync_sel: Rx frame sync signal is provided by which source.
+ * External source or by frame generator logic.
+ * @tx_frame_sync_sel: Tx frame sync signal is provided by which source.
+ * External source or by frame generator logic.
+ * @rx_fifo_config: Receive fifo enable or not.
+ * @tx_fifo_config: Transmit fifo enable or not.
+ * @spi_clk_mode: In case of SPI protocol spi modes: Normal, Zero delay or
+ * half cycle delay.
+ * @spi_burst_mode: Spi burst mode is enabled or not.
+ * @loopback_enable: Loopback mode.
+ * @tx_data_enable: Transmit extra delay enable.
+ * @default_protocol_desc: Flag to indicate client defined protocol desc or
+ * statically defined in msp.h.
+ * @protocol_desc: Protocol desc structure filled by i2s client driver.
+ * In case client defined default_prtocol_desc as 0.
+ * @multichannel_configured: multichannel configuration structure.
+ * @multichannel_config: multichannel is enabled or not.
+ * @direction: Transmit, Receive or Both.
+ * @work_mode: Dma, Polling or Interrupt.
+ * @protocol: I2S, PCM, etc.
+ * @frame_freq: Sampling freq at which data is sampled.
+ * @frame_size: size of element.
+ * @data_size: data size which defines the format in which data is written on
+ * transmit or receive fifo. Only three modes 8,16,32 are supported.
+ * @def_elem_len: Flag to indicate whether default element length is to be used
+ * or should be changed acc to data size defined by user at run time.
+ * @iodelay: value for the MSP_IODLY register
+ * @handler: callback handler in case of interrupt or dma.
+ * @tx_callback_data: Callback data for transmit.
+ * @rx_callback_data: Callback data for receive.
+ *
+ * Main Msp configuration data structure used by i2s client driver to fill
+ * various info like data size, frequency etc.
+ */
+struct msp_config {
+	unsigned int input_clock_freq;
+	unsigned int rx_clock_sel;
+	unsigned int tx_clock_sel;
+	unsigned int srg_clock_sel;
+	unsigned int rx_frame_sync_pol;
+	unsigned int tx_frame_sync_pol;
+	unsigned int rx_frame_sync_sel;
+	unsigned int tx_frame_sync_sel;
+	unsigned int rx_fifo_config;
+	unsigned int tx_fifo_config;
+	unsigned int spi_clk_mode;
+	unsigned int spi_burst_mode;
+	unsigned int loopback_enable;
+	unsigned int tx_data_enable;
+	unsigned int default_protocol_desc;
+	struct msp_protocol_desc protocol_desc;
+	int multichannel_configured;
+	struct msp_multichannel_config multichannel_config;
+	unsigned int direction;
+	unsigned int work_mode;
+	unsigned int protocol;
+	unsigned int frame_freq;
+	unsigned int frame_size;
+	enum msp_data_size data_size;
+	unsigned int def_elem_len;
+	unsigned int iodelay;
+	void (*handler) (void *data);
+	void *tx_callback_data;
+	void *rx_callback_data;
+
+};
+
+/*** Protocols ***/
+enum msp_protocol {
+	MSP_I2S_PROTOCOL,
+	MSP_PCM_PROTOCOL,
+	MSP_PCM_COMPAND_PROTOCOL,
+	MSP_AC97_PROTOCOL,
+	MSP_MASTER_SPI_PROTOCOL,
+	MSP_SLAVE_SPI_PROTOCOL,
+	MSP_INVALID_PROTOCOL
+};
+
+/*** Sample Frequencies ***/
+/* These are no longer required, frequencies in Hz can be used directly */
+enum msp_sample_freq {
+	MSP_SAMPLE_FREQ_NOT_SUPPORTED = -1,
+	MSP_SAMPLE_FREQ_8KHZ = 8000,
+	MSP_SAMPLE_FREQ_12KHZ = 12000,
+	MSP_SAMPLE_FREQ_16KHZ = 16000,
+	MSP_SAMPLE_FREQ_24KHZ = 24000,
+	MSP_SAMPLE_FREQ_32KHZ = 32000,
+	MSP_SAMPLE_FREQ_44KHZ = 44000,
+	MSP_SAMPLE_FREQ_48KHZ = 48000,
+	MSP_SAMPLE_FREQ_64KHZ = 64000,
+	MSP_SAMPLE_FREQ_88KHZ = 88000,
+	MSP_SAMPLE_FREQ_96KHZ = 96000,
+	MSP_SAMPLE_FREQ_22KHZ = 22000,
+	MSP_SAMPLE_FREQ_11KHZ = 11000
+};
+
+/*** Input Frequencies ***/
+/* These are no longer required, frequencies in Hz can be used directly */
+enum msp_in_clock_freq {
+	MSP_INPUT_FREQ_1MHZ = 1000,
+	MSP_INPUT_FREQ_2MHZ = 2000,
+	MSP_INPUT_FREQ_3MHZ = 3000,
+	MSP_INPUT_FREQ_4MHZ = 4000,
+	MSP_INPUT_FREQ_5MHZ = 5000,
+	MSP_INPUT_FREQ_6MHZ = 6000,
+	MSP_INPUT_FREQ_8MHZ = 8000,
+	MSP_INPUT_FREQ_11MHZ = 11000,
+	MSP_INPUT_FREQ_12MHZ = 12000,
+	MSP_INPUT_FREQ_16MHZ = 16000,
+	MSP_INPUT_FREQ_22MHZ = 22000,
+	MSP_INPUT_FREQ_24MHZ = 24000,
+	MSP_INPUT_FREQ_48MHZ = 48000
+};
+
+#define MSP_INPUT_FREQ_APB 48000000
+
+/*** Stereo mode. Used for APB data accesses as 16 bits accesses (mono),
+ *   32 bits accesses (stereo).
+ ***/
+enum msp_stereo_mode {
+	MSP_MONO,
+	MSP_STEREO
+};
+
+/* Direction (Transmit/Receive mode) */
+enum msp_direction {
+	MSP_TRANSMIT_MODE,
+	MSP_RECEIVE_MODE,
+	MSP_BOTH_T_R_MODE
+};
+
+/* Dma mode should be used for large transfers,
+ * polling mode should be used for transfers of a few bytes
+ */
+enum msp_xfer_mode {
+	MSP_DMA_MODE,
+	MSP_POLLING_MODE,
+	MSP_INTERRUPT_MODE
+};
+
+/* User client for the MSP */
+enum msp_user {
+	MSP_NO_USER = 0,
+	MSP_USER_SPI,
+	MSP_USER_ALSA,
+	MSP_USER_SAA,
+};
+
+/*Flag structure for MSPx*/
+struct msp_flag {
+	struct semaphore lock;
+	enum msp_user user;
+};
+
+/* User client for the MSP */
+enum msp_mode {
+	MSP_NO_MODE = 0,
+	MSP_MODE_SPI,
+	MSP_MODE_NON_SPI,
+};
+
+/* Transmit and receive configuration register */
+#define MSP_BIG_ENDIAN           0x00000000
+#define MSP_LITTLE_ENDIAN        0x00001000
+#define MSP_UNEXPECTED_FS_ABORT  0x00000000
+#define MSP_UNEXPECTED_FS_IGNORE 0x00008000
+#define MSP_NON_MODE_BIT_MASK    0x00009000
+
+/* Global configuration register */
+#define RX_ENABLE             0x00000001
+#define RX_FIFO_ENABLE        0x00000002
+#define RX_SYNC_SRG           0x00000010
+#define RX_CLK_POL_RISING     0x00000020
+#define RX_CLK_SEL_SRG        0x00000040
+#define TX_ENABLE             0x00000100
+#define TX_FIFO_ENABLE        0x00000200
+#define TX_SYNC_SRG_PROG      0x00001800
+#define TX_SYNC_SRG_AUTO      0x00001000
+#define TX_CLK_POL_RISING     0x00002000
+#define TX_CLK_SEL_SRG        0x00004000
+#define TX_EXTRA_DELAY_ENABLE 0x00008000
+#define SRG_ENABLE            0x00010000
+#define FRAME_GEN_ENABLE      0x00100000
+#define SRG_CLK_SEL_APB       0x00000000
+#define RX_FIFO_SYNC_HI       0x00000000
+#define TX_FIFO_SYNC_HI       0x00000000
+#define SPI_CLK_MODE_NORMAL   0x00000000
+
+/* SPI Clock Modes enumertion
+ * SPI clock modes of MSP provides compatibility with
+ * the SPI protocol.MSP supports 2 SPI transfer formats.
+ * MSP_ZERO_DELAY_SPI_MODE:MSP transmits data over Tx/Rx
+ * Lines immediately after MSPTCK/MSPRCK rising/falling edge.
+ * MSP_HALF_CYCLE_DELY_SPI_MODE:MSP transmits data  one-half cycle
+ * ahead of the rising/falling edge of the MSPTCK
+ */
+
+#define MSP_FRAME_SIZE_AUTO -1
+
+
+#define MSP_DR		0x00
+#define MSP_GCR		0x04
+#define MSP_TCF		0x08
+#define MSP_RCF		0x0c
+#define MSP_SRG		0x10
+#define MSP_FLR		0x14
+#define MSP_DMACR	0x18
+
+#define MSP_IMSC	0x20
+#define MSP_RIS		0x24
+#define MSP_MIS		0x28
+#define MSP_ICR		0x2c
+#define MSP_MCR		0x30
+#define MSP_RCV		0x34
+#define MSP_RCM		0x38
+
+#define MSP_TCE0	0x40
+#define MSP_TCE1	0x44
+#define MSP_TCE2	0x48
+#define MSP_TCE3	0x4c
+
+#define MSP_RCE0	0x60
+#define MSP_RCE1	0x64
+#define MSP_RCE2	0x68
+#define MSP_RCE3	0x6c
+#define MSP_IODLY	0x70
+
+#define MSP_ITCR	0x80
+#define MSP_ITIP	0x84
+#define MSP_ITOP	0x88
+#define MSP_TSTDR	0x8c
+
+#define MSP_PID0	0xfe0
+#define MSP_PID1	0xfe4
+#define MSP_PID2	0xfe8
+#define MSP_PID3	0xfec
+
+#define MSP_CID0	0xff0
+#define MSP_CID1	0xff4
+#define MSP_CID2	0xff8
+#define MSP_CID3	0xffc
+
+/* Single or dual phase mode */
+enum msp_phase_mode {
+	MSP_SINGLE_PHASE,
+	MSP_DUAL_PHASE
+};
+
+/* Frame length */
+enum msp_frame_length {
+	MSP_FRAME_LENGTH_1 = 0,
+	MSP_FRAME_LENGTH_2 = 1,
+	MSP_FRAME_LENGTH_4 = 3,
+	MSP_FRAME_LENGTH_8 = 7,
+	MSP_FRAME_LENGTH_12 = 11,
+	MSP_FRAME_LENGTH_16 = 15,
+	MSP_FRAME_LENGTH_20 = 19,
+	MSP_FRAME_LENGTH_32 = 31,
+	MSP_FRAME_LENGTH_48 = 47,
+	MSP_FRAME_LENGTH_64 = 63
+};
+
+/* Element length */
+enum msp_elem_length {
+	MSP_ELEM_LENGTH_8 = 0,
+	MSP_ELEM_LENGTH_10 = 1,
+	MSP_ELEM_LENGTH_12 = 2,
+	MSP_ELEM_LENGTH_14 = 3,
+	MSP_ELEM_LENGTH_16 = 4,
+	MSP_ELEM_LENGTH_20 = 5,
+	MSP_ELEM_LENGTH_24 = 6,
+	MSP_ELEM_LENGTH_32 = 7
+};
+
+enum msp_data_xfer_width {
+	MSP_DATA_TRANSFER_WIDTH_BYTE,
+	MSP_DATA_TRANSFER_WIDTH_HALFWORD,
+	MSP_DATA_TRANSFER_WIDTH_WORD
+};
+
+enum msp_frame_sync {
+	MSP_FRAME_SYNC_UNIGNORE = 0,
+	MSP_FRAME_SYNC_IGNORE = 1,
+
+};
+
+enum msp_phase2_start_mode {
+	MSP_PHASE2_START_MODE_IMEDIATE,
+	MSP_PHASE2_START_MODE_FRAME_SYNC
+};
+
+enum msp_btf {
+	MSP_BTF_MS_BIT_FIRST = 0,
+	MSP_BTF_LS_BIT_FIRST = 1
+};
+
+enum msp_frame_sync_pol {
+	MSP_FRAME_SYNC_POL_ACTIVE_HIGH = 0,
+	MSP_FRAME_SYNC_POL_ACTIVE_LOW = 1
+};
+
+/* Data delay (in bit clock cycles) */
+enum msp_delay {
+	MSP_DELAY_0 = 0,
+	MSP_DELAY_1 = 1,
+	MSP_DELAY_2 = 2,
+	MSP_DELAY_3 = 3
+};
+
+/* Configurations of clocks (transmit, receive or sample rate generator) */
+enum msp_edge {
+	MSP_FALLING_EDGE = 0,
+	MSP_RISING_EDGE = 1,
+};
+
+enum msp_hws {
+	MSP_HWS_NO_SWAP = 0,
+	MSP_HWS_BYTE_SWAP_IN_WORD = 1,
+	MSP_HWS_BYTE_SWAP_IN_EACH_HALF_WORD = 2,
+	MSP_HWS_HALF_WORD_SWAP_IN_WORD = 3
+};
+
+enum msp_compress_mode {
+	MSP_COMPRESS_MODE_LINEAR = 0,
+	MSP_COMPRESS_MODE_MU_LAW = 2,
+	MSP_COMPRESS_MODE_A_LAW = 3
+};
+
+enum msp_spi_clock_mode {
+	MSP_SPI_CLOCK_MODE_NON_SPI = 0,
+	MSP_SPI_CLOCK_MODE_ZERO_DELAY = 2,
+	MSP_SPI_CLOCK_MODE_HALF_CYCLE_DELAY = 3
+};
+
+enum msp_spi_burst_mode {
+	MSP_SPI_BURST_MODE_DISABLE = 0,
+	MSP_SPI_BURST_MODE_ENABLE = 1
+};
+
+enum msp_expand_mode {
+	MSP_EXPAND_MODE_LINEAR = 0,
+	MSP_EXPAND_MODE_LINEAR_SIGNED = 1,
+	MSP_EXPAND_MODE_MU_LAW = 2,
+	MSP_EXPAND_MODE_A_LAW = 3
+};
+
+/* Protocol dependant parameters list */
+#define RX_ENABLE_MASK         BIT(0)
+#define RX_FIFO_ENABLE_MASK    BIT(1)
+#define RX_FRAME_SYNC_MASK     BIT(2)
+#define DIRECT_COMPANDING_MASK BIT(3)
+#define RX_SYNC_SEL_MASK       BIT(4)
+#define RX_CLK_POL_MASK        BIT(5)
+#define RX_CLK_SEL_MASK        BIT(6)
+#define LOOPBACK_MASK          BIT(7)
+#define TX_ENABLE_MASK         BIT(8)
+#define TX_FIFO_ENABLE_MASK    BIT(9)
+#define TX_FRAME_SYNC_MASK     BIT(10)
+#define TX_MSP_TDR_TSR         BIT(11)
+#define TX_SYNC_SEL_MASK       (BIT(12) | BIT(11))
+#define TX_CLK_POL_MASK        BIT(13)
+#define TX_CLK_SEL_MASK        BIT(14)
+#define TX_EXTRA_DELAY_MASK    BIT(15)
+#define SRG_ENABLE_MASK        BIT(16)
+#define SRG_CLK_POL_MASK       BIT(17)
+#define SRG_CLK_SEL_MASK       (BIT(19) | BIT(18))
+#define FRAME_GEN_EN_MASK      BIT(20)
+#define SPI_CLK_MODE_MASK      (BIT(22) | BIT(21))
+#define SPI_BURST_MODE_MASK    BIT(23)
+
+#define RXEN_SHIFT		0
+#define RFFEN_SHIFT		1
+#define RFSPOL_SHIFT		2
+#define DCM_SHIFT		3
+#define RFSSEL_SHIFT		4
+#define RCKPOL_SHIFT		5
+#define RCKSEL_SHIFT		6
+#define LBM_SHIFT		7
+#define TXEN_SHIFT		8
+#define TFFEN_SHIFT		9
+#define TFSPOL_SHIFT		10
+#define TFSSEL_SHIFT		11
+#define TCKPOL_SHIFT		13
+#define TCKSEL_SHIFT		14
+#define TXDDL_SHIFT		15
+#define SGEN_SHIFT		16
+#define SCKPOL_SHIFT		17
+#define SCKSEL_SHIFT		18
+#define FGEN_SHIFT		20
+#define SPICKM_SHIFT		21
+#define TBSWAP_SHIFT      28
+
+#define RCKPOL_MASK BIT(0)
+#define TCKPOL_MASK BIT(0)
+#define SPICKM_MASK (BIT(1) | BIT(0))
+#define MSP_RX_CLKPOL_BIT(n)     ((n & RCKPOL_MASK) << RCKPOL_SHIFT)
+#define MSP_TX_CLKPOL_BIT(n)     ((n & TCKPOL_MASK) << TCKPOL_SHIFT)
+#define MSP_SPI_CLK_MODE_BITS(n) ((n & SPICKM_MASK) << SPICKM_SHIFT)
+
+
+
+/* Use this to clear the clock mode bits to non-spi */
+#define MSP_NON_SPI_CLK_MASK (BIT(22) | BIT(21))
+
+#define P1ELEN_SHIFT		0
+#define P1FLEN_SHIFT		3
+#define DTYP_SHIFT		10
+#define ENDN_SHIFT		12
+#define DDLY_SHIFT		13
+#define FSIG_SHIFT		15
+#define P2ELEN_SHIFT		16
+#define P2FLEN_SHIFT		19
+#define P2SM_SHIFT		26
+#define P2EN_SHIFT		27
+#define FRAME_SYNC_SHIFT		15
+
+
+#define P1ELEN_MASK 0x00000007
+#define P2ELEN_MASK 0x00070000
+#define P1FLEN_MASK 0x00000378
+#define P2FLEN_MASK 0x03780000
+#define DDLY_MASK 0x00003000
+#define DTYP_MASK 0x00000600
+#define P2SM_MASK 0x04000000
+#define P2EN_MASK 0x08000000
+#define ENDN_MASK 0x00001000
+#define TFSPOL_MASK 0x00000400
+#define TBSWAP_MASK 0x30000000
+#define COMPANDING_MODE_MASK 0x00000c00
+#define FRAME_SYNC_MASK 0x00008000
+
+#define MSP_P1_ELEM_LEN_BITS(n) (n & P1ELEN_MASK)
+#define MSP_P2_ELEM_LEN_BITS(n)  (((n) << P2ELEN_SHIFT) & P2ELEN_MASK)
+#define MSP_P1_FRAME_LEN_BITS(n) (((n) << P1FLEN_SHIFT) & P1FLEN_MASK)
+#define MSP_P2_FRAME_LEN_BITS(n) (((n) << P2FLEN_SHIFT) & P2FLEN_MASK)
+#define MSP_DATA_DELAY_BITS(n)   (((n) << DDLY_SHIFT) & DDLY_MASK)
+#define MSP_DATA_TYPE_BITS(n)    (((n) << DTYP_SHIFT) & DTYP_MASK)
+#define MSP_P2_START_MODE_BIT(n) ((n << P2SM_SHIFT) & P2SM_MASK)
+#define MSP_P2_ENABLE_BIT(n)     ((n << P2EN_SHIFT) & P2EN_MASK)
+#define MSP_SET_ENDIANNES_BIT(n) ((n << ENDN_SHIFT) & ENDN_MASK)
+#define MSP_FRAME_SYNC_POL(n)	((n << TFSPOL_SHIFT) & TFSPOL_MASK)
+#define MSP_DATA_WORD_SWAP(n)	((n << TBSWAP_SHIFT) & TBSWAP_MASK)
+#define MSP_SET_COMPANDING_MODE(n) ((n << DTYP_SHIFT) & COMPANDING_MODE_MASK)
+#define MSP_SET_FRAME_SYNC_IGNORE(n) ((n << FRAME_SYNC_SHIFT) & \
+				      FRAME_SYNC_MASK)
+
+/* Flag register */
+#define RX_BUSY       BIT(0)
+#define RX_FIFO_EMPTY BIT(1)
+#define RX_FIFO_FULL  BIT(2)
+#define TX_BUSY       BIT(3)
+#define TX_FIFO_EMPTY BIT(4)
+#define TX_FIFO_FULL  BIT(5)
+
+#define RBUSY_SHIFT		0
+#define RFE_SHIFT			1
+#define RFU_SHIFT			2
+#define TBUSY_SHIFT		3
+#define TFE_SHIFT			4
+#define TFU_SHIFT			5
+
+/* Multichannel control register */
+#define RMCEN_SHIFT		0
+#define RMCSF_SHIFT		1
+#define RCMPM_SHIFT		3
+#define TMCEN_SHIFT		5
+#define TNCSF_SHIFT		6
+
+/* Sample rate generator register */
+#define SCKDIV_SHIFT		0
+#define FRWID_SHIFT		10
+#define FRPER_SHIFT		16
+
+#define SCK_DIV_MASK 0x0000003FF
+#define FRAME_WIDTH_BITS(n) (((n) << FRWID_SHIFT)  & 0x0000FC00)
+#define FRAME_PERIOD_BITS(n) (((n) << FRPER_SHIFT) & 0x1FFF0000)
+
+/* DMA controller register */
+#define RX_DMA_ENABLE BIT(0)
+#define TX_DMA_ENABLE BIT(1)
+
+#define RDMAE_SHIFT		0
+#define TDMAE_SHIFT		1
+
+/* Interrupt Register */
+#define RECEIVE_SERVICE_INT		BIT(0)
+#define RECEIVE_OVERRUN_ERROR_INT	BIT(1)
+#define RECEIVE_FRAME_SYNC_ERR_INT	BIT(2)
+#define RECEIVE_FRAME_SYNC_INT		BIT(3)
+#define TRANSMIT_SERVICE_INT		BIT(4)
+#define TRANSMIT_UNDERRUN_ERR_INT	BIT(5)
+#define TRANSMIT_FRAME_SYNC_ERR_INT	BIT(6)
+#define TRANSMIT_FRAME_SYNC_INT		BIT(7)
+#define ALL_INT				0x000000ff
+
+/* MSP test control register */
+#define MSP_ITCR_ITEN			BIT(0)
+#define MSP_ITCR_TESTFIFO		BIT(1)
+
+/*
+ *  Protocol configuration values I2S:
+ *  Single phase, 16 bits, 2 words per frame
+ */
+#define I2S_PROTOCOL_DESC				\
+{							\
+	MSP_SINGLE_PHASE,				\
+	MSP_SINGLE_PHASE,				\
+	MSP_PHASE2_START_MODE_IMEDIATE,			\
+	MSP_PHASE2_START_MODE_IMEDIATE,			\
+	MSP_BTF_MS_BIT_FIRST,				\
+	MSP_BTF_MS_BIT_FIRST,				\
+	MSP_FRAME_LENGTH_1,				\
+	MSP_FRAME_LENGTH_1,				\
+	MSP_FRAME_LENGTH_1,				\
+	MSP_FRAME_LENGTH_1,				\
+	MSP_ELEM_LENGTH_32,				\
+	MSP_ELEM_LENGTH_32,				\
+	MSP_ELEM_LENGTH_32,				\
+	MSP_ELEM_LENGTH_32,				\
+	MSP_DELAY_1,					\
+	MSP_DELAY_1,					\
+	MSP_RISING_EDGE,				\
+	MSP_FALLING_EDGE,				\
+	MSP_FRAME_SYNC_POL_ACTIVE_LOW,			\
+	MSP_FRAME_SYNC_POL_ACTIVE_LOW,			\
+	MSP_HWS_NO_SWAP,				\
+	MSP_HWS_NO_SWAP,				\
+	MSP_COMPRESS_MODE_LINEAR,			\
+	MSP_EXPAND_MODE_LINEAR,				\
+	MSP_SPI_CLOCK_MODE_NON_SPI,			\
+	MSP_SPI_BURST_MODE_DISABLE,			\
+	MSP_FRAME_SYNC_IGNORE,			\
+	31,						\
+	15,						\
+	32,						\
+}
+
+#define PCM_PROTOCOL_DESC				\
+{							\
+	MSP_DUAL_PHASE,				\
+	MSP_DUAL_PHASE,				\
+	MSP_PHASE2_START_MODE_FRAME_SYNC,		\
+	MSP_PHASE2_START_MODE_FRAME_SYNC,		\
+	MSP_BTF_MS_BIT_FIRST,				\
+	MSP_BTF_MS_BIT_FIRST,				\
+	MSP_FRAME_LENGTH_1,				\
+	MSP_FRAME_LENGTH_1,				\
+	MSP_FRAME_LENGTH_1,				\
+	MSP_FRAME_LENGTH_1,				\
+	MSP_ELEM_LENGTH_16,				\
+	MSP_ELEM_LENGTH_16,				\
+	MSP_ELEM_LENGTH_16,				\
+	MSP_ELEM_LENGTH_16,				\
+	MSP_DELAY_0,					\
+	MSP_DELAY_0,					\
+	MSP_RISING_EDGE,				\
+	MSP_FALLING_EDGE,				\
+	MSP_FRAME_SYNC_POL_ACTIVE_HIGH,			\
+	MSP_FRAME_SYNC_POL_ACTIVE_HIGH,			\
+	MSP_HWS_NO_SWAP,				\
+	MSP_HWS_NO_SWAP,				\
+	MSP_COMPRESS_MODE_LINEAR,			\
+	MSP_EXPAND_MODE_LINEAR,				\
+	MSP_SPI_CLOCK_MODE_NON_SPI,			\
+	MSP_SPI_BURST_MODE_DISABLE,			\
+	MSP_FRAME_SYNC_IGNORE,			\
+	255,						\
+	0,						\
+	256,						\
+}
+
+/* Companded PCM: Single phase, 8 bits, 1 word per frame */
+#define PCM_COMPAND_PROTOCOL_DESC				\
+{							\
+	MSP_SINGLE_PHASE,				\
+	MSP_SINGLE_PHASE,				\
+	MSP_PHASE2_START_MODE_FRAME_SYNC,		\
+	MSP_PHASE2_START_MODE_FRAME_SYNC,		\
+	MSP_BTF_MS_BIT_FIRST,				\
+	MSP_BTF_MS_BIT_FIRST,				\
+	MSP_FRAME_LENGTH_1,				\
+	MSP_FRAME_LENGTH_1,				\
+	MSP_FRAME_LENGTH_1,				\
+	MSP_FRAME_LENGTH_1,				\
+	MSP_ELEM_LENGTH_8,				\
+	MSP_ELEM_LENGTH_8,				\
+	MSP_ELEM_LENGTH_8,				\
+	MSP_ELEM_LENGTH_8,				\
+	MSP_DELAY_0,					\
+	MSP_DELAY_0,					\
+	MSP_RISING_EDGE,				\
+	MSP_RISING_EDGE,				\
+	MSP_FRAME_SYNC_POL_ACTIVE_HIGH,			\
+	MSP_FRAME_SYNC_POL_ACTIVE_HIGH,			\
+	MSP_HWS_NO_SWAP,				\
+	MSP_HWS_NO_SWAP,				\
+	MSP_COMPRESS_MODE_LINEAR,			\
+	MSP_EXPAND_MODE_LINEAR,				\
+	MSP_SPI_CLOCK_MODE_NON_SPI,			\
+	MSP_SPI_BURST_MODE_DISABLE,			\
+	MSP_FRAME_SYNC_IGNORE,			\
+	255,						\
+	0,						\
+	256,						\
+}
+
+/*
+ * AC97: Double phase, 1 element of 16 bits during first phase,
+ * 12 elements of 20 bits in second phase.
+ */
+#define AC97_PROTOCOL_DESC				\
+{							\
+	MSP_DUAL_PHASE,				\
+	MSP_DUAL_PHASE,				\
+	MSP_PHASE2_START_MODE_FRAME_SYNC,		\
+	MSP_PHASE2_START_MODE_FRAME_SYNC,		\
+	MSP_BTF_MS_BIT_FIRST,				\
+	MSP_BTF_MS_BIT_FIRST,				\
+	MSP_FRAME_LENGTH_1,				\
+	MSP_FRAME_LENGTH_12,				\
+	MSP_FRAME_LENGTH_1,				\
+	MSP_FRAME_LENGTH_12,				\
+	MSP_ELEM_LENGTH_16,				\
+	MSP_ELEM_LENGTH_20,				\
+	MSP_ELEM_LENGTH_16,				\
+	MSP_ELEM_LENGTH_20,				\
+	MSP_DELAY_1,					\
+	MSP_DELAY_1,					\
+	MSP_RISING_EDGE,				\
+	MSP_RISING_EDGE,				\
+	MSP_FRAME_SYNC_POL_ACTIVE_HIGH,			\
+	MSP_FRAME_SYNC_POL_ACTIVE_HIGH,			\
+	MSP_HWS_NO_SWAP,				\
+	MSP_HWS_NO_SWAP,				\
+	MSP_COMPRESS_MODE_LINEAR,			\
+	MSP_EXPAND_MODE_LINEAR,				\
+	MSP_SPI_CLOCK_MODE_NON_SPI,			\
+	MSP_SPI_BURST_MODE_DISABLE,			\
+	MSP_FRAME_SYNC_IGNORE,			\
+	255,						\
+	0,						\
+	256,						\
+}
+
+#define SPI_MASTER_PROTOCOL_DESC				\
+{							\
+	MSP_SINGLE_PHASE,				\
+	MSP_SINGLE_PHASE,				\
+	MSP_PHASE2_START_MODE_FRAME_SYNC,		\
+	MSP_PHASE2_START_MODE_FRAME_SYNC,		\
+	MSP_BTF_MS_BIT_FIRST,				\
+	MSP_BTF_MS_BIT_FIRST,				\
+	MSP_FRAME_LENGTH_1,				\
+	MSP_FRAME_LENGTH_1,				\
+	MSP_FRAME_LENGTH_1,				\
+	MSP_FRAME_LENGTH_1,				\
+	MSP_ELEM_LENGTH_8,				\
+	MSP_ELEM_LENGTH_8,				\
+	MSP_ELEM_LENGTH_8,				\
+	MSP_ELEM_LENGTH_8,				\
+	MSP_DELAY_1,					\
+	MSP_DELAY_1,					\
+	MSP_FALLING_EDGE,				\
+	MSP_FALLING_EDGE,				\
+	MSP_FRAME_SYNC_POL_ACTIVE_HIGH,			\
+	MSP_FRAME_SYNC_POL_ACTIVE_HIGH,			\
+	MSP_HWS_NO_SWAP,				\
+	MSP_HWS_NO_SWAP,				\
+	MSP_COMPRESS_MODE_LINEAR,			\
+	MSP_EXPAND_MODE_LINEAR,				\
+	MSP_SPI_CLOCK_MODE_NON_SPI,			\
+	MSP_SPI_BURST_MODE_DISABLE,			\
+	MSP_FRAME_SYNC_IGNORE,			\
+	255,						\
+	0,						\
+	256,						\
+}
+
+#define SPI_SLAVE_PROTOCOL_DESC				\
+{							\
+	MSP_SINGLE_PHASE,				\
+	MSP_SINGLE_PHASE,				\
+	MSP_PHASE2_START_MODE_FRAME_SYNC,		\
+	MSP_PHASE2_START_MODE_FRAME_SYNC,		\
+	MSP_BTF_MS_BIT_FIRST,				\
+	MSP_BTF_MS_BIT_FIRST,				\
+	MSP_FRAME_LENGTH_1,				\
+	MSP_FRAME_LENGTH_1,				\
+	MSP_FRAME_LENGTH_1,				\
+	MSP_FRAME_LENGTH_1,				\
+	MSP_ELEM_LENGTH_8,				\
+	MSP_ELEM_LENGTH_8,				\
+	MSP_ELEM_LENGTH_8,				\
+	MSP_ELEM_LENGTH_8,				\
+	MSP_DELAY_1,					\
+	MSP_DELAY_1,					\
+	MSP_FALLING_EDGE,				\
+	MSP_FALLING_EDGE,				\
+	MSP_FRAME_SYNC_POL_ACTIVE_HIGH,			\
+	MSP_FRAME_SYNC_POL_ACTIVE_HIGH,			\
+	MSP_HWS_NO_SWAP,				\
+	MSP_HWS_NO_SWAP,				\
+	MSP_COMPRESS_MODE_LINEAR,			\
+	MSP_EXPAND_MODE_LINEAR,				\
+	MSP_SPI_CLOCK_MODE_NON_SPI,			\
+	MSP_SPI_BURST_MODE_DISABLE,			\
+	MSP_FRAME_SYNC_IGNORE,			\
+	255,						\
+	0,						\
+	256,						\
+}
+
+#define MSP_FRAME_PERIOD_IN_MONO_MODE 256
+#define MSP_FRAME_PERIOD_IN_STEREO_MODE 32
+#define MSP_FRAME_WIDTH_IN_STEREO_MODE 16
+
+/*
+ * No of registers to backup during
+ * suspend resume
+ */
+#define MAX_MSP_BACKUP_REGS 36
+
+enum enum_i2s_controller {
+	MSP_0_I2S_CONTROLLER = 0,
+	MSP_1_I2S_CONTROLLER,
+	MSP_2_I2S_CONTROLLER,
+	MSP_3_I2S_CONTROLLER,
+};
+
+/**
+ * struct msp - Main msp controller data structure per MSP.
+ * @work_mode: Mode i.e dma, polling or interrupt.
+ * @id: Controller id like MSP1 or MSP2 etc.
+ * @msp_io_error: To indicate error while transferring.
+ * @registers: MSP's register base address.
+ * @actual_data_size: Data size in which data needs to send or receive.
+ * @irq:  MSP's irq number.
+ * @i2s_cont: MSP's Controller's structure pointer created per MSP.
+ * @lock: semaphore lock acquired while configuring msp.
+ * @dma_cfg_tx: TX DMA configuration
+ * @dma_cfg_rx: RX DMA configuration
+ * @tx_pipeid: TX DMA channel
+ * @rx_pipeid: RX DMA channel
+ * @msp_state: Current state of msp.
+ * @read: Function pointer for read, u8_msp_read,u16_msp_read,u32_msp_read.
+ * @write: Function pointer for write, u8_msp_write,u16_msp_write,u32_msp_write.
+ * @transfer: Function pointer for type of transfer i.e dma,polling or interrupt
+ * @xfer_data: MSP's transfer data structure. Contains info about current xfer.
+ * @plat_init: MSP's initialization function.
+ * @plat_exit: MSP's Exit function.
+ * @notify_timer: Timer used in Polling mode to prevent hang.
+ * @polling_flag: Flag used in error handling while polling.
+ * @def_elem_len: Flag indicates whether default elem len to be used in
+ * protocol_desc or not.
+ * @reg_enabled: Flag indicates whether regulator has been enabled or not.
+ * @vape_opp_constraint: 1 if constraint is applied to have vape at 100OPP; 0 otherwise
+ * @infinite: true if an infinite transfer has been configured
+ *
+ * Main Msp private data structure to be used to store various info of a
+ * particular MSP.Longer description
+ */
+struct msp {
+	int work_mode;
+	enum enum_i2s_controller id;
+	int msp_io_error;
+	void __iomem *registers;
+	enum msp_data_size actual_data_size;
+	struct device *dev;
+	int irq;
+	struct i2s_controller *i2s_cont;
+	struct semaphore lock;
+	struct stedma40_chan_cfg *dma_cfg_rx;
+	struct stedma40_chan_cfg *dma_cfg_tx;
+	struct dma_chan *tx_pipeid;
+	struct dma_chan *rx_pipeid;
+	enum msp_state msp_state;
+	void (*read) (struct trans_data *xfer_data);
+	void (*write) (struct trans_data *xfer_data);
+	int (*transfer) (struct msp *msp, struct i2s_message *message);
+	struct trans_data xfer_data;
+	int (*plat_init) (void);
+	int (*plat_exit) (void);
+	struct timer_list notify_timer;
+	int polling_flag;
+	int def_elem_len;
+	struct clk *clk;
+	unsigned int direction;
+	int users;
+	int reg_enabled;
+	int loopback_enable;
+	u32 backup_regs[MAX_MSP_BACKUP_REGS];
+	int vape_opp_constraint;
+	bool infinite;
+};
+
+/**
+ * struct msp_i2s_platform_data - Main msp controller platform data structure.
+ * @id: Controller id like MSP1 or MSP2 etc.
+ * @msp_i2s_dma_rx: RX DMA channel config
+ * @msp_i2s_dma_tx: RX DMA channel config
+ * @msp_i2s_init: MSP's initialization function.
+ * @msp_i2s_exit: MSP's Exit function.
+ * @backup_regs: used for backup registers during suspend resume.
+ *
+ * Platform data structure passed by devices.c file.
+ */
+struct msp_i2s_platform_data {
+	enum enum_i2s_controller id;
+	struct stedma40_chan_cfg *msp_i2s_dma_rx;
+	struct stedma40_chan_cfg *msp_i2s_dma_tx;
+	int (*msp_i2s_init) (void);
+	int (*msp_i2s_exit) (void);
+};
+
+#endif
diff --git a/include/sound/ux500_ab8500.h b/include/sound/ux500_ab8500.h
new file mode 100644
index 0000000..7858bfd
--- /dev/null
+++ b/include/sound/ux500_ab8500.h
@@ -0,0 +1,36 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * Author: Jarmo K. Kuronen <jarmo.kuronen@symbio.com>
+ *         for ST-Ericsson.
+ *
+ * License terms:
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#ifndef UX500_AB8500_H
+#define UX500_AB8500_H
+
+extern struct snd_soc_ops ux500_ab8500_ops[];
+
+struct snd_soc_pcm_runtime;
+
+int ux500_ab8500_startup(struct snd_pcm_substream *substream);
+
+void ux500_ab8500_shutdown(struct snd_pcm_substream *substream);
+
+int ux500_ab8500_hw_params(struct snd_pcm_substream *substream,
+			struct snd_pcm_hw_params *params);
+
+int ux500_ab8500_soc_machine_drv_init(void);
+
+void ux500_ab8500_soc_machine_drv_cleanup(void);
+
+int ux500_ab8500_machine_codec_init(struct snd_soc_pcm_runtime *runtime);
+
+extern void ux500_ab8500_jack_report(int);
+
+#endif
diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 35e662d..10c66dc 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -45,6 +45,7 @@ source "sound/soc/s6000/Kconfig"
 source "sound/soc/sh/Kconfig"
 source "sound/soc/tegra/Kconfig"
 source "sound/soc/txx9/Kconfig"
+source "sound/soc/ux500/Kconfig"
 
 # Supported codecs
 source "sound/soc/codecs/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 9ea8ac8..c5d3966 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -22,3 +22,4 @@ obj-$(CONFIG_SND_SOC)	+= s6000/
 obj-$(CONFIG_SND_SOC)	+= sh/
 obj-$(CONFIG_SND_SOC)	+= tegra/
 obj-$(CONFIG_SND_SOC)	+= txx9/
+obj-$(CONFIG_SND_SOC)	+= ux500/
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 7c205e7..a02b2c3 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -12,6 +12,7 @@ config SND_SOC_ALL_CODECS
 	tristate "Build all ASoC CODEC drivers"
 	select SND_SOC_88PM860X if MFD_88PM860X
 	select SND_SOC_L3
+	select SND_SOC_AB8500
 	select SND_SOC_AC97_CODEC if SND_SOC_AC97_BUS
 	select SND_SOC_AD1836 if SPI_MASTER
 	select SND_SOC_AD193X if SND_SOC_I2C_AND_SPI
@@ -124,6 +125,9 @@ config SND_SOC_WM_HUBS
 	default y if SND_SOC_WM8993=y || SND_SOC_WM8994=y
 	default m if SND_SOC_WM8993=m || SND_SOC_WM8994=m
 
+config SND_SOC_AB8500
+	tristate
+
 config SND_SOC_AC97_CODEC
 	tristate
 	select SND_AC97_CODEC
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index de80781..7b3e406 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -1,4 +1,5 @@
 snd-soc-88pm860x-objs := 88pm860x-codec.o
+snd-soc-ab8500_audio-objs := ab8500_audio.o
 snd-soc-ac97-objs := ac97.o
 snd-soc-ad1836-objs := ad1836.o
 snd-soc-ad193x-objs := ad193x.o
@@ -101,6 +102,7 @@ snd-soc-max9877-objs := max9877.o
 snd-soc-tpa6130a2-objs := tpa6130a2.o
 
 obj-$(CONFIG_SND_SOC_88PM860X)	+= snd-soc-88pm860x.o
+obj-$(CONFIG_SND_SOC_AB8500)    += snd-soc-ab8500_audio.o
 obj-$(CONFIG_SND_SOC_AC97_CODEC)	+= snd-soc-ac97.o
 obj-$(CONFIG_SND_SOC_AD1836)	+= snd-soc-ad1836.o
 obj-$(CONFIG_SND_SOC_AD193X)	+= snd-soc-ad193x.o
@@ -201,3 +203,7 @@ obj-$(CONFIG_SND_SOC_WM_HUBS)	+= snd-soc-wm-hubs.o
 # Amp
 obj-$(CONFIG_SND_SOC_MAX9877)	+= snd-soc-max9877.o
 obj-$(CONFIG_SND_SOC_TPA6130A2)	+= snd-soc-tpa6130a2.o
+
+ifdef CONFIG_SND_SOC_UX500_DEBUG
+CFLAGS_ab8500_audio.o := -DDEBUG
+endif
diff --git a/sound/soc/codecs/Makefile.rej b/sound/soc/codecs/Makefile.rej
new file mode 100644
index 0000000..893304b
--- /dev/null
+++ b/sound/soc/codecs/Makefile.rej
@@ -0,0 +1,10 @@
+--- sound/soc/codecs/Makefile
++++ sound/soc/codecs/Makefile
+@@ -197,3 +199,7 @@
+ obj-$(CONFIG_SND_SOC_TPA6130A2)	+= snd-soc-tpa6130a2.o
+ obj-$(CONFIG_SND_SOC_WM2000)	+= snd-soc-wm2000.o
+ obj-$(CONFIG_SND_SOC_WM9090)	+= snd-soc-wm9090.o
++
++ifdef CONFIG_SND_SOC_UX500_DEBUG
++CFLAGS_ab8500_audio.o := -DDEBUG
++endif
diff --git a/sound/soc/codecs/ab8500_audio.c b/sound/soc/codecs/ab8500_audio.c
new file mode 100644
index 0000000..6b7b1c0
--- /dev/null
+++ b/sound/soc/codecs/ab8500_audio.c
@@ -0,0 +1,2928 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * Author: Mikko J. Lehto <mikko.lehto@symbio.com>,
+ *         Mikko Sarmanne <mikko.sarmanne@symbio.com>,
+ *         Jarmo K. Kuronen <jarmo.kuronen@symbio.com>,
+ *         Ola Lilja <ola.o.lilja@stericsson.com>
+ *         for ST-Ericsson.
+ *
+ * License terms:
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/platform_device.h>
+#include <linux/mutex.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/tlv.h>
+#include <linux/mfd/abx500/ab8500.h>
+#include <linux/mfd/abx500.h>
+#include <linux/mfd/abx500/ab5500.h>
+#include <linux/mfd/abx500/ab8500-sysctrl.h>
+#include "ab8500_audio.h"
+
+/* To convert register definition shifts to masks */
+#define BMASK(bsft)	(1 << (bsft))
+
+/* Macrocell value definitions */
+#define CLK_32K_OUT2_DISABLE			0x01
+#define INACTIVE_RESET_AUDIO			0x02
+#define ENABLE_AUDIO_CLK_TO_AUDIO_BLK		0x10
+#define ENABLE_VINTCORE12_SUPPLY		0x04
+#define GPIO27_DIR_OUTPUT			0x04
+#define GPIO29_DIR_OUTPUT			0x10
+#define GPIO31_DIR_OUTPUT			0x40
+
+/* Macrocell register definitions */
+#define AB8500_CTRL3_REG			0x0200
+#define AB8500_GPIO_DIR4_REG			0x1013
+
+/* Nr of FIR/IIR-coeff banks in ANC-block */
+#define AB8500_NR_OF_ANC_COEFF_BANKS		2
+
+/* Macros to simplify implementation of register write sequences and error handling */
+#define AB8500_SET_BIT_LOCKED(xreg, xbit, xerr, xerr_hdl) { \
+	xerr = snd_soc_update_bits_locked(ab8500_codec, xreg, REG_MASK_NONE, BMASK(xbit)); \
+	if (xerr < 0) \
+		goto xerr_hdl; }
+#define AB8500_CLEAR_BIT_LOCKED(xreg, xbit, xerr, xerr_hdl) { \
+	xerr = snd_soc_update_bits_locked(ab8500_codec, xreg, BMASK(xbit), REG_MASK_NONE); \
+	if (xerr < 0) \
+		goto xerr_hdl; }
+#define AB8500_WRITE(xreg, xvalue, xerr, xerr_hdl) { \
+	xerr = snd_soc_write(ab8500_codec, xreg, xvalue); \
+	if (xerr < 0) \
+		goto xerr_hdl; }
+
+/*
+ * AB8500 register cache & default register settings
+ */
+static const u8 ab8500_reg_cache[AB8500_CACHEREGNUM] = {
+	0x00, /* REG_POWERUP		(0x00) */
+	0x00, /* REG_AUDSWRESET		(0x01) */
+	0x00, /* REG_ADPATHENA		(0x02) */
+	0x00, /* REG_DAPATHENA		(0x03) */
+	0x00, /* REG_ANACONF1		(0x04) */
+	0x0F, /* REG_ANACONF2		(0x05) */
+	0x00, /* REG_DIGMICCONF		(0x06) */
+	0x00, /* REG_ANACONF3		(0x07) */
+	0x00, /* REG_ANACONF4		(0x08) */
+	0x00, /* REG_DAPATHCONF		(0x09) */
+	0x40, /* REG_MUTECONF		(0x0A) */
+	0x00, /* REG_SHORTCIRCONF	(0x0B) */
+	0x01, /* REG_ANACONF5		(0x0C) */
+	0x00, /* REG_ENVCPCONF		(0x0D) */
+	0x00, /* REG_SIGENVCONF		(0x0E) */
+	0x3F, /* REG_PWMGENCONF1	(0x0F) */
+	0x32, /* REG_PWMGENCONF2	(0x10) */
+	0x32, /* REG_PWMGENCONF3	(0x11) */
+	0x32, /* REG_PWMGENCONF4	(0x12) */
+	0x32, /* REG_PWMGENCONF5	(0x13) */
+	0x0F, /* REG_ANAGAIN1		(0x14) */
+	0x0F, /* REG_ANAGAIN2		(0x15) */
+	0x22, /* REG_ANAGAIN3		(0x16) */
+	0x55, /* REG_ANAGAIN4		(0x17) */
+	0x13, /* REG_DIGLINHSLGAIN	(0x18) */
+	0x13, /* REG_DIGLINHSRGAIN	(0x19) */
+	0x00, /* REG_ADFILTCONF		(0x1A) */
+	0x00, /* REG_DIGIFCONF1		(0x1B) */
+	0x02, /* REG_DIGIFCONF2		(0x1C) */
+	0x00, /* REG_DIGIFCONF3		(0x1D) */
+	0x02, /* REG_DIGIFCONF4		(0x1E) */
+	0xCC, /* REG_ADSLOTSEL1		(0xCC) */
+	0xCC, /* REG_ADSLOTSEL2		(0xCC) */
+	0xCC, /* REG_ADSLOTSEL3		(0xCC) */
+	0xCC, /* REG_ADSLOTSEL4		(0xCC) */
+	0xCC, /* REG_ADSLOTSEL5		(0xCC) */
+	0xCC, /* REG_ADSLOTSEL6		(0xCC) */
+	0xCC, /* REG_ADSLOTSEL7		(0xCC) */
+	0xCC, /* REG_ADSLOTSEL8		(0xCC) */
+	0xCC, /* REG_ADSLOTSEL9		(0xCC) */
+	0xCC, /* REG_ADSLOTSEL10	(0xCC) */
+	0xCC, /* REG_ADSLOTSEL11	(0xCC) */
+	0xCC, /* REG_ADSLOTSEL12	(0xCC) */
+	0xCC, /* REG_ADSLOTSEL13	(0xCC) */
+	0xCC, /* REG_ADSLOTSEL14	(0xCC) */
+	0xCC, /* REG_ADSLOTSEL15	(0xCC) */
+	0xCC, /* REG_ADSLOTSEL16	(0xCC) */
+	0x00, /* REG_ADSLOTHIZCTRL1	(0x2F) */
+	0x00, /* REG_ADSLOTHIZCTRL2	(0x30) */
+	0x00, /* REG_ADSLOTHIZCTRL3	(0x31) */
+	0x00, /* REG_ADSLOTHIZCTRL4	(0x32) */
+	0x08, /* REG_DASLOTCONF1	(0x33) */
+	0x08, /* REG_DASLOTCONF2	(0x34) */
+	0x08, /* REG_DASLOTCONF3	(0x35) */
+	0x08, /* REG_DASLOTCONF4	(0x36) */
+	0x08, /* REG_DASLOTCONF5	(0x37) */
+	0x08, /* REG_DASLOTCONF6	(0x38) */
+	0x08, /* REG_DASLOTCONF7	(0x39) */
+	0x08, /* REG_DASLOTCONF8	(0x3A) */
+	0x00, /* REG_CLASSDCONF1	(0x3B) */
+	0x00, /* REG_CLASSDCONF2	(0x3C) */
+	0x84, /* REG_CLASSDCONF3	(0x3D) */
+	0x00, /* REG_DMICFILTCONF	(0x3E) */
+	0xFE, /* REG_DIGMULTCONF1	(0x3F) */
+	0xC0, /* REG_DIGMULTCONF2	(0x40) */
+	0x3F, /* REG_ADDIGGAIN1		(0x41) */
+	0x3F, /* REG_ADDIGGAIN2		(0x42) */
+	0x1F, /* REG_ADDIGGAIN3		(0x43) */
+	0x1F, /* REG_ADDIGGAIN4		(0x44) */
+	0x3F, /* REG_ADDIGGAIN5		(0x45) */
+	0x3F, /* REG_ADDIGGAIN6		(0x46) */
+	0x1F, /* REG_DADIGGAIN1		(0x47) */
+	0x1F, /* REG_DADIGGAIN2		(0x48) */
+	0x3F, /* REG_DADIGGAIN3		(0x49) */
+	0x3F, /* REG_DADIGGAIN4		(0x4A) */
+	0x3F, /* REG_DADIGGAIN5		(0x4B) */
+	0x3F, /* REG_DADIGGAIN6		(0x4C) */
+	0x3F, /* REG_ADDIGLOOPGAIN1	(0x4D) */
+	0x3F, /* REG_ADDIGLOOPGAIN2	(0x4E) */
+	0x00, /* REG_HSLEARDIGGAIN	(0x4F) */
+	0x00, /* REG_HSRDIGGAIN		(0x50) */
+	0x1F, /* REG_SIDFIRGAIN1	(0x51) */
+	0x1F, /* REG_SIDFIRGAIN2	(0x52) */
+	0x00, /* REG_ANCCONF1		(0x53) */
+	0x00, /* REG_ANCCONF2		(0x54) */
+	0x00, /* REG_ANCCONF3		(0x55) */
+	0x00, /* REG_ANCCONF4		(0x56) */
+	0x00, /* REG_ANCCONF5		(0x57) */
+	0x00, /* REG_ANCCONF6		(0x58) */
+	0x00, /* REG_ANCCONF7		(0x59) */
+	0x00, /* REG_ANCCONF8		(0x5A) */
+	0x00, /* REG_ANCCONF9		(0x5B) */
+	0x00, /* REG_ANCCONF10		(0x5C) */
+	0x00, /* REG_ANCCONF11		(0x5D) - read only */
+	0x00, /* REG_ANCCONF12		(0x5E) - read only */
+	0x00, /* REG_ANCCONF13		(0x5F) - read only */
+	0x00, /* REG_ANCCONF14		(0x60) - read only */
+	0x00, /* REG_SIDFIRADR		(0x61) */
+	0x00, /* REG_SIDFIRCOEF1	(0x62) */
+	0x00, /* REG_SIDFIRCOEF2	(0x63) */
+	0x00, /* REG_SIDFIRCONF		(0x64) */
+	0x00, /* REG_AUDINTMASK1	(0x65) */
+	0x00, /* REG_AUDINTSOURCE1	(0x66) - read only */
+	0x00, /* REG_AUDINTMASK2	(0x67) */
+	0x00, /* REG_AUDINTSOURCE2	(0x68) - read only */
+	0x00, /* REG_FIFOCONF1		(0x69) */
+	0x00, /* REG_FIFOCONF2		(0x6A) */
+	0x00, /* REG_FIFOCONF3		(0x6B) */
+	0x00, /* REG_FIFOCONF4		(0x6C) */
+	0x00, /* REG_FIFOCONF5		(0x6D) */
+	0x00, /* REG_FIFOCONF6		(0x6E) */
+	0x02, /* REG_AUDREV		(0x6F) - read only */
+};
+
+static struct snd_soc_codec *ab8500_codec;
+
+/* Signed multi register array controls. */
+struct soc_smra_control {
+	unsigned int *reg;
+	const unsigned int rcount, count, invert;
+	long min, max;
+	const char **texts;
+	long *values;
+};
+
+/* ANC FIR- & IIR-coeff caches */
+static int ab8500_anc_fir_coeff_cache[REG_ANC_FIR_COEFFS];
+static int ab8500_anc_iir_coeff_cache[REG_ANC_IIR_COEFFS];
+
+/* ANC states */
+enum anc_states {
+	ANC_UNCONFIGURED = 0,
+	ANC_CONFIGURE_FIR_IIR = 1,
+	ANC_FIR_IIR_CONFIGURED = 2,
+	ANC_CONFIGURE_FIR = 3,
+	ANC_FIR_CONFIGURED = 4,
+	ANC_CONFIGURE_IIR = 5,
+	ANC_IIR_CONFIGURED = 6,
+	ANC_ERROR = 7
+};
+static int ab8500_anc_status = ANC_UNCONFIGURED;
+
+/* ANC configuration lock */
+static DEFINE_MUTEX(ab8500_anc_conf_lock);
+
+/* Reads an arbitrary register from the ab8500 chip.
+*/
+static int ab8500_codec_read_reg(struct snd_soc_codec *codec, unsigned int bank,
+		unsigned int reg)
+{
+	u8 value;
+	int status = abx500_get_register_interruptible(
+		codec->dev, bank, reg, &value);
+
+	if (status < 0) {
+		pr_err("%s: Register (%02x:%02x) read failed (%d).\n",
+			__func__, (u8)bank, (u8)reg, status);
+	} else {
+		pr_debug("Read 0x%02x from register %02x:%02x\n",
+			(u8)value, (u8)bank, (u8)reg);
+		status = value;
+	}
+
+	return status;
+}
+
+/* Writes an arbitrary register to the ab8500 chip.
+ */
+static int ab8500_codec_write_reg(struct snd_soc_codec *codec, unsigned int bank,
+		unsigned int reg, unsigned int value)
+{
+	int status = abx500_set_register_interruptible(
+		codec->dev, bank, reg, value);
+
+	if (status < 0) {
+		pr_err("%s: Register (%02x:%02x) write failed (%d).\n",
+			__func__, (u8)bank, (u8)reg, status);
+	} else {
+		pr_debug("Wrote 0x%02x into register %02x:%02x\n",
+			(u8)value, (u8)bank, (u8)reg);
+	}
+
+	return status;
+}
+
+/* Reads an audio register from the cache.
+ */
+static unsigned int ab8500_codec_read_reg_audio(struct snd_soc_codec *codec,
+		unsigned int reg)
+{
+	u8 *cache = codec->reg_cache;
+	return cache[reg];
+}
+
+/* Reads an audio register from the hardware.
+ */
+static int ab8500_codec_read_reg_audio_nocache(struct snd_soc_codec *codec,
+		unsigned int reg)
+{
+	u8 *cache = codec->reg_cache;
+	int value = ab8500_codec_read_reg(codec, AB8500_AUDIO, reg);
+
+	if (value >= 0)
+		cache[reg] = value;
+
+	return value;
+}
+
+/* Writes an audio register to the hardware and cache.
+ */
+static int ab8500_codec_write_reg_audio(struct snd_soc_codec *codec,
+		unsigned int reg, unsigned int value)
+{
+	u8 *cache = codec->reg_cache;
+	int status = ab8500_codec_write_reg(codec, AB8500_AUDIO, reg, value);
+
+	if (status >= 0)
+		cache[reg] = value;
+
+	return status;
+}
+
+/* Dumps all audio registers.
+ */
+static inline void ab8500_codec_dump_all_reg(struct snd_soc_codec *codec)
+{
+	int i;
+
+	pr_debug("%s Enter.\n", __func__);
+
+	for (i = AB8500_FIRST_REG; i <= AB8500_LAST_REG; i++)
+		ab8500_codec_read_reg_audio_nocache(codec, i);
+}
+
+/* Updates an audio register.
+ */
+static inline int ab8500_codec_update_reg_audio(struct snd_soc_codec *codec,
+		unsigned int reg, unsigned int clr, unsigned int ins)
+{
+	unsigned int new, old;
+
+	old = ab8500_codec_read_reg_audio(codec, reg);
+	new = (old & ~clr) | ins;
+	if (old == new)
+		return 0;
+
+	return ab8500_codec_write_reg_audio(codec, reg, new);
+}
+
+/* Generic soc info for signed register controls. */
+int snd_soc_info_s(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_info *uinfo)
+{
+	struct soc_smra_control *smra =
+		(struct soc_smra_control *)kcontrol->private_value;
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = smra->count;
+	uinfo->value.integer.min = smra->min;
+	uinfo->value.integer.max = smra->max;
+
+	return 0;
+}
+
+/* Generic soc get for signed multi register controls. */
+int snd_soc_get_smr(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct soc_smra_control *smra =
+		(struct soc_smra_control *)kcontrol->private_value;
+	unsigned int *reg = smra->reg;
+	unsigned int rcount = smra->rcount;
+	long min = smra->min;
+	long max = smra->max;
+	unsigned int invert = smra->invert;
+	unsigned long mask = abs(min) | abs(max);
+	long value = 0;
+	int i, rvalue;
+
+	for (i = 0; i < rcount; i++) {
+		rvalue = snd_soc_read(codec, reg[i]) & REG_MASK_ALL;
+		value |= rvalue << (8 * (rcount - i - 1));
+	}
+	value &= mask;
+	if (min < 0 && value > max)
+		value |= ~mask;
+	if (invert)
+		value = ~value;
+	ucontrol->value.integer.value[0] = value;
+
+	return 0;
+}
+
+/* Generic soc put for signed multi register controls. */
+int snd_soc_put_smr(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct soc_smra_control *smra =
+		(struct soc_smra_control *)kcontrol->private_value;
+	unsigned int *reg = smra->reg;
+	unsigned int rcount = smra->rcount;
+	long min = smra->min;
+	long max = smra->max;
+	unsigned int invert = smra->invert;
+	unsigned long mask = abs(min) | abs(max);
+	long value = ucontrol->value.integer.value[0];
+	int i, rvalue, err;
+
+	if (invert)
+		value = ~value;
+	if (value > max)
+		value = max;
+	else if (value < min)
+		value = min;
+	value &= mask;
+	for (i = 0; i < rcount; i++) {
+		rvalue = (value >> (8 * (rcount - i - 1))) & REG_MASK_ALL;
+		err = snd_soc_write(codec, reg[i], rvalue);
+		if (err < 0)
+			return 0;
+	}
+
+	return 1;
+}
+
+/* Generic soc get for signed array controls. */
+static int snd_soc_get_sa(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_smra_control *smra =
+		(struct soc_smra_control *)kcontrol->private_value;
+	long *values = smra->values;
+	unsigned int count = smra->count;
+	unsigned int idx;
+
+	for (idx = 0; idx < count; idx++)
+		ucontrol->value.integer.value[idx] = values[idx];
+
+	return 0;
+}
+
+/* Generic soc put for signed array controls. */
+static int snd_soc_put_sa(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_smra_control *smra =
+			(struct soc_smra_control *) kcontrol->private_value;
+	long *values = smra->values;
+	unsigned int count = smra->count;
+	long min = smra->min;
+	long max = smra->max;
+	unsigned int idx;
+	long value;
+
+	for (idx = 0; idx < count; idx++) {
+		value = ucontrol->value.integer.value[idx];
+		if (value > max)
+			value = max;
+		else if (value < min)
+			value = min;
+		values[idx] = value;
+	}
+
+	return 0;
+}
+
+/* Generic soc get for enum strobe controls. */
+int snd_soc_get_enum_strobe(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct soc_enum *e =
+		(struct soc_enum *)kcontrol->private_value;
+	unsigned int reg = e->reg;
+	unsigned int bit = e->shift_l;
+	unsigned int invert = e->shift_r != 0;
+	unsigned int value = snd_soc_read(codec, reg) & BMASK(bit);
+
+	if (bit != 0 && value != 0)
+		value = value >> bit;
+	ucontrol->value.enumerated.item[0] = value ^ invert;
+
+	return 0;
+}
+
+/* Generic soc put for enum strobe controls. */
+int snd_soc_put_enum_strobe(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct soc_enum *e =
+		(struct soc_enum *)kcontrol->private_value;
+	unsigned int reg = e->reg;
+	unsigned int bit = e->shift_l;
+	unsigned int invert = e->shift_r != 0;
+	unsigned int strobe = ucontrol->value.enumerated.item[0] != 0;
+	unsigned int set_mask = REG_MASK_NONE;
+	unsigned int clr_mask = REG_MASK_NONE;
+	unsigned int err;
+
+	if (strobe ^ invert)
+		set_mask = BMASK(bit);
+	else
+		clr_mask = BMASK(bit);
+	err = snd_soc_update_bits_locked(codec, reg, clr_mask, set_mask);
+	if (err < 0)
+		return err;
+	return snd_soc_update_bits_locked(codec, reg, set_mask, clr_mask);
+}
+
+static const char * const enum_ena_dis[] = {"Enabled", "Disabled"};
+static const char * const enum_dis_ena[] = {"Disabled", "Enabled"};
+
+/* Controls - Non-DAPM Non-ASoC */
+
+/* Sidetone */
+
+static int st_fir_value_control_info(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = (REG_MASK_ALL+1) * (REG_MASK_ALL+1) - 1;
+
+	return 0;
+}
+
+static int st_fir_value_control_get(struct snd_kcontrol *kcontrol,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	return 0;
+}
+
+static int st_fir_value_control_put(struct snd_kcontrol *kcontrol,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	int ret;
+	unsigned int val_msb = (int)ucontrol->value.integer.value[0] / (REG_MASK_ALL+1);
+	unsigned int val_lsb = (int)ucontrol->value.integer.value[0] -
+			val_msb * (REG_MASK_ALL+1);
+	ret = ab8500_codec_write_reg_audio(ab8500_codec, REG_SIDFIRCOEF1, val_msb);
+	ret |= ab8500_codec_write_reg_audio(ab8500_codec, REG_SIDFIRCOEF2, val_lsb);
+	if (ret < 0) {
+		pr_err("%s: ERROR: Failed to write FIR-coeffecient!\n", __func__);
+		return 0;
+	}
+	return 1;
+}
+
+static const struct snd_kcontrol_new st_fir_value_control = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Sidetone FIR Coeffecient Value",
+	.index = 0,
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info = st_fir_value_control_info,
+	.get = st_fir_value_control_get,
+	.put = st_fir_value_control_put,
+	.private_value = 1 /* ULPCLK */
+};
+
+static int st_fir_apply_control_info(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = 2;
+	if (uinfo->value.enumerated.item) {
+		uinfo->value.enumerated.item = 1;
+		strcpy(uinfo->value.enumerated.name, "Apply");
+	} else {
+		strcpy(uinfo->value.enumerated.name, "Ready");
+	}
+	return 0;
+}
+
+static int st_fir_apply_control_get(struct snd_kcontrol *kcontrol,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	int reg = ab8500_codec_read_reg_audio(ab8500_codec, REG_SIDFIRADR);
+	ucontrol->value.enumerated.item[0] = reg & BMASK(REG_SIDFIRADR_FIRSIDSET);
+
+	return 0;
+}
+
+static int st_fir_apply_control_put(struct snd_kcontrol *kcontrol,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	int ret;
+
+	if (ucontrol->value.enumerated.item[0] != 0) {
+		ret = ab8500_codec_write_reg_audio(ab8500_codec,
+						REG_SIDFIRADR,
+						BMASK(REG_SIDFIRADR_FIRSIDSET));
+		if (ret < 0) {
+			pr_err("%s: ERROR: Failed to apply FIR-coeffecients!\n", __func__);
+			return 0;
+		}
+		pr_debug("%s: FIR-coeffecients applied.\n", __func__);
+	}
+
+	ret = ab8500_codec_write_reg_audio(ab8500_codec, REG_SIDFIRADR, 0);
+	if (ret < 0)
+		pr_err("%s: ERROR: Going to ready failed!\n", __func__);
+
+	return 1;
+}
+
+static const struct snd_kcontrol_new st_fir_apply_control = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Sidetone FIR Apply Coeffecients",
+	.index = 0,
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info = st_fir_apply_control_info,
+	.get = st_fir_apply_control_get,
+	.put = st_fir_apply_control_put,
+	.private_value = 0 /* Ready */
+};
+
+/* Controls - DAPM */
+
+/* Inverted order - Ascending/Descending */
+enum control_inversion {
+	NORMAL = 0,
+	INVERT = 1
+};
+
+/* Headset */
+
+/* Headset left - Mute */
+static const struct snd_kcontrol_new dapm_hsl_mute[] = {
+	SOC_DAPM_SINGLE("Playback Switch", REG_MUTECONF, REG_MUTECONF_MUTHSL, 1, INVERT),
+};
+
+/* Headset right - Mute */
+static const struct snd_kcontrol_new dapm_hsr_mute[] = {
+	SOC_DAPM_SINGLE("Playback Switch", REG_MUTECONF, REG_MUTECONF_MUTHSR, 1, INVERT),
+};
+
+/* Earpiece */
+
+/* Earpiece - Mute */
+static const struct snd_kcontrol_new dapm_ear_mute[] = {
+	SOC_DAPM_SINGLE("Playback Switch", REG_MUTECONF, REG_MUTECONF_MUTEAR, 1, INVERT),
+};
+
+/* Earpiece source selector */
+static const char * const enum_ear_lineout_source[] = {"Headset Left", "IHF Left"};
+static SOC_ENUM_SINGLE_DECL(dapm_enum_ear_lineout_source, REG_DMICFILTCONF,
+			REG_DMICFILTCONF_DA3TOEAR, enum_ear_lineout_source);
+static const struct snd_kcontrol_new dapm_ear_lineout_source =
+	SOC_DAPM_ENUM("Earpiece or LineOut Mono Source", dapm_enum_ear_lineout_source);
+
+/* LineOut */
+
+/* LineOut source selector */
+static const char * const enum_lineout_source[] = {"Mono Path", "Stereo Path"};
+static SOC_ENUM_DOUBLE_DECL(dapm_enum_lineout_source, REG_ANACONF5,
+			REG_ANACONF5_HSLDACTOLOL, REG_ANACONF5_HSRDACTOLOR, enum_lineout_source);
+static const struct snd_kcontrol_new dapm_lineout_source[] = {
+	SOC_DAPM_ENUM("LineOut Source", dapm_enum_lineout_source),
+};
+
+/* LineOut */
+
+/* LineOut Left - Enable/Disable */
+static const struct soc_enum enum_lineout_left = SOC_ENUM_SINGLE(0, 0, 2, enum_dis_ena);
+static const struct snd_kcontrol_new dapm_lineout_left_mux =
+				SOC_DAPM_ENUM_VIRT("LineOut Left", enum_lineout_left);
+
+/* LineOut Right - Enable/Disable */
+static const struct soc_enum enum_lineout_right = SOC_ENUM_SINGLE(0, 0, 2, enum_dis_ena);
+static const struct snd_kcontrol_new dapm_lineout_right_mux =
+				SOC_DAPM_ENUM_VIRT("LineOut Right", enum_lineout_right);
+
+/* LineOut/IHF - Select */
+static const char * const enum_ihf_or_lineout_select_sel[] = {"IHF", "LineOut"};
+static const struct soc_enum enum_ihf_or_lineout_select = SOC_ENUM_SINGLE(0, 0, 2, enum_ihf_or_lineout_select_sel);
+static const struct snd_kcontrol_new dapm_ihf_or_lineout_select_mux =
+				SOC_DAPM_ENUM_VIRT("IHF or LineOut Select", enum_ihf_or_lineout_select);
+
+
+/* IHF */
+
+/* IHF - Enable/Disable */
+static const struct soc_enum enum_ihf_left = SOC_ENUM_SINGLE(0, 0, 2, enum_dis_ena);
+static const struct snd_kcontrol_new dapm_ihf_left_mux =
+				SOC_DAPM_ENUM_VIRT("IHF Left", enum_ihf_left);
+
+static const struct soc_enum enum_ihf_right = SOC_ENUM_SINGLE(0, 0, 2, enum_dis_ena);
+static const struct snd_kcontrol_new dapm_ihf_right_mux =
+				SOC_DAPM_ENUM_VIRT("IHF Right", enum_ihf_right);
+
+/* IHF left - ANC selector */
+static const char * const enum_ihfx_sel[] = {"Audio Path", "ANC"};
+static SOC_ENUM_SINGLE_DECL(dapm_enum_ihfl_sel, REG_DIGMULTCONF2,
+			REG_DIGMULTCONF2_HFLSEL, enum_ihfx_sel);
+static const struct snd_kcontrol_new dapm_ihfl_select[] = {
+	SOC_DAPM_ENUM("IHF Left Source", dapm_enum_ihfl_sel),
+};
+
+/* IHF right - ANC selector */
+static SOC_ENUM_SINGLE_DECL(dapm_enum_ihfr_sel, REG_DIGMULTCONF2,
+			REG_DIGMULTCONF2_HFRSEL, enum_ihfx_sel);
+static const struct snd_kcontrol_new dapm_ihfr_select[] = {
+	SOC_DAPM_ENUM("IHF Right Source", dapm_enum_ihfr_sel),
+};
+
+/* Mic 1 */
+
+/* Mic 1 - Mute */
+static const struct snd_kcontrol_new dapm_mic1_mute[] = {
+	SOC_DAPM_SINGLE("Capture Switch", REG_ANACONF2, REG_ANACONF2_MUTMIC1, 1, INVERT),
+};
+
+/* Mic 1 - Mic 1A or 1B selector */
+static const char * const enum_mic1ab_sel[] = {"Mic 1A", "Mic 1B"};
+static SOC_ENUM_SINGLE_DECL(dapm_enum_mic1ab_sel, REG_ANACONF3,
+			REG_ANACONF3_MIC1SEL, enum_mic1ab_sel);
+static const struct snd_kcontrol_new dapm_mic1ab_select[] = {
+	SOC_DAPM_ENUM("Mic 1A or 1B Select", dapm_enum_mic1ab_sel),
+};
+
+/* Mic 1 - AD3 - Mic 1 or DMic 3 selector */
+static const char * const enum_ad3_sel[] = {"Mic 1", "DMic 3"};
+static SOC_ENUM_SINGLE_DECL(dapm_enum_ad3_sel, REG_DIGMULTCONF1,
+			REG_DIGMULTCONF1_AD3SEL, enum_ad3_sel);
+static const struct snd_kcontrol_new dapm_ad3_select[] = {
+	SOC_DAPM_ENUM("AD 3 Select", dapm_enum_ad3_sel),
+};
+
+/* Mic 1 - AD6 - Mic 1 or DMic 6 selector */
+static const char * const enum_ad6_sel[] = {"Mic 1", "DMic 6"};
+static SOC_ENUM_SINGLE_DECL(dapm_enum_ad6_sel, REG_DIGMULTCONF1,
+			REG_DIGMULTCONF1_AD6SEL, enum_ad6_sel);
+static const struct snd_kcontrol_new dapm_ad6_select[] = {
+	SOC_DAPM_ENUM("AD 6 Select", dapm_enum_ad6_sel),
+};
+
+/* Mic 2 */
+
+/* Mic 2 - Mute */
+static const struct snd_kcontrol_new dapm_mic2_mute[] = {
+	SOC_DAPM_SINGLE("Capture Switch", REG_ANACONF2, REG_ANACONF2_MUTMIC2, 1, INVERT),
+};
+
+/* Mic 2 - AD5 - Mic 2 or DMic 5 selector */
+static const char * const enum_ad5_sel[] = {"Mic 2", "DMic 5"};
+static SOC_ENUM_SINGLE_DECL(dapm_enum_ad5_sel, REG_DIGMULTCONF1,
+			REG_DIGMULTCONF1_AD5SEL, enum_ad5_sel);
+static const struct snd_kcontrol_new dapm_ad5_select[] = {
+	SOC_DAPM_ENUM("AD 5 Select", dapm_enum_ad5_sel),
+};
+
+/* LineIn */
+
+/* LineIn left - Mute */
+static const struct snd_kcontrol_new dapm_linl_mute[] = {
+	SOC_DAPM_SINGLE("Capture Switch", REG_ANACONF2, REG_ANACONF2_MUTLINL, 1, INVERT),
+};
+
+/* LineIn left - AD1 - LineIn Left or DMic 1 selector */
+static const char * const enum_ad1_sel[] = {"LineIn Left", "DMic 1"};
+static SOC_ENUM_SINGLE_DECL(dapm_enum_ad1_sel, REG_DIGMULTCONF1,
+			REG_DIGMULTCONF1_AD1SEL, enum_ad1_sel);
+static const struct snd_kcontrol_new dapm_ad1_select[] = {
+	SOC_DAPM_ENUM("AD 1 Select", dapm_enum_ad1_sel),
+};
+
+/* LineIn right - Mute */
+static const struct snd_kcontrol_new dapm_linr_mute[] = {
+	SOC_DAPM_SINGLE("Capture Switch", REG_ANACONF2, REG_ANACONF2_MUTLINR, 1, INVERT),
+};
+
+/* LineIn right - Mic 2 or LineIn Right selector */
+static const char * const enum_mic2lr_sel[] = {"Mic 2", "LineIn Right"};
+static SOC_ENUM_SINGLE_DECL(dapm_enum_mic2lr_sel, REG_ANACONF3,
+			REG_ANACONF3_LINRSEL, enum_mic2lr_sel);
+static const struct snd_kcontrol_new dapm_mic2lr_select[] = {
+	SOC_DAPM_ENUM("Mic 2 or LINR Select", dapm_enum_mic2lr_sel),
+};
+
+/* LineIn right - AD2 - LineIn Right or DMic2 selector */
+static const char * const enum_ad2_sel[] = {"LineIn Right", "DMic 2"};
+static SOC_ENUM_SINGLE_DECL(dapm_enum_ad2_sel, REG_DIGMULTCONF1,
+			REG_DIGMULTCONF1_AD2SEL, enum_ad2_sel);
+static const struct snd_kcontrol_new dapm_ad2_select[] = {
+	SOC_DAPM_ENUM("AD 2 Select", dapm_enum_ad2_sel),
+};
+
+/* DMic */
+
+/* DMic 1 - Mute */
+static const struct snd_kcontrol_new dapm_dmic1_mute[] = {
+	SOC_DAPM_SINGLE("Capture Switch", REG_DIGMICCONF,
+			REG_DIGMICCONF_ENDMIC1, 1, NORMAL),
+};
+
+/* DMic 2 - Mute */
+static const struct snd_kcontrol_new dapm_dmic2_mute[] = {
+	SOC_DAPM_SINGLE("Capture Switch", REG_DIGMICCONF,
+			REG_DIGMICCONF_ENDMIC2, 1, NORMAL),
+};
+
+/* DMic 3 - Mute */
+static const struct snd_kcontrol_new dapm_dmic3_mute[] = {
+	SOC_DAPM_SINGLE("Capture Switch", REG_DIGMICCONF,
+			REG_DIGMICCONF_ENDMIC3, 1, NORMAL),
+};
+
+/* DMic 4 - Mute */
+static const struct snd_kcontrol_new dapm_dmic4_mute[] = {
+	SOC_DAPM_SINGLE("Capture Switch", REG_DIGMICCONF,
+			REG_DIGMICCONF_ENDMIC4, 1, NORMAL),
+};
+
+/* DMic 5 - Mute */
+static const struct snd_kcontrol_new dapm_dmic5_mute[] = {
+	SOC_DAPM_SINGLE("Capture Switch", REG_DIGMICCONF,
+			REG_DIGMICCONF_ENDMIC5, 1, NORMAL),
+};
+
+/* DMic 6 - Mute */
+static const struct snd_kcontrol_new dapm_dmic6_mute[] = {
+	SOC_DAPM_SINGLE("Capture Switch", REG_DIGMICCONF,
+			REG_DIGMICCONF_ENDMIC6, 1, NORMAL),
+};
+
+/* ANC */
+
+static const char * const enum_anc_in_sel[] = {"Mic 1 / DMic 6", "Mic 2 / DMic 5"};
+static SOC_ENUM_SINGLE_DECL(dapm_enum_anc_in_sel, REG_DMICFILTCONF,
+			REG_DMICFILTCONF_ANCINSEL, enum_anc_in_sel);
+static const struct snd_kcontrol_new dapm_anc_in_select[] = {
+	SOC_DAPM_ENUM("ANC Source", dapm_enum_anc_in_sel),
+};
+
+/* ANC - Enable/Disable */
+static SOC_ENUM_SINGLE_DECL(dapm_enum_anc_enable, REG_ANCCONF1,
+			REG_ANCCONF1_ENANC, enum_dis_ena);
+static const struct snd_kcontrol_new dapm_anc_enable[] = {
+	SOC_DAPM_ENUM("ANC", dapm_enum_anc_enable),
+};
+
+/* ANC to Earpiece - Mute */
+static const struct snd_kcontrol_new dapm_anc_ear_mute[] = {
+	SOC_DAPM_SINGLE("Playback Switch", REG_DIGMULTCONF1,
+			REG_DIGMULTCONF1_ANCSEL, 1, NORMAL),
+};
+
+/* Sidetone left */
+
+/* Sidetone left - Input selector */
+static const char * const enum_stfir1_in_sel[] = {
+	"LineIn Left", "LineIn Right", "Mic 1", "Headset Left"};
+static SOC_ENUM_SINGLE_DECL(dapm_enum_stfir1_in_sel, REG_DIGMULTCONF2,
+			REG_DIGMULTCONF2_FIRSID1SEL, enum_stfir1_in_sel);
+static const struct snd_kcontrol_new dapm_stfir1_in_select[] = {
+	SOC_DAPM_ENUM("Sidetone Left Source", dapm_enum_stfir1_in_sel),
+};
+
+/* Sidetone right path */
+
+/* Sidetone right - Input selector */
+static const char * const enum_stfir2_in_sel[] = {
+	"LineIn Right", "Mic 1", "DMic 4", "Headset Right"};
+static SOC_ENUM_SINGLE_DECL(dapm_enum_stfir2_in_sel, REG_DIGMULTCONF2,
+			REG_DIGMULTCONF2_FIRSID2SEL, enum_stfir2_in_sel);
+static const struct snd_kcontrol_new dapm_stfir2_in_select[] = {
+	SOC_DAPM_ENUM("Sidetone Right Source", dapm_enum_stfir2_in_sel),
+};
+
+/* Vibra */
+
+/* Vibra 1 - Enable/Disable */
+static const struct soc_enum enum_vibra1 = SOC_ENUM_SINGLE(0, 0, 2, enum_dis_ena);
+static const struct snd_kcontrol_new dapm_vibra1_mux =
+				SOC_DAPM_ENUM_VIRT("Vibra 1", enum_vibra1);
+
+/* Vibra 2 - Enable/Disable */
+static const struct soc_enum enum_vibra2 = SOC_ENUM_SINGLE(0, 0, 2, enum_dis_ena);
+static const struct snd_kcontrol_new dapm_vibra2_mux =
+				SOC_DAPM_ENUM_VIRT("Vibra 2", enum_vibra2);
+
+static const char * const enum_pwm2vibx[] = {"Audio Path", "PWM Generator"};
+
+static SOC_ENUM_SINGLE_DECL(dapm_enum_pwm2vib1, REG_PWMGENCONF1,
+			REG_PWMGENCONF1_PWMTOVIB1, enum_pwm2vibx);
+
+static const struct snd_kcontrol_new dapm_pwm2vib1[] = {
+	SOC_DAPM_ENUM("Vibra 1 Controller", dapm_enum_pwm2vib1),
+};
+
+static SOC_ENUM_SINGLE_DECL(dapm_enum_pwm2vib2, REG_PWMGENCONF1,
+			REG_PWMGENCONF1_PWMTOVIB2, enum_pwm2vibx);
+
+static const struct snd_kcontrol_new dapm_pwm2vib2[] = {
+	SOC_DAPM_ENUM("Vibra 2 Controller", dapm_enum_pwm2vib2),
+};
+
+static const struct snd_soc_dapm_widget ab8500_dapm_widgets[] = {
+
+	/* DA/AD */
+
+	SND_SOC_DAPM_INPUT("ADC Input"),
+	SND_SOC_DAPM_ADC("ADC", "ab8500_0c", SND_SOC_NOPM, 0, 0),
+
+	SND_SOC_DAPM_DAC("DAC", "ab8500_0p", SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_OUTPUT("DAC Output"),
+
+	SND_SOC_DAPM_AIF_IN("DA_IN1", "ab8500_0p", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("DA_IN2", "ab8500_0p", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("DA_IN3", "ab8500_0p", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("DA_IN4", "ab8500_0p", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("DA_IN5", "ab8500_0p", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("DA_IN6", "ab8500_0p", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("AD_OUT1", "ab8500_0c", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("AD_OUT2", "ab8500_0c", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("AD_OUT3", "ab8500_0c", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("AD_OUT4", "ab8500_0c", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("AD_OUT57", "ab8500_0c", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("AD_OUT68", "ab8500_0c", 0, SND_SOC_NOPM, 0, 0),
+
+	/* Headset path */
+
+	SND_SOC_DAPM_SUPPLY("Charge Pump", REG_ANACONF5, REG_ANACONF5_ENCPHS, 0, NULL, 0),
+
+	SND_SOC_DAPM_DAC("DA1 Enable", "ab8500_0p",
+			REG_DAPATHENA, REG_DAPATHENA_ENDA1, 0),
+	SND_SOC_DAPM_DAC("DA2 Enable", "ab8500_0p",
+			REG_DAPATHENA, REG_DAPATHENA_ENDA2, 0),
+
+	SND_SOC_DAPM_SWITCH("Headset Left", SND_SOC_NOPM, 0, 0, dapm_hsl_mute),
+	SND_SOC_DAPM_SWITCH("Headset Right", SND_SOC_NOPM, 0, 0, dapm_hsr_mute),
+
+	SND_SOC_DAPM_PGA("HSL Digital Gain", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("HSR Digital Gain", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	SND_SOC_DAPM_DAC("HSL DAC", "ab8500_0p",
+			REG_DAPATHCONF, REG_DAPATHCONF_ENDACHSL, 0),
+	SND_SOC_DAPM_DAC("HSR DAC", "ab8500_0p",
+			REG_DAPATHCONF, REG_DAPATHCONF_ENDACHSR, 0),
+	SND_SOC_DAPM_MIXER("HSL DAC Mute", REG_MUTECONF, REG_MUTECONF_MUTDACHSL,
+			INVERT, NULL, 0),
+	SND_SOC_DAPM_MIXER("HSR DAC Mute", REG_MUTECONF, REG_MUTECONF_MUTDACHSR,
+			INVERT, NULL, 0),
+	SND_SOC_DAPM_DAC("HSL DAC Driver", "ab8500_0p",
+			REG_ANACONF3, REG_ANACONF3_ENDRVHSL, 0),
+	SND_SOC_DAPM_DAC("HSR DAC Driver", "ab8500_0p",
+			REG_ANACONF3, REG_ANACONF3_ENDRVHSR, 0),
+
+	SND_SOC_DAPM_MIXER("HSL Mute", REG_MUTECONF, REG_MUTECONF_MUTHSL,
+			INVERT, NULL, 0),
+	SND_SOC_DAPM_MIXER("HSR Mute", REG_MUTECONF, REG_MUTECONF_MUTHSR,
+			INVERT, NULL, 0),
+	SND_SOC_DAPM_MIXER("HSL Enable", REG_ANACONF4, REG_ANACONF4_ENHSL,
+			NORMAL, NULL, 0),
+	SND_SOC_DAPM_MIXER("HSR Enable", REG_ANACONF4, REG_ANACONF4_ENHSR,
+			NORMAL, NULL, 0),
+	SND_SOC_DAPM_PGA("HSL Gain", SND_SOC_NOPM, 0,
+			0, NULL, 0),
+	SND_SOC_DAPM_PGA("HSR Gain", SND_SOC_NOPM, 0,
+			0, NULL, 0),
+
+	SND_SOC_DAPM_OUTPUT("HSL"),
+	SND_SOC_DAPM_OUTPUT("HSR"),
+
+	/* LineOut path */
+
+	SND_SOC_DAPM_MUX("LineOut Source Playback Route",
+			SND_SOC_NOPM, 0, 0, dapm_lineout_source),
+
+	SND_SOC_DAPM_MIXER("LOL Enable", REG_ANACONF5,
+			REG_ANACONF5_ENLOL, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("LOR Enable", REG_ANACONF5,
+			REG_ANACONF5_ENLOR, 0, NULL, 0),
+
+	SND_SOC_DAPM_MUX("LineOut Left",
+			SND_SOC_NOPM, 0, 0, &dapm_lineout_left_mux),
+
+	SND_SOC_DAPM_MUX("LineOut Right",
+			SND_SOC_NOPM, 0, 0, &dapm_lineout_right_mux),
+
+	/* Earpiece path */
+
+	SND_SOC_DAPM_MUX("Earpiece or LineOut Mono Source",
+			SND_SOC_NOPM, 0, 0, &dapm_ear_lineout_source),
+
+	SND_SOC_DAPM_MIXER("EAR DAC", REG_DAPATHCONF,
+			REG_DAPATHCONF_ENDACEAR, 0, NULL, 0),
+
+	SND_SOC_DAPM_SWITCH("Earpiece", SND_SOC_NOPM, 0, 0, dapm_ear_mute),
+
+	SND_SOC_DAPM_MIXER("EAR Enable", REG_ANACONF4,
+			REG_ANACONF4_ENEAR, 0, NULL, 0),
+
+	SND_SOC_DAPM_OUTPUT("EAR"),
+
+	/* Handsfree path */
+
+	SND_SOC_DAPM_MIXER("DA3 Channel Gain", REG_DAPATHENA,
+			REG_DAPATHENA_ENDA3, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("DA4 Channel Gain", REG_DAPATHENA,
+			REG_DAPATHENA_ENDA4, 0, NULL, 0),
+
+	SND_SOC_DAPM_MUX("IHF Left Source Playback Route",
+			SND_SOC_NOPM, 0, 0, dapm_ihfl_select),
+	SND_SOC_DAPM_MUX("IHF Right Source Playback Route",
+			SND_SOC_NOPM, 0, 0, dapm_ihfr_select),
+
+	SND_SOC_DAPM_MUX("IHF Left", SND_SOC_NOPM, 0, 0, &dapm_ihf_left_mux),
+	SND_SOC_DAPM_MUX("IHF Right", SND_SOC_NOPM, 0, 0, &dapm_ihf_right_mux),
+
+	SND_SOC_DAPM_MUX("IHF or LineOut Select", SND_SOC_NOPM,
+			0, 0, &dapm_ihf_or_lineout_select_mux),
+
+	SND_SOC_DAPM_MIXER("IHFL DAC", REG_DAPATHCONF,
+			REG_DAPATHCONF_ENDACHFL, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("IHFR DAC", REG_DAPATHCONF,
+			REG_DAPATHCONF_ENDACHFR, 0, NULL, 0),
+
+	SND_SOC_DAPM_MIXER("DA4 or ANC path to HfR", REG_DIGMULTCONF2,
+			REG_DIGMULTCONF2_DATOHFREN, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("DA3 or ANC path to HfL", REG_DIGMULTCONF2,
+			REG_DIGMULTCONF2_DATOHFLEN, 0, NULL, 0),
+
+	SND_SOC_DAPM_MIXER("IHFL Enable", REG_ANACONF4,
+			REG_ANACONF4_ENHFL, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("IHFR Enable", REG_ANACONF4,
+			REG_ANACONF4_ENHFR, 0, NULL, 0),
+
+	SND_SOC_DAPM_OUTPUT("IHFL"),
+	SND_SOC_DAPM_OUTPUT("IHFR"),
+
+	/* Vibrator path */
+
+	SND_SOC_DAPM_MUX("Vibra 1", SND_SOC_NOPM, 0, 0, &dapm_vibra1_mux),
+	SND_SOC_DAPM_MUX("Vibra 2", SND_SOC_NOPM, 0, 0, &dapm_vibra2_mux),
+	SND_SOC_DAPM_MIXER("DA5 Channel Gain", REG_DAPATHENA,
+			REG_DAPATHENA_ENDA5, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("DA6 Channel Gain", REG_DAPATHENA,
+			REG_DAPATHENA_ENDA6, 0, NULL, 0),
+
+	SND_SOC_DAPM_MIXER("VIB1 DAC", REG_DAPATHCONF,
+			REG_DAPATHCONF_ENDACVIB1, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("VIB2 DAC", REG_DAPATHCONF,
+			REG_DAPATHCONF_ENDACVIB2, 0, NULL, 0),
+
+	SND_SOC_DAPM_INPUT("PWMGEN1"),
+	SND_SOC_DAPM_INPUT("PWMGEN2"),
+
+	SND_SOC_DAPM_MUX("Vibra 1 Controller Playback Route",
+			SND_SOC_NOPM, 0, 0, dapm_pwm2vib1),
+	SND_SOC_DAPM_MUX("Vibra 2 Controller Playback Route",
+			SND_SOC_NOPM, 0, 0, dapm_pwm2vib2),
+
+	SND_SOC_DAPM_MIXER("VIB1 Enable", REG_ANACONF4,
+			REG_ANACONF4_ENVIB1, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("VIB2 Enable", REG_ANACONF4,
+			REG_ANACONF4_ENVIB2, 0, NULL, 0),
+
+	SND_SOC_DAPM_OUTPUT("VIB1"),
+	SND_SOC_DAPM_OUTPUT("VIB2"),
+
+	/* LineIn & Microphone 2 path */
+
+	SND_SOC_DAPM_INPUT("LINL"),
+	SND_SOC_DAPM_INPUT("LINR"),
+	SND_SOC_DAPM_INPUT("MIC2 Input"),
+
+	SND_SOC_DAPM_SWITCH("LineIn Left", SND_SOC_NOPM, 0, 0, dapm_linl_mute),
+	SND_SOC_DAPM_SWITCH("LineIn Right", SND_SOC_NOPM, 0, 0, dapm_linr_mute),
+	SND_SOC_DAPM_SWITCH("Mic 2", SND_SOC_NOPM, 0, 0, dapm_mic2_mute),
+
+	SND_SOC_DAPM_MIXER("LINL Enable", REG_ANACONF2,
+			REG_ANACONF2_ENLINL, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("LINR Enable", REG_ANACONF2,
+			REG_ANACONF2_ENLINR, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("MIC2 Enable", REG_ANACONF2,
+			REG_ANACONF2_ENMIC2, 0, NULL, 0),
+
+	SND_SOC_DAPM_MUX("Mic 2 or LINR Select Capture Route",
+			SND_SOC_NOPM, 0, 0, dapm_mic2lr_select),
+
+	SND_SOC_DAPM_MIXER("LINL ADC", REG_ANACONF3,
+			REG_ANACONF3_ENADCLINL, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("LINR ADC", REG_ANACONF3,
+			REG_ANACONF3_ENADCLINR, 0, NULL, 0),
+
+	SND_SOC_DAPM_MUX("AD 1 Select Capture Route",
+			SND_SOC_NOPM, 0, 0, dapm_ad1_select),
+	SND_SOC_DAPM_MUX("AD 2 Select Capture Route",
+			SND_SOC_NOPM, 0, 0, dapm_ad2_select),
+
+	SND_SOC_DAPM_MIXER("AD1 Channel Gain", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("AD2 Channel Gain", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	SND_SOC_DAPM_MIXER("AD12 Enable", REG_ADPATHENA,
+			REG_ADPATHENA_ENAD12, 0, NULL, 0),
+
+	/* Microphone 1 path */
+
+	SND_SOC_DAPM_INPUT("MIC1 Input"),
+
+	SND_SOC_DAPM_MUX("Mic 1A or 1B Select Capture Route",
+			SND_SOC_NOPM, 0, 0, dapm_mic1ab_select),
+
+	SND_SOC_DAPM_SWITCH("Mic 1", SND_SOC_NOPM, 0, 0, dapm_mic1_mute),
+
+	SND_SOC_DAPM_MIXER("MIC1 Enable", REG_ANACONF2,
+			REG_ANACONF2_ENMIC1, 0, NULL, 0),
+
+	SND_SOC_DAPM_MIXER("MIC1 ADC", REG_ANACONF3,
+			REG_ANACONF3_ENADCMIC, 0, NULL, 0),
+
+	SND_SOC_DAPM_MUX("AD 3 Select Capture Route",
+			SND_SOC_NOPM, 0, 0, dapm_ad3_select),
+
+	SND_SOC_DAPM_MIXER("AD3 Channel Gain", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	SND_SOC_DAPM_MIXER("AD3 Enable", REG_ADPATHENA,
+			REG_ADPATHENA_ENAD34, 0, NULL, 0),
+
+	/* HD Capture path */
+
+	SND_SOC_DAPM_MUX("AD 5 Select Capture Route",
+			SND_SOC_NOPM, 0, 0, dapm_ad5_select),
+	SND_SOC_DAPM_MUX("AD 6 Select Capture Route",
+			SND_SOC_NOPM, 0, 0, dapm_ad6_select),
+
+	SND_SOC_DAPM_MIXER("AD5 Channel Gain", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("AD6 Channel Gain", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	SND_SOC_DAPM_MIXER("AD57 Enable", REG_ADPATHENA,
+			REG_ADPATHENA_ENAD5768, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("AD68 Enable", REG_ADPATHENA,
+			REG_ADPATHENA_ENAD5768, 0, NULL, 0),
+
+	/* Digital Microphone path */
+
+	SND_SOC_DAPM_INPUT("DMIC Input"),
+
+	SND_SOC_DAPM_SWITCH("DMic 1", SND_SOC_NOPM, 0, 0, dapm_dmic1_mute),
+	SND_SOC_DAPM_SWITCH("DMic 2", SND_SOC_NOPM, 0, 0, dapm_dmic2_mute),
+	SND_SOC_DAPM_SWITCH("DMic 3", SND_SOC_NOPM, 0, 0, dapm_dmic3_mute),
+	SND_SOC_DAPM_SWITCH("DMic 4", SND_SOC_NOPM, 0, 0, dapm_dmic4_mute),
+	SND_SOC_DAPM_SWITCH("DMic 5", SND_SOC_NOPM, 0, 0, dapm_dmic5_mute),
+	SND_SOC_DAPM_SWITCH("DMic 6", SND_SOC_NOPM, 0, 0, dapm_dmic6_mute),
+
+	SND_SOC_DAPM_MIXER("AD4 Channel Gain", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	SND_SOC_DAPM_MIXER("AD4 Enable", REG_ADPATHENA,
+			REG_ADPATHENA_ENAD34, 0, NULL, 0),
+
+	/* LineIn Bypass path */
+
+	SND_SOC_DAPM_MIXER("LINL to HSL Gain", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("LINR to HSR Gain", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	/* Acoustical Noise Cancellation path */
+
+	SND_SOC_DAPM_MUX("ANC Source Playback Route",
+			SND_SOC_NOPM, 0, 0, dapm_anc_in_select),
+
+	SND_SOC_DAPM_MUX("ANC Playback Switch",
+			SND_SOC_NOPM, 0, 0, dapm_anc_enable),
+
+	SND_SOC_DAPM_SWITCH("ANC to Earpiece",
+			SND_SOC_NOPM, 0, 0, dapm_anc_ear_mute),
+
+	/* Sidetone Filter path */
+
+	SND_SOC_DAPM_MUX("Sidetone Left Source Playback Route",
+			SND_SOC_NOPM, 0, 0, dapm_stfir1_in_select),
+	SND_SOC_DAPM_MUX("Sidetone Right Source Playback Route",
+			SND_SOC_NOPM, 0, 0, dapm_stfir2_in_select),
+
+	SND_SOC_DAPM_MIXER("STFIR1 Control", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("STFIR2 Control", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	SND_SOC_DAPM_MIXER("STFIR1 Gain", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("STFIR2 Gain", SND_SOC_NOPM, 0, 0, NULL, 0),
+};
+
+/* DAPM-routes */
+
+static const struct snd_soc_dapm_route dapm_routes[] = {
+	/* AD/DA */
+	{"ADC", NULL, "ADC Input"},
+	{"DAC Output", NULL, "DAC"},
+
+	/* Powerup charge pump if DA1/2 is in use */
+	{"DA_IN1", NULL, "Charge Pump"},
+	{"DA_IN2", NULL, "Charge Pump"},
+
+	/* Headset path */
+
+	{"DA1 Enable", NULL, "DA_IN1"},
+	{"DA2 Enable", NULL, "DA_IN2"},
+
+	{"HSL Digital Gain", NULL, "DA1 Enable"},
+	{"HSR Digital Gain", NULL, "DA2 Enable"},
+
+	{"HSL DAC", NULL, "HSL Digital Gain"},
+	{"HSR DAC", NULL, "HSR Digital Gain"},
+
+	{"HSL DAC Mute", NULL, "HSL DAC"},
+	{"HSR DAC Mute", NULL, "HSR DAC"},
+
+	{"HSL DAC Driver", NULL, "HSL DAC Mute"},
+	{"HSR DAC Driver", NULL, "HSR DAC Mute"},
+
+	{"HSL Mute", NULL, "HSL DAC Driver"},
+	{"HSR Mute", NULL, "HSR DAC Driver"},
+
+	{"Headset Left", "Playback Switch", "HSL Mute"},
+	{"Headset Right", "Playback Switch", "HSR Mute"},
+
+	{"HSL Enable", NULL, "Headset Left"},
+	{"HSR Enable", NULL, "Headset Right"},
+
+	{"HSL Gain", NULL, "HSL Enable"},
+	{"HSR Gain", NULL, "HSR Enable"},
+
+	{"HSL", NULL, "HSL Gain"},
+	{"HSR", NULL, "HSR Gain"},
+
+	/* IHF or LineOut path */
+
+	{"DA3 Channel Gain", NULL, "DA_IN3"},
+	{"DA4 Channel Gain", NULL, "DA_IN4"},
+
+	{"IHF Left Source Playback Route", "Audio Path", "DA3 Channel Gain"},
+	{"IHF Right Source Playback Route", "Audio Path", "DA4 Channel Gain"},
+
+	{"DA3 or ANC path to HfL", NULL, "IHF Left Source Playback Route"},
+	{"DA4 or ANC path to HfR", NULL, "IHF Right Source Playback Route"},
+
+	/* IHF path */
+
+	{"IHF Left", "Enabled", "DA3 or ANC path to HfL"},
+	{"IHF Right", "Enabled", "DA4 or ANC path to HfR"},
+
+	{"IHFL DAC", NULL, "IHF Left"},
+	{"IHFR DAC", NULL, "IHF Right"},
+
+	{"IHFL Enable", NULL, "IHFL DAC"},
+	{"IHFR Enable", NULL, "IHFR DAC"},
+
+	{"IHF or LineOut Select", "IHF", "IHFL Enable"},
+	{"IHF or LineOut Select", "IHF", "IHFR Enable"},
+
+	/* Earpiece path */
+
+	{"Earpiece or LineOut Mono Source", "Headset Left", "HSL Digital Gain"},
+	{"Earpiece or LineOut Mono Source", "IHF Left", "DA3 or ANC path to HfL"},
+
+	{"EAR DAC", NULL, "Earpiece or LineOut Mono Source"},
+
+	{"Earpiece", "Playback Switch", "EAR DAC"},
+
+	{"EAR Enable", NULL, "Earpiece"},
+
+	{"EAR", NULL, "EAR Enable"},
+
+	/* LineOut path stereo */
+
+	{"LineOut Source Playback Route", "Stereo Path", "HSL DAC Driver"},
+	{"LineOut Source Playback Route", "Stereo Path", "HSR DAC Driver"},
+
+	/* LineOut path mono */
+
+	{"LineOut Source Playback Route", "Mono Path", "EAR DAC"},
+
+	/* LineOut path */
+
+	{"LineOut Left", "Enabled", "LineOut Source Playback Route"},
+	{"LineOut Right", "Enabled", "LineOut Source Playback Route"},
+
+	{"LOL Enable", NULL, "LineOut Left"},
+	{"LOR Enable", NULL, "LineOut Right"},
+
+	{"IHF or LineOut Select", "LineOut", "LOL Enable"},
+	{"IHF or LineOut Select", "LineOut", "LOR Enable"},
+
+	/* IHF path */
+
+	{"IHFL", NULL, "IHF or LineOut Select"},
+	{"IHFR", NULL, "IHF or LineOut Select"},
+
+	/* Vibrator path */
+
+	{"DA5 Channel Gain", NULL, "DA_IN5"},
+	{"DA6 Channel Gain", NULL, "DA_IN6"},
+
+	{"VIB1 DAC", NULL, "DA5 Channel Gain"},
+	{"VIB2 DAC", NULL, "DA6 Channel Gain"},
+
+	{"Vibra 1 Controller Playback Route", "Audio Path", "VIB1 DAC"},
+	{"Vibra 2 Controller Playback Route", "Audio Path", "VIB2 DAC"},
+	{"Vibra 1 Controller Playback Route", "PWM Generator", "PWMGEN1"},
+	{"Vibra 2 Controller Playback Route", "PWM Generator", "PWMGEN2"},
+
+	{"Vibra 1", "Enabled", "Vibra 1 Controller Playback Route"},
+	{"Vibra 2", "Enabled", "Vibra 2 Controller Playback Route"},
+
+	{"VIB1 Enable", NULL, "Vibra 1"},
+	{"VIB2 Enable", NULL, "Vibra 2"},
+
+	{"VIB1", NULL, "VIB1 Enable"},
+	{"VIB2", NULL, "VIB2 Enable"},
+
+	/* LineIn & Microphone 2 path */
+
+	{"LineIn Left", "Capture Switch", "LINL"},
+	{"LineIn Right", "Capture Switch", "LINR"},
+	{"Mic 2", "Capture Switch", "MIC2 Input"},
+
+	{"LINL Enable", NULL, "LineIn Left"},
+	{"LINR Enable", NULL, "LineIn Right"},
+	{"MIC2 Enable", NULL, "Mic 2"},
+
+	{"Mic 2 or LINR Select Capture Route", "LineIn Right", "LINR Enable"},
+	{"Mic 2 or LINR Select Capture Route", "Mic 2", "MIC2 Enable"},
+
+	{"LINL ADC", NULL, "LINL Enable"},
+	{"LINR ADC", NULL, "Mic 2 or LINR Select Capture Route"},
+
+	{"AD 1 Select Capture Route", "LineIn Left", "LINL ADC"},
+	{"AD 2 Select Capture Route", "LineIn Right", "LINR ADC"},
+
+	{"AD1 Channel Gain", NULL, "AD 1 Select Capture Route"},
+	{"AD2 Channel Gain", NULL, "AD 2 Select Capture Route"},
+
+	{"AD12 Enable", NULL, "AD1 Channel Gain"},
+	{"AD12 Enable", NULL, "AD2 Channel Gain"},
+
+	{"AD_OUT1", NULL, "AD12 Enable"},
+	{"AD_OUT2", NULL, "AD12 Enable"},
+
+	/* Microphone 1 path */
+
+	{"Mic 1A or 1B Select Capture Route", "Mic 1A", "MIC1 Input"},
+	{"Mic 1A or 1B Select Capture Route", "Mic 1B", "MIC1 Input"},
+
+	{"Mic 1", "Capture Switch", "Mic 1A or 1B Select Capture Route"},
+
+	{"MIC1 Enable", NULL, "Mic 1"},
+
+	{"MIC1 ADC", NULL, "MIC1 Enable"},
+
+	{"AD 3 Select Capture Route", "Mic 1", "MIC1 ADC"},
+
+	{"AD3 Channel Gain", NULL, "AD 3 Select Capture Route"},
+
+	{"AD3 Enable", NULL, "AD3 Channel Gain"},
+
+	{"AD_OUT3", NULL, "AD3 Enable"},
+
+	/* HD Capture path */
+
+	{"AD 5 Select Capture Route", "Mic 2", "LINR ADC"},
+	{"AD 6 Select Capture Route", "Mic 1", "MIC1 ADC"},
+
+	{"AD5 Channel Gain", NULL, "AD 5 Select Capture Route"},
+	{"AD6 Channel Gain", NULL, "AD 6 Select Capture Route"},
+
+	{"AD57 Enable", NULL, "AD5 Channel Gain"},
+	{"AD68 Enable", NULL, "AD6 Channel Gain"},
+
+	{"AD_OUT57", NULL, "AD57 Enable"},
+	{"AD_OUT68", NULL, "AD68 Enable"},
+
+	/* Digital Microphone path */
+
+	{"DMic 1", "Capture Switch", "DMIC Input"},
+	{"DMic 2", "Capture Switch", "DMIC Input"},
+	{"DMic 3", "Capture Switch", "DMIC Input"},
+	{"DMic 4", "Capture Switch", "DMIC Input"},
+	{"DMic 5", "Capture Switch", "DMIC Input"},
+	{"DMic 6", "Capture Switch", "DMIC Input"},
+
+	{"AD 1 Select Capture Route", "DMic 1", "DMic 1"},
+	{"AD 2 Select Capture Route", "DMic 2", "DMic 2"},
+	{"AD 3 Select Capture Route", "DMic 3", "DMic 3"},
+	{"AD 5 Select Capture Route", "DMic 5", "DMic 5"},
+	{"AD 6 Select Capture Route", "DMic 6", "DMic 6"},
+
+	{"AD4 Channel Gain", NULL, "DMic 4"},
+
+	{"AD4 Enable", NULL, "AD4 Channel Gain"},
+
+	{"AD_OUT4", NULL, "AD4 Enable"},
+
+	/* LineIn Bypass path */
+
+	{"LINL to HSL Gain", NULL, "LINL Enable"},
+	{"LINR to HSR Gain", NULL, "LINR Enable"},
+
+	{"HSL DAC Driver", NULL, "LINL to HSL Gain"},
+	{"HSR DAC Driver", NULL, "LINR to HSR Gain"},
+
+	/* Acoustical Noise Cancellation path */
+
+	{"ANC Source Playback Route", "Mic 2 / DMic 5", "AD5 Channel Gain"},
+	{"ANC Source Playback Route", "Mic 1 / DMic 6", "AD6 Channel Gain"},
+
+	{"ANC Playback Switch", "Enabled", "ANC Source Playback Route"},
+
+	{"IHF Left Source Playback Route", "ANC", "ANC Playback Switch"},
+	{"IHF Right Source Playback Route", "ANC", "ANC Playback Switch"},
+	{"ANC to Earpiece", "Playback Switch", "ANC Playback Switch"},
+
+	{"HSL Digital Gain", NULL, "ANC to Earpiece"},
+
+	/* Sidetone Filter path */
+
+	{"Sidetone Left Source Playback Route", "LineIn Left", "AD12 Enable"},
+	{"Sidetone Left Source Playback Route", "LineIn Right", "AD12 Enable"},
+	{"Sidetone Left Source Playback Route", "Mic 1", "AD3 Enable"},
+	{"Sidetone Left Source Playback Route", "Headset Left", "DA_IN1"},
+	{"Sidetone Right Source Playback Route", "LineIn Right", "AD12 Enable"},
+	{"Sidetone Right Source Playback Route", "Mic 1", "AD3 Enable"},
+	{"Sidetone Right Source Playback Route", "DMic 4", "AD4 Enable"},
+	{"Sidetone Right Source Playback Route", "Headset Right", "DA_IN2"},
+
+	{"STFIR1 Control", NULL, "Sidetone Left Source Playback Route"},
+	{"STFIR2 Control", NULL, "Sidetone Right Source Playback Route"},
+
+	{"STFIR1 Gain", NULL, "STFIR1 Control"},
+	{"STFIR2 Gain", NULL, "STFIR2 Control"},
+
+	{"DA1 Enable", NULL, "STFIR1 Gain"},
+	{"DA2 Enable", NULL, "STFIR2 Gain"},
+};
+
+/* Controls - Non-DAPM ASoC */
+
+/* from -31 to 31 dB in 1 dB steps (mute instead of -32 dB) */
+static DECLARE_TLV_DB_SCALE(adx_dig_gain_tlv, -3200, 100, 1);
+
+/* from -62 to 0 dB in 1 dB steps (mute instead of -63 dB) */
+static DECLARE_TLV_DB_SCALE(dax_dig_gain_tlv, -6300, 100, 1);
+
+/* from 0 to 8 dB in 1 dB steps (mute instead of -1 dB) */
+static DECLARE_TLV_DB_SCALE(hs_ear_dig_gain_tlv, -100, 100, 1);
+
+/* from -30 to 0 dB in 1 dB steps (mute instead of -31 dB) */
+static DECLARE_TLV_DB_SCALE(stfir_dig_gain_tlv, -3100, 100, 1);
+
+/* from -32 to -20 dB in 4 dB steps / from -18 to 2 dB in 2 dB steps */
+static const unsigned int hs_gain_tlv[] = {
+	TLV_DB_RANGE_HEAD(2),
+	0, 3, TLV_DB_SCALE_ITEM(-3200, 400, 0),
+	4, 15, TLV_DB_SCALE_ITEM(-1800, 200, 0),
+};
+
+/* from 0 to 31 dB in 1 dB steps */
+static DECLARE_TLV_DB_SCALE(mic_gain_tlv, 0, 100, 0);
+
+/* from -10 to 20 dB in 2 dB steps */
+static DECLARE_TLV_DB_SCALE(lin_gain_tlv, -1000, 200, 0);
+
+/* from -36 to 0 dB in 2 dB steps (mute instead of -38 dB) */
+static DECLARE_TLV_DB_SCALE(lin2hs_gain_tlv, -3800, 200, 1);
+
+static SOC_ENUM_SINGLE_DECL(soc_enum_hshpen,
+	REG_ANACONF1, REG_ANACONF1_HSHPEN, enum_dis_ena);
+static SOC_ENUM_SINGLE_DECL(soc_enum_hslowpow,
+	REG_ANACONF1, REG_ANACONF1_HSLOWPOW, enum_dis_ena);
+static SOC_ENUM_SINGLE_DECL(soc_enum_daclowpow1,
+	REG_ANACONF1, REG_ANACONF1_DACLOWPOW1, enum_dis_ena);
+static SOC_ENUM_SINGLE_DECL(soc_enum_daclowpow0,
+	REG_ANACONF1, REG_ANACONF1_DACLOWPOW0, enum_dis_ena);
+static SOC_ENUM_SINGLE_DECL(soc_enum_eardaclowpow,
+	REG_ANACONF1, REG_ANACONF1_EARDACLOWPOW, enum_dis_ena);
+static SOC_ENUM_SINGLE_DECL(soc_enum_eardrvlowpow,
+	REG_ANACONF1, REG_ANACONF1_EARDRVLOWPOW, enum_dis_ena);
+
+static const char * const enum_earselcm[] = {"0.95V", "1.10V", "1.27V", "1.58V"};
+static SOC_ENUM_SINGLE_DECL(soc_enum_earselcm,
+	REG_ANACONF1, REG_ANACONF1_EARSELCM, enum_earselcm);
+
+static const char * const enum_hsfadspeed[] = {"2ms", "0.5ms", "10.6ms", "5ms"};
+static SOC_ENUM_SINGLE_DECL(soc_enum_hsfadspeed,
+	REG_DIGMICCONF, REG_DIGMICCONF_HSFADSPEED, enum_hsfadspeed);
+
+static const char * const enum_envdetthre[] = {
+	"250mV", "300mV", "350mV", "400mV",
+	"450mV", "500mV", "550mV", "600mV",
+	"650mV", "700mV", "750mV", "800mV",
+	"850mV", "900mV", "950mV", "1.00V" };
+static SOC_ENUM_SINGLE_DECL(soc_enum_envdetcpen,
+	REG_SIGENVCONF, REG_SIGENVCONF_ENVDETCPEN, enum_dis_ena);
+static SOC_ENUM_SINGLE_DECL(soc_enum_envdeththre,
+	REG_ENVCPCONF, REG_ENVCPCONF_ENVDETHTHRE, enum_envdetthre);
+static SOC_ENUM_SINGLE_DECL(soc_enum_envdetlthre,
+	REG_ENVCPCONF, REG_ENVCPCONF_ENVDETLTHRE, enum_envdetthre);
+
+static const char * const enum_envdettime[] = {
+	"26.6us", "53.2us", "106us",  "213us",
+	"426us",  "851us",  "1.70ms", "3.40ms",
+	"6.81ms", "13.6ms", "27.2ms", "54.5ms",
+	"109ms",  "218ms",  "436ms",  "872ms" };
+static SOC_ENUM_SINGLE_DECL(soc_enum_envdettime,
+	REG_SIGENVCONF, REG_SIGENVCONF_ENVDETTIME, enum_envdettime);
+
+static const char * const enum_ensemicx[] = {"Differential", "Single Ended"};
+static SOC_ENUM_SINGLE_DECL(soc_enum_ensemic1,
+	REG_ANAGAIN1, REG_ANAGAINX_ENSEMICX, enum_ensemicx);
+static SOC_ENUM_SINGLE_DECL(soc_enum_ensemic2,
+	REG_ANAGAIN2, REG_ANAGAINX_ENSEMICX, enum_ensemicx);
+static SOC_ENUM_SINGLE_DECL(soc_enum_lowpowmic1,
+	REG_ANAGAIN1, REG_ANAGAINX_LOWPOWMICX, enum_dis_ena);
+static SOC_ENUM_SINGLE_DECL(soc_enum_lowpowmic2,
+	REG_ANAGAIN2, REG_ANAGAINX_LOWPOWMICX, enum_dis_ena);
+
+static SOC_ENUM_DOUBLE_DECL(soc_enum_ad12nh, REG_ADFILTCONF,
+	REG_ADFILTCONF_AD1NH, REG_ADFILTCONF_AD2NH, enum_ena_dis);
+static SOC_ENUM_DOUBLE_DECL(soc_enum_ad34nh, REG_ADFILTCONF,
+	REG_ADFILTCONF_AD3NH, REG_ADFILTCONF_AD4NH, enum_ena_dis);
+
+static const char * const enum_av_mode[] = {"Audio", "Voice"};
+static SOC_ENUM_DOUBLE_DECL(soc_enum_ad12voice, REG_ADFILTCONF,
+	REG_ADFILTCONF_AD1VOICE, REG_ADFILTCONF_AD2VOICE, enum_av_mode);
+static SOC_ENUM_DOUBLE_DECL(soc_enum_ad34voice, REG_ADFILTCONF,
+	REG_ADFILTCONF_AD3VOICE, REG_ADFILTCONF_AD4VOICE, enum_av_mode);
+
+static SOC_ENUM_SINGLE_DECL(soc_enum_da12voice,
+	REG_DASLOTCONF1, REG_DASLOTCONF1_DA12VOICE, enum_av_mode);
+static SOC_ENUM_SINGLE_DECL(soc_enum_da34voice,
+	REG_DASLOTCONF3, REG_DASLOTCONF3_DA34VOICE, enum_av_mode);
+static SOC_ENUM_SINGLE_DECL(soc_enum_da56voice,
+	REG_DASLOTCONF5, REG_DASLOTCONF5_DA56VOICE, enum_av_mode);
+
+static SOC_ENUM_SINGLE_DECL(soc_enum_swapda12_34,
+	REG_DASLOTCONF1, REG_DASLOTCONF1_SWAPDA12_34, enum_dis_ena);
+
+static SOC_ENUM_DOUBLE_DECL(soc_enum_vib12swap, REG_CLASSDCONF1,
+	REG_CLASSDCONF1_VIB1SWAPEN, REG_CLASSDCONF1_VIB2SWAPEN, enum_dis_ena);
+static SOC_ENUM_DOUBLE_DECL(soc_enum_hflrswap, REG_CLASSDCONF1,
+	REG_CLASSDCONF1_HFLSWAPEN, REG_CLASSDCONF1_HFRSWAPEN, enum_dis_ena);
+
+static SOC_ENUM_DOUBLE_DECL(soc_enum_fir01byp, REG_CLASSDCONF2,
+	REG_CLASSDCONF2_FIRBYP0, REG_CLASSDCONF2_FIRBYP1, enum_dis_ena);
+static SOC_ENUM_DOUBLE_DECL(soc_enum_fir23byp, REG_CLASSDCONF2,
+	REG_CLASSDCONF2_FIRBYP2, REG_CLASSDCONF2_FIRBYP3, enum_dis_ena);
+static SOC_ENUM_DOUBLE_DECL(soc_enum_highvol01, REG_CLASSDCONF2,
+	REG_CLASSDCONF2_HIGHVOLEN0, REG_CLASSDCONF2_HIGHVOLEN1, enum_dis_ena);
+static SOC_ENUM_DOUBLE_DECL(soc_enum_highvol23, REG_CLASSDCONF2,
+	REG_CLASSDCONF2_HIGHVOLEN2, REG_CLASSDCONF2_HIGHVOLEN3, enum_dis_ena);
+
+static const char * const enum_sinc53[] = {"Sinc 5", "Sinc 3"};
+static SOC_ENUM_DOUBLE_DECL(soc_enum_dmic12sinc, REG_DMICFILTCONF,
+	REG_DMICFILTCONF_DMIC1SINC3, REG_DMICFILTCONF_DMIC2SINC3, enum_sinc53);
+static SOC_ENUM_DOUBLE_DECL(soc_enum_dmic34sinc, REG_DMICFILTCONF,
+	REG_DMICFILTCONF_DMIC3SINC3, REG_DMICFILTCONF_DMIC4SINC3, enum_sinc53);
+static SOC_ENUM_DOUBLE_DECL(soc_enum_dmic56sinc, REG_DMICFILTCONF,
+	REG_DMICFILTCONF_DMIC5SINC3, REG_DMICFILTCONF_DMIC6SINC3, enum_sinc53);
+
+static const char * const enum_da2hslr[] = {"Sidetone", "Audio Path"};
+static SOC_ENUM_DOUBLE_DECL(soc_enum_da2hslr, REG_DIGMULTCONF1,
+	REG_DIGMULTCONF1_DATOHSLEN, REG_DIGMULTCONF1_DATOHSREN,	enum_da2hslr);
+
+static const char * const enum_sinc31[] = {"Sinc 3", "Sinc 1"};
+static SOC_ENUM_SINGLE_DECL(soc_enum_hsesinc,
+		REG_HSLEARDIGGAIN, REG_HSLEARDIGGAIN_HSSINC1, enum_sinc31);
+
+static const char * const enum_fadespeed[] = {"1ms", "4ms", "8ms", "16ms"};
+static SOC_ENUM_SINGLE_DECL(soc_enum_fadespeed,
+	REG_HSRDIGGAIN, REG_HSRDIGGAIN_FADESPEED, enum_fadespeed);
+
+/* Digital interface - Clocks */
+static SOC_ENUM_SINGLE_DECL(soc_enum_mastgen,
+	REG_DIGIFCONF1, REG_DIGIFCONF1_ENMASTGEN, enum_dis_ena);
+static SOC_ENUM_SINGLE_DECL(soc_enum_fsbitclk0,
+	REG_DIGIFCONF1, REG_DIGIFCONF1_ENFSBITCLK0, enum_dis_ena);
+static SOC_ENUM_SINGLE_DECL(soc_enum_fsbitclk1,
+	REG_DIGIFCONF1, REG_DIGIFCONF1_ENFSBITCLK1, enum_dis_ena);
+
+/* Digital interface - DA from slot mapping */
+static const char * const enum_da_from_slot_map[] = {"SLOT0",
+					"SLOT1",
+					"SLOT2",
+					"SLOT3",
+					"SLOT4",
+					"SLOT5",
+					"SLOT6",
+					"SLOT7",
+					"SLOT8",
+					"SLOT9",
+					"SLOT10",
+					"SLOT11",
+					"SLOT12",
+					"SLOT13",
+					"SLOT14",
+					"SLOT15",
+					"SLOT16",
+					"SLOT17",
+					"SLOT18",
+					"SLOT19",
+					"SLOT20",
+					"SLOT21",
+					"SLOT22",
+					"SLOT23",
+					"SLOT24",
+					"SLOT25",
+					"SLOT26",
+					"SLOT27",
+					"SLOT28",
+					"SLOT29",
+					"SLOT30",
+					"SLOT31"};
+static SOC_ENUM_SINGLE_DECL(soc_enum_da1slotmap,
+	REG_DASLOTCONF1, REG_DASLOTCONFX_SLTODAX_SHIFT, enum_da_from_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_da2slotmap,
+	REG_DASLOTCONF2, REG_DASLOTCONFX_SLTODAX_SHIFT, enum_da_from_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_da3slotmap,
+	REG_DASLOTCONF3, REG_DASLOTCONFX_SLTODAX_SHIFT, enum_da_from_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_da4slotmap,
+	REG_DASLOTCONF4, REG_DASLOTCONFX_SLTODAX_SHIFT, enum_da_from_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_da5slotmap,
+	REG_DASLOTCONF5, REG_DASLOTCONFX_SLTODAX_SHIFT, enum_da_from_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_da6slotmap,
+	REG_DASLOTCONF6, REG_DASLOTCONFX_SLTODAX_SHIFT, enum_da_from_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_da7slotmap,
+	REG_DASLOTCONF7, REG_DASLOTCONFX_SLTODAX_SHIFT, enum_da_from_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_da8slotmap,
+	REG_DASLOTCONF8, REG_DASLOTCONFX_SLTODAX_SHIFT, enum_da_from_slot_map);
+
+/* Digital interface - AD to slot mapping */
+static const char * const enum_ad_to_slot_map[] = {"AD_OUT1",
+					"AD_OUT2",
+					"AD_OUT3",
+					"AD_OUT4",
+					"AD_OUT5",
+					"AD_OUT6",
+					"AD_OUT7",
+					"AD_OUT8",
+					"zeroes",
+					"tristate"};
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot0map,
+	REG_ADSLOTSEL1, REG_ADSLOTSELX_EVEN_SHIFT, enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot1map,
+	REG_ADSLOTSEL1, REG_ADSLOTSELX_ODD_SHIFT, enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot2map,
+	REG_ADSLOTSEL2, REG_ADSLOTSELX_EVEN_SHIFT, enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot3map,
+	REG_ADSLOTSEL2, REG_ADSLOTSELX_ODD_SHIFT, enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot4map,
+	REG_ADSLOTSEL3, REG_ADSLOTSELX_EVEN_SHIFT, enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot5map,
+	REG_ADSLOTSEL3, REG_ADSLOTSELX_ODD_SHIFT, enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot6map,
+	REG_ADSLOTSEL4, REG_ADSLOTSELX_EVEN_SHIFT, enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot7map,
+	REG_ADSLOTSEL4, REG_ADSLOTSELX_ODD_SHIFT, enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot8map,
+	REG_ADSLOTSEL5, REG_ADSLOTSELX_EVEN_SHIFT, enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot9map,
+	REG_ADSLOTSEL5, REG_ADSLOTSELX_ODD_SHIFT, enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot10map,
+	REG_ADSLOTSEL6, REG_ADSLOTSELX_EVEN_SHIFT, enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot11map,
+	REG_ADSLOTSEL6, REG_ADSLOTSELX_ODD_SHIFT, enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot12map,
+	REG_ADSLOTSEL7, REG_ADSLOTSELX_EVEN_SHIFT, enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot13map,
+	REG_ADSLOTSEL7, REG_ADSLOTSELX_ODD_SHIFT, enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot14map,
+	REG_ADSLOTSEL8, REG_ADSLOTSELX_EVEN_SHIFT, enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot15map,
+	REG_ADSLOTSEL8, REG_ADSLOTSELX_ODD_SHIFT, enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot16map,
+	REG_ADSLOTSEL9, REG_ADSLOTSELX_EVEN_SHIFT, enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot17map,
+	REG_ADSLOTSEL9, REG_ADSLOTSELX_ODD_SHIFT, enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot18map,
+	REG_ADSLOTSEL10, REG_ADSLOTSELX_EVEN_SHIFT, enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot19map,
+	REG_ADSLOTSEL10, REG_ADSLOTSELX_ODD_SHIFT, enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot20map,
+	REG_ADSLOTSEL11, REG_ADSLOTSELX_EVEN_SHIFT, enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot21map,
+	REG_ADSLOTSEL11, REG_ADSLOTSELX_ODD_SHIFT, enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot22map,
+	REG_ADSLOTSEL12, REG_ADSLOTSELX_EVEN_SHIFT, enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot23map,
+	REG_ADSLOTSEL12, REG_ADSLOTSELX_ODD_SHIFT, enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot24map,
+	REG_ADSLOTSEL13, REG_ADSLOTSELX_EVEN_SHIFT, enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot25map,
+	REG_ADSLOTSEL13, REG_ADSLOTSELX_ODD_SHIFT, enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot26map,
+	REG_ADSLOTSEL14, REG_ADSLOTSELX_EVEN_SHIFT, enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot27map,
+	REG_ADSLOTSEL14, REG_ADSLOTSELX_ODD_SHIFT, enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot28map,
+	REG_ADSLOTSEL15, REG_ADSLOTSELX_EVEN_SHIFT, enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot29map,
+	REG_ADSLOTSEL15, REG_ADSLOTSELX_ODD_SHIFT, enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot30map,
+	REG_ADSLOTSEL16, REG_ADSLOTSELX_EVEN_SHIFT, enum_ad_to_slot_map);
+static SOC_ENUM_SINGLE_DECL(soc_enum_adslot31map,
+	REG_ADSLOTSEL16, REG_ADSLOTSELX_ODD_SHIFT, enum_ad_to_slot_map);
+
+/* Digital interface - Digital loopback */
+static SOC_ENUM_SINGLE_DECL(soc_enum_ad1loop,
+	REG_DASLOTCONF1, REG_DASLOTCONF1_DAI7TOADO1, enum_dis_ena);
+static SOC_ENUM_SINGLE_DECL(soc_enum_ad2loop,
+	REG_DASLOTCONF2, REG_DASLOTCONF2_DAI8TOADO2, enum_dis_ena);
+static SOC_ENUM_SINGLE_DECL(soc_enum_ad3loop,
+	REG_DASLOTCONF3, REG_DASLOTCONF3_DAI7TOADO3, enum_dis_ena);
+static SOC_ENUM_SINGLE_DECL(soc_enum_ad4loop,
+	REG_DASLOTCONF4, REG_DASLOTCONF4_DAI8TOADO4, enum_dis_ena);
+static SOC_ENUM_SINGLE_DECL(soc_enum_ad5loop,
+	REG_DASLOTCONF5, REG_DASLOTCONF5_DAI7TOADO5, enum_dis_ena);
+static SOC_ENUM_SINGLE_DECL(soc_enum_ad6loop,
+	REG_DASLOTCONF6, REG_DASLOTCONF6_DAI8TOADO6, enum_dis_ena);
+static SOC_ENUM_SINGLE_DECL(soc_enum_ad7loop,
+	REG_DASLOTCONF7, REG_DASLOTCONF7_DAI8TOADO7, enum_dis_ena);
+static SOC_ENUM_SINGLE_DECL(soc_enum_ad8loop,
+	REG_DASLOTCONF8, REG_DASLOTCONF8_DAI7TOADO8, enum_dis_ena);
+
+/* Digital interface - Burst mode */
+static SOC_ENUM_SINGLE_DECL(soc_enum_if0fifoen,
+	REG_DIGIFCONF3, REG_DIGIFCONF3_IF0BFIFOEN, enum_dis_ena);
+static const char * const enum_mask[] = {"Unmasked", "Masked"};
+static SOC_ENUM_SINGLE_DECL(soc_enum_bfifomask,
+	REG_FIFOCONF1, REG_FIFOCONF1_BFIFOMASK, enum_mask);
+static const char * const enum_bitclk0[] = {"19_2_MHz", "38_4_MHz"};
+static SOC_ENUM_SINGLE_DECL(soc_enum_bfifo19m2,
+	REG_FIFOCONF1, REG_FIFOCONF1_BFIFO19M2, enum_bitclk0);
+static const char * const enum_slavemaster[] = {"Slave", "Master"};
+static SOC_ENUM_SINGLE_DECL(soc_enum_bfifomast,
+	REG_FIFOCONF3, REG_FIFOCONF3_BFIFOMAST_SHIFT, enum_slavemaster);
+static SOC_ENUM_SINGLE_DECL(soc_enum_bfifoint,
+	REG_FIFOCONF3, REG_FIFOCONF3_BFIFORUN_SHIFT, enum_dis_ena);
+
+/* TODO: move to DAPM */
+static SOC_ENUM_SINGLE_DECL(soc_enum_enfirsids,
+	REG_SIDFIRCONF, REG_SIDFIRCONF_ENFIRSIDS, enum_dis_ena);
+static SOC_ENUM_SINGLE_DECL(soc_enum_parlhf,
+	REG_CLASSDCONF1, REG_CLASSDCONF1_PARLHF, enum_dis_ena);
+static SOC_ENUM_SINGLE_DECL(soc_enum_parlvib,
+	REG_CLASSDCONF1, REG_CLASSDCONF1_PARLVIB, enum_dis_ena);
+
+static struct snd_kcontrol_new ab8500_snd_controls[] = {
+	SOC_ENUM("Headset High Pass Playback Switch", soc_enum_hshpen),
+	SOC_ENUM("Headset Low Power Playback Switch", soc_enum_hslowpow),
+	SOC_ENUM("Headset DAC Low Power Playback Switch", soc_enum_daclowpow1),
+	SOC_ENUM("Headset DAC Drv Low Power Playback Switch",
+		soc_enum_daclowpow0),
+	SOC_ENUM("Earpiece DAC Low Power Playback Switch",
+		soc_enum_eardaclowpow),
+	SOC_ENUM("Earpiece DAC Drv Low Power Playback Switch",
+		soc_enum_eardrvlowpow),
+	SOC_ENUM("Earpiece Common Mode Playback Switch", soc_enum_earselcm),
+
+	SOC_ENUM("Headset Fade Speed Playback Switch", soc_enum_hsfadspeed),
+
+	SOC_ENUM("Charge Pump High Threshold For Low Voltage",
+		soc_enum_envdeththre),
+	SOC_ENUM("Charge Pump Low Threshold For Low Voltage",
+		soc_enum_envdetlthre),
+	SOC_ENUM("Charge Pump Envelope Detection", soc_enum_envdetcpen),
+	SOC_ENUM("Charge Pump Envelope Detection Decay Time",
+		soc_enum_envdettime),
+
+	SOC_ENUM("Mic 1 Type Capture Switch", soc_enum_ensemic1),
+	SOC_ENUM("Mic 2 Type Capture Switch", soc_enum_ensemic2),
+	SOC_ENUM("Mic 1 Low Power Capture Switch", soc_enum_lowpowmic1),
+	SOC_ENUM("Mic 2 Low Power Capture Switch", soc_enum_lowpowmic2),
+
+	SOC_ENUM("LineIn High Pass Capture Switch", soc_enum_ad12nh),
+	SOC_ENUM("Mic High Pass Capture Switch", soc_enum_ad34nh),
+	SOC_ENUM("LineIn Mode Capture Switch", soc_enum_ad12voice),
+	SOC_ENUM("Mic Mode Capture Switch", soc_enum_ad34voice),
+
+	SOC_ENUM("Headset Mode Playback Switch", soc_enum_da12voice),
+	SOC_ENUM("IHF Mode Playback Switch", soc_enum_da34voice),
+	SOC_ENUM("Vibra Mode Playback Switch", soc_enum_da56voice),
+
+	SOC_ENUM("IHF and Headset Swap Playback Switch", soc_enum_swapda12_34),
+
+	SOC_ENUM("IHF Low EMI Mode Playback Switch", soc_enum_hflrswap),
+	SOC_ENUM("Vibra Low EMI Mode Playback Switch", soc_enum_vib12swap),
+
+	SOC_ENUM("IHF FIR Bypass Playback Switch", soc_enum_fir01byp),
+	SOC_ENUM("Vibra FIR Bypass Playback Switch", soc_enum_fir23byp),
+
+	/* TODO: Cannot be changed on the fly with digital channel enabled. */
+	SOC_ENUM("IHF High Volume Playback Switch", soc_enum_highvol01),
+	SOC_ENUM("Vibra High Volume Playback Switch", soc_enum_highvol23),
+
+	SOC_SINGLE("ClassD High Pass Gain Playback Volume",
+		REG_CLASSDCONF3, REG_CLASSDCONF3_DITHHPGAIN,
+		REG_CLASSDCONF3_DITHHPGAIN_MAX, NORMAL),
+	SOC_SINGLE("ClassD White Gain Playback Volume",
+		REG_CLASSDCONF3, REG_CLASSDCONF3_DITHWGAIN,
+		REG_CLASSDCONF3_DITHWGAIN_MAX, NORMAL),
+
+	SOC_ENUM("LineIn Filter Capture Switch", soc_enum_dmic12sinc),
+	SOC_ENUM("Mic Filter Capture Switch", soc_enum_dmic34sinc),
+	SOC_ENUM("HD Mic Filter Capture Switch", soc_enum_dmic56sinc),
+
+	SOC_ENUM("Headset Source Playback Route", soc_enum_da2hslr),
+
+	/* TODO: Cannot be changed on the fly with digital channel enabled. */
+	SOC_ENUM("Headset Filter Playback Switch", soc_enum_hsesinc),
+
+	SOC_ENUM("Digital Gain Fade Speed Switch", soc_enum_fadespeed),
+
+	SOC_DOUBLE_R("Vibra PWM Duty Cycle N Playback Volume",
+		REG_PWMGENCONF3, REG_PWMGENCONF5,
+		REG_PWMGENCONFX_PWMVIBXDUTCYC,
+		REG_PWMGENCONFX_PWMVIBXDUTCYC_MAX, NORMAL),
+	SOC_DOUBLE_R("Vibra PWM Duty Cycle P Playback Volume",
+		REG_PWMGENCONF2, REG_PWMGENCONF4,
+		REG_PWMGENCONFX_PWMVIBXDUTCYC,
+		REG_PWMGENCONFX_PWMVIBXDUTCYC_MAX, NORMAL),
+
+	/* TODO: move to DAPM */
+	SOC_ENUM("Sidetone Playback Switch", soc_enum_enfirsids),
+	SOC_ENUM("IHF L and R Bridge Playback Route", soc_enum_parlhf),
+	SOC_ENUM("Vibra 1 and 2 Bridge Playback Route", soc_enum_parlvib),
+
+	/* Digital gains for AD side */
+
+	SOC_DOUBLE_R_TLV("LineIn Master Gain Capture Volume",
+		REG_ADDIGGAIN1, REG_ADDIGGAIN2,
+		0, REG_ADDIGGAINX_ADXGAIN_MAX, INVERT, adx_dig_gain_tlv),
+	SOC_DOUBLE_R_TLV("Mic Master Gain Capture Volume",
+		REG_ADDIGGAIN3, REG_ADDIGGAIN4,
+		0, REG_ADDIGGAINX_ADXGAIN_MAX, INVERT, adx_dig_gain_tlv),
+	SOC_DOUBLE_R_TLV("HD Mic Master Gain Capture Volume",
+		REG_ADDIGGAIN5, REG_ADDIGGAIN6,
+		0, REG_ADDIGGAINX_ADXGAIN_MAX, INVERT, adx_dig_gain_tlv),
+
+	/* Digital gains for DA side */
+
+	SOC_DOUBLE_R_TLV("Headset Master Gain Playback Volume",
+		REG_DADIGGAIN1, REG_DADIGGAIN2,
+		0, REG_DADIGGAINX_DAXGAIN_MAX, INVERT, dax_dig_gain_tlv),
+	SOC_DOUBLE_R_TLV("IHF Master Gain Playback Volume",
+		REG_DADIGGAIN3, REG_DADIGGAIN4,
+		0, REG_DADIGGAINX_DAXGAIN_MAX, INVERT, dax_dig_gain_tlv),
+	SOC_DOUBLE_R_TLV("Vibra Master Gain Playback Volume",
+		REG_DADIGGAIN5, REG_DADIGGAIN6,
+		0, REG_DADIGGAINX_DAXGAIN_MAX, INVERT, dax_dig_gain_tlv),
+	SOC_DOUBLE_R_TLV("Analog Loopback Gain Playback Volume",
+		REG_ADDIGLOOPGAIN1, REG_ADDIGLOOPGAIN2,
+		0, REG_ADDIGLOOPGAINX_ADXLBGAIN_MAX, INVERT, dax_dig_gain_tlv),
+	SOC_DOUBLE_R_TLV("Headset Digital Gain Playback Volume",
+		REG_HSLEARDIGGAIN, REG_HSRDIGGAIN,
+		0, REG_HSLEARDIGGAIN_HSLDGAIN_MAX, INVERT, hs_ear_dig_gain_tlv),
+	SOC_DOUBLE_R_TLV("Sidetone Digital Gain Playback Volume",
+		REG_SIDFIRGAIN1, REG_SIDFIRGAIN2,
+		0, REG_SIDFIRGAINX_FIRSIDXGAIN_MAX, INVERT, stfir_dig_gain_tlv),
+
+	/* Analog gains */
+
+	SOC_DOUBLE_TLV("Headset Gain Playback Volume",
+		REG_ANAGAIN3,
+		REG_ANAGAIN3_HSLGAIN, REG_ANAGAIN3_HSRGAIN,
+		REG_ANAGAIN3_HSXGAIN_MAX, INVERT, hs_gain_tlv),
+	SOC_SINGLE_TLV("Mic 1 Capture Volume",
+		REG_ANAGAIN1,
+		REG_ANAGAINX_MICXGAIN,
+		REG_ANAGAINX_MICXGAIN_MAX, NORMAL, mic_gain_tlv),
+	SOC_SINGLE_TLV("Mic 2 Capture Volume",
+		REG_ANAGAIN2,
+		REG_ANAGAINX_MICXGAIN,
+		REG_ANAGAINX_MICXGAIN_MAX, NORMAL, mic_gain_tlv),
+	SOC_DOUBLE_TLV("LineIn Capture Volume",
+		REG_ANAGAIN4,
+		REG_ANAGAIN4_LINLGAIN, REG_ANAGAIN4_LINRGAIN,
+		REG_ANAGAIN4_LINXGAIN_MAX, NORMAL, lin_gain_tlv),
+	SOC_DOUBLE_R_TLV("LineIn to Headset Bypass Playback Volume",
+		REG_DIGLINHSLGAIN, REG_DIGLINHSRGAIN,
+		REG_DIGLINHSXGAIN_LINTOHSXGAIN,
+		REG_DIGLINHSXGAIN_LINTOHSXGAIN_MAX, INVERT, lin2hs_gain_tlv),
+
+	/* Digital interface - Clocks */
+	SOC_ENUM("Digital Interface Master Generator Switch", soc_enum_mastgen),
+	SOC_ENUM("Digital Interface 0 Bit-clock Switch", soc_enum_fsbitclk0),
+	SOC_ENUM("Digital Interface 1 Bit-clock Switch", soc_enum_fsbitclk1),
+
+	/* Digital interface - DA from slot mapping */
+	SOC_ENUM("Digital Interface DA 1 From Slot Map", soc_enum_da1slotmap),
+	SOC_ENUM("Digital Interface DA 2 From Slot Map", soc_enum_da2slotmap),
+	SOC_ENUM("Digital Interface DA 3 From Slot Map", soc_enum_da3slotmap),
+	SOC_ENUM("Digital Interface DA 4 From Slot Map", soc_enum_da4slotmap),
+	SOC_ENUM("Digital Interface DA 5 From Slot Map", soc_enum_da5slotmap),
+	SOC_ENUM("Digital Interface DA 6 From Slot Map", soc_enum_da6slotmap),
+	SOC_ENUM("Digital Interface DA 7 From Slot Map", soc_enum_da7slotmap),
+	SOC_ENUM("Digital Interface DA 8 From Slot Map", soc_enum_da8slotmap),
+
+	/* Digital interface - AD to slot mapping */
+	SOC_ENUM("Digital Interface AD To Slot 0 Map", soc_enum_adslot0map),
+	SOC_ENUM("Digital Interface AD To Slot 1 Map", soc_enum_adslot1map),
+	SOC_ENUM("Digital Interface AD To Slot 2 Map", soc_enum_adslot2map),
+	SOC_ENUM("Digital Interface AD To Slot 3 Map", soc_enum_adslot3map),
+	SOC_ENUM("Digital Interface AD To Slot 4 Map", soc_enum_adslot4map),
+	SOC_ENUM("Digital Interface AD To Slot 5 Map", soc_enum_adslot5map),
+	SOC_ENUM("Digital Interface AD To Slot 6 Map", soc_enum_adslot6map),
+	SOC_ENUM("Digital Interface AD To Slot 7 Map", soc_enum_adslot7map),
+	SOC_ENUM("Digital Interface AD To Slot 8 Map", soc_enum_adslot8map),
+	SOC_ENUM("Digital Interface AD To Slot 9 Map", soc_enum_adslot9map),
+	SOC_ENUM("Digital Interface AD To Slot 10 Map", soc_enum_adslot10map),
+	SOC_ENUM("Digital Interface AD To Slot 11 Map", soc_enum_adslot11map),
+	SOC_ENUM("Digital Interface AD To Slot 12 Map", soc_enum_adslot12map),
+	SOC_ENUM("Digital Interface AD To Slot 13 Map", soc_enum_adslot13map),
+	SOC_ENUM("Digital Interface AD To Slot 14 Map", soc_enum_adslot14map),
+	SOC_ENUM("Digital Interface AD To Slot 15 Map", soc_enum_adslot15map),
+	SOC_ENUM("Digital Interface AD To Slot 16 Map", soc_enum_adslot16map),
+	SOC_ENUM("Digital Interface AD To Slot 17 Map", soc_enum_adslot17map),
+	SOC_ENUM("Digital Interface AD To Slot 18 Map", soc_enum_adslot18map),
+	SOC_ENUM("Digital Interface AD To Slot 19 Map", soc_enum_adslot19map),
+	SOC_ENUM("Digital Interface AD To Slot 20 Map", soc_enum_adslot20map),
+	SOC_ENUM("Digital Interface AD To Slot 21 Map", soc_enum_adslot21map),
+	SOC_ENUM("Digital Interface AD To Slot 22 Map", soc_enum_adslot22map),
+	SOC_ENUM("Digital Interface AD To Slot 23 Map", soc_enum_adslot23map),
+	SOC_ENUM("Digital Interface AD To Slot 24 Map", soc_enum_adslot24map),
+	SOC_ENUM("Digital Interface AD To Slot 25 Map", soc_enum_adslot25map),
+	SOC_ENUM("Digital Interface AD To Slot 26 Map", soc_enum_adslot26map),
+	SOC_ENUM("Digital Interface AD To Slot 27 Map", soc_enum_adslot27map),
+	SOC_ENUM("Digital Interface AD To Slot 28 Map", soc_enum_adslot28map),
+	SOC_ENUM("Digital Interface AD To Slot 29 Map", soc_enum_adslot29map),
+	SOC_ENUM("Digital Interface AD To Slot 30 Map", soc_enum_adslot30map),
+	SOC_ENUM("Digital Interface AD To Slot 31 Map", soc_enum_adslot31map),
+
+	/* Digital interface - Loopback */
+	SOC_ENUM("Digital Interface AD 1 Loopback Switch", soc_enum_ad1loop),
+	SOC_ENUM("Digital Interface AD 2 Loopback Switch", soc_enum_ad2loop),
+	SOC_ENUM("Digital Interface AD 3 Loopback Switch", soc_enum_ad3loop),
+	SOC_ENUM("Digital Interface AD 4 Loopback Switch", soc_enum_ad4loop),
+	SOC_ENUM("Digital Interface AD 5 Loopback Switch", soc_enum_ad5loop),
+	SOC_ENUM("Digital Interface AD 6 Loopback Switch", soc_enum_ad6loop),
+	SOC_ENUM("Digital Interface AD 7 Loopback Switch", soc_enum_ad7loop),
+	SOC_ENUM("Digital Interface AD 8 Loopback Switch", soc_enum_ad8loop),
+
+	/* Digital interface - Burst FIFO */
+	SOC_ENUM("Digital Interface 0 FIFO Enable Switch", soc_enum_if0fifoen),
+	SOC_ENUM("Burst FIFO Mask", soc_enum_bfifomask),
+	SOC_ENUM("Burst FIFO Bit-clock Frequency", soc_enum_bfifo19m2),
+	SOC_SINGLE("Burst FIFO Threshold",
+		REG_FIFOCONF1,
+		REG_FIFOCONF1_BFIFOINT_SHIFT,
+		REG_FIFOCONF1_BFIFOINT_MAX,
+		NORMAL),
+	SOC_SINGLE("Burst FIFO Length",
+		REG_FIFOCONF2,
+		REG_FIFOCONF2_BFIFOTX_SHIFT,
+		REG_FIFOCONF2_BFIFOTX_MAX,
+		NORMAL),
+	SOC_SINGLE("Burst FIFO EOS Extra Slots",
+		REG_FIFOCONF3,
+		REG_FIFOCONF3_BFIFOEXSL_SHIFT,
+		REG_FIFOCONF3_BFIFOEXSL_MAX,
+		NORMAL),
+	SOC_SINGLE("Burst FIFO FS Extra Bit-clocks",
+		REG_FIFOCONF3,
+		REG_FIFOCONF3_PREBITCLK0_SHIFT,
+		REG_FIFOCONF3_PREBITCLK0_MAX,
+		NORMAL),
+	SOC_ENUM("Burst FIFO Interface Mode", soc_enum_bfifomast),
+	SOC_ENUM("Burst FIFO Interface Switch", soc_enum_bfifoint),
+	SOC_SINGLE("Burst FIFO Switch Frame Number",
+		REG_FIFOCONF4,
+		REG_FIFOCONF4_BFIFOFRAMSW_SHIFT,
+		REG_FIFOCONF4_BFIFOFRAMSW_MAX,
+		NORMAL),
+	SOC_SINGLE("Burst FIFO Wake Up Delay",
+		REG_FIFOCONF5,
+		REG_FIFOCONF5_BFIFOWAKEUP_SHIFT,
+		REG_FIFOCONF5_BFIFOWAKEUP_MAX,
+		NORMAL),
+	SOC_SINGLE("Burst FIFO Samples In FIFO",
+		REG_FIFOCONF6,
+		REG_FIFOCONF6_BFIFOSAMPLE_SHIFT,
+		REG_FIFOCONF6_BFIFOSAMPLE_MAX,
+		NORMAL),
+
+	/* Sidetone */
+	SOC_SINGLE("Sidetone FIR Coeffecient Index",
+		REG_SIDFIRADR,
+		REG_SIDFIRADR_ADDRESS_SHIFT,
+		REG_SIDFIRADR_ADDRESS_MAX,
+		NORMAL),
+
+	/* ANC */
+	SOC_SINGLE_S1R("ANC Warp Delay Shift",
+		REG_ANCCONF2,
+		REG_ANCCONF2_VALUE_MIN,
+		REG_ANCCONF2_VALUE_MAX,
+		NORMAL),
+	SOC_SINGLE_S1R("ANC FIR Output Shift",
+		REG_ANCCONF3,
+		REG_ANCCONF3_VALUE_MIN,
+		REG_ANCCONF3_VALUE_MAX,
+		NORMAL),
+	SOC_SINGLE_S1R("ANC IIR Output Shift",
+		REG_ANCCONF4,
+		REG_ANCCONF4_VALUE_MIN,
+		REG_ANCCONF4_VALUE_MAX,
+		NORMAL),
+	SOC_SINGLE_S2R("ANC Warp Delay",
+		REG_ANCCONF9, REG_ANCCONF10,
+		REG_ANC_WARP_DELAY_MIN,
+		REG_ANC_WARP_DELAY_MAX,
+		NORMAL),
+	SOC_MULTIPLE_SA("ANC FIR Coefficients",
+		ab8500_anc_fir_coeff_cache,
+		REG_ANC_FIR_COEFF_MIN,
+		REG_ANC_FIR_COEFF_MAX,
+		NORMAL),
+	SOC_MULTIPLE_SA("ANC IIR Coefficients",
+		ab8500_anc_iir_coeff_cache,
+		REG_ANC_IIR_COEFF_MIN,
+		REG_ANC_IIR_COEFF_MAX,
+		NORMAL),
+};
+
+static int ab8500_codec_set_format_if1(struct snd_soc_codec *codec, unsigned int fmt)
+{
+	unsigned int clear_mask, set_mask;
+
+	/* Master or slave */
+
+	clear_mask = BMASK(REG_DIGIFCONF3_IF1MASTER);
+	set_mask = 0;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM: /* codec clk & FRM master */
+		pr_debug("%s: IF1 Master-mode: AB8500 master.\n", __func__);
+		set_mask |= BMASK(REG_DIGIFCONF3_IF1MASTER);
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS: /* codec clk & FRM slave */
+		pr_debug("%s: IF1 Master-mode: AB8500 slave.\n", __func__);
+		break;
+	case SND_SOC_DAIFMT_CBS_CFM: /* codec clk slave & FRM master */
+	case SND_SOC_DAIFMT_CBM_CFS: /* codec clk master & frame slave */
+		pr_err("%s: ERROR: The device is either a master or a slave.\n",
+			__func__);
+	default:
+		pr_err("%s: ERROR: Unsupporter master mask 0x%x\n",
+			__func__,
+			fmt & SND_SOC_DAIFMT_MASTER_MASK);
+		return -EINVAL;
+	}
+
+	ab8500_codec_update_reg_audio(codec,
+				REG_DIGIFCONF3,
+				BMASK(REG_DIGIFCONF3_IF1MASTER),
+				BMASK(REG_DIGIFCONF3_IF1MASTER));
+
+	/* I2S or TDM */
+
+	clear_mask = BMASK(REG_DIGIFCONF4_FSYNC1P) |
+			BMASK(REG_DIGIFCONF4_BITCLK1P) |
+			BMASK(REG_DIGIFCONF4_IF1FORMAT1) |
+			BMASK(REG_DIGIFCONF4_IF1FORMAT0);
+	set_mask = 0;
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S: /* I2S mode */
+		pr_debug("%s: IF1 Protocol: I2S\n", __func__);
+		set_mask |= BMASK(REG_DIGIFCONF4_IF1FORMAT1);
+		break;
+	case SND_SOC_DAIFMT_DSP_B: /* L data MSB during FRM LRC */
+		pr_debug("%s: IF1 Protocol: DSP B (TDM)\n", __func__);
+		set_mask |= BMASK(REG_DIGIFCONF4_IF1FORMAT0);
+		break;
+	default:
+		pr_err("%s: ERROR: Unsupported format (0x%x)!\n",
+			__func__,
+			fmt & SND_SOC_DAIFMT_FORMAT_MASK);
+		return -EINVAL;
+	}
+
+	ab8500_codec_update_reg_audio(codec, REG_DIGIFCONF4, clear_mask, set_mask);
+
+	return 0;
+}
+
+static int ab8500_codec_set_word_length_if1(struct snd_soc_codec *codec, unsigned int wl)
+{
+	unsigned int clear_mask, set_mask;
+
+	clear_mask = BMASK(REG_DIGIFCONF4_IF1WL1) | BMASK(REG_DIGIFCONF4_IF1WL0);
+	set_mask = 0;
+
+	switch (wl) {
+	case 16:
+		break;
+	case 20:
+		set_mask |= BMASK(REG_DIGIFCONF4_IF1WL0);
+		break;
+	case 24:
+		set_mask |= BMASK(REG_DIGIFCONF4_IF1WL1);
+		break;
+	case 32:
+		set_mask |= BMASK(REG_DIGIFCONF2_IF0WL1) |
+			BMASK(REG_DIGIFCONF2_IF0WL0);
+		break;
+	default:
+		pr_err("%s: Unsupporter word-length 0x%x\n", __func__, wl);
+		return -EINVAL;
+	}
+
+	pr_debug("%s: Word-length: %d bits.\n", __func__, wl);
+	ab8500_codec_update_reg_audio(codec, REG_DIGIFCONF4, clear_mask, set_mask);
+
+	return 0;
+}
+
+static int ab8500_codec_set_bit_delay_if1(struct snd_soc_codec *codec, unsigned int delay)
+{
+	unsigned int clear_mask, set_mask;
+
+	clear_mask = BMASK(REG_DIGIFCONF4_IF1DEL);
+	set_mask = 0;
+
+	switch (delay) {
+	case 0:
+		break;
+	case 1:
+		set_mask |= BMASK(REG_DIGIFCONF4_IF1DEL);
+		break;
+	default:
+		pr_err("%s: ERROR: Unsupported bit-delay (0x%x)!\n", __func__, delay);
+		return -EINVAL;
+	}
+
+	pr_debug("%s: IF1 Bit-delay: %d bits.\n", __func__, delay);
+	ab8500_codec_update_reg_audio(codec, REG_DIGIFCONF4, clear_mask, set_mask);
+
+	return 0;
+}
+
+/* Configures audio macrocell into the AB8500 Chip */
+static void ab8500_codec_configure_audio_macrocell(struct snd_soc_codec *codec)
+{
+	int data, ret;
+
+	ret = ab8500_sysctrl_write(AB8500_STW4500CTRL3,
+		AB8500_STW4500CTRL3_CLK32KOUT2DIS | AB8500_STW4500CTRL3_RESETAUDN,
+		AB8500_STW4500CTRL3_RESETAUDN);
+	if (ret < 0)
+		pr_err("%s: WARN: Unable to set reg STW4500CTRL3!\n", __func__);
+
+	data = ab8500_codec_read_reg(codec, AB8500_MISC, AB8500_GPIO_DIR4_REG);
+	data |= GPIO27_DIR_OUTPUT | GPIO29_DIR_OUTPUT | GPIO31_DIR_OUTPUT;
+	ab8500_codec_write_reg(codec, AB8500_MISC, AB8500_GPIO_DIR4_REG, data);
+}
+
+/* Extended interface for codec-driver */
+
+void ab8500_audio_power_control(bool power_on)
+{
+	if (ab8500_codec == NULL) {
+		pr_err("%s: ERROR: AB8500 ASoC-driver not yet probed!\n", __func__);
+		return;
+	}
+
+	if (power_on) {
+		unsigned int set_mask;
+		pr_debug("Enabling AB8500.");
+		set_mask = BMASK(REG_POWERUP_POWERUP) | BMASK(REG_POWERUP_ENANA);
+		ab8500_codec_update_reg_audio(ab8500_codec, REG_POWERUP, 0x00, set_mask);
+	} else {
+		unsigned int clear_mask;
+		pr_debug("Disabling AB8500.");
+		clear_mask = BMASK(REG_POWERUP_POWERUP) | BMASK(REG_POWERUP_ENANA);
+		ab8500_codec_update_reg_audio(ab8500_codec, REG_POWERUP, clear_mask, 0x00);
+	}
+}
+
+void ab8500_audio_pwm_vibra(unsigned char speed_left_pos,
+			unsigned char speed_left_neg,
+			unsigned char speed_right_pos,
+			unsigned char speed_right_neg)
+{
+	unsigned int clear_mask, set_mask;
+	bool vibra_on;
+
+	if (ab8500_codec == NULL) {
+		pr_err("%s: ERROR: AB8500 ASoC-driver not yet probed!\n", __func__);
+		return;
+	}
+
+	vibra_on = speed_left_pos | speed_left_neg | speed_right_pos | speed_right_neg;
+	if (!vibra_on) {
+		speed_left_pos = 0;
+		speed_left_neg = 0;
+		speed_right_pos = 0;
+		speed_right_neg = 0;
+	}
+
+	pr_debug("%s: PWM-vibra (%d, %d, %d, %d).\n",
+			__func__,
+			speed_left_pos,
+			speed_left_neg,
+			speed_right_pos,
+			speed_right_neg);
+
+	set_mask = BMASK(REG_PWMGENCONF1_PWMTOVIB1) |
+		BMASK(REG_PWMGENCONF1_PWMTOVIB2) |
+		BMASK(REG_PWMGENCONF1_PWM1CTRL) |
+		BMASK(REG_PWMGENCONF1_PWM2CTRL) |
+		BMASK(REG_PWMGENCONF1_PWM1NCTRL) |
+		BMASK(REG_PWMGENCONF1_PWM1PCTRL) |
+		BMASK(REG_PWMGENCONF1_PWM2NCTRL) |
+		BMASK(REG_PWMGENCONF1_PWM2PCTRL);
+	ab8500_codec_update_reg_audio(ab8500_codec, REG_PWMGENCONF1, 0x00, set_mask);
+
+	if (speed_left_pos > REG_PWMGENCONFX_PWMVIBXDUTCYC_MAX)
+		speed_left_pos = REG_PWMGENCONFX_PWMVIBXDUTCYC_MAX;
+	ab8500_codec_update_reg_audio(ab8500_codec, REG_PWMGENCONF3, REG_MASK_ALL, speed_left_pos);
+
+	if (speed_left_neg > REG_PWMGENCONFX_PWMVIBXDUTCYC_MAX)
+		speed_left_neg = REG_PWMGENCONFX_PWMVIBXDUTCYC_MAX;
+	ab8500_codec_update_reg_audio(ab8500_codec, REG_PWMGENCONF2, REG_MASK_ALL, speed_left_neg);
+
+	if (speed_right_pos > REG_PWMGENCONFX_PWMVIBXDUTCYC_MAX)
+		speed_right_pos = REG_PWMGENCONFX_PWMVIBXDUTCYC_MAX;
+	ab8500_codec_update_reg_audio(ab8500_codec, REG_PWMGENCONF5, REG_MASK_ALL, speed_right_pos);
+
+	if (speed_right_neg > REG_PWMGENCONFX_PWMVIBXDUTCYC_MAX)
+		speed_right_neg = REG_PWMGENCONFX_PWMVIBXDUTCYC_MAX;
+	ab8500_codec_update_reg_audio(ab8500_codec, REG_PWMGENCONF4, REG_MASK_ALL, speed_right_neg);
+
+	if (vibra_on) {
+		clear_mask = 0;
+		set_mask = BMASK(REG_ANACONF4_ENVIB1) | BMASK(REG_ANACONF4_ENVIB2);
+	} else {
+		clear_mask = BMASK(REG_ANACONF4_ENVIB1) | BMASK(REG_ANACONF4_ENVIB2);
+		set_mask = 0;
+	};
+	ab8500_codec_update_reg_audio(ab8500_codec, REG_ANACONF4, clear_mask, set_mask);
+}
+
+int ab8500_audio_set_word_length(struct snd_soc_dai *dai, unsigned int wl)
+{
+	unsigned int clear_mask, set_mask;
+	struct snd_soc_codec *codec = dai->codec;
+
+	clear_mask = BMASK(REG_DIGIFCONF2_IF0WL0) | BMASK(REG_DIGIFCONF2_IF0WL1);
+	set_mask = 0;
+
+	switch (wl) {
+	case 16:
+		break;
+	case 20:
+		set_mask |= BMASK(REG_DIGIFCONF2_IF0WL0);
+		break;
+	case 24:
+		set_mask |= BMASK(REG_DIGIFCONF2_IF0WL1);
+		break;
+	case 32:
+		set_mask |= BMASK(REG_DIGIFCONF2_IF0WL1) |
+			BMASK(REG_DIGIFCONF2_IF0WL0);
+		break;
+	default:
+		pr_err("%s: Unsupporter word-length 0x%x\n", __func__, wl);
+		return -EINVAL;
+	}
+
+	pr_debug("%s: IF0 Word-length: %d bits.\n", __func__, wl);
+	ab8500_codec_update_reg_audio(codec, REG_DIGIFCONF2, clear_mask, set_mask);
+
+	return 0;
+}
+
+int ab8500_audio_set_bit_delay(struct snd_soc_dai *dai, unsigned int delay)
+{
+	unsigned int clear_mask, set_mask;
+	struct snd_soc_codec *codec = dai->codec;
+
+	clear_mask = BMASK(REG_DIGIFCONF2_IF0DEL);
+	set_mask = 0;
+
+	switch (delay) {
+	case 0:
+		break;
+	case 1:
+		set_mask |= BMASK(REG_DIGIFCONF2_IF0DEL);
+		break;
+	default:
+		pr_err("%s: ERROR: Unsupported bit-delay (0x%x)!\n", __func__, delay);
+		return -EINVAL;
+	}
+
+	pr_debug("%s: IF0 Bit-delay: %d bits.\n", __func__, delay);
+	ab8500_codec_update_reg_audio(codec, REG_DIGIFCONF2, clear_mask, set_mask);
+
+	return 0;
+}
+
+int ab8500_audio_setup_if1(struct snd_soc_codec *codec,
+			unsigned int fmt,
+			unsigned int wl,
+			unsigned int delay)
+{
+	int ret;
+
+	pr_debug("%s: Enter.\n", __func__);
+
+	ret = ab8500_codec_set_format_if1(codec, fmt);
+	if (ret)
+		return -1;
+
+	ret = ab8500_codec_set_bit_delay_if1(codec, delay);
+	if (ret)
+		return -1;
+
+
+	ret = ab8500_codec_set_word_length_if1(codec, wl);
+	if (ret)
+		return -1;
+
+	return 0;
+}
+
+/* ANC block current configuration status */
+unsigned int ab8500_audio_anc_status(void)
+{
+	return ab8500_anc_status;
+}
+
+/* ANC IIR-/FIR-coefficients configuration sequence */
+int ab8500_audio_anc_configure(unsigned int req_state)
+{
+	bool configure_fir = req_state == ANC_CONFIGURE_FIR || req_state == ANC_CONFIGURE_FIR_IIR;
+	bool configure_iir = req_state == ANC_CONFIGURE_IIR || req_state == ANC_CONFIGURE_FIR_IIR;
+	unsigned int bank, param;
+	int ret;
+
+	if (req_state == ANC_UNCONFIGURED
+		|| req_state == ANC_FIR_IIR_CONFIGURED
+		|| req_state == ANC_FIR_CONFIGURED
+		|| req_state == ANC_IIR_CONFIGURED
+		|| req_state == ANC_ERROR)
+		return -1;
+
+	mutex_lock(&ab8500_anc_conf_lock);
+
+	if (configure_fir)
+		AB8500_CLEAR_BIT_LOCKED(REG_ANCCONF1, REG_ANCCONF1_ENANC, ret, cleanup)
+
+	AB8500_SET_BIT_LOCKED(REG_ANCCONF1, REG_ANCCONF1_ENANC, ret, cleanup)
+
+	if (configure_fir) {
+		for (bank = 0; bank < AB8500_NR_OF_ANC_COEFF_BANKS; bank++) {
+			for (param = 0; param < REG_ANC_FIR_COEFFS; param++) {
+				if (param == 0 && bank == 0)
+					AB8500_SET_BIT_LOCKED(REG_ANCCONF1, REG_ANCCONF1_ANCFIRUPDATE, ret, cleanup)
+
+				AB8500_WRITE(REG_ANCCONF5, ab8500_anc_fir_coeff_cache[param] >> 8 & REG_MASK_ALL, ret, cleanup)
+				AB8500_WRITE(REG_ANCCONF6, ab8500_anc_fir_coeff_cache[param] & REG_MASK_ALL, ret, cleanup)
+
+				if (param == REG_ANC_FIR_COEFFS - 1 && bank == 1)
+					AB8500_CLEAR_BIT_LOCKED(REG_ANCCONF1, REG_ANCCONF1_ANCFIRUPDATE, ret, cleanup)
+			}
+		}
+		if (ab8500_anc_status == ANC_IIR_CONFIGURED)
+			ab8500_anc_status = ANC_FIR_IIR_CONFIGURED;
+		else if (ab8500_anc_status != ANC_FIR_IIR_CONFIGURED)
+			ab8500_anc_status =  ANC_FIR_CONFIGURED;
+	}
+
+	if (configure_iir) {
+		for (bank = 0; bank < AB8500_NR_OF_ANC_COEFF_BANKS; bank++) {
+			for (param = 0; param < REG_ANC_IIR_COEFFS; param++) {
+				if (param == 0) {
+					if (bank == 0) {
+						AB8500_SET_BIT_LOCKED(REG_ANCCONF1, REG_ANCCONF1_ANCIIRINIT, ret, cleanup)
+						udelay(2000);
+						AB8500_CLEAR_BIT_LOCKED(REG_ANCCONF1, REG_ANCCONF1_ANCIIRINIT, ret, cleanup)
+						udelay(2000);
+					} else {
+						AB8500_SET_BIT_LOCKED(REG_ANCCONF1, REG_ANCCONF1_ANCIIRUPDATE, ret, cleanup)
+					}
+				} else if (param > 3) {
+					AB8500_WRITE(REG_ANCCONF7, REG_MASK_NONE, ret, cleanup)
+					AB8500_WRITE(REG_ANCCONF8, ab8500_anc_iir_coeff_cache[param] >> 16 & REG_MASK_ALL, ret, cleanup)
+				}
+
+				AB8500_WRITE(REG_ANCCONF7, ab8500_anc_iir_coeff_cache[param] >> 8 & REG_MASK_ALL, ret, cleanup)
+				AB8500_WRITE(REG_ANCCONF8, ab8500_anc_iir_coeff_cache[param] & REG_MASK_ALL, ret, cleanup)
+
+				if (param == REG_ANC_IIR_COEFFS - 1 && bank == 1)
+					AB8500_CLEAR_BIT_LOCKED(REG_ANCCONF1, REG_ANCCONF1_ANCIIRUPDATE, ret, cleanup)
+			}
+		}
+		if (ab8500_anc_status == ANC_FIR_CONFIGURED)
+			ab8500_anc_status = ANC_FIR_IIR_CONFIGURED;
+		else if (ab8500_anc_status != ANC_FIR_IIR_CONFIGURED)
+			ab8500_anc_status =  ANC_IIR_CONFIGURED;
+	}
+
+	mutex_unlock(&ab8500_anc_conf_lock);
+
+	return 0;
+
+cleanup:
+	ret |= snd_soc_update_bits_locked(ab8500_codec
+			, REG_ANCCONF1
+			, BMASK(REG_ANCCONF1_ENANC)
+			| BMASK(REG_ANCCONF1_ANCIIRINIT)
+			| BMASK(REG_ANCCONF1_ANCIIRUPDATE)
+			| BMASK(REG_ANCCONF1_ANCFIRUPDATE)
+			, REG_MASK_NONE);
+
+	ab8500_anc_status = ANC_ERROR;
+
+	mutex_unlock(&ab8500_anc_conf_lock);
+
+	return ret;
+}
+
+bool ab8500_audio_dapm_path_active(enum ab8500_audio_dapm_path dapm_path)
+{
+	int reg, reg_mask;
+
+	switch (dapm_path) {
+	case AB8500_AUDIO_DAPM_PATH_DMIC:
+		reg = ab8500_codec_read_reg_audio(ab8500_codec, REG_DIGMICCONF);
+		reg_mask = BMASK(REG_DIGMICCONF_ENDMIC1) |
+			BMASK(REG_DIGMICCONF_ENDMIC2) |
+			BMASK(REG_DIGMICCONF_ENDMIC3) |
+			BMASK(REG_DIGMICCONF_ENDMIC4) |
+			BMASK(REG_DIGMICCONF_ENDMIC5) |
+			BMASK(REG_DIGMICCONF_ENDMIC6);
+		return reg & reg_mask;
+
+	case AB8500_AUDIO_DAPM_PATH_AMIC1:
+		reg = ab8500_codec_read_reg_audio(ab8500_codec, REG_ANACONF2);
+		reg_mask = BMASK(REG_ANACONF2_MUTMIC1);
+		return !(reg & reg_mask);
+
+	case AB8500_AUDIO_DAPM_PATH_AMIC2:
+		reg = ab8500_codec_read_reg_audio(ab8500_codec, REG_ANACONF2);
+		reg_mask = BMASK(REG_ANACONF2_MUTMIC2);
+		return !(reg & reg_mask);
+
+	default:
+		return false;
+	}
+}
+
+static int ab8500_codec_add_widgets(struct snd_soc_codec *codec)
+{
+	int ret;
+
+	ret = snd_soc_dapm_new_controls(&codec->dapm, ab8500_dapm_widgets,
+			ARRAY_SIZE(ab8500_dapm_widgets));
+	if (ret < 0) {
+		pr_err("%s: Failed to create DAPM controls (%d).\n",
+			__func__, ret);
+		return ret;
+	}
+
+	ret = snd_soc_dapm_add_routes(&codec->dapm, dapm_routes, ARRAY_SIZE(dapm_routes));
+	if (ret < 0) {
+		pr_err("%s: Failed to add DAPM routes (%d).\n",
+			__func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ab8500_codec_pcm_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *hw_params, struct snd_soc_dai *dai)
+{
+	pr_debug("%s Enter.\n", __func__);
+	return 0;
+}
+
+static int ab8500_codec_pcm_startup(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	pr_debug("%s Enter.\n", __func__);
+
+	return 0;
+}
+
+static int ab8500_codec_pcm_prepare(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	pr_debug("%s Enter.\n", __func__);
+
+	/* Clear interrupt status registers by reading them. */
+	ab8500_codec_read_reg_audio(dai->codec, REG_AUDINTSOURCE1);
+	ab8500_codec_read_reg_audio(dai->codec, REG_AUDINTSOURCE2);
+
+	return 0;
+}
+
+static void ab8500_codec_pcm_shutdown(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	pr_debug("%s Enter.\n", __func__);
+
+	ab8500_codec_dump_all_reg(dai->codec);
+}
+
+static int ab8500_codec_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
+		unsigned int freq, int dir)
+{
+	pr_err("%s Enter.\n", __func__);
+
+	return 0;
+}
+
+/* Gates clocking according format mask */
+static int ab8500_codec_set_dai_clock_gate(struct snd_soc_codec *codec, unsigned int fmt)
+{
+	unsigned int clear_mask;
+	unsigned int set_mask;
+
+	clear_mask = BMASK(REG_DIGIFCONF1_ENMASTGEN) |
+			BMASK(REG_DIGIFCONF1_ENFSBITCLK0);
+
+	set_mask = BMASK(REG_DIGIFCONF1_ENMASTGEN);
+
+	switch (fmt & SND_SOC_DAIFMT_CLOCK_MASK) {
+	case SND_SOC_DAIFMT_CONT: /* continuous clock */
+		pr_debug("%s: IF0 Clock is continous.\n", __func__);
+		set_mask |= BMASK(REG_DIGIFCONF1_ENFSBITCLK0);
+		break;
+	case SND_SOC_DAIFMT_GATED: /* clock is gated */
+		pr_debug("%s: IF0 Clock is gated.\n", __func__);
+		break;
+	default:
+		pr_err("%s: ERROR: Unsupporter clock mask (0x%x)!\n",
+			__func__,
+			fmt & SND_SOC_DAIFMT_CLOCK_MASK);
+		return -EINVAL;
+	}
+
+	ab8500_codec_update_reg_audio(codec, REG_DIGIFCONF1, clear_mask, set_mask);
+
+	return 0;
+}
+
+static int ab8500_codec_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	unsigned int clear_mask;
+	unsigned int set_mask;
+	struct snd_soc_codec *codec = dai->codec;
+	int err;
+
+	pr_debug("%s: Enter (fmt = 0x%x)\n", __func__, fmt);
+
+	clear_mask = BMASK(REG_DIGIFCONF3_IF1DATOIF0AD) |
+			BMASK(REG_DIGIFCONF3_IF1CLKTOIF0CLK) |
+			BMASK(REG_DIGIFCONF3_IF0BFIFOEN) |
+			BMASK(REG_DIGIFCONF3_IF0MASTER);
+	set_mask = 0;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM: /* codec clk & FRM master */
+		pr_debug("%s: IF0 Master-mode: AB8500 master.\n", __func__);
+		set_mask |= BMASK(REG_DIGIFCONF3_IF0MASTER);
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS: /* codec clk & FRM slave */
+		pr_debug("%s: IF0 Master-mode: AB8500 slave.\n", __func__);
+		break;
+	case SND_SOC_DAIFMT_CBS_CFM: /* codec clk slave & FRM master */
+	case SND_SOC_DAIFMT_CBM_CFS: /* codec clk master & frame slave */
+		pr_err("%s: ERROR: The device is either a master or a slave.\n", __func__);
+	default:
+		pr_err("%s: ERROR: Unsupporter master mask 0x%x\n",
+				__func__,
+				(fmt & SND_SOC_DAIFMT_MASTER_MASK));
+		return -EINVAL;
+		break;
+	}
+
+	ab8500_codec_update_reg_audio(codec, REG_DIGIFCONF3, clear_mask, set_mask);
+
+	/* Set clock gating */
+	err = ab8500_codec_set_dai_clock_gate(codec, fmt);
+	if (err) {
+		pr_err("%s: ERRROR: Failed to set clock gate (%d).\n", __func__, err);
+		return err;
+	}
+
+	/* Setting data transfer format */
+
+	clear_mask = BMASK(REG_DIGIFCONF2_IF0FORMAT0) |
+		BMASK(REG_DIGIFCONF2_IF0FORMAT1) |
+		BMASK(REG_DIGIFCONF2_FSYNC0P) |
+		BMASK(REG_DIGIFCONF2_BITCLK0P);
+	set_mask = 0;
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S: /* I2S mode */
+		pr_debug("%s: IF0 Protocol: I2S\n", __func__);
+		set_mask |= BMASK(REG_DIGIFCONF2_IF0FORMAT1);
+
+		/* 32 bit, 0 delay */
+		ab8500_audio_set_word_length(dai, 32);
+		ab8500_audio_set_bit_delay(dai, 0);
+
+		break;
+	case SND_SOC_DAIFMT_DSP_A: /* L data MSB after FRM LRC */
+		pr_debug("%s: IF0 Protocol: DSP A (TDM)\n", __func__);
+		set_mask |= BMASK(REG_DIGIFCONF2_IF0FORMAT0);
+		break;
+	case SND_SOC_DAIFMT_DSP_B: /* L data MSB during FRM LRC */
+		pr_debug("%s: IF0 Protocol: DSP B (TDM)\n", __func__);
+		set_mask |= BMASK(REG_DIGIFCONF2_IF0FORMAT0);
+		break;
+	default:
+		pr_err("%s: ERROR: Unsupporter format (0x%x)!\n",
+				__func__,
+				fmt & SND_SOC_DAIFMT_FORMAT_MASK);
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF: /* normal bit clock + frame */
+		pr_debug("%s: IF0: Normal bit clock, normal frame\n", __func__);
+		break;
+	case SND_SOC_DAIFMT_NB_IF: /* normal BCLK + inv FRM */
+		pr_debug("%s: IF0: Normal bit clock, inverted frame\n", __func__);
+		set_mask |= BMASK(REG_DIGIFCONF2_FSYNC0P);
+		break;
+	case SND_SOC_DAIFMT_IB_NF: /* invert BCLK + nor FRM */
+		pr_debug("%s: IF0: Inverted bit clock, normal frame\n", __func__);
+		set_mask |= BMASK(REG_DIGIFCONF2_BITCLK0P);
+		break;
+	case SND_SOC_DAIFMT_IB_IF: /* invert BCLK + FRM */
+		pr_debug("%s: IF0: Inverted bit clock, inverted frame\n", __func__);
+		set_mask |= BMASK(REG_DIGIFCONF2_FSYNC0P);
+		set_mask |= BMASK(REG_DIGIFCONF2_BITCLK0P);
+		break;
+	default:
+		pr_err("%s: ERROR: Unsupported INV mask 0x%x\n",
+				__func__,
+				(fmt & SND_SOC_DAIFMT_INV_MASK));
+		return -EINVAL;
+		break;
+	}
+
+	ab8500_codec_update_reg_audio(codec, REG_DIGIFCONF2, clear_mask, set_mask);
+
+	return 0;
+}
+
+static int ab8500_codec_set_dai_tdm_slot(struct snd_soc_dai *dai,
+		unsigned int tx_mask, unsigned int rx_mask,
+		int slots, int slot_width)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	unsigned int set_mask, clear_mask, slots_active;
+
+	/* Only 16 bit slot width is supported at the moment in TDM mode */
+	if (slot_width != 16) {
+		pr_err("%s: ERROR: Unsupported slot_width %d.\n",
+			__func__, slot_width);
+		return -EINVAL;
+	}
+
+	/* Setup TDM clocking according to slot count */
+	pr_debug("%s: Slots, total: %d\n", __func__, slots);
+	clear_mask = BMASK(REG_DIGIFCONF1_IF0BITCLKOS0) |
+			BMASK(REG_DIGIFCONF1_IF0BITCLKOS1);
+	switch (slots) {
+	case 2:
+		set_mask = REG_MASK_NONE;
+		break;
+	case 4:
+		set_mask = BMASK(REG_DIGIFCONF1_IF0BITCLKOS0);
+		break;
+	case 8:
+		set_mask = BMASK(REG_DIGIFCONF1_IF0BITCLKOS1);
+		break;
+	case 16:
+		set_mask = BMASK(REG_DIGIFCONF1_IF0BITCLKOS0) |
+				BMASK(REG_DIGIFCONF1_IF0BITCLKOS1);
+		break;
+	default:
+		pr_err("%s: ERROR: Unsupported number of slots (%d)!\n", __func__, slots);
+		return -EINVAL;
+	}
+	ab8500_codec_update_reg_audio(codec, REG_DIGIFCONF1, clear_mask, set_mask);
+
+	/* Setup TDM DA according to active tx slots */
+	clear_mask = REG_DASLOTCONFX_SLTODAX_MASK;
+	slots_active = hweight32(tx_mask);
+	pr_debug("%s: Slots, active, TX: %d\n", __func__, slots_active);
+	switch (slots_active) {
+	case 0:
+		break;
+	case 1:
+		/* Slot 9 -> DA_IN1 & DA_IN3 */
+		ab8500_codec_update_reg_audio(codec, REG_DASLOTCONF1, clear_mask, 9);
+		ab8500_codec_update_reg_audio(codec, REG_DASLOTCONF3, clear_mask, 9);
+		break;
+	case 2:
+		/* Slot 9 -> DA_IN1 & DA_IN3, Slot 11 -> DA_IN2 & DA_IN4 */
+		ab8500_codec_update_reg_audio(codec, REG_DASLOTCONF1, clear_mask, 9);
+		ab8500_codec_update_reg_audio(codec, REG_DASLOTCONF3, clear_mask, 9);
+		ab8500_codec_update_reg_audio(codec, REG_DASLOTCONF2, clear_mask, 11);
+		ab8500_codec_update_reg_audio(codec, REG_DASLOTCONF4, clear_mask, 11);
+
+		break;
+	case 8:
+		pr_debug("%s: In 8-channel mode DA-from-slot mapping is set manually.", __func__);
+		break;
+	default:
+		pr_err("%s: Unsupported number of active TX-slots (%d)!\n", __func__, slots_active);
+		return -EINVAL;
+	}
+
+	/* Setup TDM AD according to active RX-slots */
+	slots_active = hweight32(rx_mask);
+	pr_debug("%s: Slots, active, RX: %d\n", __func__, slots_active);
+	switch (slots_active) {
+	case 0:
+		break;
+	case 1:
+		/* AD_OUT3 -> slot 0 & 1 */
+		ab8500_codec_update_reg_audio(codec, REG_ADSLOTSEL1,
+			REG_MASK_ALL,
+			REG_ADSLOTSELX_AD_OUT3_TO_SLOT_EVEN |
+			REG_ADSLOTSELX_AD_OUT3_TO_SLOT_ODD);
+		break;
+	case 2:
+		/* AD_OUT3 -> slot 0, AD_OUT2 -> slot 1 */
+		ab8500_codec_update_reg_audio(codec, REG_ADSLOTSEL1,
+			REG_MASK_ALL,
+			REG_ADSLOTSELX_AD_OUT3_TO_SLOT_EVEN |
+			REG_ADSLOTSELX_AD_OUT2_TO_SLOT_ODD);
+		break;
+	case 8:
+		pr_debug("%s: In 8-channel mode AD-to-slot mapping is set manually.", __func__);
+		break;
+	default:
+		pr_err("%s: Unsupported number of active RX-slots (%d)!\n", __func__, slots_active);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+struct snd_soc_dai_driver ab8500_codec_dai[] = {
+	{
+		.name = "ab8500-codec-dai.0",
+		.id = 0,
+		.playback = {
+			.stream_name = "ab8500_0p",
+			.channels_min = 1,
+			.channels_max = 8,
+			.rates = AB8500_SUPPORTED_RATE,
+			.formats = AB8500_SUPPORTED_FMT,
+		},
+		.ops = (struct snd_soc_dai_ops[]) {
+			{
+				.startup = ab8500_codec_pcm_startup,
+				.prepare = ab8500_codec_pcm_prepare,
+				.hw_params = ab8500_codec_pcm_hw_params,
+				.shutdown = ab8500_codec_pcm_shutdown,
+				.set_sysclk = ab8500_codec_set_dai_sysclk,
+				.set_tdm_slot = ab8500_codec_set_dai_tdm_slot,
+				.set_fmt = ab8500_codec_set_dai_fmt,
+			}
+		},
+		.symmetric_rates = 1
+	},
+	{
+		.name = "ab8500-codec-dai.1",
+		.id = 1,
+		.capture = {
+			.stream_name = "ab8500_0c",
+			.channels_min = 1,
+			.channels_max = 8,
+			.rates = AB8500_SUPPORTED_RATE,
+			.formats = AB8500_SUPPORTED_FMT,
+		},
+		.ops = (struct snd_soc_dai_ops[]) {
+			{
+				.startup = ab8500_codec_pcm_startup,
+				.prepare = ab8500_codec_pcm_prepare,
+				.hw_params = ab8500_codec_pcm_hw_params,
+				.shutdown = ab8500_codec_pcm_shutdown,
+				.set_sysclk = ab8500_codec_set_dai_sysclk,
+				.set_tdm_slot = ab8500_codec_set_dai_tdm_slot,
+				.set_fmt = ab8500_codec_set_dai_fmt,
+			}
+		},
+		.symmetric_rates = 1
+	}
+};
+
+static int ab8500_codec_probe(struct snd_soc_codec *codec)
+{
+	int i, ret;
+	u8 *cache = codec->reg_cache;
+
+	pr_debug("%s: Enter.\n", __func__);
+
+	ab8500_codec_configure_audio_macrocell(codec);
+
+	for (i = REG_AUDREV; i >= REG_POWERUP; i--)
+		ab8500_codec_write_reg_audio(codec, i, cache[i]);
+
+	/* Add controls */
+	ret = snd_soc_add_controls(codec, ab8500_snd_controls,
+			ARRAY_SIZE(ab8500_snd_controls));
+	if (ret < 0) {
+		pr_err("%s: failed to add soc controls (%d).\n",
+				__func__, ret);
+		return ret;
+	}
+
+	/* Add controls with events */
+	snd_ctl_add(codec->card->snd_card, snd_ctl_new1(&st_fir_value_control, codec));
+	snd_ctl_add(codec->card->snd_card, snd_ctl_new1(&st_fir_apply_control, codec));
+
+	/* Add DAPM-widgets */
+	ret = ab8500_codec_add_widgets(codec);
+	if (ret < 0) {
+		pr_err("%s: Failed add widgets (%d).\n", __func__, ret);
+		return ret;
+	}
+
+	ab8500_codec = codec;
+
+	return ret;
+}
+
+static int ab8500_codec_remove(struct snd_soc_codec *codec)
+{
+	snd_soc_dapm_free(&codec->dapm);
+	ab8500_codec = NULL;
+
+	return 0;
+}
+
+static int ab8500_codec_suspend(struct snd_soc_codec *codec,
+		pm_message_t state)
+{
+	pr_debug("%s Enter.\n", __func__);
+
+	return 0;
+}
+
+static int ab8500_codec_resume(struct snd_soc_codec *codec)
+{
+	pr_debug("%s Enter.\n", __func__);
+
+	return 0;
+}
+
+struct snd_soc_codec_driver ab8500_codec_driver = {
+	.probe =		ab8500_codec_probe,
+	.remove =		ab8500_codec_remove,
+	.suspend =		ab8500_codec_suspend,
+	.resume =		ab8500_codec_resume,
+	.read =			ab8500_codec_read_reg_audio,
+	.write =		ab8500_codec_write_reg_audio,
+	.reg_cache_size =	ARRAY_SIZE(ab8500_reg_cache),
+	.reg_word_size =	sizeof(u8),
+	.reg_cache_default =	ab8500_reg_cache,
+};
+
+static int __devinit ab8500_codec_driver_probe(struct platform_device *pdev)
+{
+	int err;
+
+	pr_debug("%s: Enter.\n", __func__);
+
+	pr_info("%s: Register codec.\n", __func__);
+	err = snd_soc_register_codec(&pdev->dev,
+				&ab8500_codec_driver,
+				ab8500_codec_dai,
+				ARRAY_SIZE(ab8500_codec_dai));
+
+	if (err < 0) {
+		pr_err("%s: Error: Failed to register codec (%d).\n",
+			__func__, err);
+	}
+
+	return err;
+}
+
+static int __devexit ab8500_codec_driver_remove(struct platform_device *pdev)
+{
+	pr_info("%s Enter.\n", __func__);
+
+	snd_soc_unregister_codec(&pdev->dev);
+
+	return 0;
+}
+
+static int ab8500_codec_driver_suspend(struct platform_device *pdev,
+		pm_message_t state)
+{
+	pr_debug("%s Enter.\n", __func__);
+
+	return 0;
+}
+
+static int ab8500_codec_driver_resume(struct platform_device *pdev)
+{
+	pr_debug("%s Enter.\n", __func__);
+
+	return 0;
+}
+
+static struct platform_driver ab8500_codec_platform_driver = {
+	.driver	= {
+		.name	= "ab8500-codec",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= ab8500_codec_driver_probe,
+	.remove		= __devexit_p(ab8500_codec_driver_remove),
+	.suspend	= ab8500_codec_driver_suspend,
+	.resume		= ab8500_codec_driver_resume,
+};
+
+static int __devinit ab8500_codec_platform_driver_init(void)
+{
+	int ret;
+
+	pr_info("%s: Enter.\n", __func__);
+
+	ret = platform_driver_register(&ab8500_codec_platform_driver);
+	if (ret != 0) {
+		pr_err("%s: Failed to register AB8500 platform driver (%d)!\n",
+			__func__, ret);
+	}
+
+	return ret;
+}
+
+static void __exit ab8500_codec_platform_driver_exit(void)
+{
+	pr_info("%s: Enter.\n", __func__);
+
+	platform_driver_unregister(&ab8500_codec_platform_driver);
+}
+
+module_init(ab8500_codec_platform_driver_init);
+module_exit(ab8500_codec_platform_driver_exit);
+
diff --git a/sound/soc/codecs/ab8500_audio.h b/sound/soc/codecs/ab8500_audio.h
new file mode 100644
index 0000000..ad6cd16
--- /dev/null
+++ b/sound/soc/codecs/ab8500_audio.h
@@ -0,0 +1,673 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * Author: Mikko J. Lehto <mikko.lehto@symbio.com>,
+ *         Mikko Sarmanne <mikko.sarmanne@symbio.com>,
+ *         Ola Lilja <ola.o.lilja@stericsson.com>
+ *         for ST-Ericsson.
+ *
+ * License terms:
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#ifndef AB8500_CODEC_REGISTERS_H
+#define AB8500_CODEC_REGISTERS_H
+
+#define AB8500_SUPPORTED_RATE (SNDRV_PCM_RATE_48000)
+#define AB8500_SUPPORTED_FMT (SNDRV_PCM_FMTBIT_S16_LE)
+
+extern struct snd_soc_dai_driver ab8500_codec_dai[];
+extern struct snd_soc_codec_driver soc_codec_dev_ab8500;
+
+/* Extended interface for codec-driver */
+
+void ab8500_audio_power_control(bool power_on);
+void ab8500_audio_pwm_vibra(unsigned char speed_left_pos,
+			unsigned char speed_left_neg,
+			unsigned char speed_right_pos,
+			unsigned char speed_right_neg);
+int ab8500_audio_set_word_length(struct snd_soc_dai *dai, unsigned int wl);
+int ab8500_audio_set_bit_delay(struct snd_soc_dai *dai, unsigned int delay);
+int ab8500_audio_setup_if1(struct snd_soc_codec *codec,
+			unsigned int fmt,
+			unsigned int wl,
+			unsigned int delay);
+unsigned int ab8500_audio_anc_status(void);
+int ab8500_audio_anc_configure(unsigned int req_state);
+
+enum ab8500_audio_dapm_path {
+	AB8500_AUDIO_DAPM_PATH_DMIC,
+	AB8500_AUDIO_DAPM_PATH_AMIC1,
+	AB8500_AUDIO_DAPM_PATH_AMIC2
+};
+bool ab8500_audio_dapm_path_active(enum ab8500_audio_dapm_path dapm_path);
+
+#define SOC_SINGLE_VALUE_S1R(xreg0, xcount, xmin, xmax, xinvert) \
+	((unsigned long)&(struct soc_smra_control) \
+	{ .reg = ((unsigned int[]){ xreg0 }), \
+	.rcount = 1, .count = xcount, \
+	.invert = xinvert, .min = xmin, .max = xmax})
+
+#define SOC_SINGLE_VALUE_S2R(xreg0, xreg1, xcount, xmin, xmax, xinvert) \
+	((unsigned long)&(struct soc_smra_control) \
+	{.reg = ((unsigned int[]){ xreg0, xreg1 }), \
+	.rcount = 2, .count = xcount, \
+	.min = xmin, .max = xmax, .invert = xinvert})
+
+#define SOC_SINGLE_VALUE_S4R(xreg0, xreg1, xreg2, xreg3, \
+	xcount, xmin, xmax, xinvert) \
+	((unsigned long)&(struct soc_smra_control) \
+	{.reg = ((unsigned int[]){ xreg0, xreg1, xreg2, xreg3 }), \
+	.rcount = 4, .count = xcount, \
+	.min = xmin, .max = xmax, .invert = xinvert})
+
+#define SOC_SINGLE_VALUE_S8R(xreg0, xreg1, xreg2, xreg3, \
+		xreg4, xreg5, xreg6, xreg7, xcount, xmin, xmax, xinvert) \
+	((unsigned long)&(struct soc_smra_control) \
+	{.reg = ((unsigned int[]){ xreg0, xreg1, xreg2, xreg3, \
+			xreg4, xreg5, xreg6, xreg7 }), \
+	.rcount = 8, .count = xcount, \
+	.min = xmin, .max = xmax, .invert = xinvert})
+
+#define SOC_MULTIPLE_VALUE_SA(xvalues, xcount, xmin, xmax, xinvert) \
+	((unsigned long)&(struct soc_smra_control) \
+	{.values = xvalues, .rcount = 1, .count = xcount, \
+	.min = xmin, .max = xmax, .invert = xinvert})
+
+#define SOC_ENUM_STROBE_DECL(name, xreg, xbit, xinvert, xtexts) \
+	struct soc_enum name = SOC_ENUM_DOUBLE(xreg, xbit, \
+	xinvert, 2, xtexts)
+
+/* Extended SOC macros */
+
+#define SOC_SINGLE_S1R(xname, reg0, min, max, invert) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE, \
+	.info = snd_soc_info_s, .get = snd_soc_get_smr, .put = snd_soc_put_smr, \
+	.private_value =  SOC_SINGLE_VALUE_S1R(reg0, 1, min, max, invert) }
+
+#define SOC_SINGLE_S2R(xname, reg0, reg1, min, max, invert) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE, \
+	.info = snd_soc_info_s, .get = snd_soc_get_smr, .put = snd_soc_put_smr, \
+	.private_value =  SOC_SINGLE_VALUE_S2R(reg0, reg1, 1, min, max, invert) }
+
+#define SOC_SINGLE_S4R(xname, reg0, reg1, reg2, reg3, min, max, invert) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE, \
+	.info = snd_soc_info_s, .get = snd_soc_get_smr, .put = snd_soc_put_smr, \
+	.private_value =  SOC_SINGLE_VALUE_S4R(reg0, reg1, reg2, reg3, \
+	1, min, max, invert) }
+
+#define SOC_SINGLE_S8R(xname, reg0, reg1, reg2, reg3, \
+		reg4, reg5, reg6, reg7, min, max, invert) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE, \
+	.info = snd_soc_info_s, .get = snd_soc_get_smr, .put = snd_soc_put_smr, \
+	.private_value =  SOC_SINGLE_VALUE_S4R(reg0, reg1, reg2, reg3, \
+			reg4, reg5, reg6, reg7\
+	1, min, max, invert) }
+
+#define SOC_MULTIPLE_SA(xname, values, min, max, invert) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE, \
+	.info = snd_soc_info_s, .get = snd_soc_get_sa, .put = snd_soc_put_sa, \
+	.private_value = SOC_MULTIPLE_VALUE_SA((long *)values, ARRAY_SIZE(values), \
+	min, max, invert) }
+
+#define SOC_ENUM_STROBE(xname, enum) \
+	SOC_ENUM_EXT(xname, xenum, \
+	snd_soc_get_enum_strobe, \
+	snd_soc_put_enum_strobe)
+
+/* AB8500 audio bank (0x0d) register definitions */
+
+#define REG_POWERUP		0x00
+#define REG_AUDSWRESET		0x01
+#define REG_ADPATHENA		0x02
+#define REG_DAPATHENA		0x03
+#define REG_ANACONF1		0x04
+#define REG_ANACONF2		0x05
+#define REG_DIGMICCONF		0x06
+#define REG_ANACONF3		0x07
+#define REG_ANACONF4		0x08
+#define REG_DAPATHCONF		0x09
+#define REG_MUTECONF		0x0A
+#define REG_SHORTCIRCONF	0x0B
+#define REG_ANACONF5		0x0C
+#define REG_ENVCPCONF		0x0D
+#define REG_SIGENVCONF		0x0E
+#define REG_PWMGENCONF1		0x0F
+#define REG_PWMGENCONF2		0x10
+#define REG_PWMGENCONF3		0x11
+#define REG_PWMGENCONF4		0x12
+#define REG_PWMGENCONF5		0x13
+#define REG_ANAGAIN1		0x14
+#define REG_ANAGAIN2		0x15
+#define REG_ANAGAIN3		0x16
+#define REG_ANAGAIN4		0x17
+#define REG_DIGLINHSLGAIN	0x18
+#define REG_DIGLINHSRGAIN	0x19
+#define REG_ADFILTCONF		0x1A
+#define REG_DIGIFCONF1		0x1B
+#define REG_DIGIFCONF2		0x1C
+#define REG_DIGIFCONF3		0x1D
+#define REG_DIGIFCONF4		0x1E
+#define REG_ADSLOTSEL1		0x1F
+#define REG_ADSLOTSEL2		0x20
+#define REG_ADSLOTSEL3		0x21
+#define REG_ADSLOTSEL4		0x22
+#define REG_ADSLOTSEL5		0x23
+#define REG_ADSLOTSEL6		0x24
+#define REG_ADSLOTSEL7		0x25
+#define REG_ADSLOTSEL8		0x26
+#define REG_ADSLOTSEL9		0x27
+#define REG_ADSLOTSEL10		0x28
+#define REG_ADSLOTSEL11		0x29
+#define REG_ADSLOTSEL12		0x2A
+#define REG_ADSLOTSEL13		0x2B
+#define REG_ADSLOTSEL14		0x2C
+#define REG_ADSLOTSEL15		0x2D
+#define REG_ADSLOTSEL16		0x2E
+#define REG_ADSLOTHIZCTRL1	0x2F
+#define REG_ADSLOTHIZCTRL2	0x30
+#define REG_ADSLOTHIZCTRL3	0x31
+#define REG_ADSLOTHIZCTRL4	0x32
+#define REG_DASLOTCONF1		0x33
+#define REG_DASLOTCONF2		0x34
+#define REG_DASLOTCONF3		0x35
+#define REG_DASLOTCONF4		0x36
+#define REG_DASLOTCONF5		0x37
+#define REG_DASLOTCONF6		0x38
+#define REG_DASLOTCONF7		0x39
+#define REG_DASLOTCONF8		0x3A
+#define REG_CLASSDCONF1		0x3B
+#define REG_CLASSDCONF2		0x3C
+#define REG_CLASSDCONF3		0x3D
+#define REG_DMICFILTCONF	0x3E
+#define REG_DIGMULTCONF1	0x3F
+#define REG_DIGMULTCONF2	0x40
+#define REG_ADDIGGAIN1		0x41
+#define REG_ADDIGGAIN2		0x42
+#define REG_ADDIGGAIN3		0x43
+#define REG_ADDIGGAIN4		0x44
+#define REG_ADDIGGAIN5		0x45
+#define REG_ADDIGGAIN6		0x46
+#define REG_DADIGGAIN1		0x47
+#define REG_DADIGGAIN2		0x48
+#define REG_DADIGGAIN3		0x49
+#define REG_DADIGGAIN4		0x4A
+#define REG_DADIGGAIN5		0x4B
+#define REG_DADIGGAIN6		0x4C
+#define REG_ADDIGLOOPGAIN1	0x4D
+#define REG_ADDIGLOOPGAIN2	0x4E
+#define REG_HSLEARDIGGAIN	0x4F
+#define REG_HSRDIGGAIN		0x50
+#define REG_SIDFIRGAIN1		0x51
+#define REG_SIDFIRGAIN2		0x52
+#define REG_ANCCONF1		0x53
+#define REG_ANCCONF2		0x54
+#define REG_ANCCONF3		0x55
+#define REG_ANCCONF4		0x56
+#define REG_ANCCONF5		0x57
+#define REG_ANCCONF6		0x58
+#define REG_ANCCONF7		0x59
+#define REG_ANCCONF8		0x5A
+#define REG_ANCCONF9		0x5B
+#define REG_ANCCONF10		0x5C
+#define REG_ANCCONF11		0x5D
+#define REG_ANCCONF12		0x5E
+#define REG_ANCCONF13		0x5F
+#define REG_ANCCONF14		0x60
+#define REG_SIDFIRADR		0x61
+#define REG_SIDFIRCOEF1		0x62
+#define REG_SIDFIRCOEF2		0x63
+#define REG_SIDFIRCONF		0x64
+#define REG_AUDINTMASK1		0x65
+#define REG_AUDINTSOURCE1	0x66
+#define REG_AUDINTMASK2		0x67
+#define REG_AUDINTSOURCE2	0x68
+#define REG_FIFOCONF1		0x69
+#define REG_FIFOCONF2		0x6A
+#define REG_FIFOCONF3		0x6B
+#define REG_FIFOCONF4		0x6C
+#define REG_FIFOCONF5		0x6D
+#define REG_FIFOCONF6		0x6E
+#define REG_AUDREV		0x6F
+
+#define AB8500_FIRST_REG	REG_POWERUP
+#define AB8500_LAST_REG		REG_AUDREV
+#define AB8500_CACHEREGNUM	(AB8500_LAST_REG + 1)
+
+
+#define REG_MASK_ALL				0xFF
+#define REG_MASK_NONE				0x00
+
+/* REG_POWERUP */
+#define REG_POWERUP_POWERUP			7
+#define REG_POWERUP_ENANA			3
+
+/* REG_AUDSWRESET */
+#define REG_AUDSWRESET_SWRESET			7
+
+/* REG_ADPATHENA */
+#define REG_ADPATHENA_ENAD12			7
+#define REG_ADPATHENA_ENAD34			5
+#define REG_ADPATHENA_ENAD5768			3
+
+/* REG_DAPATHENA */
+#define REG_DAPATHENA_ENDA1			7
+#define REG_DAPATHENA_ENDA2			6
+#define REG_DAPATHENA_ENDA3			5
+#define REG_DAPATHENA_ENDA4			4
+#define REG_DAPATHENA_ENDA5			3
+#define REG_DAPATHENA_ENDA6			2
+
+/* REG_ANACONF1 */
+#define REG_ANACONF1_HSLOWPOW			7
+#define REG_ANACONF1_DACLOWPOW1			6
+#define REG_ANACONF1_DACLOWPOW0			5
+#define REG_ANACONF1_EARDACLOWPOW		4
+#define REG_ANACONF1_EARSELCM			2
+#define REG_ANACONF1_HSHPEN			1
+#define REG_ANACONF1_EARDRVLOWPOW		0
+
+/* REG_ANACONF2 */
+#define REG_ANACONF2_ENMIC1			7
+#define REG_ANACONF2_ENMIC2			6
+#define REG_ANACONF2_ENLINL			5
+#define REG_ANACONF2_ENLINR			4
+#define REG_ANACONF2_MUTMIC1			3
+#define REG_ANACONF2_MUTMIC2			2
+#define REG_ANACONF2_MUTLINL			1
+#define REG_ANACONF2_MUTLINR			0
+
+/* REG_DIGMICCONF */
+#define REG_DIGMICCONF_ENDMIC1			7
+#define REG_DIGMICCONF_ENDMIC2			6
+#define REG_DIGMICCONF_ENDMIC3			5
+#define REG_DIGMICCONF_ENDMIC4			4
+#define REG_DIGMICCONF_ENDMIC5			3
+#define REG_DIGMICCONF_ENDMIC6			2
+#define REG_DIGMICCONF_HSFADSPEED		0
+
+/* REG_ANACONF3 */
+#define REG_ANACONF3_MIC1SEL			7
+#define REG_ANACONF3_LINRSEL			6
+#define REG_ANACONF3_ENDRVHSL			5
+#define REG_ANACONF3_ENDRVHSR			4
+#define REG_ANACONF3_ENADCMIC			2
+#define REG_ANACONF3_ENADCLINL			1
+#define REG_ANACONF3_ENADCLINR			0
+
+/* REG_ANACONF4 */
+#define REG_ANACONF4_DISPDVSS			7
+#define REG_ANACONF4_ENEAR			6
+#define REG_ANACONF4_ENHSL			5
+#define REG_ANACONF4_ENHSR			4
+#define REG_ANACONF4_ENHFL			3
+#define REG_ANACONF4_ENHFR			2
+#define REG_ANACONF4_ENVIB1			1
+#define REG_ANACONF4_ENVIB2			0
+
+/* REG_DAPATHCONF */
+#define REG_DAPATHCONF_ENDACEAR			6
+#define REG_DAPATHCONF_ENDACHSL			5
+#define REG_DAPATHCONF_ENDACHSR			4
+#define REG_DAPATHCONF_ENDACHFL			3
+#define REG_DAPATHCONF_ENDACHFR			2
+#define REG_DAPATHCONF_ENDACVIB1		1
+#define REG_DAPATHCONF_ENDACVIB2		0
+
+/* REG_MUTECONF */
+#define REG_MUTECONF_MUTEAR			6
+#define REG_MUTECONF_MUTHSL			5
+#define REG_MUTECONF_MUTHSR			4
+#define REG_MUTECONF_MUTDACEAR			2
+#define REG_MUTECONF_MUTDACHSL			1
+#define REG_MUTECONF_MUTDACHSR			0
+
+
+/* REG_SHORTCIRCONF */
+
+/* REG_ANACONF5 */
+#define REG_ANACONF5_ENCPHS			7
+#define REG_ANACONF5_HSLDACTOLOL		5
+#define REG_ANACONF5_HSRDACTOLOR		4
+#define REG_ANACONF5_ENLOL			3
+#define REG_ANACONF5_ENLOR			2
+#define REG_ANACONF5_HSAUTOEN			0
+
+/* REG_ENVCPCONF */
+#define REG_ENVCPCONF_ENVDETHTHRE		4
+#define REG_ENVCPCONF_ENVDETLTHRE		0
+#define REG_ENVCPCONF_ENVDETHTHRE_MAX		0x0F
+#define REG_ENVCPCONF_ENVDETLTHRE_MAX		0x0F
+
+/* REG_SIGENVCONF */
+#define REG_SIGENVCONF_CPLVEN			5
+#define REG_SIGENVCONF_ENVDETCPEN		4
+#define REG_SIGENVCONF_ENVDETTIME		0
+#define REG_SIGENVCONF_ENVDETTIME_MAX		0x0F
+
+/* REG_PWMGENCONF1 */
+#define REG_PWMGENCONF1_PWMTOVIB1		7
+#define REG_PWMGENCONF1_PWMTOVIB2		6
+#define REG_PWMGENCONF1_PWM1CTRL		5
+#define REG_PWMGENCONF1_PWM2CTRL		4
+#define REG_PWMGENCONF1_PWM1NCTRL		3
+#define REG_PWMGENCONF1_PWM1PCTRL		2
+#define REG_PWMGENCONF1_PWM2NCTRL		1
+#define REG_PWMGENCONF1_PWM2PCTRL		0
+
+/* REG_PWMGENCONF2 */
+/* REG_PWMGENCONF3 */
+/* REG_PWMGENCONF4 */
+/* REG_PWMGENCONF5 */
+#define REG_PWMGENCONFX_PWMVIBXPOL		7
+#define REG_PWMGENCONFX_PWMVIBXDUTCYC		0
+#define REG_PWMGENCONFX_PWMVIBXDUTCYC_MAX	0x64
+
+/* REG_ANAGAIN1 */
+/* REG_ANAGAIN2 */
+#define REG_ANAGAINX_ENSEMICX			7
+#define REG_ANAGAINX_LOWPOWMICX			6
+#define REG_ANAGAINX_MICXGAIN			0
+#define REG_ANAGAINX_MICXGAIN_MAX		0x1F
+
+/* REG_ANAGAIN3 */
+#define REG_ANAGAIN3_HSLGAIN			4
+#define REG_ANAGAIN3_HSRGAIN			0
+#define REG_ANAGAIN3_HSXGAIN_MAX		0x0F
+
+/* REG_ANAGAIN4 */
+#define REG_ANAGAIN4_LINLGAIN			4
+#define REG_ANAGAIN4_LINRGAIN			0
+#define REG_ANAGAIN4_LINXGAIN_MAX		0x0F
+
+/* REG_DIGLINHSLGAIN */
+/* REG_DIGLINHSRGAIN */
+#define REG_DIGLINHSXGAIN_LINTOHSXGAIN		0
+#define REG_DIGLINHSXGAIN_LINTOHSXGAIN_MAX	0x13
+
+/* REG_ADFILTCONF */
+#define REG_ADFILTCONF_AD1NH			7
+#define REG_ADFILTCONF_AD2NH			6
+#define REG_ADFILTCONF_AD3NH			5
+#define REG_ADFILTCONF_AD4NH			4
+#define REG_ADFILTCONF_AD1VOICE			3
+#define REG_ADFILTCONF_AD2VOICE			2
+#define REG_ADFILTCONF_AD3VOICE			1
+#define REG_ADFILTCONF_AD4VOICE			0
+
+/* REG_DIGIFCONF1 */
+#define REG_DIGIFCONF1_ENMASTGEN		7
+#define REG_DIGIFCONF1_IF1BITCLKOS1		6
+#define REG_DIGIFCONF1_IF1BITCLKOS0		5
+#define REG_DIGIFCONF1_ENFSBITCLK1		4
+#define REG_DIGIFCONF1_IF0BITCLKOS1		2
+#define REG_DIGIFCONF1_IF0BITCLKOS0		1
+#define REG_DIGIFCONF1_ENFSBITCLK0		0
+
+/* REG_DIGIFCONF2 */
+#define REG_DIGIFCONF2_FSYNC0P			6
+#define REG_DIGIFCONF2_BITCLK0P			5
+#define REG_DIGIFCONF2_IF0DEL			4
+#define REG_DIGIFCONF2_IF0FORMAT1		3
+#define REG_DIGIFCONF2_IF0FORMAT0		2
+#define REG_DIGIFCONF2_IF0WL1			1
+#define REG_DIGIFCONF2_IF0WL0			0
+
+/* REG_DIGIFCONF3 */
+#define REG_DIGIFCONF3_IF0DATOIF1AD		7
+#define REG_DIGIFCONF3_IF0CLKTOIF1CLK		6
+#define REG_DIGIFCONF3_IF1MASTER		5
+#define REG_DIGIFCONF3_IF1DATOIF0AD		3
+#define REG_DIGIFCONF3_IF1CLKTOIF0CLK		2
+#define REG_DIGIFCONF3_IF0MASTER		1
+#define REG_DIGIFCONF3_IF0BFIFOEN		0
+
+/* REG_DIGIFCONF4 */
+#define REG_DIGIFCONF4_FSYNC1P			6
+#define REG_DIGIFCONF4_BITCLK1P			5
+#define REG_DIGIFCONF4_IF1DEL			4
+#define REG_DIGIFCONF4_IF1FORMAT1		3
+#define REG_DIGIFCONF4_IF1FORMAT0		2
+#define REG_DIGIFCONF4_IF1WL1			1
+#define REG_DIGIFCONF4_IF1WL0			0
+
+/* REG_ADSLOTSELX */
+#define REG_ADSLOTSELX_AD_OUT1_TO_SLOT_ODD	0x00
+#define REG_ADSLOTSELX_AD_OUT2_TO_SLOT_ODD	0x01
+#define REG_ADSLOTSELX_AD_OUT3_TO_SLOT_ODD	0x02
+#define REG_ADSLOTSELX_AD_OUT4_TO_SLOT_ODD	0x03
+#define REG_ADSLOTSELX_AD_OUT5_TO_SLOT_ODD	0x04
+#define REG_ADSLOTSELX_AD_OUT6_TO_SLOT_ODD	0x05
+#define REG_ADSLOTSELX_AD_OUT7_TO_SLOT_ODD	0x06
+#define REG_ADSLOTSELX_AD_OUT8_TO_SLOT_ODD	0x07
+#define REG_ADSLOTSELX_ZEROES_TO_SLOT_ODD	0x08
+#define REG_ADSLOTSELX_TRISTATE_TO_SLOT_ODD	0x0F
+#define REG_ADSLOTSELX_AD_OUT1_TO_SLOT_EVEN	0x00
+#define REG_ADSLOTSELX_AD_OUT2_TO_SLOT_EVEN	0x10
+#define REG_ADSLOTSELX_AD_OUT3_TO_SLOT_EVEN	0x20
+#define REG_ADSLOTSELX_AD_OUT4_TO_SLOT_EVEN	0x30
+#define REG_ADSLOTSELX_AD_OUT5_TO_SLOT_EVEN	0x40
+#define REG_ADSLOTSELX_AD_OUT6_TO_SLOT_EVEN	0x50
+#define REG_ADSLOTSELX_AD_OUT7_TO_SLOT_EVEN	0x60
+#define REG_ADSLOTSELX_AD_OUT8_TO_SLOT_EVEN	0x70
+#define REG_ADSLOTSELX_ZEROES_TO_SLOT_EVEN	0x80
+#define REG_ADSLOTSELX_TRISTATE_TO_SLOT_EVEN	0xF0
+#define REG_ADSLOTSELX_EVEN_SHIFT		0
+#define REG_ADSLOTSELX_ODD_SHIFT		4
+
+/* REG_ADSLOTHIZCTRL1 */
+/* REG_ADSLOTHIZCTRL2 */
+/* REG_ADSLOTHIZCTRL3 */
+/* REG_ADSLOTHIZCTRL4 */
+/* REG_DASLOTCONF1 */
+#define REG_DASLOTCONF1_DA12VOICE		7
+#define REG_DASLOTCONF1_SWAPDA12_34		6
+#define REG_DASLOTCONF1_DAI7TOADO1		5
+
+/* REG_DASLOTCONF2 */
+#define REG_DASLOTCONF2_DAI8TOADO2		5
+
+/* REG_DASLOTCONF3 */
+#define REG_DASLOTCONF3_DA34VOICE		7
+#define REG_DASLOTCONF3_DAI7TOADO3		5
+
+/* REG_DASLOTCONF4 */
+#define REG_DASLOTCONF4_DAI8TOADO4		5
+
+/* REG_DASLOTCONF5 */
+#define REG_DASLOTCONF5_DA56VOICE		7
+#define REG_DASLOTCONF5_DAI7TOADO5		5
+
+/* REG_DASLOTCONF6 */
+#define REG_DASLOTCONF6_DAI8TOADO6		5
+
+/* REG_DASLOTCONF7 */
+#define REG_DASLOTCONF7_DAI8TOADO7		5
+
+/* REG_DASLOTCONF8 */
+#define REG_DASLOTCONF8_DAI7TOADO8		5
+
+#define REG_DASLOTCONFX_SLTODAX_SHIFT		0
+#define REG_DASLOTCONFX_SLTODAX_MASK		0x1F
+
+/* REG_CLASSDCONF1 */
+#define REG_CLASSDCONF1_PARLHF			7
+#define REG_CLASSDCONF1_PARLVIB			6
+#define REG_CLASSDCONF1_VIB1SWAPEN		3
+#define REG_CLASSDCONF1_VIB2SWAPEN		2
+#define REG_CLASSDCONF1_HFLSWAPEN		1
+#define REG_CLASSDCONF1_HFRSWAPEN		0
+
+/* REG_CLASSDCONF2 */
+#define REG_CLASSDCONF2_FIRBYP3			7
+#define REG_CLASSDCONF2_FIRBYP2			6
+#define REG_CLASSDCONF2_FIRBYP1			5
+#define REG_CLASSDCONF2_FIRBYP0			4
+#define REG_CLASSDCONF2_HIGHVOLEN3		3
+#define REG_CLASSDCONF2_HIGHVOLEN2		2
+#define REG_CLASSDCONF2_HIGHVOLEN1		1
+#define REG_CLASSDCONF2_HIGHVOLEN0		0
+
+/* REG_CLASSDCONF3 */
+#define REG_CLASSDCONF3_DITHHPGAIN		4
+#define REG_CLASSDCONF3_DITHHPGAIN_MAX		0x0A
+#define REG_CLASSDCONF3_DITHWGAIN		0
+#define REG_CLASSDCONF3_DITHWGAIN_MAX		0x0A
+
+/* REG_DMICFILTCONF */
+#define REG_DMICFILTCONF_ANCINSEL		7
+#define REG_DMICFILTCONF_DA3TOEAR		6
+#define REG_DMICFILTCONF_DMIC1SINC3		5
+#define REG_DMICFILTCONF_DMIC2SINC3		4
+#define REG_DMICFILTCONF_DMIC3SINC3		3
+#define REG_DMICFILTCONF_DMIC4SINC3		2
+#define REG_DMICFILTCONF_DMIC5SINC3		1
+#define REG_DMICFILTCONF_DMIC6SINC3		0
+
+/* REG_DIGMULTCONF1 */
+#define REG_DIGMULTCONF1_DATOHSLEN		7
+#define REG_DIGMULTCONF1_DATOHSREN		6
+#define REG_DIGMULTCONF1_AD1SEL			5
+#define REG_DIGMULTCONF1_AD2SEL			4
+#define REG_DIGMULTCONF1_AD3SEL			3
+#define REG_DIGMULTCONF1_AD5SEL			2
+#define REG_DIGMULTCONF1_AD6SEL			1
+#define REG_DIGMULTCONF1_ANCSEL			0
+
+/* REG_DIGMULTCONF2 */
+#define REG_DIGMULTCONF2_DATOHFREN		7
+#define REG_DIGMULTCONF2_DATOHFLEN		6
+#define REG_DIGMULTCONF2_HFRSEL			5
+#define REG_DIGMULTCONF2_HFLSEL			4
+#define REG_DIGMULTCONF2_FIRSID1SEL		2
+#define REG_DIGMULTCONF2_FIRSID2SEL		0
+
+/* REG_ADDIGGAIN1 */
+/* REG_ADDIGGAIN2 */
+/* REG_ADDIGGAIN3 */
+/* REG_ADDIGGAIN4 */
+/* REG_ADDIGGAIN5 */
+/* REG_ADDIGGAIN6 */
+#define REG_ADDIGGAINX_FADEDISADX		6
+#define REG_ADDIGGAINX_ADXGAIN_MAX		0x3F
+
+/* REG_DADIGGAIN1 */
+/* REG_DADIGGAIN2 */
+/* REG_DADIGGAIN3 */
+/* REG_DADIGGAIN4 */
+/* REG_DADIGGAIN5 */
+/* REG_DADIGGAIN6 */
+#define REG_DADIGGAINX_FADEDISDAX		6
+#define REG_DADIGGAINX_DAXGAIN_MAX		0x3F
+
+/* REG_ADDIGLOOPGAIN1 */
+/* REG_ADDIGLOOPGAIN2 */
+#define REG_ADDIGLOOPGAINX_FADEDISADXL		6
+#define REG_ADDIGLOOPGAINX_ADXLBGAIN_MAX	0x3F
+
+/* REG_HSLEARDIGGAIN */
+#define REG_HSLEARDIGGAIN_HSSINC1		7
+#define REG_HSLEARDIGGAIN_FADEDISHSL		4
+#define REG_HSLEARDIGGAIN_HSLDGAIN_MAX		0x09
+
+/* REG_HSRDIGGAIN */
+#define REG_HSRDIGGAIN_FADESPEED		6
+#define REG_HSRDIGGAIN_FADEDISHSR		4
+#define REG_HSRDIGGAIN_HSRDGAIN_MAX		0x09
+
+/* REG_SIDFIRGAIN1 */
+/* REG_SIDFIRGAIN2 */
+#define REG_SIDFIRGAINX_FIRSIDXGAIN_MAX		0x1F
+
+/* REG_ANCCONF1 */
+#define REG_ANCCONF1_ANCIIRUPDATE		3
+#define REG_ANCCONF1_ENANC			2
+#define REG_ANCCONF1_ANCIIRINIT			1
+#define REG_ANCCONF1_ANCFIRUPDATE		0
+
+/* REG_ANCCONF2 */
+#define REG_ANCCONF2_VALUE_MIN			-0x10
+#define REG_ANCCONF2_VALUE_MAX			0x0F
+/* REG_ANCCONF3 */
+#define REG_ANCCONF3_VALUE_MIN			-0x10
+#define REG_ANCCONF3_VALUE_MAX			0x0F
+/* REG_ANCCONF4 */
+#define REG_ANCCONF4_VALUE_MIN			-0x10
+#define REG_ANCCONF4_VALUE_MAX			0x0F
+/* REG_ANC_FIR_COEFFS */
+#define REG_ANC_FIR_COEFF_MIN			-0x8000
+#define REG_ANC_FIR_COEFF_MAX			0x7FFF
+#define REG_ANC_FIR_COEFFS			0xF
+/* REG_ANC_IIR_COEFFS */
+#define REG_ANC_IIR_COEFF_MIN			-0x800000
+#define REG_ANC_IIR_COEFF_MAX			0x7FFFFF
+#define REG_ANC_IIR_COEFFS			0x18
+/* REG_ANC_WARP_DELAY */
+#define REG_ANC_WARP_DELAY_MIN			0x0000
+#define REG_ANC_WARP_DELAY_MAX			0xFFFF
+/* REG_ANCCONF11 */
+/* REG_ANCCONF12 */
+/* REG_ANCCONF13 */
+/* REG_ANCCONF14 */
+
+/* REG_SIDFIRADR */
+#define REG_SIDFIRADR_FIRSIDSET			7
+#define REG_SIDFIRADR_ADDRESS_SHIFT		0
+#define REG_SIDFIRADR_ADDRESS_MAX		0x7F
+
+/* REG_SIDFIRCOEF1 */
+/* REG_SIDFIRCOEF2 */
+#define REG_SIDFIRCOEFX_VALUE_SHIFT		0
+#define REG_SIDFIRCOEFX_VALUE_MAX		0xFF
+
+/* REG_SIDFIRCONF */
+#define REG_SIDFIRCONF_ENFIRSIDS		2
+#define REG_SIDFIRCONF_FIRSIDSTOIF1		1
+#define REG_SIDFIRCONF_FIRSIDBUSY		0
+
+/* REG_AUDINTMASK1 */
+/* REG_AUDINTSOURCE1 */
+/* REG_AUDINTMASK2 */
+/* REG_AUDINTSOURCE2 */
+
+/* REG_FIFOCONF1 */
+#define REG_FIFOCONF1_BFIFOMASK			0x80
+#define REG_FIFOCONF1_BFIFO19M2			0x40
+#define REG_FIFOCONF1_BFIFOINT_SHIFT		0
+#define REG_FIFOCONF1_BFIFOINT_MAX		0x3F
+
+/* REG_FIFOCONF2 */
+#define REG_FIFOCONF2_BFIFOTX_SHIFT		0
+#define REG_FIFOCONF2_BFIFOTX_MAX		0xFF
+
+/* REG_FIFOCONF3 */
+#define REG_FIFOCONF3_BFIFOEXSL_SHIFT		5
+#define REG_FIFOCONF3_BFIFOEXSL_MAX		0x5
+#define REG_FIFOCONF3_PREBITCLK0_SHIFT		2
+#define REG_FIFOCONF3_PREBITCLK0_MAX		0x7
+#define REG_FIFOCONF3_BFIFOMAST_SHIFT		1
+#define REG_FIFOCONF3_BFIFORUN_SHIFT		0
+
+/* REG_FIFOCONF4 */
+#define REG_FIFOCONF4_BFIFOFRAMSW_SHIFT		0
+#define REG_FIFOCONF4_BFIFOFRAMSW_MAX		0xFF
+
+/* REG_FIFOCONF5 */
+#define REG_FIFOCONF5_BFIFOWAKEUP_SHIFT		0
+#define REG_FIFOCONF5_BFIFOWAKEUP_MAX		0xFF
+
+/* REG_FIFOCONF6 */
+#define REG_FIFOCONF6_BFIFOSAMPLE_SHIFT		0
+#define REG_FIFOCONF6_BFIFOSAMPLE_MAX		0xFF
+
+/* REG_AUDREV */
+
+#endif
diff --git a/sound/soc/ux500/Kconfig b/sound/soc/ux500/Kconfig
new file mode 100644
index 0000000..bcf1ff8
--- /dev/null
+++ b/sound/soc/ux500/Kconfig
@@ -0,0 +1,33 @@
+#
+# Ux500 SoC audio configuration
+#
+
+menuconfig SND_SOC_UX500
+	bool "SoC Audio support for Ux500 platform"
+	depends on SND_SOC
+	default n
+	help
+		Say Y if you want to add support for the Ux500 platform.
+
+choice
+	prompt "Ux500 Platform"
+	depends on SND_SOC_UX500
+	default SND_SOC_U8500
+	config SND_SOC_U8500
+	bool "Platform - U8500"
+endchoice
+
+config SND_SOC_UX500_AB8500
+	bool "Codec - AB8500"
+	depends on SND_SOC_UX500 && UX500_SOC_DB8500 && AB8500_CORE && AB8500_GPADC
+	select SND_SOC_AB8500
+	default n
+	help
+	   Select this to enable support for AB8500 in the Ux500 machine-driver.
+
+config SND_SOC_UX500_DEBUG
+	bool "Activate Ux500 platform debug-mode (pr_debug)"
+	depends on SND_SOC_UX500
+	default n
+	help
+		Say Y if you want to add debug level prints for Ux500 code-files.
diff --git a/sound/soc/ux500/Makefile b/sound/soc/ux500/Makefile
new file mode 100644
index 0000000..eeb86f6
--- /dev/null
+++ b/sound/soc/ux500/Makefile
@@ -0,0 +1,25 @@
+# Ux500 Platform Support
+
+ifdef CONFIG_SND_SOC_UX500_DEBUG
+CFLAGS_u8500.o := -DDEBUG
+CFLAGS_ux500_pcm.o := -DDEBUG
+CFLAGS_ux500_msp_dai.o := -DDEBUG
+CFLAGS_ux500_ab8500.o := -DDEBUG
+CFLAGS_ux500_msp_i2s.o := -DDEBUG
+endif
+
+ifdef CONFIG_UX500_SOC_DB8500
+snd-soc-ux500-platform-objs := ux500_pcm.o ux500_msp_dai.o ux500_msp_i2s.o
+obj-y += snd-soc-ux500-platform.o
+endif
+
+ifdef CONFIG_SND_SOC_UX500_AB8500
+snd-soc-ux500-machine-objs += ux500_ab8500.o
+endif
+
+obj-y += snd-soc-ux500-machine.o
+
+ifdef CONFIG_UX500_SOC_DB8500
+snd-soc-u8500-objs := u8500.o
+obj-y += snd-soc-u8500.o
+endif
diff --git a/sound/soc/ux500/u8500.c b/sound/soc/ux500/u8500.c
new file mode 100644
index 0000000..7a5c61d
--- /dev/null
+++ b/sound/soc/ux500/u8500.c
@@ -0,0 +1,150 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * Author: Ola Lilja (ola.o.lilja@stericsson.com)
+ *         for ST-Ericsson.
+ *
+ * License terms:
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include <asm/mach-types.h>
+
+#include <linux/io.h>
+#include <linux/spi/spi.h>
+
+#include <sound/soc.h>
+#include <sound/initval.h>
+
+#include "ux500_pcm.h"
+#include "ux500_msp_dai.h"
+
+#ifdef CONFIG_SND_SOC_UX500_AB8500
+#include <sound/ux500_ab8500.h>
+#endif
+
+static struct platform_device *u8500_platform_dev;
+
+/* Create dummy devices for platform drivers */
+
+static struct platform_device ux500_pcm = {
+		.name = "ux500-pcm",
+		.id = 0,
+		.dev = {
+			.platform_data = NULL,
+		},
+};
+
+/* Define the whole U8500 soundcard, linking platform to the codec-drivers  */
+struct snd_soc_dai_link u8500_dai_links[] = {
+	#ifdef CONFIG_SND_SOC_UX500_AB8500
+	{
+	.name = "ab8500_0",
+	.stream_name = "ab8500_0",
+	.cpu_dai_name = "ux500-msp-i2s.1",
+	.codec_dai_name = "ab8500-codec-dai.0",
+	.platform_name = "ux500-pcm.0",
+	.codec_name = "ab8500-codec.0",
+	.init = ux500_ab8500_machine_codec_init,
+	.ops = ux500_ab8500_ops,
+	},
+	{
+	.name = "ab8500_1",
+	.stream_name = "ab8500_1",
+	.cpu_dai_name = "ux500-msp-i2s.3",
+	.codec_dai_name = "ab8500-codec-dai.1",
+	.platform_name = "ux500-pcm.0",
+	.codec_name = "ab8500-codec.0",
+	.init = NULL,
+	.ops = ux500_ab8500_ops,
+	},
+	#endif
+};
+
+static struct snd_soc_card u8500_drvdata = {
+	.name = "U8500-card",
+	.probe = NULL,
+	.dai_link = u8500_dai_links,
+	.num_links = ARRAY_SIZE(u8500_dai_links),
+};
+
+static int __init u8500_soc_init(void)
+{
+	int ret;
+
+	pr_debug("%s: Enter.\n", __func__);
+
+	#ifdef CONFIG_SND_SOC_UX500_AB8500
+	pr_debug("%s: Calling init-function for AB8500 machine driver.\n",
+		__func__);
+	ret = ux500_ab8500_soc_machine_drv_init();
+	if (ret)
+		pr_err("%s: ux500_ab8500_soc_machine_drv_init failed (%d).\n",
+			__func__, ret);
+	#endif
+
+	pr_debug("%s: Register device to generate a probe for Ux500-pcm platform.\n",
+		__func__);
+	platform_device_register(&ux500_pcm);
+
+	pr_debug("%s: Allocate platform device 'soc-audio'.\n",
+		__func__);
+	u8500_platform_dev = platform_device_alloc("soc-audio", -1);
+	if (!u8500_platform_dev)
+		return -ENOMEM;
+
+	pr_debug("%s: Card %s: num_links = %d\n",
+		__func__,
+		u8500_drvdata.name,
+		u8500_drvdata.num_links);
+	pr_debug("%s: Card %s: DAI-link 0: name = %s\n",
+		__func__,
+		u8500_drvdata.name,
+		u8500_drvdata.dai_link[0].name);
+	pr_debug("%s: Card %s: DAI-link 0: stream_name = %s\n",
+		__func__,
+		u8500_drvdata.name,
+		u8500_drvdata.dai_link[0].stream_name);
+
+	pr_debug("%s: Card %s: Set platform drvdata.\n",
+		__func__,
+		u8500_drvdata.name);
+	platform_set_drvdata(u8500_platform_dev, &u8500_drvdata);
+	u8500_drvdata.dev = &u8500_platform_dev->dev;
+
+	pr_debug("%s: Card %s: Add platform device.\n",
+		__func__,
+		u8500_drvdata.name);
+	ret = platform_device_add(u8500_platform_dev);
+	if (ret) {
+		pr_err("%s: Error: Failed to add platform device (%s).\n",
+			__func__,
+			u8500_drvdata.name);
+		platform_device_put(u8500_platform_dev);
+	}
+
+	return ret;
+}
+
+static void __exit u8500_soc_exit(void)
+{
+	pr_debug("%s: Enter.\n", __func__);
+
+	#ifdef CONFIG_SND_SOC_UX500_AB8500
+	pr_debug("%s: Calling exit-function for AB8500 machine driver.\n",
+		__func__);
+	ux500_ab8500_soc_machine_drv_cleanup();
+	#endif
+
+	pr_debug("%s: Unregister platform device (%s).\n",
+		__func__,
+		u8500_drvdata.name);
+	platform_device_unregister(u8500_platform_dev);
+}
+
+module_init(u8500_soc_init);
+module_exit(u8500_soc_exit);
+
diff --git a/sound/soc/ux500/ux500_ab8500.c b/sound/soc/ux500/ux500_ab8500.c
new file mode 100644
index 0000000..e507f93
--- /dev/null
+++ b/sound/soc/ux500/ux500_ab8500.c
@@ -0,0 +1,790 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * Author: Mikko J. Lehto <mikko.lehto@symbio.com>,
+ *         Mikko Sarmanne <mikko.sarmanne@symbio.com>,
+ *         Jarmo K. Kuronen <jarmo.kuronen@symbio.com>.
+ *         Ola Lilja <ola.o.lilja@stericsson.com>
+ *         for ST-Ericsson.
+ *
+ * License terms:
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/regulator/consumer.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/pcm.h>
+#include <sound/jack.h>
+#include <sound/pcm_params.h>
+#include <mach/hardware.h>
+#include "ux500_pcm.h"
+#include "ux500_msp_dai.h"
+#include "../codecs/ab8500_audio.h"
+
+#define TX_SLOT_MONO	0x0008
+#define TX_SLOT_STEREO	0x000a
+#define RX_SLOT_MONO	0x0001
+#define RX_SLOT_STEREO	0x0003
+#define TX_SLOT_8CH	0x00FF
+#define RX_SLOT_8CH	0x00FF
+
+#define DEF_TX_SLOTS	TX_SLOT_STEREO
+#define DEF_RX_SLOTS	RX_SLOT_MONO
+
+#define DRIVERMODE_NORMAL	0
+#define DRIVERMODE_CODEC_ONLY	1
+
+static struct snd_soc_jack jack;
+static bool vibra_on;
+
+/* Power-control */
+static DEFINE_MUTEX(power_lock);
+static int ab8500_power_count;
+
+/* Clocks */
+/* audioclk -> intclk -> sysclk/ulpclk */
+static int master_clock_sel;
+static struct clk *clk_ptr_audioclk;
+static struct clk *clk_ptr_intclk;
+static struct clk *clk_ptr_sysclk;
+static struct clk *clk_ptr_ulpclk;
+static struct clk *clk_ptr_gpio1;
+
+/* Temporary solution until the Ux500 clock-framework is in place.*/
+#ifndef clk_set_parent
+
+int clock_nosupport(void)
+{
+	pr_warn("%s: WARNING: Clock-framework does not support " \
+		"needed clocks!\n", __func__);
+	return 0;
+}
+#define CLK_SET_PARENT(x, y) clock_nosupport()
+#define CLK_ENABLE(x) clock_nosupport()
+#define CLK_DISABLE(x) clock_nosupport()
+#define CLK_GET(x, y) clock_nosupport()
+
+#else
+
+#define CLK_SET_PARENT(x, y) clk_set_parent(c, y)
+#define CLK_ENABLE(x) clk_enable(x)
+#define CLK_DISABLE(x) clk_disable(x)
+#define CLK_GET(x, y) clk_get(x, y)
+
+#endif
+
+/* ANC States */
+static const char *enum_anc_state[] = {
+	"Unconfigured",
+	"Configure FIR+IIR",
+	"FIR+IIR Configured",
+	"Configure FIR",
+	"FIR Configured",
+	"Configure IIR",
+	"IIR Configured",
+	"Error"
+};
+static SOC_ENUM_SINGLE_EXT_DECL(soc_enum_ancstate, enum_anc_state);
+
+/* Regulators */
+enum regulator_idx {
+	REGULATOR_AUDIO,
+	REGULATOR_DMIC,
+	REGULATOR_AMIC1,
+	REGULATOR_AMIC2
+};
+static struct regulator_bulk_data reg_info[4] = {
+	{	.supply = "vaud"	},
+	{	.supply = "vdmic"	},
+	{	.supply = "vamic1"	},
+	{	.supply = "vamic2"	},
+};
+static bool reg_enabled[4] =  {
+	false,
+	false,
+	false,
+	false
+};
+
+/* Slot configuration */
+static unsigned int tx_slots = DEF_TX_SLOTS;
+static unsigned int rx_slots = DEF_RX_SLOTS;
+
+/* Regulators */
+
+static int enable_regulator(enum regulator_idx idx)
+{
+	int ret;
+
+	if (reg_enabled[idx])
+		return 0;
+
+	ret = regulator_enable(reg_info[idx].consumer);
+	if (ret != 0) {
+		pr_err("%s: Failure to enable regulator '%s' (ret = %d)\n",
+			__func__, reg_info[idx].supply, ret);
+		return ret;
+	};
+
+	reg_enabled[idx] = true;
+	pr_debug("%s: Enabled regulator '%s', status: %d, %d, %d, %d\n",
+		__func__,
+		reg_info[idx].supply,
+		(int)reg_enabled[0],
+		(int)reg_enabled[1],
+		(int)reg_enabled[2],
+		(int)reg_enabled[3]);
+	return 0;
+}
+
+static void disable_regulator(enum regulator_idx idx)
+{
+	if (!reg_enabled[idx])
+		return;
+
+	regulator_disable(reg_info[idx].consumer);
+
+	reg_enabled[idx] = false;
+	pr_debug("%s: Disabled regulator '%s', status: %d, %d, %d, %d\n",
+		__func__,
+		reg_info[idx].supply,
+		(int)reg_enabled[0],
+		(int)reg_enabled[1],
+		(int)reg_enabled[2],
+		(int)reg_enabled[3]);
+}
+
+static int create_regulators(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+	int i, status = 0;
+
+	pr_debug("%s: Enter.\n", __func__);
+
+	for (i = 0; i < ARRAY_SIZE(reg_info); ++i) {
+		reg_info[i].consumer = regulator_get(codec->dev, reg_info[i].supply);
+		if (IS_ERR(reg_info[i].consumer)) {
+			status = PTR_ERR(reg_info[i].consumer);
+			pr_err("%s: ERROR: Failed to get regulator '%s' (ret = %d)!\n",
+				__func__, reg_info[i].supply, status);
+			reg_info[i].consumer = NULL;
+			goto err_get;
+		}
+	}
+
+	return 0;
+
+err_get:
+
+	for (i = 0; i < ARRAY_SIZE(reg_info); ++i) {
+		if (reg_info[i].consumer) {
+			regulator_put(reg_info[i].consumer);
+			reg_info[i].consumer = NULL;
+		}
+	}
+
+	return status;
+}
+
+/* Power/clock control */
+
+static int ux500_ab8500_power_control_inc(void)
+{
+	int ret = 0;
+
+	mutex_lock(&power_lock);
+
+	ab8500_power_count++;
+	pr_debug("%s: ab8500_power_count changed from %d to %d",
+		__func__,
+		ab8500_power_count-1,
+		ab8500_power_count);
+
+	if (ab8500_power_count == 1) {
+		/* Turn on audio-regulator */
+		ret = enable_regulator(REGULATOR_AUDIO);
+
+		if (ret)
+			goto out;
+
+		/* Enable audio-clock */
+		ret = CLK_SET_PARENT(clk_ptr_intclk,
+				(master_clock_sel == 0) ? clk_ptr_sysclk : clk_ptr_ulpclk);
+		if (ret) {
+			pr_err("%s: ERROR: Setting master-clock to %s failed (ret = %d)!",
+				__func__,
+				(master_clock_sel == 0) ? "SYSCLK" : "ULPCLK",
+				ret);
+			goto clk_err;
+		}
+		pr_debug("%s: Enabling master-clock (%s).",
+			__func__,
+			(master_clock_sel == 0) ? "SYSCLK" : "ULPCLK");
+		ret = CLK_ENABLE(clk_ptr_audioclk);
+		if (ret) {
+			pr_err("%s: ERROR: clk_enable failed (ret = %d)!", __func__, ret);
+			ab8500_power_count = 0;
+			goto clk_err;
+		}
+
+		/* Power on audio-parts of AB8500 */
+		ab8500_audio_power_control(true);
+	}
+
+	goto out;
+
+clk_err:
+	disable_regulator(REGULATOR_AUDIO);
+
+out:
+	mutex_unlock(&power_lock);
+
+	return ret;
+}
+
+static void ux500_ab8500_power_control_dec(void)
+{
+	mutex_lock(&power_lock);
+
+	ab8500_power_count--;
+
+	pr_debug("%s: ab8500_power_count changed from %d to %d",
+		__func__,
+		ab8500_power_count+1,
+		ab8500_power_count);
+
+	if (ab8500_power_count == 0) {
+		/* Power off audio-parts of AB8500 */
+		ab8500_audio_power_control(false);
+
+		/* Disable audio-clock */
+		pr_debug("%s: Disabling master-clock (%s).",
+			__func__,
+			(master_clock_sel == 0) ? "SYSCLK" : "ULPCLK");
+		CLK_DISABLE(clk_ptr_audioclk);
+
+		/* Turn off audio-regulator */
+		disable_regulator(REGULATOR_AUDIO);
+	}
+
+	mutex_unlock(&power_lock);
+}
+
+/* Controls - Non-DAPM Non-ASoC */
+
+static int mclk_input_control_info(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = 2;
+	if (uinfo->value.enumerated.item) {
+		uinfo->value.enumerated.item = 1;
+		strcpy(uinfo->value.enumerated.name, "ULPCLK");
+	} else {
+		strcpy(uinfo->value.enumerated.name, "SYSCLK");
+	}
+	return 0;
+}
+
+static int mclk_input_control_get(struct snd_kcontrol *kcontrol,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.enumerated.item[0] = master_clock_sel;
+	return 0;
+}
+
+static int mclk_input_control_put(struct snd_kcontrol *kcontrol,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	unsigned int val;
+
+	val = (ucontrol->value.enumerated.item[0] != 0);
+	if (master_clock_sel == val)
+		return 0;
+
+	master_clock_sel = val;
+
+	return 1;
+}
+
+static const struct snd_kcontrol_new mclk_input_control = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Master Clock Select",
+	.index = 0,
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info = mclk_input_control_info,
+	.get = mclk_input_control_get,
+	.put = mclk_input_control_put,
+	.private_value = 1 /* ULPCLK */
+};
+
+static int anc_status_control_get(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = ab8500_audio_anc_status();
+
+	return 0;
+}
+
+static int anc_status_control_put(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_value *ucontrol)
+{
+	int ret;
+	int req_state = ucontrol->value.integer.value[0];
+
+	ret = ux500_ab8500_power_control_inc();
+	if (ret)
+		goto cleanup;
+
+	ret = ab8500_audio_anc_configure(req_state);
+
+	ux500_ab8500_power_control_dec();
+
+cleanup:
+	if (ret) {
+		pr_err("%s: Unable to configure ANC! (ret = %d)\n",
+				__func__, ret);
+		return 0;
+	}
+
+	return 1;
+}
+
+static const struct snd_kcontrol_new anc_status_control = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "ANC Status",
+	.index = 0,
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.info = snd_soc_info_enum_ext,
+	.get = anc_status_control_get, .put = anc_status_control_put,
+	.private_value = (unsigned long) &soc_enum_ancstate
+};
+
+/* DAPM-events */
+
+static int dapm_audioreg_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *k, int event)
+{
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		ux500_ab8500_power_control_inc();
+	else
+		ux500_ab8500_power_control_dec();
+
+	return 0;
+}
+
+
+static int dapm_mic1reg_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *k, int event)
+{
+	int ret = 0;
+
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		ret = enable_regulator(REGULATOR_AMIC1);
+	else
+		disable_regulator(REGULATOR_AMIC1);
+
+	return ret;
+}
+
+static int dapm_mic2reg_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *k, int event)
+{
+	int ret = 0;
+
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		ret = enable_regulator(REGULATOR_AMIC2);
+	else
+		disable_regulator(REGULATOR_AMIC2);
+
+	return ret;
+}
+
+static int dapm_dmicreg_event(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *k, int event)
+{
+	int ret = 0;
+
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		ret = enable_regulator(REGULATOR_DMIC);
+	else
+		disable_regulator(REGULATOR_DMIC);
+
+	return ret;
+}
+
+/* DAPM-widgets */
+
+static const struct snd_soc_dapm_widget ux500_ab8500_dapm_widgets[] = {
+	SND_SOC_DAPM_SUPPLY("AUDIO Regulator", SND_SOC_NOPM, 0, 0, dapm_audioreg_event,
+			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY("AMIC1 Regulator", SND_SOC_NOPM, 0, 0, dapm_mic1reg_event,
+			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY("AMIC2 Regulator", SND_SOC_NOPM, 0, 0, dapm_mic2reg_event,
+			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY("DMIC Regulator", SND_SOC_NOPM, 0, 0, dapm_dmicreg_event,
+			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+};
+
+/* DAPM-routes */
+
+static const struct snd_soc_dapm_route ux500_ab8500_dapm_intercon[] = {
+
+	/* Power AB8500 audio-block when AD/DA is active */
+	{"DAC", NULL, "AUDIO Regulator"},
+	{"ADC", NULL, "AUDIO Regulator"},
+
+	/* Power AMIC1-regulator when MIC1 is enabled */
+	{"MIC1 Enable", NULL, "AMIC1 Regulator"},
+
+	/* Power AMIC2-regulator when MIC1 is enabled */
+	{"MIC2 Enable", NULL, "AMIC2 Regulator"},
+
+	/* Power DMIC-regulator when any digital mic is enabled */
+	{"DMic 1", NULL, "DMIC Regulator"},
+	{"DMic 2", NULL, "DMIC Regulator"},
+	{"DMic 3", NULL, "DMIC Regulator"},
+	{"DMic 4", NULL, "DMIC Regulator"},
+	{"DMic 5", NULL, "DMIC Regulator"},
+	{"DMic 6", NULL, "DMIC Regulator"},
+};
+
+
+static int add_widgets(struct snd_soc_codec *codec)
+{
+	int ret;
+
+	ret = snd_soc_dapm_new_controls(&codec->dapm,
+			ux500_ab8500_dapm_widgets,
+			ARRAY_SIZE(ux500_ab8500_dapm_widgets));
+	if (ret < 0) {
+		pr_err("%s: Failed to create DAPM controls (%d).\n",
+			__func__, ret);
+		return ret;
+	}
+
+	ret = snd_soc_dapm_add_routes(&codec->dapm,
+				ux500_ab8500_dapm_intercon,
+				ARRAY_SIZE(ux500_ab8500_dapm_intercon));
+	if (ret < 0) {
+		pr_err("%s: Failed to add DAPM routes (%d).\n",
+			__func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+/* ASoC */
+
+int ux500_ab8500_startup(struct snd_pcm_substream *substream)
+{
+	int ret = 0;
+
+	pr_debug("%s: Enter\n", __func__);
+
+	/* Enable gpio.1-clock (needed by DSP in burst mode) */
+	ret = CLK_ENABLE(clk_ptr_gpio1);
+	if (ret) {
+		pr_err("%s: ERROR: CLK_ENABLE(gpio.1) failed (ret = %d)!", __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+void ux500_ab8500_shutdown(struct snd_pcm_substream *substream)
+{
+	pr_debug("%s: Enter\n", __func__);
+
+	/* Reset slots configuration to default(s) */
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		tx_slots = DEF_TX_SLOTS;
+	else
+		rx_slots = DEF_RX_SLOTS;
+
+	CLK_DISABLE(clk_ptr_gpio1);
+}
+
+int ux500_ab8500_hw_params(struct snd_pcm_substream *substream,
+			struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	unsigned int fmt, fmt_if1;
+	int channels, ret = 0, slots, slot_width, driver_mode;
+	bool streamIsPlayback;
+
+	pr_debug("%s: Enter\n", __func__);
+
+	pr_debug("%s: substream->pcm->name = %s\n"
+		"substream->pcm->id = %s.\n"
+		"substream->name = %s.\n"
+		"substream->number = %d.\n",
+		__func__,
+		substream->pcm->name,
+		substream->pcm->id,
+		substream->name,
+		substream->number);
+
+	channels = params_channels(params);
+
+	/* Setup codec depending on driver-mode */
+	driver_mode = (channels == 8) ?
+		DRIVERMODE_CODEC_ONLY : DRIVERMODE_NORMAL;
+	pr_debug("%s: Driver-mode: %s.\n",
+		__func__,
+		(driver_mode == DRIVERMODE_NORMAL) ? "NORMAL" : "CODEC_ONLY");
+
+	ab8500_audio_set_bit_delay(codec_dai, 1);
+
+	if (driver_mode == DRIVERMODE_NORMAL) {
+		ab8500_audio_set_word_length(codec_dai, 16);
+		fmt = SND_SOC_DAIFMT_DSP_A |
+			SND_SOC_DAIFMT_CBM_CFM |
+			SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CONT;
+	} else {
+		ab8500_audio_set_word_length(codec_dai, 20);
+		fmt = SND_SOC_DAIFMT_DSP_A |
+			SND_SOC_DAIFMT_CBM_CFM |
+			SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_GATED;
+	}
+
+	ret = snd_soc_dai_set_fmt(codec_dai, fmt);
+	if (ret < 0) {
+		pr_err("%s: ERROR: snd_soc_dai_set_fmt failed for codec_dai (ret = %d)!\n",
+			__func__,
+			ret);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
+	if (ret < 0) {
+		pr_err("%s: ERROR: snd_soc_dai_set_fmt for cpu_dai (ret = %d)!\n",
+			__func__,
+			ret);
+		return ret;
+	}
+
+	ux500_msp_dai_set_data_delay(cpu_dai, MSP_DELAY_1);
+
+	/* Setup TDM-slots */
+
+	streamIsPlayback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
+	switch (channels) {
+	case 1:
+		slots = 16;
+		slot_width = 16;
+		tx_slots = (streamIsPlayback) ? TX_SLOT_MONO : 0;
+		rx_slots = (streamIsPlayback) ? 0 : RX_SLOT_MONO;
+		break;
+	case 2:
+		slots = 16;
+		slot_width = 16;
+		tx_slots = (streamIsPlayback) ? TX_SLOT_STEREO : 0;
+		rx_slots = (streamIsPlayback) ? 0 : RX_SLOT_STEREO;
+		break;
+	case 8:
+		slots = 16;
+		slot_width = 16;
+		tx_slots = (streamIsPlayback) ? TX_SLOT_8CH : 0;
+		rx_slots = (streamIsPlayback) ? 0 : RX_SLOT_8CH;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	pr_debug("%s: CPU-DAI TDM: TX=0x%04X RX=0x%04x\n",
+		__func__, tx_slots, rx_slots);
+	ret = snd_soc_dai_set_tdm_slot(cpu_dai, tx_slots, rx_slots, slots, slot_width);
+	if (ret)
+		return ret;
+
+	pr_debug("%s: CODEC-DAI TDM: TX=0x%04X RX=0x%04x\n",
+		__func__, tx_slots, rx_slots);
+	ret = snd_soc_dai_set_tdm_slot(codec_dai, tx_slots, rx_slots, slots, slot_width);
+	if (ret)
+		return ret;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		pr_debug("%s: Setup IF1 for FM-radio.\n", __func__);
+		fmt_if1 = SND_SOC_DAIFMT_CBM_CFM | SND_SOC_DAIFMT_I2S;
+		ret = ab8500_audio_setup_if1(codec_dai->codec, fmt_if1, 16, 1);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+struct snd_soc_ops ux500_ab8500_ops[] = {
+	{
+	.hw_params = ux500_ab8500_hw_params,
+	.startup = ux500_ab8500_startup,
+	.shutdown = ux500_ab8500_shutdown,
+	}
+};
+
+int ux500_ab8500_machine_codec_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+	int ret;
+
+	pr_debug("%s Enter.\n", __func__);
+
+	ret = snd_soc_jack_new(codec,
+			"AB8500 Hs Status",
+			SND_JACK_HEADPHONE     |
+			SND_JACK_MICROPHONE    |
+			SND_JACK_HEADSET       |
+			SND_JACK_LINEOUT       |
+			SND_JACK_MECHANICAL    |
+			SND_JACK_VIDEOOUT,
+			&jack);
+	if (ret < 0) {
+		pr_err("%s: ERROR: Failed to create Jack (ret = %d)!\n", __func__, ret);
+		return ret;
+	}
+
+	/* Add controls */
+	snd_ctl_add(codec->card->snd_card, snd_ctl_new1(&mclk_input_control, codec));
+	snd_ctl_add(codec->card->snd_card, snd_ctl_new1(&anc_status_control, codec));
+
+	ret = create_regulators(rtd);
+	if (ret < 0) {
+		pr_err("%s: ERROR: Failed to instantiate regulators (ret = %d)!\n",
+			__func__, ret);
+		return ret;
+	}
+
+	/* Get references to clock-nodes */
+	clk_ptr_sysclk = NULL;
+	clk_ptr_ulpclk = NULL;
+	clk_ptr_intclk = NULL;
+	clk_ptr_audioclk = NULL;
+	clk_ptr_gpio1 = NULL;
+	clk_ptr_sysclk = CLK_GET(codec->dev, "sysclk");
+	if (IS_ERR(clk_ptr_sysclk)) {
+		pr_err("ERROR: clk_get failed (ret = %d)!", -EFAULT);
+		return -EFAULT;
+	}
+	clk_ptr_ulpclk = CLK_GET(codec->dev, "ulpclk");
+	if (IS_ERR(clk_ptr_sysclk)) {
+		pr_err("ERROR: clk_get failed (ret = %d)!", -EFAULT);
+		return -EFAULT;
+	}
+	clk_ptr_intclk = CLK_GET(codec->dev, "intclk");
+	if (IS_ERR(clk_ptr_audioclk)) {
+		pr_err("ERROR: clk_get failed (ret = %d)!", -EFAULT);
+		return -EFAULT;
+	}
+	clk_ptr_audioclk = CLK_GET(codec->dev, "audioclk");
+	if (IS_ERR(clk_ptr_audioclk)) {
+		pr_err("ERROR: clk_get failed (ret = %d)!", -EFAULT);
+		return -EFAULT;
+	}
+	clk_ptr_gpio1 = clk_get_sys("gpio.1", NULL);
+	if (IS_ERR(clk_ptr_gpio1)) {
+		pr_err("ERROR: clk_get_sys(gpio.1) failed (ret = %d)!", -EFAULT);
+		return -EFAULT;
+	}
+
+	/* Set intclk default parent to ulpclk */
+	ret = CLK_SET_PARENT(clk_ptr_intclk, clk_ptr_ulpclk);
+	if (ret) {
+		pr_err("%s: ERROR: Setting intclk parent to ulpclk failed (ret = %d)!",
+			__func__,
+			ret);
+		return -EFAULT;
+	}
+
+	master_clock_sel = 1;
+
+	ab8500_power_count = 0;
+
+	/* Add DAPM-widgets */
+	ret = add_widgets(codec);
+	if (ret < 0) {
+		pr_err("%s: Failed add widgets (%d).\n", __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+int ux500_ab8500_soc_machine_drv_init(void)
+{
+	pr_debug("%s: Enter.\n", __func__);
+
+	vibra_on = false;
+
+	return 0;
+}
+
+void ux500_ab8500_soc_machine_drv_cleanup(void)
+{
+	pr_debug("%s: Enter.\n", __func__);
+
+	regulator_bulk_free(ARRAY_SIZE(reg_info), reg_info);
+
+	if (clk_ptr_sysclk != NULL)
+		clk_put(clk_ptr_sysclk);
+	if (clk_ptr_ulpclk != NULL)
+		clk_put(clk_ptr_ulpclk);
+	if (clk_ptr_intclk != NULL)
+		clk_put(clk_ptr_intclk);
+	if (clk_ptr_audioclk != NULL)
+		clk_put(clk_ptr_audioclk);
+	if (clk_ptr_gpio1 != NULL)
+		clk_put(clk_ptr_gpio1);
+}
+
+/* Extended interface */
+
+void ux500_ab8500_audio_pwm_vibra(unsigned char speed_left_pos,
+			unsigned char speed_left_neg,
+			unsigned char speed_right_pos,
+			unsigned char speed_right_neg)
+{
+	bool vibra_on_new;
+
+	vibra_on_new = speed_left_pos | speed_left_neg | speed_right_pos | speed_right_neg;
+	if ((!vibra_on_new) && (vibra_on)) {
+		pr_debug("%s: PWM-vibra off.\n", __func__);
+		vibra_on = false;
+
+		ux500_ab8500_power_control_dec();
+	}
+
+	if ((vibra_on_new) && (!vibra_on)) {
+		pr_debug("%s: PWM-vibra on.\n", __func__);
+		vibra_on = true;
+
+		ux500_ab8500_power_control_inc();
+	}
+
+	ab8500_audio_pwm_vibra(speed_left_pos,
+			speed_left_neg,
+			speed_right_pos,
+			speed_right_neg);
+}
+
+void ux500_ab8500_jack_report(int value)
+{
+	if (jack.jack)
+		snd_soc_jack_report(&jack, value, 0xFF);
+}
+EXPORT_SYMBOL(ux500_ab8500_jack_report);
+
diff --git a/sound/soc/ux500/ux500_msp_dai.c b/sound/soc/ux500/ux500_msp_dai.c
new file mode 100644
index 0000000..bc1a7ea
--- /dev/null
+++ b/sound/soc/ux500/ux500_msp_dai.c
@@ -0,0 +1,998 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2011
+ *
+ * Author: Ola Lilja <ola.o.lilja@stericsson.com>,
+ *         Roger Nilsson <roger.xr.nilsson@stericsson.com>
+ *         for ST-Ericsson.
+ *
+ * License terms:
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/bitops.h>
+#include <linux/platform_device.h>
+
+#include <mach/hardware.h>
+#include <mach/msp.h>
+
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+
+#include "ux500_msp_i2s.h"
+#include "ux500_msp_dai.h"
+#include "ux500_pcm.h"
+
+static struct ux500_platform_drvdata platform_drvdata[UX500_NBR_OF_DAI] = {
+	{
+		.msp_i2s_drvdata = NULL,
+		.fmt = 0,
+		.slots = 1,
+		.tx_mask = 0x01,
+		.rx_mask = 0x01,
+		.slot_width = 16,
+		.playback_active = false,
+		.capture_active = false,
+		.configured = 0,
+		.data_delay = MSP_DELAY_0,
+		.master_clk = UX500_MSP_INTERNAL_CLOCK_FREQ,
+	},
+	{
+		.msp_i2s_drvdata = NULL,
+		.fmt = 0,
+		.slots = 1,
+		.tx_mask = 0x01,
+		.rx_mask = 0x01,
+		.slot_width = 16,
+		.playback_active = false,
+		.capture_active = false,
+		.configured = 0,
+		.data_delay = MSP_DELAY_0,
+		.master_clk = UX500_MSP1_INTERNAL_CLOCK_FREQ,
+	},
+	{
+		.msp_i2s_drvdata = NULL,
+		.fmt = 0,
+		.slots = 1,
+		.tx_mask = 0x01,
+		.rx_mask = 0x01,
+		.slot_width = 16,
+		.playback_active = false,
+		.capture_active = false,
+		.configured = 0,
+		.data_delay = MSP_DELAY_0,
+		.master_clk = UX500_MSP_INTERNAL_CLOCK_FREQ,
+	},
+	{
+		.msp_i2s_drvdata = NULL,
+		.fmt = 0,
+		.slots = 1,
+		.tx_mask = 0x01,
+		.rx_mask = 0x01,
+		.slot_width = 16,
+		.playback_active = false,
+		.capture_active = false,
+		.configured = 0,
+		.data_delay = MSP_DELAY_0,
+		.master_clk = UX500_MSP1_INTERNAL_CLOCK_FREQ,
+	},
+};
+
+bool ux500_msp_dai_i2s_get_underrun_status(int dai_idx)
+{
+	struct ux500_platform_drvdata *drvdata = &platform_drvdata[dai_idx];
+	int status = ux500_msp_i2s_hw_status(drvdata->msp_i2s_drvdata);
+	return (bool)(status & TRANSMIT_UNDERRUN_ERR_INT);
+}
+
+int ux500_msp_dai_i2s_configure_sg(dma_addr_t dma_addr,
+				int period_cnt,
+				size_t period_len,
+				int dai_idx,
+				int stream_id)
+{
+	struct ux500_platform_drvdata *drvdata = &platform_drvdata[dai_idx];
+	struct i2s_message message;
+	int ret = 0;
+	bool playback_req_valid =
+		(drvdata->playback_active &&
+			stream_id == SNDRV_PCM_STREAM_PLAYBACK);
+	bool capture_req_valid =
+		(drvdata->capture_active &&
+			stream_id == SNDRV_PCM_STREAM_CAPTURE);
+
+	pr_debug("%s: Enter (MSP Index: %u, period-cnt: %u, period-len: %u).\n",
+		__func__,
+		dai_idx,
+		period_cnt,
+		period_len);
+
+	if (!playback_req_valid && !capture_req_valid) {
+		pr_err("%s: The I2S controller is not available."
+			"MSP index:%d\n",
+			__func__,
+			dai_idx);
+		return ret;
+	}
+
+	message.i2s_direction = (stream_id == SNDRV_PCM_STREAM_PLAYBACK) ?
+					I2S_DIRECTION_TX :
+					I2S_DIRECTION_RX;
+	message.buf_addr = dma_addr;
+	message.buf_len = period_cnt * period_len;
+	message.period_len = period_len;
+
+	ret = ux500_msp_i2s_transfer(drvdata->msp_i2s_drvdata, &message);
+	if (ret < 0) {
+		pr_err("%s: Error: i2s_transfer failed. MSP index: %d\n",
+			__func__,
+			dai_idx);
+	}
+
+	return ret;
+}
+
+static const char *stream_str(struct snd_pcm_substream *substream)
+{
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		return "Playback";
+	else
+		return "Capture";
+}
+
+static int ux500_msp_dai_startup(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct ux500_platform_drvdata *drvdata = &platform_drvdata[dai->id];
+	bool mode_playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
+
+	pr_debug("%s: MSP %d (%s): Enter.\n", __func__, dai->id, stream_str(substream));
+
+	if ((mode_playback && drvdata->playback_active) ||
+		(!mode_playback && drvdata->capture_active)) {
+		pr_err("%s: Error: MSP %d (%s): Stream already active.\n",
+			__func__,
+			dai->id,
+			stream_str(substream));
+		return -EBUSY;
+	}
+
+	if (mode_playback)
+		drvdata->playback_active = true;
+	else
+		drvdata->capture_active = true;
+
+	return 0;
+}
+
+static void ux500_msp_dai_shutdown(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	struct ux500_platform_drvdata *drvdata = &platform_drvdata[dai->id];
+	bool mode_playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
+
+	pr_debug("%s: MSP %d (%s): Enter.\n", __func__, dai->id, stream_str(substream));
+
+	if (drvdata == NULL)
+		return;
+
+	if (mode_playback)
+		drvdata->playback_active = false;
+	else
+		drvdata->capture_active = false;
+
+	if (ux500_msp_i2s_close(drvdata->msp_i2s_drvdata,
+			mode_playback ? DISABLE_TRANSMIT : DISABLE_RECEIVE)) {
+			pr_err("%s: Error: MSP %d (%s): Unable to close i2s.\n",
+				__func__,
+				dai->id,
+				stream_str(substream));
+	}
+
+	if (mode_playback)
+		drvdata->configured &= ~PLAYBACK_CONFIGURED;
+	else
+		drvdata->configured &= ~CAPTURE_CONFIGURED;
+}
+
+static void ux500_msp_dai_setup_multichannel(struct ux500_platform_drvdata *private,
+					struct msp_config *msp_config)
+{
+	struct msp_multichannel_config *multi =	&msp_config->multichannel_config;
+
+	if (private->slots > 1) {
+		msp_config->multichannel_configured = 1;
+
+		multi->tx_multichannel_enable = true;
+		multi->rx_multichannel_enable = true;
+		multi->rx_comparison_enable_mode = MSP_COMPARISON_DISABLED;
+
+		multi->tx_channel_0_enable = private->tx_mask;
+		multi->tx_channel_1_enable = 0;
+		multi->tx_channel_2_enable = 0;
+		multi->tx_channel_3_enable = 0;
+
+		multi->rx_channel_0_enable = private->rx_mask;
+		multi->rx_channel_1_enable = 0;
+		multi->rx_channel_2_enable = 0;
+		multi->rx_channel_3_enable = 0;
+
+		pr_debug("%s: Multichannel enabled."
+			"Slots: %d TX: %u RX: %u\n",
+			__func__,
+			private->slots,
+			multi->tx_channel_0_enable,
+			multi->rx_channel_0_enable);
+	}
+}
+
+static void ux500_msp_dai_setup_frameper(struct ux500_platform_drvdata *private,
+					unsigned int rate,
+					struct msp_protocol_desc *prot_desc)
+{
+	switch (private->slots) {
+	default:
+	case 1:
+		switch (rate) {
+		case 8000:
+			prot_desc->frame_period =
+				FRAME_PER_SINGLE_SLOT_8_KHZ;
+			break;
+		case 16000:
+			prot_desc->frame_period =
+				FRAME_PER_SINGLE_SLOT_16_KHZ;
+			break;
+		case 44100:
+			prot_desc->frame_period =
+				FRAME_PER_SINGLE_SLOT_44_1_KHZ;
+			break;
+		case 48000:
+		default:
+			prot_desc->frame_period =
+				FRAME_PER_SINGLE_SLOT_48_KHZ;
+			break;
+		}
+		break;
+
+	case 2:
+		prot_desc->frame_period = FRAME_PER_2_SLOTS;
+		break;
+
+	case 8:
+		prot_desc->frame_period =
+			FRAME_PER_8_SLOTS;
+		break;
+
+	case 16:
+		prot_desc->frame_period =
+			FRAME_PER_16_SLOTS;
+		break;
+	}
+
+	prot_desc->total_clocks_for_one_frame =
+			prot_desc->frame_period+1;
+
+	pr_debug("%s: Total clocks per frame: %u\n",
+		__func__,
+		prot_desc->total_clocks_for_one_frame);
+}
+
+static void ux500_msp_dai_setup_framing_pcm(struct ux500_platform_drvdata *private,
+					unsigned int rate,
+					struct msp_protocol_desc *prot_desc)
+{
+	u32 frame_length = MSP_FRAME_LENGTH_1;
+	prot_desc->frame_width = 0;
+
+	switch (private->slots) {
+	default:
+	case 1:
+		frame_length = MSP_FRAME_LENGTH_1;
+		break;
+
+	case 2:
+		frame_length = MSP_FRAME_LENGTH_2;
+		break;
+
+	case 8:
+		frame_length = MSP_FRAME_LENGTH_8;
+		break;
+
+	case 16:
+		frame_length = MSP_FRAME_LENGTH_16;
+		break;
+	}
+
+	prot_desc->tx_frame_length_1 = frame_length;
+	prot_desc->rx_frame_length_1 = frame_length;
+	prot_desc->tx_frame_length_2 = frame_length;
+	prot_desc->rx_frame_length_2 = frame_length;
+
+	prot_desc->tx_element_length_1 = MSP_ELEM_LENGTH_16;
+	prot_desc->rx_element_length_1 = MSP_ELEM_LENGTH_16;
+	prot_desc->tx_element_length_2 = MSP_ELEM_LENGTH_16;
+	prot_desc->rx_element_length_2 = MSP_ELEM_LENGTH_16;
+
+	ux500_msp_dai_setup_frameper(private, rate, prot_desc);
+}
+
+static void ux500_msp_dai_setup_clocking(unsigned int fmt,
+					struct msp_config *msp_config)
+{
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	default:
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+
+	case SND_SOC_DAIFMT_NB_IF:
+		msp_config->tx_frame_sync_pol ^= 1 << TFSPOL_SHIFT;
+		msp_config->rx_frame_sync_pol ^= 1 << RFSPOL_SHIFT;
+		break;
+	}
+
+	if ((fmt & SND_SOC_DAIFMT_MASTER_MASK) == SND_SOC_DAIFMT_CBM_CFM) {
+		pr_debug("%s: Codec is MASTER.\n",
+			__func__);
+		msp_config->iodelay = 0x20;
+		msp_config->rx_frame_sync_sel = 0;
+		msp_config->tx_frame_sync_sel = 1 << TFSSEL_SHIFT;
+		msp_config->tx_clock_sel = 0;
+		msp_config->rx_clock_sel = 0;
+		msp_config->srg_clock_sel = 0x2 << SCKSEL_SHIFT;
+
+	} else {
+		pr_debug("%s: Codec is SLAVE.\n",
+			__func__);
+
+		msp_config->tx_clock_sel = TX_CLK_SEL_SRG;
+		msp_config->tx_frame_sync_sel = TX_SYNC_SRG_PROG;
+		msp_config->rx_clock_sel = RX_CLK_SEL_SRG;
+		msp_config->rx_frame_sync_sel = RX_SYNC_SRG;
+		msp_config->srg_clock_sel = 1 << SCKSEL_SHIFT;
+	}
+}
+
+static void ux500_msp_dai_compile_prot_desc_pcm(unsigned int fmt,
+					struct msp_protocol_desc *prot_desc)
+{
+	prot_desc->rx_phase_mode = MSP_SINGLE_PHASE;
+	prot_desc->tx_phase_mode = MSP_SINGLE_PHASE;
+	prot_desc->rx_phase2_start_mode = MSP_PHASE2_START_MODE_IMEDIATE;
+	prot_desc->tx_phase2_start_mode = MSP_PHASE2_START_MODE_IMEDIATE;
+	prot_desc->rx_bit_transfer_format = MSP_BTF_MS_BIT_FIRST;
+	prot_desc->tx_bit_transfer_format = MSP_BTF_MS_BIT_FIRST;
+	prot_desc->tx_frame_sync_pol = MSP_FRAME_SYNC_POL(MSP_FRAME_SYNC_POL_ACTIVE_HIGH);
+	prot_desc->rx_frame_sync_pol = MSP_FRAME_SYNC_POL_ACTIVE_HIGH << RFSPOL_SHIFT;
+
+	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) == SND_SOC_DAIFMT_DSP_A) {
+		pr_debug("%s: DSP_A.\n",
+			__func__);
+		prot_desc->rx_clock_pol = MSP_RISING_EDGE;
+		prot_desc->tx_clock_pol = MSP_FALLING_EDGE;
+	} else {
+		pr_debug("%s: DSP_B.\n",
+			__func__);
+		prot_desc->rx_clock_pol = MSP_FALLING_EDGE;
+		prot_desc->tx_clock_pol = MSP_RISING_EDGE;
+	}
+
+	prot_desc->rx_half_word_swap = MSP_HWS_NO_SWAP;
+	prot_desc->tx_half_word_swap = MSP_HWS_NO_SWAP;
+	prot_desc->compression_mode = MSP_COMPRESS_MODE_LINEAR;
+	prot_desc->expansion_mode = MSP_EXPAND_MODE_LINEAR;
+	prot_desc->spi_clk_mode = MSP_SPI_CLOCK_MODE_NON_SPI;
+	prot_desc->spi_burst_mode = MSP_SPI_BURST_MODE_DISABLE;
+	prot_desc->frame_sync_ignore = MSP_FRAME_SYNC_IGNORE;
+}
+
+static void ux500_msp_dai_compile_prot_desc_i2s(struct msp_protocol_desc *prot_desc)
+{
+	prot_desc->rx_phase_mode = MSP_DUAL_PHASE;
+	prot_desc->tx_phase_mode = MSP_DUAL_PHASE;
+	prot_desc->rx_phase2_start_mode =
+		MSP_PHASE2_START_MODE_FRAME_SYNC;
+	prot_desc->tx_phase2_start_mode =
+		MSP_PHASE2_START_MODE_FRAME_SYNC;
+	prot_desc->rx_bit_transfer_format = MSP_BTF_MS_BIT_FIRST;
+	prot_desc->tx_bit_transfer_format = MSP_BTF_MS_BIT_FIRST;
+	prot_desc->tx_frame_sync_pol = MSP_FRAME_SYNC_POL(MSP_FRAME_SYNC_POL_ACTIVE_LOW);
+	prot_desc->rx_frame_sync_pol = MSP_FRAME_SYNC_POL_ACTIVE_LOW << RFSPOL_SHIFT;
+
+	prot_desc->rx_frame_length_1 = MSP_FRAME_LENGTH_1;
+	prot_desc->rx_frame_length_2 = MSP_FRAME_LENGTH_1;
+	prot_desc->tx_frame_length_1 = MSP_FRAME_LENGTH_1;
+	prot_desc->tx_frame_length_2 = MSP_FRAME_LENGTH_1;
+	prot_desc->rx_element_length_1 = MSP_ELEM_LENGTH_16;
+	prot_desc->rx_element_length_2 = MSP_ELEM_LENGTH_16;
+	prot_desc->tx_element_length_1 = MSP_ELEM_LENGTH_16;
+	prot_desc->tx_element_length_2 = MSP_ELEM_LENGTH_16;
+
+	prot_desc->rx_clock_pol = MSP_RISING_EDGE;
+	prot_desc->tx_clock_pol = MSP_FALLING_EDGE;
+
+	prot_desc->tx_half_word_swap = MSP_HWS_NO_SWAP;
+	prot_desc->rx_half_word_swap = MSP_HWS_NO_SWAP;
+	prot_desc->compression_mode = MSP_COMPRESS_MODE_LINEAR;
+	prot_desc->expansion_mode = MSP_EXPAND_MODE_LINEAR;
+	prot_desc->spi_clk_mode = MSP_SPI_CLOCK_MODE_NON_SPI;
+	prot_desc->spi_burst_mode = MSP_SPI_BURST_MODE_DISABLE;
+	prot_desc->frame_sync_ignore = MSP_FRAME_SYNC_IGNORE;
+}
+
+static void ux500_msp_dai_compile_msp_config(struct snd_pcm_substream *substream,
+					struct ux500_platform_drvdata *private,
+					unsigned int rate,
+					struct msp_config *msp_config)
+{
+	struct msp_protocol_desc *prot_desc = &msp_config->protocol_desc;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	unsigned int fmt = private->fmt;
+
+	memset(msp_config, 0, sizeof(*msp_config));
+
+	msp_config->input_clock_freq = private->master_clk;
+
+	msp_config->tx_fifo_config = TX_FIFO_ENABLE;
+	msp_config->rx_fifo_config = RX_FIFO_ENABLE;
+	msp_config->spi_clk_mode = SPI_CLK_MODE_NORMAL;
+	msp_config->spi_burst_mode = 0;
+	msp_config->handler = ux500_pcm_dma_eot_handler;
+	msp_config->tx_callback_data =
+		substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
+		substream : NULL;
+	msp_config->rx_callback_data =
+		substream->stream == SNDRV_PCM_STREAM_CAPTURE ?
+		substream : NULL;
+	msp_config->def_elem_len = 1;
+	msp_config->direction =
+		substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
+		MSP_TRANSMIT_MODE : MSP_RECEIVE_MODE;
+	msp_config->data_size = MSP_DATA_BITS_32;
+	msp_config->work_mode = MSP_DMA_MODE;
+	msp_config->frame_freq = rate;
+
+	pr_debug("%s: input_clock_freq = %u, frame_freq = %u.\n",
+	       __func__, msp_config->input_clock_freq, msp_config->frame_freq);
+	/* To avoid division by zero in I2S-driver (i2s_setup) */
+	prot_desc->total_clocks_for_one_frame = 1;
+
+	prot_desc->rx_data_delay = private->data_delay;
+	prot_desc->tx_data_delay = private->data_delay;
+
+	pr_debug("%s: rate: %u channels: %d.\n",
+			__func__,
+			rate,
+			runtime->channels);
+	switch (fmt &
+		(SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_MASTER_MASK)) {
+
+	case SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS:
+		pr_debug("%s: SND_SOC_DAIFMT_I2S.\n",
+			__func__);
+
+		msp_config->default_protocol_desc = 1;
+		msp_config->protocol = MSP_I2S_PROTOCOL;
+		break;
+
+	default:
+	case SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM:
+		pr_debug("%s: SND_SOC_DAIFMT_I2S.\n",
+			__func__);
+
+		msp_config->data_size = MSP_DATA_BITS_16;
+		msp_config->protocol = MSP_I2S_PROTOCOL;
+
+		ux500_msp_dai_compile_prot_desc_i2s(prot_desc);
+		break;
+
+	case SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_CBS_CFS:
+	case SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_CBM_CFM:
+	case SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBS_CFS:
+	case SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM:
+		pr_debug("%s: PCM format.\n",
+			__func__);
+		msp_config->data_size = MSP_DATA_BITS_16;
+		msp_config->protocol = MSP_PCM_PROTOCOL;
+
+		ux500_msp_dai_compile_prot_desc_pcm(fmt, prot_desc);
+		ux500_msp_dai_setup_multichannel(private, msp_config);
+		ux500_msp_dai_setup_framing_pcm(private, rate, prot_desc);
+		break;
+	}
+
+	ux500_msp_dai_setup_clocking(fmt, msp_config);
+}
+
+static int ux500_msp_dai_prepare(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *dai)
+{
+	int ret = 0;
+	struct ux500_platform_drvdata *drvdata = &platform_drvdata[dai->id];
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct msp_config msp_config;
+	bool mode_playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
+
+	pr_debug("%s: MSP %d (%s): Enter.\n", __func__, dai->id, stream_str(substream));
+
+	/* If already configured -> not errors reported */
+	if (mode_playback) {
+		if ((drvdata->configured & PLAYBACK_CONFIGURED) &&
+			(drvdata->playback_active))
+			goto cleanup;
+	} else {
+		if ((drvdata->configured & CAPTURE_CONFIGURED) &&
+			(drvdata->capture_active))
+			goto cleanup;
+	}
+
+	pr_debug("%s: Setup dai (Rate: %u).\n", __func__, runtime->rate);
+	ux500_msp_dai_compile_msp_config(substream,
+					drvdata,
+					runtime->rate,
+					&msp_config);
+
+	ret = ux500_msp_i2s_open(drvdata->msp_i2s_drvdata, &msp_config);
+	if (ret < 0) {
+		pr_err("%s: Error: msp_setup failed (ret = %d)!\n", __func__, ret);
+		goto cleanup;
+	}
+
+	drvdata->configured |= mode_playback ?
+			PLAYBACK_CONFIGURED : CAPTURE_CONFIGURED;
+
+cleanup:
+	return ret;
+}
+
+static int ux500_msp_dai_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+	unsigned int mask, slots_active;
+	struct ux500_platform_drvdata *drvdata = &platform_drvdata[dai->id];
+
+	pr_debug("%s: MSP %d (%s): Enter.\n",
+			__func__,
+			dai->id,
+			stream_str(substream));
+
+	switch (drvdata->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		if (params_channels(params) != 2) {
+			pr_err("%s: Error: I2S requires channels = 2 "
+				"(channels = %d)!\n",
+				__func__,
+				params_channels(params));
+			return -EINVAL;
+		}
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+	case SND_SOC_DAIFMT_DSP_A:
+
+		mask = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
+			drvdata->tx_mask :
+			drvdata->rx_mask;
+
+		slots_active = hweight32(mask);
+
+		pr_debug("TDM slots active: %d", slots_active);
+
+		if (params_channels(params) != slots_active) {
+			pr_err("%s: Error: PCM TDM format requires channels "
+				"to match active slots "
+				"(channels = %d, active slots = %d)!\n",
+				__func__,
+				params_channels(params),
+				slots_active);
+			return -EINVAL;
+		}
+		break;
+
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+int ux500_msp_dai_set_data_delay(struct snd_soc_dai *dai, int delay)
+{
+	struct ux500_platform_drvdata *drvdata = &platform_drvdata[dai->id];
+
+	pr_debug("%s: MSP %d: Enter.\n", __func__, dai->id);
+
+	switch (delay) {
+	case MSP_DELAY_0:
+	case MSP_DELAY_1:
+	case MSP_DELAY_2:
+	case MSP_DELAY_3:
+		break;
+	default:
+		goto unsupported_delay;
+	}
+
+	drvdata->data_delay = delay;
+	return 0;
+
+unsupported_delay:
+	pr_err("%s: MSP %d: Error: Unsupported DAI delay (%d)!\n",
+		__func__,
+		dai->id,
+		delay);
+	return -EINVAL;
+}
+
+static int ux500_msp_dai_set_dai_fmt(struct snd_soc_dai *dai,
+				unsigned int fmt)
+{
+	struct ux500_platform_drvdata *drvdata = &platform_drvdata[dai->id];
+
+	pr_debug("%s: MSP %d: Enter.\n", __func__, dai->id);
+
+	switch (fmt & (SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_MASTER_MASK)) {
+	case SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS:
+	case SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM:
+	case SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBS_CFS:
+	case SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_CBM_CFM:
+	case SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_CBS_CFS:
+	case SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_CBM_CFM:
+		break;
+
+	default:
+		goto unsupported_format;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+	case SND_SOC_DAIFMT_NB_IF:
+	case SND_SOC_DAIFMT_IB_IF:
+		break;
+
+	default:
+		goto unsupported_format;
+	}
+
+	drvdata->fmt = fmt;
+	return 0;
+
+unsupported_format:
+	pr_err("%s: MSP %d: Error: Unsupported DAI format (0x%x)!\n",
+		__func__,
+		dai->id,
+		fmt);
+	return -EINVAL;
+}
+
+static int ux500_msp_dai_set_tdm_slot(struct snd_soc_dai *dai,
+				unsigned int tx_mask,
+				unsigned int rx_mask,
+				int slots,
+				int slot_width)
+{
+	struct ux500_platform_drvdata *drvdata = &platform_drvdata[dai->id];
+	unsigned int cap;
+
+	if (!(slots == 1 || slots == 2 || slots == 8 || slots == 16)) {
+		pr_err("%s: Error: Unsupported slots (%d)! "
+			"Supported values are 1/2/8/16.\n",
+			__func__,
+			slots);
+		return -EINVAL;
+	}
+	drvdata->slots = slots;
+
+	if (!(slot_width == 16)) {
+		pr_err("%s: Error: Unsupported slots_width (%d)!. "
+			"Supported value is 16.\n",
+			__func__,
+			slot_width);
+		return -EINVAL;
+	}
+	drvdata->slot_width = slot_width;
+
+	switch (slots) {
+	default:
+	case 1:
+		cap = 0x01;
+		break;
+	case 2:
+		cap = 0x03;
+		break;
+	case 8:
+		cap = 0xFF;
+		break;
+	case 16:
+		cap = 0xFFFF;
+		break;
+	}
+
+	drvdata->tx_mask = tx_mask & cap;
+	drvdata->rx_mask = rx_mask & cap;
+
+	return 0;
+}
+
+static int ux500_msp_dai_set_dai_sysclk(struct snd_soc_dai *dai,
+	int clk_id,
+	unsigned int freq,
+	int dir)
+{
+	struct ux500_platform_drvdata *drvdata = &platform_drvdata[dai->id];
+
+	pr_debug("%s: MSP %d: Enter. Clk id: %d, freq: %u.\n",
+		__func__,
+		dai->id,
+		clk_id,
+		freq);
+
+	switch (clk_id) {
+	case UX500_MSP_MASTER_CLOCK:
+		drvdata->master_clk = freq;
+		break;
+
+	default:
+		pr_err("%s: MSP %d: Invalid clkid: %d.\n",
+			__func__,
+			dai->id,
+			clk_id);
+	}
+
+	return 0;
+}
+
+static int ux500_msp_dai_trigger(struct snd_pcm_substream *substream,
+				int cmd,
+				struct snd_soc_dai *dai)
+{
+	int ret = 0;
+	struct ux500_platform_drvdata *drvdata = &platform_drvdata[dai->id];
+
+	pr_debug("%s: MSP %d (%s): Enter (msp->id = %d, cmd = %d).\n",
+		__func__,
+		dai->id,
+		stream_str(substream),
+		(int)drvdata->msp_i2s_drvdata->id,
+		cmd);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		ret = 0;
+		break;
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		ret = 0;
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		ret = 0;
+		break;
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		ret = 0;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static struct snd_soc_dai_driver ux500_msp_dai_drv[UX500_NBR_OF_DAI] = {
+	{
+		.name = "ux500-msp-i2s.0",
+		.id = 0,
+		.suspend = NULL,
+		.resume = NULL,
+		.playback = {
+			.channels_min = UX500_MSP_MIN_CHANNELS,
+			.channels_max = UX500_MSP_MAX_CHANNELS,
+			.rates = UX500_I2S_RATES,
+			.formats = UX500_I2S_FORMATS,
+		},
+		.capture = {
+			.channels_min = UX500_MSP_MIN_CHANNELS,
+			.channels_max = UX500_MSP_MAX_CHANNELS,
+			.rates = UX500_I2S_RATES,
+			.formats = UX500_I2S_FORMATS,
+		},
+		.ops = (struct snd_soc_dai_ops[]) {
+			{
+			.set_sysclk = ux500_msp_dai_set_dai_sysclk,
+			.set_fmt = ux500_msp_dai_set_dai_fmt,
+			.set_tdm_slot = ux500_msp_dai_set_tdm_slot,
+			.startup = ux500_msp_dai_startup,
+			.shutdown = ux500_msp_dai_shutdown,
+			.prepare = ux500_msp_dai_prepare,
+			.trigger = ux500_msp_dai_trigger,
+			.hw_params = ux500_msp_dai_hw_params,
+			}
+		},
+	},
+	{
+		.name = "ux500-msp-i2s.1",
+		.id = 1,
+		.suspend = NULL,
+		.resume = NULL,
+		.playback = {
+			.channels_min = UX500_MSP_MIN_CHANNELS,
+			.channels_max = UX500_MSP_MAX_CHANNELS,
+			.rates = UX500_I2S_RATES,
+			.formats = UX500_I2S_FORMATS,
+		},
+		.capture = {
+			.channels_min = UX500_MSP_MIN_CHANNELS,
+			.channels_max = UX500_MSP_MAX_CHANNELS,
+			.rates = UX500_I2S_RATES,
+			.formats = UX500_I2S_FORMATS,
+		},
+		.ops = (struct snd_soc_dai_ops[]) {
+			{
+			.set_sysclk = ux500_msp_dai_set_dai_sysclk,
+			.set_fmt = ux500_msp_dai_set_dai_fmt,
+			.set_tdm_slot = ux500_msp_dai_set_tdm_slot,
+			.startup = ux500_msp_dai_startup,
+			.shutdown = ux500_msp_dai_shutdown,
+			.prepare = ux500_msp_dai_prepare,
+			.trigger = ux500_msp_dai_trigger,
+			.hw_params = ux500_msp_dai_hw_params,
+			}
+		},
+	},
+	{
+		.name = "ux500-msp-i2s.2",
+		.id = 2,
+		.suspend = NULL,
+		.resume = NULL,
+		.playback = {
+			.channels_min = UX500_MSP_MIN_CHANNELS,
+			.channels_max = UX500_MSP_MAX_CHANNELS,
+			.rates = UX500_I2S_RATES,
+			.formats = UX500_I2S_FORMATS,
+		},
+		.capture = {
+			.channels_min = UX500_MSP_MIN_CHANNELS,
+			.channels_max = UX500_MSP_MAX_CHANNELS,
+			.rates = UX500_I2S_RATES,
+			.formats = UX500_I2S_FORMATS,
+		},
+		.ops = (struct snd_soc_dai_ops[]) {
+			{
+			.set_sysclk = ux500_msp_dai_set_dai_sysclk,
+			.set_fmt = ux500_msp_dai_set_dai_fmt,
+			.set_tdm_slot = ux500_msp_dai_set_tdm_slot,
+			.startup = ux500_msp_dai_startup,
+			.shutdown = ux500_msp_dai_shutdown,
+			.prepare = ux500_msp_dai_prepare,
+			.trigger = ux500_msp_dai_trigger,
+			.hw_params = ux500_msp_dai_hw_params,
+			}
+		},
+	},
+	{
+		.name = "ux500-msp-i2s.3",
+		.id = 3,
+		.suspend = NULL,
+		.resume = NULL,
+		.playback = {
+			.channels_min = UX500_MSP_MIN_CHANNELS,
+			.channels_max = UX500_MSP_MAX_CHANNELS,
+			.rates = UX500_I2S_RATES,
+			.formats = UX500_I2S_FORMATS,
+		},
+		.capture = {
+			.channels_min = UX500_MSP_MIN_CHANNELS,
+			.channels_max = UX500_MSP_MAX_CHANNELS,
+			.rates = UX500_I2S_RATES,
+			.formats = UX500_I2S_FORMATS,
+		},
+		.ops = (struct snd_soc_dai_ops[]) {
+			{
+			.set_sysclk = ux500_msp_dai_set_dai_sysclk,
+			.set_fmt = ux500_msp_dai_set_dai_fmt,
+			.set_tdm_slot = ux500_msp_dai_set_tdm_slot,
+			.startup = ux500_msp_dai_startup,
+			.shutdown = ux500_msp_dai_shutdown,
+			.prepare = ux500_msp_dai_prepare,
+			.trigger = ux500_msp_dai_trigger,
+			.hw_params = ux500_msp_dai_hw_params,
+			}
+		},
+	},
+};
+EXPORT_SYMBOL(ux500_msp_dai_drv);
+
+static int ux500_msp_drv_probe(struct platform_device *pdev)
+{
+	struct ux500_msp_i2s_drvdata *msp_i2s_drvdata;
+	struct ux500_platform_drvdata *drvdata;
+	struct msp_i2s_platform_data *platform_data;
+	int id;
+	int ret = 0;
+
+	pr_err("%s: Enter (pdev->name = %s).\n", __func__, pdev->name);
+
+	platform_data = (struct msp_i2s_platform_data *)pdev->dev.platform_data;
+	msp_i2s_drvdata = ux500_msp_i2s_init(pdev, platform_data);
+	if (!msp_i2s_drvdata) {
+		pr_err("%s: ERROR: ux500_msp_i2s_init failed!", __func__);
+		return -1;
+	}
+
+	id = msp_i2s_drvdata->id;
+	drvdata = &platform_drvdata[id];
+	drvdata->msp_i2s_drvdata = msp_i2s_drvdata;
+
+	pr_info("%s: Registering ux500-msp-dai SoC CPU-DAI.\n", __func__);
+	ret = snd_soc_register_dai(&pdev->dev, &ux500_msp_dai_drv[id]);
+	if (ret < 0) {
+		pr_err("Error: %s: Failed to register MSP %d.\n", __func__, id);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int ux500_msp_drv_remove(struct platform_device *pdev)
+{
+	struct ux500_msp_i2s_drvdata *msp_i2s_drvdata = dev_get_drvdata(&pdev->dev);
+	struct ux500_platform_drvdata *drvdata = &platform_drvdata[msp_i2s_drvdata->id];
+
+	pr_info("%s: Unregister ux500-msp-dai ASoC CPU-DAI.\n", __func__);
+	snd_soc_unregister_dais(&pdev->dev, ARRAY_SIZE(ux500_msp_dai_drv));
+
+	ux500_msp_i2s_exit(msp_i2s_drvdata);
+	drvdata->msp_i2s_drvdata = NULL;
+
+	return 0;
+}
+
+int ux500_msp_drv_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct ux500_msp_i2s_drvdata *msp_i2s_drvdata = dev_get_drvdata(&pdev->dev);
+
+	pr_debug("%s: Enter (pdev->name = %s).\n", __func__, pdev->name);
+
+	return ux500_msp_i2s_suspend(msp_i2s_drvdata);
+}
+
+int ux500_msp_drv_resume(struct platform_device *pdev)
+{
+	struct ux500_msp_i2s_drvdata *msp_i2s_drvdata = dev_get_drvdata(&pdev->dev);
+
+	pr_debug("%s: Enter (pdev->name = %s).\n", __func__, pdev->name);
+
+	return ux500_msp_i2s_resume(msp_i2s_drvdata);
+}
+
+static struct platform_driver msp_i2s_driver = {
+	.driver = {
+		.name = "ux500-msp-i2s",
+		.owner = THIS_MODULE,
+	},
+	.probe = ux500_msp_drv_probe,
+	.remove = ux500_msp_drv_remove,
+	.suspend = ux500_msp_drv_suspend,
+	.resume = ux500_msp_drv_resume,
+};
+
+static int __init ux500_msp_init(void)
+{
+	pr_info("%s: Register ux500-msp-dai platform driver.\n", __func__);
+	return platform_driver_register(&msp_i2s_driver);
+}
+
+static void __exit ux500_msp_exit(void)
+{
+	pr_info("%s: Unregister ux500-msp-dai platform driver.\n", __func__);
+	platform_driver_unregister(&msp_i2s_driver);
+}
+
+module_init(ux500_msp_init);
+module_exit(ux500_msp_exit);
+
+MODULE_LICENSE("GPLv2");
diff --git a/sound/soc/ux500/ux500_msp_dai.h b/sound/soc/ux500/ux500_msp_dai.h
new file mode 100644
index 0000000..b9625e6
--- /dev/null
+++ b/sound/soc/ux500/ux500_msp_dai.h
@@ -0,0 +1,83 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2011
+ *
+ * Author: Ola Lilja <ola.o.lilja@stericsson.com>,
+ *         Roger Nilsson <roger.xr.nilsson@stericsson.com>
+ *         for ST-Ericsson.
+ *
+ * License terms:
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#ifndef UX500_msp_dai_H
+#define UX500_msp_dai_H
+
+#include <linux/types.h>
+#include <linux/spinlock.h>
+
+#include <mach/msp.h>
+
+#define UX500_NBR_OF_DAI	4
+
+#define UX500_I2S_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |	\
+			SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)
+
+#define UX500_I2S_FORMATS (SNDRV_PCM_FMTBIT_S16_LE)
+
+#define FRAME_PER_SINGLE_SLOT_8_KHZ		31
+#define FRAME_PER_SINGLE_SLOT_16_KHZ	124
+#define FRAME_PER_SINGLE_SLOT_44_1_KHZ	63
+#define FRAME_PER_SINGLE_SLOT_48_KHZ	49
+#define FRAME_PER_2_SLOTS				31
+#define FRAME_PER_8_SLOTS				138
+#define FRAME_PER_16_SLOTS				277
+
+#ifndef CONFIG_SND_SOC_UX500_AB5500
+#define UX500_MSP_INTERNAL_CLOCK_FREQ  40000000
+#define UX500_MSP1_INTERNAL_CLOCK_FREQ UX500_MSP_INTERNAL_CLOCK_FREQ
+#else
+#define UX500_MSP_INTERNAL_CLOCK_FREQ 13000000
+#define UX500_MSP1_INTERNAL_CLOCK_FREQ (UX500_MSP_INTERNAL_CLOCK_FREQ * 2)
+#endif
+
+#define UX500_MSP_MIN_CHANNELS		1
+#define UX500_MSP_MAX_CHANNELS		8
+
+#define PLAYBACK_CONFIGURED		1
+#define CAPTURE_CONFIGURED		2
+
+enum ux500_msp_clock_id {
+	UX500_MSP_MASTER_CLOCK,
+};
+
+struct ux500_platform_drvdata {
+	struct ux500_msp_i2s_drvdata *msp_i2s_drvdata;
+	unsigned int fmt;
+	unsigned int tx_mask;
+	unsigned int rx_mask;
+	int slots;
+	int slot_width;
+	bool playback_active;
+	bool capture_active;
+	u8 configured;
+	int data_delay;
+	unsigned int master_clk;
+};
+
+extern struct snd_soc_dai ux500_msp_dai[UX500_NBR_OF_DAI];
+
+bool ux500_msp_dai_i2s_get_underrun_status(int dai_idx);
+int ux500_msp_dai_i2s_configure_sg(dma_addr_t dma_addr,
+				int perod_cnt,
+				size_t period_len,
+				int dai_idx,
+				int stream_id);
+int ux500_msp_dai_i2s_send_data(void *data, size_t bytes, int dai_idx);
+int ux500_msp_dai_i2s_receive_data(void *data, size_t bytes, int dai_idx);
+
+int ux500_msp_dai_set_data_delay(struct snd_soc_dai *dai, int delay);
+
+#endif
diff --git a/sound/soc/ux500/ux500_msp_i2s.c b/sound/soc/ux500/ux500_msp_i2s.c
new file mode 100644
index 0000000..c52012c
--- /dev/null
+++ b/sound/soc/ux500/ux500_msp_i2s.c
@@ -0,0 +1,1004 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2011
+ *
+ * Author: Ola Lilja <ola.o.lilja@stericsson.com>,
+ *         Sandeep Kaushik <sandeep.kaushik@st.com>
+ *         for ST-Ericsson.
+ *
+ * License terms:
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/regulator/consumer.h>
+#include <linux/mfd/dbx500-prcmu.h>
+
+#include <plat/ste_dma40.h>
+
+#include <mach/hardware.h>
+#include <mach/msp.h>
+
+#include "ux500_msp_i2s.h"
+
+ /* Protocol desciptors */
+static const struct msp_protocol_desc prot_descs[] = {
+	I2S_PROTOCOL_DESC,
+	PCM_PROTOCOL_DESC,
+	PCM_COMPAND_PROTOCOL_DESC,
+	AC97_PROTOCOL_DESC,
+	SPI_MASTER_PROTOCOL_DESC,
+	SPI_SLAVE_PROTOCOL_DESC,
+};
+
+static void ux500_msp_i2s_set_prot_desc_tx(struct msp *msp,
+					struct msp_protocol_desc *protocol_desc,
+					enum msp_data_size data_size)
+{
+	u32 temp_reg = 0;
+
+	temp_reg |= MSP_P2_ENABLE_BIT(protocol_desc->tx_phase_mode);
+	temp_reg |= MSP_P2_START_MODE_BIT(protocol_desc->tx_phase2_start_mode);
+	temp_reg |= MSP_P1_FRAME_LEN_BITS(protocol_desc->tx_frame_length_1);
+	temp_reg |= MSP_P2_FRAME_LEN_BITS(protocol_desc->tx_frame_length_2);
+	if (msp->def_elem_len) {
+		temp_reg |= MSP_P1_ELEM_LEN_BITS(protocol_desc->tx_element_length_1);
+		temp_reg |= MSP_P2_ELEM_LEN_BITS(protocol_desc->tx_element_length_2);
+		if (protocol_desc->tx_element_length_1 ==
+			protocol_desc->tx_element_length_2) {
+			msp->actual_data_size = protocol_desc->tx_element_length_1;
+		} else {
+			msp->actual_data_size = data_size;
+		}
+	} else {
+		temp_reg |= MSP_P1_ELEM_LEN_BITS(data_size);
+		temp_reg |= MSP_P2_ELEM_LEN_BITS(data_size);
+		msp->actual_data_size = data_size;
+	}
+	temp_reg |= MSP_DATA_DELAY_BITS(protocol_desc->tx_data_delay);
+	temp_reg |= MSP_SET_ENDIANNES_BIT(protocol_desc->tx_bit_transfer_format);
+	temp_reg |= MSP_FRAME_SYNC_POL(protocol_desc->tx_frame_sync_pol);
+	temp_reg |= MSP_DATA_WORD_SWAP(protocol_desc->tx_half_word_swap);
+	temp_reg |= MSP_SET_COMPANDING_MODE(protocol_desc->compression_mode);
+	temp_reg |= MSP_SET_FRAME_SYNC_IGNORE(protocol_desc->frame_sync_ignore);
+
+	writel(temp_reg, msp->registers + MSP_TCF);
+}
+
+static void ux500_msp_i2s_set_prot_desc_rx(struct msp *msp,
+					struct msp_protocol_desc *protocol_desc,
+					enum msp_data_size data_size)
+{
+	u32 temp_reg = 0;
+
+	temp_reg |= MSP_P2_ENABLE_BIT(protocol_desc->rx_phase_mode);
+	temp_reg |= MSP_P2_START_MODE_BIT(protocol_desc->rx_phase2_start_mode);
+	temp_reg |= MSP_P1_FRAME_LEN_BITS(protocol_desc->rx_frame_length_1);
+	temp_reg |= MSP_P2_FRAME_LEN_BITS(protocol_desc->rx_frame_length_2);
+	if (msp->def_elem_len) {
+		temp_reg |= MSP_P1_ELEM_LEN_BITS(protocol_desc->rx_element_length_1);
+		temp_reg |= MSP_P2_ELEM_LEN_BITS(protocol_desc->rx_element_length_2);
+		if (protocol_desc->rx_element_length_1 ==
+			protocol_desc->rx_element_length_2) {
+			msp->actual_data_size = protocol_desc->rx_element_length_1;
+		} else {
+			msp->actual_data_size = data_size;
+		}
+	} else {
+		temp_reg |= MSP_P1_ELEM_LEN_BITS(data_size);
+		temp_reg |= MSP_P2_ELEM_LEN_BITS(data_size);
+		msp->actual_data_size = data_size;
+	}
+
+	temp_reg |= MSP_DATA_DELAY_BITS(protocol_desc->rx_data_delay);
+	temp_reg |= MSP_SET_ENDIANNES_BIT(protocol_desc->rx_bit_transfer_format);
+	temp_reg |= MSP_FRAME_SYNC_POL(protocol_desc->rx_frame_sync_pol);
+	temp_reg |= MSP_DATA_WORD_SWAP(protocol_desc->rx_half_word_swap);
+	temp_reg |= MSP_SET_COMPANDING_MODE(protocol_desc->expansion_mode);
+	temp_reg |= MSP_SET_FRAME_SYNC_IGNORE(protocol_desc->frame_sync_ignore);
+
+	writel(temp_reg, msp->registers + MSP_RCF);
+
+}
+
+static int ux500_msp_i2s_configure_protocol(struct msp *msp,
+			      struct msp_config *config)
+{
+	int direction;
+	struct msp_protocol_desc *protocol_desc;
+	enum msp_data_size data_size;
+	u32 temp_reg = 0;
+
+	data_size = config->data_size;
+	msp->def_elem_len = config->def_elem_len;
+	direction = config->direction;
+	if (config->default_protocol_desc == 1) {
+		if (config->protocol >= MSP_INVALID_PROTOCOL) {
+			pr_err("%s: ERROR: Invalid protocol!\n", __func__);
+			return -EINVAL;
+		}
+		protocol_desc =
+		    (struct msp_protocol_desc *)&prot_descs[config->protocol];
+	} else {
+		protocol_desc = (struct msp_protocol_desc *)&config->protocol_desc;
+	}
+
+	if (data_size < MSP_DATA_BITS_DEFAULT || data_size > MSP_DATA_BITS_32) {
+		pr_err("%s: ERROR: Invalid data-size requested (data_size = %d)!\n",
+			__func__, data_size);
+		return -EINVAL;
+	}
+
+	switch (direction) {
+	case MSP_TRANSMIT_MODE:
+		ux500_msp_i2s_set_prot_desc_tx(msp, protocol_desc, data_size);
+		break;
+	case MSP_RECEIVE_MODE:
+		ux500_msp_i2s_set_prot_desc_rx(msp, protocol_desc, data_size);
+		break;
+	case MSP_BOTH_T_R_MODE:
+		ux500_msp_i2s_set_prot_desc_tx(msp, protocol_desc, data_size);
+		ux500_msp_i2s_set_prot_desc_rx(msp, protocol_desc, data_size);
+		break;
+	default:
+		pr_err("%s: ERROR: Invalid direction requested (direction = %d)!\n",
+			__func__, direction);
+		return -EINVAL;
+	}
+
+	/* The below code is needed for both Rx and Tx path. Can't separate them. */
+	temp_reg = readl(msp->registers + MSP_GCR) & ~TX_CLK_POL_RISING;
+	temp_reg |= MSP_TX_CLKPOL_BIT(~protocol_desc->tx_clock_pol);
+	writel(temp_reg, msp->registers + MSP_GCR);
+	temp_reg = readl(msp->registers + MSP_GCR) & ~RX_CLK_POL_RISING;
+	temp_reg |= MSP_RX_CLKPOL_BIT(protocol_desc->rx_clock_pol);
+	writel(temp_reg, msp->registers + MSP_GCR);
+
+	return 0;
+}
+
+static int ux500_msp_i2s_configure_clock(struct msp *msp, struct msp_config *config)
+{
+	u32 reg_val_GCR;
+	u32 frame_per = 0;
+	u32 sck_div = 0;
+	u32 frame_width = 0;
+	u32 temp_reg = 0;
+	u32 bit_clock = 0;
+	struct msp_protocol_desc *protocol_desc = NULL;
+
+	reg_val_GCR = readl(msp->registers + MSP_GCR);
+	writel(reg_val_GCR & ~SRG_ENABLE, msp->registers + MSP_GCR);
+
+	if (config->default_protocol_desc)
+		protocol_desc =
+			(struct msp_protocol_desc *)&prot_descs[config->protocol];
+	else
+		protocol_desc = (struct msp_protocol_desc *)&config->protocol_desc;
+
+	switch (config->protocol) {
+	case MSP_PCM_PROTOCOL:
+	case MSP_PCM_COMPAND_PROTOCOL:
+		frame_width = protocol_desc->frame_width;
+		sck_div = config->input_clock_freq / (config->frame_freq *
+			(protocol_desc->total_clocks_for_one_frame));
+		frame_per = protocol_desc->frame_period;
+		break;
+	case MSP_I2S_PROTOCOL:
+		frame_width = protocol_desc->frame_width;
+		sck_div = config->input_clock_freq / (config->frame_freq *
+			(protocol_desc->total_clocks_for_one_frame));
+		frame_per = protocol_desc->frame_period;
+		break;
+	case MSP_AC97_PROTOCOL:
+		/* Not supported */
+		pr_err("%s: ERROR: AC97 protocol not supported!\n", __func__);
+		return -ENOSYS;
+	default:
+		pr_err("%s: ERROR: Unknown protocol (%d)!\n",
+			__func__,
+			config->protocol);
+		return -EINVAL;
+	}
+
+	temp_reg = (sck_div - 1) & SCK_DIV_MASK;
+	temp_reg |= FRAME_WIDTH_BITS(frame_width);
+	temp_reg |= FRAME_PERIOD_BITS(frame_per);
+	writel(temp_reg, msp->registers + MSP_SRG);
+
+	bit_clock = (config->input_clock_freq)/(sck_div + 1);
+	/* If the bit clock is higher than 19.2MHz, Vape should be run in 100% OPP
+	 * Only consider OPP 100% when bit-clock is used, i.e. MSP master mode
+	 */
+	if ((bit_clock > 19200000) && ((config->tx_clock_sel != 0) || (config->rx_clock_sel != 0))) {
+		prcmu_qos_update_requirement(PRCMU_QOS_APE_OPP, "ux500-msp-i2s", 100);
+		msp->vape_opp_constraint = 1;
+	} else {
+		prcmu_qos_update_requirement(PRCMU_QOS_APE_OPP, "ux500-msp-i2s", 50);
+		msp->vape_opp_constraint = 0;
+	}
+
+	/* Enable clock */
+	udelay(100);
+	reg_val_GCR = readl(msp->registers + MSP_GCR);
+	writel(reg_val_GCR | SRG_ENABLE, msp->registers + MSP_GCR);
+	udelay(100);
+
+	return 0;
+}
+
+static int ux500_msp_i2s_configure_multichannel(struct msp *msp, struct msp_config *config)
+{
+	struct msp_protocol_desc *protocol_desc;
+	struct msp_multichannel_config *mcfg;
+	u32 reg_val_MCR;
+
+	if (config->default_protocol_desc == 1) {
+		if (config->protocol >= MSP_INVALID_PROTOCOL) {
+			pr_err("%s: ERROR: Invalid protocol (%d)!\n",
+				__func__,
+				config->protocol);
+			return -EINVAL;
+		}
+		protocol_desc = (struct msp_protocol_desc *)
+				&prot_descs[config->protocol];
+	} else {
+		protocol_desc = (struct msp_protocol_desc *)&config->protocol_desc;
+	}
+
+	mcfg = &config->multichannel_config;
+	if (mcfg->tx_multichannel_enable) {
+		if (protocol_desc->tx_phase_mode == MSP_SINGLE_PHASE) {
+			reg_val_MCR = readl(msp->registers + MSP_MCR);
+			writel(reg_val_MCR |
+				(mcfg->tx_multichannel_enable ? 1 << TMCEN_BIT : 0),
+				msp->registers + MSP_MCR);
+			writel(mcfg->tx_channel_0_enable,
+					msp->registers + MSP_TCE0);
+			writel(mcfg->tx_channel_1_enable,
+					msp->registers + MSP_TCE1);
+			writel(mcfg->tx_channel_2_enable,
+					msp->registers + MSP_TCE2);
+			writel(mcfg->tx_channel_3_enable,
+					msp->registers + MSP_TCE3);
+		} else {
+			pr_err("%s: ERROR: Only single-phase supported (TX-mode: %d)!\n",
+				__func__, protocol_desc->tx_phase_mode);
+			return -EINVAL;
+		}
+	}
+	if (mcfg->rx_multichannel_enable) {
+		if (protocol_desc->rx_phase_mode == MSP_SINGLE_PHASE) {
+			reg_val_MCR = readl(msp->registers + MSP_MCR);
+			writel(reg_val_MCR |
+				(mcfg->rx_multichannel_enable ? 1 << RMCEN_BIT : 0),
+				msp->registers + MSP_MCR);
+			writel(mcfg->rx_channel_0_enable,
+					msp->registers + MSP_RCE0);
+			writel(mcfg->rx_channel_1_enable,
+					msp->registers + MSP_RCE1);
+			writel(mcfg->rx_channel_2_enable,
+					msp->registers + MSP_RCE2);
+			writel(mcfg->rx_channel_3_enable,
+					msp->registers + MSP_RCE3);
+		} else {
+			pr_err("%s: ERROR: Only single-phase supported (RX-mode: %d)!\n",
+				__func__, protocol_desc->rx_phase_mode);
+			return -EINVAL;
+		}
+		if (mcfg->rx_comparison_enable_mode) {
+			reg_val_MCR = readl(msp->registers + MSP_MCR);
+			writel(reg_val_MCR |
+					(mcfg->rx_comparison_enable_mode << RCMPM_BIT),
+					msp->registers + MSP_MCR);
+
+			writel(mcfg->comparison_mask,
+					msp->registers + MSP_RCM);
+			writel(mcfg->comparison_value,
+					msp->registers + MSP_RCV);
+
+		}
+	}
+
+	return 0;
+}
+
+void ux500_msp_i2s_configure_dma(struct msp *msp, struct msp_config *config)
+{
+	struct stedma40_chan_cfg *rx_dma_info = msp->dma_cfg_rx;
+	struct stedma40_chan_cfg *tx_dma_info = msp->dma_cfg_tx;
+	dma_cap_mask_t mask;
+	u16 word_width;
+	bool rx_active, tx_active;
+
+	if (msp->tx_pipeid != NULL) {
+		dma_release_channel(msp->tx_pipeid);
+		msp->tx_pipeid = NULL;
+	}
+
+	switch (config->data_size) {
+	case MSP_DATA_BITS_32:
+		word_width = STEDMA40_WORD_WIDTH;
+		break;
+	case MSP_DATA_BITS_16:
+		word_width = STEDMA40_HALFWORD_WIDTH;
+		break;
+	case MSP_DATA_BITS_8:
+		word_width = STEDMA40_BYTE_WIDTH;
+		break;
+	default:
+		word_width = STEDMA40_WORD_WIDTH;
+		pr_warn("%s: Unknown data-size (%d)! Assuming 32 bits.\n",
+			__func__, config->data_size);
+	}
+
+	rx_active = (config->direction == MSP_RECEIVE_MODE ||
+		config->direction == MSP_BOTH_T_R_MODE);
+	tx_active = (config->direction == MSP_TRANSMIT_MODE ||
+		config->direction == MSP_BOTH_T_R_MODE);
+
+	if (rx_active) {
+		rx_dma_info->src_info.data_width = word_width;
+		rx_dma_info->dst_info.data_width = word_width;
+	}
+	if (tx_active) {
+		tx_dma_info->src_info.data_width = word_width;
+		tx_dma_info->dst_info.data_width = word_width;
+	}
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	if (rx_active)
+		msp->rx_pipeid = dma_request_channel(mask, stedma40_filter, rx_dma_info);
+
+	if (tx_active)
+		msp->tx_pipeid = dma_request_channel(mask, stedma40_filter, tx_dma_info);
+}
+
+static int ux500_msp_i2s_dma_xfer(struct msp *msp, struct i2s_message *msg)
+{
+	dma_cookie_t status_submit;
+	int direction, enable_bit;
+	u32 reg_val_GCR;
+	struct dma_chan *pipeid;
+	struct dma_async_tx_descriptor *cdesc;
+
+	if (msg->i2s_direction == I2S_DIRECTION_TX) {
+		direction = DMA_TO_DEVICE;
+		pipeid = msp->tx_pipeid;
+		enable_bit = TX_ENABLE;
+		pr_debug("%s: Direction: TX\n", __func__);
+	} else {
+		direction = DMA_FROM_DEVICE;
+		pipeid = msp->rx_pipeid;
+		enable_bit = RX_ENABLE;
+		pr_debug("%s: Direction: RX\n", __func__);
+	}
+
+	pr_debug("%s: msg->buf_addr = %p\n", __func__, (void *)msg->buf_addr);
+	pr_debug("%s: buf_len = %d\n", __func__, msg->buf_len);
+	pr_debug("%s: perios_len = %d\n", __func__, msg->period_len);
+
+	/* setup the cyclic description */
+	cdesc = pipeid->device->device_prep_dma_cyclic(pipeid,
+						msg->buf_addr,
+						msg->buf_len,
+						msg->period_len,
+						direction);
+	if (IS_ERR(cdesc)) {
+		pr_err("%s: ERROR: device_prep_dma_cyclic failed (%ld)!\n",
+			__func__,
+			PTR_ERR(cdesc));
+		return -EINVAL;
+	}
+
+	/* Submit to the dma */
+	if (msg->i2s_direction == I2S_DIRECTION_TX) {
+		cdesc->callback = msp->xfer_data.tx_handler;
+		cdesc->callback_param = msp->xfer_data.tx_callback_data;
+	} else {
+		cdesc->callback = msp->xfer_data.rx_handler;
+		cdesc->callback_param = msp->xfer_data.rx_callback_data;
+	}
+	status_submit = dmaengine_submit(cdesc);
+	if (dma_submit_error(status_submit)) {
+		pr_err("%s: ERROR: dmaengine_submit failed!\n", __func__);
+		return -EINVAL;
+	}
+
+	/* Start the dma */
+	dma_async_issue_pending(pipeid);
+	reg_val_GCR = readl(msp->registers + MSP_GCR);
+	writel(reg_val_GCR | enable_bit, msp->registers + MSP_GCR);
+
+	return 0;
+}
+
+static int ux500_msp_i2s_enable(struct msp *msp, struct msp_config *config)
+{
+	int status = 0;
+	u32 reg_val_DMACR, reg_val_GCR;
+
+	if (config->work_mode != MSP_DMA_MODE) {
+		pr_err("%s: ERROR: Only DMA-mode is supported (msp->work_mode = %d)\n",
+			__func__,
+			msp->work_mode);
+		return -EINVAL;
+	}
+	msp->work_mode = config->work_mode;
+
+	/* Check msp state whether in RUN or CONFIGURED Mode */
+	if (msp->msp_state == MSP_STATE_IDLE) {
+		if (msp->plat_init) {
+			status = msp->plat_init();
+			if (status) {
+				pr_err("%s: ERROR: Failed to init MSP (%d)!\n",
+					__func__,
+					status);
+				return status;
+			}
+		}
+	}
+
+	/* Configure msp with protocol dependent settings */
+	ux500_msp_i2s_configure_protocol(msp, config);
+	ux500_msp_i2s_configure_clock(msp, config);
+	if (config->multichannel_configured == 1) {
+		status = ux500_msp_i2s_configure_multichannel(msp, config);
+		if (status)
+			pr_warn("%s: WARN: ux500_msp_i2s_configure_multichannel failed (%d)!\n",
+				__func__, status);
+	}
+
+	/* Make sure the correct DMA-directions are configured */
+	if ((config->direction == MSP_RECEIVE_MODE) ||
+		(config->direction == MSP_BOTH_T_R_MODE))
+		if (!msp->dma_cfg_rx) {
+			pr_err("%s: ERROR: MSP RX-mode is not configured!", __func__);
+			return -EINVAL;
+		}
+	if ((config->direction == MSP_TRANSMIT_MODE) ||
+		(config->direction == MSP_BOTH_T_R_MODE))
+		if (!msp->dma_cfg_tx) {
+			pr_err("%s: ERROR: MSP TX-mode is not configured!", __func__);
+			return -EINVAL;
+		}
+
+	reg_val_DMACR = readl(msp->registers + MSP_DMACR);
+	switch (config->direction) {
+	case MSP_TRANSMIT_MODE:
+		writel(reg_val_DMACR | TX_DMA_ENABLE,
+				msp->registers + MSP_DMACR);
+
+		msp->xfer_data.tx_handler = config->handler;
+		msp->xfer_data.tx_callback_data = config->tx_callback_data;
+
+		break;
+	case MSP_RECEIVE_MODE:
+		writel(reg_val_DMACR | RX_DMA_ENABLE,
+				msp->registers + MSP_DMACR);
+
+		msp->xfer_data.rx_handler = config->handler;
+		msp->xfer_data.rx_callback_data = config->rx_callback_data;
+
+		break;
+	case MSP_BOTH_T_R_MODE:
+		writel(reg_val_DMACR | RX_DMA_ENABLE | TX_DMA_ENABLE,
+				msp->registers + MSP_DMACR);
+
+		msp->xfer_data.tx_handler = config->handler;
+		msp->xfer_data.rx_handler = config->handler;
+		msp->xfer_data.tx_callback_data = config->tx_callback_data;
+		msp->xfer_data.rx_callback_data = config->rx_callback_data;
+
+		break;
+	default:
+		pr_err("%s: ERROR: Illegal MSP direction (config->direction = %d)!",
+			__func__,
+			config->direction);
+		if (msp->plat_exit)
+			msp->plat_exit();
+		return -EINVAL;
+	}
+	ux500_msp_i2s_configure_dma(msp, config);
+
+	msp->transfer = ux500_msp_i2s_dma_xfer;
+
+	writel(config->iodelay, msp->registers + MSP_IODLY);
+
+	/* Enable frame generation logic */
+	reg_val_GCR = readl(msp->registers + MSP_GCR);
+	writel(reg_val_GCR | FRAME_GEN_ENABLE, msp->registers + MSP_GCR);
+
+	return status;
+}
+
+static void flush_fifo_rx(struct msp *msp)
+{
+	u32 reg_val_DR, reg_val_GCR, reg_val_FLR;
+	u32 limit = 32;
+
+	reg_val_GCR = readl(msp->registers + MSP_GCR);
+	writel(reg_val_GCR | RX_ENABLE, msp->registers + MSP_GCR);
+
+	reg_val_FLR = readl(msp->registers + MSP_FLR);
+	while (!(reg_val_FLR & RX_FIFO_EMPTY) && limit--) {
+		reg_val_DR = readl(msp->registers + MSP_DR);
+		reg_val_FLR = readl(msp->registers + MSP_FLR);
+	}
+
+	writel(reg_val_GCR, msp->registers + MSP_GCR);
+}
+
+static void flush_fifo_tx(struct msp *msp)
+{
+	u32 reg_val_TSTDR, reg_val_GCR, reg_val_FLR;
+	u32 limit = 32;
+
+	reg_val_GCR = readl(msp->registers + MSP_GCR);
+	writel(reg_val_GCR | TX_ENABLE, msp->registers + MSP_GCR);
+	writel(MSP_ITCR_ITEN | MSP_ITCR_TESTFIFO, msp->registers + MSP_ITCR);
+
+	reg_val_FLR = readl(msp->registers + MSP_FLR);
+	while (!(reg_val_FLR & TX_FIFO_EMPTY) && limit--) {
+		reg_val_TSTDR = readl(msp->registers + MSP_TSTDR);
+		reg_val_FLR = readl(msp->registers + MSP_FLR);
+	}
+	writel(0x0, msp->registers + MSP_ITCR);
+	writel(reg_val_GCR, msp->registers + MSP_GCR);
+}
+
+int ux500_msp_i2s_open(struct ux500_msp_i2s_drvdata *drvdata, struct msp_config *msp_config)
+{
+	struct msp *msp = drvdata->msp;
+	u32 old_reg, new_reg, mask;
+	int res;
+
+	if (in_interrupt()) {
+		pr_err("%s: ERROR: Open called in interrupt context!\n", __func__);
+		return -1;
+	}
+
+	/* Two simultanous configuring msp is avoidable */
+	down(&msp->lock);
+
+	/* Don't enable regulator if its msp1 or msp3 */
+	if (!(msp->reg_enabled) && msp->id != MSP_1_I2S_CONTROLLER
+				&& msp->id != MSP_3_I2S_CONTROLLER) {
+		res = regulator_enable(drvdata->reg_vape);
+		if (res != 0) {
+			pr_err("%s: Failed to enable regulator!\n", __func__);
+			up(&msp->lock);
+			return res;
+		}
+		msp->reg_enabled = 1;
+	}
+
+	switch (msp->users) {
+	case 0:
+		clk_enable(msp->clk);
+		msp->direction = msp_config->direction;
+		break;
+	case 1:
+		if (msp->direction == MSP_BOTH_T_R_MODE ||
+		    msp_config->direction == msp->direction ||
+		    msp_config->direction == MSP_BOTH_T_R_MODE) {
+			pr_warn("%s: WARN: MSP is in use (direction = %d)!\n",
+				__func__, msp_config->direction);
+			up(&msp->lock);
+			return -EBUSY;
+		}
+		msp->direction = MSP_BOTH_T_R_MODE;
+		break;
+	default:
+		pr_warn("%s: MSP in use in (both directions)!\n", __func__);
+		up(&msp->lock);
+		return -EBUSY;
+	}
+	msp->users++;
+
+	/* First do the global config register */
+	mask =
+	    RX_CLK_SEL_MASK | TX_CLK_SEL_MASK | RX_FRAME_SYNC_MASK |
+	    TX_FRAME_SYNC_MASK | RX_SYNC_SEL_MASK | TX_SYNC_SEL_MASK |
+	    RX_FIFO_ENABLE_MASK | TX_FIFO_ENABLE_MASK | SRG_CLK_SEL_MASK |
+	    LOOPBACK_MASK | TX_EXTRA_DELAY_MASK;
+
+	new_reg = (msp_config->tx_clock_sel | msp_config->rx_clock_sel |
+		msp_config->rx_frame_sync_pol | msp_config->tx_frame_sync_pol |
+		msp_config->rx_frame_sync_sel | msp_config->tx_frame_sync_sel |
+		msp_config->rx_fifo_config | msp_config->tx_fifo_config |
+		msp_config->srg_clock_sel | msp_config->loopback_enable |
+		msp_config->tx_data_enable);
+
+	old_reg = readl(msp->registers + MSP_GCR);
+	old_reg &= ~mask;
+	new_reg |= old_reg;
+	writel(new_reg, msp->registers + MSP_GCR);
+
+	if (ux500_msp_i2s_enable(msp, msp_config) != 0) {
+		pr_err("%s: ERROR: ux500_msp_i2s_enable failed!\n", __func__);
+		return -EBUSY;
+	}
+	if (msp_config->loopback_enable & 0x80)
+		msp->loopback_enable = 1;
+
+	/* Flush FIFOs */
+	flush_fifo_tx(msp);
+	flush_fifo_rx(msp);
+
+	msp->msp_state = MSP_STATE_CONFIGURED;
+	up(&msp->lock);
+	return 0;
+}
+
+static void func_notify_timer(unsigned long data)
+{
+	struct msp *msp = (struct msp *)data;
+	if (msp->polling_flag) {
+		msp->msp_io_error = 1;
+		pr_err("%s: ERROR: Polling timeout!\n", __func__);
+		del_timer(&msp->notify_timer);
+	}
+}
+
+int ux500_msp_i2s_transfer(struct ux500_msp_i2s_drvdata *drvdata, struct i2s_message *message)
+{
+	struct msp *msp = drvdata->msp;
+	int status = 0;
+
+	if (!message || (msp->msp_state == MSP_STATE_IDLE)) {
+		pr_err("%s: ERROR: i2s_message == NULL!\n", __func__);
+		return -EINVAL;
+	}
+	if (msp->msp_state == MSP_STATE_IDLE) {
+		pr_err("%s: ERROR: MSP in idle-state!\n", __func__);
+		return -EPERM;
+	}
+
+	msp->msp_state = MSP_STATE_RUN;
+	if (msp->transfer)
+		status = msp->transfer(msp, message);
+
+	if (msp->msp_state == MSP_STATE_RUN)
+		msp->msp_state = MSP_STATE_CONFIGURED;
+
+	return status;
+}
+
+static void ux500_msp_i2s_disable_rx(struct msp *msp)
+{
+	u32 reg_val_GCR, reg_val_DMACR, reg_val_IMSC;
+
+	reg_val_GCR = readl(msp->registers + MSP_GCR);
+	writel(reg_val_GCR & ~RX_ENABLE, msp->registers + MSP_GCR);
+	reg_val_DMACR = readl(msp->registers + MSP_DMACR);
+	writel(reg_val_DMACR & ~RX_DMA_ENABLE, msp->registers + MSP_DMACR);
+	reg_val_IMSC = readl(msp->registers + MSP_IMSC);
+	writel(reg_val_IMSC &
+			~(RECEIVE_SERVICE_INT | RECEIVE_OVERRUN_ERROR_INT),
+			msp->registers + MSP_IMSC);
+	msp->xfer_data.message.rxbytes = 0;
+	msp->xfer_data.message.rx_offset = 0;
+	msp->xfer_data.message.rxdata = NULL;
+	msp->read = NULL;
+}
+
+static void ux500_msp_i2s_disable_tx(struct msp *msp)
+{
+	u32 reg_val_GCR, reg_val_DMACR, reg_val_IMSC;
+
+	reg_val_GCR = readl(msp->registers + MSP_GCR);
+	writel(reg_val_GCR & ~TX_ENABLE, msp->registers + MSP_GCR);
+	reg_val_DMACR = readl(msp->registers + MSP_DMACR);
+	writel(reg_val_DMACR & ~TX_DMA_ENABLE, msp->registers + MSP_DMACR);
+	reg_val_IMSC = readl(msp->registers + MSP_IMSC);
+	writel(reg_val_IMSC &
+			~(TRANSMIT_SERVICE_INT | TRANSMIT_UNDERRUN_ERR_INT),
+			msp->registers + MSP_IMSC);
+	msp->xfer_data.message.txbytes = 0;
+	msp->xfer_data.message.tx_offset = 0;
+	msp->xfer_data.message.txdata = NULL;
+	msp->write = NULL;
+}
+
+static int ux500_msp_i2s_disable(struct msp *msp, int direction, enum i2s_flag flag)
+{
+	u32 reg_val_GCR;
+	int status = 0;
+
+	reg_val_GCR = readl(msp->registers + MSP_GCR);
+	if (!(reg_val_GCR & (TX_ENABLE | RX_ENABLE)))
+		return 0;
+
+	if (flag == DISABLE_ALL || flag == DISABLE_TRANSMIT) {
+		if (msp->tx_pipeid != NULL) {
+			dmaengine_terminate_all(msp->tx_pipeid);
+			dma_release_channel(msp->tx_pipeid);
+			msp->tx_pipeid = NULL;
+		}
+	}
+	if ((flag == DISABLE_ALL || flag == DISABLE_RECEIVE)) {
+		if (msp->rx_pipeid != NULL) {
+			dmaengine_terminate_all(msp->rx_pipeid);
+			dma_release_channel(msp->rx_pipeid);
+			msp->rx_pipeid = NULL;
+		}
+	}
+
+	if (flag == DISABLE_TRANSMIT)
+		ux500_msp_i2s_disable_tx(msp);
+	else if (flag == DISABLE_RECEIVE)
+		ux500_msp_i2s_disable_rx(msp);
+	else {
+		reg_val_GCR = readl(msp->registers + MSP_GCR);
+		writel(reg_val_GCR | LOOPBACK_MASK,
+				msp->registers + MSP_GCR);
+
+		/* Flush TX-FIFO */
+		flush_fifo_tx(msp);
+
+		/* Disable TX-channel */
+		writel((readl(msp->registers + MSP_GCR) &
+			       (~TX_ENABLE)), msp->registers + MSP_GCR);
+
+		/* Flush RX-FIFO */
+		flush_fifo_rx(msp);
+
+		/* Disable Loopback and Receive channel */
+		writel((readl(msp->registers + MSP_GCR) &
+				(~(RX_ENABLE | LOOPBACK_MASK))),
+				msp->registers + MSP_GCR);
+
+		ux500_msp_i2s_disable_tx(msp);
+		ux500_msp_i2s_disable_rx(msp);
+
+	}
+
+	/* disable sample rate and frame generators */
+	if (flag == DISABLE_ALL) {
+		msp->msp_state = MSP_STATE_IDLE;
+		writel((readl(msp->registers + MSP_GCR) &
+			       (~(FRAME_GEN_ENABLE | SRG_ENABLE))),
+			      msp->registers + MSP_GCR);
+		memset(&msp->xfer_data, 0, sizeof(struct trans_data));
+		if (msp->plat_exit)
+			status = msp->plat_exit();
+			if (status)
+				pr_warn("%s: WARN: ux500_msp_i2s_exit failed (%d)!\n",
+					__func__, status);
+		msp->transfer = NULL;
+		writel(0, msp->registers + MSP_GCR);
+		writel(0, msp->registers + MSP_TCF);
+		writel(0, msp->registers + MSP_RCF);
+		writel(0, msp->registers + MSP_DMACR);
+		writel(0, msp->registers + MSP_SRG);
+		writel(0, msp->registers + MSP_MCR);
+		writel(0, msp->registers + MSP_RCM);
+		writel(0, msp->registers + MSP_RCV);
+		writel(0, msp->registers + MSP_TCE0);
+		writel(0, msp->registers + MSP_TCE1);
+		writel(0, msp->registers + MSP_TCE2);
+		writel(0, msp->registers + MSP_TCE3);
+		writel(0, msp->registers + MSP_RCE0);
+		writel(0, msp->registers + MSP_RCE1);
+		writel(0, msp->registers + MSP_RCE2);
+		writel(0, msp->registers + MSP_RCE3);
+	}
+
+	return status;
+}
+
+int ux500_msp_i2s_close(struct ux500_msp_i2s_drvdata *drvdata, enum i2s_flag flag)
+{
+	struct msp *msp = drvdata->msp;
+	int status = 0;
+
+	pr_debug("%s: Enter.\n", __func__);
+
+	down(&msp->lock);
+
+	if (msp->users == 0) {
+		pr_err("%s: ERROR: MSP already closed!\n", __func__);
+		status = -EINVAL;
+		goto end;
+	}
+	pr_debug("%s: msp->users = %d, flag = %d\n", __func__, msp->users, flag);
+
+	/* We need to call it twice for DISABLE_ALL*/
+	msp->users = flag == DISABLE_ALL ? 0 : msp->users - 1;
+	if (msp->users)
+		status = ux500_msp_i2s_disable(msp, MSP_BOTH_T_R_MODE, flag);
+	else {
+		status = ux500_msp_i2s_disable(msp, MSP_BOTH_T_R_MODE, DISABLE_ALL);
+		clk_disable(msp->clk);
+		if (msp->reg_enabled) {
+			status = regulator_disable(drvdata->reg_vape);
+			msp->reg_enabled = 0;
+		}
+		if (status != 0) {
+			pr_err("%s: ERROR: Failed to disable regulator (%d)!\n",
+				__func__, status);
+			clk_enable(msp->clk);
+			goto end;
+		}
+	}
+	if (status)
+		goto end;
+	if (msp->users)
+		msp->direction = flag == DISABLE_TRANSMIT ?
+			MSP_RECEIVE_MODE : MSP_TRANSMIT_MODE;
+
+	if (msp->vape_opp_constraint == 1) {
+		prcmu_qos_update_requirement(PRCMU_QOS_APE_OPP, "ux500_msp_i2s", 50);
+		msp->vape_opp_constraint = 0;
+	}
+end:
+	up(&msp->lock);
+	return status;
+
+}
+
+int ux500_msp_i2s_hw_status(struct ux500_msp_i2s_drvdata *drvdata)
+{
+	struct msp *msp = drvdata->msp;
+	int status;
+
+	pr_debug("%s: Enter.\n", __func__);
+
+	status = readl(msp->registers + MSP_RIS) & 0xee;
+	if (status)
+		writel(status, msp->registers + MSP_ICR);
+
+	return status;
+}
+
+struct ux500_msp_i2s_drvdata *ux500_msp_i2s_init(struct platform_device *pdev,
+					struct msp_i2s_platform_data *platform_data)
+{
+	struct ux500_msp_i2s_drvdata *msp_i2s_drvdata;
+	int irq;
+	struct resource *res = NULL;
+	struct i2s_controller *i2s_cont;
+	struct msp *msp;
+
+	pr_debug("%s: Enter (pdev->name = %s).\n", __func__, pdev->name);
+
+	msp_i2s_drvdata = kzalloc(sizeof(struct ux500_msp_i2s_drvdata), GFP_KERNEL);
+	msp_i2s_drvdata->msp = kzalloc(sizeof(struct msp), GFP_KERNEL);
+	msp = msp_i2s_drvdata->msp;
+
+	msp->id = platform_data->id;
+	msp_i2s_drvdata->id = msp->id;
+	pr_debug("msp_i2s_drvdata->id = %d\n", msp_i2s_drvdata->id);
+
+	msp->plat_init = platform_data->msp_i2s_init;
+	msp->plat_exit = platform_data->msp_i2s_exit;
+	msp->dma_cfg_rx = platform_data->msp_i2s_dma_rx;
+	msp->dma_cfg_tx = platform_data->msp_i2s_dma_tx;
+
+	sema_init(&msp->lock, 1);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL) {
+		pr_err("%s: ERROR: Unable to get resource!\n", __func__);
+		goto free_msp;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		goto free_msp;
+	msp->irq = irq;
+
+	msp->registers = ioremap(res->start, (res->end - res->start + 1));
+	if (msp->registers == NULL)
+		goto free_msp;
+
+	msp_i2s_drvdata->reg_vape = regulator_get(NULL, "v-ape");
+	if (IS_ERR(msp_i2s_drvdata->reg_vape)) {
+		pr_err("%s: ERROR: Failed to get Vape supply (%d)!\n",
+			__func__, (int)PTR_ERR(msp_i2s_drvdata->reg_vape));
+		goto free_irq;
+	}
+	dev_set_drvdata(&pdev->dev, msp_i2s_drvdata);
+
+	prcmu_qos_add_requirement(PRCMU_QOS_APE_OPP, (char *)pdev->name, 50);
+	msp->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(msp->clk)) {
+		pr_err("%s: ERROR: clk_get failed (%d)!\n",
+			__func__, (int)PTR_ERR(msp->clk));
+		goto free_irq;
+	}
+
+	init_timer(&msp->notify_timer);
+	msp->notify_timer.expires = jiffies + msecs_to_jiffies(1000);
+	msp->notify_timer.function = func_notify_timer;
+	msp->notify_timer.data = (unsigned long)msp;
+
+	msp->rx_pipeid = NULL;
+	msp->tx_pipeid = NULL;
+	msp->read = NULL;
+	msp->write = NULL;
+	msp->transfer = NULL;
+	msp->msp_state = MSP_STATE_IDLE;
+	msp->loopback_enable = 0;
+
+	/* I2S Controller is allocated and added in I2S controller class. */
+	i2s_cont = kzalloc(sizeof(*i2s_cont), GFP_KERNEL);
+	if (!i2s_cont) {
+		pr_err("%s: ERROR: Failed to allocate struct i2s_cont (kzalloc)!\n",
+			__func__);
+		goto del_timer;
+	}
+	i2s_cont->dev.parent = &pdev->dev;
+	i2s_cont->data = (void *)msp;
+	i2s_cont->id = (s16)msp->id;
+	snprintf(i2s_cont->name,
+		sizeof(i2s_cont->name),
+		"ux500-msp-i2s.%04x",
+		msp->id);
+	pr_debug("I2S device-name :%s\n", i2s_cont->name);
+	msp->i2s_cont = i2s_cont;
+
+	return msp_i2s_drvdata;
+
+del_timer:
+	del_timer_sync(&msp->notify_timer);
+	clk_put(msp->clk);
+free_irq:
+	iounmap(msp->registers);
+free_msp:
+	kfree(msp);
+	return NULL;
+}
+
+int ux500_msp_i2s_exit(struct ux500_msp_i2s_drvdata *drvdata)
+{
+	struct msp *msp = drvdata->msp;
+	int status = 0;
+
+	pr_debug("%s: Enter (drvdata->id = %d).\n", __func__, drvdata->id);
+
+	device_unregister(&msp->i2s_cont->dev);
+	del_timer_sync(&msp->notify_timer);
+	clk_put(msp->clk);
+	iounmap(msp->registers);
+	prcmu_qos_remove_requirement(PRCMU_QOS_APE_OPP, "ux500_msp_i2s");
+	regulator_put(drvdata->reg_vape);
+	kfree(msp);
+
+	return status;
+}
+
+int ux500_msp_i2s_suspend(struct ux500_msp_i2s_drvdata *drvdata)
+{
+	struct msp *msp = drvdata->msp;
+
+	pr_debug("%s: Enter (drvdata->id = %d).\n", __func__, drvdata->id);
+
+	down(&msp->lock);
+	if (msp->users > 0) {
+		up(&msp->lock);
+		return -EBUSY;
+	}
+	up(&msp->lock);
+
+	return 0;
+}
+
+int ux500_msp_i2s_resume(struct ux500_msp_i2s_drvdata *drvdata)
+{
+	pr_debug("%s: Enter (drvdata->id = %d).\n", __func__, drvdata->id);
+
+	return 0;
+}
+
+MODULE_LICENSE("GPLv2");
diff --git a/sound/soc/ux500/ux500_msp_i2s.h b/sound/soc/ux500/ux500_msp_i2s.h
new file mode 100644
index 0000000..5c12f31
--- /dev/null
+++ b/sound/soc/ux500/ux500_msp_i2s.h
@@ -0,0 +1,40 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2011
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
+
+#ifndef UX500_MSP_I2S_H
+#define UX500_MSP_I2S_H
+
+#include <linux/platform_device.h>
+
+#include <mach/msp.h>
+
+struct ux500_msp_i2s_drvdata {
+	int id;
+	struct msp *msp;
+	struct regulator *reg_vape;
+};
+
+struct ux500_msp_i2s_drvdata *ux500_msp_i2s_init(struct platform_device *pdev,
+						struct msp_i2s_platform_data *platform_data);
+int ux500_msp_i2s_exit(struct ux500_msp_i2s_drvdata *drvdata);
+int ux500_msp_i2s_open(struct ux500_msp_i2s_drvdata *drvdata, struct msp_config *msp_config);
+int ux500_msp_i2s_close(struct ux500_msp_i2s_drvdata *drvdata, enum i2s_flag flag);
+int ux500_msp_i2s_transfer(struct ux500_msp_i2s_drvdata *drvdata, struct i2s_message *message);
+int ux500_msp_i2s_hw_status(struct ux500_msp_i2s_drvdata *drvdata);
+
+int ux500_msp_i2s_suspend(struct ux500_msp_i2s_drvdata *drvdata);
+int ux500_msp_i2s_resume(struct ux500_msp_i2s_drvdata *drvdata);
+
+#endif
+
diff --git a/sound/soc/ux500/ux500_pcm.c b/sound/soc/ux500/ux500_pcm.c
new file mode 100644
index 0000000..85b9a7b
--- /dev/null
+++ b/sound/soc/ux500/ux500_pcm.c
@@ -0,0 +1,428 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * Author: Ola Lilja <ola.o.lilja@stericsson.com>,
+ *         Roger Nilsson <roger.xr.nilsson@stericsson.com>
+ *         for ST-Ericsson.
+ *
+ * License terms:
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include <asm/page.h>
+
+#include <linux/module.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/slab.h>
+
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include "ux500_pcm.h"
+#include "ux500_msp_dai.h"
+
+static struct snd_pcm_hardware ux500_pcm_hw_playback = {
+	.info = SNDRV_PCM_INFO_INTERLEAVED |
+		SNDRV_PCM_INFO_MMAP |
+		SNDRV_PCM_INFO_RESUME |
+		SNDRV_PCM_INFO_PAUSE,
+	.formats = SNDRV_PCM_FMTBIT_S16_LE |
+		SNDRV_PCM_FMTBIT_U16_LE |
+		SNDRV_PCM_FMTBIT_S16_BE |
+		SNDRV_PCM_FMTBIT_U16_BE,
+	.rates = SNDRV_PCM_RATE_KNOT,
+	.rate_min = UX500_PLATFORM_MIN_RATE_PLAYBACK,
+	.rate_max = UX500_PLATFORM_MAX_RATE_PLAYBACK,
+	.channels_min = UX500_PLATFORM_MIN_CHANNELS,
+	.channels_max = UX500_PLATFORM_MAX_CHANNELS,
+	.buffer_bytes_max = UX500_PLATFORM_BUFFER_BYTES_MAX,
+	.period_bytes_min = UX500_PLATFORM_PERIODS_BYTES_MIN,
+	.period_bytes_max = UX500_PLATFORM_PERIODS_BYTES_MAX,
+	.periods_min = UX500_PLATFORM_PERIODS_MIN,
+	.periods_max = UX500_PLATFORM_PERIODS_MAX,
+};
+
+static struct snd_pcm_hardware ux500_pcm_hw_capture = {
+	.info = SNDRV_PCM_INFO_INTERLEAVED |
+		SNDRV_PCM_INFO_MMAP |
+		SNDRV_PCM_INFO_RESUME |
+		SNDRV_PCM_INFO_PAUSE,
+	.formats = SNDRV_PCM_FMTBIT_S16_LE |
+		SNDRV_PCM_FMTBIT_U16_LE |
+		SNDRV_PCM_FMTBIT_S16_BE |
+		SNDRV_PCM_FMTBIT_U16_BE,
+	.rates = SNDRV_PCM_RATE_KNOT,
+	.rate_min = UX500_PLATFORM_MIN_RATE_CAPTURE,
+	.rate_max = UX500_PLATFORM_MAX_RATE_CAPTURE,
+	.channels_min = UX500_PLATFORM_MIN_CHANNELS,
+	.channels_max = UX500_PLATFORM_MAX_CHANNELS,
+	.buffer_bytes_max = UX500_PLATFORM_BUFFER_BYTES_MAX,
+	.period_bytes_min = UX500_PLATFORM_PERIODS_BYTES_MIN,
+	.period_bytes_max = UX500_PLATFORM_PERIODS_BYTES_MAX,
+	.periods_min = UX500_PLATFORM_PERIODS_MIN,
+	.periods_max = UX500_PLATFORM_PERIODS_MAX,
+};
+
+static const char *stream_str(struct snd_pcm_substream *substream)
+{
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		return "Playback";
+	else
+		return "Capture";
+}
+
+static void ux500_pcm_dma_hw_free(struct device *dev,
+				struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_dma_buffer *buf = runtime->dma_buffer_p;
+
+	if (runtime->dma_area == NULL)
+		return;
+
+	if (buf != &substream->dma_buffer) {
+		dma_free_coherent(
+			buf->dev.dev,
+			buf->bytes,
+			buf->area,
+			buf->addr);
+		kfree(runtime->dma_buffer_p);
+	}
+
+	snd_pcm_set_runtime_buffer(substream, NULL);
+}
+
+void ux500_pcm_dma_eot_handler(void *data)
+{
+	struct snd_pcm_substream *substream = data;
+	struct snd_pcm_runtime *runtime;
+	struct ux500_pcm_private *private;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *dai = rtd->cpu_dai;
+
+	pr_debug("%s: MSP %d (%s): Enter.\n", __func__, dai->id, stream_str(substream));
+
+	if (substream) {
+		runtime = substream->runtime;
+		private = substream->runtime->private_data;
+
+		if (ux500_msp_dai_i2s_get_underrun_status(private->msp_id)) {
+			private->no_of_underruns++;
+			pr_debug("%s: Nr of underruns (%d)\n", __func__,
+					private->no_of_underruns);
+		}
+
+		/* calc the offset in the circular buffer */
+		private->offset += frames_to_bytes(runtime,
+				runtime->period_size);
+		private->offset %= frames_to_bytes(runtime,
+				runtime->period_size) * runtime->periods;
+
+		snd_pcm_period_elapsed(substream);
+	}
+}
+EXPORT_SYMBOL(ux500_pcm_dma_eot_handler);
+
+static int ux500_pcm_open(struct snd_pcm_substream *substream)
+{
+	int stream_id = substream->pstr->stream;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ux500_pcm_private *private;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *dai = rtd->cpu_dai;
+	int ret;
+
+	pr_debug("%s: MSP %d (%s): Enter.\n", __func__, dai->id, stream_str(substream));
+
+	pr_debug("%s: Set runtime hwparams.\n", __func__);
+	if (stream_id == SNDRV_PCM_STREAM_PLAYBACK)
+		snd_soc_set_runtime_hwparams(substream, &ux500_pcm_hw_playback);
+	else
+		snd_soc_set_runtime_hwparams(substream, &ux500_pcm_hw_capture);
+
+	/* ensure that buffer size is a multiple of period size */
+	ret = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0) {
+		pr_err("%s: Error: snd_pcm_hw_constraints failed (%d)\n",
+			__func__,
+			ret);
+		return ret;
+	}
+
+	pr_debug("%s: Init runtime private data.\n", __func__);
+	private = kzalloc(sizeof(struct ux500_pcm_private), GFP_KERNEL);
+	if (private == NULL)
+		return -ENOMEM;
+	private->msp_id = dai->id;
+	runtime->private_data = private;
+
+	pr_debug("%s: Set hw-struct for %s.\n", __func__, stream_str(substream));
+	runtime->hw = (stream_id == SNDRV_PCM_STREAM_PLAYBACK) ?
+		ux500_pcm_hw_playback : ux500_pcm_hw_capture;
+
+	return 0;
+}
+
+static int ux500_pcm_close(struct snd_pcm_substream *substream)
+{
+	struct ux500_pcm_private *private = substream->runtime->private_data;
+
+	pr_debug("%s: Enter\n", __func__);
+
+	kfree(private);
+
+	return 0;
+}
+
+static int ux500_pcm_hw_params(struct snd_pcm_substream *substream,
+			struct snd_pcm_hw_params *hw_params)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_dma_buffer *buf = runtime->dma_buffer_p;
+	int ret = 0;
+	int size;
+
+	pr_debug("%s: Enter\n", __func__);
+
+	size = params_buffer_bytes(hw_params);
+
+	if (buf) {
+		if (buf->bytes >= size)
+			goto out;
+		ux500_pcm_dma_hw_free(NULL, substream);
+	}
+
+	if (substream->dma_buffer.area != NULL &&
+		substream->dma_buffer.bytes >= size) {
+		buf = &substream->dma_buffer;
+	} else {
+		buf = kmalloc(sizeof(struct snd_dma_buffer), GFP_KERNEL);
+		if (!buf)
+			goto nomem;
+
+		buf->dev.type = SNDRV_DMA_TYPE_DEV;
+		buf->dev.dev = NULL;
+		buf->area = dma_alloc_coherent(
+			NULL,
+			size,
+			&buf->addr,
+			GFP_KERNEL);
+		buf->bytes = size;
+		buf->private_data = NULL;
+
+		if (!buf->area)
+			goto free;
+	}
+	snd_pcm_set_runtime_buffer(substream, buf);
+	ret = 1;
+ out:
+	runtime->dma_bytes = size;
+	return ret;
+
+ free:
+	kfree(buf);
+ nomem:
+	return -ENOMEM;
+}
+
+static int ux500_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	pr_debug("%s: Enter\n", __func__);
+
+	ux500_pcm_dma_hw_free(NULL, substream);
+
+	return 0;
+}
+
+static int ux500_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	pr_debug("%s: Enter\n", __func__);
+	return 0;
+}
+
+static int ux500_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	int ret;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ux500_pcm_private *private = runtime->private_data;
+	int stream_id = substream->pstr->stream;
+
+	pr_debug("%s: Enter\n", __func__);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		pr_debug("%s: START/PAUSE-RELEASE\n", __func__);
+		if (runtime->status->state == SNDRV_PCM_STATE_XRUN) {
+			pr_debug("XRUN occurred\n");
+				return 0;
+		}
+
+		private->no_of_underruns = 0;
+		private->offset = 0;
+		ret = ux500_msp_dai_i2s_configure_sg(runtime->dma_addr,
+				runtime->periods,
+				frames_to_bytes(runtime, runtime->period_size),
+				private->msp_id,
+				stream_id);
+		if (ret) {
+			pr_err("%s: Failed to configure I2S!\n", __func__);
+			return -EINVAL;
+		}
+		break;
+
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+		pr_debug("%s: SNDRV_PCM_TRIGGER_STOP\n", __func__);
+		pr_debug("%s: no_of_underruns = %u\n",
+			__func__,
+			private->no_of_underruns);
+		break;
+
+	default:
+		pr_err("%s: Invalid command in pcm trigger\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static snd_pcm_uframes_t ux500_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct ux500_pcm_private *private = runtime->private_data;
+
+	pr_debug("%s: dma_offset %d frame %ld\n", __func__, private->offset,
+			bytes_to_frames(substream->runtime, private->offset));
+
+	return bytes_to_frames(substream->runtime, private->offset);
+}
+
+static int ux500_pcm_mmap(struct snd_pcm_substream *substream,
+			struct vm_area_struct *vma)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	pr_debug("%s: Enter.\n", __func__);
+
+	return dma_mmap_coherent(
+		NULL,
+		vma,
+		runtime->dma_area,
+		runtime->dma_addr,
+		runtime->dma_bytes);
+}
+
+static const struct snd_pcm_ops ux500_pcm_ops = {
+	.open		= ux500_pcm_open,
+	.close		= ux500_pcm_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= ux500_pcm_hw_params,
+	.hw_free	= ux500_pcm_hw_free,
+	.prepare	= ux500_pcm_prepare,
+	.trigger	= ux500_pcm_trigger,
+	.pointer	= ux500_pcm_pointer,
+	.mmap		= ux500_pcm_mmap
+};
+
+int ux500_pcm_new(struct snd_card *card,
+		struct snd_soc_dai *dai,
+		struct snd_pcm *pcm)
+{
+	pr_debug("%s: pcm = %d\n", __func__, (int)pcm);
+
+	pcm->info_flags = 0;
+	strcpy(pcm->name, "UX500_PCM");
+
+	pr_debug("%s: pcm->name = %s.\n", __func__, pcm->name);
+
+	return 0;
+}
+
+static void ux500_pcm_free(struct snd_pcm *pcm)
+{
+	pr_debug("%s: Enter\n", __func__);
+}
+
+static int ux500_pcm_suspend(struct snd_soc_dai *dai)
+{
+	pr_debug("%s: Enter\n", __func__);
+
+	return 0;
+}
+
+static int ux500_pcm_resume(struct snd_soc_dai *dai)
+{
+	pr_debug("%s: Enter\n", __func__);
+
+	return 0;
+}
+
+struct snd_soc_platform_driver ux500_pcm_soc_drv = {
+	.ops		= &ux500_pcm_ops,
+	.pcm_new        = ux500_pcm_new,
+	.pcm_free       = ux500_pcm_free,
+	.suspend        = ux500_pcm_suspend,
+	.resume         = ux500_pcm_resume,
+};
+EXPORT_SYMBOL(ux500_pcm_soc_drv);
+
+static int __devexit ux500_pcm_drv_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	pr_info("%s: Register ux500-pcm SoC platform driver.\n", __func__);
+	ret = snd_soc_register_platform(&pdev->dev, &ux500_pcm_soc_drv);
+	if (ret < 0) {
+		pr_err("%s: Error: Failed to register "
+			"ux500-pcm SoC platform driver (%d)!\n",
+			__func__,
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __devinit ux500_pcm_drv_remove(struct platform_device *pdev)
+{
+	pr_info("%s: Unregister ux500-pcm SoC platform driver.\n", __func__);
+	snd_soc_unregister_platform(&pdev->dev);
+
+	return 0;
+}
+
+static struct platform_driver ux500_pcm_driver = {
+	.driver = {
+		.name = "ux500-pcm",
+		.owner = THIS_MODULE,
+	},
+
+	.probe = ux500_pcm_drv_probe,
+	.remove = __devexit_p(ux500_pcm_drv_remove),
+};
+
+static int __init ux500_pcm_drv_init(void)
+{
+	pr_debug("%s: Register ux500-pcm platform driver.\n", __func__);
+
+	return platform_driver_register(&ux500_pcm_driver);
+}
+
+static void __exit ux500_pcm_drv_exit(void)
+{
+	pr_debug("%s: Unregister ux500-pcm platform driver.\n", __func__);
+
+	platform_driver_unregister(&ux500_pcm_driver);
+}
+
+module_init(ux500_pcm_drv_init);
+module_exit(ux500_pcm_drv_exit);
+
diff --git a/sound/soc/ux500/ux500_pcm.h b/sound/soc/ux500/ux500_pcm.h
new file mode 100644
index 0000000..50f4661
--- /dev/null
+++ b/sound/soc/ux500/ux500_pcm.h
@@ -0,0 +1,44 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * Author: Ola Lilja <ola.o.lilja@stericsson.com>,
+ *         Roger Nilsson <roger.xr.nilsson@stericsson.com>
+ *         for ST-Ericsson.
+ *
+ * License terms:
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+#ifndef UX500_PCM_H
+#define UX500_PCM_H
+
+#include <mach/msp.h>
+
+#define UX500_PLATFORM_MIN_RATE_PLAYBACK 8000
+#define UX500_PLATFORM_MAX_RATE_PLAYBACK 48000
+#define UX500_PLATFORM_MIN_RATE_CAPTURE	8000
+#define UX500_PLATFORM_MAX_RATE_CAPTURE	48000
+
+#define UX500_PLATFORM_MIN_CHANNELS 1
+#define UX500_PLATFORM_MAX_CHANNELS 8
+
+#define UX500_PLATFORM_PERIODS_BYTES_MIN	128
+#define UX500_PLATFORM_PERIODS_BYTES_MAX	(64 * PAGE_SIZE)
+#define UX500_PLATFORM_PERIODS_MIN		2
+#define UX500_PLATFORM_PERIODS_MAX		48
+#define UX500_PLATFORM_BUFFER_BYTES_MAX		(2048 * PAGE_SIZE)
+
+extern struct snd_soc_platform ux500_soc_platform;
+
+struct ux500_pcm_private {
+	int msp_id;
+	int stream_id;
+	unsigned int no_of_underruns;
+	unsigned int offset;
+};
+
+void ux500_pcm_dma_eot_handler(void *data);
+
+#endif
-- 
1.7.8.3
