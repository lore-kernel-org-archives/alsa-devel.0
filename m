From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH] ASoC: dmaengine: fix deferred probe detection
Date: Wed, 11 Dec 2013 11:20:50 -0700
Message-ID: <1386786050-4846-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com [216.228.121.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C67EC261B05
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2013 19:20:55 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Check the return value of dma_request_slave_channel_reason() to see if
deferred probe happens, not the variable the return value will be
assigned to later.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Fixes: 5eda87b890f8 ("ASoC: dmaengine: support deferred probe for DMA channels")
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 585eaa69e8c3..7483922f6ee3 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -321,7 +321,7 @@ static int dmaengine_pcm_request_chan_of(struct dmaengine_pcm *pcm,
 			name = config->chan_names[i];
 		chan = dma_request_slave_channel_reason(dev, name);
 		if (IS_ERR(chan)) {
-			if (PTR_ERR(pcm->chan[i]) == -EPROBE_DEFER)
+			if (PTR_ERR(chan) == -EPROBE_DEFER)
 				return -EPROBE_DEFER;
 			pcm->chan[i] = NULL;
 		} else {
-- 
1.8.1.5
