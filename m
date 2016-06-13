From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: wm8985: add i2c dependency
Date: Mon, 13 Jun 2016 17:39:42 +0200
Message-ID: <1465832422-2998958-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The wm8985 driver is now user-selectable, but building it with
I2C disabled results in a link failure:

sound/built-in.o: In function `wm8985_i2c_probe':
:(.text+0x44914): undefined reference to `__devm_regmap_init_i2c'
sound/built-in.o: In function `wm8985_exit':
:(.exit.text+0x3d8): undefined reference to `i2c_del_driver'
sound/built-in.o: In function `wm8985_modinit':
:(.init.text+0x1454): undefined reference to `i2c_register_driver'

This adds a Kconfig dependency the way that the other codec
drivers have it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 811e66de2241 ("ASoC: wm8985: add support for WM8758")
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index cb57f8fe2690..f555a5a004f7 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -986,6 +986,7 @@ config SND_SOC_WM8983
 
 config SND_SOC_WM8985
 	tristate "Wolfson Microelectronics WM8985 and WM8758 codec driver"
+	depends on I2C
 
 config SND_SOC_WM8988
 	tristate
-- 
2.7.0
