From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl: fix build failure" to the asoc tree
Date: Fri, 03 Jun 2016 00:47:12 +0100
Message-ID: <E1b8cKW-00028q-4g@finisterre>
References: <1464872364-3232-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464872364-3232-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl: fix build failure

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

>From 121a01521b1ef7440ea285aa3aae02bf005e5635 Mon Sep 17 00:00:00 2001
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Thu, 2 Jun 2016 18:29:24 +0530
Subject: [PATCH] ASoC: fsl: fix build failure

m32r allmodconfig build is failing with the error:
ERROR: "bad_dma_ops" [sound/soc/fsl/snd-soc-fsl-asrc.ko] undefined!

The code is using DMA but the related dependency is not mentioned in the
Kconfig.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 35aabf9dc503..19bdcac71775 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -4,6 +4,7 @@ comment "Common SoC Audio options for Freescale CPUs:"
 
 config SND_SOC_FSL_ASRC
 	tristate "Asynchronous Sample Rate Converter (ASRC) module support"
+	depends on HAS_DMA
 	select REGMAP_MMIO
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
-- 
2.8.1
