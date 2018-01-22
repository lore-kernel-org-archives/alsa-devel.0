From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [alsa-devel] [PATCH] ASoC: intel: clean up CONFIG_SND_SST_IPC handling
Date: Mon, 22 Jan 2018 21:59:58 +0100
Message-ID: <CAK8P3a2b=igCG5_TAOoJfydpx5LLi_o_CuDhPS6mYCYvEJQXwQ@mail.gmail.com>
References: <20180121221505.196163-1-arnd@arndb.de> <1516614692.7000.1155.camel@linux.intel.com>
 <CAK8P3a0H6CbFgqQijFRYsDoYq3mEPcuBL6x01Ppp7P+_81t++A@mail.gmail.com>
 <1516621142.7000.1170.camel@linux.intel.com> <a463e463-2181-1047-3721-529d8923ad68@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a463e463-2181-1047-3721-529d8923ad68@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Harsha Priya N <harshapriya.n@intel.com>, Mark Brown <broonie@kernel.org>, Naveen M <naveen.m@intel.com>, Daniel Drake <drake@endlessm.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 22, 2018 at 5:37 PM, Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> On 1/22/18 5:39 AM, Andy Shevchenko wrote:
>> On Mon, 2018-01-22 at 11:58 +0100, Arnd Bergmann wrote:
>>> On Mon, Jan 22, 2018 at 10:51 AM, Andy Shevchenko
>>> <andriy.shevchenko@linux.intel.com> wrote:
>>>> On Sun, 2018-01-21 at 23:14 +0100, Arnd Bergmann wrote:

>> Above looks like a solution to me, although I'm not familiar with ASoC
>> code, so, I would rely on Pierre, Vinod and Liam suggestions.
>
>
> I'd suggest that we instead add SND_SST_ATOM_HIFI2_PLATFORM_ACPI (for
> symmetry with PCI) and keep the SND_SST_ATOM_HIFI2_PLATFORM as a common part
> to solve this coexistence.
>
> e.g (untested - just idea)
>
> config SND_SST_ATOM_HIFI2_PLATFORM_PCI
>         tristate "PCI HiFi2 (Merrifield) Platforms"
>         depends on X86 && PCI
>         select SND_SST_IPC_PCI
>         select SND_SST_ATOM_HIFI2_PLATFORM
>
> config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
>         tristate "ACPI HiFi2 (Baytrail, Cherrytrail) Platforms"
>         depends on X86 && ACPI
>         select SND_SST_IPC_ACPI
>         select SND_SST_ATOM_HIFI2_PLATFORM
>
> config SND_SST_ATOM_HIFI2_PLATFORM
>         tristate
>         select SND_SOC_COMPRESS
>
> That said changing names would break oldnoconfig so maybe something similar
> that just adds the common layer.

It sounds like a good idea, at least if it can be done without a
larger code rework.
For the new SND_SST_ATOM_HIFI2_PLATFORM_ACPI symbol, you could simply
make that 'default ACPI' to make at least 'oldconfig' and 'olddefconfig' work.

See https://pastebin.com/GKtkgW99 for my randconfig file for testing the
configuration that I hit. With the current state of linux-next, there are two
configurations that are broken AFAICT

- SND_SST_ATOM_HIFI2_PLATFORM_PCI=y && SND_SST_ATOM_HIFI2_PLATFORM=m
  (because of the Makefile thing I mentioned)

- SND_SST_ATOM_HIFI2_PLATFORM_PCI=y && SND_SST_ATOM_HIFI2_PLATFORM=n
  (because of missing symbols)

       Arnd
