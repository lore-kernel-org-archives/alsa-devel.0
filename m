From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: integration into ASoC
Date: Mon, 10 Mar 2014 17:43:07 +0100
Message-ID: <20140310164307.GH2815@lukather>
References: <20140307165335.GT607@lukather> <5319FE01.3070909@metafoo.de>
 <20140310095039.GC2815@lukather> <531D90C1.8000800@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5633550366151483038=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (top.free-electrons.com [176.31.233.9])
 by alsa0.perex.cz (Postfix) with ESMTP id DBE04265776
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 17:45:03 +0100 (CET)
In-Reply-To: <531D90C1.8000800@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, zhuzhenhua@allwinnertech.com, Mark Brown <broonie@kernel.org>, kevin.z.m.zh@gmail.com, sunny@allwinnertech.com, shuge@allwinnertech.com
List-Id: alsa-devel@alsa-project.org


--===============5633550366151483038==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LiQwW4YX+w4axhAx"
Content-Disposition: inline


--LiQwW4YX+w4axhAx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2014 at 11:15:29AM +0100, Lars-Peter Clausen wrote:
> >>>This IP is made of a few registers to control the sampling rate, if
> >>>we're using mono/stereo, plus two fifos, one for playback, one for
> >>>capture, that can be seed with data. The data are then taken, go
> >>>through a DAC, and the outer interface of the IP are directly analog
> >>>signals (so the DAC/ADC are directly in the SoC, and the only
> >>>interface we have is plain registers).
> >>>
> >>> From what I understood from ASoC, you have mostly three components,
> >>>the DAI, the codec and the platform that plumbers the two first
> >>>together. Here, my understanding is that it's pretty much the whole
> >>>three in a single IP.
> >>
> >>The platform component usually takes care of transferring data from
> >>memory to your IP. It sounds as if this is still separate on your
> >>platform. Quite possibly you can use the generic dmaengine PCM
> >>driver.
> >
> >You really have two intertwined sets of registers, one for the FIFO
> >themselves (and you will obviously use DMA for that, I'll keep in mind
> >the dmaengine PCM driver), and the control registers, so you can't
> >really split it into two separate drivers (at least, not easily).
>=20
> You'd configure the FIFOs from the CPU component driver, but the
> part that takes care of moving the audio data around is a separate
> component.

Ok.

> >
> >>Right now ASoC expects you to specify a DAI link for a PCM
> >>device. The DAI link connects the DAIs of two components typically
> >>the SoC side and a external CODEC. In your case you do not have the
> >>external CODEC. You can solve this by using a dummy CODEC or
> >>splitting things up and register both the CODEC and the CPU DAI from
> >>the same driver.
> >
> >That would probably be the best solution, yes.
> >
> >>But I'm currently working on a patchset that will eventually allow
> >>these kind of devices to be supported more naturally. It will allow
> >>to register them as one component that won't need the CODEC
> >>component to work.
> >
> >Great! Do you have a branch with that work somewhere?
>=20
> Not yet. But I hope to get there in the next weeks.

Could you put me in Cc whenever you post them for feedback/testing?


> >>>Should such a hardware block be handled into ASoC, and if yes, how?
> >>>If not, which other framework should be used?
> >>
> >>It makes sense to use ASoC if there are components where the driver
> >>can be shared e.g. the DMA in your case. Otherwise you can also use
> >>plain old ALSA.
> >
> >The DMA controller this IP will use is a system-wide DMA master, so
> >I don't think this driver will provide something to other drivers.
>=20
> That's what I meant. The DMA controller is not integrated into the
> sound core, so you'll have a dmaengine driver for the DMA controller
> and the part that can be shared with other drivers is the code that
> handles setting up the DMA transfers etc.

Ok. Thanks!

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--LiQwW4YX+w4axhAx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTHeubAAoJEBx+YmzsjxAgU3wP/jKQH4JhoEN4kjvz3PjahUAU
KntFOLPVxxLYaULWqnzSZ8g+Yx1rrqJrkVT+F4zv0WBZNBhBY0qG6i5ldwGHXB3u
3gYD8127bJ8KPns0Nn2T6EqGzBqt0jO5Eik8o7rbB5QX811BGU8882d28w7PMxqL
pv2Jsm+ZDEOrcikoIHkXu3+aRBwSdEzVrHCVbK5yqPxgc2DwswtRuVACtZr/fqQW
0EWXw6zm5G/B/oNSH3x7GEPyTxoki/euwNS1PHqkB6IoK/u8svtYqUlHWShFMfCB
h7En0h/0nl4tWT1+rsRsFlEudlWyI9qsXm75dTlYmbLLtvFcHb4VY5yVlqoXMuVg
3sJRFRigHiaUWeu8eofnDDum8fR3o8WywCP+QhWpEJZXMnTwN07rCHUtYFmsjj8b
N2CTrxYkbCPRGGP4MKJqP5FQpXIWgrewPBhFF+f/iE8e0vs0YKYxQKb2QKznM1uJ
iolqV3zi9yMqdEJdXG/Gj9e1tJ287NzDVGgVcTwhnASDUWbONePta68qkQ2fKplM
znyPdrrDGUidXwcbgHmxF9XsIW3C1kZ8Q7uPhWi0PxjJfkWvJ5LFbnZtJoN57vG0
/tkgo3a74oCmZYLn0g1BfvW1aHuTAztCRrHZf3NS10RZ+CMANgC4Bcr7KJG1wgOV
96EJteNCB3T8MKh03A8t
=8Y0o
-----END PGP SIGNATURE-----

--LiQwW4YX+w4axhAx--

--===============5633550366151483038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5633550366151483038==--
