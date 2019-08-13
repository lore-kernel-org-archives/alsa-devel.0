From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v2 3/5] ASoC: core: add support to
 snd_soc_dai_get_sdw_stream()
Date: Tue, 13 Aug 2019 12:51:49 -0500
Message-ID: <d2b7773b-d52a-7769-aa5b-ef8c8845d447@linux.intel.com>
References: <20190813083550.5877-1-srinivas.kandagatla@linaro.org>
 <20190813083550.5877-4-srinivas.kandagatla@linaro.org>
 <ba88e0f9-ae7d-c26e-d2dc-83bf910c2c01@linux.intel.com>
 <c2eecd44-f06a-7287-2862-0382bf697f8d@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c2eecd44-f06a-7287-2862-0382bf697f8d@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, vkoul@kernel.org, broonie@kernel.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, plai@codeaurora.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, spapothi@codeaurora.org
List-Id: alsa-devel@alsa-project.org

On 8/13/19 11:50 AM, Srinivas Kandagatla wrote:
> Thanks for the review,
> 
> On 13/08/2019 15:44, Pierre-Louis Bossart wrote:
>> On 8/13/19 3:35 AM, Srinivas Kandagatla wrote:
>>> On platforms which have smart speaker amplifiers connected via
>>> soundwire and modeled as aux devices in ASoC, in such usecases machine
>>> driver should be able to get sdw master stream from dai so that it can
>>> use the runtime stream to setup slave streams.
>>
>> using the _set_sdw_stream? I don't fully get the sequence with the 
>> wording above.
> 
> Yes, using set_sdw_stream().

Maybe I am missing something here, but I don't see where the 
set_sdw_stream() is called.

Also I don't fully get the rule. set_sdw_stream() looks required, 
get_sdw_stream() is optional, is this what you are suggesting?

>>
>>>
>>> soundwire already as a set function, get function would provide more
>>> flexibility to above configurations.
>>
>> I am not clear if you are asking for both to be used, or get only or 
>> set only?
> 
> It depends on the usecase, in db845c usecase  [1] as Aux device is dai 
> less, machine driver is using get function to get hold of master stream 
> so that it can setup slave port config.
> 
> 
> Looks like there is a typo in above like
> 
> This was supposed to be "soundwire already has a set function, get 
> function would provide more flexibility to above configurations"
> 
> [1] 
> https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/tree/sound/soc/qcom/db845c.c?h=integration-linux-qcomlt 
> 
> 
> thanks,
> srini
> 
>>
>>>
>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>> ---
>>>   include/sound/soc-dai.h | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
>>> index dc48fe081a20..1e01f4a302e0 100644
>>> --- a/include/sound/soc-dai.h
>>> +++ b/include/sound/soc-dai.h
>>> @@ -202,6 +202,7 @@ struct snd_soc_dai_ops {
>>>       int (*set_sdw_stream)(struct snd_soc_dai *dai,
>>>               void *stream, int direction);
>>> +    void *(*get_sdw_stream)(struct snd_soc_dai *dai, int direction);
>>>       /*
>>>        * DAI digital mute - optional.
>>>        * Called by soc-core to minimise any pops.
>>> @@ -410,4 +411,13 @@ static inline int 
>>> snd_soc_dai_set_sdw_stream(struct snd_soc_dai *dai,
>>>           return -ENOTSUPP;
>>>   }
>>> +static inline void *snd_soc_dai_get_sdw_stream(struct snd_soc_dai *dai,
>>> +                           int direction)
>>> +{
>>> +    if (dai->driver->ops->get_sdw_stream)
>>> +        return dai->driver->ops->get_sdw_stream(dai, direction);
>>> +    else
>>> +        return ERR_PTR(-ENOTSUPP);
>>> +}
>>> +
>>>   #endif
>>>
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
