From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v2] ALSA: core: let low-level driver or
 userspace disable rewinds
Date: Mon, 12 Jun 2017 15:35:38 +0900
Message-ID: <f0167d08-b11d-b687-3016-2128c82748ad@sakamocchi.jp>
References: <1497245230-18436-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 0D6B1266DF2
 for <alsa-devel@alsa-project.org>; Mon, 12 Jun 2017 08:35:41 +0200 (CEST)
In-Reply-To: <1497245230-18436-1-git-send-email-subhransu.s.prusty@intel.com>
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
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, lgirdwood@gmail.com, Ramesh Babu <ramesh.babu@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

I have a question to your patch, in a point of the relationship between 
queued PCM frames and position of appl_ptr.

On Jun 12 2017 14:27, Subhransu S. Prusty wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Add new hw_params flag to explicitly tell driver that rewinds will never
> be used. This can be used by low-level driver to optimize DMA operations
> and reduce power consumption. Use this flag only when data written in
> ring buffer will never be invalidated, e.g. any update of appl_ptr is
> final.
> 
> Note that the update of appl_ptr include both a read/write data
> operation as well as snd_pcm_forward() whose behavior is not modified.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
> Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> ---
> 
> v1->v2: No change
> 
> Since the ack callback change is now dropped and "ALSA: pcm: conditionally
> avoid mmap of control data" will be dropped with recent change "ALSA: pcm:
> Suppress status/control mmap when ack ops is present", I think this patch
> can be merged independently.
> 
>   include/sound/pcm.h         | 1 +
>   include/uapi/sound/asound.h | 1 +
>   sound/core/pcm_native.c     | 8 ++++++++
>   3 files changed, 10 insertions(+)
> 
> diff --git a/include/sound/pcm.h b/include/sound/pcm.h
> index 79fedf517070..c1e2b87cd409 100644
> --- a/include/sound/pcm.h
> +++ b/include/sound/pcm.h
> @@ -368,6 +368,7 @@ struct snd_pcm_runtime {
>   	unsigned int rate_num;
>   	unsigned int rate_den;
>   	unsigned int no_period_wakeup: 1;
> +	unsigned int no_rewinds:1;
>   
>   	/* -- SW params -- */
>   	int tstamp_mode;		/* mmap timestamp is updated */
> diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
> index fd41697cb4d3..c697ff90450d 100644
> --- a/include/uapi/sound/asound.h
> +++ b/include/uapi/sound/asound.h
> @@ -365,6 +365,7 @@ struct snd_pcm_info {
>   #define SNDRV_PCM_HW_PARAMS_NORESAMPLE	(1<<0)	/* avoid rate resampling */
>   #define SNDRV_PCM_HW_PARAMS_EXPORT_BUFFER	(1<<1)	/* export buffer */
>   #define SNDRV_PCM_HW_PARAMS_NO_PERIOD_WAKEUP	(1<<2)	/* disable period wakeups */
> +#define SNDRV_PCM_HW_PARAMS_NO_REWINDS	        (1<<3)	/* disable rewinds */
>   
>   struct snd_interval {
>   	unsigned int min, max;
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index bf5d0f2acfb9..0e8b7ea0d38d 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -554,6 +554,8 @@ static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
>   	runtime->no_period_wakeup =
>   			(params->info & SNDRV_PCM_INFO_NO_PERIOD_WAKEUP) &&
>   			(params->flags & SNDRV_PCM_HW_PARAMS_NO_PERIOD_WAKEUP);
> +	runtime->no_rewinds =
> +		(params->flags & SNDRV_PCM_HW_PARAMS_NO_REWINDS) ? 1 : 0;
>   
>   	bits = snd_pcm_format_physical_width(runtime->format);
>   	runtime->sample_bits = bits;
> @@ -2521,6 +2523,9 @@ static snd_pcm_sframes_t snd_pcm_playback_rewind(struct snd_pcm_substream *subst
>   	if (frames == 0)
>   		return 0;
>   
> +	if (runtime->no_rewinds)
> +		return 0;
> +
>   	snd_pcm_stream_lock_irq(substream);
>   	ret = do_pcm_hwsync(substream);
>   	if (!ret)
> @@ -2539,6 +2544,9 @@ static snd_pcm_sframes_t snd_pcm_capture_rewind(struct snd_pcm_substream *substr
>   	if (frames == 0)
>   		return 0;
>   
> +	if (runtime->no_rewinds)
> +		return 0;
> +
>   	snd_pcm_stream_lock_irq(substream);
>   	ret = do_pcm_hwsync(substream);
>   	if (!ret)

In my understanding, your intention for this patch is to prevent queue 
PCM frames in PCM buffer from being dropped. You have a plan to use 
'struct snd_pcm_ops.ack' to notify the number of available PCM frames in 
the buffer to your hardware. I don't know exactly about design of your 
hardware because Intel developers never declare it.

Well, For playback PCM substream, the patch satisfies your intension. On 
the other hand, for capture PCM substream, it doesn't.

See below diagram. In this case, one PCM buffer consists of three 
period. The 'equal' sign represents queued PCM frames. You can see the 
relationship between hwptr and applptr is inverse for playback/capture 
substream.

For playback:
0       1p       2p       3p
|--======|========|==------|
   ^                  ^
   hwptr              applptr

For capture:
0       1p       2p       3p
|-----===|========|=====---|
      ^                 ^
      applptr           hwptr

When operate rewinding, for playback substream, some queued PCM frames 
are dropped.

For playback:
0       1p       2p       3p
|--======|===_____|__------|
   ^          ^
   hwptr      applptr<-

The underscore sign represents the dropped PCM frames. But for capture 
substream, no queued PCM frames are dropped.

For capture:
0       1p       2p       3p
|#####===|========|=====---|
  ^                      ^
  applptr<-              hwptr

The sharp sign represent PCM frames which are available again for the 
application.

In your case, for capture substream, 'forward' operation should be 
avoided because it can drop queued PCM frames.

For capture:
0       1p       2p       3p
|-----___|__======|=====---|
            ^           ^
          ->applptr     hwptr

If data transmission in your hardware somehow depends on a callback of 
'struct snd_pcm_ops.ack()'. I can imagine a unit of data transmission as 
an disadvantage of the forward operation.

If describing the detail design of your hardware, you might get more helps.

  * I intentionally ignore discussion about burstness of data
    transmission and accuracy of hwptr.


Regards

Takashi Sakamoto
