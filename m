From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/3] ALSA: pcm: use friendly name for id of PCM
	substream in trace print
Date: Fri,  9 Jun 2017 21:46:50 +0900
Message-ID: <20170609124650.19989-4-o-takashi@sakamocchi.jp>
References: <20170609124650.19989-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 19621267637
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 14:47:00 +0200 (CEST)
In-Reply-To: <20170609124650.19989-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use the same print format of snd_pcm_debug_name() for userspace tracing
program.

Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/pcm_param_trace.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/core/pcm_param_trace.h b/sound/core/pcm_param_trace.h
index 872922326b38..86c8d658a25c 100644
--- a/sound/core/pcm_param_trace.h
+++ b/sound/core/pcm_param_trace.h
@@ -49,11 +49,11 @@ TRACE_EVENT(hw_mask_param,
 		memcpy(__entry->prev_bits, prev->bits, sizeof(__u32) * 8);
 		memcpy(__entry->curr_bits, curr->bits, sizeof(__u32) * 8);
 	),
-	TP_printk("%d,%d,%d,%d %03d/%03d %s %08x%08x%08x%08x %08x%08x%08x%08x",
+	TP_printk("pcmC%dD%d%s:%d %03d/%03d %s %08x%08x%08x%08x %08x%08x%08x%08x",
 		  __entry->card,
 		  __entry->device,
+		  __entry->direction ? "c" : "p",
 		  __entry->subdevice,
-		  __entry->direction,
 		  __entry->index,
 		  __entry->total,
 		  __print_symbolic(__entry->type, hw_param_labels),
@@ -109,11 +109,11 @@ TRACE_EVENT(hw_interval_param,
 		__entry->curr_integer = curr->integer;
 		__entry->curr_empty = curr->empty;
 	),
-	TP_printk("%d,%d,%d,%d %03d/%03d %s %d %d %s%u %u%s %d %d %s%u %u%s",
+	TP_printk("pcmC%dD%d%s:%d %03d/%03d %s %d %d %s%u %u%s %d %d %s%u %u%s",
 		  __entry->card,
 		  __entry->device,
+		  __entry->direction ? "c" : "p",
 		  __entry->subdevice,
-		  __entry->direction,
 		  __entry->index,
 		  __entry->total,
 		  __print_symbolic(__entry->type, hw_param_labels),
-- 
2.11.0
