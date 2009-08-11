From: Chaithrika U S <chaithrika@ti.com>
Subject: [PATCH] ARM: DaVinci: Audio support for
	DA850/OMAP-L138 EVM
Date: Tue, 11 Aug 2009 17:03:25 -0400
Message-ID: <1250024605-27215-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id BF6CD24364
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Aug 2009 13:34:29 +0200 (CEST)
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

Define resources for McASP used on DA850/OMAP-L138 EVM, add platform
device defintion and Pin Mux configurations.

Signed-off-by: Chaithrika U S <chaithrika@ti.com>
---
Applies on DaVinci GIT tree.
This patch is dependent on the following patch which I have
submitted earlier:
	[PATCH v2] ARM: DaVinci: Audio support for DA830 EVM

 arch/arm/mach-davinci/board-da850-evm.c  |   29 ++++++++++++++++++++++
 arch/arm/mach-davinci/da850.c            |   39 ++++++++++++++++++++++++++++++
 arch/arm/mach-davinci/devices-da8xx.c    |   34 +++++++++++++++++++++++++-
 arch/arm/mach-davinci/include/mach/asp.h |    7 +++++
 arch/arm/mach-davinci/include/mach/mux.h |   25 +++++++++++++++++++
 5 files changed, 133 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index d989346..52bfe4c 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -38,6 +38,28 @@ static struct davinci_uart_config da850_evm_uart_config __initdata = {
 	.enabled_uarts = 0x7,
 };
 
+/* davinci da850 evm audio machine driver */
+static u8 da850_iis_serializer_direction[] = {
+	INACTIVE_MODE,	INACTIVE_MODE,	INACTIVE_MODE,	INACTIVE_MODE,
+	INACTIVE_MODE,	INACTIVE_MODE,	INACTIVE_MODE,	INACTIVE_MODE,
+	INACTIVE_MODE,	INACTIVE_MODE,	INACTIVE_MODE,	TX_MODE,
+	RX_MODE,	INACTIVE_MODE,	INACTIVE_MODE,	INACTIVE_MODE,
+};
+
+static struct snd_platform_data da850_evm_snd_data = {
+	.tx_dma_offset	= 0x2000,
+	.rx_dma_offset	= 0x2000,
+	.op_mode	= DAVINCI_MCASP_IIS_MODE,
+	.num_serializer	= ARRAY_SIZE(da850_iis_serializer_direction),
+	.tdm_slots	= 2,
+	.serial_dir	= da850_iis_serializer_direction,
+	.eventq_no	= EVENTQ_1,
+	.version	= MCASP_VERSION_2,
+	.txnumevt	= 1,
+	.rxnumevt	= 1,
+};
+
+
 static __init void da850_evm_init(void)
 {
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
@@ -86,6 +108,13 @@ static __init void da850_evm_init(void)
 	 */
 	__raw_writel(0, IO_ADDRESS(DA8XX_UART1_BASE) + 0x30);
 	__raw_writel(0, IO_ADDRESS(DA8XX_UART0_BASE) + 0x30);
+
+	ret = da8xx_pinmux_setup(da850_mcasp_pins);
+	if (ret)
+		pr_warning("da850_evm_init: mcasp mux setup failed: %d\n",
+				ret);
+
+	da8xx_init_mcasp(0, &da850_evm_snd_data);
 }
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 4a43ae2..e33b226 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -289,6 +289,13 @@ static struct clk emac_clk = {
 	.lpsc		= DA8XX_LPSC1_CPGMAC,
 };
 
