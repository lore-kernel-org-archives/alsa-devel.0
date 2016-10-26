From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RESEND PATCH v4] clk: x86: Add Atom PMC platform clocks
Date: Wed, 26 Oct 2016 23:43:24 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1610262341020.5013@nanos>
References: <1476735320-4315-1-git-send-email-irina.tirdea@intel.com> <alpine.DEB.2.20.1610202349200.4938@nanos> <20161021045932.GA90338@f23x64.localdomain> <1F3AC3675D538145B1661F571FE1805F2F387575@irsmsx105.ger.corp.intel.com>
 <20161026213323.GB23374@f23x64.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161026213323.GB23374@f23x64.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: "Tirdea, Irina" <irina.tirdea@intel.com>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Ingo Molnar <mingo@redhat.com>, Michael Turquette <mturquette@baylibre.com>, "H. Peter Anvin" <hpa@zytor.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, "Bossart, Pierre-louis" <pierre-louis.bossart@intel.com>, LKML <linux-kernel@vger.kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 26 Oct 2016, Darren Hart wrote:
> On Mon, Oct 24, 2016 at 01:38:54PM +0000, Tirdea, Irina wrote:
> > intel_pmc_* drivers or is it enough to move it as a standalone driver for now?
> 
> If the functionality is substantially different, then I don't see a
> compelling, and certainly not an immediate, need to merge them. Assume
> for now they are to remain as separate drivers. I suggest keeping the
> existing name for now as well. Let's just complete the move with as
> little user-visible changes as possible.
> 
> The placement of the header file is a bit tricky as it is being used in
> drivers/clk/x86 in addition to the pmc_atom driver in
> drivers/platform/x86.
> 
> The best existing location would appear to be include/platform_data/
> 
> Thomas, is that acceptable to you?

Yes

> arch/x86/platform/atom/pmc_atom.c -> drivers/platform/x86
> arch/x86/include/asm/pmc_atom.h -> include/platform_data/
> 
> If there are enough of these, it might make sense to create:
> 
> include/platform/x86/
> 
> but I suggest we start with minimal change.

No. Make that x86 directory right away. include/platform_data is already a
maze of 224 files. Start structuring it now.

Thanks,

	tglx
