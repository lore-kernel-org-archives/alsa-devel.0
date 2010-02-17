From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Separate dma driver for cpu_dais
Date: Wed, 17 Feb 2010 13:14:22 +0000
Message-ID: <20100217131421.GB11510@rakim.wolfsonmicro.main>
References: <1b68c6791002161839q705df04cmeda046736948c614@mail.gmail.com>
	<4B7B9387.1070506@samsung.com>
	<20100217105202.GB31765@sirena.org.uk>
	<1b68c6791002170415q457d0893jb1a77b864031ee6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3D6D0103894
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 14:14:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6791002170415q457d0893jb1a77b864031ee6c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: kyungmin.park@samsung.com, alsa-devel@alsa-project.org, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 17, 2010 at 09:15:56PM +0900, jassi brar wrote:
> On Wed, Feb 17, 2010 at 7:52 PM, Mark Brown

> > What modifications are you looking for here? =A0ASoC doesn't make any
> > effort to avoid reuse of DAIs in multiple links - it doesn't actively do
> > anything to help here but equally well it's not supposed to get in the
> > way.

> The workaround to enable a cpu_dai to be used in multiple dai_links isn't

What workaround?

> going to work as such because of cpu_dai->runtime =3D runtime done
> in soc_pcm_open.
> Luckily for codec_dai, we can use the same in more than one dai_link.

Right, OK - CPU DAIs don't come up so much so I've not noticed that.

> > The only thing I can think of off the top of my head that would cause
> > actual problems is that the DAPM events for stream stop/start in the
> > CODEC might not be doing reference counting, I'd need to check. =A0Other
> > than that there's a bunch of things that could make use cases like this
> > nicer like providing a way of bundling links that share signals together
> > and providing callbacks when things start and stop (so shared clocking
> > can be turned on and off, for example) but these should be things that
> > could be open coded in individual drivers.

> Also, how cleanly could we avoid startup/shutdown/mute etc callbacks
> when a codec_dai is used in multiple dai_links, is to be seen.

The mute is just part of the reference counting I was mentioning, that's
fairly straightforward to resolve I'd expect.

Startup and shutdown will just work for a lot of drivers, either through
not having relevant callbacks in the first place or winding up being a
noop due to rewriting an identical configuration - as a first
approximation we can probably get away with open coding in any drivers
that do have a problem.
