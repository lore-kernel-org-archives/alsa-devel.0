From: Tim Cussins <timcussins@eml.cc>
Subject: Re: [RFC] ALSA: provide a simple mechanism to start
 playback at a given time
Date: Thu, 16 Oct 2014 11:53:07 +0100
Message-ID: <543FA393.7020605@eml.cc>
References: <543d33f8.4a66b40a.638d.0583@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 55C7E2614A9
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 12:53:11 +0200 (CEST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by gateway2.nyi.internal (Postfix) with ESMTP id F32AC207AF
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 06:53:08 -0400 (EDT)
Received: from [10.2.10.211] (unknown [195.59.102.251])
 by mail.messagingengine.com (Postfix) with ESMTPA id 89ED9C00011
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 06:53:08 -0400 (EDT)
In-Reply-To: <543d33f8.4a66b40a.638d.0583@mx.google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi again Nick!

On 14/10/14 09:29, Nick Stoughton wrote:
> Initial implementation / Request For Comment.
>
> Given an absolute time based on a given clock (CLOCK_MONOTONIC,
> CLOCK_MONOTONIC_RAW, CLOCK_REALTIME etc), setup a high resolution timer
> to cause playback to be triggered at that time.
> ---
>   include/linux/timekeeping.h |  3 ++
>   include/uapi/sound/asound.h |  6 +++
>   kernel/time/timekeeping.c   | 16 ++++++++
>   sound/core/pcm_native.c     | 99 +++++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 124 insertions(+)
>
> diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
> index 1caa6b0..74eb6b2 100644
> --- a/include/linux/timekeeping.h
> +++ b/include/linux/timekeeping.h
> @@ -32,6 +32,9 @@ extern void ktime_get_ts64(struct timespec64 *ts);
>   extern int __getnstimeofday64(struct timespec64 *tv);
>   extern void getnstimeofday64(struct timespec64 *tv);
>
> +/*  Get the offset between monotonic and monotonic raw clocks */
> +extern ktime_t ktime_get_raw_offset(void);
> +
>   #if BITS_PER_LONG == 64
>   static inline int __getnstimeofday(struct timespec *ts)
>   {
> diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
> index 6ee5867..c7aa88c 100644
> --- a/include/uapi/sound/asound.h
> +++ b/include/uapi/sound/asound.h
> @@ -462,6 +462,11 @@ struct snd_xfern {
>   	snd_pcm_uframes_t frames;
>   };
>
> +struct snd_clock_time {
> +        clockid_t       clock;
> +        struct timespec time;
> +};
> +

Takashi added snd_pcm_tstamp_type_t in July - If the final start_at 
patch includes some "struct snd_clock_time", then it'd probably use 
Takashi's type in favour of a raw clockid_t.

I like the idea of a single struct that includes the context for the 
timespec btw. Cool.

>   enum {
>   	SNDRV_PCM_TSTAMP_TYPE_GETTIMEOFDAY = 0,	/* gettimeofday equivalent */
>   	SNDRV_PCM_TSTAMP_TYPE_MONOTONIC,	/* posix_clock_monotonic equivalent */
> @@ -547,6 +552,7 @@ enum {
>   #define SNDRV_PCM_IOCTL_READN_FRAMES	_IOR('A', 0x53, struct snd_xfern)
>   #define SNDRV_PCM_IOCTL_LINK		_IOW('A', 0x60, int)
>   #define SNDRV_PCM_IOCTL_UNLINK		_IO('A', 0x61)
> +#define SNDRV_PCM_IOCTL_START_AT	_IOR('A', 0x62, struct snd_clock_time)
>
>   /*****************************************************************************
>    *                                                                           *
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index ec1791f..3d5d0bc 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -789,6 +789,22 @@ error: /* even if we error out, we forwarded the time, so call update */
>   }
>   EXPORT_SYMBOL(timekeeping_inject_offset);
>
> +/**
> + * ktime_get_raw_offset - get the offset in ktime format between
> + * the monotonic_raw clock and the monotonic clock
> + */
> +ktime_t ktime_get_raw_offset(void)
> +{
> +        struct timespec rawtime = {0,0};
> +        struct timespec now = {0,0};
> +        struct timespec delta;
> +
> +        ktime_get_ts(&now);
> +        getrawmonotonic(&rawtime);
> +        delta = timespec_sub(now, rawtime);
> +        return timespec_to_ktime(delta);
> +}
> +EXPORT_SYMBOL(ktime_get_raw_offset);
>
>   /**
>    * timekeeping_get_tai_offset - Returns current TAI offset from UTC
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index 85fe1a2..1121127 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -27,6 +27,7 @@
>   #include <linux/pm_qos.h>
>   #include <linux/aio.h>
>   #include <linux/dma-mapping.h>
> +#include <linux/time.h>
>   #include <sound/core.h>
>   #include <sound/control.h>
>   #include <sound/info.h>
> @@ -38,6 +39,9 @@
>   #if defined(CONFIG_MIPS) && defined(CONFIG_DMA_NONCOHERENT)
>   #include <dma-coherence.h>
>   #endif
> +#if defined(CONFIG_HIGH_RES_TIMERS)
> +#include <linux/hrtimer.h>
> +#endif
>
>   /*
>    *  Compatibility
> @@ -1016,6 +1020,99 @@ static struct action_ops snd_pcm_action_start = {
>   	.post_action = snd_pcm_post_start
>   };
>
> +#ifdef CONFIG_HIGH_RES_TIMERS
> +/*
> + * hrtimer interface
> + */
> +
> +struct hrtimer_pcm {
> +	struct hrtimer timer;
> +	struct snd_pcm_substream *substream;
> +};
> +
> +/*
> + * called from a hard irq context - no need for locks.
> + * only problem is that the caller might have gone away and closed the substream
> + * before the timer expires.
> + */
> +enum hrtimer_restart snd_pcm_do_start_time(struct hrtimer *timer)
> +{
> +        struct hrtimer_pcm *pcm_timer;
> +	struct snd_pcm_substream *substream;
> +        int ret;
> +
> +        pcm_timer = container_of(timer, struct hrtimer_pcm, timer);
> +        substream = pcm_timer->substream;
> +
> +        if (substream->runtime) {
> +                ret = snd_pcm_do_start(substream, SNDRV_PCM_STATE_RUNNING);
> +                if (ret == 0) {
> +                        snd_pcm_post_start(substream, SNDRV_PCM_STATE_RUNNING);
> +                }
> +        }
> +	kfree(pcm_timer);
> +
> +        return HRTIMER_NORESTART;
> +}
> +
> +int snd_pcm_start_at(struct snd_pcm_substream *substream,
> +        struct snd_clock_time __user *_start_time)
> +{
> +        struct hrtimer_pcm *pcm_timer;
> +        struct snd_clock_time start_time;
> +        int clock;
> +        ktime_t start_kt;
> +        ktime_t raw_offset;
> +        int ret;
> +
> +	if (copy_from_user(&start_time, _start_time, sizeof(start_time)))
> +		return -EFAULT;
> +
> +        if (!timespec_valid(&start_time.time))
> +		return -EINVAL;
> +
> +        start_kt = timespec_to_ktime(start_time.time);
> +        clock = start_time.clock;
> +        if (start_time.clock == CLOCK_MONOTONIC_RAW) {
> +                raw_offset = ktime_get_raw_offset();
> +
> +                /* convert to clock monotonic */
> +                start_kt = ktime_add(raw_offset, start_kt);
> +                clock = CLOCK_MONOTONIC;
> +        }
> +
> +        /*  if not playback substream or less than 100 ms give up */
> +	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK ||
> +           (ktime_compare(start_kt, ktime_add_ns(ktime_get(), 100000000)) <= 0)) {
> +		return snd_pcm_action_lock_irq(&snd_pcm_action_start,
> +                        substream, SNDRV_PCM_STATE_RUNNING);
> +        }
> +
> +        ret = snd_pcm_pre_start(substream, SNDRV_PCM_STATE_PREPARED);
> +        if (ret != 0) {
> +                return ret;
> +        }
> +
> +        pcm_timer = kmalloc(sizeof(*pcm_timer), GFP_KERNEL);
> +        hrtimer_init(&pcm_timer->timer, clock, HRTIMER_MODE_ABS);
> +
> +        pcm_timer->timer.function = snd_pcm_do_start_time;
> +        pcm_timer->substream = substream;
> +
> +	hrtimer_start(&pcm_timer->timer, start_kt, HRTIMER_MODE_ABS);
> +
> +	return 0;
> +}
> +#else
> +/* without high res time, interface is identical to snd_pcm_start() */
> +int snd_pcm_start_at(struct snd_pcm_substream *substream,
> +        struct snd_clock_time __user *_start_time)
> +{
> +        return snd_pcm_action_lock_irq(&snd_pcm_action_start,
> +                substream, SNDRV_PCM_STATE_RUNNING);
> +}
> +#endif
> +

I'd prefer to return an error code when snd_pcm_start_at cannot be 
supported, rather than lying to userspace that it will be satisfied :)

There might be a number of reasons that snd_pcm_start_at cannot be 
satisfied: unsupported clock-type, timespec in the past, incompatible 
kernel config are just three.

While one might argue that start_at is a "best effort" mechanism, on 
principle the function should make every effort to return an error when 
it would be meaningful (read: handleable) by userspace. Not sure how you 
feel about that ... :)

>   /**
>    * snd_pcm_start - start all linked streams
>    * @substream: the PCM substream instance
> @@ -2698,6 +2795,8 @@ static int snd_pcm_common_ioctl1(struct file *file,
>   		return snd_pcm_reset(substream);
>   	case SNDRV_PCM_IOCTL_START:
>   		return snd_pcm_action_lock_irq(&snd_pcm_action_start, substream, SNDRV_PCM_STATE_RUNNING);
> +        case SNDRV_PCM_IOCTL_START_AT:
> +                return snd_pcm_start_at(substream, arg);
>   	case SNDRV_PCM_IOCTL_LINK:
>   		return snd_pcm_link(substream, (int)(unsigned long) arg);
>   	case SNDRV_PCM_IOCTL_UNLINK:
>

I'm really not qualified to pass comment on the kernel half of start_at: 
I'll have to some back to that, or defer to others...

Cheers,
Tim
