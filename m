From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH v2 1/3] dt-bindings: ASoC: Add TDA7802
 amplifier
Date: Tue, 30 Jul 2019 15:33:39 +0100
Message-ID: <20190730143339.GH4264@sirena.org.uk>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-2-thomas.preston@codethink.co.uk>
 <20190730122748.GF54126@ediswmail.ad.cirrus.com>
 <20190730131209.rdv2kdlrpfeouh66@pengutronix.de>
 <16a99e45-fd5a-2878-acf9-63518f9ca527@codethink.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+QwZB9vYiNIzNXIj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <16a99e45-fd5a-2878-acf9-63518f9ca527@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Preston <thomas.preston@codethink.co.uk>
Cc: Marco Felsch <m.felsch@pengutronix.de>, Charles Keepax <ckeepax@opensource.cirrus.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Rob Duncan <rduncan@tesla.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Kirill Marinushkin <kmarinushkin@birdec.tech>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Annaliese McDermond <nh6z@nh6z.net>, Paul Cercueil <paul@crapouillou.net>, Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Nate Case <ncase@tesla.com>, Cheng-Yi Chiang <cychiang@chromium.org>, Patrick Glaser <pglaser@tesla.com>, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org


--+QwZB9vYiNIzNXIj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 30, 2019 at 03:12:21PM +0100, Thomas Preston wrote:
> On 30/07/2019 14:12, Marco Felsch wrote:

> >>> +- compatible : "st,tda7802"
> >>> +- reg : the I2C address of the device
> >>> +- enable-supply : a regulator spec for the PLLen pin

> > Shouldn't that be a pin called 'pllen-gpios'? IMHO I would not use a
> > regulator for that.

> Hi Marco,
> We have multiple amplifiers hooked up in a chain, and all the PLLens
> are connected to one GPIO. So we need to use a regulator so that
> i2c-TDA7802:00 doesn't turn off the PLLen which i2c-TDA7802:01 still
> requires.

> This is why we use a regulator. Is there GPIO support for this?

If it's a GPIO not a regulator then it should be a GPIO not a regulator
in the device tree.  The device tree describes the hardware.  There was
some work on helping share GPIOs in the GPIO framework to accomodate
GPIOs for regulator enables, you should be able to do something similar
to what the regulator framework does.

--+QwZB9vYiNIzNXIj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1AVUMACgkQJNaLcl1U
h9Cu4Qf+OOSeubUr69q1X65qxycxElWJauRAa8zN5ZCS6Corf1z/+hgxkei5GI7D
p242D+7O5/QHuGlsws3pHfiD3BUJbV+/D05v8DDX1GOEf54+8wv+dnX/1AZKtYzS
IU/5aki3+oYGj76dQKpAhuTJFnJGGmkMg+O5SWXocr3KZO5P740PKZG0+wVX+yQp
OdZbJOEfztfQ8AfQQ4vtSjun2grcmxeEyxPo7LiL+iNs2ifAOZW6TWNIl7Y/Xftg
UNGdYVAtOL9s9G364+UmdAbLbQtKDtLLnotRd98S8NGElOoOGoLss6/pwrW2BHd4
CgdgNotIdcr1q2Me8acJM2d8pxjKWA==
=aDlD
-----END PGP SIGNATURE-----

--+QwZB9vYiNIzNXIj--
