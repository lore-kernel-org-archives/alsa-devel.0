From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: fix Kconfig dependencies
Date: Thu, 2 Nov 2017 14:04:26 +0100
Message-ID: <CAK8P3a3p4k=iU9Ym_h-Ahq5y93ga2yhDLO6S_6+g7dLN5aGbQQ@mail.gmail.com>
References: <20171102110737.2813128-1-arnd@arndb.de> <48ffc83d-6ab0-3388-fade-9e02dc4459cf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <48ffc83d-6ab0-3388-fade-9e02dc4459cf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Harsha Priya N <harshapriya.n@intel.com>, Naveen M <naveen.m@intel.com>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 2, 2017 at 1:43 PM, Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> On 11/2/17 6:07 AM, Arnd Bergmann wrote:
>>
>> I ran into multiple problems during randconfig builds of the
>> recently changed Kconfig logic for Intel ASoC drivers:
>
>
> we did quite a bit of testing on this change, looks like we missed a number
> of cases. Gah.
>
>>
>> - Building without DMADEVICES doesn't work in general
>
>
> the Intel audio hardware has its own DMA in general, be it based on
> DesignWare controlled by audio firmware or HDaudio, not sure if/why this
> dependency is needed across the board?

Probably my mistake. I'll try again without the dependency and see
what problems I run into then and what the correct fix is.

>> - With that dependency added, we can relax the 'depends
>>    on X86' again and allow compile-testing, except for
>>    SND_SST_ATOM_HIFI2_PLATFORM, which depends on X86
>>    for asm/platform_sst_audio. > - Skylake requires
>> SND_SOC_INTEL_SST_ACPI, so we
>>    have to depend on ACPI in turn
>> - Haswell needs SND_DMA_SGBUF for snd_sgbuf_aligned_pages()
>
>
> This one is surprising as well, this was not there before so it either was
> not detected or is not needed?

No idea. The driver has clearly been calling snd_sgbuf_aligned_pages()
since commit 0b708c87f66a ("ASoC: Intel: Fix Haswell/Broadwell DSP
page table creation.") back in 2014, and the helper function has been
unavailable since 2008. My best guess is that some other Kconfig option
enforced the dependency implicitly before.

       Arnd
