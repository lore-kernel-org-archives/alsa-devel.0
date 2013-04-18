Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A1862265E6D
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2013 12:01:43 +0200 (CEST)
Date: Thu, 18 Apr 2013 11:01:38 +0100
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Message-ID: <51225987edebdf3abc12d23aeb163ba317415062.1366278354.git.rf@open
 source.wolfsonmicro.com>
References: <cover.1366278354.git.rf@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1366278354.git.rf@opensource.wolfsonmicro.com>
Subject: [alsa-devel] [PATCH 3/7] ALSA: compress_core: Deconstify copy
	callback buffer
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

The buffer passed to the copy callback should not be const because the
copy callback can be used for capture and playback.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 include/sound/compress_driver.h |    2 +-
 sound/core/compress_offload.c   |    8 +++++---
 sound/soc/soc-compress.c        |    2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
index ff6c741..db8273a 100644
--- a/include/sound/compress_driver.h
+++ b/include/sound/compress_driver.h
@@ -121,7 +121,7 @@ struct snd_compr_ops {
 	int (*trigger)(struct snd_compr_stream *stream, int cmd);
 	int (*pointer)(struct snd_compr_stream *stream,
 			struct snd_compr_tstamp *tstamp);
-	int (*copy)(struct snd_compr_stream *stream, const char __user *buf,
+	int (*copy)(struct snd_compr_stream *stream, char __user *buf,
 		       size_t count);
 	int (*mmap)(struct snd_compr_stream *stream,
 			struct vm_area_struct *vma);
diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 1f69863..52ca4cc 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -272,10 +272,12 @@ static ssize_t snd_compr_write(struct file *f, const char __user *buf,
 	if (avail > count)
 		avail = count;
 
-	if (stream->ops->copy)
-		retval = stream->ops->copy(stream, buf, avail);
-	else
+	if (stream->ops->copy) {
+		char __user* cbuf = (char __user*)buf;
+		retval = stream->ops->copy(stream, cbuf, avail);
+	} else {
 		retval = snd_compr_write_data(stream, buf, avail);
+	}
 	if (retval > 0)
 		stream->runtime->total_bytes_available += retval;
 
diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 29093a3..da83e56 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -315,7 +315,7 @@ static int soc_compr_pointer(struct snd_compr_stream *cstream,
 }
 
 static int soc_compr_copy(struct snd_compr_stream *cstream,
-			  const char __user *buf, size_t count)
+			  char __user *buf, size_t count)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
-- 
1.7.2.5

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
