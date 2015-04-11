From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] ASoC: atmel: Improve machine driver
	compile test coverage
Date: Sat, 11 Apr 2015 11:16:19 +0200
Message-ID: <1428743779-25581-2-git-send-email-lars@metafoo.de>
References: <1428743779-25581-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-051.synserver.de (smtp-out-051.synserver.de
 [212.40.185.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 043DE261493
 for <alsa-devel@alsa-project.org>; Sat, 11 Apr 2015 11:16:21 +0200 (CEST)
In-Reply-To: <1428743779-25581-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Nicolas Ferre <nicolas.ferre@atmel.com>
List-Id: alsa-devel@alsa-project.org

The Atmel ASoC machine drivers don't have any compile time arch dependencies
anymore. Make it possible to select them when COMPILE_TEST is enabled to get
better compile test coverage.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/atmel/Kconfig | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index 2f185e5..e7d0880 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -25,7 +25,8 @@ config SND_ATMEL_SOC_SSC
 
 config SND_AT91_SOC_SAM9G20_WM8731
 	tristate "SoC Audio support for WM8731-based At91sam9g20 evaluation board"
-	depends on ARCH_AT91 && ATMEL_SSC && SND_ATMEL_SOC && SND_SOC_I2C_AND_SPI
+	depends on ARCH_AT91 || COMPILE_TEST
+	depends on ATMEL_SSC && SND_ATMEL_SOC && SND_SOC_I2C_AND_SPI
 	select SND_ATMEL_SOC_PDC
 	select SND_ATMEL_SOC_SSC
 	select SND_SOC_WM8731
@@ -35,7 +36,8 @@ config SND_AT91_SOC_SAM9G20_WM8731
 
 config SND_ATMEL_SOC_WM8904
 	tristate "Atmel ASoC driver for boards using WM8904 codec"
-	depends on ARCH_AT91 && ATMEL_SSC && SND_ATMEL_SOC && I2C
+	depends on ARCH_AT91 || COMPILE_TEST
+	depends on ATMEL_SSC && SND_ATMEL_SOC && I2C
 	select SND_ATMEL_SOC_SSC
 	select SND_ATMEL_SOC_DMA
 	select SND_SOC_WM8904
@@ -45,7 +47,8 @@ config SND_ATMEL_SOC_WM8904
 
 config SND_AT91_SOC_SAM9X5_WM8731
 	tristate "SoC Audio support for WM8731-based at91sam9x5 board"
-	depends on ARCH_AT91 && ATMEL_SSC && SND_ATMEL_SOC && SND_SOC_I2C_AND_SPI
+	depends on ARCH_AT91 || COMPILE_TEST
+	depends on ATMEL_SSC && SND_ATMEL_SOC && SND_SOC_I2C_AND_SPI
 	select SND_ATMEL_SOC_SSC
 	select SND_ATMEL_SOC_DMA
 	select SND_SOC_WM8731
-- 
1.8.0
