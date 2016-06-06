From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH V2 linux-next] ASoC: cs53l30: include gpio/consumer.h
Date: Mon,  6 Jun 2016 19:05:53 +0200
Message-ID: <1465232753-32492-1-git-send-email-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, fabf@skynet.be
List-Id: alsa-devel@alsa-project.org

cs53l30 breaks kernel compilation when CONFIG_GPIOLIB is disabled.

sound/soc/codecs/cs53l30.c:931:2: error: implicit declaration of
function devm_gpiod_get_optional [-Werror=implicit-function-declaration]
  cs53l30->reset_gpio = devm_gpiod_get_optional(dev, "reset",
  ^
sound/soc/codecs/cs53l30.c:932:13: error: GPIOD_OUT_LOW undeclared
(first use in this function)

Including gpio/consumer.h declares minimal functions in that case.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
V2:
	Add in alphabetical order (suggested by Nicolin Chen)

 sound/soc/codecs/cs53l30.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
index ac90dd7..4f6ede9 100644
--- a/sound/soc/codecs/cs53l30.c
+++ b/sound/soc/codecs/cs53l30.c
@@ -14,6 +14,7 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/of_gpio.h>
-- 
2.1.4
