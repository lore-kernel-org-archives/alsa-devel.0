From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/3] ALSA: pcm: use %s instead of %c for format
	of PCM buffer tracepoints
Date: Sun, 11 Jun 2017 15:48:08 +0900
Message-ID: <20170611064808.30572-4-o-takashi@sakamocchi.jp>
References: <20170611064808.30572-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 5CEB4266A0A
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

As long as I know, in userspace, '%c' format on printing format for
tracepoint is replaced with '>c<' by existent tracing program; i.g.
'perf-trace' and 'trace-cmd'. This is inconvenient.

This commit replaces the format with '%s'. The length of letters in the
format string is not changed, thus this commit doesn't increase object
size.

In theory, I should work for improvements of these tracing programs, but
here I'd like to save my time to work for the other projects.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_trace.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/core/pcm_trace.h b/sound/core/pcm_trace.h
index e672368ab878..3ddec1b8ae46 100644
--- a/sound/core/pcm_trace.h
+++ b/sound/core/pcm_trace.h
@@ -34,9 +34,9 @@ TRACE_EVENT(hwptr,
 		__entry->old_hw_ptr = (substream)->runtime->status->hw_ptr;
 		__entry->hw_ptr_base = (substream)->runtime->hw_ptr_base;
 	),
-	TP_printk("pcmC%dD%d%c/sub%d: %s: pos=%lu, old=%lu, base=%lu, period=%lu, buf=%lu",
+	TP_printk("pcmC%dD%d%s/sub%d: %s: pos=%lu, old=%lu, base=%lu, period=%lu, buf=%lu",
 		  __entry->card, __entry->device,
-		  __entry->stream == SNDRV_PCM_STREAM_PLAYBACK ? 'p' : 'c',
+		  __entry->stream == SNDRV_PCM_STREAM_PLAYBACK ? "p" : "c",
 		  __entry->number,
 		  __entry->in_interrupt ? "IRQ" : "POS",
 		  (unsigned long)__entry->pos,
@@ -69,9 +69,9 @@ TRACE_EVENT(xrun,
 		__entry->old_hw_ptr = (substream)->runtime->status->hw_ptr;
 		__entry->hw_ptr_base = (substream)->runtime->hw_ptr_base;
 	),
-	TP_printk("pcmC%dD%d%c/sub%d: XRUN: old=%lu, base=%lu, period=%lu, buf=%lu",
+	TP_printk("pcmC%dD%d%s/sub%d: XRUN: old=%lu, base=%lu, period=%lu, buf=%lu",
 		  __entry->card, __entry->device,
-		  __entry->stream == SNDRV_PCM_STREAM_PLAYBACK ? 'p' : 'c',
+		  __entry->stream == SNDRV_PCM_STREAM_PLAYBACK ? "p" : "c",
 		  __entry->number,
 		  (unsigned long)__entry->old_hw_ptr,
 		  (unsigned long)__entry->hw_ptr_base,
@@ -96,9 +96,9 @@ TRACE_EVENT(hw_ptr_error,
 		__entry->stream = (substream)->stream;
 		__entry->reason = (why);
 	),
-	TP_printk("pcmC%dD%d%c/sub%d: ERROR: %s",
+	TP_printk("pcmC%dD%d%s/sub%d: ERROR: %s",
 		  __entry->card, __entry->device,
-		  __entry->stream == SNDRV_PCM_STREAM_PLAYBACK ? 'p' : 'c',
+		  __entry->stream == SNDRV_PCM_STREAM_PLAYBACK ? "p" : "c",
 		  __entry->number, __entry->reason)
 );
 
-- 
2.11.0
