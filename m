From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH] ASoC: kirkwood: prevent double streaming
Date: Tue, 21 Jul 2015 18:32:58 +0200
Message-ID: <20150721165717.F04792605AA@alsa0.perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
 by alsa0.perex.cz (Postfix) with ESMTP id 040AA260599
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2015 18:57:11 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The kirkwood audio subsystem presents 2 PCM's for one source.
Streaming on a second PCM while the first one is active
cuts this last one.
Then, ending the last stream gives a kernel trap in free_irq().

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 sound/soc/kirkwood/kirkwood-dma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index 4cf2245..dbfdfe9 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -148,10 +148,14 @@ static int kirkwood_dma_open(struct snd_pcm_substream *substream)
 	dram = mv_mbus_dram_info();
 	addr = substream->dma_buffer.addr;
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		if (priv->substream_play)
+			return -EBUSY;
 		priv->substream_play = substream;
 		kirkwood_dma_conf_mbus_windows(priv->io,
 			KIRKWOOD_PLAYBACK_WIN, addr, dram);
 	} else {
+		if (priv->substream_rec)
+			return -EBUSY;
 		priv->substream_rec = substream;
 		kirkwood_dma_conf_mbus_windows(priv->io,
 			KIRKWOOD_RECORD_WIN, addr, dram);
-- 
2.1.4
