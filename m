From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Jack event API - decision needed
Date: Wed, 29 Jun 2011 10:00:24 -0700
Message-ID: <20110629170023.GA10798@opensource.wolfsonmicro.com>
References: <4DFF4D15.6050809@canonical.com>
	<20110627120743.GA20707@sirena.org.uk>
	<4E0A00E3.5000102@canonical.com> <s5hr56dykve.wl%tiwai@suse.de>
	<4E0AD0A6.7010901@canonical.com>
	<20110629072011.GB25977@opensource.wolfsonmicro.com>
	<4E0AE7BD.4080801@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7543310390F
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jun 2011 19:00:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E0AE7BD.4080801@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kay Sievers <kay.sievers@vrfy.org>, Lennart Poettering <lennart@poettering.net>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 29, 2011 at 09:52:13AM +0100, David Henningsson wrote:
> On 2011-06-29 08:21, Mark Brown wrote:

> >>However, if we manage to expose all the routing between PCMs, volume
> >>controls and ports, we can make an even better PulseAudio, because
> >>we can solve other problems as well, such as the volume control
> >>naming problem. But figuring out how to do that in the best way
> >>API-wise and so on, I guess that will take some time.

> >This is really a totally separate question,

> The question is not totally separate as if we design an ALSA API, we
> might have this in the back of our minds in order to not build an
> API when adding this information later will be very difficult.

I think if we make that difficult we've messed up massively anyway.

> >there's so much routing
> >within the devices that the jacks are just not a particularly
> >interesting part of it.

> I'm probably misunderstanding you here, because that sounds crazy.
> What sense would it make to display a routing graph if the jacks are
> not part of that graph?

I said they weren't an interesting part of it, not that they're not part
of it.  It's a very small detail relative to all the other stuff we need
to worry about.

> >My main concern is being able to group the objects back
> >together again for use both in kernel (when the hardware overlaps) and
> >in userspace in an understandable fashion and I've not seen anything
> >that I'm as comfortable with as a directly visible object exported from
> >the kernel.

> I'm not following. For userspace, you need to match the input layer
> against an ALSA sound card. You need to do that regardless of
> whether the buttons and the jacks are in the input layer, or if only
> the buttons are there. No difference in difficulty as I see it.

As repeatedly discussed we need to do at least a three way match -
currently we need to also glue both input and audio to graphics as well.
It seems likely we'll end up with other things on there too.

> For the kernel part, I guess that if ASoC core (or ALSA core) is
> responsible for the splitting, and that the actual driver has an
> object covering both types of input (i e both jacks and buttons),
> that would be the most obvious way to solve the problem.

The multiple subsystems thing also applies here - you really can't rely
on doing this all in one driver.

> >I do have to say I like not having to use alsa-lib to get the
> >information but that's even less of a big deal.

> Ok, is that because Android does not use alsa-lib?

No, it's because it's a pretty big library with it's own programming
interface that's more complicated than your standard poll and read so
it's not quite so natural to integrate into your system management
daemon (that looks after the system as a whole) as it could be.
