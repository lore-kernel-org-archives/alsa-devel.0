From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 01/10] ASoC: kirkwood-dma: fix use of
	virt_to_phys()
Date: Tue, 20 Nov 2012 12:17:51 +0000
Message-ID: <E1Tamlz-0007X3-Pj@rmk-PC.arm.linux.org.uk>
References: <20121120121726.GN3290@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id B86372615DF
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2012 13:17:54 +0100 (CET)
In-Reply-To: <20121120121726.GN3290@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Liam Girdwood <lrg@ti.com>, Rabeeh Khoury <rabeeh@solid-run.com>
List-Id: alsa-devel@alsa-project.org

This is part of a patch found in Rabeeh Khoury's git tree for the
cubox.

You can not use virt_to_phys() on the address returned from
dma_alloc_coherent(); it may not be part of the kernel direct-mapped
memory.  Fix this to use the DMA address instead.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/kirkwood/kirkwood-dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index b9f1659..afe1930 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -178,7 +178,7 @@ static int kirkwood_dma_open(struct snd_pcm_substream *substream)
 	}
 
 	dram = mv_mbus_dram_info();
-	addr = virt_to_phys(substream->dma_buffer.area);
+	addr = substream->dma_buffer.addr;
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		prdata->play_stream = substream;
 		kirkwood_dma_conf_mbus_windows(priv->io,
-- 
1.7.4.4
