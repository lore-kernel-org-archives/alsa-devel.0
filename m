From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 23/40] soundwire: stream: fix disable
 sequence
Date: Fri, 26 Jul 2019 09:17:52 -0500
Message-ID: <68948dd2-e131-7ef2-3067-ea5286e2f6d0@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-24-pierre-louis.bossart@linux.intel.com>
 <492d7897-973d-f207-46d5-f2f554645df7@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <492d7897-973d-f207-46d5-f2f554645df7@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org



On 7/26/19 5:14 AM, Cezary Rojewski wrote:
> On 2019-07-26 01:40, Pierre-Louis Bossart wrote:
>> -    return do_bank_switch(stream);
>> +    ret = do_bank_switch(stream);
>> +    if (ret < 0) {
>> +        dev_err(bus->dev, "Bank switch failed: %d\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    /* make sure alternate bank (previous current) is also disabled */
>> +    list_for_each_entry(m_rt, &stream->master_list, stream_node) {
>> +        bus = m_rt->bus;
>> +        /* Disable port(s) */
>> +        ret = sdw_enable_disable_ports(m_rt, false);
>> +        if (ret < 0) {
>> +            dev_err(bus->dev, "Disable port(s) failed: %d\n", ret);
>> +            return ret;
>> +        }
>> +    }
>> +
>> +    return 0;
>>   }
>>   /**
>>
> 
> While not directly connected to this commit, I see that you do:
> link_for_each_entry(m_rt, &stream->master_list, stream_node)
> 
> quite often in /stream.c code. Helpful macro would prove useful.

Yes, but the flip side is that people need to look at what the macro 
does to figure it out, while everyone knows what list_for_each_entry() 
means. Not sure about this one.
And on top of this we'll probably have to rework this code to have a 
background copy of the current bank in the alternate bank so it'd rather 
leave it simple for now.
