From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: kirkwood: fix build failure" to the asoc tree
Date: Mon, 23 May 2016 18:50:23 +0100
Message-ID: <E1b4tzj-0006bK-Lh@debutante>
References: <1463999454-21964-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463999454-21964-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: kirkwood: fix build failure

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

>From b01518ca88410195ace38ce755c1206588e5c167 Mon Sep 17 00:00:00 2001
From: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Date: Mon, 23 May 2016 16:00:54 +0530
Subject: [PATCH] ASoC: kirkwood: fix build failure

While building m32r allmodconfig the build failed with:
ERROR: "bad_dma_ops" [sound/soc/kirkwood/snd-soc-kirkwood.ko] undefined!

To satisfy the dependency CONFIG_SND_KIRKWOOD_SOC should depend on
HAS_DMA.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/kirkwood/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/kirkwood/Kconfig b/sound/soc/kirkwood/Kconfig
index 132bb83f8e99..bc3c7b5ac752 100644
--- a/sound/soc/kirkwood/Kconfig
+++ b/sound/soc/kirkwood/Kconfig
@@ -1,6 +1,7 @@
 config SND_KIRKWOOD_SOC
 	tristate "SoC Audio for the Marvell Kirkwood and Dove chips"
 	depends on ARCH_DOVE || ARCH_MVEBU || COMPILE_TEST
+	depends on HAS_DMA
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the Kirkwood I2S interface. You will also need to select the
-- 
2.8.1
