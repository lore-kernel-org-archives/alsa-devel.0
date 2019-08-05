From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 02/40] soundwire: cadence_master: add
 debugfs register dump
Date: Mon, 5 Aug 2019 10:20:25 -0500
Message-ID: <37002145-b8dc-ac30-d857-00b277ef4bac@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-3-pierre-louis.bossart@linux.intel.com>
 <20190805075509.GA22437@buildpc-HP-Z230>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190805075509.GA22437@buildpc-HP-Z230>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sanyog Kale <sanyog.r.kale@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com
List-Id: alsa-devel@alsa-project.org


>> +static ssize_t cdns_reg_read(struct file *file, char __user *user_buf,
>> +			     size_t count, loff_t *ppos)
>> +{
>> +	struct sdw_cdns *cdns = file->private_data;
>> +	char *buf;
>> +	ssize_t ret;
>> +	int i, j;
>> +
>> +	buf = kzalloc(RD_BUF, GFP_KERNEL);
>> +	if (!buf)
>> +		return -ENOMEM;
>> +
>> +	ret = scnprintf(buf, RD_BUF, "Register  Value\n");
>> +	ret += scnprintf(buf + ret, RD_BUF - ret, "\nMCP Registers\n");
>> +	for (i = 0; i < 8; i++) /* 8 MCP registers */
>> +		ret += cdns_sprintf(cdns, buf, ret, i * 4);
>> +
>> +	ret += scnprintf(buf + ret, RD_BUF - ret,
>> +			 "\nStatus & Intr Registers\n");
>> +	for (i = 0; i < 13; i++) /* 13 Status & Intr registers */
>> +		ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_STAT + i * 4);
>> +
>> +	ret += scnprintf(buf + ret, RD_BUF - ret,
>> +			 "\nSSP & Clk ctrl Registers\n");
>> +	ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_SSP_CTRL0);
>> +	ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_SSP_CTRL1);
>> +	ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_CLK_CTRL0);
>> +	ret += cdns_sprintf(cdns, buf, ret, CDNS_MCP_CLK_CTRL1);
>> +
>> +	ret += scnprintf(buf + ret, RD_BUF - ret,
>> +			 "\nDPn B0 Registers\n");
>> +	for (i = 0; i < 7; i++) {
>> +		ret += scnprintf(buf + ret, RD_BUF - ret,
>> +				 "\nDP-%d\n", i);
>> +		for (j = 0; j < 6; j++)
>> +			ret += cdns_sprintf(cdns, buf, ret,
>> +					CDNS_DPN_B0_CONFIG(i) + j * 4);
>> +	}
>> +
>> +	ret += scnprintf(buf + ret, RD_BUF - ret,
>> +			 "\nDPn B1 Registers\n");
>> +	for (i = 0; i < 7; i++) {
>> +		ret += scnprintf(buf + ret, RD_BUF - ret,
>> +				 "\nDP-%d\n", i);
>> +
>> +		for (j = 0; j < 6; j++)
>> +			ret += cdns_sprintf(cdns, buf, ret,
>> +					CDNS_DPN_B1_CONFIG(i) + j * 4);
>> +	}
>> +
>> +	ret += scnprintf(buf + ret, RD_BUF - ret,
>> +			 "\nDPn Control Registers\n");
>> +	for (i = 0; i < 7; i++)
>> +		ret += cdns_sprintf(cdns, buf, ret,
>> +				CDNS_PORTCTRL + i * CDNS_PORT_OFFSET);
>> +
>> +	ret += scnprintf(buf + ret, RD_BUF - ret,
>> +			 "\nPDIn Config Registers\n");
>> +	for (i = 0; i < 7; i++)
> 
> please use macros for all the hardcodings.

yes, I completely changed that part in the upcoming update by using 
register start/stop for all loops, it makes the code more consistent and 
easier to change (SoundWire 1.2 registers will need to be added)
