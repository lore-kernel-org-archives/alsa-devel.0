From: Michael Zoran <mzoran-O+n0w2l5AFbk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 3/4] sound: arm: Add build system for
 bcm2835-analog-audio driver.
Date: Tue, 14 Mar 2017 02:53:59 -0700
Message-ID: <1489485239.656.7.camel@crowfest.net>
References: <201703141503.gyuLu0Kr%fengguang.wu@intel.com>
         <1489481899.656.5.camel@crowfest.net>
         <5a437138-bf9c-1e48-9fa6-82fac9b6e54c@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5a437138-bf9c-1e48-9fa6-82fac9b6e54c-eS4NqCHxEME@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2017-03-14 at 10:13 +0100, Stefan Wahren wrote:
> Am 14.03.2017 um 09:58 schrieb Michael Zoran:
> > On Tue, 2017-03-14 at 15:15 +0800, kbuild test robot wrote:
> > > Hi Michael,
> > > 
> > > [auto build test ERROR on sound/for-next]
> > > [also build test ERROR on v4.11-rc2 next-20170310]
> > > [if your patch is applied to the wrong git tree, please drop us a
> > > note to help improve the system]
> > > 
> > > url:    https://github.com/0day-ci/linux/commits/Michael-Zoran/dt
> > > -bin
> > > dings-Document-the-dmas-and-dma-names-properties-for-bcm2835-
> > > analog-
> > > audio/20170314-091035
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sou
> > > nd.g
> > > it for-next
> > > config: arm64-allmodconfig (attached as .config)
> > > compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> > > reproduce:
> > >         wget https://raw.githubusercontent.com/01org/lkp-tests/ma
> > > ster
> > > /sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # save the attached .config to linux build tree
> > >         make.cross ARCH=arm64 
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > >    /tmp/ccNU8kQ5.s: Assembler messages:
> > > > > /tmp/ccNU8kQ5.s:1411: Error: unknown mnemonic `ldmia' --
> > > > > `ldmia
> > > > > x26,{r0,r1,r2,r3}'
> > > > > /tmp/ccNU8kQ5.s:1412: Error: unknown mnemonic `stmia' --
> > > > > `stmia
> > > > > x19!,{r0,r1,r2,r3}'
> > > > > /tmp/ccNU8kQ5.s:1618: Error: unknown mnemonic `ldmia' --
> > > > > `ldmia
> > > > > x19!,{r0,r1,r2,r3}'
> > > > > /tmp/ccNU8kQ5.s:1619: Error: unknown mnemonic `stmia' --
> > > > > `stmia
> > > > > x26,{r0,r1,r2,r3}'
> > > 
> > > ---
> > > 0-DAY kernel test infrastructure                Open Source
> > > Technology Center
> > > https://lists.01.org/pipermail/kbuild-all                   Intel
> > > Corporation
> > 
> > I'm a bit confused here.  Why I'm I seeing assembly instruction
> > build
> > errors when the mail points to a DT binding document change?
> > 
> > 
> 
> The email subject doesn't refer to a DT binding.
> 
> I assume it's your change to enable ARM64 for all SND_ARM drivers,
> which
> aren't aware of that.

OK, that makes sense now.  Should I just submit another change adding a
depends on ARM to the 1 or 2 other drivers in the directory?


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
