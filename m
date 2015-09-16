From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fix broken pxa SoC support" to the asoc
	tree
Date: Wed, 16 Sep 2015 21:01:42 +0100
Message-ID: <E1ZcIti-0007qV-AC@finisterre>
References: <1442343091-2295-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 39BCB261A5A
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2015 22:01:49 +0200 (CEST)
In-Reply-To: <1442343091-2295-1-git-send-email-robert.jarzmik@free.fr>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fix broken pxa SoC support

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

>From 3c8f7710c1c44fb650bc29b6ef78ed8b60cfaa28 Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Tue, 15 Sep 2015 20:51:31 +0200
Subject: [PATCH] ASoC: fix broken pxa SoC support

The previous fix of pxa library support, which was introduced to fix the
library dependency, broke the previous SoC behavior, where a machine
code binding pxa2xx-ac97 with a coded relied on :
 - sound/soc/pxa/pxa2xx-ac97.c
 - sound/soc/codecs/XXX.c

For example, the mioa701_wm9713.c machine code is currently broken. The
"select ARM" statement wrongly selects the soc/arm/pxa2xx-ac97 for
compilation, as per an unfortunate fate SND_PXA2XX_AC97 is both declared
in sound/arm/Kconfig and sound/soc/pxa/Kconfig.

Fix this by ensuring that SND_PXA2XX_SOC correctly triggers the correct
pxa2xx-ac97 compilation.

Fixes: 846172dfe33c ("ASoC: fix SND_PXA2XX_LIB Kconfig warning")
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/arm/Kconfig     | 15 ++++++++-------
 sound/soc/pxa/Kconfig |  2 --
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/sound/arm/Kconfig b/sound/arm/Kconfig
index 885683a..e040621 100644
--- a/sound/arm/Kconfig
+++ b/sound/arm/Kconfig
@@ -9,6 +9,14 @@ menuconfig SND_ARM
 	  Drivers that are implemented on ASoC can be found in
 	  "ALSA for SoC audio support" section.
 
+config SND_PXA2XX_LIB
+	tristate
+	select SND_AC97_CODEC if SND_PXA2XX_LIB_AC97
+	select SND_DMAENGINE_PCM
+
+config SND_PXA2XX_LIB_AC97
+	bool
+
 if SND_ARM
 
 config SND_ARMAACI
@@ -21,13 +29,6 @@ config SND_PXA2XX_PCM
 	tristate
 	select SND_PCM
 
-config SND_PXA2XX_LIB
-	tristate
-	select SND_AC97_CODEC if SND_PXA2XX_LIB_AC97
-
-config SND_PXA2XX_LIB_AC97
-	bool
-
 config SND_PXA2XX_AC97
 	tristate "AC97 driver for the Intel PXA2xx chip"
 	depends on ARCH_PXA
diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 39cea80..f2bf866 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -1,7 +1,6 @@
 config SND_PXA2XX_SOC
 	tristate "SoC Audio for the Intel PXA2xx chip"
 	depends on ARCH_PXA
-	select SND_ARM
 	select SND_PXA2XX_LIB
 	help
 	  Say Y or M if you want to add support for codecs attached to
@@ -25,7 +24,6 @@ config SND_PXA2XX_AC97
 config SND_PXA2XX_SOC_AC97
 	tristate
 	select AC97_BUS
-	select SND_ARM
 	select SND_PXA2XX_LIB_AC97
 	select SND_SOC_AC97_BUS
 
-- 
2.5.0
