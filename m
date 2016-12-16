From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v6 1/3] clk: x86: Add Atom PMC platform clocks
Date: Fri, 16 Dec 2016 10:36:07 -0800
Message-ID: <20161216183607.GB44199@f23x64.localdomain>
References: <1481306510-7471-1-git-send-email-irina.tirdea@intel.com>
 <1481306510-7471-2-git-send-email-irina.tirdea@intel.com>
 <CAHp75Vdaw4yvTPP2JZc+ti-AVNsisRQ+WG=JxPQ1jv-r7DADQA@mail.gmail.com>
 <1a98dcda-a662-958e-307f-5fe3f281ed9f@linux.intel.com>
 <CAHp75VccDyiLhWxZYg+d0usrwhfa_hiZAJCKPXXVRod=tB803g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VccDyiLhWxZYg+d0usrwhfa_hiZAJCKPXXVRod=tB803g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Irina Tirdea <irina.tirdea@intel.com>, linux-clk@vger.kernel.org, "x86@kernel.org" <x86@kernel.org>, platform-driver-x86@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 13, 2016 at 02:26:21AM +0200, Andy Shevchenko wrote:
> On Tue, Dec 13, 2016 at 2:15 AM, Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
> >
> >> Thanks for an update I will comment all the patches.
> >> Here we start.
> >
> >
> > Thanks Andy for the review. Two quick comments before going further in the
> > details later.
> >
> >>
> >>> The BayTrail and CherryTrail platforms provide platform clocks
> >>> through their Power Management Controller (PMC).
> >>>
> >>> The SoC supports up to 6 clocks (PMC_PLT_CLK[5:0]) with a
> >>> frequency of either 19.2 MHz (PLL) or 25 MHz (XTAL) for BayTrail
> >>> and a frequency of 19.2 MHz (XTAL) for CherryTrail. These clocks
> >>> are available for general system use, where appropriate, and each
> >>> have Control & Frequency register fields associated with them.
> >>>
> >>> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> >>> Signed-off-by: Pierre-Louis Bossart
> >>> <pierre-louis.bossart@linux.intel.com>
> >>
> >>
> >> Who is the actual author? SoB I guess should be either the author, or
> >> 1st, 2nd, ..., last one who is submitter.
> >
> >
> > I ported the initial code from Android legacy stuff and Irina ported the
> > functionality to the clk framework. It seems appropriate to have both
> > signed-offs?
> 
> Yes, but as I mentioned:
> 1) submitter goes last;
> 2) SoB lines and Author(s) should reflect actual state of the sources.
> If patch has 2 SoBs I'm expecting see different names of Authors in
> the source code. *Or* in some cases it's possible to explain in the
> commit message why you have former SoB and for what the credit that
> person(s) get.
> 
> >>> +#include <linux/platform_data/x86/clk-byt-plt.h>
> >
> >
> > This was a suggestion of Darren Hart in agreement with Thomas Gleixner.
> > see
> > http://mailman.alsa-project.org/pipermail/alsa-devel/2016-October/113936.html
> 
> Hmm... Thanks for pointing to this I didn't aware about such details.
> 
> But... I still insist that is not a platform data at all in both cases.
> 
> For clock I would suggest include/linux/clk/ with x86_ prefix.
> For the rest I have no strong opinion except trying to avoid
> platform_data wording in the path as much as possible.
> 
> As an example I could recall DMA engine subsystem where we have
> 
> include/linux/platform_data/dma-*.h
> 
> and
> 
> include/linux/dma/*.h
> 
> So, this sounds more to me as
> 
> include/linux/x86/pmc_atom.h

There should really be some Documentation about how to choose an include
directory :-)

My understanding is include/linux should be more generic, rather than platform
specific headers. So while platform_data may refer specifically to the platform
bus drivers, it's the closest thing we have to include/platform, which would be
ideal. I would prefer to stick with include/platform_data because:

1) Semantically, it's the closest thing there is
2) include/linux should be for more generic headers related to the OS or
   subsystems
3) It doesn't make sense to create a separate include/platform directory for a
   single header.
4) We don't want to rename platform_data to platform now and change all the
   drivers, but it could be changed later.

Thomas, do you disagree with any of the above?

> 
> > Darren, did we get your proposal right?
> 

Yes, your submission matches the intent from Thomas and I as I understand it.

> >>
> >> Is it indeed platform data? I would not create platform_data/x86
> >> without strong argument.
> >> Perhaps include/linux/clk/x86_pmc.h? (Yes, I know about clk-lpss.h
> >> which is old enough and was basically first try of clk stuff on x86)
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 

-- 
Darren Hart
Intel Open Source Technology Center
