From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH 2/2] pxa2xx: make pxa2xx_ac97_reset use MFP
Date: Mon, 25 May 2009 13:20:19 +0400
Message-ID: <1243243219-23786-2-git-send-email-dbaryshkov@gmail.com>
References: <1243243219-23786-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.145])
	by alsa0.perex.cz (Postfix) with ESMTP id BA450103868
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 11:20:34 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 26so607677eyw.56
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2009 02:20:33 -0700 (PDT)
In-Reply-To: <1243243219-23786-1-git-send-email-dbaryshkov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.miao@marvell.com>
List-Id: alsa-devel@alsa-project.org

Stop using obsolete pxa_gpio_mode, use MFP and GPIO API for setting pin
parameters.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Eric Miao <eric.miao@marvell.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-pxa/pxa27x.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index a0e787e..8674581 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -355,30 +355,30 @@ void __init pxa27x_set_i2c_power_info(struct i2c_pxa_platform_data *info)
  * computes the correct gpio_mode for further use by reset functions, and
  * applied the change through pxa_gpio_mode.
  */
-/* temporary include */
-#include <mach/pxa2xx-gpio.h>
 void pxa27x_ac97_reset(int reset_gpio, int resetgpio_action)
 {
-	int mode = 0;
+	unsigned long mfp[1] = {0};
 
 	if (reset_gpio)
 		switch (resetgpio_action) {
 		case RESETGPIO_NORMAL_ALTFUNC:
 			if (reset_gpio == 113)
-				mode = 113 | GPIO_ALT_FN_2_OUT;
+				mfp[0] = GPIO113_AC97_nRESET;
 			if (reset_gpio == 95)
-				mode = 95 | GPIO_ALT_FN_1_OUT;
+				mfp[0] = GPIO95_AC97_nRESET;
+			pxa2xx_mfp_config(mfp, 1);
 			break;
 		case RESETGPIO_FORCE_LOW:
-			mode = reset_gpio | GPIO_OUT | GPIO_DFLT_LOW;
+			mfp[0] = MFP_CFG_OUT(GPIO0, AF0, DRIVE_LOW) | MFP_PIN(reset_gpio);
+			pxa2xx_mfp_config(mfp, 1);
+			gpio_direction_output(reset_gpio, 0);
 			break;
 		case RESETGPIO_FORCE_HIGH:
-			mode = reset_gpio | GPIO_OUT | GPIO_DFLT_HIGH;
+			mfp[0] = MFP_CFG_OUT(GPIO0, AF0, DRIVE_HIGH) | MFP_PIN(reset_gpio);
+			pxa2xx_mfp_config(mfp, 1);
+			gpio_direction_output(reset_gpio, 1);
 			break;
 		};
-
-	if (mode)
-		pxa_gpio_mode(mode);
 }
 EXPORT_SYMBOL(pxa27x_ac97_reset);
 
-- 
1.6.2.4
