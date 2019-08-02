From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 07/40] soundwire: intel: fix channel number reported
 by hardware
Date: Fri, 2 Aug 2019 10:18:02 -0500
Message-ID: <c8c035fd-9a68-260b-7909-66a43695cea0@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-8-pierre-louis.bossart@linux.intel.com>
 <20190802115719.GJ12733@vkoul-mobl.Dlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190802115719.GJ12733@vkoul-mobl.Dlink>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org



On 8/2/19 6:57 AM, Vinod Koul wrote:
> On 25-07-19, 18:39, Pierre-Louis Bossart wrote:
>> PDI2 reports an invalid count, force the correct hardware-supported
>> value
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/soundwire/intel.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
>> index 497879dd9c0d..51990b192dc0 100644
>> --- a/drivers/soundwire/intel.c
>> +++ b/drivers/soundwire/intel.c
>> @@ -401,6 +401,15 @@ intel_pdi_get_ch_cap(struct sdw_intel *sdw, unsigned int pdi_num, bool pcm)
>>   
>>   	if (pcm) {
>>   		count = intel_readw(shim, SDW_SHIM_PCMSYCHC(link_id, pdi_num));
>> +
>> +		/*
>> +		 * TODO: pdi number 2 reports channel count as 1 even though
>> +		 * it supports 8 channel. Performing hardcoding for pdi
>> +		 * number 2.
>> +		 */
>> +		if (pdi_num == 2)
>> +			count = 7;
> 
> Is that true for all Intel controllers or some generations. Would it not
> be better to put this under some flag which is set on platform basis?

This is true of all controllers released so far.
We will change this if the hardware changes.

> 
>> +
>>   	} else {
>>   		count = intel_readw(shim, SDW_SHIM_PDMSCAP(link_id));
>>   		count = ((count & SDW_SHIM_PDMSCAP_CPSS) >>
>> -- 
>> 2.20.1
> 
