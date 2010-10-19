From: <vm.rod25@gmail.com>
Subject: [PATCH v5 7/9] davinci: MMC/SD support for
	Omapl138-Hawkboar
Date: Tue, 19 Oct 2010 13:06:25 -0500
Message-ID: <1287511587-22216-8-git-send-email-vm.rod25@gmail.com>
References: <1287511587-22216-1-git-send-email-vm.rod25@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E7EC2439E
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Oct 2010 20:05:41 +0200 (CEST)
In-Reply-To: <1287511587-22216-1-git-send-email-vm.rod25@gmail.com>
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

This patch adds MMC/SD support for the Hawkboard-L138 system

Signed-off-by: Victor Rodriguez <victor.rodriguez@sasken.com>
---
Notes:

This patch works with da8xx_omapl_defconfig
In order to test it select in menuconfig like insmodule

MMC/SD/SDIO card support  --->
      MMC block device driver
      Use bounce buffer for simple hosts
      TI DAVINCI Multimedia Card Interface support

 arch/arm/mach-davinci/board-omapl138-hawk.c |   63 +++++++++++++++++++++++++++
 1 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 97836e9..c83050b 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -23,6 +23,8 @@
 #include <mach/mux.h>
 
 #define HAWKBOARD_PHY_ID		"0:07"
+#define DA850_HAWK_MMCSD_CD_PIN		GPIO_TO_PIN(3, 12)
+#define DA850_HAWK_MMCSD_WP_PIN		GPIO_TO_PIN(3, 13)
 
 static short omapl138_hawk_mii_pins[] __initdata = {
 	DA850_MII_TXEN, DA850_MII_TXCLK, DA850_MII_COL, DA850_MII_TXD_3,
@@ -147,6 +149,65 @@ static struct snd_platform_data omapl138_hawk_snd_data = {
 	.rxnumevt	= 1,
 };
 
+static const short hawk_mmcsd0_pins[] = {
+	DA850_MMCSD0_DAT_0, DA850_MMCSD0_DAT_1, DA850_MMCSD0_DAT_2,
+	DA850_MMCSD0_DAT_3, DA850_MMCSD0_CLK, DA850_MMCSD0_CMD,
+	DA850_GPIO3_12, DA850_GPIO3_13,
+	-1
+};
+
+static int da850_hawk_mmc_get_ro(int index)
+{
+	return gpio_get_value(DA850_HAWK_MMCSD_WP_PIN);
+}
+
+static int da850_hawk_mmc_get_cd(int index)
+{
+	return !gpio_get_value(DA850_HAWK_MMCSD_CD_PIN);
+}
+
+static struct davinci_mmc_config da850_mmc_config = {
+	.get_ro		= da850_hawk_mmc_get_ro,
+	.get_cd		= da850_hawk_mmc_get_cd,
+	.wires		= 4,
+	.max_freq	= 50000000,
+	.caps		= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED,
+	.version	= MMC_CTLR_VERSION_2,
+};
+
+static __init void omapl138_hawk_mmc_init(void)
+{
+	int ret;
+
+	ret = davinci_cfg_reg_list(hawk_mmcsd0_pins);
+	if (ret) {
+		pr_warning("%s: MMC/SD0 mux setup failed: %d\n",
+			__func__, ret);
+		return;
+	}
+
+	ret = gpio_request_one(DA850_HAWK_MMCSD_CD_PIN,
+			GPIOF_DIR_IN, "MMC CD");
+	if (ret < 0) {
+		pr_warning("%s: can not open GPIO %d\n",
+			__func__, DA850_HAWK_MMCSD_CD_PIN);
+		return;
+	}
+
+	ret = gpio_request_one(DA850_HAWK_MMCSD_WP_PIN,
+			GPIOF_DIR_IN, "MMC WP");
+	if (ret < 0) {
+		pr_warning("%s: can not open GPIO %d\n",
+			__func__, DA850_HAWK_MMCSD_WP_PIN);
+		return;
+	}
+
+	ret = da8xx_register_mmcsd0(&da850_mmc_config);
+	if (ret)
+		pr_warning("%s: MMC/SD0 registration failed: %d\n",
+			__func__, ret);
+}
+
 static struct davinci_uart_config omapl138_hawk_uart_config __initdata = {
 	.enabled_uarts = 0x7,
 };
@@ -177,6 +238,8 @@ static __init void omapl138_hawk_init(void)
 		pr_warning("%s: mcasp mux setup failed: %d\n", __func__, ret);
 	da8xx_register_mcasp(0, &omapl138_hawk_snd_data);
 
+	omapl138_hawk_mmc_init();
+
 	ret = da8xx_register_watchdog();
 	if (ret)
 		pr_warning("omapl138_hawk_init: "
-- 
1.6.0.5
