From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] ASoC: codecs: add support for
 TAS5720 digital amplifier
Date: Wed, 30 Mar 2016 08:38:53 -0700
Message-ID: <20160330153853.GW2350@sirena.org.uk>
References: <1458580107-4632-1-git-send-email-dannenberg@ti.com>
 <1458580107-4632-3-git-send-email-dannenberg@ti.com>
 <20160328190143.GC2350@sirena.org.uk>
 <20160330025318.GB2073@borg.dal.design.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8768354843492315371=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B45C626066B
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2016 17:39:18 +0200 (CEST)
In-Reply-To: <20160330025318.GB2073@borg.dal.design.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


--===============8768354843492315371==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1hAU+gb7eAuiw2fm"
Content-Disposition: inline


--1hAU+gb7eAuiw2fm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 29, 2016 at 09:53:18PM -0500, Andreas Dannenberg wrote:
> On Mon, Mar 28, 2016 at 08:01:43PM +0100, Mark Brown wrote:
> > On Mon, Mar 21, 2016 at 12:08:27PM -0500, Andreas Dannenberg wrote:

> > Remove empty funnctions, -ENOTSUPP is expected behaviour for anything
> > that isn't explicitly supported by a driver.

> Ok will double-check. Very early during my driver development I was not
> able to play audio through aplay if this function was not provided. I
> don't recall what specific Kernel version that was but it may have been
> something like 4.1.

This would be a bug in your machine driver then.

> As explained in the code comment even with a boiled-down test code that
> has an empty threaded handler the system would come to a grinding halt
> when bombarded with interrupts every 300us which I found odd but not
> completely unexpected (from my MCU background POV that is). And while
> digging I had seen that the interrupts do get disabled just like you
> mention during threaded handling to operate in a more graceful manner.
> But I wasn't sure at this point if the additional (high priority, I
> suppose) overhead of creating/starting the thread (even an empty one)
> every 300us was just too much for my poor single-core SoC to handle so
> my assumption was that it never got cycles to process stuff other than
> interrupts, and disabling interrupts in the low-level handler fixed just
> that. But I'm going to spend some extra cycles trying to re-digest the
> realtime behavior of my particular SoC/setup to understand why exactly
> this is happening.

If your device is constantly retriggering the same interrupt that
suggests there is a problem with how you are handling your device,
perhaps you need to disable the interrupts at source if it's truly
broken beyond repair.

> > Oh, we're using _PRE() and _POST() events...  this almost certainly
> > indicates a problem, there are very few circumstances where these are a
> > good idea and I'm not seeing anything in this driver which indicates
> > that this is going on.  Please just use normal DAPM widgets (I'm
> > guessing a PGA) to represent the device and work within DAPM, don't
> > shoehorn some bodge around the side.

> I'm currently using these handlers to essentially tame the TAS5720 error
> reporting. Only when the device is in shutdown mode it will seize
> bombarding the host with 300us-spaced FAULT interrupts (that will come
> as soon as the SAIF stream stops).  Unfortunately that's the way the
> TAS5720 was designed and I've already provided feedback internally that
> this makes an elegant / low-overhead SW implementation quite
> challenging. Anyways I did see several places where this shutdown mode
> handling could get added so I simply picked the one that was not directly
> associated with the audio stream itself to make it more explicit what
> this is about but this can certainly be changed.

It sounds like this feature is unusably broken...  possibly you could do
something in the mute handler but it seems that anything you try to do
to use this feature is going to be both fragile and disruptive to the
system.  What is the value in implementing it?

--1hAU+gb7eAuiw2fm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW+/MMAAoJECTWi3JdVIfQZbcH/20Lx1LBKZrVaftP6bVLusQX
VfFd9y19rk+a1HUna3HioDt/jqQ2s6hRArFT8Hgst94+gplQJZ+Cd/Y4C7uMKcw7
WDu2yPZ8JPladmHuNUmKWoPuuloBGRMQEwZCvm+/QW3IBv1i8R/NU4yAifYn0D8S
E3vFai5usYyzRn1kTPc15I7JkCpHrLJrc9MQo0EFY0zCRf/w3IYZS6IuRgr5mDOy
NBSX1sJzIu0fgIBdFyIRslr2j+ByK9LyurT5nRrtSBdK2iPlM4TSkJ0i06WHfKQy
4HJg+vYxTkuair9rJuBZ0Aaz+OJE+EGsXfXWEqmN6RDj34ioJhpb5DzmTlUzKlc=
=sRMq
-----END PGP SIGNATURE-----

--1hAU+gb7eAuiw2fm--

--===============8768354843492315371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8768354843492315371==--
