From: David Henningsson <diwic@ubuntu.com>
Subject: Re: [PATCH] pcm_hw: Respect LIBASOUND_THREAD_SAFE env
	var
Date: Thu, 1 Sep 2016 21:40:50 +0200
Message-ID: <23fcfe7b-d833-72a8-2a2e-245522ad23ce@ubuntu.com>
References: <1472710010-16951-1-git-send-email-diwic@ubuntu.com>
 <s5hvaygp0yl.wl-tiwai@suse.de> <s5hlgzbpzw6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.egensajt.se (smtp.egensajt.se [193.42.159.246])
 by alsa0.perex.cz (Postfix) with ESMTP id BCE1E2671D5
 for <alsa-devel@alsa-project.org>; Thu,  1 Sep 2016 21:40:53 +0200 (CEST)
In-Reply-To: <s5hlgzbpzw6.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: samuel.thibault@ens-lyon.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 2016-09-01 14:28, Takashi Iwai wrote:
> On Thu, 01 Sep 2016 08:51:14 +0200,
> Takashi Iwai wrote:
>>
>> On Thu, 01 Sep 2016 08:06:50 +0200,
>> David Henningsson wrote:
>>>
>>> Without this patch, there no way to revert to the old
>>> behaviour with pcm_hw, so currently there will always
>>> be some extra locking.
>>>
>>> This seems to be an oversight?
>>
>> thread_safe=1 means that the plugin needs no locking, so it means hw
>> PCM never takes a lock by itself.  Only other plugins do, and it's
>> suppressed when $LIBASOUND_THREAD_SAFE=0 is passed.
>>
>> The flag needs a better description or a better name...
>
> So here we go, let's decrypt the monkey code.
> Let me know if this is good enough.

This is better, indeed. It also fixes the bug I sent a patch for 
(Respect LIBASOUND_THREAD_SAFE env var).

It's perhaps a bit inconsistent that "true" is -1 for lock_enabled and 1 
for need_lock, but that's just a nitpick.

Since many calls to __snd_pcm_lock has the comment "forced lock" perhaps 
it can be renamed to snd_pcm_lock_forced, and snd_pcm_lock can perhaps 
be snd_pcm_lock_if_needed?

