From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] ASoC: fix kconfig order of Blackfin drivers
Date: Thu,  1 Oct 2009 01:33:30 -0400
Message-ID: <1254375210-14928-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 3AA9710380E
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 07:33:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Barry Song <barry.song@analog.com>
List-Id: alsa-devel@alsa-project.org

From: Barry Song <barry.song@analog.com>

Some of the Blackfin options don't directly follow the kconfig options
they depend on, so kconfig is unable to display the proper tree.  So sort
the options such they expand/collapse properly.

Signed-off-by: Barry Song <barry.song@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/blackfin/Kconfig |   98 ++++++++++++++++++++++----------------------
 1 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/sound/soc/blackfin/Kconfig b/sound/soc/blackfin/Kconfig
index ac927ff..f91dcb1 100644
--- a/sound/soc/blackfin/Kconfig
+++ b/sound/soc/blackfin/Kconfig
@@ -7,15 +7,6 @@ config SND_BF5XX_I2S
 	  mode (supports single stereo In/Out).
 	  You will also need to select the audio interfaces to support below.
 
-config SND_BF5XX_TDM
-	tristate "SoC I2S(TDM mode) Audio for the ADI BF5xx chip"
-	depends on (BLACKFIN && SND_SOC)
-	help
-	  Say Y or M if you want to add support for codecs attached to
-	  the Blackfin SPORT (synchronous serial ports) interface in TDM
-	  mode.
-	  You will also need to select the audio interfaces to support below.
-
 config SND_BF5XX_SOC_SSM2602
 	tristate "SoC SSM2602 Audio support for BF52x ezkit"
 	depends on SND_BF5XX_I2S
@@ -41,6 +32,31 @@ config SND_BFIN_AD73311_SE
 	  Enter the GPIO used to control AD73311's SE pin. Acceptable
 	  values are 0 to 7
 
+config SND_BF5XX_TDM
+	tristate "SoC I2S(TDM mode) Audio for the ADI BF5xx chip"
+	depends on (BLACKFIN && SND_SOC)
+	help
+	  Say Y or M if you want to add support for codecs attached to
+	  the Blackfin SPORT (synchronous serial ports) interface in TDM
+	  mode.
+	  You will also need to select the audio interfaces to support below.
+
+config SND_BF5XX_SOC_AD1836
+	tristate "SoC AD1836 Audio support for BF5xx"
+	depends on SND_BF5XX_TDM
+	select SND_BF5XX_SOC_TDM
+	select SND_SOC_AD1836
+	help
+	  Say Y if you want to add support for SoC audio on BF5xx STAMP/EZKIT.
+
+config SND_BF5XX_SOC_AD1938
+	tristate "SoC AD1938 Audio support for Blackfin"
+	depends on SND_BF5XX_TDM
+	select SND_BF5XX_SOC_TDM
+	select SND_SOC_AD1938
+	help
+	  Say Y if you want to add support for AD1938 codec on Blackfin.
+
 config SND_BF5XX_AC97
 	tristate "SoC AC97 Audio for the ADI BF5xx chip"
 	depends on BLACKFIN
@@ -71,6 +87,30 @@ config SND_BF5XX_MULTICHAN_SUPPORT
 	  Say y if you want AC97 driver to support up to 5.1 channel audio.
 	  this mode will consume much more memory for DMA.
 
+config SND_BF5XX_HAVE_COLD_RESET
+	bool "BOARD has COLD Reset GPIO"
+	depends on SND_BF5XX_AC97
+	default y if BFIN548_EZKIT
+	default n if !BFIN548_EZKIT
+
+config SND_BF5XX_RESET_GPIO_NUM
+	int "Set a GPIO for cold reset"
+	depends on SND_BF5XX_HAVE_COLD_RESET
+	range 0 159
+	default 19 if BFIN548_EZKIT
+	default 5 if BFIN537_STAMP
+	default 0
+	help
+	  Set the correct GPIO for RESET the sound chip.
+
+config SND_BF5XX_SOC_AD1980
+	tristate "SoC AD1980/1 Audio support for BF5xx"
+	depends on SND_BF5XX_AC97
+	select SND_BF5XX_SOC_AC97
+	select SND_SOC_AD1980
+	help
+	  Say Y if you want to add support for SoC audio on BF5xx STAMP/EZKIT.
+
 config SND_BF5XX_SOC_SPORT
 	tristate
 
@@ -88,30 +128,6 @@ config SND_BF5XX_SOC_AC97
 	select SND_SOC_AC97_BUS
 	select SND_BF5XX_SOC_SPORT
 
-config SND_BF5XX_SOC_AD1836
-	tristate "SoC AD1836 Audio support for BF5xx"
-	depends on SND_BF5XX_TDM
-	select SND_BF5XX_SOC_TDM
-	select SND_SOC_AD1836
-	help
-	  Say Y if you want to add support for SoC audio on BF5xx STAMP/EZKIT.
-
-config SND_BF5XX_SOC_AD1980
-	tristate "SoC AD1980/1 Audio support for BF5xx"
-	depends on SND_BF5XX_AC97
-	select SND_BF5XX_SOC_AC97
-	select SND_SOC_AD1980
-	help
-	  Say Y if you want to add support for SoC audio on BF5xx STAMP/EZKIT.
-
-config SND_BF5XX_SOC_AD1938
-        tristate "SoC AD1938 Audio support for Blackfin"
-        depends on SND_BF5XX_TDM
-        select SND_BF5XX_SOC_TDM
-        select SND_SOC_AD1938
-        help
-          Say Y if you want to add support for AD1938 codec on Blackfin.
-
 config SND_BF5XX_SPORT_NUM
 	int "Set a SPORT for Sound chip"
 	depends on (SND_BF5XX_I2S || SND_BF5XX_AC97 || SND_BF5XX_TDM)
@@ -120,19 +136,3 @@ config SND_BF5XX_SPORT_NUM
 	default 0
 	help
 	  Set the correct SPORT for sound chip.
-
-config SND_BF5XX_HAVE_COLD_RESET
-	bool "BOARD has COLD Reset GPIO"
-	depends on SND_BF5XX_AC97
-	default y if BFIN548_EZKIT
-	default n if !BFIN548_EZKIT
-
-config SND_BF5XX_RESET_GPIO_NUM
-	int "Set a GPIO for cold reset"
-	depends on SND_BF5XX_HAVE_COLD_RESET
-	range 0 159
-	default 19 if BFIN548_EZKIT
-	default 5 if BFIN537_STAMP
-	default 0
-	help
-	  Set the correct GPIO for RESET the sound chip.
-- 
1.6.5.rc2
