From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 3/8] mfd: arizona: Add support for WM8998 and WM1814
Date: Mon, 4 May 2015 10:11:19 +0100
Message-ID: <20150504091119.GA32076@opensource.wolfsonmicro.com>
References: <1430493319-23808-1-git-send-email-rf@opensource.wolfsonmicro.com> <1430493319-23808-4-git-send-email-rf@opensource.wolfsonmicro.com> <1430560731.2187.70.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430560731.2187.70.camel@x220>
Sender: linux-gpio-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: lee.jones@linaro.org, broonie@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, cw00.choi@samsung.com, myungjoo.ham@samsung.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Sat, May 02, 2015 at 11:58:51AM +0200, Paul Bolle wrote:
> Something I didn't notice when v2 came along.
> 
> On Fri, 2015-05-01 at 16:15 +0100, Richard Fitzgerald wrote:
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> 
> > +config MFD_WM8998
> > +	bool "Wolfson Microelectronics WM8998"
> > +	depends on MFD_ARIZONA
> > +	help
> > +	  Support for Wolfson Microelectronics WM8998 low power audio SoC
> > +
> >  config MFD_WM8400
> >  	bool "Wolfson Microelectronics WM8400"
> >  	select MFD_CORE
> 
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> 
> >  ifneq ($(CONFIG_MFD_WM8997),n)
> >  obj-$(CONFIG_MFD_ARIZONA)	+= wm8997-tables.o
> >  endif
> > +ifneq ($(CONFIG_MFD_WM8998),n)
> > +obj-$(CONFIG_MFD_ARIZONA)	+= wm8998-tables.o
> > +endif
> 
> Playing a bit with the current version of drivers/mfd/Makefile it seems
> these
>     ifneq ($(CONFIG_MFD_WM[...]),n)
> 
> tests will always be true. Because, as far as I know, the Kconfig macros
> used in those tests will either be "y" or the empty string, but never
> "n". (I don't speak Makefilese fluent enough to know how to add simple
> debugging prints for the values of the CONFIG_MFD_WM[...] macros to
> actually test this, so correct me if I'm wrong here.)

Yes, I've noticed that these tests are wrong and I'm working on a patch for
it. It's another one of those cases where more lines needs patching to fix
it than the 3 lines this WM8998 patch adds, and also fixing it potentially
breaks the build because of dependencies that were accidentally working
because they never got compiled out. So I'd prefer not to half-fix it in
these WM8998 patches it's better to let the code settle and then fix it properly.

> 
> So I think that, effectively, these wm[...]-tables.o objects will always
> be built if CONFIG_MFD_ARIZONA is set. Is that the intention? If not,
> perhaps these test should read
>     ifeq ($(CONFIG_MFD_WM[...]),y)
> 
> Thanks,
> 
> 
> Paul Bolle
> 
