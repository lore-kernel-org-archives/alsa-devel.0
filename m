From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC audio fabric OF bindings RFC. was: Re: ASoC
 MPC5xxx PSC AC97 audio driver
Date: Mon, 12 Sep 2011 12:09:50 +0100
Message-ID: <20110912110950.GD2953@opensource.wolfsonmicro.com>
References: <20110908121600.267dee07@archvile>
	<CAKON4OzsMd0T6KyDK_5P_pz8R5Pax+Bd+f5+00cO5E0OMCYQpQ@mail.gmail.com>
	<20110908124529.520c1388@archvile>
	<CAKON4OwvYy6Dy-MfHT90syPyAUcTVRXqXca-qAVjk-KWkak53A@mail.gmail.com>
	<20110908163231.4b721973@archvile> <20110908184441.GD16989@siel.b>
	<20110909082844.3dbf0e72@archvile>
	<20110909120216.263eeb54@archvile>
	<20110909163714.GA4302@sirena.org.uk>
	<20110912083158.29d9e1fe@archvile>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 618A21039C1
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Sep 2011 13:09:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110912083158.29d9e1fe@archvile>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Jander <david.jander@protonic.nl>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, lrg@ti.com, devicetree-discuss@lists.ozlabs.org, torbenh <torbenh@gmx.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 12, 2011 at 08:31:58AM +0200, David Jander wrote:
> Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > This isn't really something that should go into device tree, ALSA is a
> > Linux specific concept.

> There are many Linux-specific details in Linux's implementation of Open
> Firmware Device Trees. Right now, thanks to Linux, Open-Firmware device trees

This is generally considered a bug in the bindings, the bindings are for
cross-platform usage and should not be specific to any OS.

> introduced in arch/arm right now. On all these platforms, its sole existence
> is purely for running Linux with minimal board support code in the kernel.

Other OSs are actively using device tree.

> So, why not add a few more Linux-specific bits to it, if it helps get rid of
> the last bit of board-specific code?

Eliminating board specific code for audio is not a realistic goal, the
configuration of modern audio subsystems is too complex and dynamic.  It
is realistic to make machine drivers which cover broad classes of
devices with similar hardware.

> The platforms that will use those bindings, will never have
> Open-Firmware bioses in the first place, and their DT sources will be part of
> the kernel source tree anyway.

The plan is to push the device trees out of the kernel into a separate
repository.

> > What we should really be doing here is to autodiscover by reading the ID
> > registers in the device.  That needs generic AC'97 bus work which we
> > don't have right now.

> Seems reasonable, but is correct autodiscovery really possible for all
> configurations and all DAI-codec combinations?

Yes, it's a very basic part of AC'97.
