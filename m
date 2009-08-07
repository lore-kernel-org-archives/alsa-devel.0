From: Chaithrika U S <chaithrika@ti.com>
Subject: [PATCH] ARM: DaVinci: Audio support for DA830 EVM
Date: Fri,  7 Aug 2009 10:05:47 -0400
Message-ID: <1249653947-23561-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id BB52D2447E
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Aug 2009 06:35:44 +0200 (CEST)
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
Cc: khilman@deeprootsystems.com, Chaithrika U S <chaithrika@ti.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Define resources for McASP1 used on DA830 EVM, add platform
device defintion, initialization function.
Additionally, this patch also adds version and FIFO related
members to platform data structure.

Signed-off-by: Chaithrika U S <chaithrika@ti.com>
---
Applies to DaVinci GIT tree

 arch/arm/mach-davinci/board-da830-evm.c    |   22 +++++++++++++
 arch/arm/mach-davinci/da830.c              |   48 ++++++++++++++++++++++++++--
 arch/arm/mach-davinci/include/mach/asp.h   |   15 +++++++++
 arch/arm/mach-davinci/include/mach/da8xx.h |    2 +
 4 files changed, 84 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 9025669..4643795 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -23,6 +23,7 @@
 #include <mach/irqs.h>
 #include <mach/cp_intc.h>
 #include <mach/da8xx.h>
+#include <mach/asp.h>
 
 #define DA830_EVM_PHY_MASK		0x0
 #define DA830_EVM_MDIO_FREQUENCY	2200000	/* PHY bus frequency */
@@ -51,6 +52,25 @@ static struct davinci_uart_config da830_evm_uart_config __initdata = {
 	.enabled_uarts = 0x7,
 };
 
+static u8 da830_iis_serializer_direction[] = {
+	RX_MODE,	INACTIVE_MODE,	INACTIVE_MODE,	INACTIVE_MODE,
+	INACTIVE_MODE,	TX_MODE,	INACTIVE_MODE,	INACTIVE_MODE,
+	INACTIVE_MODE,	INACTIVE_MODE,	INACTIVE_MODE,	INACTIVE_MODE,
+};
+
+static struct snd_platform_data da830_evm_snd_data = {
+	.tx_dma_offset  = 0x2000,
+	.rx_dma_offset  = 0x2000,
+	.op_mode        = DAVINCI_MCASP_IIS_MODE,
+	.num_serializer = ARRAY_SIZE(da830_iis_serializer_direction),
+	.tdm_slots      = 2,
+	.serial_dir     = da830_iis_serializer_direction,
+	.eventq_no      = EVENTQ_0,
+	.version	= MCASP_VERSION_2,
+	.txnumevt	= 1,
+	.rxnumevt	= 1,
+};
+
 static __init void da830_evm_init(void)
 {
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
@@ -93,6 +113,8 @@ static __init void da830_evm_init(void)
 	davinci_serial_init(&da830_evm_uart_config);
 	i2c_register_board_info(1, da830_evm_i2c_devices,
 			ARRAY_SIZE(da830_evm_i2c_devices));
+
+	da830_init_mcasp1(&da830_evm_snd_data);
 }
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 3a9b634..a160a7f 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -23,6 +23,7 @@
 #include <mach/common.h>
 #include <mach/time.h>
 #include <mach/da8xx.h>
+#include <mach/asp.h>
 
 #include "clock.h"
 #include "mux.h"
