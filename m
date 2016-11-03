From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: bcm: add depends on HAS_DMA" to the asoc tree
Date: Thu, 03 Nov 2016 09:42:35 -0600
Message-ID: <E1c2K9z-00006D-3m@finisterre>
References: <1475868258-10689-1-git-send-email-scott.branden@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1475868258-10689-1-git-send-email-scott.branden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Scott Branden <scott.branden@broadcom.com>
Cc: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: bcm: add depends on HAS_DMA

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

>From fe3683779e0b20edf91c549bbff0d81785e1c7a0 Mon Sep 17 00:00:00 2001
From: Scott Branden <scott.branden@broadcom.com>
Date: Wed, 2 Nov 2016 13:43:24 -0700
Subject: [PATCH] ASoC: bcm: add depends on HAS_DMA

add depends on HAS_DMA to Kconfig.  This fixes error reported
by kbuild test robot when building for ARCH=m32r:
ERROR: "bad_dma_ops" [sound/soc/bcm/snd-soc-cygnus.ko] undefined!

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/bcm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/bcm/Kconfig b/sound/soc/bcm/Kconfig
index d528aaceaad9..edf367100ebd 100644
--- a/sound/soc/bcm/Kconfig
+++ b/sound/soc/bcm/Kconfig
@@ -11,6 +11,7 @@ config SND_BCM2835_SOC_I2S
 config SND_SOC_CYGNUS
 	tristate "SoC platform audio for Broadcom Cygnus chips"
 	depends on ARCH_BCM_CYGNUS || COMPILE_TEST
+	depends on HAS_DMA
 	help
 	  Say Y if you want to add support for ASoC audio on Broadcom
 	  Cygnus chips (bcm958300, bcm958305, bcm911360)
-- 
2.10.1
