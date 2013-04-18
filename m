Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B7CF3264F06
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2013 12:03:16 +0200 (CEST)
Date: Thu, 18 Apr 2013 11:03:10 +0100
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Message-ID: <4a0d904a02cf5e87bcf788bc325c2dcd49f6a3c0.1366278354.git.rf@open
 source.wolfsonmicro.com>
References: <cover.1366278354.git.rf@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1366278354.git.rf@opensource.wolfsonmicro.com>
Subject: [alsa-devel] [PATCH 6/7] ALSA: compress_core: Remove unused
	hw_pointer
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

Only tested as far as build.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 include/sound/compress_driver.h |    1 -
 sound/core/compress_offload.c   |    2 --
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
index db8273a..2d7de96 100644
--- a/include/sound/compress_driver.h
+++ b/include/sound/compress_driver.h
@@ -56,7 +56,6 @@ struct snd_compr_runtime {
 	u64 buffer_size;
 	u32 fragment_size;
 	u32 fragments;
-	u64 hw_pointer;
 	u64 app_pointer;
 	u64 total_bytes_available;
 	u64 total_bytes_transferred;
diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 52a2765..36d7688 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -152,7 +152,6 @@ static int snd_compr_update_tstamp(struct snd_compr_stream *stream,
 	stream->ops->pointer(stream, tstamp);
 	pr_debug("dsp consumed till %d total %d bytes\n",
 		tstamp->byte_offset, tstamp->copied_total);
-	stream->runtime->hw_pointer = tstamp->byte_offset;
 	if (stream->direction == SND_COMPRESS_PLAYBACK)
 		stream->runtime->total_bytes_transferred = tstamp->copied_total;
 	else
@@ -657,7 +656,6 @@ static int snd_compr_stop(struct snd_compr_stream *stream)
 	if (!retval) {
 		stream->runtime->state = SNDRV_PCM_STATE_SETUP;
 		wake_up(&stream->runtime->sleep);
-		stream->runtime->hw_pointer = 0;
 		stream->runtime->app_pointer = 0;
 		stream->runtime->total_bytes_available = 0;
 		stream->runtime->total_bytes_transferred = 0;
-- 
1.7.2.5

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
