From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: integration into ASoC
Date: Mon, 10 Mar 2014 10:50:39 +0100
Message-ID: <20140310095039.GC2815@lukather>
References: <20140307165335.GT607@lukather>
 <5319FE01.3070909@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3867492280785083395=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (top.free-electrons.com [176.31.233.9])
 by alsa0.perex.cz (Postfix) with ESMTP id C77462656B9
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 10:55:19 +0100 (CET)
In-Reply-To: <5319FE01.3070909@metafoo.de>
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


--===============3867492280785083395==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
Content-Disposition: inline


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lars,

On Fri, Mar 07, 2014 at 06:12:33PM +0100, Lars-Peter Clausen wrote:
> On 03/07/2014 05:53 PM, Maxime Ripard wrote:
> >Hi Liam, Mark,
> >
> >I have a sound IP that is part of an SoC that I'm willing to write a
> >driver for.
>=20
> Which SoC is this?

Allwinner A31.

Unfortunately, the datasheet for this SoC is not public, but most of
the other Allwinner SoCs have an IP that behaves pretty much in the
same way.

You can find a datasheet for the A20 here:
http://dl.linux-sunxi.org/A20/A20%20User%20Manual%202013-03-22.pdf,
starting page 172.

The A31 has a slightly different IP, but from an architectural
standpoint, it's pretty much the same thing.

> >This IP is made of a few registers to control the sampling rate, if
> >we're using mono/stereo, plus two fifos, one for playback, one for
> >capture, that can be seed with data. The data are then taken, go
> >through a DAC, and the outer interface of the IP are directly analog
> >signals (so the DAC/ADC are directly in the SoC, and the only
> >interface we have is plain registers).
> >
> > From what I understood from ASoC, you have mostly three components,
> >the DAI, the codec and the platform that plumbers the two first
> >together. Here, my understanding is that it's pretty much the whole
> >three in a single IP.
>=20
> The platform component usually takes care of transferring data from
> memory to your IP. It sounds as if this is still separate on your
> platform. Quite possibly you can use the generic dmaengine PCM
> driver.

You really have two intertwined sets of registers, one for the FIFO
themselves (and you will obviously use DMA for that, I'll keep in mind
the dmaengine PCM driver), and the control registers, so you can't
really split it into two separate drivers (at least, not easily).

> Right now ASoC expects you to specify a DAI link for a PCM
> device. The DAI link connects the DAIs of two components typically
> the SoC side and a external CODEC. In your case you do not have the
> external CODEC. You can solve this by using a dummy CODEC or
> splitting things up and register both the CODEC and the CPU DAI from
> the same driver.

That would probably be the best solution, yes.

> But I'm currently working on a patchset that will eventually allow
> these kind of devices to be supported more naturally. It will allow
> to register them as one component that won't need the CODEC
> component to work.

Great! Do you have a branch with that work somewhere?

> >Should such a hardware block be handled into ASoC, and if yes, how?
> >If not, which other framework should be used?
>=20
> It makes sense to use ASoC if there are components where the driver
> can be shared e.g. the DMA in your case. Otherwise you can also use
> plain old ALSA.

The DMA controller this IP will use is a system-wide DMA master, so
I don't think this driver will provide something to other drivers.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTHYruAAoJEBx+YmzsjxAgqKUQALDxmfHxwGWk2CE5+wRwZ5K2
+IxumsVno/DKT0LcuOL9dpwfNY29LikxQjMQQZTWGBVN1y79iNT4GTzSo//RLAFb
/A3Tkh1wh0ao6iV8PC9JA45enyd42fqXP4Yd5Tr71yj53M8gKzH7xGa6IqYGjyQk
aESY2T8hWicHxrVcDcusE7KVIg3Cy9gL1t7fiyVkPUiZGPsMcBBg6bKjtlsibCah
wXFOP9vNpRCwfDcLbRVvQKiRmzl74RMlYukEDM4iy+ZN5y+0G8xM959csaNZT67I
QRPzgg/IcrXkGRLglt6Qjgs/ikBy92E7uU+uFUvK3K7n/4YsIfWOuyO8orelrm3K
qWfCbYjwuDmtjhBMEZAhZs+/ub7XgpTfibEqnFwh3Nu1AT95HKlyDjbtQ5ZSSEAf
Ax1Kbn2zZl9gLfPDLrIZBBTu+yTEdmtFKS1cN5iNmpHT791WWVslA6NrZffjffR5
9o9ZcWtU7uF9kDxgP2vhNruEugOMsqRf6+HP2+hXT0/yFSzLhDJqTaxQSjqC3pFt
LnvqhqWVjjnnA0TcmzHjZTtzYJnIHbli1ZaT1AnKEF1HCa8tbCwta+ve5QneT5II
sEhUAWW4QG9WtwhBGLBi+btOfpnxEL0PfFMJWFUWVvOoHdeahLKnBl+N5CaYUvfX
IZxo1LG+EHELUjTaPAaf
=/bL/
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--

--===============3867492280785083395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3867492280785083395==--
