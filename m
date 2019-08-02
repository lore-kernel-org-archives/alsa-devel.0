From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 12/40] soundwire: cadence_master: revisit interrupt
 settings
Date: Fri, 2 Aug 2019 10:23:52 -0500
Message-ID: <a46474c5-8f6b-fa03-8d5e-704c028667aa@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-13-pierre-louis.bossart@linux.intel.com>
 <20190802121016.GN12733@vkoul-mobl.Dlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190802121016.GN12733@vkoul-mobl.Dlink>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Bard Liao <yung-chuan.liao@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org


>> @@ -761,10 +769,21 @@ int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
>>   	cdns_writel(cdns, CDNS_MCP_SLAVE_INTMASK1,
>>   		    CDNS_MCP_SLAVE_INTMASK1_MASK);
>>   
>> +	/* enable detection of slave state changes */
>>   	mask = CDNS_MCP_INT_SLAVE_RSVD | CDNS_MCP_INT_SLAVE_ALERT |
>> -		CDNS_MCP_INT_SLAVE_ATTACH | CDNS_MCP_INT_SLAVE_NATTACH |
>> -		CDNS_MCP_INT_CTRL_CLASH | CDNS_MCP_INT_DATA_CLASH |
>> -		CDNS_MCP_INT_RX_WL | CDNS_MCP_INT_IRQ | CDNS_MCP_INT_DPINT;
>> +		CDNS_MCP_INT_SLAVE_ATTACH | CDNS_MCP_INT_SLAVE_NATTACH;
>> +
>> +	/* enable detection of bus issues */
>> +	mask |= CDNS_MCP_INT_CTRL_CLASH | CDNS_MCP_INT_DATA_CLASH |
>> +		CDNS_MCP_INT_PARITY;
>> +
>> +	/* no detection of port interrupts for now */
>> +
>> +	/* enable detection of RX fifo level */
>> +	mask |= CDNS_MCP_INT_RX_WL;
>> +
>> +	/* now enable all of the above */
> 
> I think this comment seems is at wrong line..?
> 
>> +	mask |= CDNS_MCP_INT_IRQ;
>>   
>>   	cdns_writel(cdns, CDNS_MCP_INTMASK, mask);

No it's at the right place.

This flag gates all others, if its value is zero then the value of all 
other bits is irrelevant.

that's what I meant by 'all of the above'.
