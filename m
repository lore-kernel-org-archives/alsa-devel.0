From: Sinan Kaya <Okaya@kernel.org>
Subject: Re: [PATCH v4 08/11] ASoC: Intel: atom: Make PCI dependency explicit
Date: Mon, 31 Dec 2018 22:35:20 +0300
Message-ID: <CAK9iUCNf9JqwvtL4O5KVHP9ZN3y66wZOTjOsGcXFc-T_g6xtEQ@mail.gmail.com>
References: <20181230195612.6657-1-okaya@kernel.org> <20181230195612.6657-9-okaya@kernel.org>
 <20181231174654.GH1846@sirena.org.uk> <CAK9iUCPHu0FV9LqMOKixKi7Cg_DC_F04OeXh50YSHOpgkGKejQ@mail.gmail.com>
 <20181231193017.GN1846@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181231193017.GN1846@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 31, 2018 at 10:30 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Dec 31, 2018 at 08:52:52PM +0300, Sinan Kaya wrote:
> > On Mon, Dec 31, 2018 at 8:47 PM Mark Brown <broonie@kernel.org> wrote:
>
> > > I don't have the cover letter or anything for this series, what's going
> > > on with dependencies?
>
> > Here is the executive summary:
>
> > I have a changeset that separates ACPI from PCI on 4.21. CONFIG_ACPI
> > used to select PCI. This is no longer true.
>
> > You can build an ACPI system without any PCI devices.
>
> So there's no dependency and I can just apply this?

The plan is to apply this patchset via ACPI tree. Need an Acked-by per patch.
