From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
Date: Wed, 1 Sep 2004 19:09:05 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040901170905.GA24241@elte.hu>
References: <OFD220F58F.002C5901-ON86256F02.005C2FB1-86256F02.005C2FD5@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267176AbUIARIw@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <OFD220F58F.002C5901-ON86256F02.005C2FB1-86256F02.005C2FD5@raytheon.com>
To: Mark_H_Johnson@raytheon.com
Cc: "K.R. Foley" <kr@cybsft.com>, Felipe Alfaro Solana <lkml@felipe-alfaro.com>, Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>, alsa-devel <alsa-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> >since the latency tracer does not trigger, we need a modified tracer to
> >find out what's happening during such long delays. I've attached the
> >'user-latency-tracer' patch ontop of -Q5, which is a modification of the
> >latency tracer.
> 
> The attached file has a set of user latency traces taken about 1 second
> apart at the start of running "latencytest" (a tracing version of it).
> 
> The first few show the "fast path" result of calling write. The remaining
> ones vary with three different symptoms:
>  - the fast path
>  - a "long" delay (about 1000 traces)

lt.03 shows this long delay. Here are the relevant sections, the delay
seems to be triggered by the ALSA driver, by scheduling away
intentionally, in snd_pcn_lib_write1():

 00000002 0.023ms (+0.001ms): snd_pcm_update_hw_ptr (snd_pcm_lib_write1)
 00000002 0.023ms (+0.000ms): snd_ensoniq_playback1_pointer (snd_pcm_update_hw_ptr)
 00000002 0.025ms (+0.002ms): snd_pcm_playback_silence (snd_pcm_update_hw_ptr)
 00000002 0.026ms (+0.000ms): add_wait_queue (snd_pcm_lib_write1)
 00000000 0.027ms (+0.000ms): schedule_timeout (snd_pcm_lib_write1)
 00000000 0.027ms (+0.000ms): __mod_timer (schedule_timeout)

then it sleeps 700 usecs and is woken up by the soundcard's IRQ via
snd_pcm_period_elapsed():

 00010000 0.771ms (+0.000ms): snd_audiopci_interrupt (generic_handle_IRQ_event)
 00010000 0.774ms (+0.002ms): snd_pcm_period_elapsed (snd_audiopci_interrupt)
 00010002 0.775ms (+0.001ms): snd_ensoniq_playback1_pointer (snd_pcm_period_elapsed)
 00010002 0.779ms (+0.003ms): snd_pcm_playback_silence (snd_pcm_period_elapsed)
 00010002 0.780ms (+0.001ms): __wake_up (snd_pcm_period_elapsed)
 00010003 0.780ms (+0.000ms): __wake_up_common (__wake_up)
 00010003 0.780ms (+0.000ms): default_wake_function (__wake_up_common)
 00010003 0.781ms (+0.000ms): try_to_wake_up (__wake_up_common)
 00010003 0.782ms (+0.000ms): task_rq_lock (try_to_wake_up)
 00010004 0.783ms (+0.001ms): activate_task (try_to_wake_up)

and returns to userspace shortly afterwards. So the question is, why
does snd_pcm_lib_write1() cause the latencytest task to sleep (while
latencytest clearly doesnt expect this to happen and reports this as a
latency) - is this by design?

	Ingo
