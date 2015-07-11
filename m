From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [RFC PATCH 1/4] ALSA: core: let low-level driver
 or userspace disable rewinds
Date: Sat, 11 Jul 2015 22:06:43 +0500
Message-ID: <55A14D23.3070600@gmail.com>
References: <1436350236-17509-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1436350236-17509-2-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
 [209.85.212.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 260AA26057C
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2015 19:06:46 +0200 (CEST)
Received: by widjy10 with SMTP id jy10so37467240wid.1
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2015 10:06:45 -0700 (PDT)
In-Reply-To: <1436350236-17509-2-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

08.07.2015 15:10, Pierre-Louis Bossart wrote:
> Add new hw_params flag to explicitly tell driver that rewinds
> will never be used. This can be used by low-level driver to
> optimize DMA operations and reduce power consumption.
> Use this flag only when data written in ring buffer will
> never be invalidated, e.g. any update of appl_ptr is final.
>
> Caveat: there is currently no way to query capabilities without
> opening a pcm stream, so applications might need to serially
> open all exposed devices, check what they support by looking at
> hw_params->info and close them (this is what PulseAudio does so
> might not be an issue)

Thanks for the patch. I was also about to add this flag, for the use in 
userspace. It's good to know that it is also useful in the kernel space.

I usually don't comment on kernel patches, but this one provokes some 
questions and thoughts.

1. What amount of power-saving are we talking about, for Intel chips? 
(ideally, this should be in the commit message)

2. Shouldn't SND_PCM_APPEND (the mode used by dmix and friends) be also 
made incompatible with this flag, because, when mixing, it essentially 
overwrites incompletely-mixed data, i.e. rewinds without saying the word 
"rewind"? Shouldn't all other kinds of freewheeling be made incompatible 
with this flag, because the card, essentially, is never told about the 
application pointer? Or is this a userspace-only concern?

3. I have not seen any justification for the drastic measure of making a 
DMA-based device completely unrewindable. Maybe a more polite "please 
make this a batch/blocktransfer card" request, thus disallowing only 
sub-period rewinds, would still be useful for powersaving, without 
killing dmix.

4. If this "no rewinds" mode is not made the default, then exactly 
nobody will use it. Everyone except sound servers opens the default 
device with the default flags. I understand the potential to break 
existing userspace, especially PulseAudio, but we really need to think 
more here.

So, here is an alternative (or maybe additional - your flag does make 
sense, after all) hackish idea that should be compatible with the 
existing userspace.

Please make it possible to "allow", "put in auto mode" or "disallow" the 
device to DMA up to one period in advance. Please use the following 
logic when in "auto mode":

If the card is batch or blocktransfer "by itself", let it be. We can't 
do anything here, the DMA operations are already "optimized" whether we 
want it or not.

If the card does not support disabling the period wakeup, then FIXME - I 
don't know what to do. For compatibility, I think we can't optimize DMA 
operations here.

If the card supports disabling the period wakeup, and it is disabled, 
then don't allow it to optimize DMA operations.

If the card supports disabling the period wakeup, but it is not 
disabled, then allow it to optimize DMA operations.

As you have probably guessed, the idea here is to detect typical setup 
made by PulseAudio. I suspect that this also affects CRAS.

Also maybe this idea by David Henningsson is good:

"""
E g, if the application sets a low period size
but also sets the "disable period interrupts" flag, that could be an
indicator that it wants lots of interrupts just to update the pointer,
but nothing else. Maybe that's even the behaviour today (haven't checked).
"""

(taken from 
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-September/080885.html 
)

>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>   include/sound/pcm.h         | 1 +
>   include/uapi/sound/asound.h | 1 +
>   sound/core/pcm_native.c     | 8 ++++++++
>   3 files changed, 10 insertions(+)
>
> diff --git a/include/sound/pcm.h b/include/sound/pcm.h
> index 691e7ee..25310b7 100644
> --- a/include/sound/pcm.h
> +++ b/include/sound/pcm.h
> @@ -370,6 +370,7 @@ struct snd_pcm_runtime {
>   	unsigned int rate_num;
>   	unsigned int rate_den;
>   	unsigned int no_period_wakeup: 1;
> +	unsigned int no_rewinds:1;
>
>   	/* -- SW params -- */
>   	int tstamp_mode;		/* mmap timestamp is updated */
> diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
> index a45be6b..b62b162 100644
> --- a/include/uapi/sound/asound.h
> +++ b/include/uapi/sound/asound.h
> @@ -356,6 +356,7 @@ typedef int snd_pcm_hw_param_t;
>   #define SNDRV_PCM_HW_PARAMS_NORESAMPLE	(1<<0)	/* avoid rate resampling */
>   #define SNDRV_PCM_HW_PARAMS_EXPORT_BUFFER	(1<<1)	/* export buffer */
>   #define SNDRV_PCM_HW_PARAMS_NO_PERIOD_WAKEUP	(1<<2)	/* disable period wakeups */
> +#define SNDRV_PCM_HW_PARAMS_NO_REWINDS	        (1<<3)	/* disable rewinds */
>
>   struct snd_interval {
>   	unsigned int min, max;
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index d126c03..a70e52d 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -543,6 +543,8 @@ static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
>   	runtime->no_period_wakeup =
>   			(params->info & SNDRV_PCM_INFO_NO_PERIOD_WAKEUP) &&
>   			(params->flags & SNDRV_PCM_HW_PARAMS_NO_PERIOD_WAKEUP);
> +	runtime->no_rewinds =
> +			params->flags & SNDRV_PCM_HW_PARAMS_NO_REWINDS;
>
>   	bits = snd_pcm_format_physical_width(runtime->format);
>   	runtime->sample_bits = bits;
> @@ -2428,6 +2430,9 @@ static snd_pcm_sframes_t snd_pcm_playback_rewind(struct snd_pcm_substream *subst
>   	if (frames == 0)
>   		return 0;
>
> +	if (runtime->no_rewinds)
> +		return 0;
> +
>   	snd_pcm_stream_lock_irq(substream);
>   	switch (runtime->status->state) {
>   	case SNDRV_PCM_STATE_PREPARED:
> @@ -2476,6 +2481,9 @@ static snd_pcm_sframes_t snd_pcm_capture_rewind(struct snd_pcm_substream *substr
>   	if (frames == 0)
>   		return 0;
>
> +	if (runtime->no_rewinds)
> +		return 0;
> +
>   	snd_pcm_stream_lock_irq(substream);
>   	switch (runtime->status->state) {
>   	case SNDRV_PCM_STATE_PREPARED:
>


-- 
Alexander E. Patrakov
