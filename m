From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v4 07/10] ARM: mxs: add sgtl5000 i2c device
Date: Tue, 19 Jul 2011 12:35:13 +0800
Message-ID: <1311050113-22325-1-git-send-email-b29396@freescale.com>
References: <1310731780-1645-8-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1310731780-1645-8-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: alsa-devel@alsa-project.org
Cc: s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org, w.sang@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
Just resend for rebase [PATCH v4 06/10] ARM: mxs: add saif device
---
 arch/arm/mach-mxs/Kconfig        |    1 +
 arch/arm/mach-mxs/mach-mx28evk.c |   17 +++++++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 405c28d..2de2ea1 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -49,6 +49,7 @@ config MACH_MX28EVK
 	select MXS_HAVE_PLATFORM_MXS_MMC
 	select MXS_HAVE_PLATFORM_MXSFB
 	select MXS_HAVE_PLATFORM_MXS_SAIF
+	select MXS_HAVE_PLATFORM_MXS_I2C
 	select MXS_OCOTP
 	help
 	  Include support for MX28EVK platform. This includes specific
diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index 1e5fda9..fe5ea41 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -18,6 +18,7 @@
 #include <linux/leds.h>
 #include <linux/irq.h>
 #include <linux/clk.h>
+#include <linux/i2c.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -184,6 +185,12 @@ static const iomux_cfg_t mx28evk_pads[] __initconst = {
 	/* led */
 	MX28_PAD_AUART1_TX__GPIO_3_5 | MXS_PAD_CTRL,
 
+	/* I2C */
+	MX28_PAD_I2C0_SCL__I2C0_SCL |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_I2C0_SDA__I2C0_SDA |
+		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+
 	/* saif0 & saif1 */
 	MX28_PAD_SAIF0_MCLK__SAIF0_MCLK |
 		(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
@@ -364,6 +371,12 @@ static struct mxs_mmc_platform_data mx28evk_mmc_pdata[] __initdata = {
 	},
 };
 
+static struct i2c_board_info mxs_i2c0_board_info[] __initdata = {
+	{
+		I2C_BOARD_INFO("sgtl5000", 0x0a),
+	},
+};
+
 static void __init mx28evk_init(void)
 {
 	int ret;
@@ -407,6 +420,10 @@ static void __init mx28evk_init(void)
 	mx28_add_saif(0);
 	mx28_add_saif(1);
 
+	mx28_add_mxs_i2c(0);
+	i2c_register_board_info(0, mxs_i2c0_board_info,
+				ARRAY_SIZE(mxs_i2c0_board_info));
+
 	/* power on mmc slot by writing 0 to the gpio */
 	ret = gpio_request_one(MX28EVK_MMC0_SLOT_POWER, GPIOF_OUT_INIT_LOW,
 			       "mmc0-slot-power");
-- 
1.7.0.4
