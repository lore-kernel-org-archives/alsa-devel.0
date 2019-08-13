From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH v2 3/5] ASoC: core: add support to
 snd_soc_dai_get_sdw_stream()
Date: Tue, 13 Aug 2019 19:29:50 +0200
Message-ID: <34a1a317-ac6b-bb1e-6b1b-08209f0d1923@intel.com>
References: <20190813083550.5877-1-srinivas.kandagatla@linaro.org>
 <20190813083550.5877-4-srinivas.kandagatla@linaro.org>
 <95c517ab-7c63-5d13-a03a-1db01812bb69@intel.com>
 <71fb21d0-3083-e590-db83-dbe489a4357e@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <71fb21d0-3083-e590-db83-dbe489a4357e@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: vkoul@kernel.org, broonie@kernel.org, bgoswami@codeaurora.org, plai@codeaurora.org, pierre-louis.bossart@linux.intel.com, robh+dt@kernel.org, devicetree@vger.kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, spapothi@codeaurora.org
List-Id: alsa-devel@alsa-project.org

On 2019-08-13 18:52, Srinivas Kandagatla wrote:
> Thanks for the review,
> 
> On 13/08/2019 17:03, Cezary Rojewski wrote:
>> On 2019-08-13 10:35, Srinivas Kandagatla wrote:
>>> On platforms which have smart speaker amplifiers connected via
>>> soundwire and modeled as aux devices in ASoC, in such usecases machine
>>> driver should be able to get sdw master stream from dai so that it can
>>> use the runtime stream to setup slave streams.
>>>
>>> soundwire already as a set function, get function would provide more
>>> flexibility to above configurations.
>>>
>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>> ---

>>> +static inline void *snd_soc_dai_get_sdw_stream(struct snd_soc_dai *dai,
>>> +                           int direction)
>>> +{
>>> +    if (dai->driver->ops->get_sdw_stream)
>>> +        return dai->driver->ops->get_sdw_stream(dai, direction);
>>> +    else
>>> +        return ERR_PTR(-ENOTSUPP);
>>> +}
>>
>> Drop redundant else.
> Not all the dai drivers would implement this function, I guess else is 
> not redundant here!
> 
> --srini
>>

Eh. By that I meant dropping "else" keyword and reducing indentation for 
"return ERR_PTR(-ENOTSUPP);"

Czarek
