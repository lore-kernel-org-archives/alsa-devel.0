From: Mark Brown <broonie@kernel.org>
Subject: Applied "ALSA: compress: make use of runtime buffer
	for copy" to the asoc tree
Date: Fri, 14 Dec 2018 12:44:18 +0000 (GMT)
Message-ID: <20181214124418.B877711258A2@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 526BA267A76
 for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2018 13:44:19 +0100 (CET)
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

   ALSA: compress: make use of runtime buffer for copy

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

>From d00f749b00f7802bf944688ad2971455f84fdacb Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 15 Nov 2018 18:13:21 +0000
Subject: [PATCH] ALSA: compress: make use of runtime buffer for copy

Default copy function uses kmalloc to allocate buffers, lets check
if the runtime buffers are setup before making this allocations.
This can be useful if the buffers are dma buffers.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.19.0.rc2
