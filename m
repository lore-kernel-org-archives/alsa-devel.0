From: Chaithrika U S <chaithrika@ti.com>
Subject: [PATCH v3 2/6] ARM: DaVinci: ASoC: Add the platform
	devices for ASP
Date: Thu, 28 May 2009 05:09:34 -0400
Message-ID: <1243501774-28446-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id C3BB41038D8
	for <alsa-devel@alsa-project.org>;
	Thu, 28 May 2009 11:46:09 +0200 (CEST)
Received: from dflp53.itg.ti.com ([128.247.5.6])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4S9k3av003018
	for <alsa-devel@alsa-project.org>; Thu, 28 May 2009 04:46:08 -0500
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
Cc: Chaithrika U S <chaithrika@ti.com>, davinci-linux-open-source@linux.davincidsp.com, Naresh Medisetty <naresh@ti.com>
List-Id: alsa-devel@alsa-project.org

1) Registers the platform devices for ASP on dm355, dm644x and dm646x so that
the machine driver can probe to get ASP related platform data.
2) Move towards definition of the asp clocks using phyisical name(for dm355 and
dm644x)
3) Add platform data to board specific files.

Signed-off-by: Naresh Medisetty <naresh@ti.com>
Signed-off-by: Chaithrika U S <chaithrika@ti.com>
---
This patch applies to the DaVinci git tree available at
http://git.kernel.org/?p=linux/kernel/git/khilman/linux-davinci.git

 arch/arm/mach-davinci/board-dm355-evm.c     |    5 ++
 arch/arm/mach-davinci/board-dm644x-evm.c    |    5 ++
 arch/arm/mach-davinci/board-dm646x-evm.c    |   32 +++++++++++++++
 arch/arm/mach-davinci/dm355.c               |   41 ++++++++++++++++++-
 arch/arm/mach-davinci/dm644x.c              |   36 ++++++++++++++++-
 arch/arm/mach-davinci/dm646x.c              |   58 +++++++++++++++++++++++++++
 arch/arm/mach-davinci/include/mach/asp.h    |   35 +++++++++++++++-
 arch/arm/mach-davinci/include/mach/dm355.h  |    2 +
 arch/arm/mach-davinci/include/mach/dm644x.h |    2 +
 arch/arm/mach-davinci/include/mach/dm646x.h |    2 +
 10 files changed, 213 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index f32e3d8..5bf1e13 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -118,6 +118,10 @@ static struct davinci_i2c_platform_data i2c_pdata = {
 	.bus_delay	= 0	/* usec */,
 };
 
+static struct evm_snd_platform_data dm355_evm_snd_data = {
+	.clk_name	= "asp1",
+};
+
 static int dm355evm_mmc_gpios = -EINVAL;
 
 static void dm355evm_mmcsd_gpios(unsigned gpio)
@@ -278,6 +282,7 @@ static __init void dm355_evm_init(void)
 
 	dm355_init_spi0(BIT(0), dm355_evm_spi_info,
 			ARRAY_SIZE(dm355_evm_spi_info));
+	dm355_init_asp(&dm355_evm_snd_data);
 }
 
 static __init void dm355_evm_irq_init(void)
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index e97216c..bdfbffe 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -226,6 +226,10 @@ static struct platform_device ide_dev = {
 	},
 };
 
