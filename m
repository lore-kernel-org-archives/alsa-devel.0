From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 38/40] soundwire: cadence_master: make
 clock stop exit configurable on init
Date: Fri, 26 Jul 2019 12:35:47 -0500
Message-ID: <c6ecaa08-9fdc-d228-8016-9a22241fb689@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-39-pierre-louis.bossart@linux.intel.com>
 <20190726160258.GN16003@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190726160258.GN16003@ubuntu>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org


>> -int sdw_cdns_init(struct sdw_cdns *cdns);
>> +int sdw_cdns_init(struct sdw_cdns *cdns, bool clock_stop_exit);
>>   int sdw_cdns_pdi_init(struct sdw_cdns *cdns,
>>   		      struct sdw_cdns_stream_config config);
>>   int sdw_cdns_exit_reset(struct sdw_cdns *cdns);
>> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
>> index 1192d5775484..db7bf2912767 100644
>> --- a/drivers/soundwire/intel.c
>> +++ b/drivers/soundwire/intel.c
>> @@ -1043,7 +1043,7 @@ static int intel_init(struct sdw_intel *sdw)
>>   	intel_link_power_up(sdw);
>>   	intel_shim_init(sdw);
>>   
>> -	return sdw_cdns_init(&sdw->cdns);
>> +	return sdw_cdns_init(&sdw->cdns, false);
> 
> This is the only caller of this function so far, so, it looks like
> the second argument ATM is always "false." I assume you foresee other
> uses with "true" in the future, otherwise maybe just fix it to false
> in the function?

Since we are at RFC level things are not set in stone, it's not fully 
clear if this test is required or not. I added it since Rander reported 
an error on one of the target platforms that I didn't see personally. 
We'll double-check if it's needed. And if indeed it's needed, yes it'll 
be set to true when we add clock stop.
