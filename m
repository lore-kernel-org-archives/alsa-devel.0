From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 3/7] ALSA: compress_core: Deconstify copy
	callback buffer
Date: Thu, 11 Apr 2013 19:00:41 +0100
Message-ID: <1365703245-20738-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1365703245-20738-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D8DBB26623E
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2013 20:09:59 +0200 (CEST)
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

The buffer passed to the copy callback should not be const because the
copy callback can be used for capture and playback.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
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
index f9b2197..d3f03f6 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -307,7 +307,7 @@ static int soc_compr_pointer(struct snd_compr_stream *cstream,
 }
 
 static int soc_compr_copy(struct snd_compr_stream *cstream,
-			  const char __user *buf, size_t count)
+			  char __user *buf, size_t count)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
-- 
1.7.2.5
