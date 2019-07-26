From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [RFC PATCH 09/40] soundwire: cadence_master: fix usage of
 CONFIG_UPDATE
Date: Fri, 26 Jul 2019 11:54:56 +0200
Message-ID: <c317cf0f-9487-2137-3451-ea4a514e5225@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-10-pierre-louis.bossart@linux.intel.com>
 <980e074e-0736-1b17-266b-2ef0ae7d7823@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <980e074e-0736-1b17-266b-2ef0ae7d7823@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org



On 2019-07-26 11:53, Cezary Rojewski wrote:
> On 2019-07-26 01:40, Pierre-Louis Bossart wrote:
>>   /*
>>    * debugfs
>>    */
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
>> +    return 0;
>>   }
>>   EXPORT_SYMBOL(sdw_cdns_enable_interrupt);
> 
> Rather than ignoring _cdns_enable_interrupt - despite said func always 
> returning 0 - simply do: return _cnds_enable_interrupt(cdns) and flag 
> caller with inline.
> 
> Afterwards, one can think if such encapsulation is even required - 
> remove existing sdw_cdns_enable_interrupt and rename 
> _cnds_enable_interrupt?

Nevermind, I see you simplified it in the next patch..
