From: "Tirdea, Irina" <irina.tirdea@intel.com>
Subject: RE: [RESEND PATCH v4] clk: x86: Add Atom PMC platform clocks
Date: Mon, 24 Oct 2016 13:38:54 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F387575@irsmsx105.ger.corp.intel.com>
References: <1476735320-4315-1-git-send-email-irina.tirdea@intel.com>
 <alpine.DEB.2.20.1610202349200.4938@nanos>
 <20161021045932.GA90338@f23x64.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20161021045932.GA90338@f23x64.localdomain>
Content-Language: en-US
Sender: linux-clk-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Ingo Molnar <mingo@redhat.com>, Michael Turquette <mturquette@baylibre.com>, "H. Peter Anvin" <hpa@zytor.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, "Bossart, Pierre-louis" <pierre-louis.bossart@intel.com>, LKML <linux-kernel@vger.kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Darren Hart [mailto:dvhart@infradead.org]
> Sent: 21 October, 2016 8:00
> To: Thomas Gleixner
> Cc: Tirdea, Irina; linux-clk@vger.kernel.org; x86@kernel.org; Stephen Boyd; Ingo Molnar; Michael Turquette; H. Peter Anvin; alsa-
> devel@alsa-project.org; Mark Brown; Takashi Iwai; Bossart, Pierre-louis; LKML; Pierre-Louis Bossart
> Subject: Re: [RESEND PATCH v4] clk: x86: Add Atom PMC platform clocks
> 
> On Thu, Oct 20, 2016 at 11:52:38PM +0200, Thomas Gleixner wrote:
> > On Mon, 17 Oct 2016, Irina Tirdea wrote:
> > > The patch has already been reviewed by Stephen Boyd [1].
> > > The only remaining question is the one pointed out by Stephen:
> > > "Will there be problems if this merges through clk tree? If so we
> > > could take the clk driver part and the platform data include part
> > > could be duplicated into both trees. Or clk tree could be pulled
> > > into x86?" [1]
> >
> > The proper thing to do is:
> >
> > Move all that cruft including arch/x86/platform/atom/pmc_atom.c into
> > drivers/platform/x86. There is nothing architecture specific in these
> > files. It's pure peripheral driver enablement. So drivers/platform/x86 is
> > the proper location for this. Please discuss this with Darren Hart (cc'ed).
> 

Thanks for pointing me in the right direction, Thomas!

> We've been adding more of the pmc and punit drivers to drivers/platform/x86.
> This makes more sense than being under "arch". Thomas and I have discussed
> moving more of the non architectural stuff in arch/x86/platform to my tree under
> platform/drivers/x86.
> 

Thanks for the reply, Darren.

I could move the arch/x86/platform/atom/pmc_atom.c into drivers/platform/x86,
but I'm not sure what the process is in this case. I took a look at your tree and noticed
some intel_pmc_* drivers, but they are quite different from pmc_atom.c in terms of
HW registers and capabilities. Should the code from pmc_atom.c be integrated in the
intel_pmc_* drivers or is it enough to move it as a standalone driver for now?

> Irina, please point me at the relevant context if it's more than just this
> particular patch.

This patch comes from a set of patches that enable sound for Baytrail CR devices
(especially Asus T100TAF) [1]. The rest of the patches have been already merged in
Mark's sound tree. This is the only change remaining for enabling sound on these
platforms, so there are no additional changes to the x86 platform code.

Thanks,
Irina

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2016-August/111704.html

