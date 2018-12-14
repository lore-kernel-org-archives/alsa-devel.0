From: Mark Brown <broonie@kernel.org>
Subject: Applied "ALSA: soc-compress: add support to
	snd_compr_set_runtime_buffer()" to the asoc tree
Date: Fri, 14 Dec 2018 12:44:20 +0000 (GMT)
Message-ID: <20181214124420.84B4411258A2@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 369CF267A79
 for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2018 13:44:21 +0100 (CET)
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
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ALSA: soc-compress: add support to snd_compr_set_runtime_buffer()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From ba02eed9f300b6512181d526311d4e11aaa9714f Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 15 Nov 2018 18:13:20 +0000
Subject: [PATCH] ALSA: soc-compress: add support to
 snd_compr_set_runtime_buffer()

Existing compress offload code allocates data buffers using simple kmalloc,
however there are situations where these buffers have to be mapped
in smmu. So provide a way to set the runtime buffer by the driver itself,
simillar to what we do with pcm.

This patch adds support to set runtime dma buffer on compressed stream.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/compress_driver.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
index ea8c93bbb0e0..0cdc3999ecfa 100644
--- a/include/sound/compress_driver.h
+++ b/include/sound/compress_driver.h
@@ -23,6 +23,7 @@ struct snd_compr_ops;
  * struct snd_compr_runtime: runtime stream description
  * @state: stream state
  * @ops: pointer to DSP callbacks
+ * @dma_buffer_p: runtime dma buffer pointer
  * @buffer: pointer to kernel buffer, valid only when not in mmap mode or
  *	DSP doesn't implement copy
  * @buffer_size: size of the above buffer
@@ -37,6 +38,7 @@ struct snd_compr_ops;
 struct snd_compr_runtime {
 	snd_pcm_state_t state;
 	struct snd_compr_ops *ops;
+	struct snd_dma_buffer *dma_buffer_p;
 	void *buffer;
 	u64 buffer_size;
 	u32 fragment_size;
@@ -175,6 +177,23 @@ static inline void snd_compr_drain_notify(struct snd_compr_stream *stream)
 	wake_up(&stream->runtime->sleep);
 }
 
+/**
+ * snd_compr_set_runtime_buffer - Set the Compress runtime buffer
+ * @substream: compress substream to set
+ * @bufp: the buffer information, NULL to clear
+ *
+ * Copy the buffer information to runtime buffer when @bufp is non-NULL.
+ * Otherwise it clears the current buffer information.
+ */
+static inline void snd_compr_set_runtime_buffer(
+					struct snd_compr_stream *substream,
+					struct snd_dma_buffer *bufp)
+{
+	struct snd_compr_runtime *runtime = substream->runtime;
+
+	runtime->dma_buffer_p = bufp;
+}
+
 int snd_compr_stop_error(struct snd_compr_stream *stream,
 			 snd_pcm_state_t state);
 
-- 
2.19.0.rc2
