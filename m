From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 3/3] ALSA: pcm: Add timestamp type to
	sw_params
Date: Thu, 10 Jul 2014 10:23:37 -0500
Message-ID: <53BEAFF9.5070501@linux.intel.com>
References: <1404997458-15377-1-git-send-email-tiwai@suse.de>
 <1404997458-15377-4-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F70E2655DC
 for <alsa-devel@alsa-project.org>; Thu, 10 Jul 2014 17:23:41 +0200 (CEST)
In-Reply-To: <1404997458-15377-4-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Mark Brown <broonie@kernel.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On 7/10/14, 8:04 AM, Takashi Iwai wrote:
> For allowing adjusting the timestamp type on the fly, add it to
> sw_params.  The existing ioctl is still kept for compatibility.

I have strong objections to this extension. It will result in a 
discontinuity in the timestamps reported in pcm_status without a clear 
indication of what timestamp is reported (when does this change occur?), 
and it's completely unclear how userspace would handle a step (positive 
or negative) between ntp-adjusted and non-ntp-adjusted times. For apps 
that make use of the audio_time reported with a wall clock this could 
lead to complete nonsense.
I would have no problems if this was a fixed parameter defined once 
before audio streaming starts.

>
> Along with this, increment the PCM protocol version.
>
> The extension was suggested by Clemens Ladisch.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   include/uapi/sound/asound.h | 6 ++++--
>   sound/core/pcm_native.c     | 3 +++
>   2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
> index cbf7dc850a46..a7e062f91f39 100644
> --- a/include/uapi/sound/asound.h
> +++ b/include/uapi/sound/asound.h
> @@ -139,7 +139,7 @@ struct snd_hwdep_dsp_image {
>    *                                                                           *
>    *****************************************************************************/
>
> -#define SNDRV_PCM_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 11)
> +#define SNDRV_PCM_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 12)
>
>   typedef unsigned long snd_pcm_uframes_t;
>   typedef signed long snd_pcm_sframes_t;
> @@ -391,7 +391,9 @@ struct snd_pcm_sw_params {
>   	snd_pcm_uframes_t silence_threshold;	/* min distance from noise for silence filling */
>   	snd_pcm_uframes_t silence_size;		/* silence block size */
>   	snd_pcm_uframes_t boundary;		/* pointers wrap point */
> -	unsigned char reserved[64];		/* reserved for future */
> +	unsigned int tstamp_type;		/* timestamp type */
> +	int pads;				/* alignment, reserved */
> +	unsigned char reserved[56];		/* reserved for future */
>   };
>
>   struct snd_pcm_channel_info {
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index 2372c49a8e84..81dedc381efd 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -543,6 +543,8 @@ static int snd_pcm_sw_params(struct snd_pcm_substream *substream,
>
>   	if (params->tstamp_mode > SNDRV_PCM_TSTAMP_LAST)
>   		return -EINVAL;
> +	if (params->tstamp_type > SNDRV_PCM_TSTAMP_TYPE_LAST)
> +		return -EINVAL;
>   	if (params->avail_min == 0)
>   		return -EINVAL;
>   	if (params->silence_size >= runtime->boundary) {
> @@ -557,6 +559,7 @@ static int snd_pcm_sw_params(struct snd_pcm_substream *substream,
>   	err = 0;
>   	snd_pcm_stream_lock_irq(substream);
>   	runtime->tstamp_mode = params->tstamp_mode;
> +	runtime->tstamp_type = params->tstamp_type;
>   	runtime->period_step = params->period_step;
>   	runtime->control->avail_min = params->avail_min;
>   	runtime->start_threshold = params->start_threshold;
>
