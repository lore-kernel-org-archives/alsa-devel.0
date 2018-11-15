From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 1/5] ALSA: soc-compress: add support to snd_compr_set_runtime_buffer()
Date: Thu, 15 Nov 2018 18:13:20 +0000
Message-ID: <20181115181324.26784-2-srinivas.kandagatla@linaro.org>
References: <20181115181324.26784-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181115181324.26784-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, vkoul@kernel.org
Cc: alsa-devel@alsa-project.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org, bgoswami@codeaurora.org, rohitkr@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.com, devicetree@vger.kernel.org, srini@kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

Existing compress offload code allocates data buffers using simple kmalloc,
however there are situations where these buffers have to be mapped
in smmu. So provide a way to set the runtime buffer by the driver itself,
simillar to what we do with pcm.

This patch adds support to set runtime dma buffer on compressed stream.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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
2.19.1
