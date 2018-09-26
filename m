From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 2/5] ALSA: compress: make use of runtime
	buffer for copy
Date: Wed, 26 Sep 2018 11:23:46 +0100
Message-ID: <20180926102349.23481-3-srinivas.kandagatla@linaro.org>
References: <20180926102349.23481-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F5D4267730
 for <alsa-devel@alsa-project.org>; Wed, 26 Sep 2018 12:25:58 +0200 (CEST)
Received: by mail-wm1-f65.google.com with SMTP id s12-v6so1694395wmc.0
 for <alsa-devel@alsa-project.org>; Wed, 26 Sep 2018 03:25:58 -0700 (PDT)
In-Reply-To: <20180926102349.23481-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.com, linux-kernel@vger.kernel.org, vkoul@kernel.org, rohitkr@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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
2.19.0
