From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: use correct device pointer in dma
	allocation" to the asoc tree
Date: Mon, 11 Jan 2016 17:54:12 +0000
Message-ID: <E1aIgfU-0007zB-RS@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 375892604D1
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2016 18:54:24 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qcom: use correct device pointer in dma allocation

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

>From f5f76ea75dce553631ffb08abc44dcecb68e74d4 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Mon, 11 Jan 2016 15:17:23 +0000
Subject: [PATCH] ASoC: qcom: use correct device pointer in dma allocation

dev pointer in struct snd_soc_pcm_runtime does not have dma_ops set. In
v4.4 kernel dma_ops would end up pointing to dummy_dma_ops in such cases.
So attempting to use such device in allocating coherent memory on aarch64
would fail.

According to commit 1dccb598df549d892b6450c261da54cdd7af44b4 ("arm64:
simplify dma_get_ops") The current behavior of dma_get_ops is to fall
back to the global dma_ops when a device has not set its own dma_ops,
but only for DT based systems.

So, this patch fixes the driver to use correct device pointer while
allocating coherent memory, and also deletes un-necessary dma_mask setup
on soc_runtime->dev.

Without this patch lpass driver would fail with below log:
...
[    6.541542]  ADV7533: lpass_platform_alloc_buffer: Could not allocate DMA buffer
[    6.541914] apq8016-lpass-cpu 7708000.lpass-cpu: ASoC: pcm constructor failed: -12
[    6.548216] qcom-apq8016-sbc 7702000.sound: ASoC: can't create pcm ADV7533 :-12
[    6.555581] qcom-apq8016-sbc 7702000.sound: ASoC: failed to instantiate card -12
[    6.566072] qcom-apq8016-sbc: probe of 7702000.sound failed with error -12
...

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/lpass-platform.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index 79688aa1941a..4aeb8e1a7160 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -440,18 +440,18 @@ static irqreturn_t lpass_platform_lpaif_irq(int irq, void *data)
 }
 
 static int lpass_platform_alloc_buffer(struct snd_pcm_substream *substream,
-		struct snd_soc_pcm_runtime *soc_runtime)
+		struct snd_soc_pcm_runtime *rt)
 {
 	struct snd_dma_buffer *buf = &substream->dma_buffer;
 	size_t size = lpass_platform_pcm_hardware.buffer_bytes_max;
 
 	buf->dev.type = SNDRV_DMA_TYPE_DEV;
-	buf->dev.dev = soc_runtime->dev;
+	buf->dev.dev = rt->platform->dev;
 	buf->private_data = NULL;
-	buf->area = dma_alloc_coherent(soc_runtime->dev, size, &buf->addr,
+	buf->area = dma_alloc_coherent(rt->platform->dev, size, &buf->addr,
 			GFP_KERNEL);
 	if (!buf->area) {
-		dev_err(soc_runtime->dev, "%s: Could not allocate DMA buffer\n",
+		dev_err(rt->platform->dev, "%s: Could not allocate DMA buffer\n",
 				__func__);
 		return -ENOMEM;
 	}
@@ -461,12 +461,12 @@ static int lpass_platform_alloc_buffer(struct snd_pcm_substream *substream,
 }
 
 static void lpass_platform_free_buffer(struct snd_pcm_substream *substream,
-		struct snd_soc_pcm_runtime *soc_runtime)
+		struct snd_soc_pcm_runtime *rt)
 {
 	struct snd_dma_buffer *buf = &substream->dma_buffer;
 
 	if (buf->area) {
-		dma_free_coherent(soc_runtime->dev, buf->bytes, buf->area,
+		dma_free_coherent(rt->dev, buf->bytes, buf->area,
 				buf->addr);
 	}
 	buf->area = NULL;
@@ -499,9 +499,6 @@ static int lpass_platform_pcm_new(struct snd_soc_pcm_runtime *soc_runtime)
 
 	snd_soc_pcm_set_drvdata(soc_runtime, data);
 
-	soc_runtime->dev->coherent_dma_mask = DMA_BIT_MASK(32);
-	soc_runtime->dev->dma_mask = &soc_runtime->dev->coherent_dma_mask;
-
 	ret = lpass_platform_alloc_buffer(substream, soc_runtime);
 	if (ret)
 		return ret;
-- 
2.7.0.rc3
