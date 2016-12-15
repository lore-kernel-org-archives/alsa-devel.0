From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: add GPIOLIB dependency" to the asoc tree
Date: Thu, 15 Dec 2016 12:21:05 +0000
Message-ID: <E1cHV21-0000h4-7y@debutante>
References: <1481229799-17532-1-git-send-email-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1481229799-17532-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>Krzysztof Kozlowski <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, fabf@skynet.be, alsa-devel@alsa-project.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: add GPIOLIB dependency

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 0223f500aa39a2b6df00af212da736232705be3e Mon Sep 17 00:00:00 2001
From: Fabian Frederick <fabf@skynet.be>
Date: Fri, 9 Dec 2016 19:13:26 +0100
Subject: [PATCH] ASoC: samsung: add GPIOLIB dependency

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 7c423151ef7d..f1f1d7959a1b 100644
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
2.11.0
