From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH] ASoC: snd_dmaengine: add common api for pcm_mmap
Date: Thu, 28 Jun 2012 12:31:26 +0530
Message-ID: <1340866886-24432-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, broonie@opensource.wolfsonmicro.com, tiwai@suse.de, lrg@ti.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, swarren@nvidia.com, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: alsa-devel@alsa-project.org

The pcm mmap for the substream dma buffer is done using the
dma_mmap_writecombine().
Some of the chip sound driver like Spear, Tegra, Davinci,
ep93xx,snd_imx, snd_mxs, NUC900, OMAP, Samsung are doing this
mapping locally.
Add api in the snd dmaengine driver so that different client of
snd dmaengine can use this rather than implementing locally.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 include/sound/dmaengine_pcm.h |    2 ++
 sound/soc/soc-dmaengine-pcm.c |   17 +++++++++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index b877334..15c0d3c 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -47,4 +47,6 @@ int snd_dmaengine_pcm_close(struct snd_pcm_substream *substream);
 
 struct dma_chan *snd_dmaengine_pcm_get_chan(struct snd_pcm_substream *substream);
 
+int snd_dmaengine_pcm_mmap_writecombine(struct snd_pcm_substream *substream,
+		struct vm_area_struct *vma);
 #endif
diff --git a/sound/soc/soc-dmaengine-pcm.c b/sound/soc/soc-dmaengine-pcm.c
index 5df529e..6535eb3 100644
--- a/sound/soc/soc-dmaengine-pcm.c
+++ b/sound/soc/soc-dmaengine-pcm.c
@@ -21,6 +21,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -313,3 +314,19 @@ int snd_dmaengine_pcm_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_close);
+
+/**
+ * snd_dmaengine_pcm_mmap_writecombine - mmap stream dma buffer using
+ * dma_mmap_writecombine().
+ * @substream: PCM substream
+ * @vma: VM area.
+ */
+int snd_dmaengine_pcm_mmap_writecombine(struct snd_pcm_substream *substream,
+			struct vm_area_struct *vma)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	return dma_mmap_writecombine(substream->pcm->card->dev, vma,
+		runtime->dma_area, runtime->dma_addr, runtime->dma_bytes);
+}
+EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_mmap_writecombine);
-- 
1.7.1.1
