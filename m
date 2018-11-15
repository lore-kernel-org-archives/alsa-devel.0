From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 2/5] ALSA: compress: make use of runtime buffer for copy
Date: Thu, 15 Nov 2018 18:13:21 +0000
Message-ID: <20181115181324.26784-3-srinivas.kandagatla@linaro.org>
References: <20181115181324.26784-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181115181324.26784-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, vkoul@kernel.org
Cc: alsa-devel@alsa-project.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org, bgoswami@codeaurora.org, rohitkr@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.com, devicetree@vger.kernel.org, srini@kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

Default copy function uses kmalloc to allocate buffers, lets check
if the runtime buffers are setup before making this allocations.
This can be useful if the buffers are dma buffers.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/core/compress_offload.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 26b5e245b074..a5b09e75e787 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -171,7 +171,8 @@ static int snd_compr_free(struct inode *inode, struct file *f)
 	}
 
 	data->stream.ops->free(&data->stream);
-	kfree(data->stream.runtime->buffer);
+	if (!data->stream.runtime->dma_buffer_p)
+		kfree(data->stream.runtime->buffer);
 	kfree(data->stream.runtime);
 	kfree(data);
 	return 0;
@@ -505,7 +506,7 @@ static int snd_compr_allocate_buffer(struct snd_compr_stream *stream,
 		struct snd_compr_params *params)
 {
 	unsigned int buffer_size;
-	void *buffer;
+	void *buffer = NULL;
 
 	buffer_size = params->buffer.fragment_size * params->buffer.fragments;
 	if (stream->ops->copy) {
@@ -514,7 +515,18 @@ static int snd_compr_allocate_buffer(struct snd_compr_stream *stream,
 		 * the data from core
 		 */
 	} else {
-		buffer = kmalloc(buffer_size, GFP_KERNEL);
+		if (stream->runtime->dma_buffer_p) {
+
+			if (buffer_size > stream->runtime->dma_buffer_p->bytes)
+				dev_err(&stream->device->dev,
+						"Not enough DMA buffer");
+			else
+				buffer = stream->runtime->dma_buffer_p->area;
+
+		} else {
+			buffer = kmalloc(buffer_size, GFP_KERNEL);
+		}
+
 		if (!buffer)
 			return -ENOMEM;
 	}
-- 
2.19.1
