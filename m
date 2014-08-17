From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/6] ASoC: sh: Fix dma direction type
Date: Sun, 17 Aug 2014 16:18:20 +0200
Message-ID: <1408285102-24538-5-git-send-email-lars@metafoo.de>
References: <1408285102-24538-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-166.synserver.de (smtp-out-166.synserver.de
 [212.40.185.166])
 by alsa0.perex.cz (Postfix) with ESMTP id B79F12650F2
 for <alsa-devel@alsa-project.org>; Sun, 17 Aug 2014 16:18:29 +0200 (CEST)
In-Reply-To: <1408285102-24538-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Sangbeom Kim <sbkim73@samsung.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

dmaengine_prep_slave_single() expects a enum dma_transfer_direction and not a
enum dma_data_direction. Since the integer representations of both DMA_TO_DEVICE
and DMA_MEM_TO_DEV aswell as DMA_FROM_DEVICE and DMA_DEV_TO_MEM have the same
value the code worked fine even though it was using the wrong type.

Fixes the following warnings from sparse:
	sound/soc/sh/fsi.c:1307:42: warning: mixing different enum types
	sound/soc/sh/fsi.c:1307:42:     int enum dma_data_direction  versus
	sound/soc/sh/fsi.c:1307:42:     int enum dma_transfer_direction

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/sh/fsi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index c763443..66fddec 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1297,9 +1297,14 @@ static int fsi_dma_transfer(struct fsi_priv *fsi, struct fsi_stream *io)
 	struct snd_pcm_substream *substream = io->substream;
 	struct dma_async_tx_descriptor *desc;
 	int is_play = fsi_stream_is_play(fsi, io);
-	enum dma_data_direction dir = is_play ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
+	enum dma_transfer_direction dir;
 	int ret = -EIO;
 
+	if (is_play)
+		dir = DMA_MEM_TO_DEV;
+	else
+		dir = DMA_DEV_TO_MEM;
+
 	desc = dmaengine_prep_dma_cyclic(io->chan,
 					 substream->runtime->dma_addr,
 					 snd_pcm_lib_buffer_bytes(substream),
-- 
1.8.0
