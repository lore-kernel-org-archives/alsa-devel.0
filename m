From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ti: fix davinci_mcasp_probe dependencies" to the asoc tree
Date: Mon, 11 Mar 2019 17:23:37 +0000 (GMT)
Message-ID: <20190311172337.CDA331128896@debutante.sirena.org.uk>
References: <20190304203114.1894822-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190304203114.1894822-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>Peter Ujfalusi <peter.ujfalusi@ti.com>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ti: fix davinci_mcasp_probe dependencies

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

>From 7d7b25d05ef1c5a1a9320190e1eeb55534847558 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 4 Mar 2019 21:30:50 +0100
Subject: [PATCH] ASoC: ti: fix davinci_mcasp_probe dependencies

The SND_SOC_DAVINCI_MCASP driver can use either edma or sdma as
a back-end, and it takes the presence of the respective dma engine
drivers in the configuration as an indication to which ones should be
built. However, this is flawed in multiple ways:

- With CONFIG_TI_EDMA=m and CONFIG_SND_SOC_DAVINCI_MCASP=y,
  is enabled as =m, and we get a link error:
  sound/soc/ti/davinci-mcasp.o: In function `davinci_mcasp_probe':
  davinci-mcasp.c:(.text+0x930): undefined reference to `edma_pcm_platform_register'

- When CONFIG_SND_SOC_DAVINCI_MCASP=m has already been selected by
  another driver, the same link error appears even if CONFIG_TI_EDMA
  is disabled

There are possibly other issues here, but it seems that the only reasonable
solution is to always build both SND_SOC_TI_EDMA_PCM and
SND_SOC_TI_SDMA_PCM as a dependency here. Both are fairly small and
do not have any other compile-time dependencies, so the cost is
very small, and makes the configuration stage much more consistent.

Fixes: f2055e145f29 ("ASoC: ti: Merge davinci and omap directories")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ti/Kconfig b/sound/soc/ti/Kconfig
index 4bf3c15d4e51..ee7c202c69b7 100644
--- a/sound/soc/ti/Kconfig
+++ b/sound/soc/ti/Kconfig
@@ -21,8 +21,8 @@ config SND_SOC_DAVINCI_ASP
 
 config SND_SOC_DAVINCI_MCASP
 	tristate "Multichannel Audio Serial Port (McASP) support"
-	select SND_SOC_TI_EDMA_PCM if TI_EDMA
-	select SND_SOC_TI_SDMA_PCM if DMA_OMAP
+	select SND_SOC_TI_EDMA_PCM
+	select SND_SOC_TI_SDMA_PCM
 	help
 	  Say Y or M here if you want to have support for McASP IP found in
 	  various Texas Instruments SoCs like:
-- 
2.20.1
