From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH] ALSA: firewire-lib: permit process
	context only to flush queued packets for better PCM period
	granularity
Date: Sat,  7 May 2016 21:46:36 +0900
Message-ID: <1462625196-3640-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E101260431
 for <alsa-devel@alsa-project.org>; Sat,  7 May 2016 14:46:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

Could I request your comment to this patch? It is to solve a race condition,
but the condition is quite rare. Practically, it might have a less meanings,
except for better program.

And I think there's another race condition against processing each packets
by calling out/in_stream_callback(), but I cannot observe the race. Software
IRQ contexts of IR/IT contexts and process contexts are under the race
condition, however I can see no problems related to it in my several trials
in multi-core machine. I have no idea about the reason that packet sequence
is processed correctly between the software IRQ contexts and the process
contexts without any lock primitives. Do you have some ideas about it?


Regards

Takashi Sakamoto

----- 8< -----

Subject: ALSA: firewire-lib: permit process context only to flush queued
 packets for better PCM period granularity

These three commits were merged to improve PCM pointer granularity.
commit 76fb87894828 ("ALSA: firewire-lib: taskletize the snd_pcm_period_elapsed() call")
commit e9148dddc3c7 ("ALSA: firewire-lib: flush completed packets when reading PCM position")
commit 92b862c7d685 ("ALSA: firewire-lib: optimize packet flushing")

The point of them is to handle queued packets not only in software IRQ
context of IR/IT contexts, but also in process context. This idea
introduced a cyclic call of 'struct snd_pcm_ops.pointer()'. The last
commit adds 'pointer_flush' member to 'struct amdtp_stream' to avoid the
situation. On the other hand, This solution is weak at race condition
between the process context and the software IRQ context of IR/IT
contexts.

Practically, this race is not so critical because it influences process
context to skip flushing queued packets and to get worse granularity of
PCM pointer. This is quite rare because 'struct snd_pcm_ops.pointer()'
is frequently called by process contexts while IT/IR contexts run less
frequently. However, it's better to solve the race.

The similar solution can be achieved by 'in_interrupt()' macro. This
commit applies the macro to solve the race condition against
'pointer_flush'.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 23 +++++++++++++++++------
 sound/firewire/amdtp-stream.h |  1 -
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 4484242..132c7f4 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -248,7 +248,6 @@ void amdtp_stream_pcm_prepare(struct amdtp_stream *s)
 	tasklet_kill(&s->period_tasklet);
 	s->pcm_buffer_pointer = 0;
 	s->pcm_period_pointer = 0;
-	s->pointer_flush = true;
 }
 EXPORT_SYMBOL(amdtp_stream_pcm_prepare);
 
@@ -353,7 +352,6 @@ static void update_pcm_pointers(struct amdtp_stream *s,
 	s->pcm_period_pointer += frames;
 	if (s->pcm_period_pointer >= pcm->runtime->period_size) {
 		s->pcm_period_pointer -= pcm->runtime->period_size;
-		s->pointer_flush = false;
 		tasklet_hi_schedule(&s->period_tasklet);
 	}
 }
@@ -798,11 +796,24 @@ EXPORT_SYMBOL(amdtp_stream_start);
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
+	 * When the process context reach here, some packets wll be queued in
+	 * the buffer. These packets should be handled immediately to keep
+	 * better granularity of PCM pointer.
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
index 8775704..ab697cc 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -132,7 +132,6 @@ struct amdtp_stream {
 	struct tasklet_struct period_tasklet;
 	unsigned int pcm_buffer_pointer;
 	unsigned int pcm_period_pointer;
-	bool pointer_flush;
 
 	/* To wait for first packet. */
 	bool callbacked;
-- 
2.7.4
