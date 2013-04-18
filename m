Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9F7E6265E81
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2013 12:03:51 +0200 (CEST)
Date: Thu, 18 Apr 2013 11:03:46 +0100
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Message-ID: <ff90ca8a2f4f3ce2ddc8206112ce49ace1ff23e4.1366278354.git.rf@open
 source.wolfsonmicro.com>
References: <cover.1366278354.git.rf@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1366278354.git.rf@opensource.wolfsonmicro.com>
Subject: [alsa-devel] [PATCH 7/7] ALSA: compress_core: Rework writes to use
	cumulative	values
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, tiwai@suse.de, vinod.koul@intel.com
Cc: girdwood@gmail.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, ckeepax@opensource.wolfsonmicro.com
List-ID: <alsa-devel@alsa-project.org>

This patch reworks the writes to use cumulative values thus making the
app_pointer unecessary and removing it.

Only tested as far as build.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 include/sound/compress_driver.h |    1 -
 sound/core/compress_offload.c   |   18 +++++++++++-------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
index 2d7de96..9031a26 100644
--- a/include/sound/compress_driver.h
+++ b/include/sound/compress_driver.h
@@ -56,7 +56,6 @@ struct snd_compr_runtime {
 	u64 buffer_size;
 	u32 fragment_size;
 	u32 fragments;
-	u64 app_pointer;
 	u64 total_bytes_available;
 	u64 total_bytes_transferred;
 	wait_queue_head_t sleep;
diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 36d7688..7941ace 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -28,11 +28,13 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/list.h>
+#include <linux/math64.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/poll.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
+#include <linux/types.h>
 #include <linux/uio.h>
 #include <linux/uaccess.h>
 #include <linux/module.h>
@@ -223,21 +225,24 @@ static int snd_compr_write_data(struct snd_compr_stream *stream,
 	void *dstn;
 	size_t copy;
 	struct snd_compr_runtime *runtime = stream->runtime;
+	/* 64-bit Modulus */
+	u64 app_pointer = div64_u64(runtime->total_bytes_available,
+				    runtime->buffer_size);
+	app_pointer = runtime->total_bytes_available -
+		      (app_pointer * runtime->buffer_size);
 
-	dstn = runtime->buffer + runtime->app_pointer;
+	dstn = runtime->buffer + app_pointer;
 	pr_debug("copying %ld at %lld\n",
-			(unsigned long)count, runtime->app_pointer);
-	if (count < runtime->buffer_size - runtime->app_pointer) {
+			(unsigned long)count, app_pointer);
+	if (count < runtime->buffer_size - app_pointer) {
 		if (copy_from_user(dstn, buf, count))
 			return -EFAULT;
-		runtime->app_pointer += count;
 	} else {
-		copy = runtime->buffer_size - runtime->app_pointer;
+		copy = runtime->buffer_size - app_pointer;
 		if (copy_from_user(dstn, buf, copy))
 			return -EFAULT;
 		if (copy_from_user(runtime->buffer, buf + copy, count - copy))
 			return -EFAULT;
-		runtime->app_pointer = count - copy;
 	}
 	/* if DSP cares, let it know data has been written */
 	if (stream->ops->ack)
@@ -656,7 +661,6 @@ static int snd_compr_stop(struct snd_compr_stream *stream)
 	if (!retval) {
 		stream->runtime->state = SNDRV_PCM_STATE_SETUP;
 		wake_up(&stream->runtime->sleep);
-		stream->runtime->app_pointer = 0;
 		stream->runtime->total_bytes_available = 0;
 		stream->runtime->total_bytes_transferred = 0;
 	}
-- 
1.7.2.5

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
