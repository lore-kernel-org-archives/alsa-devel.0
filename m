From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/3] ASoC: edma-pcm: Remove PCM_INFO_BATCH and
	add PCM_INFO_NO_PERIOD_WAKEUP flag
Date: Wed, 16 Jul 2014 15:12:02 +0300
Message-ID: <1405512724-23628-2-git-send-email-peter.ujfalusi@ti.com>
References: <1405512724-23628-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 6799E2619E9
 for <alsa-devel@alsa-project.org>; Wed, 16 Jul 2014 14:12:10 +0200 (CEST)
In-Reply-To: <1405512724-23628-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

The SNDRV_PCM_INFO_BATCH will be added back based on the dmaengine driver's
capabilities.
Patches for edma dmaengine driver has been prepared to suppress the
interrupts. We can add this flag right away and have the benefit of not
having interrupts during audio activity when the edma and ASoC patches
are in the same tree.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/edma-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/davinci/edma-pcm.c b/sound/soc/davinci/edma-pcm.c
index d38afb1c61ae..605e643133db 100644
--- a/sound/soc/davinci/edma-pcm.c
+++ b/sound/soc/davinci/edma-pcm.c
@@ -28,8 +28,8 @@
 static const struct snd_pcm_hardware edma_pcm_hardware = {
 	.info			= SNDRV_PCM_INFO_MMAP |
 				  SNDRV_PCM_INFO_MMAP_VALID |
-				  SNDRV_PCM_INFO_BATCH |
 				  SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME |
+				  SNDRV_PCM_INFO_NO_PERIOD_WAKEUP |
 				  SNDRV_PCM_INFO_INTERLEAVED,
 	.buffer_bytes_max	= 128 * 1024,
 	.period_bytes_min	= 32,
-- 
2.0.0
