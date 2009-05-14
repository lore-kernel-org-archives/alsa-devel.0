From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Dynamically registering a codec
Date: Thu, 14 May 2009 18:40:32 +0100
Message-ID: <1242322832.31458.1911.camel@finisterre>
References: <9e4733910905131218t174b3b7cxc0e5c2fd5f5a0a06@mail.gmail.com>
	<20090513224424.GB24973@sirena.org.uk>
	<9e4733910905140844h1899bb60p19309953905b51d3@mail.gmail.com>
	<1242317750.31458.1782.camel@finisterre>
	<9e4733910905140943u7f8e5151tbaba86938bf9e77e@mail.gmail.com>
	(sfid-20090514_174327_208229_073CAA54)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C27332447F
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 19:40:33 +0200 (CEST)
In-Reply-To: <9e4733910905140943u7f8e5151tbaba86938bf9e77e@mail.gmail.com>
	(sfid-20090514_174327_208229_073CAA54)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2009-05-14 at 12:43 -0400, Jon Smirl wrote:
> > My main objection is to your abuse of platform devices here - there is
> > no need for this on non-PowerPC platforms and a platform device affects
> > everyone. So long as you come up with a solution that does not impact
> > other platforms I'm less worried.

> This is the part you don't like?
> +static void __init efika_declare_platform_devices(void)
> +{

That bit's OK - it's the device you've added for the CODEC which is
concerning me.

> on an Efika it can exit. There were multiple discussions about this on
> the ppc list. The conclusion was that the mess of wires on the
> mainboard implementing audio really was a platform device.

I agree, this is the most sensible way to handle machine drivers.

> There is a general kernel design problem in that there is no automated
> way to load something like an audio fabric driver. The Efika fabric
> driver is just example code, my Digispeaker hardware requires a board
> specific fabric driver since it has an external audio clock chip.
> Digispeaker drivers will come later after we decide on the final
> hardware design.

It's only really a problem on platforms using the device tree,
everything else can happily define random Linux-specific platform
devices in the board initialisation code and everything is happy.

> The problem with fabric drivers is that they are optional and ALSA
> drivers can load in any order. That requires a mechanism to say
> registration time is now closed, proceed without waiting for a fabric
> driver. The core could be changed to remove this requirement by
> imposing ordering constraints on driver registration.

Indeed - this is only a problem due to the fact that you're trying to
provide a generic machine driver.
