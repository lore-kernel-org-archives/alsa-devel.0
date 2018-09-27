From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa: avoid AC97_BUS build warning" to
	the asoc tree
Date: Thu, 27 Sep 2018 23:39:48 +0100 (BST)
Message-ID: <20180927223948.526C8440078@finisterre.ee.mobilebroadband>
References: <20180926124645.1841850-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 959522678CD
 for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2018 00:39:50 +0200 (CEST)
In-Reply-To: <20180926124645.1841850-1-arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pxa: avoid AC97_BUS build warning

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From bec5ecdf41d404691980c9c82ba867113cc8dee5 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 26 Sep 2018 14:46:35 +0200
Subject: [PATCH] ASoC: pxa: avoid AC97_BUS build warning

Selecting AC97_BUS_NEW from SND_PXA2XX_SOC_AC97 leads to a Kconfig
warning if any other driver selects AC97_BUS:

WARNING: unmet direct dependencies detected for AC97_BUS_COMPAT
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && AC97_BUS_NEW [=y] && !AC97_BUS [=y]
  Selected by [y]:
  - SND_SOC_WM9713 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && AC97_BUS_NEW [=y]

I don't know if that combination is supposed to work.
Assuming it is not, this adds a dependency on all users
for PXA to avoids the combination.

Fixes: 1c8bc7b3de5e ("ASoC: pxa: switch to new ac97 bus support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 29f577e6dfc0..943b44de1464 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -79,6 +79,7 @@ config SND_PXA2XX_SOC_TOSA
 	tristate "SoC AC97 Audio support for Tosa"
 	depends on SND_PXA2XX_SOC && MACH_TOSA
 	depends on MFD_TC6393XB
+	depends on !AC97_BUS
 	select SND_PXA2XX_SOC_AC97
 	select SND_SOC_WM9712
 	help
@@ -88,6 +89,7 @@ config SND_PXA2XX_SOC_TOSA
 config SND_PXA2XX_SOC_E740
 	tristate "SoC AC97 Audio support for e740"
 	depends on SND_PXA2XX_SOC && MACH_E740
+	depends on !AC97_BUS
 	select SND_SOC_WM9705
 	select SND_PXA2XX_SOC_AC97
 	help
@@ -97,6 +99,7 @@ config SND_PXA2XX_SOC_E740
 config SND_PXA2XX_SOC_E750
 	tristate "SoC AC97 Audio support for e750"
 	depends on SND_PXA2XX_SOC && MACH_E750
+	depends on !AC97_BUS
 	select SND_SOC_WM9705
 	select SND_PXA2XX_SOC_AC97
 	help
@@ -106,6 +109,7 @@ config SND_PXA2XX_SOC_E750
 config SND_PXA2XX_SOC_E800
 	tristate "SoC AC97 Audio support for e800"
 	depends on SND_PXA2XX_SOC && MACH_E800
+	depends on !AC97_BUS
 	select SND_SOC_WM9712
 	select SND_PXA2XX_SOC_AC97
 	help
@@ -116,6 +120,7 @@ config SND_PXA2XX_SOC_EM_X270
 	tristate "SoC Audio support for CompuLab EM-x270, eXeda and CM-X300"
 	depends on SND_PXA2XX_SOC && (MACH_EM_X270 || MACH_EXEDA || \
 			MACH_CM_X300)
+	depends on !AC97_BUS
 	select SND_PXA2XX_SOC_AC97
 	select SND_SOC_WM9712
 	help
@@ -126,6 +131,7 @@ config SND_PXA2XX_SOC_PALM27X
 	bool "SoC Audio support for Palm T|X, T5, E2 and LifeDrive"
 	depends on SND_PXA2XX_SOC && (MACH_PALMLD || MACH_PALMTX || \
 			MACH_PALMT5 || MACH_PALMTE2)
+	depends on !AC97_BUS
 	select SND_PXA2XX_SOC_AC97
 	select SND_SOC_WM9712
 	help
@@ -155,6 +161,7 @@ config SND_SOC_TTC_DKB
 config SND_SOC_ZYLONITE
 	tristate "SoC Audio support for Marvell Zylonite"
 	depends on SND_PXA2XX_SOC && MACH_ZYLONITE
+	depends on !AC97_BUS
 	select SND_PXA2XX_SOC_AC97
 	select SND_PXA_SOC_SSP
 	select SND_SOC_WM9713
@@ -194,6 +201,7 @@ config SND_PXA2XX_SOC_MAGICIAN
 config SND_PXA2XX_SOC_MIOA701
         tristate "SoC Audio support for MIO A701"
         depends on SND_PXA2XX_SOC && MACH_MIOA701
+	depends on !AC97_BUS
         select SND_PXA2XX_SOC_AC97
         select SND_SOC_WM9713
         help
-- 
2.19.0
