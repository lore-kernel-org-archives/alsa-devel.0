From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ALSA: compress_core: Split copy into
	seperate read and write callbacks
Date: Wed,  3 Apr 2013 13:13:28 +0100
Message-ID: <1364991209-24653-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1364991209-24653-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AD7DC265CD8
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 14:22:36 +0200 (CEST)
In-Reply-To: <1364991209-24653-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The compress API for non-memory mapped DSPs shares a copy callback for
both read and write, however the file operation of write passes a const
buffer. Thus we can't maintain const correctness for the copy callback
and support both read and write.

This patch seperates the read and write callbacks in the compressed API.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 include/sound/compress_driver.h |    8 ++++++--
 sound/core/compress_offload.c   |    6 +++---
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
index ff6c741..4c64dd1 100644
--- a/include/sound/compress_driver.h
+++ b/include/sound/compress_driver.h
@@ -99,7 +99,9 @@ struct snd_compr_stream {
  * @trigger: Trigger operations like start, pause, resume, drain, stop.
  * This callback is mandatory
  * @pointer: Retrieve current h/w pointer information. Mandatory
- * @copy: Copy the compressed data to/from userspace, Optional
+ * @write: Copy the compressed data from userspace, Optional
+ * Can't be implemented if DSP supports mmap
+ * @read: Copy the compressed data to userspace, Optional
  * Can't be implemented if DSP supports mmap
  * @mmap: DSP mmap method to mmap DSP memory
  * @ack: Ack for DSP when data is written to audio buffer, Optional
@@ -121,7 +123,9 @@ struct snd_compr_ops {
 	int (*trigger)(struct snd_compr_stream *stream, int cmd);
 	int (*pointer)(struct snd_compr_stream *stream,
 			struct snd_compr_tstamp *tstamp);
-	int (*copy)(struct snd_compr_stream *stream, const char __user *buf,
+	int (*write)(struct snd_compr_stream *stream, const char __user *buf,
+		       size_t count);
+	int (*read)(struct snd_compr_stream *stream, char __user *buf,
 		       size_t count);
 	int (*mmap)(struct snd_compr_stream *stream,
 			struct vm_area_struct *vma);
diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 27bd81a..78c6f97 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -265,8 +265,8 @@ static ssize_t snd_compr_write(struct file *f, const char __user *buf,
 	if (avail > count)
 		avail = count;
 
-	if (stream->ops->copy)
-		retval = stream->ops->copy(stream, buf, avail);
+	if (stream->ops->write)
+		retval = stream->ops->write(stream, buf, avail);
 	else
 		retval = snd_compr_write_data(stream, buf, avail);
 	if (retval > 0)
@@ -403,7 +403,7 @@ static int snd_compr_allocate_buffer(struct snd_compr_stream *stream,
 	void *buffer;
 
 	buffer_size = params->buffer.fragment_size * params->buffer.fragments;
-	if (stream->ops->copy) {
+	if (stream->ops->write) {
 		buffer = NULL;
 		/* if copy is defined the driver will be required to copy
 		 * the data from core
-- 
1.7.2.5
