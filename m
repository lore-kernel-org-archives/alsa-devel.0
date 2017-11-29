From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH v2 1/7] ASoC: Intel: Fix Kconfig with
 top-level selector
Date: Wed, 29 Nov 2017 08:52:58 -0600
Message-ID: <8ba6af88-5cb4-8174-2ecc-46f80420ff28@linux.intel.com>
References: <20171129014551.30552-1-pierre-louis.bossart@linux.intel.com>
 <20171129014551.30552-2-pierre-louis.bossart@linux.intel.com>
 <20171129102734.GA32417@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id B5E44266B67
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 15:53:01 +0100 (CET)
In-Reply-To: <20171129102734.GA32417@localhost>
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
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, arnd@arndb.de, tiwai@suse.de, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com, torvalds@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

On 11/29/17 4:27 AM, Vinod Koul wrote:
> On Tue, Nov 28, 2017 at 07:45:45PM -0600, Pierre-Louis Bossart wrote:
> 
> I am not sure about top level being default to Y...

It's standard procedure apparently, see Linus/Mark/Takashi's emails.

> 
>>   config SND_SST_ATOM_HIFI2_PLATFORM
>>   	tristate "Intel ASoC SST driver for HiFi2 platforms (*field, *trail)"
>> -	depends on SND_SOC_INTEL_SST_TOPLEVEL && X86
>> +	depends on X86
>>   	select SND_SOC_COMPRESS
>> +	select SND_SOC_INTEL_COMMON
>>   
>>   config SND_SOC_INTEL_SKYLAKE
>>   	tristate "Intel ASoC SST driver for SKL/BXT/KBL/GLK/CNL"
>> -	depends on SND_SOC_INTEL_SST_TOPLEVEL && PCI && ACPI
>> +	depends on PCI && ACPI
>>   	select SND_HDA_EXT_CORE
>>   	select SND_HDA_DSP_LOADER
>>   	select SND_SOC_TOPOLOGY
>>   	select SND_SOC_INTEL_SST
>> +	select SND_SOC_INTEL_COMMON
>> +	help
>> +	  If you have a Intel Skylake/Broxton/ApolloLake/KabyLake/
>> +	  GeminiLake or CannonLake platform with the DSP enabled in the BIOS
>> +	  then enable this option by saying Y or m.
> 
> this is good stuff, helps in improving UX vastly. Btw can we have select ALL
> machine also as an option for people who dont want to select a specfic one,
> that one will really help for a better UX

no, we shouldn't select things, especially with the Baytrail legacy 
which is kept to avoid breaking existing setups but shouldn't be used 
any longer.
And with SOF coming, we may have hybrid configurations with SOF used on 
Baytrail/Cherrytrail/APL/CNL but SST used on Skylake/Kabylake due to 
firmware authentication stuff.

> 
>> +
>> +endif ## SND_SOC_INTEL_SST_TOPLEVEL
>>   
>>   # ASoC codec drivers
>>   source "sound/soc/intel/boards/Kconfig"
>> +
>> +# configs common to SST and SOF to compile sound/soc/intel/common
>> +# directory and use matching tables
>> +
>> +config SND_SOC_INTEL_COMMON
>> +	tristate
>> +	select SND_SOC_ACPI_INTEL_MATCH if ACPI
> 
> common selects only MATCH

COMMON is only there to go compile the sound/soc/intel/common directory. 
That's not very useful indeed but otherwise the Makefile doesn't compile 
the match tables or the sst-ipc stuff. If you find a better solution I 
am all ears.

> 
>> +	# this option controls the compilation of the sound/soc/intel/common
>> +	# directory and is not meant to be selected by the user. It is
>> +	# not filtered out on purpose by the top-level selector since
>> +	# it will be selected by SST or SOF platform driver options
>> +
>> +config SND_SOC_ACPI_INTEL_MATCH
>> +	tristate
>> +	select SND_SOC_ACPI if ACPI
> 
> then why keep common, lets remove one level and have
> SND_SOC_ACPI_INTEL_MATCH selected. ACPI is must have at top level so we can
> add depends on that symbol

we still have platforms which don't depend on ACPI, so we shouldn't take 
this out.
