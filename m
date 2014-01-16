From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: core: Use devm_kzalloc() instead kzalloc()
Date: Thu, 16 Jan 2014 16:44:47 +0800
Message-ID: <1389861887-32721-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Makes the code slightly shorter

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 5bace12..bfb012f 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -388,7 +388,7 @@ int snd_dmaengine_pcm_register(struct device *dev,
 	struct dmaengine_pcm *pcm;
 	int ret;
 
-	pcm = kzalloc(sizeof(*pcm), GFP_KERNEL);
+	pcm = devm_kzalloc(dev, sizeof(*pcm), GFP_KERNEL);
 	if (!pcm)
 		return -ENOMEM;
 
@@ -408,7 +408,6 @@ int snd_dmaengine_pcm_register(struct device *dev,
 
 err_free_dma:
 	dmaengine_pcm_release_chan(pcm);
-	kfree(pcm);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_register);
@@ -433,7 +432,6 @@ void snd_dmaengine_pcm_unregister(struct device *dev)
 
 	snd_soc_remove_platform(platform);
 	dmaengine_pcm_release_chan(pcm);
-	kfree(pcm);
 }
 EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_unregister);
 
-- 
1.8.4
