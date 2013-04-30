From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: ux500: move clock controls to ab8500-codec
Date: Tue, 30 Apr 2013 19:30:35 +0100
Message-ID: <20130430183035.GC26160@sirena.org.uk>
References: <1367330994-7259-1-git-send-email-fabio.baltieri@linaro.org>
 <1367330994-7259-3-git-send-email-fabio.baltieri@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1367330994-7259-3-git-send-email-fabio.baltieri@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Baltieri <fabio.baltieri@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, Ola Lilja <ola.o.lilja@stericsson.com>
List-Id: alsa-devel@alsa-project.org


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 30, 2013 at 04:09:53PM +0200, Fabio Baltieri wrote:
> Move ab8500 clock control definitions to the ab8500 codec driver,
> leaving only card specific setting in mop500_ab8500_ctrls.

So, if this is some generic thing and not some weird stuff for the card
this really reopens the question about why this is done with user
visible controls...

>  static struct snd_kcontrol_new ab8500_ctrls[] = {
> +	/* Digital interface - Clocks */
> +	SOC_SINGLE("Digital Interface Master Generator Switch",
> +		AB8500_DIGIFCONF1, AB8500_DIGIFCONF1_ENMASTGEN,
> +		1, 0),
> +	SOC_SINGLE("Digital Interface 0 Bit-clock Switch",
> +		AB8500_DIGIFCONF1, AB8500_DIGIFCONF1_ENFSBITCLK0,
> +		1, 0),
> +	SOC_SINGLE("Digital Interface 1 Bit-clock Switch",
> +		AB8500_DIGIFCONF1, AB8500_DIGIFCONF1_ENFSBITCLK1,
> +		1, 0),

...this is all stuff that is normally figured out automatically by the
drivers, we know when the audio interface is in use and hence when it
needs to be clocked.

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRgA3IAAoJELSic+t+oim9x1QP/iiEmShnYvFGkVpqah3NZPzg
Y5qvxDDXFlFNMd3vD9woe/FwLrMivmNcS4lOlHqNb307Q1mepHggcztia5ZPHTC5
M19x2S2vzXrshGUp8GPnY3Mi/j72Ae9cT4/B4JUiL+w69fSjLsHrri37ujs2aazf
/G9/92BWB3gaV4ZtyyIP3EyIWre4sTIyiBB0iRKt+wSZ8XQ0zo8mZWzcj+dVxW6D
DxRG8RPvEZ4XpBZzEykzKs0qQYTOFfuAX/z2DB7DogKiB4YmiNc0MlMicwUnHt1f
S5XN3GZFCaLQFM7Yc8zHVaLjQhOFyP+SVTS6lzoVuFOHUSeQqcH2Uwi/WNOWGVkP
lNiyEARIguVwRnA6A++TIzKTqTYDbnTvDhmWtEkVb+b0bfBTJc7fWwEBDbr7WFIO
q5CB8UimA7+nSrJHSMRMhBqpphZWqjWoBSqJ9qdvS6ZG5ECTOxMkqzbOVFoLGpAR
h4OM4tpJDDOdgZyqZBef9D2rcwXTBKffQiMtADkfy7wjMGuP8JOGjK3liPrGzmik
35ZrmV3hXKYDJG7/nyyA/q0izMSwekEkAEERp7iOO/ey5Org7d+vkot9aoE2uVNc
WESxLocuKWGM+9Gej+NCpvmFMSyp5pwy8UHa5KLVhI+dQC6vInRYeJWrVQ+rs5wl
GZAYlhYXWKccpi/2qp8I
=4Lf8
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--
