From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 28/40] soundwire: intel: handle disabled
 links
Date: Mon, 5 Aug 2019 14:18:35 -0500
Message-ID: <4c4e64fb-9657-0312-a19f-2a17b44fbae3@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-29-pierre-louis.bossart@linux.intel.com>
 <20190805165729.GC24889@buildpc-HP-Z230>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190805165729.GC24889@buildpc-HP-Z230>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sanyog Kale <sanyog.r.kale@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com
List-Id: alsa-devel@alsa-project.org



On 8/5/19 11:57 AM, Sanyog Kale wrote:
> On Thu, Jul 25, 2019 at 06:40:20PM -0500, Pierre-Louis Bossart wrote:
>> On most hardware platforms, SoundWire interfaces are pin-muxed with
>> other interfaces (typically DMIC or I2S) and the status of each link
>> needs to be checked at boot time.
>>
>> For Intel platforms, the BIOS provides a menu to enable/disable the
>> links separately, and the information is provided to the OS with an
>> Intel-specific _DSD property. The same capability will be added to
>> revisions of the MIPI DisCo specification.

[snip]

>> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
>> index c7dfc824be80..f78b076a8782 100644
>> --- a/include/linux/soundwire/sdw.h
>> +++ b/include/linux/soundwire/sdw.h
>> @@ -380,6 +380,7 @@ struct sdw_slave_prop {
>>    * @err_threshold: Number of times that software may retry sending a single
>>    * command
>>    * @mclk_freq: clock reference passed to SoundWire Master, in Hz.
>> + * @hw_disabled: if true, the Master is not functional, typically due to pin-mux
>>    */
>>   struct sdw_master_prop {
>>   	u32 revision;
>> @@ -395,6 +396,7 @@ struct sdw_master_prop {
>>   	bool dynamic_frame;
>>   	u32 err_threshold;
>>   	u32 mclk_freq;
>> +	bool hw_disabled;
> 
> Do we have such cases where some of SoundWire links are disabled and
> some enabled?

Yes, by default my ICL test board uses HDaudio for the codec so the 
SoundWire link0 is disabled. If I rework the board and change the BIOS 
advanced menu then SoundWire link0 is enabled. This information is 
dynamically provided to the OS after the _INI step.
SoundWire-2/3 are used typically for attached DMICs or for a combination 
of SoundWire amplifier and mic capture. It's really platform-specific.

> 
>>   };
>>   
>>   int sdw_master_read_prop(struct sdw_bus *bus);
>> -- 
>> 2.20.1
>>
> 
