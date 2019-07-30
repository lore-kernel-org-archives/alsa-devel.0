From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH v2 3/3] ASoC: TDA7802: Add turn-on
 diagnostic routine
Date: Tue, 30 Jul 2019 15:20:10 +0100
Message-ID: <20190730142010.GG4264@sirena.org.uk>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-4-thomas.preston@codethink.co.uk>
 <20190730124158.GH54126@ediswmail.ad.cirrus.com>
 <e7a879d3-36c2-2df8-97c0-3c4bbd2e7ea2@codethink.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8S1fMsFYqgBC+BN/"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e7a879d3-36c2-2df8-97c0-3c4bbd2e7ea2@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Preston <thomas.preston@codethink.co.uk>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Marco Felsch <m.felsch@pengutronix.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Kirill Marinushkin <kmarinushkin@birdec.tech>, Cheng-Yi Chiang <cychiang@chromium.org>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Paul Cercueil <paul@crapouillou.net>, Vinod Koul <vkoul@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Annaliese McDermond <nh6z@nh6z.net>, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org


--8S1fMsFYqgBC+BN/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 30, 2019 at 03:04:19PM +0100, Thomas Preston wrote:
> On 30/07/2019 13:41, Charles Keepax wrote:

> > This could probably be removed using regmap_multi_reg_write.

> The problem is that I want to retain the state of the other bits in those
> registers. Maybe I should make a copy of the backed up state, set the bits
> I want to off-device, then either:

> 1. Write the changes with regmap_multi_reg_write
> 2. Write all six regs again (if my device doesn't support the multi_reg)

Or make this a regmap function, there's nothing device specific about
it.

--8S1fMsFYqgBC+BN/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1AUhkACgkQJNaLcl1U
h9BETgf7BOzHBpbnhWhg2mabB09TWYhaMWdG7DZWPeU+jTPkgFJuIroIGpBf3h/c
WIE9G2Zy55KDP7yf1wM1Ad7N18JCMzX+enceVyJ4ZlHhpA3wLhTleyaIdn6JGSHB
++DqO5maWG0iL698Um5bPFI6lvOF9Ewd1KanKCW0hEH93m5C9D5jY4sqItVgEPb1
9vwdUdMo/MqfcwpS3rzXUC98OXCrnC8o0pPDFZT4U5i7X9gNqSSbKIhnBqmCOY+d
P6aoGUTv9ZwcZSj1cU1Ty5NKiKAu7asJyWzBvZFc6T9NcAbX3ascLBMWgP5BxYPG
LuOQqsFxOiOi3H8N4WlvJk3bvvY1mQ==
=0sPL
-----END PGP SIGNATURE-----

--8S1fMsFYqgBC+BN/--
