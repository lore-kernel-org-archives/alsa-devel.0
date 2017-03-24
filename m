From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/3] ASoC: Enable a new IC master mode:
 bcm2835<=>IC<=>cs42xx8
Date: Fri, 24 Mar 2017 19:09:55 +0000
Message-ID: <20170324190955.nxw5az4mza2ia6wl@sirena.org.uk>
References: <20170228095929.GH2742@localhost.localdomain>
 <20170315190108.y6ybxm3nfgnutajv@sirena.org.uk>
 <7d8d38f7-53aa-cc3d-4bbd-141649528a8a@flatmax.org>
 <8c62f014-d246-e0c1-2b02-a28a2c2786b7@metafoo.de>
 <000fbaa4-4c7c-5b13-0806-7e42672a4a55@flatmax.org>
 <e0adcc6c-8bf4-adae-874b-c291e71e5712@laposte.net>
 <20170321221145.GA7258@camel2.lan>
 <579f0763-a5bd-f820-b36f-b6437e331b4b@flatmax.org>
 <20170322094301.GE6986@localhost.localdomain>
 <64802e9b-ffe9-65e3-502a-4253674fb4c7@flatmax.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3642062434408262250=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 00AC42669DD
 for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2017 20:10:31 +0100 (CET)
In-Reply-To: <64802e9b-ffe9-65e3-502a-4253674fb4c7@flatmax.org>
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


--===============3642062434408262250==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pm2jo63xyijliwfb"
Content-Disposition: inline


--pm2jo63xyijliwfb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 22, 2017 at 11:04:34PM +1100, Matt Flax wrote:
> On 22/03/17 20:43, Charles Keepax wrote:

> > Are we saying that what gets transmitted on the bus is neither valid
> > I2S or DSP mode data? But as you have your custom hardware block in
> > the middle it interprets this data correctly and converts it to a
> > regular bus format on the other side that goes to the CODEC?

> Yes, essentially there is translation between the two data word edge
> triggered ABP (the bcm2835's PCM block) and a Cirrus Logic TDM codec.

Could you please be concrete about what the two formats you're talking
about here are and how these differences are observable on the wire?  I
don't know what "two data word edge triggered ABP" means.

--pm2jo63xyijliwfb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljVbwIACgkQJNaLcl1U
h9AK8wgAhKTtzGYEwml9mWU+kZtznc6kjE83ptMIkwwN73Qhc/EUZXu3H/27HpVd
iwGAAIbBkkntKrfgSx22DPpfB2lGQ4F93aTidpLXefkJno+lBGq9F1yKxzcwE3vN
kSFmS1Rt35uBbi2i2b3IuqHTszbAL6klADBiOMBpU40k1L5hU/00UCQRV+A96yeB
vSiEqfHItcBcwaT+I08TmHYrpKqmmr4KHFAKfrLMfsXWAWpSanOU0h9WTeH2Fe+m
drfagWxb2BkJebOCVtdb32xmwRm1/J1iYgidetb0++3O+D0/YsCcod67chYygxvg
VLu81/3HwtWKInv3+QqBo0PzLshkKg==
=HfX3
-----END PGP SIGNATURE-----

--pm2jo63xyijliwfb--

--===============3642062434408262250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3642062434408262250==--
