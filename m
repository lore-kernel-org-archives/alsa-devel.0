From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: atmel: Add dependency to
	SND_SOC_I2C_AND_SPI where necessary
Date: Sat, 11 Apr 2015 11:16:18 +0200
Message-ID: <1428743779-25581-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-051.synserver.de (smtp-out-051.synserver.de
 [212.40.185.51])
 by alsa0.perex.cz (Postfix) with ESMTP id A9E722612D3
 for <alsa-devel@alsa-project.org>; Sat, 11 Apr 2015 11:16:21 +0200 (CEST)
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

The SND_AT91_SOC_SAM9G20_WM8731 and SND_AT91_SOC_SAM9X5_WM8731 machine
driver symbols select SND_SOC_WM8731 which depends on SND_SOC_I2C_AND_SPI.
So the machine driver symbols need to depend on SND_SOC_I2C_AND_SPI as well,
otherwise we might end up with a invalid configuration, which will sooner or
later upset the randconfig auto-builders.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/atmel/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index 1579e99..2f185e5 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -25,7 +25,7 @@ config SND_ATMEL_SOC_SSC
 
 config SND_AT91_SOC_SAM9G20_WM8731
 	tristate "SoC Audio support for WM8731-based At91sam9g20 evaluation board"
-	depends on ARCH_AT91 && ATMEL_SSC && SND_ATMEL_SOC
+	depends on ARCH_AT91 && ATMEL_SSC && SND_ATMEL_SOC && SND_SOC_I2C_AND_SPI
 	select SND_ATMEL_SOC_PDC
 	select SND_ATMEL_SOC_SSC
 	select SND_SOC_WM8731
@@ -45,7 +45,7 @@ config SND_ATMEL_SOC_WM8904
 
 config SND_AT91_SOC_SAM9X5_WM8731
 	tristate "SoC Audio support for WM8731-based at91sam9x5 board"
-	depends on ARCH_AT91 && ATMEL_SSC && SND_ATMEL_SOC
+	depends on ARCH_AT91 && ATMEL_SSC && SND_ATMEL_SOC && SND_SOC_I2C_AND_SPI
 	select SND_ATMEL_SOC_SSC
 	select SND_ATMEL_SOC_DMA
 	select SND_SOC_WM8731
-- 
1.8.0
