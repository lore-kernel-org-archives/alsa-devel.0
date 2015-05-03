From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: samsung: wolfson: Improve compile test
	coverage
Date: Sun,  3 May 2015 20:13:35 +0200
Message-ID: <1430676815-10450-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-155.synserver.de (smtp-out-155.synserver.de
 [212.40.185.155])
 by alsa0.perex.cz (Postfix) with ESMTP id 6080D26049D
 for <alsa-devel@alsa-project.org>; Sun,  3 May 2015 20:13:47 +0200 (CEST)
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

While the the Wolfson machine drivers have a runtime dependency on a
specific machine there is no compile time dependency. Allow to lets those
drivers to be selected when COMPILE_TEST is selected to improve the compile
time test coverage.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/samsung/Kconfig | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 0632a36..3744c9e 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -174,7 +174,8 @@ config SND_SOC_SMDK_WM8994_PCM
 
 config SND_SOC_SPEYSIDE
 	tristate "Audio support for Wolfson Speyside"
-	depends on SND_SOC_SAMSUNG && MACH_WLF_CRAGG_6410 && I2C && SPI_MASTER
+	depends on SND_SOC_SAMSUNG && I2C && SPI_MASTER
+	depends on MACH_WLF_CRAGG_6410 || COMPILE_TEST
 	select SND_SAMSUNG_I2S
 	select SND_SOC_WM8996
 	select SND_SOC_WM9081
@@ -183,13 +184,15 @@ config SND_SOC_SPEYSIDE
 
 config SND_SOC_TOBERMORY
 	tristate "Audio support for Wolfson Tobermory"
-	depends on SND_SOC_SAMSUNG && MACH_WLF_CRAGG_6410 && INPUT && I2C
+	depends on SND_SOC_SAMSUNG && INPUT && I2C
+	depends on MACH_WLF_CRAGG_6410 || COMPILE_TEST
 	select SND_SAMSUNG_I2S
 	select SND_SOC_WM8962
 
 config SND_SOC_BELLS
 	tristate "Audio support for Wolfson Bells"
-	depends on SND_SOC_SAMSUNG && MACH_WLF_CRAGG_6410 && MFD_ARIZONA && I2C && SPI_MASTER
+	depends on SND_SOC_SAMSUNG && MFD_ARIZONA && I2C && SPI_MASTER
+	depends on MACH_WLF_CRAGG_6410 || COMPILE_TEST
 	select SND_SAMSUNG_I2S
 	select SND_SOC_WM5102
 	select SND_SOC_WM5110
@@ -199,14 +202,16 @@ config SND_SOC_BELLS
 
 config SND_SOC_LOWLAND
 	tristate "Audio support for Wolfson Lowland"
-	depends on SND_SOC_SAMSUNG && MACH_WLF_CRAGG_6410 && I2C
+	depends on SND_SOC_SAMSUNG && I2C
+	depends on MACH_WLF_CRAGG_6410 || COMPILE_TEST
 	select SND_SAMSUNG_I2S
 	select SND_SOC_WM5100
 	select SND_SOC_WM9081
 
 config SND_SOC_LITTLEMILL
 	tristate "Audio support for Wolfson Littlemill"
-	depends on SND_SOC_SAMSUNG && MACH_WLF_CRAGG_6410 && I2C
+	depends on SND_SOC_SAMSUNG && I2C
+	depends on MACH_WLF_CRAGG_6410 || COMPILE_TEST
 	select SND_SAMSUNG_I2S
 	select MFD_WM8994
 	select SND_SOC_WM8994
-- 
1.8.0
