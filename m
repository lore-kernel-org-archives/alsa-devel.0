From: Bo Shen <voice.shen@atmel.com>
Subject: [PATCH 3/3] i2c: change the id to let the i2c-gpio work
Date: Thu, 11 Oct 2012 10:38:17 +0800
Message-ID: <1349923097-14115-4-git-send-email-voice.shen@atmel.com>
References: <1349923097-14115-1-git-send-email-voice.shen@atmel.com>
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <1349923097-14115-1-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, nicolas.ferre@atmel.com, jm.lin@atmel.com, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 arch/arm/mach-at91/at91sam9260_devices.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 0f24cfb..805ef95 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -389,7 +389,7 @@ static struct i2c_gpio_platform_data pdata = {
 
 static struct platform_device at91sam9260_twi_device = {
 	.name			= "i2c-gpio",
-	.id			= -1,
+	.id			= 0,
 	.dev.platform_data	= &pdata,
 };
 
-- 
1.7.9.5

