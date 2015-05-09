From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] ASoC: fsl: fsl_dma: Use true/false for
	boolean init
Date: Sat,  9 May 2015 12:45:52 -0300
Message-ID: <1431186353-7331-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f49.google.com (mail-yh0-f49.google.com
 [209.85.213.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 61793260505
 for <alsa-devel@alsa-project.org>; Sat,  9 May 2015 17:46:19 +0200 (CEST)
Received: by yhw29 with SMTP id 29so26610441yhw.1
 for <alsa-devel@alsa-project.org>; Sat, 09 May 2015 08:46:18 -0700 (PDT)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Bool initializations should use true and false.  Bool tests don't need
comparisons.  Based on contributions from Joe Perches, Rusty Russell
and Bruce W Allan.

The semantic patch that makes this change is available
in scripts/coccinelle/misc/boolinit.cocci.

More information about semantic patching is available at
http://coccinelle.lip6.fr/

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/fsl_dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 93d7e56..ccadefc 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -445,7 +445,7 @@ static int fsl_dma_open(struct snd_pcm_substream *substream)
 		return ret;
 	}
 
-	dma->assigned = 1;
+	dma->assigned = true;
 
 	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
 	snd_soc_set_runtime_hwparams(substream, &fsl_dma_hardware);
@@ -814,7 +814,7 @@ static int fsl_dma_close(struct snd_pcm_substream *substream)
 		substream->runtime->private_data = NULL;
 	}
 
-	dma->assigned = 0;
+	dma->assigned = false;
 
 	return 0;
 }
-- 
1.9.1
