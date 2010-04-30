From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: asoc: problem with snd_soc_dai_set_fmt()
Date: Fri, 30 Apr 2010 11:37:48 +0100
Message-ID: <20100430103748.GD28241@rakim.wolfsonmicro.main>
References: <4BD9F889.4010106@freescale.com>
	<20100429221808.GB23958@opensource.wolfsonmicro.com>
	<s2oed82fe3e1004291630k697318f9od19ceca1011540fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A809224437
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 12:37:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s2oed82fe3e1004291630k697318f9od19ceca1011540fa@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 29, 2010 at 06:30:19PM -0500, Timur Tabi wrote:
> On Thu, Apr 29, 2010 at 5:18 PM, Mark Brown
> > On Thu, Apr 29, 2010 at 04:22:17PM -0500, Timur Tabi wrote:

> >> that if the fabric driver does this:

> > *machine*

> Grr... I've been calling it the fabric driver for a long time, and I
> know I didn't make up that term.

You may have missed some of my more subtle hints previously :)

> > Right, but really this is the case - the driver has completely ignored
> > what the machine driver was trying to do.

> But there are several functions like that, such as the _pll function.
> What if the CPU driver really doesn't care what the frequency is or
> the PLL or whatever?  Do I need to define stub functions for all of
> these?

The driver should expose whatever functionality the hardware has.  If
your CPU driver doesn't have any PLLs/FLLs that can be usefully
configured by the user using set_pll() then it shouldn't implement a
set_pll() function.  If it does have such hardware then it should
implement set_pll() so users can configure them, unless it's always
possible for the driver to do the configuration autonomously for all
situations in which case it should just do that.

> > =A0It may be that the default
> > behaviour is what was asked for, but it may also be that you've asked
> > for I2S format and got DSP format or something similiarly incompatible.

> But if the CPU driver does not define a function to check for that,
> isn't that the same thing as saying, "I really don't care -- I'll
> support whatever you want"?

Not at all.  It'll mean that either the device is fixed function or
configurability has not yet been implemented.  The set_fmt() call is how
the driver finds out what the bus is doing (and many of the formats are
indistinguishable from each other without semantic information so
looking at the wire isn't going to help).

> > Due to the above issue I don't think this is a good idea - we really
> > ought to let the machine driver know if the request it made was ignored
> > in case it is trying to set up something that can't be supported.

> IMHO, ignored !=3D not supported.

No, it really does mean that it's ignoring what it's being told to do.

It may be that the configuration that was requested just happens to be
what the hardware is set up to do but there's no way for the core to
tell that, all it knows is that it didn't have a mechanism to pass on
the configuration to the driver.

> For instance, it's possible for a CPU driver initially to support only
> some configurations, so the set_fmt function would be necessary.
> Later, the CPU driver could be updated to support all possible
> configurations, and it could know that via some other mechanism (like
> the device tree), and so it would be redundant if it let the machine
> driver know what that configuration is.

If the machine driver is relying on the configuration having been done
by some other part of the system then it shouldn't be trying to
explicitly set the format in the first place.  If it doesn't care if the
configuration it requested was actually implemented then it should just
ignore the return value.

> This is what I'm doing to my SSI driver.  Now that it probes the SSI
> nodes directly, it doesn't need the machine driver to tell it what the
> capabilities are.

Well, if your machine driver knows that the device tree will configure
everything it needs then it shouldn't be trying to set the format in the
first place, just as if it knows that the hardware is fixed function.
In your case presumably the machine driver is finding the configuration
it is trying to apply from the device tree so you should just make it
handle missing information.

> > The current expectation is that the machine driver knows what the
> > hardware is capable of

> But not necessarily at compile time!  I was hoping to use this as a
> mechanism for determining the capabilities at run time.

As I said in my previous message if you want to query the capabilities
of the CODEC you'd need to add a method for the CODEC to report
capabilities.

As has been repeatedly discussed there is a strong expectation that the
machine driver knows the details of the hardware it's gluing together
since this is the basic function of the driver.  Your desire to write a
generic machine driver which will work with a very wide range of boards
is not something that the existing code makes any effort to support.
