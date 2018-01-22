From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: intel: clean up CONFIG_SND_SST_IPC
 handling
Date: Mon, 22 Jan 2018 10:37:28 -0600
Message-ID: <a463e463-2181-1047-3721-529d8923ad68@linux.intel.com>
References: <20180121221505.196163-1-arnd@arndb.de>
 <1516614692.7000.1155.camel@linux.intel.com>
 <CAK8P3a0H6CbFgqQijFRYsDoYq3mEPcuBL6x01Ppp7P+_81t++A@mail.gmail.com>
 <1516621142.7000.1170.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516621142.7000.1170.camel@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Harsha Priya N <harshapriya.n@intel.com>, Mark Brown <broonie@kernel.org>, Naveen M <naveen.m@intel.com>, Daniel Drake <drake@endlessm.com>
List-Id: alsa-devel@alsa-project.org

On 1/22/18 5:39 AM, Andy Shevchenko wrote:
> On Mon, 2018-01-22 at 11:58 +0100, Arnd Bergmann wrote:
>> On Mon, Jan 22, 2018 at 10:51 AM, Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>>> On Sun, 2018-01-21 at 23:14 +0100, Arnd Bergmann wrote:
> 
>>>> Slightly later, commit 05f4434bc130 ("ASoC: Intel: remove
>>>> mfld_machine")
>>>> was added, which then removed the Merrifield machine code that
>>>> happened
>>>> to be the only user of SND_SST_ATOM_HIFI2_PLATFORM_PCI. With that
>>>> gone,
>>>
>>> That's what I afraid of. Intel Merrifield *should* be there. What
>>> Vinod
>>> did, AFAIU, is removal of Intel Medfield support, which is fine with
>>> me.
>>>
>>> So, before this can go, we need to get confirmation from Vinod and
>>> Pierre, that Merrifield still stays there.
>>
>> Ok, I see. Checking further, I see that
>> SND_SST_ATOM_HIFI2_PLATFORM_PCI
>> cannot be built without SND_SST_ATOM_HIFI2_PLATFORM:
>>
>> sound/soc/intel/atom/sst/sst_drv_interface.o: In function
>> `sst_register':
>> sst_drv_interface.c:(.text+0xc3e): undefined reference to
>> `sst_register_dsp'
>> sound/soc/intel/atom/sst/sst_drv_interface.o: In function
>> `sst_unregister':
>> sst_drv_interface.c:(.text+0xc67): undefined reference to
>> `sst_unregister_dsp'
> 
> Oh.
> 
>>
>> How about this instead:
>>
>> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
>> index f2c9e8c5970a..16344bd24eb0 100644
>> --- a/sound/soc/intel/Kconfig
>> +++ b/sound/soc/intel/Kconfig
>> @@ -72,21 +72,8 @@ config SND_SOC_INTEL_BAYTRAIL
>>            for Baytrail Chromebooks but this option is now deprecated
>> and is
>>            not recommended, use SND_SST_ATOM_HIFI2_PLATFORM instead.
>>
>> -config SND_SST_ATOM_HIFI2_PLATFORM_PCI
>> -       tristate "PCI HiFi2 (Medfield, Merrifield) Platforms"
>> -       depends on X86 && PCI
>> -       select SND_SST_IPC_PCI
>> -       select SND_SOC_COMPRESS
>> -       help
>> -         If you have a Intel Medfield or Merrifield/Edison platform,
>> then
>> -         enable this option by saying Y or m. Distros will typically
>> not
>> -         enable this option: Medfield devices are not available to
>> -         developers and while Merrifield/Edison can run a mainline
>> kernel with
>> -         limited functionality it will require a firmware file which
>> -         is not in the standard firmware tree
>> -
>>   config SND_SST_ATOM_HIFI2_PLATFORM
>> -       tristate "ACPI HiFi2 (Baytrail, Cherrytrail) Platforms"
>> +       tristate "ACPI HiFi2 (Baytrail, Cherrytrail, Merrifield)
>> Platforms"
> 
> Perhaps it makes sense to do something like _HIFI2 and on top
> HIFI2_PLATFORM and HIFI2_PCI, but it seems like a current split.
> 
> So, it means the split itself is not accurate in the first place.
> Pierre, Vinod?
> 
>> +config SND_SOC_INTEL_MRFLD_MACH
>> +       tristate "Merrifield/Edison platform"
> 
> Edison should not be here (it's a board, while Merrifield is a platform)
> 
>> +       depends on X86_INTEL_LPSS && I2C && PCI
> 
> X86_INTEL_LPSS has nothing to do with Merrifield. :-)
> 
>> +       select SND_SST_IPC_PCI
>> +       help
>> +         This adds support for ASoC PCI driver for the Merrifield
>> +         (platform) used e.g. on Intel Edison.  If you have
>> +         Merrifield/Edison platform, then enable this option by
>> saying
>> +         Y or m. Distros will typically not enable this option: while
>> +         Merrifield/Edison can run a mainline kernel with limited
>> +         functionality it will require a firmware file which is not
>> in
>> +         the standard firmware tree.
> 
> Above looks like a solution to me, although I'm not familiar with ASoC
> code, so, I would rely on Pierre, Vinod and Liam suggestions.

I'd suggest that we instead add SND_SST_ATOM_HIFI2_PLATFORM_ACPI (for 
symmetry with PCI) and keep the SND_SST_ATOM_HIFI2_PLATFORM as a common 
part to solve this coexistence.

e.g (untested - just idea)

config SND_SST_ATOM_HIFI2_PLATFORM_PCI
	tristate "PCI HiFi2 (Merrifield) Platforms"
	depends on X86 && PCI
	select SND_SST_IPC_PCI
	select SND_SST_ATOM_HIFI2_PLATFORM

config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
	tristate "ACPI HiFi2 (Baytrail, Cherrytrail) Platforms"
	depends on X86 && ACPI
	select SND_SST_IPC_ACPI
	select SND_SST_ATOM_HIFI2_PLATFORM

config SND_SST_ATOM_HIFI2_PLATFORM
	tristate
	select SND_SOC_COMPRESS

That said changing names would break oldnoconfig so maybe something 
similar that just adds the common layer.
