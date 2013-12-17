From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: dmaengine: Add config parameter NULL check.
Date: Tue, 17 Dec 2013 15:16:40 +0800
Message-ID: <1387264600-14225-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Because the "ASoC: dmaengine-pcm: Provide default config" has provided
us one defualt config of DMA. When using this, the config parameter of
devm_snd_dmaengine_pcm_register() will be NULL, so here we need to have
a check before using it.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 7483922..2a6c569 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -299,7 +299,7 @@ static int dmaengine_pcm_request_chan_of(struct dmaengine_pcm *pcm,
 	    !dev->of_node)
 		return 0;
 
-	if (config->dma_dev) {
+	if (config && config->dma_dev) {
 		/*
 		 * If this warning is seen, it probably means that your Linux
 		 * device structure does not match your HW device structure.
@@ -317,7 +317,7 @@ static int dmaengine_pcm_request_chan_of(struct dmaengine_pcm *pcm,
 			name = "rx-tx";
 		else
 			name = dmaengine_pcm_dma_channel_names[i];
-		if (config->chan_names[i])
+		if (config && config->chan_names[i])
 			name = config->chan_names[i];
 		chan = dma_request_slave_channel_reason(dev, name);
 		if (IS_ERR(chan)) {
-- 
1.8.4
