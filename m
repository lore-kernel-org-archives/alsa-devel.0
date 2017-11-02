From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: fix Kconfig dependencies
Date: Thu, 2 Nov 2017 17:25:01 +0100
Message-ID: <CAK8P3a2jXrL2-eEZ0h_ay6CR45quzVjiqD5dWxubz29rVpxFYA@mail.gmail.com>
References: <20171102110737.2813128-1-arnd@arndb.de> <48ffc83d-6ab0-3388-fade-9e02dc4459cf@linux.intel.com>
 <CAK8P3a3p4k=iU9Ym_h-Ahq5y93ga2yhDLO6S_6+g7dLN5aGbQQ@mail.gmail.com>
 <CAK8P3a3DhaUvQiyggVopT=DnRV2octdx8Qh8EeYmHd6fKaYHkg@mail.gmail.com> <20171102160406.GG3187@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171102160406.GG3187@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Harsha Priya N <harshapriya.n@intel.com>, Naveen M <naveen.m@intel.com>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 2, 2017 at 5:04 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Thu, Nov 02, 2017 at 02:12:11PM +0100, Arnd Bergmann wrote:
>> On Thu, Nov 2, 2017 at 2:04 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Thu, Nov 2, 2017 at 1:43 PM, Pierre-Louis Bossart
>> > <pierre-louis.bossart@linux.intel.com> wrote:
>> >> On 11/2/17 6:07 AM, Arnd Bergmann wrote:
>> >>>
>> >>> I ran into multiple problems during randconfig builds of the
>> >>> recently changed Kconfig logic for Intel ASoC drivers:
>> >>
>> >>
>> >> we did quite a bit of testing on this change, looks like we missed a number
>> >> of cases. Gah.
>> >>
>> >>>
>> >>> - Building without DMADEVICES doesn't work in general
>> >>
>> >>
>> >> the Intel audio hardware has its own DMA in general, be it based on
>> >> DesignWare controlled by audio firmware or HDaudio, not sure if/why this
>> >> dependency is needed across the board?
>> >
>> > Probably my mistake. I'll try again without the dependency and see
>> > what problems I run into then and what the correct fix is.
>>
>> I immediately ran into this Kconfig warning, so this is clearly for the two
>> users of SND_SOC_INTEL_SST_FIRMWARE:
>>
>> warning: (SATA_DWC_OLD_DMA && SERIAL_8250_LPSS &&
>> SND_SOC_INTEL_SST_FIRMWARE) selects DW_DMAC_CORE which has unmet
>> direct dependencies (DMADEVICES)
>
> The BYT legacy drivers used DMAengine (dw) to load the firmware and hence the
> dependency. The Skylake and other drivers do not need that, so we should
> move this from toplevel to the BYT driver only.

Ok, so Haswell also shouldn't select SND_SOC_INTEL_SST_FIRMWARE, right?

>>  config SND_SOC_INTEL_SST_FIRMWARE
>>         tristate
>> -       select DW_DMAC_CORE
>
> this is required as we need this DMA driver. It might not have issues on
> compile but functionality would be broken.

It's also broken at compile time, I just ran into that.

>>  config SND_SOC_INTEL_SST_ACPI
>>         tristate
>> @@ -32,19 +31,20 @@ config SND_SOC_ACPI_INTEL_MATCH
>>  config SND_SOC_INTEL_SST_TOPLEVEL
>>         tristate "Intel ASoC SST drivers"
>>         depends on X86 || COMPILE_TEST
>> -       depends on DMADEVICES
>
> This is fine
>
>>         select SND_SOC_INTEL_MACH
>>         select SND_SOC_INTEL_COMMON
>>
>>  config SND_SOC_INTEL_HASWELL
>>         tristate "Intel ASoC SST driver for Haswell/Broadwell"
>>         depends on SND_SOC_INTEL_SST_TOPLEVEL && SND_DMA_SGBUF
>> +       depends on DMADEVICES
>
> yes this and below seems right fix to me.

Ok, thanks for taking a look! I'll let the randconfig builder chew on this
overnight, and send a new version tomorrow.

     Arnd
