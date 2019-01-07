From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 08/11] ASoC: Intel: atom: Make PCI dependency explicit
Date: Mon, 7 Jan 2019 12:15:35 +0100
Message-ID: <CAJZ5v0g2bjzjuiDPTbBN8QgvOG0KMC0Ew2QOQH4u2+y6KRo0wQ@mail.gmail.com>
References: <20190105100606.6673-1-okaya@kernel.org> <20190105100606.6673-9-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190105100606.6673-9-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Jan 5, 2019 at 11:06 AM Sinan Kaya <okaya@kernel.org> wrote:
>
> After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
> CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
> satisfied implicitly through dependencies on CONFIG_ACPI have to be
> specified directly. This code relies on IOSF_MBI and IOSF_MBI depends
> on PCI. For this reason, add a direct dependency on CONFIG_PCI to the
> IOSF_MBI driver.
>
> Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> Signed-off-by: Sinan Kaya <okaya@kernel.org>

Sinan, I thought you received an ACK from Pierre-Louis on this one, didn't you?

> ---
>  sound/soc/intel/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index 99a62ba409df..bd9fd2035c55 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -91,7 +91,7 @@ config SND_SST_ATOM_HIFI2_PLATFORM_PCI
>  config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
>         tristate "ACPI HiFi2 (Baytrail, Cherrytrail) Platforms"
>         default ACPI
> -       depends on X86 && ACPI
> +       depends on X86 && ACPI && PCI
>         select SND_SST_IPC_ACPI
>         select SND_SST_ATOM_HIFI2_PLATFORM
>         select SND_SOC_ACPI_INTEL_MATCH
> --

Mark, assuming that the ACK above was given here, do you want me to
take this patch or do you want to take care of it yourself?
