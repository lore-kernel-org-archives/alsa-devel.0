From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sun4i: Implement MIC1 capture
Date: Mon, 30 Nov 2015 16:17:05 +0000
Message-ID: <20151130161705.GY1929@sirena.org.uk>
References: <1448897867-22320-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R9qb+eAX/AZDW6n0"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448897867-22320-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--R9qb+eAX/AZDW6n0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 30, 2015 at 04:37:47PM +0100, Maxime Ripard wrote:

A couple of minor issues below but I'll apply this - please send
followup patches.

> +static void sun4i_codec_start_capture(struct sun4i_codec *scodec)
> +{
> +	/*
> +	 * FIXME: according to the BSP, we might need to drive a PA
> +	 *        GPIO high here on some boards
> +	 */

That's not something this driver needs to worry about, that's something
the machine driver will do - the whole purpose is to glue all the
different components on the board together.

> +	if (clk_set_rate(scodec->clk_module, clk_freq))
> +		return -EINVAL;

It'd be better to pass back the error code from clk_set_rate().

--R9qb+eAX/AZDW6n0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWXHaAAAoJECTWi3JdVIfQ4IoH/3FGtbGtlQ3XEUwRxe61wXmf
yd3ixVGfLkyKAjdcTbM0j1sVKW2V/GaEwtAG5SuM61AhM2p5354iCsop0oHBxbr+
8XlfqmvYAr7p1QZ0De+CCjR0SBmDIWPgY7DqJgyRAofjJyN2qRum3HA3yZdsbCzJ
RhXaKB52F7IFL7rshspPdoGjugw8lKDwaVeLJ04F93I7RbCXRdx9S4ebggtLp4Yv
kTxzSrx+IEyEHvi992XaCmIRu51QHoj22EYNkS+axK0QHFSRKjvchKaUpdbZLpoZ
NIOTc/dIpunXmPMNe9WyB/1jJJ5iQKsw5ErlTZRNMV1ffzCQUyDTuWFrOnpfSlA=
=makr
-----END PGP SIGNATURE-----

--R9qb+eAX/AZDW6n0--
