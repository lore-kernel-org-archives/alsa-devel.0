From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 36/40] soundwire: intel: disable
 interrupts on suspend
Date: Fri, 26 Jul 2019 12:26:10 -0500
Message-ID: <e456112b-27a4-d897-6690-3177dd5a8b56@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-37-pierre-louis.bossart@linux.intel.com>
 <20190726155520.GL16003@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190726155520.GL16003@ubuntu>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org


>> -int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
>> +int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns, bool state)
>>   {
>>   	u32 mask;
>>   
>> -	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK0,
>> -		    CDNS_MCP_SLAVE_INTMASK0_MASK);
>> -	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1,
>> -		    CDNS_MCP_SLAVE_INTMASK1_MASK);
>> +	if (state) {
>> +		cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK0,
>> +			    CDNS_MCP_SLAVE_INTMASK0_MASK);
>> +		cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1,
>> +			    CDNS_MCP_SLAVE_INTMASK1_MASK);
>>   
>> -	/* enable detection of slave state changes */
>> -	mask = CDNS_MCP_INT_SLAVE_RSVD | CDNS_MCP_INT_SLAVE_ALERT |
>> -		CDNS_MCP_INT_SLAVE_ATTACH | CDNS_MCP_INT_SLAVE_NATTACH;
>> +		/* enable detection of slave state changes */
>> +		mask = CDNS_MCP_INT_SLAVE_RSVD | CDNS_MCP_INT_SLAVE_ALERT |
>> +			CDNS_MCP_INT_SLAVE_ATTACH | CDNS_MCP_INT_SLAVE_NATTACH;
>>   
>> -	/* enable detection of bus issues */
>> -	mask |= CDNS_MCP_INT_CTRL_CLASH | CDNS_MCP_INT_DATA_CLASH |
>> -		CDNS_MCP_INT_PARITY;
>> +		/* enable detection of bus issues */
>> +		mask |= CDNS_MCP_INT_CTRL_CLASH | CDNS_MCP_INT_DATA_CLASH |
>> +			CDNS_MCP_INT_PARITY;
>>   
>> -	/* no detection of port interrupts for now */
>> +		/* no detection of port interrupts for now */
>>   
>> -	/* enable detection of RX fifo level */
>> -	mask |= CDNS_MCP_INT_RX_WL;
>> +		/* enable detection of RX fifo level */
>> +		mask |= CDNS_MCP_INT_RX_WL;
>>   
>> -	/* now enable all of the above */
>> -	mask |= CDNS_MCP_INT_IRQ;
>> +		/* now enable all of the above */
>> +		mask |= CDNS_MCP_INT_IRQ;
>>   
>> -	if (interrupt_mask) /* parameter override */
>> -		mask = interrupt_mask;
>> +		if (interrupt_mask) /* parameter override */
>> +			mask = interrupt_mask;
>> +	} else {
>> +		cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK0, 0);
>> +		cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1, 0);
>> +		mask = 0;
>> +	}
> 
> Looks like this should be two functions? Especially since "state" is always a constant
> when it is called. If there is still a lot of common code below, maybe make it a helper
> function.

Yes, the code is a bit ugly. I could initialize all the masks to zero, 
have the if(state) block and write the masks.
