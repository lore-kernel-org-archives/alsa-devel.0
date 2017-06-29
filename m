From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [PATCH] ASoC: Drop invalid DMI fields when setting
 card long name from DMI info
Date: Thu, 29 Jun 2017 12:03:13 +0800
Message-ID: <790d9f35-4c4d-c498-f801-3b1e1c3c0d5b@linux.intel.com>
References: <20170628070139.18340-1-mengdong.lin@linux.intel.com>
 <s5hpodoi44t.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 07F72266991
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 13:00:30 +0200 (CEST)
In-Reply-To: <s5hpodoi44t.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: liam.r.girdwood@linux.intel.com, mengdong.lin@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org


On 06/28/2017 10:22 PM, Takashi Iwai wrote:
> On Wed, 28 Jun 2017 09:01:39 +0200,
> mengdong.lin@linux.intel.com wrote:
>>
>> From: Mengdong Lin <mengdong.lin@linux.intel.com>
>>
>> Sometimes DMI fields may be invalid and so can't give useful vendor,
>> product or board info, such as "Type2 - Board Manufacturer" or
>> "Type1 - TBD by OEM". Including such invalid DMI fileds may create silly
>> card long name. So this patch creates a black list of invalid strings.
>> And if a DMI field contains any string in this list, it will be excluded
>> from the card long name.
>>
>> Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
>>
>> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
>> index cfa9cf1476f2..419b788fd801 100644
>> --- a/sound/soc/soc-core.c
>> +++ b/sound/soc/soc-core.c
>> @@ -69,6 +69,20 @@ static int pmdown_time = 5000;
>>   module_param(pmdown_time, int, 0);
>>   MODULE_PARM_DESC(pmdown_time, "DAPM stream powerdown time (msecs)");
>>   
>> +/* If a DMI filed contain strings in this blacklist (e.g.
>> + * "Type2 - Board Manufacturer" or  "Type1 - TBD by OEM"), it will be taken
>> + * as invalid and dropped when setting the card long name from DMI info.
>> + */
>> +static const char * const dmi_blacklist[] = {
>> +	"To be filled by OEM",
>> +	"TBD by OEM",
>> +	"Default String",
> 
> We found also a case with "Default string" (note the case-sensitive).

I added it in the v2 patch. Please review.

It seems we'll add more strings later to handle such case-sensitive cases.

Thanks
Mengdong
