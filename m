From: <vm.rod25-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v1 4/6] davinci: SOUND support for Omapl138-Hawkboard
Date: Fri,  8 Oct 2010 20:12:26 -0500
Message-ID: <1286586746-1322-1-git-send-email-vm.rod25@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

From: Victor Rodriguez <victor.rodriguez-Ut8ZLSGP1ULQT0dZR+AlfA@public.gmane.org>

This patch adds sound support for the Hawkboard-L138 system
It is under the machine name "omapl138_hawkboard".
This system is based on the da850 davinci CPU architecture.

Signed-off-by: Victor Rodriguez <victor.rodriguez-Ut8ZLSGP1ULQT0dZR+AlfA@public.gmane.org>
---
Notes:

This patch works with da8xx_omapl_defconfig

In order to test ALSA utils select in menuconfig like insmodule:

Sound card support  --->
	Advanced Linux Sound Architecture  --->
		ALSA for SoC audio support  --->
		SoC Audio for the TI DAVINCI chip
		SoC Audio support for DA850/OMAP-L138 EVM/Hawkboard

 arch/arm/mach-davinci/board-omapl138-hawk.c |   46 +++++++++++++++++++++++++++
 arch/arm/mach-davinci/da850.c               |    2 +-
 2 files changed, 47 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 01eef73..ba3718a 100644
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
+/* davinci da850 evm audio machine driver */
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
@@ -134,6 +166,20 @@ static __init void omapl138_hawk_init(void)
 
 	ret = omapl138_hawk_config_emac();
 
+	i2c_register_board_info(1, omapl138_hawk_i2c_devices,
+			ARRAY_SIZE(omapl138_hawk_i2c_devices));
+
+	ret = da8xx_register_i2c(0, &omapl138_hawk_i2c_0_pdata);
+	if (ret)
+		pr_warning("omapl138_hawk_init: "
+			"i2c0 registration failed: %d\n", ret);
+
+	ret = davinci_cfg_reg_list(da850_mcasp_pins);
+	if (ret)
+		pr_warning("omapl138_hawk_init: "
+			"mcasp mux setup failed: %d\n", ret);
+	da8xx_register_mcasp(0, &omapl138_hawk_snd_data);
+
 	ret = da8xx_register_watchdog();
 	if (ret)
 		pr_warning("omapl138_hawk_init: "
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 63916b9..f033a0a 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -591,7 +591,7 @@ const short da850_cpgmac_pins[] __initdata = {
 const short da850_mcasp_pins[] __initdata = {
 	DA850_AHCLKX, DA850_ACLKX, DA850_AFSX,
 	DA850_AHCLKR, DA850_ACLKR, DA850_AFSR, DA850_AMUTE,
-	DA850_AXR_11, DA850_AXR_12,
+	DA850_AXR_11, DA850_AXR_12, DA850_AXR_13, DA850_AXR_14,
 	-1
 };
 
-- 
1.6.0.5
