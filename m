From: Sinan Kaya <Okaya@kernel.org>
Subject: Re: [PATCH v1 08/11] ASoC: Intel: Make PCI dependency explicit
Date: Sat, 22 Dec 2018 07:26:30 +0100
Message-ID: <CAK9iUCN77U5tQn-WWaL27v244GkEAgRBxKK1H_+xUhOZ2aCERw@mail.gmail.com>
References: <20181222001452.7474-1-okaya@kernel.org> <20181222001452.7474-9-okaya@kernel.org>
 <eb27ab03-4f42-2e2e-9873-16d9a6927e2b@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <eb27ab03-4f42-2e2e-9873-16d9a6927e2b@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Dec 22, 2018 at 4:19 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 12/21/18 4:14 PM, Sinan Kaya wrote:
> > IOSF_MBI driver depends on CONFIG_PCI set but this is not specified
> > anywhere.
>
> wrong patch description...?

Not really...
Code does unconditional select for IOSF_MBI.

>
> > Signed-off-by: Sinan Kaya <okaya@kernel.org>
> > ---
> >  sound/soc/intel/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> > index 2fd1b61e8331..b0764b2fe001 100644
> > --- a/sound/soc/intel/Kconfig
> > +++ b/sound/soc/intel/Kconfig
> > @@ -91,7 +91,7 @@ config SND_SST_ATOM_HIFI2_PLATFORM_PCI
> >  config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
> >       tristate "ACPI HiFi2 (Baytrail, Cherrytrail) Platforms"
> >       default ACPI
> > -     depends on X86 && ACPI
> > +     depends on X86 && ACPI && PCI
> >       select SND_SST_IPC_ACPI
> >       select SND_SST_ATOM_HIFI2_PLATFORM
> >       select SND_SOC_ACPI_INTEL_MATCH
> >
>
>
> --
> ~Randy
