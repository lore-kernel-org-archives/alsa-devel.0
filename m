Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DCF0D262632
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2013 12:01:08 +0200 (CEST)
Date: Thu, 18 Apr 2013 11:01:03 +0100
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Message-ID: <18b1be3cc313e7e72bb2c025320d14d48936f943.1366278354.git.rf@open
 source.wolfsonmicro.com>
References: <cover.1366278354.git.rf@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1366278354.git.rf@opensource.wolfsonmicro.com>
Subject: [alsa-devel] [PATCH 2/7] ALSA: compress_core: Calculate avail
	correctly for	capture streams
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

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/core/compress_offload.c |   29 ++++++++++++++++++-----------
 1 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 27bd81a..1f69863 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -153,7 +153,10 @@ static int snd_compr_update_tstamp(struct snd_compr_stream *stream,
 	pr_debug("dsp consumed till %d total %d bytes\n",
 		tstamp->byte_offset, tstamp->copied_total);
 	stream->runtime->hw_pointer = tstamp->byte_offset;
-	stream->runtime->total_bytes_transferred = tstamp->copied_total;
+	if (stream->direction == SND_COMPRESS_PLAYBACK)
+		stream->runtime->total_bytes_transferred = tstamp->copied_total;
+	else
+		stream->runtime->total_bytes_available = tstamp->copied_total;
 	return 0;
 }
 
@@ -164,12 +167,9 @@ static size_t snd_compr_calc_avail(struct snd_compr_stream *stream,
 	snd_compr_update_tstamp(stream, &avail->tstamp);
 	/* Still need to return avail even if tstamp can't be filled in */
 
-	/* FIXME: This needs to be different for capture stream,
-	   available is # of compressed data, for playback it's
-	   remainder of buffer */
-
 	if (stream->runtime->total_bytes_available == 0 &&
-			stream->runtime->state == SNDRV_PCM_STATE_SETUP) {
+			stream->runtime->state == SNDRV_PCM_STATE_SETUP &&
+			stream->direction == SND_COMPRESS_PLAYBACK) {
 		pr_debug("detected init and someone forgot to do a write\n");
 		return stream->runtime->buffer_size;
 	}
@@ -178,13 +178,20 @@ static size_t snd_compr_calc_avail(struct snd_compr_stream *stream,
 			stream->runtime->total_bytes_transferred);
 	if (stream->runtime->total_bytes_available ==
 				stream->runtime->total_bytes_transferred) {
-		pr_debug("both pointers are same, returning full avail\n");
-		return stream->runtime->buffer_size;
+		if (stream->direction == SND_COMPRESS_PLAYBACK) {
+			pr_debug("both pointers are same, returning full avail\n");
+			return stream->runtime->buffer_size;
+		} else {
+			pr_debug("both pointers are same, returning no avail\n");
+			return 0;
+		}
 	}
 
-	avail->avail = stream->runtime->buffer_size -
-		(stream->runtime->total_bytes_available -
-		 stream->runtime->total_bytes_transferred);
+	avail->avail = stream->runtime->total_bytes_available -
+			stream->runtime->total_bytes_transferred;
+	if (stream->direction == SND_COMPRESS_PLAYBACK)
+		avail->avail = stream->runtime->buffer_size - avail->avail;
+
 	pr_debug("ret avail as %lld\n", avail->avail);
 	return avail->avail;
 }
-- 
1.7.2.5

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
