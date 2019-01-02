From: Sinan Kaya <Okaya@kernel.org>
Subject: Re: [alsa-devel] [PATCH v5 08/11] ASoC: Intel: atom: Make PCI
 dependency explicit
Date: Wed, 2 Jan 2019 22:09:43 +0000
Message-ID: <CAK9iUCNMAuDOh_CM-bTE1xT5FePfYbq7W+0R4KF1KbqskuJ8FA@mail.gmail.com>
References: <20190102181038.4418-1-okaya@kernel.org> <20190102181038.4418-9-okaya@kernel.org>
 <57ed1d94-7f89-20e8-3289-7ef7efd18c20@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57ed1d94-7f89-20e8-3289-7ef7efd18c20@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 2, 2019 at 8:33 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
> I have three opens with this ACPI/PCI change
>
> 1. the baseline change fails on my cross-compilation checks, see below
> the result of the attached script (simplification of the one I use to
> avoid 0day reports).
>

This is pointing to a kconfig issue on ia64 arch.

arch/ia64/Kconfig:128:error: recursive dependency detected!
arch/ia64/Kconfig:128:    choice <choice> contains symbol IA64_HP_SIM
arch/ia64/Kconfig:202:    symbol IA64_HP_SIM is part of choice PM

IA64_HP_SIM is both a choice and is selected.

I did allyesconfig and disabled PCI afterwards to find all the issues
on this patchset.

> 2. there are different patterns to express the dependency on PCI e.g.
>
>   config MMC_SDHCI_ACPI
>       tristate "SDHCI support for ACPI enumerated SDHCI controllers"
>       depends on MMC_SDHCI && ACPI
> -    select IOSF_MBI if X86
> +    select IOSF_MBI if (X86 && PCI)
>
> but
>
> config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
>       tristate "ACPI HiFi2 (Baytrail, Cherrytrail) Platforms"
>       default ACPI
> -    depends on X86 && ACPI
> +    depends on X86 && ACPI && PCI
>       select SND_SST_IPC_ACPI
>       select SND_SST_ATOM_HIFI2_PLATFORM
>       select SND_SOC_ACPI_INTEL_MATCH
>

I matched depends line to

depends on X86 && ACPI && PCI

for MMC_SDHCI_ACPI per feedback from Rafael on V5. This should resolve
the inconsistency.


> IOSF is only needed for Baytrail-CR detection, and the code will compile
> fine without it, so maybe it'd be a better model if you used the
> following diff?
>
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index 2fd1b61e8331..68af0ea5c96c 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -95,7 +95,7 @@ config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
>          select SND_SST_IPC_ACPI
>          select SND_SST_ATOM_HIFI2_PLATFORM
>          select SND_SOC_ACPI_INTEL_MATCH
> -       select IOSF_MBI
> +       select IOSF_MBI if PCI
>
> 3. All the Intel machine drivers depend on X86_INTEL_LPSS which depends
> on PCI. But for Baytrail/Haswell/Broadwell we have only a dependency on
> ACPI, so we expose drivers that can be selected but fail on probe since
> there are no machine drivers. I am not sure if we want to be strict and
> only expose meaningful configurations, or allow for more compilations
> tests and corner cases?

Hopefully, v5 resolves this too with

depends on X86 && ACPI && PCI

Let me know otherwise.
