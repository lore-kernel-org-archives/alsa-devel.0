From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 08/11] ASoC: Intel: atom: Make PCI
 dependency explicit
Date: Wed, 2 Jan 2019 23:01:43 +0100
Message-ID: <CAJZ5v0jniuqiLVnB3ufkAKY2nT4H6OJG-wWrL7GsaK5dAJ6ybA@mail.gmail.com>
References: <20190102181038.4418-1-okaya@kernel.org>
 <20190102181038.4418-9-okaya@kernel.org>
 <57ed1d94-7f89-20e8-3289-7ef7efd18c20@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B4FE26782E
 for <alsa-devel@alsa-project.org>; Wed,  2 Jan 2019 23:01:55 +0100 (CET)
Received: by mail-ot1-f67.google.com with SMTP id w25so27858650otm.13
 for <alsa-devel@alsa-project.org>; Wed, 02 Jan 2019 14:01:55 -0800 (PST)
In-Reply-To: <57ed1d94-7f89-20e8-3289-7ef7efd18c20@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>, Sinan Kaya <okaya@kernel.org>, Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, open list <linux-kernel@vger.kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-Next Mailing List <linux-next@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 2, 2019 at 9:33 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
> I have three opens with this ACPI/PCI change
>
> 1. the baseline change fails on my cross-compilation checks, see below
> the result of the attached script (simplification of the one I use to
> avoid 0day reports).

What baseline change?

That failure is not related to PCI if I'm not missing anything.

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

Well, does it actually make sense to ever set
SND_SST_ATOM_HIFI2_PLATFORM_ACPI without PCI?

> 3. All the Intel machine drivers depend on X86_INTEL_LPSS which depends
> on PCI. But for Baytrail/Haswell/Broadwell we have only a dependency on
> ACPI, so we expose drivers that can be selected but fail on probe since
> there are no machine drivers. I am not sure if we want to be strict and
> only expose meaningful configurations, or allow for more compilations
> tests and corner cases?

I would only expose meaningful configurations to start with and then
*maybe* relax that going forward as long as the benefit is worth it.

Cheers,
Rafael
