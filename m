From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v6 1/3] clk: x86: Add Atom PMC platform clocks
Date: Fri, 16 Dec 2016 14:58:19 -0800
Message-ID: <20161216225819.GA62123@f23x64.localdomain>
References: <1481306510-7471-1-git-send-email-irina.tirdea@intel.com>
 <1481306510-7471-2-git-send-email-irina.tirdea@intel.com>
 <CAHp75Vdaw4yvTPP2JZc+ti-AVNsisRQ+WG=JxPQ1jv-r7DADQA@mail.gmail.com>
 <1a98dcda-a662-958e-307f-5fe3f281ed9f@linux.intel.com>
 <CAHp75VccDyiLhWxZYg+d0usrwhfa_hiZAJCKPXXVRod=tB803g@mail.gmail.com>
 <20161216183607.GB44199@f23x64.localdomain>
 <CAHp75Ve-3WXr05uvPQDfFDzxLc09+1ZSYpsuw02ab+x0enJtQg@mail.gmail.com>
 <20161216191951.GC44199@f23x64.localdomain>
 <CAHp75Vc8q_WuFURhG_z5zj9VztS-d8_RiSHQYgh-HFTjzP0MEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Vc8q_WuFURhG_z5zj9VztS-d8_RiSHQYgh-HFTjzP0MEQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Irina Tirdea <irina.tirdea@intel.com>, linux-clk@vger.kernel.org, "x86@kernel.org" <x86@kernel.org>, platform-driver-x86@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Dec 17, 2016 at 12:29:41AM +0200, Andy Shevchenko wrote:
> On Fri, Dec 16, 2016 at 9:19 PM, Darren Hart <dvhart@infradead.org> wrote:
> > On Fri, Dec 16, 2016 at 08:49:13PM +0200, Andy Shevchenko wrote:
> >> On Fri, Dec 16, 2016 at 8:36 PM, Darren Hart <dvhart@infradead.org> wrote:
> >> > On Tue, Dec 13, 2016 at 02:26:21AM +0200, Andy Shevchenko wrote:
> >> >> On Tue, Dec 13, 2016 at 2:15 AM, Pierre-Louis Bossart
> 
> >> > There should really be some Documentation about how to choose an include
> >> > directory :-)
> >>
> >> So true!
> 
> (1)
> 
> > The options are:
> >
> > a) include/linux/x86
> > b) include/linux/platform_data/x86
> 
> Correct.
> 
> > In my opinion, a) looks like architecture and would be difficult to distinguish
> > from arch/x86/include. b) on the other hand clearly notes that it is for
> > platform specific information. If it was platform instead of platform_data, that
> > would be even better, but that could be a later change. But I think the
> > confusion over x86 arch in a) is worse than the more subtle (in my opinion)
> > distinction between "platform" and "platform_data".
> >
> > I would want x86 maintainer approval before adding a), while b) I'm happy to add
> > ourselves - and we already have agreement from tglx on that.
> >
> > To move forward, let's go with b).
> 
> Let me say I'm not fully satisfied, though for sake of moving forward
> I agree with these arguments.
> 
> > The new x86 directory clearly separates out
> > content which will make it trivial to move later if the need arises.
> 
> See (1). I would really appreciate if some agreement and documentation
> will be developed.
> In that case one of us would really have one serious argument to one
> of the sides.

Agreed. I always prefer to make decisions based on Documented precedent whenever
possible.

-- 
Darren Hart
Intel Open Source Technology Center
