From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/3] ALSA: pcm: add 'applptr' event of
	tracepoint
Date: Sun, 11 Jun 2017 15:48:07 +0900
Message-ID: <20170611064808.30572-3-o-takashi@sakamocchi.jp>
References: <20170611064808.30572-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 5A935266A09
 for <alsa-devel@alsa-project.org>; Sun, 11 Jun 2017 08:48:13 +0200 (CEST)
In-Reply-To: <20170611064808.30572-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

In design of ALSA PCM core, both of hardware-side and application-side
position on PCM buffer are maintained as a part of information for
runtime of PCM substream. In a view of ALSA PCM application, these two
positions can be updated by executing ioctl(2) with some commands.

There's an event of tracepoint for hardware-side position; 'hwptr'.
On the other hand, no events for application-side position.

This commit adds a new event for this purpose; 'applptr'. When
the application-side position is changed in kernel space, this event
is probed with useful information for developers.

I note that the event is not probed for all of ALSA PCM applications,
because the application-side position is passively maintained in mmap
programming scenario. In this case, applications should be programmed
with ioctl(2) with SNDRV_PCM_IOCTL_SYNC_PTR to commit the application-side
position to kernel land when it operates any PCM frames. In read/write
programming scenario, this is needless. They're OK just to transfer any
PCM frames by ioctl(2) with SNDRV_PCM_IOCTL_[READ|WRITE][N/I]_FRAMES,
then stuffs in kernel land updates the application-side position and
the event is probed.

My additional note is lock acquisition. The event is probed under acquiring
PCM stream lock. This means that calculation in the event is free from
any hardware events.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_lib.c   |  4 ++++
 sound/core/pcm_trace.h | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index d82f1437667f..e73b6e4135f6 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -42,6 +42,7 @@
 #define trace_hwptr(substream, pos, in_interrupt)
 #define trace_xrun(substream)
 #define trace_hw_ptr_error(substream, reason)
+#define trace_applptr(substream, prev, curr)
 #endif
 
 static int fill_silence_frames(struct snd_pcm_substream *substream,
@@ -2119,6 +2120,9 @@ int pcm_lib_apply_appl_ptr(struct snd_pcm_substream *substream,
 			return ret;
 		}
 	}
+
+	trace_applptr(substream, old_appl_ptr, appl_ptr);
+
 	return 0;
 }
 
diff --git a/sound/core/pcm_trace.h b/sound/core/pcm_trace.h
index b63b654da5ff..e672368ab878 100644
--- a/sound/core/pcm_trace.h
+++ b/sound/core/pcm_trace.h
@@ -102,6 +102,44 @@ TRACE_EVENT(hw_ptr_error,
 		  __entry->number, __entry->reason)
 );
 
+TRACE_EVENT(applptr,
+	TP_PROTO(struct snd_pcm_substream *substream, snd_pcm_uframes_t prev, snd_pcm_uframes_t curr),
+	TP_ARGS(substream, prev, curr),
+	TP_STRUCT__entry(
+		__field( unsigned int, card )
+		__field( unsigned int, device )
+		__field( unsigned int, number )
+		__field( unsigned int, stream )
+		__field( snd_pcm_uframes_t, prev )
+		__field( snd_pcm_uframes_t, curr )
+		__field( snd_pcm_uframes_t, avail )
+		__field( snd_pcm_uframes_t, period_size )
+		__field( snd_pcm_uframes_t, buffer_size )
+	),
+	TP_fast_assign(
+		__entry->card = (substream)->pcm->card->number;
+		__entry->device = (substream)->pcm->device;
+		__entry->number = (substream)->number;
+		__entry->stream = (substream)->stream;
+		__entry->prev = (prev);
+		__entry->curr = (curr);
+		__entry->avail = (substream)->stream ? snd_pcm_capture_avail(substream->runtime) : snd_pcm_playback_avail(substream->runtime);
+		__entry->period_size = (substream)->runtime->period_size;
+		__entry->buffer_size = (substream)->runtime->buffer_size;
+	),
+	TP_printk("pcmC%dD%d%s/sub%d: prev=%lu, curr=%lu, avail=%lu, period=%lu, buf=%lu",
+		__entry->card,
+		__entry->device,
+		__entry->stream ? "c" : "p",
+		__entry->number,
+		__entry->prev,
+		__entry->curr,
+		__entry->avail,
+		__entry->period_size,
+		__entry->buffer_size
+	)
+);
+
 #endif /* _PCM_TRACE_H */
 
 /* This part must be outside protection */
-- 
2.11.0
