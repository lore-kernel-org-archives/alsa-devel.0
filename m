From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] gpio: add GPIOF_ values regardless on
	kconfig settings
Date: Tue, 14 Jun 2011 17:03:21 -0700
Message-ID: <20110614170321.10e1caa7.randy.dunlap@oracle.com>
References: <4DDB3AFF.9030006@oracle.com>
	<20110524075248.GB19734@sirena.org.uk>
	<20110527074552.GA907@ponder.secretlab.ca>
	<4DDFE391.2030507@oracle.com>
	<20110527201201.GA6645@ponder.secretlab.ca>
	<BANLkTin-KSVcG2cQfRM3Ys0_g_uJVruDMw@mail.gmail.com>
	<20110603171837.GA9918@opensource.wolfsonmicro.com>
	<BANLkTi=oko_C8_46Y8p5O1Qvw1KEn-1PjA@mail.gmail.com>
	<4DEC4D67.6010506@oracle.com>
	<20110614091211.465553de.randy.dunlap@oracle.com>
	<20110614161357.GB1839@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rcsinet10.oracle.com (rcsinet10.oracle.com [148.87.113.121])
	by alsa0.perex.cz (Postfix) with ESMTP id 524542436B
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Jun 2011 02:03:40 +0200 (CEST)
In-Reply-To: <20110614161357.GB1839@ponder.secretlab.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, x86@kernel.org, Dmitry Artamonow <mad_soft@inbox.ru>, Mark Brown <broonie@opensource.wolfsonmicro.com>, LKML <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org, Harald Welte <laforge@gnufiish.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 14 Jun 2011 10:13:57 -0600 Grant Likely wrote:

> On Tue, Jun 14, 2011 at 09:12:11AM -0700, Randy Dunlap wrote:
> > On Sun, 05 Jun 2011 20:45:43 -0700 Randy Dunlap wrote:
> > 
> > > On 06/03/11 10:42, Grant Likely wrote:
> > > > On Fri, Jun 3, 2011 at 11:18 AM, Mark Brown
> > > > <broonie@opensource.wolfsonmicro.com> wrote:
> > > >> On Fri, Jun 03, 2011 at 11:04:52AM -0600, Grant Likely wrote:
> > > >>
> > > >>> I ended up not pushing this one to Linus.  Turns out it causes other
> > > >>> breakage on other platforms that don't include include/linux/gpio.h.
> > > >>> Since I don't have confidence that I'll be able to find all the
> > > >>> offenders, I'm dropping it.  I recommend making any drivers that are
> > > >>
> > > >> So, this originally came about because I pushed back on adding random
> > > >> dependencies like this for features which are pretty much optional in
> > > >> drivers - their use of GPIOs is totally optional and the dependencies
> > > >> are just too fragile, leading to noise with all the randconfigs.  It
> > > >> seems better to get the architectures to keep up with enhancements to
> > > >> gpiolib (or convert to it) than to have to worry about this in drivers.
> > > > 
> > > > Fair enough.  Randy, if you or someone else can check that all GPIOF_
> > > > users have the required #include <linux/gpio.h>, then I'm okay with
> > > > this patch.
> > > 
> > > OK, I'll look at that.
> > 
> > Of the 70 files that use GPIOF_ macros:
> > 
> > hdr missing in: ./arch/arm/mach-pxa/spitz_pm.c
> > hdr missing in: ./arch/avr32/mach-at32ap/pio.c
> > hdr missing in: ./arch/avr32/mach-at32ap/include/mach/portmux.h
> > hdr missing in: ./arch/avr32/boards/hammerhead/setup.c
> > hdr missing in: ./arch/avr32/boards/hammerhead/flash.c
> > hdr missing in: ./arch/avr32/boards/mimc200/setup.c
> > hdr missing in: ./arch/avr32/boards/atstk1000/setup.c
> > hdr missing in: ./drivers/pcmcia/pxa2xx_vpac270.c
> > 
> > 
> > > Do you have any examples of builds that failed with this patch?
> > 
> > and would you merge patch(es) that add this header file to those source
> > files?  If not, I'll need to make 3 separate patches for them.

That list of files above is incorrect.  Bad grep pattern.
Drop all of the avr32 files.  Ending patch is small -- sending it soon.

> Yes I would.  I'm fine with it all being one patch.


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
