From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 32/40] soundwire: intel: add helper for
 initialization
Date: Fri, 26 Jul 2019 09:55:22 -0500
Message-ID: <41d9d18f-9df2-9c7e-6cbd-8e7abb916f71@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-33-pierre-louis.bossart@linux.intel.com>
 <b0f7d11d-b9db-af98-3036-ef2a165f7427@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b0f7d11d-b9db-af98-3036-ef2a165f7427@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org



On 7/26/19 5:42 AM, Cezary Rojewski wrote:
> On 2019-07-26 01:40, Pierre-Louis Bossart wrote:
>> Move code to helper for reuse in power management routines
>>
>> Signed-off-by: Pierre-Louis Bossart 
>> <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/soundwire/intel.c | 16 +++++++++++-----
>>   1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
>> index c40ab443e723..215dc81cdf73 100644
>> --- a/drivers/soundwire/intel.c
>> +++ b/drivers/soundwire/intel.c
>> @@ -984,6 +984,15 @@ static struct sdw_master_ops sdw_intel_ops = {
>>       .post_bank_switch = intel_post_bank_switch,
>>   };
>> +static int intel_init(struct sdw_intel *sdw)
>> +{
>> +    /* Initialize shim and controller */
>> +    intel_link_power_up(sdw);
>> +    intel_shim_init(sdw);
>> +
>> +    return sdw_cdns_init(&sdw->cdns);
>> +}
> 
> Why don't we check polling status for _link_power_up? I've already met 
> slow starting devices in the past. If polling fails and -EAGAIN is 
> returned, flow of initialization should react appropriately e.g. poll 
> till MAX_TIMEOUT of some sort -or- collapse.

The code does what it states, it initializes the Intel and Cadence IPs.

What you are referring to is a different problem: once the bus starts, 
then Slave devices will report as attached, and will be enumerated. This 
will take time. The devices I tested show up immediately and within a 
couple of ms the bus is operational. But MIPI allows to the sync to take 
up to 4096 frames, which is 85ms with a 48kHz frame rate, so yes we do 
need to look into this.

We currently do not have a notification that tells us the bus is back to 
normal, that's a design flaw - see the last patch of the series where I 
kicked the can down the road but adding an artificial delay.

So yes good point indeed but on the wrong patch :-)
