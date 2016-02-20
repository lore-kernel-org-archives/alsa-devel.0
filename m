From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: use snd_dma_alloc/free* apis" to
	the asoc tree
Date: Sun, 21 Feb 2016 02:15:27 +0900
Message-ID: <E1aXB7v-0008KB-Qc@finisterre>
References: <1455099493-359-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 821E726513B
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 18:15:35 +0100 (CET)
In-Reply-To: <1455099493-359-1-git-send-email-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qcom: use snd_dma_alloc/free* apis

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 144a98835d2b4fc8a732628eaa5c98c573d58baf Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 11 Feb 2016 12:17:17 +0000
Subject: [PATCH] ASoC: qcom: use snd_dma_alloc/free* apis

There is no point in having local allocation functions when the driver
can use snd_dma_alloc/free() apis. This patch replaces the local versions
of the dma allocation apis with the snd_dma_alloc/free() apis.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Kenneth Westfield <kwestfie@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/lpass-platform.c | 42 ++++++-----------------------------------
 1 file changed, 6 insertions(+), 36 deletions(-)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index 4aeb8e1..ec2414d 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -439,39 +439,6 @@ static irqreturn_t lpass_platform_lpaif_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int lpass_platform_alloc_buffer(struct snd_pcm_substream *substream,
-		struct snd_soc_pcm_runtime *rt)
-{
-	struct snd_dma_buffer *buf = &substream->dma_buffer;
-	size_t size = lpass_platform_pcm_hardware.buffer_bytes_max;
-
-	buf->dev.type = SNDRV_DMA_TYPE_DEV;
-	buf->dev.dev = rt->platform->dev;
-	buf->private_data = NULL;
-	buf->area = dma_alloc_coherent(rt->platform->dev, size, &buf->addr,
-			GFP_KERNEL);
-	if (!buf->area) {
-		dev_err(rt->platform->dev, "%s: Could not allocate DMA buffer\n",
-				__func__);
-		return -ENOMEM;
-	}
-	buf->bytes = size;
-
-	return 0;
-}
-
-static void lpass_platform_free_buffer(struct snd_pcm_substream *substream,
-		struct snd_soc_pcm_runtime *rt)
-{
-	struct snd_dma_buffer *buf = &substream->dma_buffer;
-
-	if (buf->area) {
-		dma_free_coherent(rt->dev, buf->bytes, buf->area,
-				buf->addr);
-	}
-	buf->area = NULL;
-}
-
 static int lpass_platform_pcm_new(struct snd_soc_pcm_runtime *soc_runtime)
 {
 	struct snd_pcm *pcm = soc_runtime->pcm;
@@ -483,6 +450,7 @@ static int lpass_platform_pcm_new(struct snd_soc_pcm_runtime *soc_runtime)
 	struct lpass_variant *v = drvdata->variant;
 	int ret;
 	struct lpass_pcm_data *data;
+	size_t size = lpass_platform_pcm_hardware.buffer_bytes_max;
 
 	data = devm_kzalloc(soc_runtime->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -499,7 +467,9 @@ static int lpass_platform_pcm_new(struct snd_soc_pcm_runtime *soc_runtime)
 
 	snd_soc_pcm_set_drvdata(soc_runtime, data);
 
-	ret = lpass_platform_alloc_buffer(substream, soc_runtime);
+	ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV,
+				soc_runtime->platform->dev,
+				size, &substream->dma_buffer);
 	if (ret)
 		return ret;
 
@@ -514,7 +484,7 @@ static int lpass_platform_pcm_new(struct snd_soc_pcm_runtime *soc_runtime)
 	return 0;
 
 err_buf:
-	lpass_platform_free_buffer(substream, soc_runtime);
+	snd_dma_free_pages(&substream->dma_buffer);
 	return ret;
 }
 
@@ -533,7 +503,7 @@ static void lpass_platform_pcm_free(struct snd_pcm *pcm)
 	if (v->free_dma_channel)
 		v->free_dma_channel(drvdata, data->rdma_ch);
 
-	lpass_platform_free_buffer(substream, soc_runtime);
+	snd_dma_free_pages(&substream->dma_buffer);
 }
 
 static struct snd_soc_platform_driver lpass_platform_driver = {
-- 
2.7.0
