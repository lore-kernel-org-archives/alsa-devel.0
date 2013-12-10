From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH V3] ASoC: dmaengine: support deferred probe for
	DMA channels
Date: Tue, 10 Dec 2013 11:11:02 -0700
Message-ID: <1386699062-27933-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 28DD12652EE
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2013 19:11:09 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

Enhance dmaengine_pcm_request_chan_of() to support deferred probe for
DMA channels, by using the new dma_request_slave_channel_or_err() API.
This prevents snd_dmaengine_pcm_register() from succeeding without
acquiring DMA channels due to the relevant DMA controller not yet being
registered.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
---
Mark, this is the patch which requires the dependency from the DMA tree,
i.e. what I mentioned in the pull request that I sent just a little while
ago. You'd previously ack'd it so I could take it through the Tegra tree,
but it's probably better if instead you put it into ASoC tree first, then
I pull your (topic/dma?) branch into the Tegra tree.

(I've validated that your current topic/dma, plus a merge of the DMA
tree's topic/defer_probe, plus this patch, plus a merge of next-20131210
to pick up the rest of ASoC etc., runs without conflicts and builds at
least for Tegra without issues).

v3:
* Fix missing braces around else block.
v2:
* Call dmaengine_pcm_release_chan() if dmaengine_pcm_request_chan_of()
  fails, to clean up any partial allocations.
---
 sound/soc/soc-generic-dmaengine-pcm.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 5b70c556fba3..585eaa69e8c3 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -287,16 +287,17 @@ static const char * const dmaengine_pcm_dma_channel_names[] = {
 	[SNDRV_PCM_STREAM_CAPTURE] = "rx",
 };
 
-static void dmaengine_pcm_request_chan_of(struct dmaengine_pcm *pcm,
+static int dmaengine_pcm_request_chan_of(struct dmaengine_pcm *pcm,
 	struct device *dev, const struct snd_dmaengine_pcm_config *config)
 {
 	unsigned int i;
 	const char *name;
+	struct dma_chan *chan;
 
 	if ((pcm->flags & (SND_DMAENGINE_PCM_FLAG_NO_DT |
 			   SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME)) ||
 	    !dev->of_node)
-		return;
+		return 0;
 
 	if (config->dma_dev) {
 		/*
@@ -318,13 +319,22 @@ static void dmaengine_pcm_request_chan_of(struct dmaengine_pcm *pcm,
 			name = dmaengine_pcm_dma_channel_names[i];
 		if (config->chan_names[i])
 			name = config->chan_names[i];
-		pcm->chan[i] = dma_request_slave_channel(dev, name);
+		chan = dma_request_slave_channel_reason(dev, name);
+		if (IS_ERR(chan)) {
+			if (PTR_ERR(pcm->chan[i]) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+			pcm->chan[i] = NULL;
+		} else {
+			pcm->chan[i] = chan;
+		}
 		if (pcm->flags & SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX)
 			break;
 	}
 
 	if (pcm->flags & SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX)
 		pcm->chan[1] = pcm->chan[0];
+
+	return 0;
 }
 
 static void dmaengine_pcm_release_chan(struct dmaengine_pcm *pcm)
@@ -360,7 +370,9 @@ int snd_dmaengine_pcm_register(struct device *dev,
 	pcm->config = config;
 	pcm->flags = flags;
 
-	dmaengine_pcm_request_chan_of(pcm, dev, config);
+	ret = dmaengine_pcm_request_chan_of(pcm, dev, config);
+	if (ret)
+		goto err_free_dma;
 
 	if (flags & SND_DMAENGINE_PCM_FLAG_NO_RESIDUE)
 		ret = snd_soc_add_platform(dev, &pcm->platform,
-- 
1.8.1.5
