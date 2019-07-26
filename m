From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 03/40] soundwire: cadence_master: align
 debugfs to 8 digits
Date: Fri, 26 Jul 2019 08:58:35 -0500
Message-ID: <b557d2ac-2229-d24e-6d64-e426a2a96dfa@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-4-pierre-louis.bossart@linux.intel.com>
 <500e2f21-3ec9-342c-ab4d-e222d9adb42c@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <500e2f21-3ec9-342c-ab4d-e222d9adb42c@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org



On 7/26/19 4:38 AM, Cezary Rojewski wrote:
> On 2019-07-26 01:39, Pierre-Louis Bossart wrote:
>> SQUASHME
>>
>> Signed-off-by: Pierre-Louis Bossart 
>> <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/soundwire/cadence_master.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/soundwire/cadence_master.c 
>> b/drivers/soundwire/cadence_master.c
>> index 91e8bacb83e3..9f611a1fff0a 100644
>> --- a/drivers/soundwire/cadence_master.c
>> +++ b/drivers/soundwire/cadence_master.c
>> @@ -234,7 +234,7 @@ static ssize_t cdns_sprintf(struct sdw_cdns *cdns,
>>                   char *buf, size_t pos, unsigned int reg)
>>   {
>>       return scnprintf(buf + pos, RD_BUF - pos,
>> -             "%4x\t%4x\n", reg, cdns_readl(cdns, reg));
>> +             "%4x\t%8x\n", reg, cdns_readl(cdns, reg));
>>   }
>>   static ssize_t cdns_reg_read(struct file *file, char __user *user_buf,
>>
> 
> Should just be merged together with the introducing commit. Guess it's 
> posted unintentionally.

Yep, I missed this, will squash in the updates as intended.
