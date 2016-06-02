From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] ASoC: fsl: fix build failure
Date: Thu,  2 Jun 2016 18:29:24 +0530
Message-ID: <1464872364-3232-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

m32r allmodconfig build is failing with the error:
ERROR: "bad_dma_ops" [sound/soc/fsl/snd-soc-fsl-asrc.ko] undefined!

The code is using DMA but the related dependency is not mentioned in the
Kconfig.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---

build log is at:
https://travis-ci.org/sudipm-mukherjee/parport/jobs/134651165

 sound/soc/fsl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 35aabf9..19bdcac 100644
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
1.9.1
