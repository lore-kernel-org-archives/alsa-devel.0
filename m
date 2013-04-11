From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 6/7] ALSA: compress_core: Remove unused
	hw_pointer
Date: Thu, 11 Apr 2013 19:00:44 +0100
Message-ID: <1365703245-20738-7-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1365703245-20738-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0369026623F
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2013 20:10:04 +0200 (CEST)
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

Only tested as far as build.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
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
index d0fc9a1..87f944c 100644
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
