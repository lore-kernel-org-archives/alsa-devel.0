From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] ASoC: es7241: add es7241 codec support
Date: Mon, 2 Jul 2018 11:20:21 +0100
Message-ID: <20180702102021.GG18211@sirena.org.uk>
References: <20180630172241.10806-1-jbrunet@baylibre.com>
 <20180630172241.10806-3-jbrunet@baylibre.com>
 <20180702101222.GF18211@sirena.org.uk>
 <1530526503.2900.144.camel@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Z0mFw3+mXTC5ycVe"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1530526503.2900.144.camel@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--Z0mFw3+mXTC5ycVe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 02, 2018 at 12:15:03PM +0200, Jerome Brunet wrote:
> On Mon, 2018-07-02 at 11:12 +0100, Mark Brown wrote:
> > On Sat, Jun 30, 2018 at 07:22:41PM +0200, Jerome Brunet wrote:

> > > +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> > > +	case SND_SOC_DAIFMT_I2S:
> > > +	case SND_SOC_DAIFMT_LEFT_J:
> > > +		break;

> > These two modes are not the same so either there should be some
> > different handling to select between them or one shouldn't be supported.

> Actually, the difference is provided with some pull-up/pull-down resistor.
> There no way to set this up in SW, AFAIK.
> So the driver shall accept both and trust we are not doing anything crazy

It at least needs a comment as this is obviously dodgy code.  Ideally
there'd be a DT property saying which mode was selected on a given board
so if we ever get round to doing automatic configuration of formats the
driver will be able to cope.

--Z0mFw3+mXTC5ycVe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls5/GUACgkQJNaLcl1U
h9Dk6Qf+KpnHKNh2NZjc91/0ZUyk0RyOmMbzKit6MK+DL2ye8d7IgPmEOdsKXr0B
s6Xsm+1UMYYj9p8MwVdhKJwMqfdk42QFW52L1zWnQ+5cRXTrzDLcJ2xy8/oHdS1F
SMNa4r7mEAwyHMJjCO9ve5b9FMVi1M70zsbPRl03a+BuRvc2omqFBCF6DWkeRNUN
fdwKj3TF7ZCs0w2XsrLP5aFsSV3KwOsctvxJCwQTRgNkYFpIS9/LtX25LZHA5t0D
7HBfBbuCj4vxiJJCn97STHbcYpNyoMa6jIIYymqgoJSLJ24oNb5h1g8n79OWJdCd
/CuLIGF69EkqgWJde9xX9/PnCu06kw==
=EDSK
-----END PGP SIGNATURE-----

--Z0mFw3+mXTC5ycVe--
