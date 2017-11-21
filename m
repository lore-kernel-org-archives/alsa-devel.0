From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 1/7] ASoC: Intel: Fix Kconfig
Date: Tue, 21 Nov 2017 15:31:03 -0600
Message-ID: <5b450209-36d7-d12a-54d2-503592e5f71f@linux.intel.com>
References: <20171118000202.22302-1-pierre-louis.bossart@linux.intel.com>
 <20171118000202.22302-2-pierre-louis.bossart@linux.intel.com>
 <s5hzi7ftvao.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hzi7ftvao.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, arnd@arndb.de, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com, torvalds@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

On 11/21/17 11:07 AM, Takashi Iwai wrote:
> On Sat, 18 Nov 2017 01:01:56 +0100,
> Pierre-Louis Bossart wrote:
>>
>> Follow network example suggested by Linus, move Intel definitions
>> in if/endif block and clarify which options distro configurations
>> should enable - everything except legacy Baytrail stuff and
>> NOCODEC (test only)
>>
>> There should be no functionality change - except that sound capabilities
>> are restored when using older configs without any user selection.
>>
>> Fixes: f6a118a800e3 ("ASoC: Intel: clarify Kconfig dependencies")
>> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> A few another things I noticed while looking at the end result:
> 
>>   config SND_SOC_INTEL_SKYLAKE
>>   	tristate "Intel ASoC SST driver for SKL/BXT/KBL/GLK/CNL"
>> -	depends on SND_SOC_INTEL_SST_TOPLEVEL && PCI && ACPI
>> +	depends on PCI && ACPI
>>   	select SND_HDA_EXT_CORE
>>   	select SND_HDA_DSP_LOADER
>>   	select SND_SOC_TOPOLOGY
>>   	select SND_SOC_INTEL_SST
>> +	select SND_SOC_INTEL_COMMON
>> +
>> +endif ## SND_SOC_INTEL_SST_TOPLEVEL
> 
> This endif should cover the whole including the source
> boards/Kconfig.  In that way, deselecting SND_SOC_INTEL_SST_TOPLEVEL
> will skip the whole.  As of this patch, you'll be still asked about
> the board config even if you say TOPLEVEL=n.

yes for now, but it's a feature needed for SOF integration...see below.

> 
>>   # ASoC codec drivers
>>   source "sound/soc/intel/boards/Kconfig"
>> +
>> +# configs common to SST and SOF to compile sound/soc/intel/common
>> +# directory and use matching tables
>> +
>> +config SND_SOC_INTEL_COMMON
>> +	tristate
>> +	select SND_SOC_ACPI_INTEL_MATCH if ACPI
>> +
>> +config SND_SOC_ACPI_INTEL_MATCH
>> +	tristate
>> +	select SND_SOC_ACPI if ACPI
> 
> ... so here should be placed the endif.

Those two are needed for SOF and shouldn't be filtered out by SST. we 
can move them somewhere else if needed.

> 
>> diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
>> index 6f754708a48c..4ae44b0cea0a 100644
>> --- a/sound/soc/intel/boards/Kconfig
>> +++ b/sound/soc/intel/boards/Kconfig
>> @@ -1,7 +1,14 @@
>> -config SND_SOC_INTEL_MACH
>> -	tristate "Intel Audio machine drivers"
>> -	depends on SND_SOC_INTEL_SST_TOPLEVEL
>> -	select SND_SOC_ACPI_INTEL_MATCH if ACPI
>> +config  SND_SOC_INTEL_MACH
>> +	bool "Intel ASoC machine drivers"
>> +	default y
>> +	help
>> +          Intel ASoC Audio Machine Drivers. If you have a Intel machine that
>> +          has audio controller with a DSP and I2S or DMIC port, then
>> +          enable this option by saying Y
>> +
>> +	  Note that the answer to this question doesn't directly affect the
>> +	  kernel: saying N will just cause the configurator to skip all
>> +	  the questions about Intel SST machine drivers.
> 
> Do we still need this filtering?  Since we have a top-level filter,
> users who want to skip the Intel stuff can say N there already, and I
> can't imagine anyone who want only the SST core / platform drivers
> built without machine drivers explicitly.

Yes, but when we add SOF we will have an alternate top-level and the 
machine drivers should be selectable even when SST is filtered out.

> 
> 
> thanks,
> 
> Takashi
> 
