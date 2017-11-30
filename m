From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 5/8] ARM: dts: am335x-pepper: Fix the
 audio CODEC's reset pin
Date: Thu, 30 Nov 2017 16:53:28 +0000
Message-ID: <20171130165328.q5nknyvwp36xj4t2@sirena.org.uk>
References: <20171129171359.29382-1-afd@ti.com>
 <20171129171359.29382-6-afd@ti.com>
 <20171130161826.GP28152@atomide.com>
 <20171130163344.kudopvsljywb4hyw@sirena.org.uk>
 <4b535cec-6e33-adc0-a962-f5e65d84d1ad@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8371209277230846036=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F42726698E
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 17:53:34 +0100 (CET)
In-Reply-To: <4b535cec-6e33-adc0-a962-f5e65d84d1ad@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Sascha Hauer <kernel@pengutronix.de>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Shawn Guo <shawnguo@kernel.org>
List-Id: alsa-devel@alsa-project.org


--===============8371209277230846036==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="axwco4d2d5uo7iar"
Content-Disposition: inline


--axwco4d2d5uo7iar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 30, 2017 at 10:37:22AM -0600, Andrew F. Davis wrote:
> On 11/30/2017 10:33 AM, Mark Brown wrote:

> > It might make sense to pull in the relevant branches from ASoC first
> > however IIRC the reset GPIO code currently does nothing useful anyway so
> > it won't have any impact on bisection.  Andrew?

> Yeah, that's right, for safety it would be nice to take these after the
> ASoC code, but it shouldn't matter in practice as the reset wasn't used
> right anyway.

I'd just go for it.

--axwco4d2d5uo7iar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlogN4gACgkQJNaLcl1U
h9Ac3ggAhUxG+uggFhqU3Uk8D3lP6+peCoqqDskiAS7FkKylAbrh0tKCi3gaa0Hy
+ldiQzlaD7trWlc6NemZUB7VlEATv+xx7jOpZKBU1xVvlKaFpYDhk+PF0eetBQik
aShL7ZbYO/Swzh7YxmCTeeA6Xw37XyhHVaUOwtW/kj5lKJpfy2rI8SKBq3wgnTt+
Q64UsNbvdNhjwBLpCRgyOGrfifTsGGrpM+uXUGshkoegphO2HC3HVW7QNTkwyRDZ
w8Oy5ap/Va0EPkh/bdbOGPIh09e4/iPxENFvmaUdSQ+FY4fVeYovvQA22VY+U7Z6
d3YCMLypVl7uWS3YgLKmvdHc3moHtQ==
=tzF5
-----END PGP SIGNATURE-----

--axwco4d2d5uo7iar--

--===============8371209277230846036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8371209277230846036==--
