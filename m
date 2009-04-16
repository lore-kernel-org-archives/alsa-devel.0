From: Naresh Medisetty <naresh@ti.com>
Subject: [PATCH v2 2/6] ARM: DaVinci: ASoC: Add the platform
	devices for ASP
Date: Thu, 16 Apr 2009 18:42:15 -0400
Message-ID: <1239921735-26911-1-git-send-email-naresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 3BF8C10394E
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 13:30:09 +0200 (CEST)
Received: from dflp53.itg.ti.com ([128.247.5.6])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n3GBU2SC020990
	for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2009 06:30:07 -0500
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: davinci-linux-open-source@linux.davincidsp.com
Cc: alsa-devel@alsa-project.org, Naresh Medisetty <naresh@ti.com>
List-Id: alsa-devel@alsa-project.org

1)Registers the platform devices for ASP on dm355, dm644x and dm646x so that
the machine driver can probe to get ASP related platform data.
2)Move towards definition of the asp clocks using phyisical name(for dm355 and
dm644x)
Signed-off-by: Naresh Medisetty <naresh@ti.com>
---
This patch applies to the DaVinci git tree available at
http://git.kernel.org/?p=linux/kernel/git/khilman/linux-davinci.git

 arch/arm/mach-davinci/dm355.c            |   29 ++++++++++++-
 arch/arm/mach-davinci/dm644x.c           |   27 +++++++++++-
 arch/arm/mach-davinci/dm646x.c           |   67 ++++++++++++++++++++++++++++++
 arch/arm/mach-davinci/include/mach/asp.h |   39 ++++++++++++++++-
 4 files changed, 157 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index c20211c..222c3f3 100755
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -23,6 +23,7 @@
 #include <mach/psc.h>
 #include <mach/mux.h>
 #include <mach/irqs.h>
+#include <mach/asp.h>
 
 #include "clock.h"
 #include "mux.h"