+static struct evm_snd_platform_data dm644x_evm_snd_data = {
+	.clk_name	= "asp0",
+};
+
 /*----------------------------------------------------------------------*/
 
 /*
@@ -667,6 +671,7 @@ static __init void davinci_evm_init(void)
 	davinci_setup_mmc(0, &dm6446evm_mmc_config);
 
 	davinci_serial_init(&uart_config);
+	dm644x_init_asp(&dm644x_evm_snd_data);
 
 	soc_info->emac_pdata->phy_mask = DM644X_EVM_PHY_MASK;
 	soc_info->emac_pdata->mdio_max_freq = DM644X_EVM_MDIO_FREQUENCY;
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index a55f45c..774497b 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -206,6 +206,37 @@ static struct at24_platform_data eeprom_info = {
 	.context	= (void *)0x7f00,
 };
 
+static u8 dm646x_iis_serializer_direction[] = {
+       TX_MODE, RX_MODE, INACTIVE_MODE, INACTIVE_MODE,
+};
+
+static u8 dm646x_dit_serializer_direction[] = {
+       TX_MODE,
+};
+
+static struct evm_snd_platform_data dm646x_evm_snd_data[] = {
+	{
+		.clk_name       = "mcasp0",
+		.tx_dma_offset  = 0x400,
+		.rx_dma_offset  = 0x400,
+		.op_mode        = DAVINCI_MCASP_IIS_MODE,
+		.num_serializer = ARRAY_SIZE(dm646x_iis_serializer_direction),
+		.tdm_slots      = 2,
+		.serial_dir     = dm646x_iis_serializer_direction,
+		.eventq_no      = EVENTQ_0,
+	},
+	{
+		.clk_name       = "mcasp1",
+		.tx_dma_offset  = 0x400,
+		.rx_dma_offset  = 0,
+		.op_mode        = DAVINCI_MCASP_DIT_MODE,
+		.num_serializer = ARRAY_SIZE(dm646x_dit_serializer_direction),
+		.tdm_slots      = 32,
+		.serial_dir     = dm646x_dit_serializer_direction,
+		.eventq_no      = EVENTQ_0,
+	},
+};
+
 static struct i2c_board_info __initdata i2c_info[] =  {
 	{
 		I2C_BOARD_INFO("24c256", 0x50),
@@ -239,6 +270,7 @@ static __init void evm_init(void)
 
 	evm_init_i2c();
 	davinci_serial_init(&uart_config);
+	dm646x_init_mcasp(dm646x_evm_snd_data);
 
 	soc_info->emac_pdata->phy_mask = DM646X_EVM_PHY_MASK;
 	soc_info->emac_pdata->mdio_max_freq = DM646X_EVM_MDIO_FREQUENCY;
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 737ba50..dca38e2 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -14,6 +14,7 @@
 #include <linux/serial_8250.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
+#include <mach/asp.h>
 
 #include <linux/spi/spi.h>
 
@@ -360,8 +361,8 @@ static struct davinci_clk dm355_clks[] = {
 	CLK(NULL, "uart1", &uart1_clk),
 	CLK(NULL, "uart2", &uart2_clk),
 	CLK("i2c_davinci.1", NULL, &i2c_clk),
-	CLK("soc-audio.0", NULL, &asp0_clk),
-	CLK("soc-audio.1", NULL, &asp1_clk),
+	CLK(NULL, "asp0", &asp0_clk),
+	CLK(NULL, "asp1", &asp1_clk),
 	CLK("davinci_mmc.0", NULL, &mmcsd0_clk),
 	CLK("davinci_mmc.1", NULL, &mmcsd1_clk),
 	CLK(NULL, "spi0", &spi0_clk),
@@ -624,6 +625,32 @@ static struct platform_device dm355_edma_device = {
 	.resource		= edma_resources,
 };
 
+/* DM335 EVM uses ASP1; line-out is a stereo mini-jack */
+static struct resource dm355_asp_resources[] = {
+	{
+		.start	= DAVINCI_ASP1_BASE,
+		.end	= DAVINCI_ASP1_BASE + SZ_8K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= DAVINCI_DMA_ASP1_TX,
+		.end	= DAVINCI_DMA_ASP1_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	{
+		.start	= DAVINCI_DMA_ASP1_RX,
+		.end	= DAVINCI_DMA_ASP1_RX,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct platform_device dm355_asp_device = {
+	.name		= "davinci-asp",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(dm355_asp_resources),
+	.resource	= dm355_asp_resources,
+};
+
 /*----------------------------------------------------------------------*/
 
 static struct map_desc dm355_io_desc[] = {
@@ -733,6 +760,16 @@ static struct davinci_soc_info davinci_soc_info_dm355 = {
 	.sram_len		= SZ_32K,
 };
 
+void __init dm355_init_asp(struct evm_snd_platform_data *pdata)
+{
+	/* we don't use ASP1 IRQs, or we'd need to mux them ... */
+	davinci_cfg_reg(DM355_EVT8_ASP1_TX);
+	davinci_cfg_reg(DM355_EVT9_ASP1_RX);
+
+	dm355_asp_device.dev.platform_data = pdata;
+	platform_device_register(&dm355_asp_device);
+}
+
 void __init dm355_init(void)
 {
 	davinci_common_init(&davinci_soc_info_dm355);
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 7cea25b..8c6c23b 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -27,6 +27,7 @@
 #include <mach/gpio.h>
 #include <mach/serial.h>
 #include <mach/common.h>
+#include <mach/asp.h>
 
 #include "clock.h"
 #include "mux.h"
@@ -303,7 +304,7 @@ struct davinci_clk dm644x_clks[] = {
 	CLK("davinci_emac.1", NULL, &emac_clk),
 	CLK("i2c_davinci.1", NULL, &i2c_clk),
 	CLK("palm_bk3710", NULL, &ide_clk),
-	CLK("soc-audio.0", NULL, &asp_clk),
+	CLK(NULL, "asp0", &asp_clk),
 	CLK("davinci_mmc.0", NULL, &mmcsd_clk),
 	CLK(NULL, "spi", &spi_clk),
 	CLK(NULL, "gpio", &gpio_clk),
@@ -550,6 +551,32 @@ static struct platform_device dm644x_edma_device = {
 	.resource		= edma_resources,
 };
 
+/* DM6446 EVM uses ASP0; line-out is a pair of RCA jacks */
+static struct resource dm644x_asp_resources[] = {
+	{
+		.start	= DAVINCI_ASP0_BASE,
+		.end	= DAVINCI_ASP0_BASE + SZ_8K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= DAVINCI_DMA_ASP0_TX,
+		.end	= DAVINCI_DMA_ASP0_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	{
+		.start	= DAVINCI_DMA_ASP0_RX,
+		.end	= DAVINCI_DMA_ASP0_RX,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct platform_device dm644x_asp_device = {
+	.name		= "davinci-asp",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(dm644x_asp_resources),
+	.resource	= dm644x_asp_resources,
+};
+
 /*----------------------------------------------------------------------*/
 
 static struct map_desc dm644x_io_desc[] = {
@@ -660,6 +687,13 @@ static struct davinci_soc_info davinci_soc_info_dm644x = {
 	.sram_len		= SZ_16K,
 };
 
+void __init dm644x_init_asp(struct evm_snd_platform_data *pdata)
+{
+	davinci_cfg_reg(DM644X_MCBSP);
+	dm644x_asp_device.dev.platform_data = pdata;
+	platform_device_register(&dm644x_asp_device);
+}
+
 void __init dm644x_init(void)
 {
 	davinci_common_init(&davinci_soc_info_dm644x);
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 07c8d88..ad5f479 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -27,6 +27,7 @@
 #include <mach/gpio.h>
 #include <mach/serial.h>
 #include <mach/common.h>
+#include <mach/asp.h>
 
 #include "clock.h"
 #include "mux.h"
@@ -587,6 +588,56 @@ static struct platform_device dm646x_edma_device = {
 	.resource		= edma_resources,
 };
 
+static struct resource dm646x_mcasp_resources[] = {
+	{
+		.name	= "mcasp0",
+		.start 	= DAVINCI_DM646X_MCASP0_REG_BASE,
+		.end 	= DAVINCI_DM646X_MCASP0_REG_BASE + (SZ_1K << 1) - 1,
+		.flags 	= IORESOURCE_MEM,
+	},
+	{
+		.name	= "mcasp1",
+		.start	= DAVINCI_DM646X_MCASP1_REG_BASE,
+		.end	= DAVINCI_DM646X_MCASP1_REG_BASE + (SZ_1K << 1) - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	/* first TX, then RX */
+	{
+		.start	= DAVINCI_DM646X_DMA_MCASP0_AXEVT0,
+		.end	= DAVINCI_DM646X_DMA_MCASP0_AXEVT0,
+		.flags	= IORESOURCE_DMA,
+	},
+	{
+		.start	= DAVINCI_DM646X_DMA_MCASP0_AREVT0,
+		.end	= DAVINCI_DM646X_DMA_MCASP0_AREVT0,
+		.flags	= IORESOURCE_DMA,
+	},
+	/* DIT mode, only TX event */
+	{
+		.start	= DAVINCI_DM646X_DMA_MCASP1_AXEVT1,
+		.end	= DAVINCI_DM646X_DMA_MCASP1_AXEVT1,
+		.flags	= IORESOURCE_DMA,
+	},
+	/* DIT mode, dummy entry */
+	{
+		.start	= -1,
+		.end	= -1,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct platform_device dm646x_mcasp_device = {
+	.name		= "davinci-mcasp",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(dm646x_mcasp_resources),
+	.resource	= dm646x_mcasp_resources,
+};
+
+static struct platform_device dm646x_dit_device = {
+	.name	= "spdif-dit",
+	.id	= -1,
+};
+
 /*----------------------------------------------------------------------*/
 
 static struct map_desc dm646x_io_desc[] = {
@@ -697,6 +748,13 @@ static struct davinci_soc_info davinci_soc_info_dm646x = {
 	.sram_len		= SZ_32K,
 };
 
+void __init dm646x_init_mcasp(struct evm_snd_platform_data *pdata)
+{
+	dm646x_mcasp_device.dev.platform_data = pdata;
+	platform_device_register(&dm646x_mcasp_device);
+	platform_device_register(&dm646x_dit_device);
+}
+
 void __init dm646x_init(void)
 {
 	davinci_common_init(&davinci_soc_info_dm646x);
diff --git a/arch/arm/mach-davinci/include/mach/asp.h b/arch/arm/mach-davinci/include/mach/asp.h
index e0abc43..cffc55c 100644
--- a/arch/arm/mach-davinci/include/mach/asp.h
+++ b/arch/arm/mach-davinci/include/mach/asp.h
@@ -5,21 +5,52 @@
 #define __ASM_ARCH_DAVINCI_ASP_H
 
 #include <mach/irqs.h>
+#include <mach/edma.h>
 
-/* Bases of register banks */
+/* Bases of dm644x and dm355 register banks */
 #define DAVINCI_ASP0_BASE	0x01E02000
 #define DAVINCI_ASP1_BASE	0x01E04000
 
-/* EDMA channels */
+/* Bases of dm646x register banks */
+#define	DAVINCI_DM646X_MCASP0_REG_BASE		0x01D01000
+#define DAVINCI_DM646X_MCASP1_REG_BASE		0x01D01800
+
+/* EDMA channels of dm644x and dm355 */
 #define DAVINCI_DMA_ASP0_TX	2
 #define DAVINCI_DMA_ASP0_RX	3
 #define DAVINCI_DMA_ASP1_TX	8
 #define DAVINCI_DMA_ASP1_RX	9
 
+/* EDMA channels of dm646x */
+#define	DAVINCI_DM646X_DMA_MCASP0_AXEVT0	6
+#define	DAVINCI_DM646X_DMA_MCASP0_AREVT0	9
+#define	DAVINCI_DM646X_DMA_MCASP1_AXEVT1	12
+
 /* Interrupts */
 #define DAVINCI_ASP0_RX_INT	IRQ_MBRINT
 #define DAVINCI_ASP0_TX_INT	IRQ_MBXINT
 #define DAVINCI_ASP1_RX_INT	IRQ_MBRINT
 #define DAVINCI_ASP1_TX_INT	IRQ_MBXINT
 
+struct evm_snd_platform_data {
+	char *clk_name;
+	u32 tx_dma_offset;
+	u32 rx_dma_offset;
+	enum dma_event_q eventq_no;	/* event queue number */
+	unsigned int codec_fmt;
+
+	/* McASP specific fields */
+	int tdm_slots;
+	u8 op_mode;
+	u8 num_serializer;
+	u8 *serial_dir;
+};
+
+#define INACTIVE_MODE	0
+#define TX_MODE		1
+#define RX_MODE		2
+
+#define DAVINCI_MCASP_IIS_MODE	0
+#define DAVINCI_MCASP_DIT_MODE	1
+
 #endif /* __ASM_ARCH_DAVINCI_ASP_H */
diff --git a/arch/arm/mach-davinci/include/mach/dm355.h b/arch/arm/mach-davinci/include/mach/dm355.h
index 54903b7..b8f9c50 100644
--- a/arch/arm/mach-davinci/include/mach/dm355.h
+++ b/arch/arm/mach-davinci/include/mach/dm355.h
@@ -12,11 +12,13 @@
 #define __ASM_ARCH_DM355_H
 
 #include <mach/hardware.h>
+#include <mach/asp.h>
 
 struct spi_board_info;
 
 void __init dm355_init(void);
 void dm355_init_spi0(unsigned chipselect_mask,
 		struct spi_board_info *info, unsigned len);
+void __init dm355_init_asp(struct evm_snd_platform_data *pdata);
 
 #endif /* __ASM_ARCH_DM355_H */
diff --git a/arch/arm/mach-davinci/include/mach/dm644x.h b/arch/arm/mach-davinci/include/mach/dm644x.h
index 15d42b9..c508b5e 100644
--- a/arch/arm/mach-davinci/include/mach/dm644x.h
+++ b/arch/arm/mach-davinci/include/mach/dm644x.h
@@ -25,6 +25,7 @@
 #include <linux/platform_device.h>
 #include <mach/hardware.h>
 #include <mach/emac.h>
+#include <mach/asp.h>
 
 #define DM644X_EMAC_BASE		(0x01C80000)
 #define DM644X_EMAC_CNTRL_OFFSET	(0x0000)
@@ -34,5 +35,6 @@
 #define DM644X_EMAC_CNTRL_RAM_SIZE	(0x2000)
 
 void __init dm644x_init(void);
+void __init dm644x_init_asp(struct evm_snd_platform_data *pdata);
 
 #endif /* __ASM_ARCH_DM644X_H */
diff --git a/arch/arm/mach-davinci/include/mach/dm646x.h b/arch/arm/mach-davinci/include/mach/dm646x.h
index 7afc613..47b3423 100644
--- a/arch/arm/mach-davinci/include/mach/dm646x.h
+++ b/arch/arm/mach-davinci/include/mach/dm646x.h
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <mach/hardware.h>
 #include <mach/emac.h>
+#include <mach/asp.h>
 
 #define DM646X_EMAC_BASE		(0x01C80000)
 #define DM646X_EMAC_CNTRL_OFFSET	(0x0000)
@@ -23,5 +24,6 @@
 #define DM646X_EMAC_CNTRL_RAM_SIZE	(0x2000)
 
 void __init dm646x_init(void);
+void __init dm646x_init_mcasp(struct evm_snd_platform_data *pdata);
 
 #endif /* __ASM_ARCH_DM646X_H */
-- 
1.5.6
