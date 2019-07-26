From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 37/40] soundwire: cadence_master: add
 hw_reset capability in debugfs
Date: Fri, 26 Jul 2019 12:31:53 -0500
Message-ID: <bd17efe9-04bf-4cf5-6527-8fdba8d39419@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-38-pierre-louis.bossart@linux.intel.com>
 <20190726155717.GM16003@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190726155717.GM16003@ubuntu>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org


>> +static int cdns_hw_reset(void *data, u64 value)
>> +{
>> +	struct sdw_cdns *cdns = data;
>> +	int ret;
>> +
>> +	if (value != 1)
>> +		return 0;
>> +
>> +	dev_info(cdns->dev, "starting link hw_reset\n");
>> +
>> +	ret = sdw_cdns_exit_reset(cdns);
>> +
>> +	dev_info(cdns->dev, "link hw_reset done\n");
> 
> Both really should be dev_info()? Maybe at least one of them can be dev_dbg()?

I have to walk back on what I explained to Greg. The idea was to have a 
dmesg trace when this function as called when the user plays with 
debugfs, otherwise the dmesg log is difficult to interpret (devices can 
go off the bus on their own). I'll keep the first one only and demote it 
to dev_dbg.
