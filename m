From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 31/40] soundwire: intel: move shutdown()
 callback and don't export symbol
Date: Fri, 23 Aug 2019 10:57:30 -0500
Message-ID: <0658de0f-c7a5-4a38-5893-e8cb665154d5@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-32-pierre-louis.bossart@linux.intel.com>
 <39318aab-b1b4-2cce-c408-792a5cc343dd@intel.com>
 <ee87d4bb-3f35-eb27-0112-e6e64a09a279@linux.intel.com>
 <20190802172843.GC12733@vkoul-mobl.Dlink>
 <7abdb0e8-b9c4-28c7-d9ed-a7db1574e0b2@linux.intel.com>
 <20190823073407.GF2672@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190823073407.GF2672@vkoul-mobl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, tiwai@suse.de, gregkh@linuxfoundation.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org



>>>>>> +void intel_shutdown(struct snd_pcm_substream *substream,
>>>>>> +            struct snd_soc_dai *dai)
>>>>>> +{
>>>>>> +    struct sdw_cdns_dma_data *dma;
>>>>>> +
>>>>>> +    dma = snd_soc_dai_get_dma_data(dai, substream);
>>>>>> +    if (!dma)
>>>>>> +        return;
>>>>>> +
>>>>>> +    snd_soc_dai_set_dma_data(dai, substream, NULL);
>>>>>> +    kfree(dma);
>>>>>> +}
>>>>>
>>>>> Correct me if I'm wrong, but do we really need to _get_dma_ here?
>>>>> _set_dma_ seems bulletproof, same for kfree.
>>>>
>>>> I must admit I have no idea why we have a reference to DMAs here, this looks
>>>> like an abuse to store a dai-specific context, and the initial test looks
>>>> like copy-paste to detect invalid configs, as done in other callbacks. Vinod
>>>> and Sanyog might have more history than me here.
>>>
>>> I dont see snd_soc_dai_set_dma_data() call for
>>> sdw_cdns_dma_data so somthing is missing (at least in upstream code)
>>>
>>> IIRC we should have a snd_soc_dai_set_dma_data() in alloc or some
>>> initialization routine and we free it here.. Sanyog?
>>
>> Vinod, I double-checked that we do not indeed have a call to
>> snd_soc_dai_dma_data(), but there is code in cdns_set_stream() that sets the
>> relevant dai->playback/capture_dma_data, see below
>>
>> I am not a big fan of this code, touching the ASoC core internal fields
>> isn't a good idea in general.
> 
> IIRC as long as you stick to single link I do not see this required. The
> question comes into picture when we have multi links as you would need
> to allocate a soundwire stream and set that for all the sdw DAIs
> 
> So, what is the current model of soundwire stream, which entity allocates
> that and do you still care about multi-link? is there any machine driver
> with soundwire upstream yet?

yes, multi-link is definitively required and one of the main appeals of 
SoundWire. We have a platform with 2 amplifiers on separate links and 
they need to be synchronized and handled with the stream concept.

The tentative plan would be to move the stream allocation to the dailink 
.init (or equivalent), and make sure each DAI in that link used the same 
stream information. There are dependencies on the multi-cpu concept that 
Morimoto-san wanted to push, so we'll likely be the first users.

For the DAI trigger, we will need to change the existing API so that a 
sdw_stream_enable() can be called multiple times, but only takes effect 
when the .trigger of the first DAI in the stream is invoked. This is a 
similar behavior than with HDaudio .trigger operations when the SYNC 
bits are used.

We will do this when we have a first pass working with all codec drivers 
upstream and a basic machine driver upstream with all 4 links working 
independently.

Everything is done in public btw, you can track our WIP solutions here:

https://github.com/thesofproject/linux/pull/1140
https://github.com/thesofproject/linux/pull/1141
https://github.com/thesofproject/linux/pull/1142
