From: Alin Grigorean <alin.grig93@gmail.com>
Subject: [PATCH] ASoC: fsl: Remove unneeded init of static variable
Date: Sat, 25 Feb 2017 12:47:26 +0200
Message-ID: <20170225104726.15936-1-alin.grig93@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: timur@tabi.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, perex@perex.cz, tiwai@suse.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, fabio.estevam@nxp.com, lgirdwood@gmail.com, broonie@kernel.org, Alin Grigorean <alin.grig93@gmail.com>
List-Id: alsa-devel@alsa-project.org

This was reported by checkpatch.pl

Signed-off-by: Alin Grigorean <alin.grig93@gmail.com>
---
 sound/soc/fsl/imx-pcm-fiq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index dac6688540dc..92410f7ca1fa 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -282,7 +282,7 @@ static int imx_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static int ssi_irq = 0;
+static int ssi_irq;
 
 static int imx_pcm_fiq_new(struct snd_soc_pcm_runtime *rtd)
 {
-- 
2.11.1
