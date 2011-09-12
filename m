From: David Jander <david.jander@protonic.nl>
Subject: Re: ASoC audio fabric OF bindings RFC. was: Re: ASoC
 MPC5xxx PSC AC97 audio driver
Date: Mon, 12 Sep 2011 08:31:58 +0200
Message-ID: <20110912083158.29d9e1fe@archvile>
References: <20110908121600.267dee07@archvile>
	<CAKON4OzsMd0T6KyDK_5P_pz8R5Pax+Bd+f5+00cO5E0OMCYQpQ@mail.gmail.com>
	<20110908124529.520c1388@archvile>
	<CAKON4OwvYy6Dy-MfHT90syPyAUcTVRXqXca-qAVjk-KWkak53A@mail.gmail.com>
	<20110908163231.4b721973@archvile> <20110908184441.GD16989@siel.b>
	<20110909082844.3dbf0e72@archvile>
	<20110909120216.263eeb54@archvile>
	<20110909163714.GA4302@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from protonic.xs4all.nl (protonic.xs4all.nl [213.84.116.84])
	by alsa0.perex.cz (Postfix) with ESMTP id 2198F2437A
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Sep 2011 08:31:48 +0200 (CEST)
In-Reply-To: <20110909163714.GA4302@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, lrg@ti.com, devicetree-discuss@lists.ozlabs.org, torbenh <torbenh@gmx.de>
List-Id: alsa-devel@alsa-project.org

On Fri, 9 Sep 2011 17:37:14 +0100
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Fri, Sep 09, 2011 at 12:02:16PM +0200, David Jander wrote:
> 
> > Ok, I actually spent a while thinking about this. What about the following
> > idea:
> 
> *Always* CC maintainers.

Sorry ;-)

> > 1: By adding compatible = "alsa,cpu-dai", this DAI is marked for binding.
> 
> This isn't really something that should go into device tree, ALSA is a
> Linux specific concept.

There are many Linux-specific details in Linux's implementation of Open
Firmware Device Trees. Right now, thanks to Linux, Open-Firmware device trees
are used for much more hardware platforms than just Oracle hardware that
probably isn't manufactured anymore and IBM Power servers. For embedded
systems for example, DT's have been used on all PowerPC platforms and is being
introduced in arch/arm right now. On all these platforms, its sole existence
is purely for running Linux with minimal board support code in the kernel.
So, why not add a few more Linux-specific bits to it, if it helps get rid of
the last bit of board-specific code?
The platforms that will use those bindings, will never have
Open-Firmware bioses in the first place, and their DT sources will be part of
the kernel source tree anyway.

> > 3: Many ac97 codecs are compatible with the generic codec driver
> > "ac97-codec".
> 
> All should be.  The only reason for specific drivers is to enable
> additional non-standard functionality.

I was being careful.

> > 4: Don't know if this is the right way to work the codec DAI name in. See
> > the next note:
> 
> What we should really be doing here is to autodiscover by reading the ID
> registers in the device.  That needs generic AC'97 bus work which we
> don't have right now.

Seems reasonable, but is correct autodiscovery really possible for all
configurations and all DAI-codec combinations?

Best regards,

-- 
David Jander
Protonic Holland.
