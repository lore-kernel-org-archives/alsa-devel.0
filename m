From: Henrik Eriksson <henrik.eriksson@axis.com>
Subject: [RFC PATCH] ALSA: core: do not update tstamp when hw
 ptr has not moved
Date: Thu, 16 Nov 2017 13:43:57 +0100
Message-ID: <20171116124349.GA21810@lnxhenriken2.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id F2293266D7D
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 13:43:58 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hello

This reverts a change that was part of a larger commit.  That change
broke timestamps in some application code for us as outlined in the log,
and reverting it obviously fixes this.  Since the original change did
not explain why the behaviour was modified I can't speak for the effects
on that use case.

Regards,
/henrik
>8------------------------------------------------------8<
Commit 3179f62001880e588e229db3006a59ad87b7792a ("ALSA: core: add
.get_time_info") made an undocumented change to the behaviour of the
PCM runtime tstamp.  Prior to this change the tstamp was not updated
by snd_pcm_update_hw_ptr0() unless the hw ptr had moved, after this
change the tstamp is always updated.

For an application, using alsa-lib, doing snd_pcm_readi() followed by
snd_pcm_status() to estimate the age of the read samples by subtracting
status->avail * [sample rate] from status->tstamp this change degraded
the accuracy of that estimate on devices where the pcm hw does not
provide a granular hw pointer.  On a device using
soc-generic-dmaengine-pcm.c and a dma-engine with residue_granularity
DMA_RESIDUE_GRANULARITY_DESCRIPTOR the accuracy of the estimate depended
on the latency between the PCM hw completing a period and when the
driver called snd_pcm_period_elapsed() to notify ALSA core, typically
determined by interrupt handling latency.  After this change the
accuracy of the estimate is determined by the latency between the PCM hw
completing a period and the application calling snd_pcm_status(),
determined by the scheduling of the application process.

Revert the part of commit 3179f62001880e588e229db3006a59ad87b7792a
("ALSA: core: add .get_time_info") that changed be behaviour of
snd_pcm_update_hw_ptr0() when the PCM hw pointer has not moved.

Fixes: 3179f6200188 ("ALSA: core: add .get_time_info")
Signed-off-by: Henrik Eriksson <henrik.eriksson@axis.com>
---
 sound/core/pcm_lib.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index a93a4235a332..2fbaf9a974cc 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -437,10 +437,8 @@ static int snd_pcm_update_hw_ptr0(struct snd_pcm_substream *substream,
 	}
 
  no_delta_check:
-	if (runtime->status->hw_ptr == new_hw_ptr) {
-		update_audio_tstamp(substream, &curr_tstamp, &audio_tstamp);
+	if (runtime->status->hw_ptr == new_hw_ptr)
 		return 0;
-	}
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
 	    runtime->silence_size > 0)
-- 
2.11.0


-- 
henrik eriksson
fixed box cameras firmware, base video products, axis communications ab
