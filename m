From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: pxa: add I2C dependencies as needed
Date: Tue, 03 Jun 2014 20:38:27 +0200
Message-ID: <46560700.2S4p0nUZl8@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 5976C26168D
 for <alsa-devel@alsa-project.org>; Tue,  3 Jun 2014 20:38:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

We have in the past added 'depends on I2C' for some of the PXA boards
after hitting randconfig build bugs. I have seens a couple of new
bugs in this area during the linux-next cycle for 3.16, after it
became possible to build some more PXA machines with I2C disabled.

To shut this up for good, this adds the dependency to every board
that uses I2C as the interface to the codec. I have gone through
all board files and verified that they all either use AC97 or
I2C, and this annotates the latter. Some of these already enable
I2C from mach-pxa/Kconfig, but since that can change it's better
to be explicit here.

The link error that can result otherwise happens when CONFIG_I2C
is set to 'm' and the codec driver is built-in as a result of being
selected by the platform specific glue.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index dcf0c08..e195b038 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -40,7 +40,7 @@ config SND_MMP_SOC_SSPA
 
 config SND_PXA2XX_SOC_CORGI
 	tristate "SoC Audio support for Sharp Zaurus SL-C7x0"
-	depends on SND_PXA2XX_SOC && PXA_SHARP_C7xx
+	depends on SND_PXA2XX_SOC && PXA_SHARP_C7xx && I2C
 	select SND_PXA2XX_SOC_I2S
 	select SND_SOC_WM8731
 	help
@@ -49,7 +49,7 @@ config SND_PXA2XX_SOC_CORGI
 
 config SND_PXA2XX_SOC_SPITZ
 	tristate "SoC Audio support for Sharp Zaurus SL-Cxx00"
-	depends on SND_PXA2XX_SOC && PXA_SHARP_Cxx00
+	depends on SND_PXA2XX_SOC && PXA_SHARP_Cxx00 && I2C
 	select SND_PXA2XX_SOC_I2S
 	select SND_SOC_WM8750
 	help
@@ -58,7 +58,7 @@ config SND_PXA2XX_SOC_SPITZ
 
 config SND_PXA2XX_SOC_Z2
 	tristate "SoC Audio support for Zipit Z2"
-	depends on SND_PXA2XX_SOC && MACH_ZIPIT2
+	depends on SND_PXA2XX_SOC && MACH_ZIPIT2 && I2C
 	select SND_PXA2XX_SOC_I2S
 	select SND_SOC_WM8750
 	help
@@ -66,7 +66,7 @@ config SND_PXA2XX_SOC_Z2
 
 config SND_PXA2XX_SOC_POODLE
 	tristate "SoC Audio support for Poodle"
-	depends on SND_PXA2XX_SOC && MACH_POODLE
+	depends on SND_PXA2XX_SOC && MACH_POODLE && I2C
 	select SND_PXA2XX_SOC_I2S
 	select SND_SOC_WM8731
 	help
@@ -181,7 +181,7 @@ config SND_PXA2XX_SOC_HX4700
 
 config SND_PXA2XX_SOC_MAGICIAN
 	tristate "SoC Audio support for HTC Magician"
-	depends on SND_PXA2XX_SOC && MACH_MAGICIAN
+	depends on SND_PXA2XX_SOC && MACH_MAGICIAN && I2C
 	select SND_PXA2XX_SOC_I2S
 	select SND_PXA_SOC_SSP
 	select SND_SOC_UDA1380
