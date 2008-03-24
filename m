From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: PXA2xx/3xx AC97 Driver(s)
Date: Mon, 24 Mar 2008 13:42:32 +0000
Message-ID: <20080324134231.GA30281@sirena.org.uk>
References: <47E7A0A8.3010200@oliford.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E1C5243BA
	for <alsa-devel@alsa-project.org>; Mon, 24 Mar 2008 14:42:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <47E7A0A8.3010200@oliford.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Oliver Ford <ipaqlinux@oliford.co.uk>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.arm.linux.org.uk, alex.meakins@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 24, 2008 at 12:38:00PM +0000, Oliver Ford wrote:

> Is there any work currently under way on an AC97 driver for the PXA3xx?

There is PXA3xx AC97 support present in the ASoC tree:

   git://opensource.wolfsonmicro.com/linux-2.6-asoc

It's under the asoc-v2-dev branch at the minute and is probably only
done for the ASoC AC97 driver, I'd need to check.  The main reason it's
only there is that it depends on the ARM architecture changes that you
identified (which are also applied on the asoc-v2-dev branch) and it
makes life easier to manage the cross-tree changes in only one tree.

All the ARM architecture changes have been submitted and marked as
applied in the patch system so should hopefully appear in Linus' kernel
early in the 2.6.26 cycle.  Once this has happened I will submit the
AC97 driver PXA3xx support.

> I want to get the touch screen working on my iPAQ 214, which uses the 
> PXA310. It's a WM97xx chip on the AC97 interface. I'm not really too 

I know that there are a number of users currently using the tree for
that use case so the asoc-v2-dev branch should hopefully work for you.
If you run into trouble please let me know.

> include/asm-arm/arch-pxa/pxa3xx-regs.h). Does the pxa310 require
> anything special like this or should just setting the cold-reset in
> the AC97 GCR work?

It also doesn't support the use of interrupts during reset operations,
requiring another special case, but I think that's about it.

> The Wolfson Microelectronics open-source page indicates that work is on 
> going with the 3xx driver but there doesn't seem to be anything more 
> than the pxa2xx driver in their source tree. Does anyone know how active 
> / close to producing anything this is?

Like I say, it's there.  The changes are fairly straightforward and
should be easy to backport to whatever kernel you need - if you need
help identifying what needs merging over please just ask.

> More generally, I'm a little confused as to why there is both the 
> standard (sound/arm/pxa2xx-ac97.c) and SoC (sound/soc/pxa/pxa2xx-ac97) 
> driver. Is one of these obsolete now or are they both still in 
> development? If guessing, I'd say the SoC driver is now the one to use 

The SoC driver is generally preferable, though it requires a bit more
work to use (since you have to write a platform driver to use it).  Both
are still maintained.  SoC offers better power management and support
for a wider range of board configurations, especially those that also
have non-AC97 interfaces (such as the I2S interface on the WM97xx
parts).

> but am not sure. Compiling either gives the warning "'pxa_set_cken' is 
> deprecated". I suspect calling this won't work for the pxa310 since it's 

This is also fixed in the patches currently queued in the ARM tree -
the drivers have been converted to use the clk_() API.

> clocks are different, but given that I'm booting linux from windows 
> (which will leave the clock on) and don't particularly care about 
> suspend/resume, should not being able to switch it off be a problem?

The cken calls should actually work fine.
