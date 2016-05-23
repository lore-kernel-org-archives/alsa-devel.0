From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] ASoC: kirkwood: fix build failure
Date: Mon, 23 May 2016 16:00:54 +0530
Message-ID: <1463999454-21964-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
List-Id: alsa-devel@alsa-project.org

From: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

While building m32r allmodconfig the build failed with:
ERROR: "bad_dma_ops" [sound/soc/kirkwood/snd-soc-kirkwood.ko] undefined!

To satisfy the dependency CONFIG_SND_KIRKWOOD_SOC should depend on
HAS_DMA.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---

build log at:
https://travis-ci.org/sudipm-mukherjee/parport/jobs/132180911

 sound/soc/kirkwood/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/kirkwood/Kconfig b/sound/soc/kirkwood/Kconfig
index 132bb83..bc3c7b5 100644
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
1.9.1
