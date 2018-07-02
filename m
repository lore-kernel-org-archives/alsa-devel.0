From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] ASoC: es7241: add es7241 codec support
Date: Mon, 2 Jul 2018 11:12:22 +0100
Message-ID: <20180702101222.GF18211@sirena.org.uk>
References: <20180630172241.10806-1-jbrunet@baylibre.com>
 <20180630172241.10806-3-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5Mfx4RzfBqgnTE/w"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180630172241.10806-3-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--5Mfx4RzfBqgnTE/w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 30, 2018 at 07:22:41PM +0200, Jerome Brunet wrote:

> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_I2S:
> +	case SND_SOC_DAIFMT_LEFT_J:
> +		break;

These two modes are not the same so either there should be some
different handling to select between them or one shouldn't be supported.

Otherwise this looks good.

--5Mfx4RzfBqgnTE/w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls5+oUACgkQJNaLcl1U
h9Aa8wf/dTruuIVc491yHsEFn7v66TTYBsqp6sndJaIy3KbCwH/KZfEc1KSKK3zf
0gpuiPdNgKAFibcp0x1sylNtY2E/HTWMcrf+2TolhWxO4C4yvS7Ih1qnuBqEmJKJ
VLllaBMWaO93hE9SfO7zUGDhqo47Tr0NT8vitatetYlun6S+uz04OrPrkc/M8a8+
SC3SfbdGAmdr73QRipZv6H5pGg0CoqgSHQwvV4EDPlsG+O34HKh7VXLWCN5bLOJp
77yzncpZbuDLtdpZMYflhmHQ4Z70+nkP0zowSDH603W3GQZEj/C6RQvjI5Ylr/DQ
g3Rh7X6OgTiG4pS+X0M43HC5aRkICA==
=M0sR
-----END PGP SIGNATURE-----

--5Mfx4RzfBqgnTE/w--
