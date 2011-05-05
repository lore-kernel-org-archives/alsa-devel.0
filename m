From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/4] Blackfin: Use 8bit spi transfers for the
	ad1836
Date: Thu,  5 May 2011 19:52:43 +0200
Message-ID: <1304617966-4410-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-227.synserver.de
	[212.40.185.227])
	by alsa0.perex.cz (Postfix) with ESMTP id 65E332414F
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 19:53:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Mike Frysinger <vapier@gentoo.org>
Cc: device-driver-devel@blackfin.uclinux.org, uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Currently there is a special case for the ad1836 in the ASoC generic spi write
functions, which swaps the upper and the lower byte for 4/12 transfers.
This was done, because the 4/12 spi write function was added for the ad1836
for which all of the users are configured to use use 16-bit transfers.
In order to be able to get rid of this special casing switch all users of
ad1836 to 8-bit transfers.

Since 8-bit, no-dma transfers is the default configuration we can remove the
bfin5xx_spi_chip struct for the ad1836 altogether.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/blackfin/mach-bf527/boards/ad7160eval.c |    9 ---------
 arch/blackfin/mach-bf527/boards/cm_bf527.c   |    9 ---------
 arch/blackfin/mach-bf527/boards/ezkit.c      |    9 ---------
 arch/blackfin/mach-bf533/boards/H8606.c      |    8 --------
 arch/blackfin/mach-bf533/boards/cm_bf533.c   |    8 --------
 arch/blackfin/mach-bf533/boards/ezkit.c      |    8 --------
 arch/blackfin/mach-bf533/boards/stamp.c      |    8 --------
 arch/blackfin/mach-bf537/boards/cm_bf537e.c  |    8 --------
 arch/blackfin/mach-bf537/boards/cm_bf537u.c  |    8 --------
 arch/blackfin/mach-bf537/boards/pnav10.c     |    9 ---------
 arch/blackfin/mach-bf537/boards/stamp.c      |    9 ---------
 arch/blackfin/mach-bf537/boards/tcm_bf537.c  |    8 --------
 arch/blackfin/mach-bf548/boards/ezkit.c      |    9 ---------
 arch/blackfin/mach-bf561/boards/cm_bf561.c   |    8 --------
 arch/blackfin/mach-bf561/boards/ezkit.c      |    9 ---------
 15 files changed, 0 insertions(+), 127 deletions(-)

diff --git a/arch/blackfin/mach-bf527/boards/ad7160eval.c b/arch/blackfin/mach-bf527/boards/ad7160eval.c
index ccab4c6..eb712ce 100644
--- a/arch/blackfin/mach-bf527/boards/ad7160eval.c
+++ b/arch/blackfin/mach-bf527/boards/ad7160eval.c
@@ -269,14 +269,6 @@ static struct bfin5xx_spi_chip spi_flash_chip_info = {
 };
 #endif
 
