From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/2][RFC] ALSA: firewire-lib: cancel processing
	packets in struct snd_pcm_ops.pointer() call
Date: Thu, 13 Sep 2018 00:04:50 +0900
Message-ID: <20180912150450.16334-3-o-takashi@sakamocchi.jp>
References: <20180912150450.16334-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by alsa0.perex.cz (Postfix) with ESMTP id CE0932673F4
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2018 17:05:08 +0200 (CEST)
Received: by mail-pl1-f196.google.com with SMTP id j8-v6so1101543pll.12
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2018 08:05:08 -0700 (PDT)
In-Reply-To: <20180912150450.16334-1-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

In current implementation of IEC 61883-1/6 engine in ALSA firewire
stack, there's two chances to handle isochronous packets in process
contexts. One is a callback of struct snd_pcm_ops.pointer() and another
is the one of .ack(). When alsa-lib applications queue/dequeue PCM frames
according to mmap scenario, the isochronous packets are handled in below
call graph.

while ()
  ->poll()
  ->snd_pcm_hwsync()
    ->ioctl(HWSYNC)
      ->struct snd_pcm_ops.pointer()
      = amdtp_stream_pcm_pointer()
          ->fw_iso_context_flush_completions()
  ->snd_pcm_mmap_begin()
  (queue/dequeue PCM frames here.)
  ->snd_pcm_mmap_commit()
    ->ioctl(SYNC_PTR)
      ->struct snd_pcm_ops.ack()
      = amdtp_stream_pcm_ack()
        ->fw_iso_context_flush_completions()

In an above iteration, two calls of fw_iso_context_flush_completions()
are executed with quite small interval, thus few packets can be handled
in a call of .ack(). This is inefficient.

Although .ack() ensures to be called in process contexts, .pointer() is
called in interrupt contexts as well as process context. Especially,
this engine is designed to call snd_pcm_period_elapsed() in software IRQ
context of tasklet, scheduled in both of process context and interrupt
context of 1394 OHCI IR/IT context. To reduce closest two call of
.pointer(), a condition to judge running context is used in .pointer.
An idea to flush packets in a callback of .pointer() requires the above
extra care.

On the other hand, a callback of .ack() has no care like that, except
for being called within acquired lock. Therefore it's reasonable to
cancel .pointer() side.

This commit cancels flushing packets in a callback of .pointer(). The
callback of .pointer just returns the number of PCM frames in
intermediate PCM buffer or SNDRV_PCM_POS_XRUN. As a result:

while ()
  ->poll()
  ->snd_pcm_hwsync()
    ->ioctl(HWSYNC)
      ->struct snd_pcm_ops.pointer()
      = amdtp_stream_pcm_pointer()
  ->snd_pcm_mmap_begin()
  (queue/dequeue PCM frames here.)
  ->snd_pcm_mmap_commit()
    ->ioctl(SYNC_PTR)
      ->struct snd_pcm_ops.ack()
      = amdtp_stream_pcm_ack()
        ->fw_iso_context_flush_completions()

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp-stream.c | 31 -------------------------------
 sound/firewire/amdtp-stream.h | 12 +++++++++++-
 2 files changed, 11 insertions(+), 32 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 3520dc2bec61..48f17264fc35 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -922,37 +922,6 @@ int amdtp_stream_start(struct amdtp_stream *s, int channel, int speed)
 }
 EXPORT_SYMBOL(amdtp_stream_start);
 
-/**
- * amdtp_stream_pcm_pointer - get the PCM buffer position
- * @s: the AMDTP stream that transports the PCM data
- *
- * Returns the current buffer position, in frames.
- */
-unsigned long amdtp_stream_pcm_pointer(struct amdtp_stream *s)
-{
-	/*
-	 * This function is called in software IRQ context of period_tasklet or
-	 * process context.
-	 *
-	 * When the software IRQ context was scheduled by software IRQ context
-	 * of IR/IT contexts, queued packets were already handled. Therefore,
-	 * no need to flush the queue in buffer anymore.
-	 *
-	 * When the process context reach here, some packets will be already
-	 * queued in the buffer. These packets should be handled immediately
-	 * to keep better granularity of PCM pointer.
-	 *
-	 * Later, the process context will sometimes schedules software IRQ
-	 * context of the period_tasklet. Then, no need to flush the queue by
-	 * the same reason as described for IR/IT contexts.
-	 */
-	if (!in_interrupt() && amdtp_stream_running(s))
-		fw_iso_context_flush_completions(s->context);
-
-	return READ_ONCE(s->pcm_buffer_pointer);
-}
-EXPORT_SYMBOL(amdtp_stream_pcm_pointer);
-
 /**
  * amdtp_stream_pcm_ack - acknowledge queued PCM frames
  * @s: the AMDTP stream that transfers the PCM frames
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index e45de3eecfe3..8a96419c462b 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -168,7 +168,6 @@ int amdtp_stream_add_pcm_hw_constraints(struct amdtp_stream *s,
 					struct snd_pcm_runtime *runtime);
 
 void amdtp_stream_pcm_prepare(struct amdtp_stream *s);
-unsigned long amdtp_stream_pcm_pointer(struct amdtp_stream *s);
 int amdtp_stream_pcm_ack(struct amdtp_stream *s);
 void amdtp_stream_pcm_abort(struct amdtp_stream *s);
 
@@ -229,6 +228,17 @@ static inline bool cip_sfc_is_base_44100(enum cip_sfc sfc)
 	return sfc & 1;
 }
 
+/**
+ * amdtp_stream_pcm_pointer - get the PCM buffer position
+ * @s: the AMDTP stream that transports the PCM data
+ *
+ * Returns the current buffer position, in frames.
+ */
+static inline unsigned long amdtp_stream_pcm_pointer(struct amdtp_stream *s)
+{
+	return READ_ONCE(s->pcm_buffer_pointer);
+}
+
 /**
  * amdtp_stream_wait_callback - sleep till callbacked or timeout
  * @s: the AMDTP stream
-- 
2.17.1
