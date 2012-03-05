From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: dmaengine_pcm: Reset pointer
	position when starting a stream
Date: Mon,  5 Mar 2012 14:02:14 +0100
Message-ID: <1330952535-30614-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-211.synserver.de (smtp-out-212.synserver.de
	[212.40.185.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 02372104188
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 14:00:33 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Vinod Koul <vinod.koul@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@iki.fi>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Mika Westerberg <mika.westerberg@iki.fi>

Otherwise a wrong position will be reported after restarting a stream and the
first few samples might be skipped.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dmaengine-pcm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-dmaengine-pcm.c b/sound/soc/soc-dmaengine-pcm.c
index 0526cf8..4420b70 100644
--- a/sound/soc/soc-dmaengine-pcm.c
+++ b/sound/soc/soc-dmaengine-pcm.c
@@ -142,6 +142,7 @@ static int dmaengine_pcm_prepare_and_submit(struct snd_pcm_substream *substream)
 
 	direction = snd_pcm_substream_to_dma_direction(substream);
 
+	prtd->pos = 0;
 	desc = chan->device->device_prep_dma_cyclic(chan,
 		substream->runtime->dma_addr,
 		snd_pcm_lib_buffer_bytes(substream),
-- 
1.7.9.1
