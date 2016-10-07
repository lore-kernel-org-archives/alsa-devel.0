From: Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH] sound: soc: cygnus: add depends on HAS_DMA
Date: Fri,  7 Oct 2016 12:24:18 -0700
Message-ID: <1475868258-10689-1-git-send-email-scott.branden@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Scott Branden <scott.branden@broadcom.com>
List-Id: alsa-devel@alsa-project.org

add depends on HAS_DMA to Kconfig.  This fixes error reported
by kbuild test robot when building for ARCH=m32r:
ERROR: "bad_dma_ops" [sound/soc/bcm/snd-soc-cygnus.ko] undefined!

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 sound/soc/bcm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/bcm/Kconfig b/sound/soc/bcm/Kconfig
index d528aac..edf3671 100644
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
2.5.0