@@ -351,8 +352,8 @@ static struct davinci_clk dm355_clks[] = {
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
@@ -540,6 +541,29 @@ static struct platform_device dm355_edma_device = {
 	.resource		= edma_resources,
 };
 
+/* DM335 EVM uses ASP1; line-out is a stereo mini-jack */
+static struct resource dm355_evm_snd_resources[] = {
+	{
+		.start	= DAVINCI_ASP1_BASE,
+		.end	= DAVINCI_ASP1_BASE + SZ_8K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct evm_snd_platform_data dm355_evm_snd_data = {
+	.clk_name	= "asp1",
+	.tx_dma_ch	= DAVINCI_DMA_ASP1_TX,
+	.rx_dma_ch	= DAVINCI_DMA_ASP1_RX,
+};
+
+static struct platform_device dm355_asoc_device = {
+	.name				= "davinci-asoc",
+	.id					= -1,
+	.dev.platform_data	= &dm355_evm_snd_data,
+	.num_resources		= ARRAY_SIZE(dm355_evm_snd_resources),
+	.resource			= dm355_evm_snd_resources,
+};
+
 /*----------------------------------------------------------------------*/
 
 void __init dm355_init(void)
@@ -555,6 +579,7 @@ static int __init dm355_init_devices(void)
 
 	davinci_cfg_reg(DM355_INT_EDMA_CC);
 	platform_device_register(&dm355_edma_device);
+	platform_device_register(&dm355_asoc_device);
 	return 0;
 }
 postcore_initcall(dm355_init_devices);
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 9878c17..01112ca 100755
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -20,6 +20,7 @@
 #include <mach/irqs.h>
 #include <mach/psc.h>
 #include <mach/mux.h>
+#include <mach/asp.h>
 
 #include "clock.h"
 #include "mux.h"
@@ -296,7 +297,7 @@ struct davinci_clk dm644x_clks[] = {
 	CLK("davinci_emac.1", NULL, &emac_clk),
 	CLK("i2c_davinci.1", NULL, &i2c_clk),
 	CLK("palm_bk3710", NULL, &ide_clk),
-	CLK("soc-audio.0", NULL, &asp_clk),
+	CLK(NULL, "asp0", &asp_clk),
 	CLK("davinci_mmc.0", NULL, &mmcsd_clk),
 	CLK(NULL, "spi", &spi_clk),
 	CLK(NULL, "gpio", &gpio_clk),
@@ -463,6 +464,29 @@ static struct platform_device dm644x_edma_device = {
 	.resource		= edma_resources,
 };
 
+/* DM6446 EVM uses ASP0; line-out is a pair of RCA jacks */
+static struct resource dm644x_evm_snd_resources[] = {
+	{
+		.start	= DAVINCI_ASP0_BASE,
+		.end	= DAVINCI_ASP0_BASE + SZ_8K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct evm_snd_platform_data dm644x_evm_snd_data = {
+	.clk_name	= "asp0",
+	.tx_dma_ch	= DAVINCI_DMA_ASP0_TX,
+	.rx_dma_ch	= DAVINCI_DMA_ASP0_RX,
+};
+
+static struct platform_device dm644x_asoc_device = {
+	.name				= "davinci-asoc",
+	.id					= -1,
+	.dev.platform_data	= &dm644x_evm_snd_data,
+	.num_resources		= ARRAY_SIZE(dm644x_evm_snd_resources),
+	.resource			= dm644x_evm_snd_resources,
+};
+
 /*----------------------------------------------------------------------*/
 #if defined(CONFIG_TI_DAVINCI_EMAC) || defined(CONFIG_TI_DAVINCI_EMAC_MODULE)
 
@@ -495,6 +519,7 @@ static int __init dm644x_init_devices(void)
 		return 0;
 
 	platform_device_register(&dm644x_edma_device);
+	platform_device_register(&dm644x_asoc_device);
 	return 0;
 }
 postcore_initcall(dm644x_init_devices);
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 39ffd17..bb8c65a 100755
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -20,6 +20,7 @@
 #include <mach/irqs.h>
 #include <mach/psc.h>
 #include <mach/mux.h>
+#include <mach/asp.h>
 
 #include "clock.h"
 #include "mux.h"
@@ -499,6 +500,70 @@ static struct platform_device dm646x_edma_device = {
 	.resource		= edma_resources,
 };
 
+static u8 dm6467_iis_serializer_direction[] = {
+       TX_MODE, RX_MODE, INACTIVE_MODE, INACTIVE_MODE,
+};
+
+static u8 dm6467_dit_serializer_direction[] = {
+       TX_MODE, INACTIVE_MODE, INACTIVE_MODE, INACTIVE_MODE,
+};
+
+static struct evm_snd_platform_data dm6467_evm_snd_data[] = {
+	{
+		.clk_name       = "mcasp0",
+		.tx_dma_ch      = DAVINCI_DM646X_DMA_MCASP0_AXEVT0,
+		.rx_dma_ch      = DAVINCI_DM646X_DMA_MCASP0_AREVT0,
+		.tx_dma_offset  = 0x400,
+		.rx_dma_offset  = 0x400,
+		.op_mode        = DAVINCI_MCASP_IIS_MODE,
+		.num_serializer = 4,
+		.tdm_slots      = 2,
+		.serial_dir     = dm6467_iis_serializer_direction,
+		.eventq_no      = EVENTQ_0,
+	},
+	{
+		.clk_name       = "mcasp1",
+		.tx_dma_ch      = DAVINCI_DM646X_DMA_MCASP1_AXEVT1,
+		.rx_dma_ch      = -1,
+		.tx_dma_offset  = 0x400,
+		.rx_dma_offset  = 0,
+		.op_mode        = DAVINCI_MCASP_DIT_MODE,
+		.num_serializer = 4,
+		.tdm_slots      = 32,
+		.serial_dir     = dm6467_dit_serializer_direction,
+		.eventq_no      = EVENTQ_0,
+	},
+};
+
+static struct resource dm6467_evm_snd_resources[] = {
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
+};
+
+static struct platform_device dm646x_asoc_device = {
+	.name				= "davinci-asoc",
+	.id					= -1,
+	.dev.platform_data	= dm6467_evm_snd_data,
+	.num_resources		= ARRAY_SIZE(dm6467_evm_snd_resources),
+	.resource			= dm6467_evm_snd_resources,
+};
+
+static struct platform_device dm646x_dit_device = {
+	.name				= "davinci-dit",
+	.id					= -1,
+
+};
+
 /*----------------------------------------------------------------------*/
 
 #if defined(CONFIG_TI_DAVINCI_EMAC) || defined(CONFIG_TI_DAVINCI_EMAC_MODULE)
@@ -532,6 +597,8 @@ static int __init dm646x_init_devices(void)
 		return 0;
 
 	platform_device_register(&dm646x_edma_device);
+	platform_device_register(&dm646x_asoc_device);
+	platform_device_register(&dm646x_dit_device);
 	return 0;
 }
 postcore_initcall(dm646x_init_devices);
diff --git a/arch/arm/mach-davinci/include/mach/asp.h b/arch/arm/mach-davinci/include/mach/asp.h
index e0abc43..1bb1f0b 100644
--- a/arch/arm/mach-davinci/include/mach/asp.h
+++ b/arch/arm/mach-davinci/include/mach/asp.h
@@ -5,21 +5,56 @@
 #define __ASM_ARCH_DAVINCI_ASP_H
 
 #include <mach/irqs.h>
+#include <mach/edma.h>
 
-/* Bases of register banks */
+/* Bases of dm644x and dm355 register banks */
 #define DAVINCI_ASP0_BASE	0x01E02000
 #define DAVINCI_ASP1_BASE	0x01E04000
 
-/* EDMA channels */
+
+/* Bases of dm646x register banks */
+#define	DAVINCI_DM646X_MCASP0_REG_BASE		0x01D01000
+#define DAVINCI_DM646X_MCASP1_REG_BASE		0x01D01800
+
+/* EDMA channels of dm644x and dm355 */
 #define DAVINCI_DMA_ASP0_TX	2
 #define DAVINCI_DMA_ASP0_RX	3
 #define DAVINCI_DMA_ASP1_TX	8
 #define DAVINCI_DMA_ASP1_RX	9
 
+
+/* EDMA channels of dm646x */
+#define	DAVINCI_DM646X_DMA_MCASP0_AXEVT0	6
+#define	DAVINCI_DM646X_DMA_MCASP0_AREVT0	9
+#define	DAVINCI_DM646X_DMA_MCASP1_AXEVT1	12
 /* Interrupts */
 #define DAVINCI_ASP0_RX_INT	IRQ_MBRINT
 #define DAVINCI_ASP0_TX_INT	IRQ_MBXINT
 #define DAVINCI_ASP1_RX_INT	IRQ_MBRINT
 #define DAVINCI_ASP1_TX_INT	IRQ_MBXINT
 
+struct evm_snd_platform_data {
+	char *clk_name;
+	int tx_dma_ch;
+	int rx_dma_ch;
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
+
 #endif /* __ASM_ARCH_DAVINCI_ASP_H */
-- 
1.5.6
