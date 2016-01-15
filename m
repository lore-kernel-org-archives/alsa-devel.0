From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: sound: use-after-free in snd_timer_interrupt
Date: Fri, 15 Jan 2016 09:06:10 +0100
Message-ID: <CACT4Y+a-=mrGALS+yf4GwGmJGLWXVJ0mbucPAkZ7WSGFaSR0Kw@mail.gmail.com>
References: <CACT4Y+ZrVvE3dgcYHRdHDG0X316VgC-=pr2U-233vVn_QbHZHw@mail.gmail.com>
 <s5hwprdv2sp.wl-tiwai@suse.de> <CACT4Y+ZFsNxsVyq_n6kh=HN1dStj_hL=B9eUu4heAHes=ixf3g@mail.gmail.com>
 <s5hio2xmh9z.wl-tiwai@suse.de> <CACT4Y+bqxg_C7JmnUSRm_9jiZ9R9XqbBV0igDdUW1ZhtqvktJw@mail.gmail.com>
 <CACT4Y+anWgMKQmNByifCs+-jizRQL9twxvRQzW3XzNJ8+a6fDw@mail.gmail.com>
 <s5hegdlmdd6.wl-tiwai@suse.de> <CACT4Y+Y62DTncEAb_S6JykY7Ps7SHo2QyCopMObBxJt2fB_NKA@mail.gmail.com>
 <s5h60yxmc99.wl-tiwai@suse.de> <s5ha8o8uoqb.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5ha8o8uoqb.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jie Yang <yang.jie@intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, LKML <linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Alexander Potapenko <glider@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>, Sasha Levin <sasha.levin@oracle.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 14, 2016 at 5:09 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Wed, 13 Jan 2016 21:54:10 +0100,
> Takashi Iwai wrote:
>>
>> OK, then this might be a possible race at the current snd_timer_stop()
>> implementation.  There is no sync action there, so the ISR might be
>> still alive after snd_timer_close() call.  Or might be another race.
>> This pattern looks a bit different, as it's involved with hrtimer.
>>
>> I'll take a look at it tomorrow.
>
> I've audited the code today, but the open window doesn't look like
> what I expected.  I found only some possible cases with slave timer
> instances.
>
> In anyway, below is a test fix patch.  Since I couldn't reproduce the
> issue on my local machines, it's hard to say whether this covers the
> holes you fell.  Let's see...


Hi Takashi,

I would be interested to understand why other people can't reproduce
issues that I hit pretty reliably.
I suspect that it can be due to .config. Please try with the following
config values.

I also start qemu with "-soundhw all" arg.

CONFIG_SOUND=y
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_JACK=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQ_DUMMY=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_PCM_OSS_PLUGINS=y
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_HRTIMER=y
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_RAWMIDI_SEQ=y
CONFIG_SND_OPL3_LIB_SEQ=y
CONFIG_SND_MPU401_UART=y
CONFIG_SND_OPL3_LIB=y
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_DRIVERS=y
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=0
CONFIG_SND_SB_COMMON=y
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=y
CONFIG_SND_ALS300=y
CONFIG_SND_ALS4000=y
CONFIG_SND_ALI5451=y
CONFIG_SND_OXYGEN_LIB=y
CONFIG_SND_VIRTUOSO=y
CONFIG_SND_HDA=y
CONFIG_SND_HDA_INTEL=y
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=1
CONFIG_SND_HDA_PATCH_LOADER=y
CONFIG_SND_HDA_CODEC_REALTEK=y
CONFIG_SND_HDA_CODEC_ANALOG=y
CONFIG_SND_HDA_CODEC_SIGMATEL=y
CONFIG_SND_HDA_CODEC_VIA=y
CONFIG_SND_HDA_CODEC_HDMI=y
CONFIG_SND_HDA_GENERIC=y
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
CONFIG_SND_HDA_CORE=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_PREALLOC_SIZE=64
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=y
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=y
CONFIG_SND_DICE=y
CONFIG_SND_OXFW=y
CONFIG_SND_ISIGHT=y
CONFIG_SND_SCS1X=y
CONFIG_SND_FIREWORKS=y
CONFIG_SND_BEBOB=y
CONFIG_SND_FIREWIRE_DIGI00X=y
CONFIG_SND_FIREWIRE_TASCAM=y
CONFIG_SND_PCMCIA=y



