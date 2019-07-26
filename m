From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 15/40] soundwire: cadence_master: handle
 multiple status reports per Slave
Date: Fri, 26 Jul 2019 09:09:56 -0500
Message-ID: <fe63b365-5251-fab0-ab7f-bb2290534e4b@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-16-pierre-louis.bossart@linux.intel.com>
 <20190725223100.GC16003@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725223100.GC16003@ubuntu>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org


>> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
>> index 889fa2cd49ae..25d5c7267c15 100644
>> --- a/drivers/soundwire/cadence_master.c
>> +++ b/drivers/soundwire/cadence_master.c
>> @@ -643,13 +643,35 @@ static int cdns_update_slave_status(struct sdw_cdns *cdns,
>>   
>>   		/* first check if Slave reported multiple status */
>>   		if (set_status > 1) {
>> +			u32 val;
>> +
>>   			dev_warn_ratelimited(cdns->dev,
>> -					     "Slave reported multiple Status: %d\n",
>> -					     mask);
>> -			/*
>> -			 * TODO: we need to reread the status here by
>> -			 * issuing a PING cmd
>> -			 */
>> +					     "Slave %d reported multiple Status: %d\n",
>> +					     i, mask);
>> +
>> +			/* re-check latest status extracted from PING commands */
>> +			val = cdns_readl(cdns, CDNS_MCP_SLAVE_STAT);
>> +			val >>= (i * 2);
> 
> Superfluous parentheses.

Humm, I don't know my left from my right and I can't remember operator 
precedence, so i'd rather make it explicit...

> 
>> +
>> +			switch (val & 0x3) {
>> +			case 0:
>> +				status[i] = SDW_SLAVE_UNATTACHED;
>> +				break;
>> +			case 1:
>> +				status[i] = SDW_SLAVE_ATTACHED;
>> +				break;
>> +			case 2:
>> +				status[i] = SDW_SLAVE_ALERT;
>> +				break;
>> +			default:
> 
> There aren't many values left for the "default" case :-) But I'm not sure whether
> any of
> 
> +			case 3:
> 
> or
> 
> +			case 3:
> +			default:
> 
> would improve readability.
> 
> Thanks
> Guennadi
> 
>> +				status[i] = SDW_SLAVE_RESERVED;
>> +				break;

Yes, those defaults are annoying. Some tools complain so I tend to leave 
them.
