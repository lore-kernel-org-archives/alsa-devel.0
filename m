From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] ASoC: atmel: fix build failure
Date: Sun,  5 Jun 2016 19:00:21 +0100
Message-ID: <1465149621-4493-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

m32r allmodconfig build is failing with the error:
ERROR: "bad_dma_ops" [sound/soc/atmel/snd-soc-atmel-pcm-pdc.ko] undefined!

The code is using DMA but the related dependency is not mentioned in the
Kconfig.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---

build log is at:
https://travis-ci.org/sudipm-mukherjee/parport/jobs/134651165

 sound/soc/atmel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index 06e099e..22aec9a 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -10,6 +10,7 @@ if SND_ATMEL_SOC
 
 config SND_ATMEL_SOC_PDC
 	tristate
+	depends on HAS_DMA
 	default m if SND_ATMEL_SOC_SSC_PDC=m && SND_ATMEL_SOC_SSC=m
 	default y if SND_ATMEL_SOC_SSC_PDC=y || (SND_ATMEL_SOC_SSC_PDC=m && SND_ATMEL_SOC_SSC=y)
 
-- 
1.9.1
