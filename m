From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH V3 2/2] ASoC: samsung: add GPIOLIB dependency
Date: Fri,  9 Dec 2016 19:13:26 +0100
Message-ID: <1481307206-3649-1-git-send-email-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, fabf@skynet.be
List-Id: alsa-devel@alsa-project.org

Both SND_SOC_SMARTQ and SND_SOC_SAMSUNG_TM2_WM5110
use gpio/consumer.h
This patch adds GPIOLIB || COMPILE_TEST to Kconfig entries
to fix runtime dependency.

See commit 638f958baeaf
("extcon: Allow compile test of GPIO consumers if !GPIOLIB")

for similar problem and explanations.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
V3:
   -Fix commit message (suggested by Krzysztof Kozlowski)
   -Add reviewed-by

 sound/soc/samsung/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 7c42315..f1f1d79 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -111,6 +111,7 @@ config SND_SOC_SAMSUNG_RX1950_UDA1380
 config SND_SOC_SMARTQ
 	tristate "SoC I2S Audio support for SmartQ board"
 	depends on MACH_SMARTQ || COMPILE_TEST
+	depends on GPIOLIB || COMPILE_TEST
 	depends on I2C
 	select SND_SAMSUNG_I2S
 	select SND_SOC_WM8750
@@ -193,6 +194,7 @@ config SND_SOC_ARNDALE_RT5631_ALC5631
 config SND_SOC_SAMSUNG_TM2_WM5110
 	tristate "SoC I2S Audio support for WM5110 on TM2 board"
 	depends on SND_SOC_SAMSUNG && MFD_ARIZONA && I2C && SPI_MASTER
+	depends on GPIOLIB || COMPILE_TEST
 	select SND_SOC_MAX98504
 	select SND_SOC_WM5110
 	select SND_SAMSUNG_I2S
-- 
2.7.4
