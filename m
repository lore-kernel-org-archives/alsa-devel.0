From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: [PATCH v2 2/9] ARM: Kirkwood: Remove platform driver for codec
Date: Sat,  3 May 2014 20:30:12 +0200
Message-ID: <1399141819-23924-3-git-send-email-andrew@lunn.ch>
References: <1399141819-23924-1-git-send-email-andrew@lunn.ch>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1399141819-23924-1-git-send-email-andrew-g2DYL2Zd6BY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Remove the platform driver and platform data for the audio codec.
A DT node will replace it.

Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
---
 arch/arm/mach-mvebu/board-t5325.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/arm/mach-mvebu/board-t5325.c b/arch/arm/mach-mvebu/board-t5325.c
index 65ace6db9f28..f2401b298218 100644
--- a/arch/arm/mach-mvebu/board-t5325.c
+++ b/arch/arm/mach-mvebu/board-t5325.c
@@ -11,10 +11,8 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <sound/alc5623.h>
 #include "board.h"
 
 static struct platform_device hp_t5325_audio_device = {
@@ -22,20 +20,7 @@ static struct platform_device hp_t5325_audio_device = {
 	.id		= -1,
 };
 
-static struct alc5623_platform_data alc5621_data = {
-	.add_ctrl = 0x3700,
-	.jack_det_ctrl = 0x4810,
-};
-
-static struct i2c_board_info i2c_board_info[] __initdata = {
-	{
-		I2C_BOARD_INFO("alc5621", 0x1a),
-		.platform_data = &alc5621_data,
-	},
-};
-
 void __init t5325_init(void)
 {
-	i2c_register_board_info(0, i2c_board_info, ARRAY_SIZE(i2c_board_info));
 	platform_device_register(&hp_t5325_audio_device);
 }
-- 
2.0.0.rc0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
