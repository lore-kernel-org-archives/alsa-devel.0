From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 09/12] pcm038: add sound support
Date: Thu, 19 Nov 2009 16:48:23 +0100
Message-ID: <1258645706-9071-10-git-send-email-s.hauer@pengutronix.de>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-2-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-3-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-4-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-5-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-6-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-7-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-8-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-9-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 0D788103818
	for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2009 16:48:45 +0100 (CET)
In-Reply-To: <1258645706-9071-9-git-send-email-s.hauer@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx2/pcm038.c |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx2/pcm038.c b/arch/arm/mach-mx2/pcm038.c
index 906d59b..7d11da1 100644
--- a/arch/arm/mach-mx2/pcm038.c
+++ b/arch/arm/mach-mx2/pcm038.c
@@ -39,7 +39,9 @@
 #include <mach/iomux.h>
 #include <mach/imx-uart.h>
 #include <mach/mxc_nand.h>
+#include <mach/audmux.h>
 #include <mach/spi.h>
+#include <mach/ssi.h>
 
 #include "devices.h"
 
@@ -264,7 +266,7 @@ static struct mc13783_platform_data pcm038_pmic = {
 	.regulators = pcm038_regulators,
 	.num_regulators = ARRAY_SIZE(pcm038_regulators),
 	.flags = MC13783_USE_ADC | MC13783_USE_REGULATOR |
-		 MC13783_USE_TOUCHSCREEN,
+		 MC13783_USE_TOUCHSCREEN | MC13783_USE_CODEC,
 };
 
 static struct spi_board_info pcm038_spi_board_info[] __initdata = {
@@ -279,16 +281,35 @@ static struct spi_board_info pcm038_spi_board_info[] __initdata = {
 	}
 };
 
+struct imx_ssi_platform_data pcm038_ssi_pdata = {
+//	.flags = IMX_SSI_DMA,
+};
+
 static void __init pcm038_init(void)
 {
 	mxc_gpio_setup_multiple_pins(pcm038_pins, ARRAY_SIZE(pcm038_pins),
 			"PCM038");
 
+	mxc_audmux_v1_configure_port(MX27_AUDMUX_HPCR1_SSI0,
+		MXC_AUDMUX_V1_PCR_TFSDIR |
+		MXC_AUDMUX_V1_PCR_TCLKDIR |
+		MXC_AUDMUX_V1_PCR_TFCSEL(MX27_AUDMUX_PPCR1_SSI_PINS_1) |
+		MXC_AUDMUX_V1_PCR_RFSDIR |
+		MXC_AUDMUX_V1_PCR_RCLKDIR |
+		MXC_AUDMUX_V1_PCR_RFCSEL(MX27_AUDMUX_HPCR3_SSI_PINS_4) |
+		MXC_AUDMUX_V1_PCR_RXDSEL(MX27_AUDMUX_HPCR3_SSI_PINS_4));
+	mxc_audmux_v1_configure_port(MX27_AUDMUX_HPCR3_SSI_PINS_4,
+		MXC_AUDMUX_V1_PCR_RXDSEL(MX27_AUDMUX_HPCR1_SSI0));
+	mxc_audmux_v1_configure_port(MX27_AUDMUX_PPCR1_SSI_PINS_1,
+		MXC_AUDMUX_V1_PCR_TFCSEL(MX27_AUDMUX_HPCR1_SSI0) |
+		MXC_AUDMUX_V1_PCR_RFCSEL(MX27_AUDMUX_HPCR1_SSI0));
+
 	pcm038_init_sram();
 
 	mxc_register_device(&mxc_uart_device0, &uart_pdata[0]);
 	mxc_register_device(&mxc_uart_device1, &uart_pdata[1]);
 	mxc_register_device(&mxc_uart_device2, &uart_pdata[2]);
+	mxc_register_device(&imx_ssi_device0, &pcm038_ssi_pdata);
 
 	mxc_gpio_mode(PE16_AF_OWIRE);
 	mxc_register_device(&mxc_nand_device, &pcm038_nand_board_info);
-- 
1.6.5.2
