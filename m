From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 06/40] soundwire: intel: prevent possible
 dereference in hw_params
Date: Fri, 26 Jul 2019 09:02:30 -0500
Message-ID: <f7cc450c-5a87-4ee3-ff35-e588d03da7d8@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-7-pierre-louis.bossart@linux.intel.com>
 <1e814ab9-9606-88a5-3181-6cdb203671c3@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1e814ab9-9606-88a5-3181-6cdb203671c3@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org


>> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
>> index 68832e613b1e..497879dd9c0d 100644
>> --- a/drivers/soundwire/intel.c
>> +++ b/drivers/soundwire/intel.c
>> @@ -509,7 +509,7 @@ static int intel_config_stream(struct sdw_intel *sdw,
>>                      struct snd_soc_dai *dai,
>>                      struct snd_pcm_hw_params *hw_params, int link_id)
>>   {
>> -    if (sdw->res->ops && sdw->res->ops->config_stream)
>> +    if (sdw->res->ops && sdw->res->ops->config_stream && sdw->res->arg)
>>           return sdw->res->ops->config_stream(sdw->res->arg,
>>                   substream, dai, hw_params, link_id);
>>
> 
> Hmm, declaring local for sdw->res should prove useful here after 
> addition of 4th sdw->res dereference.

yes, it's an eyesore. I added this to quickly fix a kernel oops while 
debugging, will simplify. thanks for the note.
