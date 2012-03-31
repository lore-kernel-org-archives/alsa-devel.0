From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 1/1] ASoC: soc-dmaengine-pcm: fix compile error
	since dma api is changed
Date: Sat, 31 Mar 2012 20:37:48 +0800
Message-ID: <1333197468-3263-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
	(am1ehsobe002.messaging.microsoft.com [213.199.154.205])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D92F244E4
	for <alsa-devel@alsa-project.org>;
	Sat, 31 Mar 2012 14:26:53 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

From: Dong Aisheng <dong.aisheng@linaro.org>

The following compiling error is caused by the API device_prep_dma_cyclic
is changed. Using dmaengine_prep_dma_cyclic to fix it.

sound/soc/soc-dmaengine-pcm.c: In function 'dmaengine_pcm_prepare_and_submit':
sound/soc/soc-dmaengine-pcm.c:149: error: too few arguments to function 'chan->device->device_prep_dma_cyclic'
make[2]: *** [sound/soc/soc-dmaengine-pcm.o] Error 1
make[1]: *** [sound/soc] Error 2
make: *** [sound] Error 2

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 sound/soc/soc-dmaengine-pcm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-dmaengine-pcm.c b/sound/soc/soc-dmaengine-pcm.c
index 4420b70..4756952 100644
--- a/sound/soc/soc-dmaengine-pcm.c
+++ b/sound/soc/soc-dmaengine-pcm.c
@@ -143,7 +143,7 @@ static int dmaengine_pcm_prepare_and_submit(struct snd_pcm_substream *substream)
 	direction = snd_pcm_substream_to_dma_direction(substream);
 
 	prtd->pos = 0;
-	desc = chan->device->device_prep_dma_cyclic(chan,
+	desc = dmaengine_prep_dma_cyclic(chan,
 		substream->runtime->dma_addr,
 		snd_pcm_lib_buffer_bytes(substream),
 		snd_pcm_lib_period_bytes(substream), direction);
-- 
1.7.0.4
