From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: davinci: Kconfig: Update the edma-pcm
	section's dependency and help" to the asoc tree
Date: Sun, 13 Mar 2016 15:15:11 +0700
Message-ID: <E1af1B9-0004LH-Vp@finisterre>
References: <1457705060-7504-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BE7E826051B
 for <alsa-devel@alsa-project.org>; Sun, 13 Mar 2016 09:15:19 +0100 (CET)
In-Reply-To: <1457705060-7504-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: davinci: Kconfig: Update the edma-pcm section's dependency and help

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

>From dc6cdb420359103e1f20752d01cb1e2bbe8ba8b8 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Fri, 11 Mar 2016 16:04:20 +0200
Subject: [PATCH] ASoC: davinci: Kconfig: Update the edma-pcm section's
 dependency and help

Instead of depending on individual SoCs make the edma-pcm depend on the eDMA
dmaengine driver (TI_EDMA).
Update the help text and add DRA7xx family since they have eDMA integrated
as well along with sDMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/davinci/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index 3736d9aabc56..50ca291cc225 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -5,7 +5,7 @@ config SND_DAVINCI_SOC
 
 config SND_EDMA_SOC
 	tristate "SoC Audio for Texas Instruments chips using eDMA"
-	depends on SOC_AM33XX || SOC_AM43XX || ARCH_DAVINCI
+	depends on TI_EDMA
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y or M here if you want audio support for TI SoC which uses eDMA.
@@ -13,6 +13,7 @@ config SND_EDMA_SOC
 	  - daVinci devices
 	  - AM335x
 	  - AM437x/AM438x
+	  - DRA7xx family
 
 config SND_DAVINCI_SOC_I2S
 	tristate
-- 
2.7.0