+static struct clk mcasp_clk = {
+	.name		= "mcasp",
+	.parent		= &pll0_sysclk2,
+	.lpsc		= DA8XX_LPSC1_McASP0,
+	.psc_ctlr	= 1,
+};
+
 static struct davinci_clk da850_clks[] = {
 	CLK(NULL,		"ref",		&ref_clk),
 	CLK(NULL,		"pll0",		&pll0_clk),
@@ -326,6 +333,7 @@ static struct davinci_clk da850_clks[] = {
 	CLK(NULL,		"arm",		&arm_clk),
 	CLK(NULL,		"rmii",		&rmii_clk),
 	CLK("davinci_emac.1",	NULL,		&emac_clk),
+	CLK("davinci-mcasp.0",	NULL,		&mcasp_clk),
 	CLK(NULL,		NULL,		NULL),
 };
 
@@ -370,6 +378,30 @@ static const struct mux_config da850_pins[] = {
 	MUX_CFG(DA850, MII_RXD_2,	3,	20,	15,	8,	false)
 	MUX_CFG(DA850, MII_RXD_1,	3,	24,	15,	8,	false)
 	MUX_CFG(DA850, MII_RXD_0,	3,	28,	15,	8,	false)
+	/* McASP function */
+	MUX_CFG(DA850,	ACLKR,		0,	0,	15,	1,	false)
+	MUX_CFG(DA850,	ACLKX,		0,	4,	15,	1,	false)
+	MUX_CFG(DA850,	AFSR,		0,	8,	15,	1,	false)
+	MUX_CFG(DA850,	AFSX,		0,	12,	15,	1,	false)
+	MUX_CFG(DA850,	AHCLKR,		0,	16,	15,	1,	false)
+	MUX_CFG(DA850,	AHCLKX,		0,	20,	15,	1,	false)
+	MUX_CFG(DA850,	AMUTE,		0,	24,	15,	1,	false)
+	MUX_CFG(DA850,	AXR_15,		1,	0,	15,	1,	false)
+	MUX_CFG(DA850,	AXR_14,		1,	4,	15,	1,	false)
+	MUX_CFG(DA850,	AXR_13,		1,	8,	15,	1,	false)
+	MUX_CFG(DA850,	AXR_12,		1,	12,	15,	1,	false)
+	MUX_CFG(DA850,	AXR_11,		1,	16,	15,	1,	false)
+	MUX_CFG(DA850,	AXR_10,		1,	20,	15,	1,	false)
+	MUX_CFG(DA850,	AXR_9,		1,	24,	15,	1,	false)
+	MUX_CFG(DA850,	AXR_8,		1,	28,	15,	1,	false)
+	MUX_CFG(DA850,	AXR_7,		2,	0,	15,	1,	false)
+	MUX_CFG(DA850,	AXR_6,		2,	4,	15,	1,	false)
+	MUX_CFG(DA850,	AXR_5,		2,	8,	15,	1,	false)
+	MUX_CFG(DA850,	AXR_4,		2,	12,	15,	1,	false)
+	MUX_CFG(DA850,	AXR_3,		2,	16,	15,	1,	false)
+	MUX_CFG(DA850,	AXR_2,		2,	20,	15,	1,	false)
+	MUX_CFG(DA850,	AXR_1,		2,	24,	15,	1,	false)
+	MUX_CFG(DA850,	AXR_0,		2,	28,	15,	1,	false)
 #endif
 };
 
@@ -406,6 +438,13 @@ const short da850_cpgmac_pins[] __initdata = {
 	-1
 };
 
+const short da850_mcasp_pins[] __initdata = {
+	DA850_AHCLKX, DA850_ACLKX, DA850_AFSX,
+	DA850_AHCLKR, DA850_ACLKR, DA850_AFSR, DA850_AMUTE,
+	DA850_AXR_11, DA850_AXR_12,
+	-1
+};
+
 /* FIQ are pri 0-1; otherwise 2-7, with 7 lowest priority */
 static u8 da850_default_priorities[DA850_N_CP_INTC_IRQ] = {
 	[IRQ_DA8XX_COMMTX]		= 7,
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index fe0baaf..1882eef 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -309,6 +309,34 @@ static struct platform_device da830_mcasp1_device = {
 	.resource	= da830_mcasp1_resources,
 };
 
+static struct resource da850_mcasp_resources[] = {
+	{
+		.name	= "mcasp",
+		.start	= DAVINCI_DA8XX_MCASP0_REG_BASE,
+		.end	= DAVINCI_DA8XX_MCASP0_REG_BASE + (SZ_1K * 12) - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	/* TX event */
+	{
+		.start	= DAVINCI_DA8XX_DMA_MCASP0_AXEVT,
+		.end	= DAVINCI_DA8XX_DMA_MCASP0_AXEVT,
+		.flags	= IORESOURCE_DMA,
+	},
+	/* RX event */
+	{
+		.start	= DAVINCI_DA8XX_DMA_MCASP0_AREVT,
+		.end	= DAVINCI_DA8XX_DMA_MCASP0_AREVT,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct platform_device da850_mcasp_device = {
+	.name		= "davinci-mcasp",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(da850_mcasp_resources),
+	.resource	= da850_mcasp_resources,
+};
+
 int __init da8xx_register_emac(void)
 {
 	return platform_device_register(&da8xx_emac_device);
@@ -316,8 +344,12 @@ int __init da8xx_register_emac(void)
 
 void __init da8xx_init_mcasp(int id, struct snd_platform_data *pdata)
 {
-	if (id == 1) { /* DA830/OMAP-L137 has 3 instances of McASP */
+	/* DA830/OMAP-L137 has 3 instances of McASP */
+	if (cpu_is_davinci_da830() && id == 1) {
 		da830_mcasp1_device.dev.platform_data = pdata;
 		platform_device_register(&da830_mcasp1_device);
+	} else if (cpu_is_davinci_da850()) {
+		da850_mcasp_device.dev.platform_data = pdata;
+		platform_device_register(&da850_mcasp_device);
 	}
 }
diff --git a/arch/arm/mach-davinci/include/mach/asp.h b/arch/arm/mach-davinci/include/mach/asp.h
index f3c97ac..18e4ce3 100644
--- a/arch/arm/mach-davinci/include/mach/asp.h
+++ b/arch/arm/mach-davinci/include/mach/asp.h
@@ -15,6 +15,9 @@
 #define	DAVINCI_DM646X_MCASP0_REG_BASE		0x01D01000
 #define DAVINCI_DM646X_MCASP1_REG_BASE		0x01D01800
 
+/* Bases of da850/da830 McASP0  register banks */
+#define DAVINCI_DA8XX_MCASP0_REG_BASE	0x01D00000
+
 /* Bases of da830 McASP1 register banks */
 #define DAVINCI_DA830_MCASP1_REG_BASE	0x01D04000
 
@@ -29,6 +32,10 @@
 #define	DAVINCI_DM646X_DMA_MCASP0_AREVT0	9
 #define	DAVINCI_DM646X_DMA_MCASP1_AXEVT1	12
 
+/* EDMA channels of da850/da830 McASP0 */
+#define	DAVINCI_DA8XX_DMA_MCASP0_AREVT	0
+#define	DAVINCI_DA8XX_DMA_MCASP0_AXEVT	1
+
 /* EDMA channels of da830 McASP1 */
 #define	DAVINCI_DA830_DMA_MCASP1_AREVT	2
 #define	DAVINCI_DA830_DMA_MCASP1_AXEVT	3
diff --git a/arch/arm/mach-davinci/include/mach/mux.h b/arch/arm/mach-davinci/include/mach/mux.h
index a676b2f..f50f5b2 100644
--- a/arch/arm/mach-davinci/include/mach/mux.h
+++ b/arch/arm/mach-davinci/include/mach/mux.h
@@ -748,6 +748,31 @@ enum davinci_da850_index {
 	DA850_MII_RXD_2,
 	DA850_MII_RXD_1,
 	DA850_MII_RXD_0,
+
+	/* McASP function */
+	DA850_ACLKR,
+	DA850_ACLKX,
+	DA850_AFSR,
+	DA850_AFSX,
+	DA850_AHCLKR,
+	DA850_AHCLKX,
+	DA850_AMUTE,
+	DA850_AXR_15,
+	DA850_AXR_14,
+	DA850_AXR_13,
+	DA850_AXR_12,
+	DA850_AXR_11,
+	DA850_AXR_10,
+	DA850_AXR_9,
+	DA850_AXR_8,
+	DA850_AXR_7,
+	DA850_AXR_6,
+	DA850_AXR_5,
+	DA850_AXR_4,
+	DA850_AXR_3,
+	DA850_AXR_2,
+	DA850_AXR_1,
+	DA850_AXR_0,
 };
 
 #ifdef CONFIG_DAVINCI_MUX
-- 
1.5.6
