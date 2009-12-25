From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Duplicate wake-ups in pcm_lib.c
Date: Fri, 25 Dec 2009 14:59:06 +0800
Message-ID: <4f3252890912242259j1476880fj4689811b97ee67f9@mail.gmail.com>
References: <6160a5130912231228g29669e4ctfef9ea8f42633120@mail.gmail.com>
	<alpine.LNX.2.00.0912240922460.2598@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f179.google.com (mail-pz0-f179.google.com
	[209.85.222.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3ED171037F2
	for <alsa-devel@alsa-project.org>; Fri, 25 Dec 2009 07:59:08 +0100 (CET)
Received: by pzk9 with SMTP id 9so5661000pzk.16
	for <alsa-devel@alsa-project.org>; Thu, 24 Dec 2009 22:59:07 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.0912240922460.2598@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

does it mean that avail_min cannot be larger than buffer size ?

Is this a bug of snd_pcm_sw_params_set_avail_min() ?


PA server set avail_min to 4661 which is even larger than buffer size 2048
when use 2 periods of 4K bytes with au8830

avail will never greater than  runtime->control->avail_min (4661)


However au8830 work quite well on Fedora 10 pulseaudio-0.9.14


D: alsa-util.c:   buffer_size  : 2048
D: alsa-util.c:   period_size  : 1024
D: alsa-util.c:   period_time  : 23219
D: alsa-util.c:   tstamp_mode  : NONE
D: alsa-util.c:   period_step  : 1
D: alsa-util.c:   avail_min    : 4661


2009/12/10 pl bossart <bossart.nospam@gmail.com>
>>> 2) why PA use  snd_pcm_hw_params_get_buffer_size_max() instead of
>>> snd_pcm_hw_params_get_buffer_size() after snd_pcm_hw_params() ?

 >> Precisely to use the maximum preallocated buffer size.


D: alsa-util.c: Maximum hw buffer size is 371 ms
I: module-alsa-sink.c: Successfully opened device front:0.
I: module-alsa-sink.c: Successfully enabled mmap() mode.
I: module-alsa-sink.c: Successfully enabled timer-based scheduling mode.
I: (alsa-lib)control.c: Invalid CTL front:0
I: alsa-util.c: Unable to attach to mixer front:0: No such file or directory
I: alsa-util.c: Successfully attached to mixer 'hw:0'
I: alsa-util.c: Using mixer control "Master".
I: sink.c: Created sink 0
"alsa_output.pci_12eb_2_sound_card_0_alsa_playback_0" with sample spec s16le
2ch 44100Hz and channel map front-left,front-right
I: source.c: Created source 0
"alsa_output.pci_12eb_2_sound_card_0_alsa_playback_0.monitor" with sample
spec s16le 2ch 44100Hz and channel map front-left,front-right

I: module-alsa-sink.c: Using 2 fragments of size 4096 bytes, buffer time is
46.44ms
I: module-alsa-sink.c: Time scheduling watermark is 20.00ms
D: module-alsa-sink.c: hwbuf_unused_frames=0
D: module-alsa-sink.c: setting avail_min=4661
I: module-alsa-sink.c: Volume ranges from 0 to 31.
I: module-alsa-sink.c: Volume ranges from -46.50 dB to 0.00 dB.
I: alsa-util.c: All 2 channels can be mapped to mixer channels.
I: module-alsa-sink.c: Using hardware volume control. Hardware dB scale
supported.
D: alsa-util.c: snd_pcm_dump():
D: alsa-util.c: Hardware PCM card 0 'Aureal Vortex au8830' device 0
subdevice 0
D: alsa-util.c: Its setup is:
D: alsa-util.c:   stream       : PLAYBACK
D: alsa-util.c:   access       : MMAP_INTERLEAVED
D: alsa-util.c:   format       : S16_LE
D: alsa-util.c:   subformat    : STD
D: alsa-util.c:   channels     : 2
D: alsa-util.c:   rate         : 44100
D: alsa-util.c:   exact rate   : 44100 (44100/1)
D: alsa-util.c:   msbits       : 16
D: alsa-util.c:   buffer_size  : 2048
D: alsa-util.c:   period_size  : 1024
D: alsa-util.c:   period_time  : 23219
D: alsa-util.c:   tstamp_mode  : NONE
D: alsa-util.c:   period_step  : 1
D: alsa-util.c:   avail_min    : 4661
D: alsa-util.c:   period_event : 0
D: alsa-util.c:   start_threshold  : -1
D: alsa-util.c:   stop_threshold   : -1
D: alsa-util.c:   silence_threshold: 0
D: alsa-util.c:   silence_size : 0
D: alsa-util.c:   boundary     : 1073741824
D: alsa-util.c:   appl_ptr     : 0
D: alsa-util.c:   hw_ptr       : 0



2009/12/24 Jaroslav Kysela <perex@perex.cz>

> On Wed, 23 Dec 2009, pl bossart wrote:
>
> > Thanks to Takashi's advice, I managed to find out the reason why I was
> > seeing null events returned by poll(). This could explain why
> > PulseAudio doesn't seem to sleep much. It turns out that we have two
> > calls to wakeup() in pcm_lib.c, and a nice race condition it seems.
> > See the log below.
> >
> > A wake-up is generated during the period interrupt, and a second
> > wake-up is generated during the write loop, after the application was
> > awaken but just before the pointers are updated. This second wake-up
> > shouldn't exist, since the write loop actually fills the ring buffer.
> > By the time the second wake-up is actually handled, there's really no
> > space left in the buffer and a null event is generated; it'll wake-up
> > the application a second time for nothing. Maybe we should move the
> > call to snd_pcm_update_hw_ptr() after the transfer took place?
>
> The right fix should be to preserve wakeups when write operation is in
> progress (also for interrupts). Something like this (untested):
>
> diff --git a/include/sound/pcm.h b/include/sound/pcm.h
> index c83a4a7..8112834 100644
> --- a/include/sound/pcm.h
> +++ b/include/sound/pcm.h
> @@ -272,6 +272,7 @@ struct snd_pcm_runtime {
>        snd_pcm_uframes_t hw_ptr_interrupt; /* Position at interrupt time */
>        unsigned long hw_ptr_jiffies;   /* Time when hw_ptr is updated */
>        snd_pcm_sframes_t delay;        /* extra delay; typically FIFO size
> */
> +       unsigned int nowake: 1;         /* do not wakeup */
>
>        /* -- HW params -- */
>        snd_pcm_access_t access;        /* access mode */
> diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
> index 30f4108..26cf3ff 100644
> --- a/sound/core/pcm_lib.c
> +++ b/sound/core/pcm_lib.c
> @@ -208,7 +208,7 @@ static int snd_pcm_update_hw_ptr_post(struct
> snd_pcm_substream *substream,
>                        return -EPIPE;
>                }
>        }
> -       if (avail >= runtime->control->avail_min)
> +       if (!runtime->nowake && avail >= runtime->control->avail_min)
>                wake_up(&runtime->sleep);
>        return 0;
>  }
> @@ -1776,6 +1776,7 @@ static snd_pcm_sframes_t snd_pcm_lib_write1(struct
> snd_pcm_substream *substream,
>                goto _end_unlock;
>        }
>
> +       runtime->nowake = 1;
>        while (size > 0) {
>                snd_pcm_uframes_t frames, appl_ptr, appl_ofs;
>                snd_pcm_uframes_t avail;
> @@ -1786,17 +1787,18 @@ static snd_pcm_sframes_t snd_pcm_lib_write1(struct
> snd_pcm_substream *substream,
>                if (!avail) {
>                        if (nonblock) {
>                                err = -EAGAIN;
> -                               goto _end_unlock;
> +                               goto _end_wake;
>                        }
>                        err = wait_for_avail_min(substream, &avail);
>                        if (err < 0)
> -                               goto _end_unlock;
> +                               goto _end_wake;
>                }
>                frames = size > avail ? avail : size;
>                cont = runtime->buffer_size - runtime->control->appl_ptr %
> runtime->buffer_size;
>                if (frames > cont)
>                        frames = cont;
>                if (snd_BUG_ON(!frames)) {
> +                       runtime->nowake = 0;
>                        snd_pcm_stream_unlock_irq(substream);
>                        return -EINVAL;
>                }
> @@ -1809,10 +1811,10 @@ static snd_pcm_sframes_t snd_pcm_lib_write1(struct
> snd_pcm_substream *substream,
>                switch (runtime->status->state) {
>                case SNDRV_PCM_STATE_XRUN:
>                        err = -EPIPE;
> -                       goto _end_unlock;
> +                       goto _end;
>                case SNDRV_PCM_STATE_SUSPENDED:
>                        err = -ESTRPIPE;
> -                       goto _end_unlock;
> +                       goto _end;
>                default:
>                        break;
>                }
> @@ -1830,12 +1832,18 @@ static snd_pcm_sframes_t snd_pcm_lib_write1(struct
> snd_pcm_substream *substream,
>                    snd_pcm_playback_hw_avail(runtime) >=
> (snd_pcm_sframes_t)runtime->start_threshold) {
>                        err = snd_pcm_start(substream);
>                        if (err < 0)
> -                               goto _end_unlock;
> +                               goto _end_wake;
>                }
>        }
> + _end_wake:
> +       runtime->nowake = 0;
> +       if (runtime->status->state == SNDRV_PCM_STATE_RUNNING)
> +               snd_pcm_update_hw_ptr_post(substream, runtime);
>   _end_unlock:
>        snd_pcm_stream_unlock_irq(substream);
> +       return xfer > 0 ? (snd_pcm_sframes_t)xfer : err;
>   _end:
> +       runtime->nowake = 0;
>        return xfer > 0 ? (snd_pcm_sframes_t)xfer : err;
>  }
>
>
> -----
> Jaroslav Kysela <perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, Red Hat, Inc.
>
>
