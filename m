From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 kernel 1/3] snd_pcm_start_at and friends.
Date: Fri, 06 Feb 2015 10:32:53 -0600
Message-ID: <54D4ECB5.5060606@linux.intel.com>
References: <1423239388-17745-1-git-send-email-timcussins@eml.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 7465426060A
 for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2015 17:33:38 +0100 (CET)
In-Reply-To: <1423239388-17745-1-git-send-email-timcussins@eml.cc>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tim Cussins <timcussins@eml.cc>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/06/2015 10:16 AM, Tim Cussins wrote:
> We introduce the kernel-side of the START_AT ioctl.
> 
> struct runtime is updated to hold information about the currently
> active start_at timer, if any. This facilitates cancellation via
> snd_pcm_start_at_abort(), and querying via snd_pcm_status().
> 
> struct snd_start_at holds a startat operation and its arguments.
> 
> Signed-off-by: Tim Cussins <timcussins@eml.cc>
> 
> diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
> index 0e88e7a..2943e1a 100644
> --- a/include/uapi/sound/asound.h
> +++ b/include/uapi/sound/asound.h
> @@ -421,7 +421,10 @@ struct snd_pcm_status {
>  	snd_pcm_state_t suspended_state; /* suspended stream state */
>  	__u32 reserved_alignment;	/* must be filled with zero */
>  	struct timespec audio_tstamp;	/* from sample counter or wall clock */
> -	unsigned char reserved[56-sizeof(struct timespec)]; /* must be filled with zero */
> +	int startat_pending;		/* 1 if a start_at timer is pending, 0 otherwise */
> +	int startat_clock_type;		/* start_at clock type, if pending */
> +	struct timespec startat_start_time;	/* start_at start time, if pending */
> +	unsigned char reserved[48-(2*sizeof(struct timespec))]; /* must be filled with zero */
>  };
>  
>  struct snd_pcm_mmap_status {
> @@ -473,6 +476,34 @@ enum {
>  	SNDRV_PCM_TSTAMP_TYPE_LAST = SNDRV_PCM_TSTAMP_TYPE_MONOTONIC_RAW,
>  };
>  
> +enum {
> +	SNDRV_PCM_STARTAT_OP_SET = 0,
> +	SNDRV_PCM_STARTAT_OP_CANCEL,
> +	SNDRV_PCM_STARTAT_OP_STATUS,
> +	SNDRV_PCM_STARTAT_OP_LAST = SNDRV_PCM_STARTAT_OP_STATUS,
> +};
> +
> +enum {
> +        SNDRV_PCM_STARTAT_CLOCK_TYPE_GETTIMEOFDAY = 0,
> +        SNDRV_PCM_STARTAT_CLOCK_TYPE_MONOTONIC,
> +        SNDRV_PCM_STARTAT_CLOCK_TYPE_LINK,
> +        SNDRV_PCM_STARTAT_CLOCK_TYPE_LAST = SNDRV_PCM_STARTAT_CLOCK_TYPE_LINK,
> +};

Looks like you went back to the original design with all clocks mixed. I think it's a better idea to split system timers and audio clocks.
And you are missing MONOTONIC_RAW (no NTP corrections).

> +
> +struct snd_start_at {
> +	int op;				/* startat operation to be performed */
> +	union {				/* fields for setting a startat timer */
> +		struct {
> +			int clock_type;			/* clock type e.g. SNDRV_PCM_STARTAT_CLOCK_TYPE_GETTIMEOFDAY */
> +			struct timespec start_time;	/* start time */
> +		} set;
> +		struct {
> +			int clock_type;
> +			struct timespec current_time;
> +		} status;
> +	} args;
> +};
> +
>  /* channel positions */
>  enum {
>  	SNDRV_CHMAP_UNKNOWN = 0,
> @@ -551,6 +582,8 @@ enum {
>  #define SNDRV_PCM_IOCTL_READN_FRAMES	_IOR('A', 0x53, struct snd_xfern)
>  #define SNDRV_PCM_IOCTL_LINK		_IOW('A', 0x60, int)
>  #define SNDRV_PCM_IOCTL_UNLINK		_IO('A', 0x61)
> +#define SNDRV_PCM_IOCTL_START_AT        _IOW('A', 0x62, struct snd_start_at)
> +
>  
>  /*****************************************************************************
>   *                                                                           *
> 
