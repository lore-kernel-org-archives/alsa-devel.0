From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 20/40] soundwire: prototypes for
 suspend/resume
Date: Fri, 26 Jul 2019 09:15:00 -0500
Message-ID: <0ef40222-46b2-1f5e-2482-ae1f48a91241@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-21-pierre-louis.bossart@linux.intel.com>
 <f718d6ae-6654-210b-4152-6692091130c9@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f718d6ae-6654-210b-4152-6692091130c9@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org



On 7/26/19 5:04 AM, Cezary Rojewski wrote:
> On 2019-07-26 01:40, Pierre-Louis Bossart wrote:
>> Signed-off-by: Pierre-Louis Bossart 
>> <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/soundwire/cadence_master.h | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/soundwire/cadence_master.h 
>> b/drivers/soundwire/cadence_master.h
>> index c0bf6ff00a44..d375bbfead18 100644
>> --- a/drivers/soundwire/cadence_master.h
>> +++ b/drivers/soundwire/cadence_master.h
>> @@ -165,6 +165,9 @@ int sdw_cdns_enable_interrupt(struct sdw_cdns *cdns);
>>   void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root);
>> +int sdw_cdns_suspend(struct sdw_cdns *cdns);
>> +bool sdw_cdns_check_resume_status(struct sdw_cdns *cdns);
>> +
>>   int sdw_cdns_get_stream(struct sdw_cdns *cdns,
>>               struct sdw_cdns_streams *stream,
>>               u32 ch, u32 dir);
>>
> 
> No commit message, guess it's SQUASHME commit and shouldn't be part of 
> overall series.

I can't recall why it's separate, will look into this. Thanks.
