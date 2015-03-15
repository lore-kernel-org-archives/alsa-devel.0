From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: nuc900: No need to track the dma buffer
	in the driver state struct
Date: Sun, 15 Mar 2015 12:15:24 +0100
Message-ID: <1426418124-1096-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-060.synserver.de (smtp-out-060.synserver.de
 [212.40.185.60])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D12526049D
 for <alsa-devel@alsa-project.org>; Sun, 15 Mar 2015 12:15:18 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Wan ZongShun <mcuos.com@gmail.com>
List-Id: alsa-devel@alsa-project.org

The DMA buffer and address can be accessed through the snd_pcm_runtime.
There is no need to manually track them in the driver's state struct.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/nuc900/nuc900-audio.h |  3 ---
 sound/soc/nuc900/nuc900-pcm.c   | 31 +++++--------------------------
 2 files changed, 5 insertions(+), 29 deletions(-)

diff --git a/sound/soc/nuc900/nuc900-audio.h b/sound/soc/nuc900/nuc900-audio.h
index 59f7e8e..d0b7257 100644
--- a/sound/soc/nuc900/nuc900-audio.h
+++ b/sound/soc/nuc900/nuc900-audio.h
@@ -100,10 +100,7 @@
 struct nuc900_audio {
 	void __iomem *mmio;
 	spinlock_t lock;
-	dma_addr_t dma_addr[2];
-	unsigned long buffersize[2];
 	unsigned long irq_num;
-	struct snd_pcm_substream *substream;
 	struct resource *res;
 	struct clk *clk;
 	struct device *dev;
diff --git a/sound/soc/nuc900/nuc900-pcm.c b/sound/soc/nuc900/nuc900-pcm.c
index b809fa9..5ae5ca1 100644
--- a/sound/soc/nuc900/nuc900-pcm.c
+++ b/sound/soc/nuc900/nuc900-pcm.c
@@ -42,29 +42,10 @@ static const struct snd_pcm_hardware nuc900_pcm_hardware = {
 static int nuc900_dma_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct nuc900_audio *nuc900_audio = runtime->private_data;
-	unsigned long flags;
-	int ret = 0;
-
-	ret = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
-	if (ret < 0)
-		return ret;
-
-	spin_lock_irqsave(&nuc900_audio->lock, flags);
-
-	nuc900_audio->substream = substream;
-	nuc900_audio->dma_addr[substream->stream] = runtime->dma_addr;
-	nuc900_audio->buffersize[substream->stream] =
-						params_buffer_bytes(params);
-
-	spin_unlock_irqrestore(&nuc900_audio->lock, flags);
-
-	return ret;
+	return snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
 }
 
-static void nuc900_update_dma_register(struct snd_pcm_substream *substream,
-				dma_addr_t dma_addr, size_t count)
+static void nuc900_update_dma_register(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct nuc900_audio *nuc900_audio = runtime->private_data;
@@ -78,8 +59,8 @@ static void nuc900_update_dma_register(struct snd_pcm_substream *substream,
 		mmio_len = nuc900_audio->mmio + ACTL_RDST_LENGTH;
 	}
 
-	AUDIO_WRITE(mmio_addr, dma_addr);
-	AUDIO_WRITE(mmio_len, count);
+	AUDIO_WRITE(mmio_addr, runtime->dma_addr);
+	AUDIO_WRITE(mmio_len, runtime->dma_bytes);
 }
 
 static void nuc900_dma_start(struct snd_pcm_substream *substream)
@@ -170,9 +151,7 @@ static int nuc900_dma_prepare(struct snd_pcm_substream *substream)
 
 	spin_lock_irqsave(&nuc900_audio->lock, flags);
 
-	nuc900_update_dma_register(substream,
-				nuc900_audio->dma_addr[substream->stream],
-				nuc900_audio->buffersize[substream->stream]);
+	nuc900_update_dma_register(substream);
 
 	val = AUDIO_READ(nuc900_audio->mmio + ACTL_RESET);
 
-- 
1.8.0
