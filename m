From: miguel.aguilar@ridgerun.com
Subject: [PATCH 3/4] Davinci: DM365: Add platform device for
	McBSP
Date: Fri, 28 Aug 2009 13:53:35 -0600
Message-ID: <1251489215-22657-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.navvo.net (mail.navvo.net [74.208.67.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 0256F10382C
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Aug 2009 21:53:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org
Cc: todd.fischer@ridgerun.com, diego.dompe@ridgerun.com, clark.becker@ridgerun.com, Miguel Aguilar <miguel.aguilar@ridgerun.com>
List-Id: alsa-devel@alsa-project.org

From: Miguel Aguilar <miguel.aguilar@ridgerun.com>

1) Registers the platform device for McBSP on DM365.
2) Add platform data to DM365 EVM board file.

Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>
---
 arch/arm/mach-davinci/board-dm365-evm.c    |    4 ++
 arch/arm/mach-davinci/dm365.c              |   42 +++++++++++++++++++++++++++-
 arch/arm/mach-davinci/include/mach/asp.h   |    3 ++
 arch/arm/mach-davinci/include/mach/dm365.h |    2 +
 4 files changed, 50 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index f6adf79..fd2db78 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -177,6 +177,8 @@ static struct at24_platform_data eeprom_info = {
 	.context	= (void *)0x7f00,
 };
 
+static struct snd_platform_data dm365_evm_snd_data;
+
 static struct i2c_board_info i2c_info[] = {
 	{
 		I2C_BOARD_INFO("dm365evm_keys", 0x25),
@@ -476,6 +478,8 @@ static __init void dm365_evm_init(void)
 
 	/* maybe setup mmc1/etc ... _after_ mmc0 */
 	evm_init_cpld();
+	
+	dm365_init_asp(&dm365_evm_snd_data);
 }
 
 static __init void dm365_evm_irq_init(void)
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index e815174..cba09b0 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -32,6 +32,7 @@
 #include <mach/time.h>
 #include <mach/serial.h>
 #include <mach/common.h>
+#include <mach/asp.h>
 
 #include "clock.h"
 #include "mux.h"
@@ -456,7 +457,7 @@ static struct davinci_clk dm365_clks[] = {
 	CLK(NULL, "usb", &usb_clk),
 	CLK("davinci_emac.1", NULL, &emac_clk),
 	CLK("voice_codec", NULL, &voicecodec_clk),
-	CLK("soc-audio.0", NULL, &asp0_clk),
+	CLK("davinci-asp.0", NULL, &asp0_clk),
 	CLK(NULL, "rto", &rto_clk),
 	CLK(NULL, "mjcp", &mjcp_clk),
 	CLK(NULL, NULL, NULL),
@@ -806,6 +807,31 @@ static struct platform_device dm365_edma_device = {
 	.resource		= edma_resources,
 };
 
+static struct resource dm365_asp_resources[] = {
+	{
+		.start	= DAVINCI_DM365_ASP0_BASE,
+		.end	= DAVINCI_DM365_ASP0_BASE + SZ_8K - 1,
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
+static struct platform_device dm365_asp_device = {
+	.name		= "davinci-asp",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(dm365_asp_resources),
+	.resource	= dm365_asp_resources,
+};
+
 static struct map_desc dm365_io_desc[] = {
 	{
 		.virtual	= IO_VIRT,
@@ -907,6 +933,20 @@ static struct davinci_soc_info davinci_soc_info_dm365 = {
 	.sram_len		= SZ_32K,
 };
 
+void __init dm365_init_asp(struct snd_platform_data *pdata)
+{
+	davinci_cfg_reg(DM365_MCBSP0_BDX);
+	davinci_cfg_reg(DM365_MCBSP0_X);
+	davinci_cfg_reg(DM365_MCBSP0_BFSX);
+	davinci_cfg_reg(DM365_MCBSP0_BDR);
+	davinci_cfg_reg(DM365_MCBSP0_R);
+	davinci_cfg_reg(DM365_MCBSP0_BFSR);
+	davinci_cfg_reg(DM365_EVT2_ASP_TX);
+	davinci_cfg_reg(DM365_EVT3_ASP_RX);
+	dm365_asp_device.dev.platform_data = pdata;
+	platform_device_register(&dm365_asp_device);
+}
+
 void __init dm365_init(void)
 {
 	davinci_common_init(&davinci_soc_info_dm365);
diff --git a/arch/arm/mach-davinci/include/mach/asp.h b/arch/arm/mach-davinci/include/mach/asp.h
index 18e4ce3..fbcbed0 100644
--- a/arch/arm/mach-davinci/include/mach/asp.h
+++ b/arch/arm/mach-davinci/include/mach/asp.h
@@ -15,6 +15,9 @@
 #define	DAVINCI_DM646X_MCASP0_REG_BASE		0x01D01000
 #define DAVINCI_DM646X_MCASP1_REG_BASE		0x01D01800
 
+/* Bases of dm365 register banks */
+#define DAVINCI_DM365_ASP0_BASE	0x01D02000
+
 /* Bases of da850/da830 McASP0  register banks */
 #define DAVINCI_DA8XX_MCASP0_REG_BASE	0x01D00000
 
diff --git a/arch/arm/mach-davinci/include/mach/dm365.h b/arch/arm/mach-davinci/include/mach/dm365.h
index 09db434..2291c0d 100644
--- a/arch/arm/mach-davinci/include/mach/dm365.h
+++ b/arch/arm/mach-davinci/include/mach/dm365.h
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 #include <mach/hardware.h>
 #include <mach/emac.h>
+#include <mach/asp.h>
 
 #define DM365_EMAC_BASE			(0x01D07000)
 #define DM365_EMAC_CNTRL_OFFSET		(0x0000)
@@ -25,5 +26,6 @@
 #define DM365_EMAC_CNTRL_RAM_SIZE	(0x2000)
 
 void __init dm365_init(void);
+void __init dm365_init_asp(struct snd_platform_data *pdata);
 
 #endif /* __ASM_ARCH_DM365_H */
-- 
1.6.0.4
