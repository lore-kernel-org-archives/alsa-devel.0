From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl: imx-pcm-fiq: Remove unneeded 'out'
	label
Date: Mon, 24 Feb 2014 00:20:43 -0300
Message-ID: <1393212043-9002-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f53.google.com (mail-yh0-f53.google.com
 [209.85.213.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FE182651EB
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 04:21:00 +0100 (CET)
Received: by mail-yh0-f53.google.com with SMTP id v1so4659999yhn.40
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 19:20:59 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Instead of jumping to the 'out' label, just return the error code immediately.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/imx-pcm-fiq.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/imx-pcm-fiq.c b/sound/soc/fsl/imx-pcm-fiq.c
index 6553202..7abf6a0 100644
--- a/sound/soc/fsl/imx-pcm-fiq.c
+++ b/sound/soc/fsl/imx-pcm-fiq.c
@@ -270,18 +270,17 @@ static int imx_pcm_new(struct snd_soc_pcm_runtime *rtd)
 		ret = imx_pcm_preallocate_dma_buffer(pcm,
 			SNDRV_PCM_STREAM_PLAYBACK);
 		if (ret)
-			goto out;
+			return ret;
 	}
 
 	if (pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
 		ret = imx_pcm_preallocate_dma_buffer(pcm,
 			SNDRV_PCM_STREAM_CAPTURE);
 		if (ret)
-			goto out;
+			return ret;
 	}
 
-out:
-	return ret;
+	return 0;
 }
 
 static int ssi_irq = 0;
-- 
1.8.1.2
