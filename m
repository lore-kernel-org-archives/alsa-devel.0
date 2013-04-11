From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 7/7] ALSA: compress_core: Rework writes to use
	cumulative values
Date: Thu, 11 Apr 2013 19:00:45 +0100
Message-ID: <1365703245-20738-8-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1365703245-20738-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 22FB326505A
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2013 20:10:05 +0200 (CEST)
In-Reply-To: <1365703245-20738-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

This patch reworks the writes to use cumulative values thus making the
app_pointer unecessary and removing it.

Only tested as far as build.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
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
index 87f944c..38d42af 100644
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
