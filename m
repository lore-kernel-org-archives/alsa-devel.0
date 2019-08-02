From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 06/40] soundwire: intel: prevent possible
 dereference in hw_params
Date: Fri, 2 Aug 2019 10:16:08 -0500
Message-ID: <6da5aeef-40bf-c9bb-fc18-4ac0b3961857@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-7-pierre-louis.bossart@linux.intel.com>
 <20190802115537.GI12733@vkoul-mobl.Dlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190802115537.GI12733@vkoul-mobl.Dlink>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org



On 8/2/19 6:55 AM, Vinod Koul wrote:
> On 25-07-19, 18:39, Pierre-Louis Bossart wrote:
>> This should not happen in production systems but we should test for
>> all callback arguments before invoking the config_stream callback.
> 
> so you are saying callback arg is mandatory, if so please document that
> assumption

no, what this says is that if a config_stream is provided then it needs 
to have a valid argument.

I am not sure what you mean by "document that assumption", comment in 
the code (where?) or SoundWire documentation?

> 
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/soundwire/intel.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
>> index 68832e613b1e..497879dd9c0d 100644
>> --- a/drivers/soundwire/intel.c
>> +++ b/drivers/soundwire/intel.c
>> @@ -509,7 +509,7 @@ static int intel_config_stream(struct sdw_intel *sdw,
>>   			       struct snd_soc_dai *dai,
>>   			       struct snd_pcm_hw_params *hw_params, int link_id)
>>   {
>> -	if (sdw->res->ops && sdw->res->ops->config_stream)
>> +	if (sdw->res->ops && sdw->res->ops->config_stream && sdw->res->arg)
>>   		return sdw->res->ops->config_stream(sdw->res->arg,
>>   				substream, dai, hw_params, link_id);
>>   
>> -- 
>> 2.20.1
> 
