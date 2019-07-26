From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 09/40] soundwire: cadence_master: fix
 usage of CONFIG_UPDATE
Date: Fri, 26 Jul 2019 08:33:06 -0500
Message-ID: <f3468f5b-3e0a-ee4a-7e7a-734ed23fbdfa@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-10-pierre-louis.bossart@linux.intel.com>
 <3aa182a9-4b8e-96dd-e8f8-f2f5a90401cb@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3aa182a9-4b8e-96dd-e8f8-f2f5a90401cb@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Bard liao <yung-chuan.liao@linux.intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org


>> @@ -758,15 +774,9 @@ static int _cdns_enable_interrupt(struct sdw_cdns 
>> *cdns)
>>    */
>>   int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns)
>>   {
>> -    int ret;
>> -
>>       _cdns_enable_interrupt(cdns);
>> -    ret = cdns_clear_bit(cdns, CDNS_MCP_CONFIG_UPDATE,
>> -                 CDNS_MCP_CONFIG_UPDATE_BIT);
>> -    if (ret < 0)
>> -        dev_err(cdns->dev, "Config update timedout\n");
>> -    return ret;
> Should we add cdns_update_config() here?

indeed, this would be a good improvement. The code works because we 
added the exit_reset() sequence which does call cdns_update_config(), 
but better make this function self-contained. When we enable the 
clock-stop mode we will not do this reset sequence.
