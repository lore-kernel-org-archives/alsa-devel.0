From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 26/40] soundwire: cadence_master: fix
 divider setting in clock register
Date: Mon, 5 Aug 2019 10:41:20 -0500
Message-ID: <acad7ddf-4b83-0019-2f6f-8fd7c80a0fcc@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-27-pierre-louis.bossart@linux.intel.com>
 <20190805104047.GG22437@buildpc-HP-Z230>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190805104047.GG22437@buildpc-HP-Z230>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sanyog Kale <sanyog.r.kale@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Rander Wang <rander.wang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


>> @@ -988,9 +989,11 @@ int sdw_cdns_init(struct sdw_cdns *cdns)
>>   	/* Set clock divider */
>>   	divider	= (prop->mclk_freq / prop->max_clk_freq) - 1;
>>   	val = cdns_readl(cdns, CDNS_MCP_CLK_CTRL0);
> 
> reg read of CLK_CTRL0 can be removed.

yes for both comments. Thanks for the review Sanyog, appreciate it.

> 
>> -	val |= divider;
>> -	cdns_writel(cdns, CDNS_MCP_CLK_CTRL0, val);
>> -	cdns_writel(cdns, CDNS_MCP_CLK_CTRL1, val);
>> +
>> +	cdns_updatel(cdns, CDNS_MCP_CLK_CTRL0,
>> +		     CDNS_MCP_CLK_MCLKD_MASK, divider);
>> +	cdns_updatel(cdns, CDNS_MCP_CLK_CTRL1,
>> +		     CDNS_MCP_CLK_MCLKD_MASK, divider);
>>   
>>   	pr_err("plb: mclk %d max_freq %d divider %d register %x\n",
>>   	       prop->mclk_freq,
>> @@ -1064,8 +1067,7 @@ int cdns_bus_conf(struct sdw_bus *bus, struct sdw_bus_params *params)
>>   		mcp_clkctrl_off = CDNS_MCP_CLK_CTRL0;
>>   
>>   	mcp_clkctrl = cdns_readl(cdns, mcp_clkctrl_off);
> 
> same as above.
> 
>> -	mcp_clkctrl |= divider;
>> -	cdns_writel(cdns, mcp_clkctrl_off, mcp_clkctrl);
>> +	cdns_updatel(cdns, mcp_clkctrl_off, CDNS_MCP_CLK_MCLKD_MASK, divider);
>>   
>>   	pr_err("plb: mclk * 2 %d curr_dr_freq %d divider %d register %x\n",
>>   	       prop->mclk_freq * SDW_DOUBLE_RATE_FACTOR,
>> -- 
>> 2.20.1
>>
> 