>
>
> Takashi
>
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] pcm: Better understandable locking code
>
> The newly added locking code seems to have confused quite a few
> people, as "thread_safe=1" may be considered as if the thread-safety
> lock has to be turned on.  (It meant that the plugin _is_ thread-safe,
> i.e. it needs no extra locking.)
>
> For avoiding such a misunderstanding, this commit renames the relevant
> pcm fields and give more comments to explain what is for what.
> The former single pcm->thread_safe flag is now split to two boolean
> flags, pcm->need_lock and pcm->lock_enabled.  It consumes a few more
> bytes, but this would be (hopefully) better understandable.
>
> No functional change by this commit.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  src/pcm/pcm.c       | 16 +++++++++++-----
>  src/pcm/pcm_hw.c    |  2 +-
>  src/pcm/pcm_local.h | 27 ++++++++++++++++++++++-----
>  3 files changed, 34 insertions(+), 11 deletions(-)
>
> diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
> index f8323999343e..c96ae1c4641a 100644
> --- a/src/pcm/pcm.c
> +++ b/src/pcm/pcm.c
> @@ -2545,14 +2545,20 @@ int snd_pcm_new(snd_pcm_t **pcmp, snd_pcm_type_t type, const char *name,
>  	INIT_LIST_HEAD(&pcm->async_handlers);
>  #ifdef THREAD_SAFE_API
>  	pthread_mutex_init(&pcm->lock, NULL);
> +	/* use locking as default;
> +	 * each plugin may suppress this in its open call
> +	 */
> +	pcm->need_lock = 1;
>  	{
> -		static int default_thread_safe = -1;
> -		if (default_thread_safe < 0) {
> +		/* set lock_enabled field depending on $LIBASOUND_THREAD_SAFE;
> +		 * it's evaluated only once at the first open for consistency
> +		 */
> +		static int do_lock_enable = -1;
> +		if (do_lock_enable < 0) {
>  			char *p = getenv("LIBASOUND_THREAD_SAFE");
> -			default_thread_safe = !p || *p != '0';
> +			do_lock_enable = !p || *p != '0';
>  		}
> -		if (!default_thread_safe)
> -			pcm->thread_safe = -1; /* force to disable */
> +		pcm->lock_enabled = do_lock_enable;
>  	}
>  #endif
>  	*pcmp = pcm;
> diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
> index 3a5634c1d39a..56e88b6bf6c0 100644
> --- a/src/pcm/pcm_hw.c
> +++ b/src/pcm/pcm_hw.c
> @@ -1514,7 +1514,7 @@ int snd_pcm_hw_open_fd(snd_pcm_t **pcmp, const char *name,
>  	pcm->poll_events = info.stream == SND_PCM_STREAM_PLAYBACK ? POLLOUT : POLLIN;
>  	pcm->tstamp_type = tstamp_type;
>  #ifdef THREAD_SAFE_API
> -	pcm->thread_safe = 1;
> +	pcm->need_lock = 0;	/* hw plugin is thread-safe */
>  #endif
>
>  	ret = snd_pcm_hw_mmap_status(pcm);
> diff --git a/src/pcm/pcm_local.h b/src/pcm/pcm_local.h
> index bb7964d7833e..bba2f15ac463 100644
> --- a/src/pcm/pcm_local.h
> +++ b/src/pcm/pcm_local.h
> @@ -244,7 +244,12 @@ struct _snd_pcm {
>  	void *private_data;
>  	struct list_head async_handlers;
>  #ifdef THREAD_SAFE_API
> -	int thread_safe;
> +	int need_lock;		/* true = this PCM (plugin) is thread-unsafe,
> +				 * thus it needs a lock.
> +				 */
> +	int lock_enabled;	/* thread-safety lock is enabled on the system;
> +				 * it's set depending on $LIBASOUND_THREAD_SAFE.
> +				 */
>  	pthread_mutex_t lock;
>  #endif
>  };
> @@ -1085,24 +1090,36 @@ static inline void sw_set_period_event(snd_pcm_sw_params_t *params, int val)
>  #define PCMINABORT(pcm) (((pcm)->mode & SND_PCM_ABORT) != 0)
>
>  #ifdef THREAD_SAFE_API
> +/*
> + * __snd_pcm_lock() and __snd_pcm_unlock() are used to lock/unlock the plugin
> + * forcibly even if it's declared as thread-safe.  It's needed only for some
> + * codes that are thread-unsafe per design (e.g. snd_pcm_nonblock()).
> + *
> + * OTOH, snd_pcm_lock() and snd_pcm_unlock() are used to lock/unlock the plugin
> + * in normal situations.  They do lock/unlock only when the plugin is
> + * thread-unsafe.
> + *
> + * Both __snd_pcm_lock() and snd_pcm_lock() (and their unlocks) wouldn't do
> + * any action when the whole locking is disabled via $LIBASOUND_THREAD_SAFE=0.
> + */
>  static inline void __snd_pcm_lock(snd_pcm_t *pcm)
>  {
> -	if (pcm->thread_safe >= 0)
> +	if (pcm->lock_enabled)
>  		pthread_mutex_lock(&pcm->lock);
>  }
>  static inline void __snd_pcm_unlock(snd_pcm_t *pcm)
>  {
> -	if (pcm->thread_safe >= 0)
> +	if (pcm->lock_enabled)
>  		pthread_mutex_unlock(&pcm->lock);
>  }
>  static inline void snd_pcm_lock(snd_pcm_t *pcm)
>  {
> -	if (!pcm->thread_safe)
> +	if (pcm->lock_enabled && pcm->need_lock)
>  		pthread_mutex_lock(&pcm->lock);
>  }
>  static inline void snd_pcm_unlock(snd_pcm_t *pcm)
>  {
> -	if (!pcm->thread_safe)
> +	if (pcm->lock_enabled && pcm->need_lock)
>  		pthread_mutex_unlock(&pcm->lock);
>  }
>  #else /* THREAD_SAFE_API */
>
