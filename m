From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
Date: Tue, 31 Aug 2004 13:20:19 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1093972819.5403.8.camel@krustophenia.net>
References: <OF923A124A.1D8E364E-ON86256F01.0053F7B2-86256F01.0053F7D7@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S265462AbUHaR1J@vger.kernel.org>
In-Reply-To: <OF923A124A.1D8E364E-ON86256F01.0053F7B2-86256F01.0053F7D7@raytheon.com>
To: Mark_H_Johnson@raytheon.com
Cc: Ingo Molnar <mingo@elte.hu>, "K.R. Foley" <kr@cybsft.com>, linux-kernel <linux-kernel@vger.kernel.org>, Felipe Alfaro Solana <lkml@felipe-alfaro.com>, Daniel Schmitt <pnambic@unu.nu>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2004-08-31 at 11:17, Mark_H_Johnson@raytheon.com wrote:
> >I will be running some additional tests
> >- reducing preempt_max_latency
> >- running with sortirq and hardirq_preemption=0
> >to see if these uncover any further problems.
> 
> #1 - audio driver
>  latency: 621 us, entries: 28 (28)
>     -----------------
>     | task: latencytest/11492, uid:0 nice:0 policy:1 rt_prio:99
>     -----------------
>  => started at: snd_ensoniq_playback1_prepare+0x74/0x180
>  => ended at:   snd_ensoniq_playback1_prepare+0x11d/0x180
> =======>
> 00000001 0.000ms (+0.000ms): snd_ensoniq_playback1_prepare
> (snd_pcm_do_prepare)
> 00000001 0.014ms (+0.014ms): snd_es1371_dac1_rate
> (snd_ensoniq_playback1_prepare)
> 00000001 0.014ms (+0.000ms): snd_es1371_wait_src_ready
> (snd_es1371_dac1_rate)
> 00000001 0.562ms (+0.548ms): snd_es1371_src_read (snd_es1371_dac1_rate)
> 00000001 0.562ms (+0.000ms): snd_es1371_wait_src_ready
> (snd_es1371_src_read)
> 00000001 0.578ms (+0.015ms): snd_es1371_wait_src_ready
> (snd_es1371_src_read)
> 00000001 0.585ms (+0.006ms): snd_es1371_src_write (snd_es1371_dac1_rate)
> 00000001 0.585ms (+0.000ms): snd_es1371_wait_src_ready
> (snd_es1371_src_write)
> 00000001 0.601ms (+0.015ms): snd_es1371_src_write (snd_es1371_dac1_rate)
> 00000001 0.601ms (+0.000ms): snd_es1371_wait_src_ready
> (snd_es1371_src_write)
> 00000001 0.602ms (+0.001ms): snd_es1371_wait_src_ready
> (snd_es1371_dac1_rate)
> 00000001 0.616ms (+0.013ms): smp_apic_timer_interrupt
> (snd_ensoniq_playback1_prepare)
> 
> or
> 
>  latency: 663 us, entries: 41 (41)
>     -----------------
>     | task: latencytest/11492, uid:0 nice:0 policy:1 rt_prio:99
>     -----------------
>  => started at: snd_ensoniq_playback1_prepare+0x74/0x180
>  => ended at:   snd_ensoniq_playback1_prepare+0x11d/0x180
> =======>
> 00000001 0.000ms (+0.000ms): snd_ensoniq_playback1_prepare
> (snd_pcm_do_prepare)
> 00000001 0.004ms (+0.004ms): snd_es1371_dac1_rate
> (snd_ensoniq_playback1_prepare)
> 00000001 0.005ms (+0.000ms): snd_es1371_wait_src_ready
> (snd_es1371_dac1_rate)
> 00000001 0.006ms (+0.001ms): snd_es1371_src_read (snd_es1371_dac1_rate)
> 00000001 0.006ms (+0.000ms): snd_es1371_wait_src_ready
> (snd_es1371_src_read)
> 00000001 0.019ms (+0.012ms): snd_es1371_wait_src_ready
> (snd_es1371_src_read)
> 00000001 0.607ms (+0.588ms): snd_es1371_src_write (snd_es1371_dac1_rate)
> 00000001 0.608ms (+0.000ms): snd_es1371_wait_src_ready
> (snd_es1371_src_write)
> 00000001 0.624ms (+0.016ms): snd_es1371_src_write (snd_es1371_dac1_rate)
> 00000001 0.624ms (+0.000ms): snd_es1371_wait_src_ready
> (snd_es1371_src_write)
> 00000001 0.626ms (+0.001ms): snd_es1371_wait_src_ready
> (snd_es1371_dac1_rate)
> 00000001 0.639ms (+0.013ms): smp_apic_timer_interrupt
> (snd_ensoniq_playback1_prepare)

Hmm, looks like the es1371 takes ~0.5 ms to set the DAC rate.  The ALSA
team would probably be able to help.  Takashi, any ideas?

Lee
