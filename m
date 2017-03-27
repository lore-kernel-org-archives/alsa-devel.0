From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/3] ASoC: Enable a new IC master mode:
 bcm2835<=>IC<=>cs42xx8
Date: Mon, 27 Mar 2017 11:01:26 +0100
Message-ID: <20170327100126.osj3o2qtq4jwex3s@sirena.org.uk>
References: <7d8d38f7-53aa-cc3d-4bbd-141649528a8a@flatmax.org>
 <8c62f014-d246-e0c1-2b02-a28a2c2786b7@metafoo.de>
 <000fbaa4-4c7c-5b13-0806-7e42672a4a55@flatmax.org>
 <e0adcc6c-8bf4-adae-874b-c291e71e5712@laposte.net>
 <20170321221145.GA7258@camel2.lan>
 <579f0763-a5bd-f820-b36f-b6437e331b4b@flatmax.org>
 <20170322094301.GE6986@localhost.localdomain>
 <64802e9b-ffe9-65e3-502a-4253674fb4c7@flatmax.org>
 <20170324190955.nxw5az4mza2ia6wl@sirena.org.uk>
 <3c818d92-498e-868c-696b-a9b709af5415@flatmax.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7863041659770154567=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4954726583C
 for <alsa-devel@alsa-project.org>; Mon, 27 Mar 2017 12:02:02 +0200 (CEST)
In-Reply-To: <3c818d92-498e-868c-696b-a9b709af5415@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Flax <flatmax@flatmax.org>
Cc: Emmanuel =?iso-8859-1?Q?Fust=E9?= <emmanuel.fuste@laposte.net>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>, Eric Anholt <eric@anholt.net>, Lee Jones <lee@kernel.org>, phil@raspberrypi.org, Liam Girdwood <lgirdwood@gmail.com>, Matthias Reichl <hias@horus.com>, florian.kauer@koalo.de, Florian Meier <florian.meier@koalo.de>, linux-rpi-kernel@lists.infradead.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7863041659770154567==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p5idljytbm7ltuew"
Content-Disposition: inline


--p5idljytbm7ltuew
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 25, 2017 at 04:45:46PM +1100, Matt Flax wrote:
> On 25/03/17 06:09, Mark Brown wrote:

> > Could you please be concrete about what the two formats you're talking
> > about here are and how these differences are observable on the wire?  I
> > don't know what "two data word edge triggered ABP" means.
> On the codec side it is a regular TDM stream.
> On the SoC side, two channels  are arbitrarily offset from a PCM frame sync
> clock (PCM_FS) leading edge. I have chosen to have 64 bits per frame with 1
> bit offset for the first word (from the leading edge) and 33 bits offset
> (from the leading edge) for the second word. This resembles I2S, but it
> doesn't have to for the bcm2835.

What's internal to the SoC is not relevant here, what matters is what's
externally visible.  The formats on the DAI are how the SoC interfaces
with the outside world.

--p5idljytbm7ltuew
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljY4vUACgkQJNaLcl1U
h9CNEQf9F7bzWaXEBoXAGivDYnXxt+AcWF8o5c+5U8OlWU5/Yi7yZSg/T3ERPt0t
t3YhdNIKZhGgA2vW4YzOoJnnNlzezUY3KoFz/OllZGjgzn9i2FYz9P34CLdbqjgS
3G/QXDZolxvOWZST/rXeNeS7sf1iZx3YimCwbybXhfvtTObgS2+p0ekdX/IFsy9S
I5AB5KUvwV/QyMyLGvcKgSXsybtbJYz7d89E29v3Gl+HWHcePeC3j0usbf5by/C7
4II07OZ6XUiHvk8UYD9ZYhKfUPzv/q62u9p1Bv6fXzgwCm9Mo0ekoso0eeDlKPhk
cFl4QsJSQGIi+Gd50h0u8l+xN8HR6g==
=LKp5
-----END PGP SIGNATURE-----

--p5idljytbm7ltuew--

--===============7863041659770154567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7863041659770154567==--
