From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: generic-dmaengine-pcm: Set BATCH flag
	when residue reporting is not supported
Date: Sat, 30 Nov 2013 18:00:45 +0100
Message-ID: <1385830845-30517-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-136.synserver.de (smtp-out-237.synserver.de
 [212.40.185.237])
 by alsa0.perex.cz (Postfix) with ESMTP id 97C362616E1
 for <alsa-devel@alsa-project.org>; Sat, 30 Nov 2013 18:00:09 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

For dmaengine drivers which do not support transfer residue reporting we update
the PCM pointer with period granularity. Set the SNDRV_PCM_INFO_BATCH flag in
this case to let userspace know about this.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index cbc9c96..87e8635 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -137,6 +137,9 @@ static int dmaengine_pcm_set_runtime_hwparams(struct snd_pcm_substream *substrea
 	hw.buffer_bytes_max = SIZE_MAX;
 	hw.fifo_size = dma_data->fifo_size;
 
+	if (pcm->flags & SND_DMAENGINE_PCM_FLAG_NO_RESIDUE)
+		hw.info |= SNDRV_PCM_INFO_BATCH;
+
 	ret = dma_get_slave_caps(chan, &dma_caps);
 	if (ret == 0) {
 		if (dma_caps.cmd_pause)
-- 
1.8.0
