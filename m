From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 31/40] soundwire: intel: move shutdown()
 callback and don't export symbol
Date: Fri, 2 Aug 2019 12:42:29 -0500
Message-ID: <f189bd38-32ec-ee7d-e0fa-4de108a18ea2@linux.intel.com>
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
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 8/2/19 12:28 PM, Vinod Koul wrote:
> On 26-07-19, 09:46, Pierre-Louis Bossart wrote:
>>
>>
>> On 7/26/19 5:38 AM, Cezary Rojewski wrote:
>>> On 2019-07-26 01:40, Pierre-Louis Bossart wrote:
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

the code does a bunch of get_dma_data() and this seems to work, but 
indeed I don't see where the _set_dma_data() is done. magic.
