From: Darren Hart <dvhart@infradead.org>
Subject: Re: [RESEND PATCH v4] clk: x86: Add Atom PMC platform clocks
Date: Wed, 26 Oct 2016 14:33:23 -0700
Message-ID: <20161026213323.GB23374@f23x64.localdomain>
References: <1476735320-4315-1-git-send-email-irina.tirdea@intel.com>
 <alpine.DEB.2.20.1610202349200.4938@nanos>
 <20161021045932.GA90338@f23x64.localdomain>
 <1F3AC3675D538145B1661F571FE1805F2F387575@irsmsx105.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F2F387575@irsmsx105.ger.corp.intel.com>
Sender: linux-clk-owner@vger.kernel.org
To: "Tirdea, Irina" <irina.tirdea@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Ingo Molnar <mingo@redhat.com>, Michael Turquette <mturquette@baylibre.com>, "H. Peter Anvin" <hpa@zytor.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, "Bossart, Pierre-louis" <pierre-louis.bossart@intel.com>, LKML <linux-kernel@vger.kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 24, 2016 at 01:38:54PM +0000, Tirdea, Irina wrote:
> > On Thu, Oct 20, 2016 at 11:52:38PM +0200, Thomas Gleixner wrote:
> > > On Mon, 17 Oct 2016, Irina Tirdea wrote:
> > > > The patch has already been reviewed by Stephen Boyd [1].
> > > > The only remaining question is the one pointed out by Stephen:
> > > > "Will there be problems if this merges through clk tree? If so we
> > > > could take the clk driver part and the platform data include part
> > > > could be duplicated into both trees. Or clk tree could be pulled
> > > > into x86?" [1]
> > >
> > > The proper thing to do is:
> > >
> > > Move all that cruft including arch/x86/platform/atom/pmc_atom.c into
> > > drivers/platform/x86. There is nothing architecture specific in these
> > > files. It's pure peripheral driver enablement. So drivers/platform/x86 is
> > > the proper location for this. Please discuss this with Darren Hart (cc'ed).
> > 
> 
> Thanks for pointing me in the right direction, Thomas!
> 
> > We've been adding more of the pmc and punit drivers to drivers/platform/x86.
> > This makes more sense than being under "arch". Thomas and I have discussed
> > moving more of the non architectural stuff in arch/x86/platform to my tree under
> > platform/drivers/x86.
> > 
> 
> Thanks for the reply, Darren.
> 
> I could move the arch/x86/platform/atom/pmc_atom.c into drivers/platform/x86,
> but I'm not sure what the process is in this case. I took a look at your tree and noticed
> some intel_pmc_* drivers, but they are quite different from pmc_atom.c in terms of
> HW registers and capabilities. Should the code from pmc_atom.c be integrated in the
> intel_pmc_* drivers or is it enough to move it as a standalone driver for now?

If the functionality is substantially different, then I don't see a
compelling, and certainly not an immediate, need to merge them. Assume
for now they are to remain as separate drivers. I suggest keeping the
existing name for now as well. Let's just complete the move with as
little user-visible changes as possible.

The placement of the header file is a bit tricky as it is being used in
drivers/clk/x86 in addition to the pmc_atom driver in
drivers/platform/x86.

The best existing location would appear to be include/platform_data/

Thomas, is that acceptable to you?

arch/x86/platform/atom/pmc_atom.c -> drivers/platform/x86
arch/x86/include/asm/pmc_atom.h -> include/platform_data/

If there are enough of these, it might make sense to create:

include/platform/x86/

but I suggest we start with minimal change.

> 
> > Irina, please point me at the relevant context if it's more than just this
> > particular patch.
> 
> This patch comes from a set of patches that enable sound for Baytrail CR devices
> (especially Asus T100TAF) [1]. The rest of the patches have been already merged in
> Mark's sound tree. This is the only change remaining for enabling sound on these
> platforms, so there are no additional changes to the x86 platform code.
> 
> Thanks,
> Irina
> 
> [1] http://mailman.alsa-project.org/pipermail/alsa-devel/2016-August/111704.html
> 
> 

-- 
Darren Hart
Intel Open Source Technology Center
