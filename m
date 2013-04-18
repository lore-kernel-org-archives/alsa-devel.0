Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5D56C264F06
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2013 11:59:28 +0200 (CEST)
Date: Thu, 18 Apr 2013 10:59:23 +0100
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Message-ID: <345f9ee1b69146d031316280ec21f0ed599abc07.1366278354.git.rf@open
 source.wolfsonmicro.com>
References: <cover.1366278354.git.rf@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1366278354.git.rf@opensource.wolfsonmicro.com>
Subject: [alsa-devel] [PATCH 1/7] ALSA: compress_core: Update calc_avail to
	use	cumulative values
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
Cc: girdwood@gmail.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, ckeepax@opensource.wolfsonmicro.com, rf@opensource.wolfsonmicro.com
List-ID: <alsa-devel@alsa-project.org>

The app_pointer is managed locally by the compress core for memory
mapped DSPs but for DSPs that are not memory mapped this would have to
be manually updated from within the DSP driver itself, which is hardly
very idiomatic.

This patch switches to using the cumulative values to calculate the
available buffer space because these are already gracefully passed out
of the DSP driver to the compress core and otherwise should be
functionally equivalent.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/core/compress_offload.c |   23 +++++------------------
 1 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index c84abc8..27bd81a 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -160,8 +160,6 @@ static int snd_compr_update_tstamp(struct snd_compr_stream *stream,
 static size_t snd_compr_calc_avail(struct snd_compr_stream *stream,
 		struct snd_compr_avail *avail)
 {
-	long avail_calc; /*this needs to be signed variable */
-
 	memset(avail, 0, sizeof(*avail));
 	snd_compr_update_tstamp(stream, &avail->tstamp);
 	/* Still need to return avail even if tstamp can't be filled in */
@@ -184,22 +182,11 @@ static size_t snd_compr_calc_avail(struct snd_compr_stream *stream,
 		return stream->runtime->buffer_size;
 	}
 
-	/* FIXME: this routine isn't consistent, in one test we use
-	 * cumulative values and in the other byte offsets. Do we
-	 * really need the byte offsets if the cumulative values have
-	 * been updated? In the PCM interface app_ptr and hw_ptr are
-	 * already cumulative */
-
-	avail_calc = stream->runtime->buffer_size -
-		(stream->runtime->app_pointer - stream->runtime->hw_pointer);
-	pr_debug("calc avail as %ld, app_ptr %lld, hw+ptr %lld\n", avail_calc,
-			stream->runtime->app_pointer,
-			stream->runtime->hw_pointer);
-	if (avail_calc >= stream->runtime->buffer_size)
-		avail_calc -= stream->runtime->buffer_size;
-	pr_debug("ret avail as %ld\n", avail_calc);
-	avail->avail = avail_calc;
-	return avail_calc;
+	avail->avail = stream->runtime->buffer_size -
+		(stream->runtime->total_bytes_available -
+		 stream->runtime->total_bytes_transferred);
+	pr_debug("ret avail as %lld\n", avail->avail);
+	return avail->avail;
 }
 
 static inline size_t snd_compr_get_avail(struct snd_compr_stream *stream)
-- 
1.7.2.5

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
