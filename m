From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 31/40] soundwire: intel: move shutdown()
 callback and don't export symbol
Date: Wed, 14 Aug 2019 14:31:43 -0500
Message-ID: <7abdb0e8-b9c4-28c7-d9ed-a7db1574e0b2@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-32-pierre-louis.bossart@linux.intel.com>
 <39318aab-b1b4-2cce-c408-792a5cc343dd@intel.com>
 <ee87d4bb-3f35-eb27-0112-e6e64a09a279@linux.intel.com>
 <20190802172843.GC12733@vkoul-mobl.Dlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190802172843.GC12733@vkoul-mobl.Dlink>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, tiwai@suse.de, gregkh@linuxfoundation.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org



>>>> +void intel_shutdown(struct snd_pcm_substream *substream,
>>>> +            struct snd_soc_dai *dai)
>>>> +{
>>>> +    struct sdw_cdns_dma_data *dma;
>>>> +
>>>> +    dma = snd_soc_dai_get_dma_data(dai, substream);
>>>> +    if (!dma)
>>>> +        return;
>>>> +
>>>> +    snd_soc_dai_set_dma_data(dai, substream, NULL);
>>>> +    kfree(dma);
>>>> +}
>>>
>>> Correct me if I'm wrong, but do we really need to _get_dma_ here?
>>> _set_dma_ seems bulletproof, same for kfree.
>>
>> I must admit I have no idea why we have a reference to DMAs here, this looks
>> like an abuse to store a dai-specific context, and the initial test looks
>> like copy-paste to detect invalid configs, as done in other callbacks. Vinod
>> and Sanyog might have more history than me here.
> 
> I dont see snd_soc_dai_set_dma_data() call for
> sdw_cdns_dma_data so somthing is missing (at least in upstream code)
> 
> IIRC we should have a snd_soc_dai_set_dma_data() in alloc or some
> initialization routine and we free it here.. Sanyog?

Vinod, I double-checked that we do not indeed have a call to 
snd_soc_dai_dma_data(), but there is code in cdns_set_stream() that sets 
the relevant dai->playback/capture_dma_data, see below

I am not a big fan of this code, touching the ASoC core internal fields 
isn't a good idea in general.

Also not sure why for a DAI we need both _drvdata and _dma_data 
(especially for this case where the information stored has absolutely 
nothing to do with DMAs).

If the idea was to keep a context that is direction-dependent, that's 
likely unnecessary. For the Intel/Cadence case the interfaces can be 
configured as playback OR capture, not both concurrently, so the "dma" 
information could have been stored in the generic DAI _drvdata.

I have other things to look into for now but this code will likely need 
to be cleaned-up at some point to remove unnecessary parts.

int cdns_set_sdw_stream(struct snd_soc_dai *dai,
			void *stream, bool pcm, int direction)
{
	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
	struct sdw_cdns_dma_data *dma;

	dma = kzalloc(sizeof(*dma), GFP_KERNEL);
	if (!dma)
		return -ENOMEM;

	if (pcm)
		dma->stream_type = SDW_STREAM_PCM;
	else
		dma->stream_type = SDW_STREAM_PDM;

	dma->bus = &cdns->bus;
	dma->link_id = cdns->instance;

	dma->stream = stream;

 >>> this is equivalent to snd_soc_dai_dma_data()

	if (direction == SNDRV_PCM_STREAM_PLAYBACK)
		dai->playback_dma_data = dma;
	else
		dai->capture_dma_data = dma;
<<<<
	return 0;
}
EXPORT_SYMBOL(cdns_set_sdw_stream);
