From: Xia Kaixu <kaixu.xia@linaro.org>
Subject: [PATCH 12/15] ASoC: Atmel WM8904 codec support needs I2C
Date: Tue, 29 Apr 2014 19:18:33 +0800
Message-ID: <1398770316-19715-13-git-send-email-kaixu.xia@linaro.org>
References: <1398770316-19715-1-git-send-email-kaixu.xia@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398770316-19715-1-git-send-email-kaixu.xia@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linaro-kernel@lists.linaro.org, arnd@arndb.de, kaixu.xia@linaro.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Arnd Bergmann <arnd@arndb.de>

The WM8904 codec driver needs I2C to be enabled, so the
SND_ATMEL_SOC_WM8904 option also requires this.

Found using randconfig build testing.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Xia Kaixu <kaixu.xia@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/atmel/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index 4789619..27e3fc4 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -35,7 +35,7 @@ config SND_AT91_SOC_SAM9G20_WM8731
 
 config SND_ATMEL_SOC_WM8904
 	tristate "Atmel ASoC driver for boards using WM8904 codec"
-	depends on ARCH_AT91 && ATMEL_SSC && SND_ATMEL_SOC
+	depends on ARCH_AT91 && ATMEL_SSC && SND_ATMEL_SOC && I2C
 	select SND_ATMEL_SOC_SSC
 	select SND_ATMEL_SOC_DMA
 	select SND_SOC_WM8904
-- 
1.7.9.5
