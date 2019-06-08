From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 3/6] soundwire: core: define SDW_MAX_PORT
Date: Sat, 8 Jun 2019 22:04:32 +0200
Message-ID: <641a22e7-6998-2a6a-bd90-ddf75d0cd9c8@intel.com>
References: <20190607085643.932-1-srinivas.kandagatla@linaro.org>
 <20190607085643.932-4-srinivas.kandagatla@linaro.org>
 <a4b527af-c999-829d-c4a0-41f0a6775b65@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a4b527af-c999-829d-c4a0-41f0a6775b65@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, broonie@kernel.org, vkoul@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org


On 2019-06-07 14:31, Pierre-Louis Bossart wrote:
> On 6/7/19 3:56 AM, Srinivas Kandagatla wrote:
>> This patch adds SDW_MAX_PORT so that other driver can use it.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   include/linux/soundwire/sdw.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/soundwire/sdw.h 
>> b/include/linux/soundwire/sdw.h
>> index aac68e879fae..80ca997e4e5d 100644
>> --- a/include/linux/soundwire/sdw.h
>> +++ b/include/linux/soundwire/sdw.h
>> @@ -36,6 +36,7 @@ struct sdw_slave;
>>   #define SDW_FRAME_CTRL_BITS        48
>>   #define SDW_MAX_DEVICES            11
>> +#define SDW_MAX_PORTS    14
> 
> That's an ambiguous definition.
> You can have 16 ports per the SoundWire spec, but DP0 is reserved for 
> control and DP15 is an alias for all ports (same idea as device 15 for 
> broadcast operations but limited to a single device), which leaves 14 
> ports for audio usages.
> 
> In the MIPI specs, specifically the DisCo part, the difference is called 
> about with the the DP0 and DPn notations, so this could be SDW_MAX_DPn. 
> Alternatively you could use SDW_MAX_AUDIO_PORTS which is more 
> self-explanatory and does not require in-depth familiarity with the spec.
> 

This ambiguity spreads even further. Look at the name of #define below.
DP0 is by no means invalid. It's specific and has some optional 
registers, yes, but that's because of its engagement in BPT.

Given the fact SDW does not care about type of data being transported, 
even "AUDIO" seems misleading here. Though it's still better than no 
specifier at all.

>>   #define SDW_VALID_PORT_RANGE(n)        ((n) <= 14 && (n) >= 1)
>>   #define SDW_DAI_ID_RANGE_START        100
>>
> 