-#if defined(CONFIG_SND_BF5XX_SOC_AD183X) \
-	|| defined(CONFIG_SND_BF5XX_SOC_AD183X_MODULE)
-static struct bfin5xx_spi_chip ad1836_spi_chip_info = {
-	.enable_dma = 0,
-	.bits_per_word = 16,
-};
-#endif
-
 #if defined(CONFIG_MMC_SPI) || defined(CONFIG_MMC_SPI_MODULE)
 static struct bfin5xx_spi_chip  mmc_spi_chip_info = {
 	.enable_dma = 0,
@@ -328,7 +320,6 @@ static struct spi_board_info bfin_spi_board_info[] __initdata = {
 		.max_speed_hz = 3125000,     /* max spi clock (SCK) speed in HZ */
 		.bus_num = 0,
 		.chip_select = 4,
-		.controller_data = &ad1836_spi_chip_info,
 	},
 #endif
 #if defined(CONFIG_MMC_SPI) || defined(CONFIG_MMC_SPI_MODULE)
diff --git a/arch/blackfin/mach-bf527/boards/cm_bf527.c b/arch/blackfin/mach-bf527/boards/cm_bf527.c
index c9d6dc8..ccdf2e7 100644
--- a/arch/blackfin/mach-bf527/boards/cm_bf527.c
+++ b/arch/blackfin/mach-bf527/boards/cm_bf527.c
@@ -367,14 +367,6 @@ static struct bfin5xx_spi_chip spi_adc_chip_info = {
 };
 #endif
 
-#if defined(CONFIG_SND_BF5XX_SOC_AD183X) \
-	|| defined(CONFIG_SND_BF5XX_SOC_AD183X_MODULE)
-static struct bfin5xx_spi_chip ad1836_spi_chip_info = {
-	.enable_dma = 0,
-	.bits_per_word = 16,
-};
-#endif
-
 #if defined(CONFIG_MMC_SPI) || defined(CONFIG_MMC_SPI_MODULE)
 static struct bfin5xx_spi_chip  mmc_spi_chip_info = {
 	.enable_dma = 0,
@@ -452,7 +444,6 @@ static struct spi_board_info bfin_spi_board_info[] __initdata = {
 		.max_speed_hz = 3125000,     /* max spi clock (SCK) speed in HZ */
 		.bus_num = 0,
 		.chip_select = 4,
-		.controller_data = &ad1836_spi_chip_info,
 	},
 #endif
 #if defined(CONFIG_MMC_SPI) || defined(CONFIG_MMC_SPI_MODULE)
diff --git a/arch/blackfin/mach-bf527/boards/ezkit.c b/arch/blackfin/mach-bf527/boards/ezkit.c
index 2cd2ff6..503837b 100644
--- a/arch/blackfin/mach-bf527/boards/ezkit.c
+++ b/arch/blackfin/mach-bf527/boards/ezkit.c
@@ -460,14 +460,6 @@ static struct bfin5xx_spi_chip spi_adc_chip_info = {
 };
 #endif
 
-#if defined(CONFIG_SND_BF5XX_SOC_AD183X) \
-	|| defined(CONFIG_SND_BF5XX_SOC_AD183X_MODULE)
-static struct bfin5xx_spi_chip ad1836_spi_chip_info = {
-	.enable_dma = 0,
-	.bits_per_word = 16,
-};
-#endif
-
 #if defined(CONFIG_MMC_SPI) || defined(CONFIG_MMC_SPI_MODULE)
 static struct bfin5xx_spi_chip  mmc_spi_chip_info = {
 	.enable_dma = 0,
@@ -583,7 +575,6 @@ static struct spi_board_info bfin_spi_board_info[] __initdata = {
 		.max_speed_hz = 3125000,     /* max spi clock (SCK) speed in HZ */
 		.bus_num = 0,
 		.chip_select = 4,
-		.controller_data = &ad1836_spi_chip_info,
 	},
 #endif
 #if defined(CONFIG_MMC_SPI) || defined(CONFIG_MMC_SPI_MODULE)
diff --git a/arch/blackfin/mach-bf533/boards/H8606.c b/arch/blackfin/mach-bf533/boards/H8606.c
index d4bfcea..41c9329 100644
--- a/arch/blackfin/mach-bf533/boards/H8606.c
+++ b/arch/blackfin/mach-bf533/boards/H8606.c
@@ -171,13 +171,6 @@ static struct bfin5xx_spi_chip spi_adc_chip_info = {
 };
 #endif
 
-#if defined(CONFIG_SND_BF5XX_SOC_AD183X) || defined(CONFIG_SND_BF5XX_SOC_AD183X_MODULE)
-static struct bfin5xx_spi_chip ad1836_spi_chip_info = {
-	.enable_dma = 0,
-	.bits_per_word = 16,
-};
-#endif
-
 /* Notice: for blackfin, the speed_hz is the value of register
  * SPI_BAUD, not the real baudrate */
 static struct spi_board_info bfin_spi_board_info[] __initdata = {
@@ -212,7 +205,6 @@ static struct spi_board_info bfin_spi_board_info[] __initdata = {
 		.max_speed_hz = 16,
 		.bus_num = 1,
 		.chip_select = 4,
-		.controller_data = &ad1836_spi_chip_info,
 	},
 #endif
 
diff --git a/arch/blackfin/mach-bf533/boards/cm_bf533.c b/arch/blackfin/mach-bf533/boards/cm_bf533.c
index 4d5604e..2506703 100644
--- a/arch/blackfin/mach-bf533/boards/cm_bf533.c
+++ b/arch/blackfin/mach-bf533/boards/cm_bf533.c
@@ -71,13 +71,6 @@ static struct bfin5xx_spi_chip spi_adc_chip_info = {
 };
 #endif
 
-#if defined(CONFIG_SND_BF5XX_SOC_AD183X) || defined(CONFIG_SND_BF5XX_SOC_AD183X_MODULE)
-static struct bfin5xx_spi_chip ad1836_spi_chip_info = {
-	.enable_dma = 0,
-	.bits_per_word = 16,
-};
-#endif
-
 #if defined(CONFIG_MMC_SPI) || defined(CONFIG_MMC_SPI_MODULE)
 static struct bfin5xx_spi_chip mmc_spi_chip_info = {
 	.enable_dma = 0,
@@ -116,7 +109,6 @@ static struct spi_board_info bfin_spi_board_info[] __initdata = {
 		.max_speed_hz = 3125000,     /* max spi clock (SCK) speed in HZ */
 		.bus_num = 0,
 		.chip_select = 4,
-		.controller_data = &ad1836_spi_chip_info,
 	},
 #endif
 
diff --git a/arch/blackfin/mach-bf533/boards/ezkit.c b/arch/blackfin/mach-bf533/boards/ezkit.c
index b67b91d..7d82463 100644
--- a/arch/blackfin/mach-bf533/boards/ezkit.c
+++ b/arch/blackfin/mach-bf533/boards/ezkit.c
@@ -222,13 +222,6 @@ static struct bfin5xx_spi_chip spi_adc_chip_info = {
 };
 #endif
 
-#if defined(CONFIG_SND_BF5XX_SOC_AD183X) || defined(CONFIG_SND_BF5XX_SOC_AD183X_MODULE)
-static struct bfin5xx_spi_chip ad1836_spi_chip_info = {
-	.enable_dma = 0,
-	.bits_per_word = 16,
-};
-#endif
-
 #if defined(CONFIG_SPI_SPIDEV) || defined(CONFIG_SPI_SPIDEV_MODULE)
 static struct bfin5xx_spi_chip spidev_chip_info = {
 	.enable_dma = 0,
@@ -267,7 +260,6 @@ static struct spi_board_info bfin_spi_board_info[] __initdata = {
 		.max_speed_hz = 3125000,     /* max spi clock (SCK) speed in HZ */
 		.bus_num = 0,
 		.chip_select = 4,
-		.controller_data = &ad1836_spi_chip_info,
 	},
 #endif
 #if defined(CONFIG_SPI_SPIDEV) || defined(CONFIG_SPI_SPIDEV_MODULE)
diff --git a/arch/blackfin/mach-bf533/boards/stamp.c b/arch/blackfin/mach-bf533/boards/stamp.c
index 43224ef..32091b8 100644
--- a/arch/blackfin/mach-bf533/boards/stamp.c
+++ b/arch/blackfin/mach-bf533/boards/stamp.c
@@ -184,13 +184,6 @@ static struct bfin5xx_spi_chip spi_adc_chip_info = {
 };
 #endif
 
-#if defined(CONFIG_SND_BF5XX_SOC_AD183X) || defined(CONFIG_SND_BF5XX_SOC_AD183X_MODULE)
-static struct bfin5xx_spi_chip ad1836_spi_chip_info = {
-	.enable_dma = 0,
-	.bits_per_word = 16,
-};
-#endif
-
 #if defined(CONFIG_SPI_SPIDEV) || defined(CONFIG_SPI_SPIDEV_MODULE)
 static struct bfin5xx_spi_chip spidev_chip_info = {
 	.enable_dma = 0,
@@ -258,7 +251,6 @@ static struct spi_board_info bfin_spi_board_info[] __initdata = {
 		.bus_num = 0,
 		.chip_select = 4,
 		.platform_data = "ad1836", /* only includes chip name for the moment */
-		.controller_data = &ad1836_spi_chip_info,
 		.mode = SPI_MODE_3,
 	},
 #endif
diff --git a/arch/blackfin/mach-bf537/boards/cm_bf537e.c b/arch/blackfin/mach-bf537/boards/cm_bf537e.c
index d582b81..cb0a34e 100644
--- a/arch/blackfin/mach-bf537/boards/cm_bf537e.c
+++ b/arch/blackfin/mach-bf537/boards/cm_bf537e.c
@@ -73,13 +73,6 @@ static struct bfin5xx_spi_chip spi_adc_chip_info = {
 };
 #endif
 
-#if defined(CONFIG_SND_BF5XX_SOC_AD183X) || defined(CONFIG_SND_BF5XX_SOC_AD183X_MODULE)
-static struct bfin5xx_spi_chip ad1836_spi_chip_info = {
-	.enable_dma = 0,
-	.bits_per_word = 16,
-};
-#endif
-
 #if defined(CONFIG_MMC_SPI) || defined(CONFIG_MMC_SPI_MODULE)
 static struct bfin5xx_spi_chip  mmc_spi_chip_info = {
 	.enable_dma = 0,
@@ -118,7 +111,6 @@ static struct spi_board_info bfin_spi_board_info[] __initdata = {
 		.max_speed_hz = 3125000,     /* max spi clock (SCK) speed in HZ */
 		.bus_num = 0,
 		.chip_select = 4,
-		.controller_data = &ad1836_spi_chip_info,
 	},
 #endif
 
diff --git a/arch/blackfin/mach-bf537/boards/cm_bf537u.c b/arch/blackfin/mach-bf537/boards/cm_bf537u.c
index cbb8098..197a77c 100644
--- a/arch/blackfin/mach-bf537/boards/cm_bf537u.c
+++ b/arch/blackfin/mach-bf537/boards/cm_bf537u.c
@@ -74,13 +74,6 @@ static struct bfin5xx_spi_chip spi_adc_chip_info = {
 };
 #endif
 
-#if defined(CONFIG_SND_BF5XX_SOC_AD183X) || defined(CONFIG_SND_BF5XX_SOC_AD183X_MODULE)
-static struct bfin5xx_spi_chip ad1836_spi_chip_info = {
-	.enable_dma = 0,
-	.bits_per_word = 16,
-};
-#endif
-
 #if defined(CONFIG_MMC_SPI) || defined(CONFIG_MMC_SPI_MODULE)
 static struct bfin5xx_spi_chip  mmc_spi_chip_info = {
 	.enable_dma = 0,
@@ -119,7 +112,6 @@ static struct spi_board_info bfin_spi_board_info[] __initdata = {
 		.max_speed_hz = 3125000,     /* max spi clock (SCK) speed in HZ */
 		.bus_num = 0,
 		.chip_select = 4,
-		.controller_data = &ad1836_spi_chip_info,
 	},
 #endif
 
diff --git a/arch/blackfin/mach-bf537/boards/pnav10.c b/arch/blackfin/mach-bf537/boards/pnav10.c
index 9389f03..7037128 100644
--- a/arch/blackfin/mach-bf537/boards/pnav10.c
+++ b/arch/blackfin/mach-bf537/boards/pnav10.c
@@ -197,14 +197,6 @@ static struct bfin5xx_spi_chip spi_adc_chip_info = {
 };
 #endif
 
-#if defined(CONFIG_SND_BF5XX_SOC_AD183X) \
-	|| defined(CONFIG_SND_BF5XX_SOC_AD183X_MODULE)
-static struct bfin5xx_spi_chip ad1836_spi_chip_info = {
-	.enable_dma = 0,
-	.bits_per_word = 16,
-};
-#endif
-
 #if defined(CONFIG_MMC_SPI) || defined(CONFIG_MMC_SPI_MODULE)
 static struct bfin5xx_spi_chip mmc_spi_chip_info = {
 	.enable_dma = 0,
@@ -267,7 +259,6 @@ static struct spi_board_info bfin_spi_board_info[] __initdata = {
 		.max_speed_hz = 3125000,     /* max spi clock (SCK) speed in HZ */
 		.bus_num = 0,
 		.chip_select = 4,
-		.controller_data = &ad1836_spi_chip_info,
 	},
 #endif
 #if defined(CONFIG_MMC_SPI) || defined(CONFIG_MMC_SPI_MODULE)
diff --git a/arch/blackfin/mach-bf537/boards/stamp.c b/arch/blackfin/mach-bf537/boards/stamp.c
index 3fa3354..343f969 100644
--- a/arch/blackfin/mach-bf537/boards/stamp.c
+++ b/arch/blackfin/mach-bf537/boards/stamp.c
@@ -549,14 +549,6 @@ static struct bfin5xx_spi_chip spi_adc_chip_info = {
 };
 #endif
 
-#if defined(CONFIG_SND_BF5XX_SOC_AD183X) \
-	|| defined(CONFIG_SND_BF5XX_SOC_AD183X_MODULE)
-static struct bfin5xx_spi_chip ad1836_spi_chip_info = {
-	.enable_dma = 0,
-	.bits_per_word = 16,
-};
-#endif
-
 #if defined(CONFIG_SND_BF5XX_SOC_AD193X) \
 	|| defined(CONFIG_SND_BF5XX_SOC_AD193X_MODULE)
 static struct bfin5xx_spi_chip ad1938_spi_chip_info = {
@@ -1076,7 +1068,6 @@ static struct spi_board_info bfin_spi_board_info[] __initdata = {
 		.bus_num = 0,
 		.chip_select = 4,
 		.platform_data = "ad1836", /* only includes chip name for the moment */
-		.controller_data = &ad1836_spi_chip_info,
 		.mode = SPI_MODE_3,
 	},
 #endif
diff --git a/arch/blackfin/mach-bf537/boards/tcm_bf537.c b/arch/blackfin/mach-bf537/boards/tcm_bf537.c
index 164a7e0..b720fec 100644
--- a/arch/blackfin/mach-bf537/boards/tcm_bf537.c
+++ b/arch/blackfin/mach-bf537/boards/tcm_bf537.c
@@ -74,13 +74,6 @@ static struct bfin5xx_spi_chip spi_adc_chip_info = {
 };
 #endif
 
-#if defined(CONFIG_SND_BF5XX_SOC_AD183X) || defined(CONFIG_SND_BF5XX_SOC_AD183X_MODULE)
-static struct bfin5xx_spi_chip ad1836_spi_chip_info = {
-	.enable_dma = 0,
-	.bits_per_word = 16,
-};
-#endif
-
 #if defined(CONFIG_MMC_SPI) || defined(CONFIG_MMC_SPI_MODULE)
 static struct bfin5xx_spi_chip mmc_spi_chip_info = {
 	.enable_dma = 0,
@@ -119,7 +112,6 @@ static struct spi_board_info bfin_spi_board_info[] __initdata = {
 		.max_speed_hz = 3125000,     /* max spi clock (SCK) speed in HZ */
 		.bus_num = 0,
 		.chip_select = 4,
-		.controller_data = &ad1836_spi_chip_info,
 	},
 #endif
 
diff --git a/arch/blackfin/mach-bf548/boards/ezkit.c b/arch/blackfin/mach-bf548/boards/ezkit.c
index 93e19a5..002e0f9 100644
--- a/arch/blackfin/mach-bf548/boards/ezkit.c
+++ b/arch/blackfin/mach-bf548/boards/ezkit.c
@@ -1013,14 +1013,6 @@ static struct bfin5xx_spi_chip spi_flash_chip_info = {
 };
 #endif
 
-#if defined(CONFIG_SND_BF5XX_SOC_AD183X) \
-	|| defined(CONFIG_SND_BF5XX_SOC_AD183X_MODULE)
-static struct bfin5xx_spi_chip ad1836_spi_chip_info = {
-	.enable_dma = 0,
-	.bits_per_word = 16,
-};
-#endif
-
 #if defined(CONFIG_TOUCHSCREEN_AD7877) || defined(CONFIG_TOUCHSCREEN_AD7877_MODULE)
 static struct bfin5xx_spi_chip spi_ad7877_chip_info = {
 	.enable_dma = 0,
@@ -1077,7 +1069,6 @@ static struct spi_board_info bfin_spi_board_info[] __initdata = {
 		.max_speed_hz = 3125000,     /* max spi clock (SCK) speed in HZ */
 		.bus_num = 1,
 		.chip_select = 4,
-		.controller_data = &ad1836_spi_chip_info,
 	},
 #endif
 #if defined(CONFIG_TOUCHSCREEN_AD7877) || defined(CONFIG_TOUCHSCREEN_AD7877_MODULE)
diff --git a/arch/blackfin/mach-bf561/boards/cm_bf561.c b/arch/blackfin/mach-bf561/boards/cm_bf561.c
index 87595cd..1418053 100644
--- a/arch/blackfin/mach-bf561/boards/cm_bf561.c
+++ b/arch/blackfin/mach-bf561/boards/cm_bf561.c
@@ -72,13 +72,6 @@ static struct bfin5xx_spi_chip spi_adc_chip_info = {
 };
 #endif
 
-#if defined(CONFIG_SND_BF5XX_SOC_AD183X) || defined(CONFIG_SND_BF5XX_SOC_AD183X_MODULE)
-static struct bfin5xx_spi_chip ad1836_spi_chip_info = {
-	.enable_dma = 0,
-	.bits_per_word = 16,
-};
-#endif
-
 #if defined(CONFIG_MMC_SPI) || defined(CONFIG_MMC_SPI_MODULE)
 static struct bfin5xx_spi_chip mmc_spi_chip_info = {
 	.enable_dma = 0,
@@ -117,7 +110,6 @@ static struct spi_board_info bfin_spi_board_info[] __initdata = {
 		.max_speed_hz = 3125000,     /* max spi clock (SCK) speed in HZ */
 		.bus_num = 0,
 		.chip_select = 4,
-		.controller_data = &ad1836_spi_chip_info,
 	},
 #endif
 #if defined(CONFIG_MMC_SPI) || defined(CONFIG_MMC_SPI_MODULE)
diff --git a/arch/blackfin/mach-bf561/boards/ezkit.c b/arch/blackfin/mach-bf561/boards/ezkit.c
index f667e77..9f58605 100644
--- a/arch/blackfin/mach-bf561/boards/ezkit.c
+++ b/arch/blackfin/mach-bf561/boards/ezkit.c
@@ -275,14 +275,6 @@ static struct platform_device ezkit_flash_device = {
 };
 #endif
 
-#if defined(CONFIG_SND_BF5XX_SOC_AD183X) \
-	|| defined(CONFIG_SND_BF5XX_SOC_AD183X_MODULE)
-static struct bfin5xx_spi_chip ad1836_spi_chip_info = {
-	.enable_dma = 0,
-	.bits_per_word = 16,
-};
-#endif
-
 #if defined(CONFIG_SPI_SPIDEV) || defined(CONFIG_SPI_SPIDEV_MODULE)
 static struct bfin5xx_spi_chip spidev_chip_info = {
 	.enable_dma = 0,
@@ -337,7 +329,6 @@ static struct spi_board_info bfin_spi_board_info[] __initdata = {
 		.bus_num = 0,
 		.chip_select = 4,
 		.platform_data = "ad1836", /* only includes chip name for the moment */
-		.controller_data = &ad1836_spi_chip_info,
 		.mode = SPI_MODE_3,
 	},
 #endif
-- 
1.7.2.5
