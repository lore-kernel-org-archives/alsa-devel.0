From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: pxa: change ac97 dependencies
Date: Fri,  2 Nov 2018 12:20:39 +0100
Message-ID: <20181102112055.659197-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by alsa0.perex.cz (Postfix) with ESMTP id 73F8A2675BA
 for <alsa-devel@alsa-project.org>; Fri,  2 Nov 2018 12:21:07 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-arm-kernel@lists.infradead.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Enabling both the old AC97_BUS code and the new AC97_BUS_COMPAT causes
problems because both modules provide an exported snd_ac97_reset()
function.

I had tried to fix the problem of having both coexist earlier, but
my patch only prevented them from being built-in. This is because
of a special Kconfig feature that lets a symbol have a dependency
on another one being disabled, but still allow both to be loadable
modules.

Changing the dependency to =n avoids that problem, now we can only
build the new driver if the old one is completely disabled.

If we could figure out a way to let rename one of the reset
functions and have each driver link to exactly the old or
the compat code, that would also work, but I could not find if
that's possible.

Fixes: bec5ecdf41d4 ("ASoC: pxa: avoid AC97_BUS build warning")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/pxa/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 943b44de1464..6075fc32e6b9 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -79,7 +79,7 @@ config SND_PXA2XX_SOC_TOSA
 	tristate "SoC AC97 Audio support for Tosa"
 	depends on SND_PXA2XX_SOC && MACH_TOSA
 	depends on MFD_TC6393XB
-	depends on !AC97_BUS
+	depends on AC97_BUS=n
 	select SND_PXA2XX_SOC_AC97
 	select SND_SOC_WM9712
 	help
@@ -89,7 +89,7 @@ config SND_PXA2XX_SOC_TOSA
 config SND_PXA2XX_SOC_E740
 	tristate "SoC AC97 Audio support for e740"
 	depends on SND_PXA2XX_SOC && MACH_E740
-	depends on !AC97_BUS
+	depends on AC97_BUS=n
 	select SND_SOC_WM9705
 	select SND_PXA2XX_SOC_AC97
 	help
@@ -99,7 +99,7 @@ config SND_PXA2XX_SOC_E740
 config SND_PXA2XX_SOC_E750
 	tristate "SoC AC97 Audio support for e750"
 	depends on SND_PXA2XX_SOC && MACH_E750
-	depends on !AC97_BUS
+	depends on AC97_BUS=n
 	select SND_SOC_WM9705
 	select SND_PXA2XX_SOC_AC97
 	help
@@ -109,7 +109,7 @@ config SND_PXA2XX_SOC_E750
 config SND_PXA2XX_SOC_E800
 	tristate "SoC AC97 Audio support for e800"
 	depends on SND_PXA2XX_SOC && MACH_E800
-	depends on !AC97_BUS
+	depends on AC97_BUS=n
 	select SND_SOC_WM9712
 	select SND_PXA2XX_SOC_AC97
 	help
@@ -120,7 +120,7 @@ config SND_PXA2XX_SOC_EM_X270
 	tristate "SoC Audio support for CompuLab EM-x270, eXeda and CM-X300"
 	depends on SND_PXA2XX_SOC && (MACH_EM_X270 || MACH_EXEDA || \
 			MACH_CM_X300)
-	depends on !AC97_BUS
+	depends on AC97_BUS=n
 	select SND_PXA2XX_SOC_AC97
 	select SND_SOC_WM9712
 	help
@@ -131,7 +131,7 @@ config SND_PXA2XX_SOC_PALM27X
 	bool "SoC Audio support for Palm T|X, T5, E2 and LifeDrive"
 	depends on SND_PXA2XX_SOC && (MACH_PALMLD || MACH_PALMTX || \
 			MACH_PALMT5 || MACH_PALMTE2)
-	depends on !AC97_BUS
+	depends on AC97_BUS=n
 	select SND_PXA2XX_SOC_AC97
 	select SND_SOC_WM9712
 	help
@@ -161,7 +161,7 @@ config SND_SOC_TTC_DKB
 config SND_SOC_ZYLONITE
 	tristate "SoC Audio support for Marvell Zylonite"
 	depends on SND_PXA2XX_SOC && MACH_ZYLONITE
-	depends on !AC97_BUS
+	depends on AC97_BUS=n
 	select SND_PXA2XX_SOC_AC97
 	select SND_PXA_SOC_SSP
 	select SND_SOC_WM9713
@@ -201,7 +201,7 @@ config SND_PXA2XX_SOC_MAGICIAN
 config SND_PXA2XX_SOC_MIOA701
         tristate "SoC Audio support for MIO A701"
         depends on SND_PXA2XX_SOC && MACH_MIOA701
-	depends on !AC97_BUS
+	depends on AC97_BUS=n
         select SND_PXA2XX_SOC_AC97
         select SND_SOC_WM9713
         help
-- 
2.18.0
