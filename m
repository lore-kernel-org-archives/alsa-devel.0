From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH V2 1/3] ASoC: restructure
	dmaengine_pcm_request_chan_of()
Date: Tue,  3 Dec 2013 14:26:32 -0700
Message-ID: <1386105994-16373-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 61FDF2652CA
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2013 22:26:41 +0100 (CET)
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

Restructure the internals of dmaengine_pcm_request_chan_of() as a loop
over all channels to be allocated. This makes it easier to add logic
that applies to all allocated channels, without having to duplicate that
logic in each of the half-duplex/full-duplex paths.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2 (new as a separate patch):
* Re-ordered patches, so that patch 3/3 in this series could be available
  in the ASoC tree without having to wait for the patches to the DMA tree
  the implement deferred probe during channel allocation.

This whole series is a dependency for some patches that will go through
the Tegra tree. If it could be applied to a topic branch in the ASoC tree
that would be great. the overall dependency structure will be:

a) This series.
   Can be applied on top of e.g. v3.13-rc1.
b) Patches to the DMA tree, which implement deferred probe.
   Can be applied on top of e.g. v3.13-rc1.
c) ASoC modifications to support deferred probe during DMA ch allocation
   This will depend on both (a) and (b).
d) Tegra modifications that depend on (c).
---
 sound/soc/soc-generic-dmaengine-pcm.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index cbc9c96ce1f4..88b011b80058 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -288,21 +288,26 @@ static void dmaengine_pcm_request_chan_of(struct dmaengine_pcm *pcm,
 	struct device *dev)
 {
 	unsigned int i;
+	const char *name;
 
 	if ((pcm->flags & (SND_DMAENGINE_PCM_FLAG_NO_DT |
 			   SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME)) ||
 	    !dev->of_node)
 		return;
 
-	if (pcm->flags & SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX) {
-		pcm->chan[0] = dma_request_slave_channel(dev, "rx-tx");
-		pcm->chan[1] = pcm->chan[0];
-	} else {
-		for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE; i++) {
-			pcm->chan[i] = dma_request_slave_channel(dev,
-					dmaengine_pcm_dma_channel_names[i]);
-		}
+	for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE;
+	     i++) {
+		if (pcm->flags & SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX)
+			name = "rx-tx";
+		else
+			name = dmaengine_pcm_dma_channel_names[i];
+		pcm->chan[i] = dma_request_slave_channel(dev, name);
+		if (pcm->flags & SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX)
+			break;
 	}
+
+	if (pcm->flags & SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX)
+		pcm->chan[1] = pcm->chan[0];
 }
 
 /**
-- 
1.8.1.5
