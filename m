From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 09/40] soundwire: cadence_master: fix usage of
 CONFIG_UPDATE
Date: Fri, 2 Aug 2019 10:18:52 -0500
Message-ID: <71786692-7bdc-d8f2-676a-b2e955675474@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-10-pierre-louis.bossart@linux.intel.com>
 <20190802120319.GL12733@vkoul-mobl.Dlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190802120319.GL12733@vkoul-mobl.Dlink>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org



On 8/2/19 7:03 AM, Vinod Koul wrote:
> On 25-07-19, 18:40, Pierre-Louis Bossart wrote:
> 
>>   int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
>>   {
>> -	int ret;
>> -
>>   	_cdns_enable_interrupt(cdns);
>> -	ret = cdns_clear_bit(cdns, CDNS_MCP_CONFIG_UPDATE,
>> -			     CDNS_MCP_CONFIG_UPDATE_BIT);
>> -	if (ret < 0)
>> -		dev_err(cdns->dev, "Config update timedout\n");
> 
> I was expecting cdns_update_config() to be invoked here??
> 
>>   
>> -	return ret;
>> +	return 0;
> 
> It would be better if we return a value here a not success always
> 
>> @@ -943,7 +953,10 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
>>   
>>   	cdns_writel(cdns, CDNS_MCP_CONFIG, val);
>>   
>> -	return 0;
>> +	/* commit changes */
>> +	ret = cdns_update_config(cdns);
>> +
>> +	return ret;
> 
> return cdns_update_config()

yes, all of this is fixed already.
