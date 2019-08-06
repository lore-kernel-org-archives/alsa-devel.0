From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 09/17] soundwire: stream: remove unnecessary variable
 initializations
Date: Tue, 6 Aug 2019 10:39:23 -0500
Message-ID: <346425e0-0001-ecbc-c79a-c1372d0b4fcc@linux.intel.com>
References: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
 <20190806005522.22642-10-pierre-louis.bossart@linux.intel.com>
 <a52b4fbd-1d97-d8b8-dd2c-fac30c6add4b@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a52b4fbd-1d97-d8b8-dd2c-fac30c6add4b@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, Blauciak@vger.kernel.org, Slawomir <slawomir.blauciak@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org



On 8/6/19 10:31 AM, Cezary Rojewski wrote:
> On 2019-08-06 02:55, Pierre-Louis Bossart wrote:
>> @@ -1493,6 +1493,11 @@ static int _sdw_prepare_stream(struct 
>> sdw_stream_runtime *stream)
>>           }
>>       }
>> +    if (!bus) {
>> +        pr_err("Configuration error in %s\n", __func__);
>> +        return -EINVAL;
>> +    }
>> +
> 
> This should probably be located in separate path - not at all an 
> initialization removal.

It's a consequence of the initialization removal: because we are 
removing the default init, there is a risk that the loop just before do 
not set it, so it's required to trap the case where the variable in not 
initialized.

> 
>> @@ -1573,6 +1578,11 @@ static int _sdw_enable_stream(struct 
>> sdw_stream_runtime *stream)
>>           }
>>       }
>> +    if (!bus) {
>> +        pr_err("Configuration error in %s\n", __func__);
>> +        return -EINVAL;
>> +    }
>> +
> 
> Same here.

same reply

> 
>> @@ -1639,13 +1650,14 @@ static int _sdw_disable_stream(struct 
>> sdw_stream_runtime *stream)
>>       ret = do_bank_switch(stream);
>>       if (ret < 0) {
>> -        dev_err(bus->dev, "Bank switch failed: %d\n", ret);
>> +        pr_err("Bank switch failed: %d\n", ret);
>>           return ret;
>>       }
> 
> Here too.

no, same thing, the bus variable is initialized in loops so tools will 
report a possible path where bus->dev is an invalid dereference.

> I might have missed something though I bet you got my point.
