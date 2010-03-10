From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: [PATCH 4/4] mmp: enable sound in aspenite
Date: Wed, 10 Mar 2010 08:16:23 -0500
Message-ID: <771cded01003100516q6d02ad42qb992e03c5380803e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f175.google.com (mail-pz0-f175.google.com
	[209.85.222.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 5992A10398A
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 14:16:24 +0100 (CET)
Received: by pzk5 with SMTP id 5so680914pzk.16
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 05:16:23 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Eric Miao <eric.y.miao@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

>From 2fbfce5a3cd1c17b4a8ea00bcc9c8be85fe9977a Mon Sep 17 00:00:00 2001
From: Haojian Zhuang <haojian.zhuang@marvell.com>
Date: Wed, 10 Mar 2010 06:35:43 -0500
Subject: [PATCH] [ARM] mmp: enable sound in aspenite

Enable sound on aspenite. Hifi mode is supported.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/aspenite.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index a2d307e..244655d 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -59,6 +59,13 @@ static unsigned long common_pin_config[] __initdata = {
 	/* UART1 */
 	GPIO107_UART1_RXD,
 	GPIO108_UART1_TXD,
+
+	/* SSP1 */
+	GPIO113_I2S_MCLK,
+	GPIO114_I2S_FRM,
+	GPIO115_I2S_BCLK,
+	GPIO116_I2S_RXD,
+	GPIO117_I2S_TXD,
 };

 static struct smc91x_platdata smc91x_info = {
@@ -123,12 +130,18 @@ static struct pxa3xx_nand_platform_data
aspenite_nand_info = {
 	.nr_parts	= ARRAY_SIZE(aspenite_nand_partitions),
 };

+static struct i2c_board_info aspenite_i2c_info[] __initdata = {
+	{ I2C_BOARD_INFO("wm8753", 0x1b), },
+};
+
 static void __init common_init(void)
 {
 	mfp_config(ARRAY_AND_SIZE(common_pin_config));

 	/* on-chip devices */
 	pxa168_add_uart(1);
+	pxa168_add_twsi(1, NULL, ARRAY_AND_SIZE(aspenite_i2c_info));
+	pxa168_add_ssp(1);
 	pxa168_add_nand(&aspenite_nand_info);

 	/* off-chip devices */
-- 
1.5.6.5
