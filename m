From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/1] sst: select DW_DMAC_CORE since it's
 mandatory
Date: Fri, 18 Mar 2016 11:15:36 -0500
Message-ID: <56EC29A8.3030400@linux.intel.com>
References: <1442576689-32221-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1458303883.1347.141.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E168B2625EE
 for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2016 17:15:36 +0100 (CET)
In-Reply-To: <1458303883.1347.141.camel@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>
Cc: dmaengine <dmaengine@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 3/18/16 7:24 AM, Andy Shevchenko wrote:
> On Fri, 2015-09-18 at 14:44 +0300, Andy Shevchenko wrote:
>> While here group selectors under SND_SOC_INTEL_HASWELL and
>> SND_SOC_INTEL_BAYTRAIL.
>
> It seems patch is not applied anymore.
> I will send v2 if no one objects on the approach.

I don't think DW_DMAC_CORE is mandatory at all for BAYTRAIL. We've have 
a thread with Keyon on this.

>
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>   sound/soc/intel/Kconfig | 15 +++++----------
>>   1 file changed, 5 insertions(+), 10 deletions(-)
>>
>> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
>> index 05fde5e6e..bc5281e 100644
>> --- a/sound/soc/intel/Kconfig
>> +++ b/sound/soc/intel/Kconfig
>> @@ -35,15 +35,17 @@ config SND_SOC_INTEL_SST_ACPI
>>
>>   config SND_SOC_INTEL_HASWELL
>>   	tristate
>> +	select DW_DMAC_CORE
>> +	select SND_SOC_INTEL_SST
>>
>>   config SND_SOC_INTEL_BAYTRAIL
>>   	tristate
>> +	select DW_DMAC_CORE
>> +	select SND_SOC_INTEL_SST
>>
>>   config SND_SOC_INTEL_HASWELL_MACH
>>   	tristate "ASoC Audio DSP support for Intel Haswell
>> Lynxpoint"
>>   	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM
>> -	depends on DW_DMAC_CORE
>> -	select SND_SOC_INTEL_SST
>>   	select SND_SOC_INTEL_HASWELL
>>   	select SND_SOC_RT5640
>>   	help
>> @@ -55,8 +57,6 @@ config SND_SOC_INTEL_HASWELL_MACH
>>   config SND_SOC_INTEL_BYT_RT5640_MACH
>>   	tristate "ASoC Audio driver for Intel Baytrail with RT5640
>> codec"
>>   	depends on X86_INTEL_LPSS && I2C
>> -	depends on DW_DMAC_CORE
>> -	select SND_SOC_INTEL_SST
>>   	select SND_SOC_INTEL_BAYTRAIL
>>   	select SND_SOC_RT5640
>>   	help
>> @@ -66,8 +66,6 @@ config SND_SOC_INTEL_BYT_RT5640_MACH
>>   config SND_SOC_INTEL_BYT_MAX98090_MACH
>>   	tristate "ASoC Audio driver for Intel Baytrail with MAX98090
>> codec"
>>   	depends on X86_INTEL_LPSS && I2C
>> -	depends on DW_DMAC_CORE
>> -	select SND_SOC_INTEL_SST
>>   	select SND_SOC_INTEL_BAYTRAIL
>>   	select SND_SOC_MAX98090
>>   	help
>> @@ -76,10 +74,7 @@ config SND_SOC_INTEL_BYT_MAX98090_MACH
>>
>>   config SND_SOC_INTEL_BROADWELL_MACH
>>   	tristate "ASoC Audio DSP support for Intel Broadwell
>> Wildcatpoint"
>> -	depends on X86_INTEL_LPSS && I2C && DW_DMAC && \
>> -		   I2C_DESIGNWARE_PLATFORM
>> -	depends on DW_DMAC_CORE
>> -	select SND_SOC_INTEL_SST
>> +	depends on X86_INTEL_LPSS && I2C && I2C_DESIGNWARE_PLATFORM
>>   	select SND_SOC_INTEL_HASWELL
>>   	select SND_SOC_RT286
>>   	help
>