@@ -411,9 +412,9 @@ static struct davinci_clk da830_clks[] = {
 	CLK("eqep.0",		NULL,		&eqep0_clk),
 	CLK("eqep.1",		NULL,		&eqep1_clk),
 	CLK("da830_lcdc",	NULL,		&lcdc_clk),
-	CLK("soc-audio.0",	NULL,		&mcasp0_clk),
-	CLK("soc-audio.1",	NULL,		&mcasp1_clk),
-	CLK("soc-audio.2",	NULL,		&mcasp2_clk),
+	CLK("davinci-mcasp.0",	NULL,		&mcasp0_clk),
+	CLK("davinci-mcasp.1",	NULL,		&mcasp1_clk),
+	CLK("davinci-mcasp.2",	NULL,		&mcasp2_clk),
 	CLK("musb_hdrc",	NULL,		&usb20_clk),
 	CLK(NULL,		"aemif",	&aemif_clk),
 	CLK(NULL,		"aintc",	&aintc_clk),
@@ -1198,6 +1199,47 @@ static struct davinci_soc_info davinci_soc_info_da830 = {
 	.emac_pdata		= &da8xx_emac_pdata,
 };
 
+static struct resource da830_mcasp1_resources[] = {
+	{
+		.name	= "mcasp1",
+		.start	= DAVINCI_DA830_MCASP1_REG_BASE,
+		.end	= DAVINCI_DA830_MCASP1_REG_BASE + (SZ_1K * 12) - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	/* TX event */
+	{
+		.start	= DAVINCI_DA830_DMA_MCASP1_AXEVT,
+		.end	= DAVINCI_DA830_DMA_MCASP1_AXEVT,
+		.flags	= IORESOURCE_DMA,
+	},
+	/* RX event */
+	{
+		.start	= DAVINCI_DA830_DMA_MCASP1_AREVT,
+		.end	= DAVINCI_DA830_DMA_MCASP1_AREVT,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct platform_device da830_mcasp1_device = {
+	.name		= "davinci-mcasp",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(da830_mcasp1_resources),
+	.resource	= da830_mcasp1_resources,
+};
+
+void __init da830_init_mcasp1(struct snd_platform_data *pdata)
+{
+	int ret;
+
+	ret = da8xx_pinmux_setup(da830_mcasp1_pins);
+	if (ret)
+		pr_warning("da830_evm_init: mcasp1 mux setup failed: %d\n",
+				ret);
+
+	da830_mcasp1_device.dev.platform_data = pdata;
+	platform_device_register(&da830_mcasp1_device);
+}
+
 void __init da830_init(void)
 {
 	davinci_common_init(&davinci_soc_info_da830);
diff --git a/arch/arm/mach-davinci/include/mach/asp.h b/arch/arm/mach-davinci/include/mach/asp.h
index cdf1f44..4df3839 100644
--- a/arch/arm/mach-davinci/include/mach/asp.h
+++ b/arch/arm/mach-davinci/include/mach/asp.h
@@ -15,6 +15,9 @@
 #define	DAVINCI_DM646X_MCASP0_REG_BASE		0x01D01000
 #define DAVINCI_DM646X_MCASP1_REG_BASE		0x01D01800
 
+/* Bases of da830 register banks */
+#define DAVINCI_DA830_MCASP1_REG_BASE	0x01D04000
+
 /* EDMA channels of dm644x and dm355 */
 #define DAVINCI_DMA_ASP0_TX	2
 #define DAVINCI_DMA_ASP0_RX	3
@@ -26,6 +29,10 @@
 #define	DAVINCI_DM646X_DMA_MCASP0_AREVT0	9
 #define	DAVINCI_DM646X_DMA_MCASP1_AXEVT1	12
 
+/* EDMA channels of da830 */
+#define	DAVINCI_DA830_DMA_MCASP1_AREVT	2
+#define	DAVINCI_DA830_DMA_MCASP1_AXEVT	3
+
 /* Interrupts */
 #define DAVINCI_ASP0_RX_INT	IRQ_MBRINT
 #define DAVINCI_ASP0_TX_INT	IRQ_MBXINT
@@ -43,6 +50,14 @@ struct snd_platform_data {
 	u8 op_mode;
 	u8 num_serializer;
 	u8 *serial_dir;
+	u8 version;
+	u8 txnumevt;
+	u8 rxnumevt;
+};
+
+enum {
+	MCASP_VERSION_1 = 0,	/* DM646x */
+	MCASP_VERSION_2,	/* DA8xx/OMAPL1x */
 };
 
 #define INACTIVE_MODE	0
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index a8cb570..c2aabf1 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -15,6 +15,7 @@
 #include <mach/edma.h>
 #include <mach/i2c.h>
 #include <mach/emac.h>
+#include <mach/asp.h>
 
 /*
  * The cp_intc interrupt controller for the da8xx isn't in the same
@@ -65,6 +66,7 @@ int da8xx_register_edma(void);
 int da8xx_register_i2c(int instance, struct davinci_i2c_platform_data *pdata);
 int da8xx_register_watchdog(void);
 int da8xx_register_emac(void);
+void __init da830_init_mcasp1(struct snd_platform_data *pdata);
 
 extern struct platform_device da8xx_serial_device;
 extern struct emac_platform_data da8xx_emac_pdata;
-- 
1.5.6
