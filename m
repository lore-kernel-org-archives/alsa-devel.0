From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: [PATCH,
	RFC 3/3] pxa/magician: add I2C board info and platform data for
	UDA1380
Date: Sun, 14 Jun 2009 12:51:32 +0200
Message-ID: <1244976692-5189-5-git-send-email-philipp.zabel@gmail.com>
References: <1244976692-5189-1-git-send-email-philipp.zabel@gmail.com>
	<1244976692-5189-2-git-send-email-philipp.zabel@gmail.com>
	<1244976692-5189-3-git-send-email-philipp.zabel@gmail.com>
	<1244976692-5189-4-git-send-email-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f218.google.com (mail-fx0-f218.google.com
	[209.85.220.218])
	by alsa0.perex.cz (Postfix) with ESMTP id E7365246C4
	for <alsa-devel@alsa-project.org>;
	Sun, 14 Jun 2009 12:51:52 +0200 (CEST)
Received: by mail-fx0-f218.google.com with SMTP id 18so2976723fxm.32
	for <alsa-devel@alsa-project.org>; Sun, 14 Jun 2009 03:51:52 -0700 (PDT)
In-Reply-To: <1244976692-5189-4-git-send-email-philipp.zabel@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

Configures I2C address, power/reset GPIOs and DAC clock from WSPLL.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 arch/arm/mach-pxa/magician.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 869f083..3da8284 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -43,6 +43,8 @@
 #include <mach/irda.h>
 #include <mach/ohci.h>
 
+#include <sound/uda1380.h>
+
 #include "devices.h"
 #include "generic.h"
 
@@ -862,9 +864,22 @@ static struct platform_device calypso = {
 };
 
 /*
- * I2C
+ * Philips UDA1380 on I2C
  */
 
+static struct uda1380_platform_data uda1380_info = {
+	.gpio_power = EGPIO_MAGICIAN_CODEC_POWER,
+	.gpio_reset = EGPIO_MAGICIAN_CODEC_RESET,
+	.dac_clk    = UDA1380_DAC_CLK_WSPLL,
+};
+
+static struct i2c_board_info i2c_board_info[] = {
+	{
+		I2C_BOARD_INFO("uda1380", 0x18),
+		.platform_data = &uda1380_info,
+	},
+};
+
 static struct i2c_pxa_platform_data i2c_info = {
 	.fast_mode = 1,
 };
@@ -906,6 +921,7 @@ static void __init magician_init(void)
 	}
 	pxa27x_set_i2c_power_info(NULL);
 	pxa_set_i2c_info(&i2c_info);
+	i2c_register_board_info(0, ARRAY_AND_SIZE(i2c_board_info));
 	i2c_register_board_info(1, ARRAY_AND_SIZE(pi2c_board_info));
 	pxa_set_mci_info(&magician_mci_info);
 	pxa_set_ohci_info(&magician_ohci_info);
-- 
1.6.3.1