> Takashi
>
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: timer: Harden slave timer list handling
>
> A slave timer instance might be still accessible in a racy way while
> operating the master instance as it lacks of locking.  Since the
> master operation is mostly protected with timer->lock, we should cope
> with it while changing the slave instance, too.  Also, some linked
> lists (active_list and ack_list) of slave instances aren't unlinked
> immediately at stopping or closing, and this may lead to unexpected
> accesses.
>
> This patch tries to address these issues.  It adds spin lock of
> timer->lock (either from master or slave, which is equivalent) in a
> few places.  For avoiding a deadlock, we ensure that the global
> slave_active_lock is always locked at first before each timer lock.
>
> Also, ack and active_list of slave instances are properly unlinked at
> snd_timer_stop() and snd_timer_close().
>
> Last but not least, remove the superfluous call of _snd_timer_stop()
> at removing slave links.  This is a noop, and calling it may confuse
> readers wrt locking.  Further cleanup will follow in a later patch.
>
> Actually we've got reports of use-after-free by syzkaller fuzzer, and
> this hopefully fixes these issues.
>
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/core/timer.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/sound/core/timer.c b/sound/core/timer.c
> index 3810ee8f1205..4e8d7bfffff6 100644
> --- a/sound/core/timer.c
> +++ b/sound/core/timer.c
> @@ -215,11 +215,13 @@ static void snd_timer_check_master(struct snd_timer_instance *master)
>                     slave->slave_id == master->slave_id) {
>                         list_move_tail(&slave->open_list, &master->slave_list_head);
>                         spin_lock_irq(&slave_active_lock);
> +                       spin_lock(&master->timer->lock);
>                         slave->master = master;
>                         slave->timer = master->timer;
>                         if (slave->flags & SNDRV_TIMER_IFLG_RUNNING)
>                                 list_add_tail(&slave->active_list,
>                                               &master->slave_active_head);
> +                       spin_unlock(&master->timer->lock);
>                         spin_unlock_irq(&slave_active_lock);
>                 }
>         }
> @@ -346,15 +348,18 @@ int snd_timer_close(struct snd_timer_instance *timeri)
>                     timer->hw.close)
>                         timer->hw.close(timer);
>                 /* remove slave links */
> +               spin_lock_irq(&slave_active_lock);
> +               spin_lock(&timer->lock);
>                 list_for_each_entry_safe(slave, tmp, &timeri->slave_list_head,
>                                          open_list) {
> -                       spin_lock_irq(&slave_active_lock);
> -                       _snd_timer_stop(slave, 1, SNDRV_TIMER_EVENT_RESOLUTION);
>                         list_move_tail(&slave->open_list, &snd_timer_slave_list);
>                         slave->master = NULL;
>                         slave->timer = NULL;
> -                       spin_unlock_irq(&slave_active_lock);
> +                       list_del_init(&slave->ack_list);
> +                       list_del_init(&slave->active_list);
>                 }
> +               spin_unlock(&timer->lock);
> +               spin_unlock_irq(&slave_active_lock);
>                 mutex_unlock(&register_mutex);
>         }
>   out:
> @@ -441,9 +446,12 @@ static int snd_timer_start_slave(struct snd_timer_instance *timeri)
>
>         spin_lock_irqsave(&slave_active_lock, flags);
>         timeri->flags |= SNDRV_TIMER_IFLG_RUNNING;
> -       if (timeri->master)
> +       if (timeri->master && timeri->timer) {
> +               spin_lock(&timeri->timer->lock);
>                 list_add_tail(&timeri->active_list,
>                               &timeri->master->slave_active_head);
> +               spin_unlock(&timeri->timer->lock);
> +       }
>         spin_unlock_irqrestore(&slave_active_lock, flags);
>         return 1; /* delayed start */
>  }
> @@ -489,6 +497,8 @@ static int _snd_timer_stop(struct snd_timer_instance * timeri,
>                 if (!keep_flag) {
>                         spin_lock_irqsave(&slave_active_lock, flags);
>                         timeri->flags &= ~SNDRV_TIMER_IFLG_RUNNING;
> +                       list_del_init(&timeri->ack_list);
> +                       list_del_init(&timeri->active_list);
>                         spin_unlock_irqrestore(&slave_active_lock, flags);
>                 }
>                 goto __end;
> --
> 2.7.0
>
>
