From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 16/40] soundwire: cadence_master: improve
 startup sequence with link hw_reset
Date: Fri, 26 Jul 2019 09:11:03 -0500
Message-ID: <c91d6e9d-7ad9-64e2-6ed1-3c0be0b6833d@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-17-pierre-louis.bossart@linux.intel.com>
 <20190726072234.GD16003@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190726072234.GD16003@ubuntu>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org


>> +static int do_reset(struct sdw_cdns *cdns)
>> +{
>> +	int ret;
>> +
>> +	/* program maximum length reset to be safe */
>> +	cdns_updatel(cdns, CDNS_MCP_CONTROL,
>> +		     CDNS_MCP_CONTROL_RST_DELAY,
>> +		     CDNS_MCP_CONTROL_RST_DELAY);
>> +
>> +	/* use hardware generated reset */
>> +	cdns_updatel(cdns, CDNS_MCP_CONTROL,
>> +		     CDNS_MCP_CONTROL_HW_RST,
>> +		     CDNS_MCP_CONTROL_HW_RST);
>> +
>> +	/* enable bus operations with clock and data */
>> +	cdns_updatel(cdns, CDNS_MCP_CONFIG,
>> +		     CDNS_MCP_CONFIG_OP,
>> +		     CDNS_MCP_CONFIG_OP_NORMAL);
>> +
>> +	/* commit changes */
>> +	ret = cdns_update_config(cdns);
>> +
>> +	return ret;
> 
> +	return cdns_update_config(cdns);
> 
> and remove the "ret" variable.

Yes, it's the same issue as previously reported. will fix.
