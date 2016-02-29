From: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] ASoC: qcom: add dependency on HAS_DMA
Date: Mon, 29 Feb 2016 19:55:39 +0530
Message-ID: <1456755939-7848-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Patrick Lai <plai-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Banajit Goswami <bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

m32r allmodconfig build is failing with the error:
ERROR: "bad_dma_ops" [sound/soc/qcom/snd-soc-lpass-platform.ko] undefined!
ERROR: "dma_common_mmap" [sound/soc/qcom/snd-soc-lpass-platform.ko] undefined!

lpass-platform uses DMA so add HAS_DMA in the Kconfig. Also add the same
for SND_SOC_LPASS_IPQ806X and SND_SOC_LPASS_APQ8016 as they will also
select SND_SOC_LPASS_PLATFORM.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
---

m32r allmodconfig build for next-20160229 is at:
https://travis-ci.org/sudipm-mukherjee/parport/jobs/112534168

 sound/soc/qcom/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 3cc252e..1e7a783 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -11,15 +11,18 @@ config SND_SOC_LPASS_CPU
 
 config SND_SOC_LPASS_PLATFORM
 	tristate
+	depends on HAS_DMA
 	select REGMAP_MMIO
 
 config SND_SOC_LPASS_IPQ806X
 	tristate
+	depends on HAS_DMA
 	select SND_SOC_LPASS_CPU
 	select SND_SOC_LPASS_PLATFORM
 
 config SND_SOC_LPASS_APQ8016
 	tristate
+	depends on HAS_DMA
 	select SND_SOC_LPASS_CPU
 	select SND_SOC_LPASS_PLATFORM
 
-- 
1.9.1
