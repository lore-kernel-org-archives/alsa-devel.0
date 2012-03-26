From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: [PATCH] ASoC: dmaengine_pcm: use dmaengine cyclic wrapper
Date: Mon, 26 Mar 2012 17:28:08 +0530
Message-ID: <1332763088-18964-1-git-send-email-vinod.koul@linux.intel.com>
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-next@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, paul.gortmaker@windriver.com, fabio.estevam@freescale.com, Alexandre.Bounine@idt.com, Vinod Koul <vinod.koul@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

commit 4a163c82 added extra parameter to device_prep_dma_cyclic
this is not required if we use the wrapper over cyclic API.

This is split from Alexedre's patch

Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
---
 sound/soc/soc-dmaengine-pcm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dmaengine-pcm.c b/sound/soc/soc-dmaengine-pcm.c
index 76c038b..4756952 100644
--- a/sound/soc/soc-dmaengine-pcm.c
+++ b/sound/soc/soc-dmaengine-pcm.c
@@ -143,10 +143,10 @@ static int dmaengine_pcm_prepare_and_submit(struct snd_pcm_substream *substream)
 	direction = snd_pcm_substream_to_dma_direction(substream);
 
 	prtd->pos = 0;
-	desc = chan->device->device_prep_dma_cyclic(chan,
+	desc = dmaengine_prep_dma_cyclic(chan,
 		substream->runtime->dma_addr,
 		snd_pcm_lib_buffer_bytes(substream),
-		snd_pcm_lib_period_bytes(substream), direction, NULL);
+		snd_pcm_lib_period_bytes(substream), direction);
 
 	if (!desc)
 		return -ENOMEM;
-- 
1.7.0.4
