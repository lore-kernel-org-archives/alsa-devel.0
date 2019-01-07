From: Sinan Kaya <Okaya@kernel.org>
Subject: Re: [PATCH v6 08/11] ASoC: Intel: atom: Make PCI dependency explicit
Date: Mon, 7 Jan 2019 10:16:53 -0500
Message-ID: <CAK9iUCPjMr0m+9HUXEbtUPrsvO84HpZV39CUYYkne=EpY_X+bQ@mail.gmail.com>
References: <20190105100606.6673-1-okaya@kernel.org> <20190105100606.6673-9-okaya@kernel.org>
 <CAJZ5v0g2bjzjuiDPTbBN8QgvOG0KMC0Ew2QOQH4u2+y6KRo0wQ@mail.gmail.com> <20190107121919.GA9570@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190107121919.GA9570@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux-Next Mailing List <linux-next@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 7, 2019 at 7:19 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Jan 07, 2019 at 12:15:35PM +0100, Rafael J. Wysocki wrote:
> > On Sat, Jan 5, 2019 at 11:06 AM Sinan Kaya <okaya@kernel.org> wrote:
>
> > > Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> > > Signed-off-by: Sinan Kaya <okaya@kernel.org>
>
> > Sinan, I thought you received an ACK from Pierre-Louis on this one, didn't you?
>
> Yes.  I've also applied it already and it's *still* being sent without
> either a cover letter or the rest of the series :(

There is a cover letter but it is being sent to Linux-acpi and Linux-next only.

https://patchwork.kernel.org/cover/10749203/

This means that you are not on either of these mailing lists.

>
> Sinan:
>
> Please do not submit new versions of already applied patches, please
> submit incremental updates to the existing code.  Modifying existing
> commits creates problems for other users building on top of those
> commits so it's best practice to only change pubished git commits if
> absolutely essential.

I apologize. I didn't realize that you applied this already. I'll drop
this patch
in case I need to submit a new revision.
