From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [RFC PATCH 3/4] ALSA: core: add report of max dma
 burst
Date: Sat, 11 Jul 2015 22:46:04 +0500
Message-ID: <55A1565C.70004@gmail.com>
References: <1436350236-17509-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1436350236-17509-4-git-send-email-pierre-louis.bossart@linux.intel.com>
 <s5hio9uhg16.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
 [209.85.212.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 1726B260593
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2015 19:46:07 +0200 (CEST)
Received: by wifm2 with SMTP id m2so69978461wif.1
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2015 10:46:06 -0700 (PDT)
In-Reply-To: <s5hio9uhg16.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

08.07.2015 19:37, Takashi Iwai wrote:
> On Wed, 08 Jul 2015 12:10:35 +0200,
> Pierre-Louis Bossart wrote:
>>
>> Report how many bytes the DMA can burst before updating the hw_ptr.
>> This can help fix two issues with stale data discussed many times over
>> on the alsa-devel mailing list (refilling/reading ring buffer too late or
>> rewinding too close to the hw_ptr)
>>
>> FIXME:
>> 1. this was copy/pasted/edited based on the fifo_size fields, not
>> sure why we would need this IOCTL1
>
> fifo_size would fit, but it means that it also changes the current
> behavior.  I don't believe that currently there are many programs
> relying on this value, but who knows.

Debian Code Search knows, if that matters. Result: it is used by 
bindings, wrappers and reimplementations only (lush, oss4, alsa-lib 
itself, pyglet, libtritonus-java).

https://codesearch.debian.net/results/snd_pcm_hw_params_get_fifo_size/page_0

https://codesearch.debian.net/results/snd_pcm_hw_params_get_fifo_size/page_1

>
>> 2. we also need the ability to set the actual fifo size, if suppported,
>> by the hardware, to negociate the prefetch amount between application
>> and driver. By default the default should be max buffering to allow
>> for lower power, but for low-latency use cases we may want to reduce
>> the amount of prefetching.
>
> Right.  So a hw_parmas field looks suitable for that purpose.
>
>
> Takashi
>
>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   include/sound/pcm.h         |  2 ++
>>   include/uapi/sound/asound.h |  5 +++--
>>   sound/core/pcm_lib.c        | 19 +++++++++++++++++++
>>   sound/core/pcm_native.c     |  7 +++++++
>>   4 files changed, 31 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/sound/pcm.h b/include/sound/pcm.h
>> index d5eff03..57c0571 100644
>> --- a/include/sound/pcm.h
>> +++ b/include/sound/pcm.h
>> @@ -56,6 +56,7 @@ struct snd_pcm_hardware {
>>   	unsigned int periods_min;	/* min # of periods */
>>   	unsigned int periods_max;	/* max # of periods */
>>   	size_t fifo_size;		/* fifo size in bytes */
>> +	unsigned int max_dma_burst;     /* max DMA in-flight bytes, linked to hw_ptr precision/fuzziness */
>>   };
>>
>>   struct snd_pcm_substream;
>> @@ -106,6 +107,7 @@ struct snd_pcm_ops {
>>   #define SNDRV_PCM_IOCTL1_CHANNEL_INFO	2
>>   #define SNDRV_PCM_IOCTL1_GSTATE		3
>>   #define SNDRV_PCM_IOCTL1_FIFO_SIZE	4
>> +#define SNDRV_PCM_IOCTL1_MAX_DMA_BURST	5
>>
>>   #define SNDRV_PCM_TRIGGER_STOP		0
>>   #define SNDRV_PCM_TRIGGER_START		1
>> diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
>> index b62b162..3dc049a 100644
>> --- a/include/uapi/sound/asound.h
>> +++ b/include/uapi/sound/asound.h
>> @@ -386,8 +386,9 @@ struct snd_pcm_hw_params {
>>   	unsigned int msbits;		/* R: used most significant bits */
>>   	unsigned int rate_num;		/* R: rate numerator */
>>   	unsigned int rate_den;		/* R: rate denominator */
>> -	snd_pcm_uframes_t fifo_size;	/* R: chip FIFO size in frames */
>> -	unsigned char reserved[64];	/* reserved for future */
>> +	snd_pcm_uframes_t fifo_size;	/* R: chip FIFO size in frames, indicates buffering after hw_ptr */
>> +	unsigned int max_dma_burst;     /* R: max in-flight bytes, indicates buffering before hw_ptr */
>> +	unsigned char reserved[60];	/* reserved for future */
>>   };
>>
>>   enum {
>> diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
>> index 7d45645..dc89aa0 100644
>> --- a/sound/core/pcm_lib.c
>> +++ b/sound/core/pcm_lib.c
>> @@ -1826,6 +1826,22 @@ static int snd_pcm_lib_ioctl_fifo_size(struct snd_pcm_substream *substream,
>>   	return 0;
>>   }
>>
>> +static int snd_pcm_lib_ioctl_max_dma_burst(struct snd_pcm_substream *substream,
>> +					      void *arg)
>> +{
>> +	struct snd_pcm_hw_params *params = arg;
>> +
>> +	/* FIXME: add sanity checks:
>> +	 * max burst < ring buffer
>> +	 * max burst >= min_period_size
>> +	 * not sure if we can check against period sizes?
>> +	 * any others ?
>> +	 */
>> +	params->max_dma_burst = substream->runtime->hw.max_dma_burst;
>> +
>> +	return 0;
>> +}
>> +
>>   /**
>>    * snd_pcm_lib_ioctl - a generic PCM ioctl callback
>>    * @substream: the pcm substream instance
>> @@ -1849,6 +1865,9 @@ int snd_pcm_lib_ioctl(struct snd_pcm_substream *substream,
>>   		return snd_pcm_lib_ioctl_channel_info(substream, arg);
>>   	case SNDRV_PCM_IOCTL1_FIFO_SIZE:
>>   		return snd_pcm_lib_ioctl_fifo_size(substream, arg);
>> +	case SNDRV_PCM_IOCTL1_MAX_DMA_BURST:
>> +		return snd_pcm_lib_ioctl_max_dma_burst(substream, arg);
>> +
>>   	}
>>   	return -ENXIO;
>>   }
>> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
>> index dd519b8..3d379b8 100644
>> --- a/sound/core/pcm_native.c
>> +++ b/sound/core/pcm_native.c
>> @@ -280,6 +280,7 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
>>
>>   	params->info = 0;
>>   	params->fifo_size = 0;
>> +	params->max_dma_burst = 0;
>>   	if (params->rmask & (1 << SNDRV_PCM_HW_PARAM_SAMPLE_BITS))
>>   		params->msbits = 0;
>>   	if (params->rmask & (1 << SNDRV_PCM_HW_PARAM_RATE)) {
>> @@ -437,6 +438,12 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
>>   				return changed;
>>   		}
>>   	}
>> +	if (!params->max_dma_burst) {
>> +		changed = substream->ops->ioctl(substream,
>> +						SNDRV_PCM_IOCTL1_MAX_DMA_BURST, params);
>> +		if (changed < 0)
>> +			return changed;
>> +	}
>>   	params->rmask = 0;
>>   	return 0;
>>   }
>> --
>> 1.9.1
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
