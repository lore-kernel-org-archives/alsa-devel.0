From: Tim Cussins <timcussins@eml.cc>
Subject: Re: [RFC] pcm: provide a simple mechanism to start
 playback at a given time
Date: Thu, 16 Oct 2014 12:15:18 +0100
Message-ID: <543FA8C6.7090104@eml.cc>
References: <543d3401.88aa980a.6fbf.ffff9f5f@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id CEC132605C9
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 13:15:20 +0200 (CEST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by gateway2.nyi.internal (Postfix) with ESMTP id 1718120722
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 07:15:20 -0400 (EDT)
Received: from [10.2.10.211] (unknown [195.59.102.251])
 by mail.messagingengine.com (Postfix) with ESMTPA id ACD286800C2
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 07:15:19 -0400 (EDT)
In-Reply-To: <543d3401.88aa980a.6fbf.ffff9f5f@mx.google.com>
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

Hi Nick,

Some more comments :)

On 14/10/14 09:34, Nick Stoughton wrote:
> Initial implementation / Request For Comment.
>
> Given an absolute time based on a given clock (CLOCK_MONOTONIC,
> CLOCK_MONOTONIC_RAW, CLOCK_REALTIME etc), setup a high resolution timer
> to cause playback to be triggered at that time.
> ---
>   include/global.h       | 10 +++++++++-
>   include/pcm.h          |  2 ++
>   include/sound/asound.h |  7 +++++++
>   src/pcm/pcm.c          | 22 +++++++++++++++++++++-
>   src/pcm/pcm_hw.c       | 15 +++++++++++++++
>   src/pcm/pcm_local.h    |  1 +
>   6 files changed, 55 insertions(+), 2 deletions(-)
>
> diff --git a/include/global.h b/include/global.h
> index 16a26dc..f0fb661 100644
> --- a/include/global.h
> +++ b/include/global.h
> @@ -144,6 +144,8 @@ struct timespec {
>   	time_t		tv_sec;		/* seconds */
>   	long		tv_nsec;	/* nanoseconds */
>   };
> +
> +typedef int clockid_t;
>   #endif
>   #endif
>
> @@ -151,7 +153,13 @@ struct timespec {
>   typedef struct timeval snd_timestamp_t;
>   /** Hi-res timestamp */
>   typedef struct timespec snd_htimestamp_t;
> -
> +/** clock type */
> +typedef clockid_t snd_clock_t;
> +/** a combined clock and time */
> +typedef struct {
> +        snd_clock_t             clock;
> +        snd_htimestamp_t        time;
> +} snd_clock_time_t;

See comments on snd_timestamp_type_t from previous email.

>   /** \} */
>
>   #ifdef __cplusplus
> diff --git a/include/pcm.h b/include/pcm.h
> index db88ad5..dfaf69f 100644
> --- a/include/pcm.h
> +++ b/include/pcm.h
> @@ -474,6 +474,8 @@ int snd_pcm_prepare(snd_pcm_t *pcm);
>   int snd_pcm_reset(snd_pcm_t *pcm);
>   int snd_pcm_status(snd_pcm_t *pcm, snd_pcm_status_t *status);
>   int snd_pcm_start(snd_pcm_t *pcm);
> +int snd_pcm_start_at(snd_pcm_t *pcm, snd_clock_time_t *start_time);

> +#define SND_PCM_START_AT(pcm, start_time) snd_pcm_start_at(pcm, start_time)

A debug macro, right? Just checking...

>   int snd_pcm_drop(snd_pcm_t *pcm);
>   int snd_pcm_drain(snd_pcm_t *pcm);
>   int snd_pcm_pause(snd_pcm_t *pcm, int enable);
> diff --git a/include/sound/asound.h b/include/sound/asound.h
> index 6ee5867..92647ce 100644
> --- a/include/sound/asound.h
> +++ b/include/sound/asound.h
> @@ -434,6 +434,11 @@ struct snd_pcm_mmap_control {
>   	snd_pcm_uframes_t avail_min;	/* RW: min available frames for wakeup */
>   };
>
> +struct snd_clock_time {
> +        clockid_t       clock;
> +        struct timespec time;
> +};
> +

As above.

>   #define SNDRV_PCM_SYNC_PTR_HWSYNC	(1<<0)	/* execute hwsync */
>   #define SNDRV_PCM_SYNC_PTR_APPL		(1<<1)	/* get appl_ptr from driver (r/w op) */
>   #define SNDRV_PCM_SYNC_PTR_AVAIL_MIN	(1<<2)	/* get avail_min from driver */
> @@ -547,6 +552,8 @@ enum {
>   #define SNDRV_PCM_IOCTL_READN_FRAMES	_IOR('A', 0x53, struct snd_xfern)
>   #define SNDRV_PCM_IOCTL_LINK		_IOW('A', 0x60, int)
>   #define SNDRV_PCM_IOCTL_UNLINK		_IO('A', 0x61)
> +#define SNDRV_PCM_IOCTL_START_AT        _IOR('A', 0x62, struct snd_clock_time)
> +
>
>   /*****************************************************************************
>    *                                                                           *
> diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
> index 4a7be6c..7051a22 100644
> --- a/src/pcm/pcm.c
> +++ b/src/pcm/pcm.c
> @@ -1084,6 +1084,25 @@ int snd_pcm_start(snd_pcm_t *pcm)
>   }
>
>   /**
> + * \brief Start a PCM at a specified point in the future
> + * \param pcm PCM handle
> + * \param start_time time to start - based on specified clock
> + * \return 0 on success otherwise a negative error code

Let's figure out what the error codes are going to be:

   EINVAL for invalid arguments (broken timespec, invalid clock type)
   ENOSYS if start_at isn't supported in this configuration
   ETIME  if timespec points into the past? Maybe not a great idea...

> + */
> +int snd_pcm_start_at(snd_pcm_t *pcm, snd_clock_time_t *start_at)
> +{
> +        assert(pcm);
> +        assert(start_at);
> +	if (CHECK_SANITY(! pcm->setup)) {
> +		SNDMSG("PCM not set up");
> +		return -EIO;
> +	}
> +        if (pcm->fast_ops->start_at)
> +                return pcm->fast_ops->start_at(pcm->fast_op_arg, start_at);
> +        return -EINVAL;
> +}
> +
> +/**
>    * \brief Stop a PCM dropping pending frames
>    * \param pcm PCM handle
>    * \return 0 on success otherwise a negative error code
> @@ -2444,8 +2463,9 @@ int snd_pcm_wait_nocheck(snd_pcm_t *pcm, int timeout)
>   		                continue;
>   			return -errno;
>                   }
> -		if (! err_poll)
> +		if (! err_poll) {
>   			break;
> +                }
>   		err = snd_pcm_poll_descriptors_revents(pcm, pfd, npfds, &revents);
>   		if (err < 0)
>   			return err;
> diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
> index c34b766..9888253 100644
> --- a/src/pcm/pcm_hw.c
> +++ b/src/pcm/pcm_hw.c
> @@ -620,6 +620,20 @@ static int snd_pcm_hw_start(snd_pcm_t *pcm)
>   	return 0;
>   }
>
> +static int snd_pcm_hw_start_at(snd_pcm_t *pcm, snd_clock_time_t *start_time)
> +{
> +	snd_pcm_hw_t *hw = pcm->private_data;
> +	int err;
> +
> +	sync_ptr(hw, 0);
> +	if (ioctl(hw->fd, SNDRV_PCM_IOCTL_START_AT, start_time) < 0) {
> +		err = -errno;
> +		SYSMSG("SNDRV_PCM_IOCTL_START_AT failed (%i)", err);
> +		return err;
> +	}
> +	return 0;
> +}
> +
>   static int snd_pcm_hw_drop(snd_pcm_t *pcm)
>   {
>   	snd_pcm_hw_t *hw = pcm->private_data;
> @@ -1336,6 +1350,7 @@ static const snd_pcm_fast_ops_t snd_pcm_hw_fast_ops = {
>   	.prepare = snd_pcm_hw_prepare,
>   	.reset = snd_pcm_hw_reset,
>   	.start = snd_pcm_hw_start,
> +	.start_at = snd_pcm_hw_start_at,
>   	.drop = snd_pcm_hw_drop,
>   	.drain = snd_pcm_hw_drain,
>   	.pause = snd_pcm_hw_pause,
> diff --git a/src/pcm/pcm_local.h b/src/pcm/pcm_local.h
> index 394505f..c3e58af 100644
> --- a/src/pcm/pcm_local.h
> +++ b/src/pcm/pcm_local.h
> @@ -154,6 +154,7 @@ typedef struct {
>   	int (*prepare)(snd_pcm_t *pcm);
>   	int (*reset)(snd_pcm_t *pcm);
>   	int (*start)(snd_pcm_t *pcm);
> +	int (*start_at)(snd_pcm_t *pcm, snd_clock_time_t *start_time);
>   	int (*drop)(snd_pcm_t *pcm);
>   	int (*drain)(snd_pcm_t *pcm);
>   	int (*pause)(snd_pcm_t *pcm, int enable);
>
