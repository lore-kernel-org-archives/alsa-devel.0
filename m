From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH] ASoC: Tegra: Fix error handling in DMA channel
	alloc
Date: Tue, 22 Feb 2011 20:16:34 -0700
Message-ID: <1298430994-20999-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 46E7824533
	for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2011 04:16:43 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

tegra_dma_allocate_channel() returns NULL on errors, not an error pointer.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/tegra/tegra_pcm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/tegra/tegra_pcm.c b/sound/soc/tegra/tegra_pcm.c
index 40540b1..3c271f9 100644
--- a/sound/soc/tegra/tegra_pcm.c
+++ b/sound/soc/tegra/tegra_pcm.c
@@ -161,8 +161,8 @@ static int tegra_pcm_open(struct snd_pcm_substream *substream)
 	prtd->dma_req[1].dev = prtd;
 
 	prtd->dma_chan = tegra_dma_allocate_channel(TEGRA_DMA_MODE_ONESHOT);
-	if (IS_ERR(prtd->dma_chan)) {
-		ret = PTR_ERR(prtd->dma_chan);
+	if (prtd->dma_chan == NULL) {
+		ret = -ENOMEM;
 		goto err;
 	}
 
-- 
1.7.1
