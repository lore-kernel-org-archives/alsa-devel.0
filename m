From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA: firewire-lib: Fix stall of process context
 on local CPU, with disabled IRQ at packet error
Date: Fri, 9 Jun 2017 09:49:53 +0200
Message-ID: <896bd512-900f-b596-cba8-a7617312cea0@ladisch.de>
References: <0eff34d9-1c1a-a93c-ae25-2d469833a3ec@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id C32E62675FB
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 09:49:54 +0200 (CEST)
In-Reply-To: <0eff34d9-1c1a-a93c-ae25-2d469833a3ec@sakamocchi.jp>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> Hi Clemens and Iwai-san,
>
> I found a critical bug on ALSA IEC 61883-1/6 engine at error handling on process context. At packet queueing error or detection of invalid packet, user process can stall on local CPU with IRQ disabled. This bug was introduced at v3.5.
>
> I wrote a fix but this can be applied down to v4.9.31, but it's unavailable for the former longterm versions. What can we do for them?
>
> ========== 8< ----------
> From c8c7541f83913c98bb6f3774127a48c7998caca0 Mon Sep 17 00:00:00 2001
> From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Date: Fri, 9 Jun 2017 07:40:05 +0900
> Subject: [PATCH] ALSA: firewire-lib: Fix stall of process context on local CPU
>  with disabled IRQ at packet error
>
> At Linux v3.5, packet processing can be done in process context of ALSA
> PCM application as well as software IRQ context for OHCI 1394. Below is
> an example of the callgraph (some calls are omitted).
>
> ioctl(2) with e.g. HWSYNC
> (sound/core/pcm_native.c)
> ->snd_pcm_common_ioctl1()
>   ->snd_pcm_hwsync()
>     ->snd_pcm_stream_lock_irq
>     (sound/core/pcm_lib.c)
>     ->snd_pcm_update_hw_ptr()
>       ->snd_pcm_udpate_hw_ptr0()
>         ->struct snd_pcm_ops.pointer()
>         (sound/firewire/*)
>         = Each handler on drivers in ALSA firewire stack
>           (sound/firewire/amdtp-stream.c)
>           ->amdtp_stream_pcm_pointer()
>             (drivers/firewire/core-iso.c)
>             ->fw_iso_context_flush_completions()
>               ->struct fw_card_driver.flush_iso_completion()
>               (drivers/firewire/ohci.c)
>               = flush_iso_completions()
>                 ->struct fw_iso_context.callback.sc
>                 (sound/firewire/amdtp-stream.c)
>                 = in_stream_callback() or out_stream_callback()
>                   ->...
>     ->snd_pcm_stream_unlock_irq
>
> When packet queueing error occurs or detecting invalid packets in
> 'in_stream_callback()' or 'out_stream_callback()', 'snd_pcm_stop_xrun()'
> is called on local CPU with disabled IRQ.

> (sound/firewire/amdtp-stream.c)
> in_stream_callback() or out_stream_callback()
> ->amdtp_stream_pcm_abort()
>   ->snd_pcm_stop_xrun()
>     ->snd_pcm_stream_lock_irqsave()

The fact that interrupts are disabled is not a problem, because
snd_pcm_stop_xrun() uses irqsave/irqrestore calls.  The problem is that
the PCM stream has already been locked, and that snd_pcm_stop_xrun()
tries to take the same lock recursively.

> This commit attempts to fix the above bug by removing the calls of
> 'amdtp_stream_pcm_abort()' from packet handler. When encountering the
> error state, the packet handler is already programmed not to process
> packets anymore.

Yes, by setting "packet_index = -1".  But that's all it does, it just
stops queueing more packets.

> This commit expects any process context or software IRQ contexts to
> detect PCM XRUN by calls of snd_pcm_hw_ptr() or checking status data
> of PCM substream.

What status data?  I cannot test it right now, but as far as I can see,
the PCM substream itself still thinks it's running.  I think we need to
make the .pointer callback report the xrun in the error state:

+++ b/sound/firewire/amdtp-stream.h
 struct amdtp_stream {
 	...
-	unsigned int pcm_buffer_pointer;
+	snd_pcm_uframes_t pcm_buffer_pointer;
 	...
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -682,7 +682,7 @@ static void out_stream_callback(struct fw_iso_context *context, u32 tstamp,
 		cycle = increment_cycle_count(cycle, 1);
 		if (s->handle_packet(s, 0, cycle, i) < 0) {
 			s->packet_index = -1;
-			amdtp_stream_pcm_abort(s);
+			WRITE_ONCE(s->pcm_buffer_pointer, SNDRV_PCM_POS_XRUN);
 			return;
 		}
 	}
@@ -734,7 +733,7 @@ static void in_stream_callback(struct fw_iso_context *context, u32 tstamp,
 	/* Queueing error or detecting invalid payload. */
 	if (i < packets) {
 		s->packet_index = -1;
-		amdtp_stream_pcm_abort(s);
+		WRITE_ONCE(s->pcm_buffer_pointer, SNDRV_PCM_POS_XRUN);
 		return;
 	}


Regards,
Clemens
