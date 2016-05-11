From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: firewire-lib: permit to flush queued
	packets only in process context for better PCM period granularity
Date: Thu, 12 May 2016 02:17:39 +0900
Message-ID: <1462987059-10020-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id BF4A72607C8
 for <alsa-devel@alsa-project.org>; Wed, 11 May 2016 19:17:42 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

These three commits were merged to improve PCM pointer granularity.
commit 76fb87894828 ("ALSA: firewire-lib: taskletize the snd_pcm_period_elapsed() call")
commit e9148dddc3c7 ("ALSA: firewire-lib: flush completed packets when reading PCM position")
commit 92b862c7d685 ("ALSA: firewire-lib: optimize packet flushing")

The point of them is to handle queued packets not only in software IRQ
context of IR/IT contexts, but also in process context. As a result of
handling packets, period tasklet is scheduled when acrossing PCM period
boundary. This is to prevent recursive call of
'struct snd_pcm_ops.pointer()' in the same context.

When the pointer callback is executed in the process context, it's
better to avoid the second callback in the software IRQ context. The
software IRQ context runs immediately after scheduled in the process
context because few packets are queued yet.

For the aim, 'pointer_flush' is used, however it causes a race condition
between the process context and software IRQ context of IR/IT contexts.

Practically, this race is not so critical because it influences process
context to skip flushing queued packet and to get worse granularity of
PCM pointer. The race condition is quite rare but it should be improved
for stable service.

The similar effect can be achieved by using 'in_interrupt()' macro. This
commit obsoletes 'pointer_flush' with it.

Acked-by: Clemens Ladisch <clemens@ladisch.de>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 23 +++++++++++++++++------
 sound/firewire/amdtp-stream.h |  1 -
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 830a95c..024ab7f 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -251,7 +251,6 @@ void amdtp_stream_pcm_prepare(struct amdtp_stream *s)
 	tasklet_kill(&s->period_tasklet);
 	s->pcm_buffer_pointer = 0;
 	s->pcm_period_pointer = 0;
-	s->pointer_flush = true;
 }
 EXPORT_SYMBOL(amdtp_stream_pcm_prepare);
 
@@ -356,7 +355,6 @@ static void update_pcm_pointers(struct amdtp_stream *s,
 	s->pcm_period_pointer += frames;
 	if (s->pcm_period_pointer >= pcm->runtime->period_size) {
 		s->pcm_period_pointer -= pcm->runtime->period_size;
-		s->pointer_flush = false;
 		tasklet_hi_schedule(&s->period_tasklet);
 	}
 }
@@ -803,11 +801,24 @@ EXPORT_SYMBOL(amdtp_stream_start);
  */
 unsigned long amdtp_stream_pcm_pointer(struct amdtp_stream *s)
 {
-	/* this optimization is allowed to be racy */
-	if (s->pointer_flush && amdtp_stream_running(s))
+	/*
+	 * This function is called in software IRQ context of period_tasklet or
+	 * process context.
+	 *
+	 * When the software IRQ context was scheduled by software IRQ context
+	 * of IR/IT contexts, queued packets were already handled. Therefore,
+	 * no need to flush the queue in buffer anymore.
+	 *
+	 * When the process context reach here, some packets will be already
+	 * queued in the buffer. These packets should be handled immediately
+	 * to keep better granularity of PCM pointer.
+	 *
+	 * Later, the process context will sometimes schedules software IRQ
+	 * context of the period_tasklet. Then, no need to flush the queue by
+	 * the same reason as described for IR/IT contexts.
+	 */
+	if (!in_interrupt() && amdtp_stream_running(s))
 		fw_iso_context_flush_completions(s->context);
-	else
-		s->pointer_flush = true;
 
 	return ACCESS_ONCE(s->pcm_buffer_pointer);
 }
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index 349c405..c1bc7fa 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -126,7 +126,6 @@ struct amdtp_stream {
 	struct tasklet_struct period_tasklet;
 	unsigned int pcm_buffer_pointer;
 	unsigned int pcm_period_pointer;
-	bool pointer_flush;
 
 	/* To wait for first packet. */
 	bool callbacked;
-- 
2.7.4
