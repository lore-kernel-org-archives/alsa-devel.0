From: Sinan Kaya <Okaya@kernel.org>
Subject: Re: [alsa-devel] [PATCH v5 08/11] ASoC: Intel: atom: Make PCI
 dependency explicit
Date: Thu, 3 Jan 2019 03:28:52 +0000
Message-ID: <CAK9iUCNGUE82MLposxdLjqgq_710Mk7nVKnABw3P7A9VJiG=yA@mail.gmail.com>
References: <20190102181038.4418-1-okaya@kernel.org> <20190102181038.4418-9-okaya@kernel.org>
 <57ed1d94-7f89-20e8-3289-7ef7efd18c20@linux.intel.com> <CAK9iUCNMAuDOh_CM-bTE1xT5FePfYbq7W+0R4KF1KbqskuJ8FA@mail.gmail.com>
 <a9ccf7e1-4752-6bf5-2621-15b21a80c2ca@linux.intel.com> <CAK9iUCPWQ=9EgnUFo8BHraEgFwHs3FdbegPLwhT-KHD=r2WBkQ@mail.gmail.com>
 <8c69f8d0-6a95-0011-ff87-8ac9236a992d@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8c69f8d0-6a95-0011-ff87-8ac9236a992d@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, open list <linux-kernel@vger.kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, Chandan Rajendra <chandan@linux.vnet.ibm.com>, tony.luck@intel.com
List-Id: alsa-devel@alsa-project.org

+Tony

On Wed, Jan 2, 2019 at 11:50 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
> On 1/2/19 4:58 PM, Sinan Kaya wrote:
> > On Wed, Jan 2, 2019 at 10:50 PM Pierre-Louis Bossart
> > <pierre-louis.bossart@linux.intel.com> wrote:
> >>
> >>> This is pointing to a kconfig issue on ia64 arch.
> >>>
> >>> arch/ia64/Kconfig:128:error: recursive dependency detected!
> >>> arch/ia64/Kconfig:128:    choice <choice> contains symbol IA64_HP_SIM
> >>> arch/ia64/Kconfig:202:    symbol IA64_HP_SIM is part of choice PM
> >>>
> >>> IA64_HP_SIM is both a choice and is selected.
> >>>
> >>> I did allyesconfig and disabled PCI afterwards to find all the issues
> >>> on this patchset.
> >> Are you saying there's a newer series that fixes this issue for both
> >> allyesconfig and allmodconfig?
> >>
> >> if yes, then we're good.
> >
> > No, I haven't fixed ia64 kconfig issue. That's somebody else's job. I
> > used allyesconfig to find out all compilation issues on x86 arch to
> > come up with this patchset.
>
> Nothing makes me cringe more than "somebody else's job" statements. In
> this case, there is obviously a correlation with your ACPI changes since
> the circular dependency happens because of the ACPI symbol.
>

I agree that it needs to be fixed. I am not convinced that the issue
is related to my change.
Your log is pointing to an inconsistency in ia64 kconfig.

> arch/ia64/Kconfig:126:error: recursive dependency detected!
> arch/ia64/Kconfig:126:    choice <choice> contains symbol IA64_HP_SIM
> arch/ia64/Kconfig:200:    symbol IA64_HP_SIM is part of choice PM
> kernel/power/Kconfig:144:    symbol PM is selected by PM_SLEEP
> kernel/power/Kconfig:104:    symbol PM_SLEEP depends on HIBERNATE_CALLBACKS
> kernel/power/Kconfig:31:    symbol HIBERNATE_CALLBACKS is selected by
> HIBERNATION
> kernel/power/Kconfig:34:    symbol HIBERNATION depends on SWAP
> init/Kconfig:250:    symbol SWAP depends on BLOCK
> block/Kconfig:5:    symbol BLOCK is selected by UBIFS_FS
> fs/ubifs/Kconfig:1:    symbol UBIFS_FS depends on MISC_FILESYSTEMS
> fs/Kconfig:220:    symbol MISC_FILESYSTEMS is selected by ACPI_APEI
> drivers/acpi/apei/Kconfig:8:    symbol ACPI_APEI depends on ACPI
> drivers/acpi/Kconfig:9:    symbol ACPI depends on ARCH_SUPPORTS_ACPI
> <<<< LOOK HERE

I am still having hard time seeing how this issue is exposed by
removing PCI dependency from ACPi.

Rafael, Tony:

can you help me?

> drivers/acpi/Kconfig:6:    symbol ARCH_SUPPORTS_ACPI is selected by
> IA64_HP_SIM
> arch/ia64/Kconfig:200:    symbol IA64_HP_SIM is part of choice <choice>
>
> At any rate, a 3 mn git bisect tells me the circular dependency is
> exposed by this change:
>
> f3fd6cd74fedf99b6060f75df00943fda13b65f2 is the first bad commit
> commit f3fd6cd74fedf99b6060f75df00943fda13b65f2
> Author: Chandan Rajendra <chandan@linux.vnet.ibm.com>
> Date:   Sat Dec 8 12:21:38 2018 +0530
>
>      fscrypt: remove filesystem specific build config option
>
>      In order to have a common code base for fscrypt "post read" processing
>      for all filesystems which support encryption, this commit removes
>      filesystem specific build config option (e.g.
> CONFIG_EXT4_FS_ENCRYPTION)
>      and replaces it with a build option (i.e. CONFIG_FS_ENCRYPTION) whose
>      value affects all the filesystems making use of fscrypt.
>
>      Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
>      Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>
> -Pierre
>
>
