From: <vm.rod25@gmail.com>
Subject: [PATCH v2 05/10] davinci: Audio support for
	Omapl138-Hawkboard
Date: Mon, 11 Oct 2010 22:55:07 -0500
Message-ID: <1286855707-31833-1-git-send-email-vm.rod25@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 97B881039B1
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Oct 2010 05:54:15 +0200 (CEST)
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
Cc: nsekhar@ti.com, alsa-devel@alsa-project.org, khasim@ti.com, caglarakyuz@gmail.com, sshtylyov@mvista.com
List-Id: alsa-devel@alsa-project.org

From: Victor Rodriguez <victor.rodriguez@sasken.com>

This patch adds sound support for the Hawkboard-L138 system

Signed-off-by: Victor Rodriguez <victor.rodriguez@sasken.com>
---
Notes:

This patch works with da8xx_omapl_defconfig

In order to test ALSA utils select in menuconfig like insmodule:

Sound card support  --->
	Advanced Linux Sound Architecture  --->
		ALSA for SoC audio support  --->
		SoC Audio for the TI DAVINCI chip
		SoC Audio support for DA850/OMAP-L138 EVM/Hawkboard

 arch/arm/mach-davinci/board-omapl138-hawk.c |   45 +++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 358944b..c0a999a 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/console.h>
 #include <linux/gpio.h>
+#include <linux/i2c.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -116,6 +117,37 @@ static struct edma_rsv_info *da850_edma_rsv[2] = {
 	&da850_edma_cc1_rsv,
 };
 
+static struct i2c_board_info __initdata omapl138_hawk_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("tlv320aic3x", 0x18),
+	},
+};
+
+static struct davinci_i2c_platform_data omapl138_hawk_i2c_0_pdata = {
+	.bus_freq	= 100,	/* kHz */
+	.bus_delay	= 0,	/* usec */
+};
+
+/* davinci Hawkboard audio machine driver */
+static u8 da850_iis_serializer_direction[] = {
+	INACTIVE_MODE,	INACTIVE_MODE,	INACTIVE_MODE,	INACTIVE_MODE,
+	INACTIVE_MODE,	INACTIVE_MODE,	INACTIVE_MODE,	INACTIVE_MODE,
+	INACTIVE_MODE,	INACTIVE_MODE,	INACTIVE_MODE,	INACTIVE_MODE,
+	INACTIVE_MODE,	TX_MODE,	RX_MODE,	INACTIVE_MODE,
+};
+
+static struct snd_platform_data omapl138_hawk_snd_data = {
+	.tx_dma_offset	= 0x2000,
+	.rx_dma_offset	= 0x2000,
+	.op_mode	= DAVINCI_MCASP_IIS_MODE,
+	.num_serializer	= ARRAY_SIZE(da850_iis_serializer_direction),
+	.tdm_slots	= 2,
+	.serial_dir	= da850_iis_serializer_direction,
+	.asp_chan_q	= EVENTQ_1,
+	.version	= MCASP_VERSION_2,
+	.txnumevt	= 1,
+	.rxnumevt	= 1,
+};
 
 static struct davinci_uart_config omapl138_hawk_uart_config __initdata = {
 	.enabled_uarts = 0x7,
@@ -134,6 +166,19 @@ static __init void omapl138_hawk_init(void)
 
 	ret = omapl138_hawk_config_emac();
 
+	i2c_register_board_info(1, omapl138_hawk_i2c_devices,
+			ARRAY_SIZE(omapl138_hawk_i2c_devices));
+
+	ret = da8xx_register_i2c(0, &omapl138_hawk_i2c_0_pdata);
+	if (ret)
+		pr_warning("%s: i2c0 registration failed: %d\n",
+			__func__, ret);
+
+	ret = davinci_cfg_reg_list(da850_mcasp_pins);
+	if (ret)
+		pr_warning("%s: mcasp mux setup failed: %d\n", __func__, ret);
+	da8xx_register_mcasp(0, &omapl138_hawk_snd_data);
+
 	ret = da8xx_register_watchdog();
 	if (ret)
 		pr_warning("omapl138_hawk_init: "
-- 
1.6.0.5
