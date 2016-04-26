From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] Asoc: Intel: common: Removed unused
 sst_acpi_mach fields
Date: Mon, 25 Apr 2016 22:17:07 -0500
Message-ID: <571EDDB3.9050907@linux.intel.com>
References: <1461638643-1886-1-git-send-email-joel@airwebreathe.org.uk>
 <571EDD22.1050909@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EEAC262607
 for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2016 05:17:09 +0200 (CEST)
In-Reply-To: <571EDD22.1050909@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Joel Holdsworth <joel@airwebreathe.org.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 4/25/16 10:14 PM, Pierre-Louis Bossart wrote:
> On 4/25/16 9:44 PM, Joel Holdsworth wrote:
>> The fields in question are currently unused, and are unlikely to be
>> useful in the future:
>>
>>    - "board" is a very vague name not related to a concrete matching
>>      criteria such as a DMI match or ACPI OEM IDs.
>>
>>    - "machine_quirk" lacks the pointer arguments to be able to
>>      manipulate any sst-acpi structures. For it to be useful these
>>      would need to be added. Furthermore, a quirk function is much
>>      more likely to be relevant to a whole chipset, rather than a
>>      single board.
>>
>>    - Without "machine_quirk", "pdata" serves no purpose and should
>>      be removed.
>
> please don't touch this. I just used pdata for baytrail-CR work.

And you missed the code in soc/intel/atom/sst/sst_acpi.c so your patches 
won't work in the first place.

>
>> ---
>>   sound/soc/intel/common/sst-acpi.c | 8 ++++----
>>   sound/soc/intel/common/sst-acpi.h | 5 -----
>>   2 files changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/sound/soc/intel/common/sst-acpi.c
>> b/sound/soc/intel/common/sst-acpi.c
>> index 2c5eda1..aba6575 100644
>> --- a/sound/soc/intel/common/sst-acpi.c
>> +++ b/sound/soc/intel/common/sst-acpi.c
>> @@ -180,7 +180,7 @@ static int sst_acpi_remove(struct platform_device
>> *pdev)
>>   }
>>
>>   static struct sst_acpi_mach haswell_machines[] = {
>> -    { "INT33CA", "haswell-audio", "intel/IntcSST1.bin", NULL, NULL,
>> NULL },
>> +    { "INT33CA", "haswell-audio", "intel/IntcSST1.bin" },
>>       {}
>>   };
>>
>> @@ -198,7 +198,7 @@ static struct sst_acpi_desc sst_acpi_haswell_desc = {
>>   };
>>
>>   static struct sst_acpi_mach broadwell_machines[] = {
>> -    { "INT343A", "broadwell-audio", "intel/IntcSST2.bin", NULL, NULL,
>> NULL },
>> +    { "INT343A", "broadwell-audio", "intel/IntcSST2.bin" },
>>       {}
>>   };
>>
>> @@ -217,8 +217,8 @@ static struct sst_acpi_desc
>> sst_acpi_broadwell_desc = {
>>
>>   #if !IS_ENABLED(CONFIG_SND_SST_IPC_ACPI)
>>   static struct sst_acpi_mach baytrail_machines[] = {
>> -    { "10EC5640", "byt-rt5640",
>> "intel/fw_sst_0f28.bin-48kHz_i2s_master", NULL, NULL, NULL },
>> -    { "193C9890", "byt-max98090",
>> "intel/fw_sst_0f28.bin-48kHz_i2s_master", NULL, NULL, NULL },
>> +    { "10EC5640", "byt-rt5640",
>> "intel/fw_sst_0f28.bin-48kHz_i2s_master" },
>> +    { "193C9890", "byt-max98090",
>> "intel/fw_sst_0f28.bin-48kHz_i2s_master" },
>>       {}
>>   };
>>
>> diff --git a/sound/soc/intel/common/sst-acpi.h
>> b/sound/soc/intel/common/sst-acpi.h
>> index 4dcfb7e..9eb8ade 100644
>> --- a/sound/soc/intel/common/sst-acpi.h
>> +++ b/sound/soc/intel/common/sst-acpi.h
>> @@ -28,9 +28,4 @@ struct sst_acpi_mach {
>>       const char *drv_name;
>>       /* firmware file name */
>>       const char *fw_filename;
>> -
>> -    /* board name */
>> -    const char *board;
>> -    void (*machine_quirk)(void);
>> -    void *pdata;
>>   };
>>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
