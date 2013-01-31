From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ALSA: core: don't return uninitialized
	snd_compr_tstamp
Date: Thu, 31 Jan 2013 10:37:12 +0800
Message-ID: <1359599832-6210-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 71344265115
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 03:37:25 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>

The snd_compr_update_tstamp() can only fill in the snd_compr_tstamp
if the codec implements the pointer() function. If that happened
the code was previously returning uninitialized garbage in the
tstamp because it wasn't initialized anywhere.

This change zero-fills the tstamp in the two places it is used
before calling snd_compr_update_tstamp(), and also has
snd_compr_update_tstamp() return an error indication if it
can't provide a tstamp. For the case of snd_compr_calc_avail()
it ignores this error because we still need to return info on
the available buffer space even if we can't provide tstamp
info - when the tstamp is not valid all fields are now
guaranteed to be zero.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/core/compress_offload.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index ad11dc9..2d62068 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -144,16 +144,17 @@ static int snd_compr_free(struct inode *inode, struct file *f)
 	return 0;
 }
 
-static void snd_compr_update_tstamp(struct snd_compr_stream *stream,
+static int snd_compr_update_tstamp(struct snd_compr_stream *stream,
 		struct snd_compr_tstamp *tstamp)
 {
 	if (!stream->ops->pointer)
-		return;
+		return -ENOTSUPP;
 	stream->ops->pointer(stream, tstamp);
 	pr_debug("dsp consumed till %d total %d bytes\n",
 		tstamp->byte_offset, tstamp->copied_total);
 	stream->runtime->hw_pointer = tstamp->byte_offset;
 	stream->runtime->total_bytes_transferred = tstamp->copied_total;
+	return 0;
 }
 
 static size_t snd_compr_calc_avail(struct snd_compr_stream *stream,
@@ -161,7 +162,9 @@ static size_t snd_compr_calc_avail(struct snd_compr_stream *stream,
 {
 	long avail_calc; /*this needs to be signed variable */
 
+	memset(avail, 0, sizeof(*avail));
 	snd_compr_update_tstamp(stream, &avail->tstamp);
+	/* Still need to return avail even if tstamp can't be filled in */
 
 	/* FIXME: This needs to be different for capture stream,
 	   available is # of compressed data, for playback it's
@@ -517,11 +520,14 @@ out:
 static inline int
 snd_compr_tstamp(struct snd_compr_stream *stream, unsigned long arg)
 {
-	struct snd_compr_tstamp tstamp;
+	struct snd_compr_tstamp tstamp = {0};
+	int ret;
 
-	snd_compr_update_tstamp(stream, &tstamp);
-	return copy_to_user((struct snd_compr_tstamp __user *)arg,
-		&tstamp, sizeof(tstamp)) ? -EFAULT : 0;
+	ret = snd_compr_update_tstamp(stream, &tstamp);
+	if (ret == 0)
+		ret = copy_to_user((struct snd_compr_tstamp __user *)arg,
+			&tstamp, sizeof(tstamp)) ? -EFAULT : 0;
+	return ret;
 }
 
 static int snd_compr_pause(struct snd_compr_stream *stream)
-- 
1.7.10.4
