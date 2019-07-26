From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 29/40] soundwire: intel_init: add kernel
 module parameter to filter out links
Date: Fri, 26 Jul 2019 09:43:33 -0500
Message-ID: <a8ac6b27-ce30-2a76-aeab-d01acbac4265@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-30-pierre-louis.bossart@linux.intel.com>
 <c1d859dc-3fd6-0be7-2240-c3b1f3240c0a@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c1d859dc-3fd6-0be7-2240-c3b1f3240c0a@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org



On 7/26/19 5:30 AM, Cezary Rojewski wrote:
> On 2019-07-26 01:40, Pierre-Louis Bossart wrote:
>> @@ -83,6 +87,9 @@ static struct sdw_intel_ctx
>>       caps = ioread32(res->mmio_base + SDW_SHIM_BASE + SDW_SHIM_LCAP);
>>       caps &= GENMASK(2, 0);
>> +    dev_dbg(&adev->dev, "SoundWire links: BIOS count %d hardware caps 
>> %d\n",
>> +        count, caps);
>> +
>>       /* Check HW supported vs property value and use min of two */
>>       count = min_t(u8, caps, count);
> 
> This message does not look like it belongs to current patch - no 
> link_mask dependency whatsoever. There have been couple "informative" 
> patches in your series, maybe schedule it with them instead (as a 
> separate series)?

You're right, this log should be in a different patch. it was added when 
I was debugging the DisCo properties a couple of months back and should 
be moved. thanks for noting this.
