From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 11/10] arm: mxs: mx28evk: add fixed regulators
	for audio
Date: Mon, 18 Jul 2011 18:04:21 +0200
Message-ID: <1311005061-20650-1-git-send-email-w.sang@pengutronix.de>
References: <1310731780-1645-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 7521A24342
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Jul 2011 18:04:33 +0200 (CEST)
In-Reply-To: <1310731780-1645-1-git-send-email-b29396@freescale.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dong Aisheng <b29396@freescale.com>, lrg@ti.com, Wolfram Sang <w.sang@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Add fixed regulator to enable basic audio-support until full regulator
support is done.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Dong Aisheng <b29396@freescale.com>
---

Aisheng: This is the other patch (together with [1]) making the sgtl-hack
obsolete. Needs fixed regulators, of course.

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2011-July/041974.html

 arch/arm/mach-mxs/mach-mx28evk.c |   42 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index f99fc6b..edab588 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -19,6 +19,8 @@
 #include <linux/irq.h>
 #include <linux/clk.h>
 #include <linux/i2c.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -379,6 +381,44 @@ static struct i2c_board_info mxs_i2c0_board_info[] __initdata = {
 	},
 };
 
+#if defined(CONFIG_REGULATOR_FIXED_VOLTAGE) || defined(CONFIG_REGULATOR_FIXED_VOLTAGE_MODULE)
+static struct regulator_consumer_supply mx28evk_audio_consumer_supplies[] = {
+	REGULATOR_SUPPLY("VDDA", "0-000a"),
+	REGULATOR_SUPPLY("VDDIO", "0-000a"),
+};
+
+static struct regulator_init_data mx28evk_vdd_reg_init_data = {
+	.constraints	= {
+		.name	= "3V3",
+		.always_on = 1,
+	},
+	.consumer_supplies = mx28evk_audio_consumer_supplies,
+	.num_consumer_supplies = ARRAY_SIZE(mx28evk_audio_consumer_supplies),
+};
+
+static struct fixed_voltage_config mx28evk_vdd_pdata = {
+	.supply_name	= "board-3V3",
+	.microvolts	= 3300000,
+	.gpio		= -EINVAL,
+	.enabled_at_boot = 1,
+	.init_data	= &mx28evk_vdd_reg_init_data,
+};
+static struct platform_device mx28evk_voltage_regulator = {
+	.name		= "reg-fixed-voltage",
+	.id		= -1,
+	.num_resources	= 0,
+	.dev		= {
+		.platform_data	= &mx28evk_vdd_pdata,
+	},
+};
+static void __init mx28evk_add_regulators(void)
+{
+	platform_device_register(&mx28evk_voltage_regulator);
+}
+#else
+static void __init mx28evk_add_regulators(void) {}
+#endif
+
 static void __init mx28evk_init(void)
 {
 	int ret;
@@ -426,6 +466,8 @@ static void __init mx28evk_init(void)
 	i2c_register_board_info(0, mxs_i2c0_board_info,
 				ARRAY_SIZE(mxs_i2c0_board_info));
 
+	mx28evk_add_regulators();
+
 	mxs_add_platform_device("mxs-sgtl5000", 0, NULL, 0,
 			NULL, 0);
 
-- 
1.7.5.4
