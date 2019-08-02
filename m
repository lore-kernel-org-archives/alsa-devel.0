From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 06/40] soundwire: intel: prevent possible
 dereference in hw_params
Date: Fri, 2 Aug 2019 11:52:26 -0500
Message-ID: <884a13fc-08eb-10c9-de9c-50cf38ff533d@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-7-pierre-louis.bossart@linux.intel.com>
 <20190802115537.GI12733@vkoul-mobl.Dlink>
 <6da5aeef-40bf-c9bb-fc18-4ac0b3961857@linux.intel.com>
 <20190802155738.GR12733@vkoul-mobl.Dlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190802155738.GR12733@vkoul-mobl.Dlink>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org



On 8/2/19 10:57 AM, Vinod Koul wrote:
> On 02-08-19, 10:16, Pierre-Louis Bossart wrote:
>>
>>
>> On 8/2/19 6:55 AM, Vinod Koul wrote:
>>> On 25-07-19, 18:39, Pierre-Louis Bossart wrote:
>>>> This should not happen in production systems but we should test for
>>>> all callback arguments before invoking the config_stream callback.
>>>
>>> so you are saying callback arg is mandatory, if so please document that
>>> assumption
>>
>> no, what this says is that if a config_stream is provided then it needs to
>> have a valid argument.
> 
> well typically args are not mandatory..
> 
>> I am not sure what you mean by "document that assumption", comment in the
>> code (where?) or SoundWire documentation?
> 
> The callback documentation which in this is in include/linux/soundwire/sdw_intel.h
> 

/**
  * struct sdw_intel_ops: Intel audio driver callback ops
  *
  * @config_stream: configure the stream with the hw_params
  */
struct sdw_intel_ops {
	int (*config_stream)(void *arg, void *substream,
			     void *dai, void *hw_params, int stream_num);
};

all parameters are mandatory really, not sure what you are trying to get at.
