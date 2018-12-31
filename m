From: Sinan Kaya <Okaya@kernel.org>
Subject: Re: [PATCH v4 08/11] ASoC: Intel: atom: Make PCI dependency explicit
Date: Mon, 31 Dec 2018 23:35:21 +0300
Message-ID: <CAK9iUCNhPg21ZFxkbqquTQ5aRRh7ojsSiFP4_RJ2_MsD4t=cYw@mail.gmail.com>
References: <20181230195612.6657-1-okaya@kernel.org> <20181230195612.6657-9-okaya@kernel.org>
 <20181231174654.GH1846@sirena.org.uk> <CAK9iUCPHu0FV9LqMOKixKi7Cg_DC_F04OeXh50YSHOpgkGKejQ@mail.gmail.com>
 <20181231193017.GN1846@sirena.org.uk> <CAK9iUCNf9JqwvtL4O5KVHP9ZN3y66wZOTjOsGcXFc-T_g6xtEQ@mail.gmail.com>
 <d288e6cf-158f-e832-6096-17d3faf9e3e9@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d288e6cf-158f-e832-6096-17d3faf9e3e9@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 31, 2018 at 11:29 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
> On 12/31/18 1:35 PM, Sinan Kaya wrote:
> > On Mon, Dec 31, 2018 at 10:30 PM Mark Brown <broonie@kernel.org> wrote:
> >> On Mon, Dec 31, 2018 at 08:52:52PM +0300, Sinan Kaya wrote:
> >>> On Mon, Dec 31, 2018 at 8:47 PM Mark Brown <broonie@kernel.org> wrote:
> >>>> I don't have the cover letter or anything for this series, what's going
> >>>> on with dependencies?
> >>> Here is the executive summary:
> >>> I have a changeset that separates ACPI from PCI on 4.21. CONFIG_ACPI
> >>> used to select PCI. This is no longer true.
> >>> You can build an ACPI system without any PCI devices.
> >> So there's no dependency and I can just apply this?
> > The plan is to apply this patchset via ACPI tree. Need an Acked-by per patch.
> Anytime we change the Kconfig settings for audio, we get all kinds of
> problems with randconfig and 0day/kbuild due to depend/select issues.
> I'd like to give this a spin first, can you share a link to the entire
> series? Thanks!

Sure,

You can find them here

https://lore.kernel.org/patchwork/patch/1028330/

Click related.
