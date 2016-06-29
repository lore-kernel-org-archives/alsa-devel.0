From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 09/39 v2] ASoC: simple-card-utils: add
 asoc_simple_card_parse_clk()
Date: Wed, 29 Jun 2016 19:18:43 +0100
Message-ID: <20160629181843.GM6247@sirena.org.uk>
References: <87fusysjam.wl%kuninori.morimoto.gx@renesas.com>
 <8737oysj1d.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kunpHVz1op/+13PW"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8737oysj1d.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--kunpHVz1op/+13PW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 31, 2016 at 09:02:22AM +0000, Kuninori Morimoto wrote:

> +	struct clk *clk;
> +	u32 val;
> +
> +	/*
> +	 * Parse dai->sysclk come from "clocks = <&xxx>"
> +	 * (if system has common clock)
> +	 *  or "system-clock-frequency = <xxx>"
> +	 *  or device's module clock.
> +	 */
> +	clk = of_clk_get(port_np, 0);
> +	if (!IS_ERR(clk)) {
> +		simple_dai->sysclk = clk_get_rate(clk);
> +		simple_dai->clk = clk;
> +	} else if (!of_property_read_u32(port_np, "system-clock-frequency", &val)) {
> +		simple_dai->sysclk = val;
> +	} else {
> +		clk = of_clk_get(endpoint_np, 0);
> +		if (!IS_ERR(clk))
> +			simple_dai->sysclk = clk_get_rate(clk);
> +	}

This looks like we're leaking the clocks - devm_ might help here
perhaps?

--kunpHVz1op/+13PW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXdBEBAAoJECTWi3JdVIfQJq4H+wYo25+Urw2BDs9+rBahpLJH
iUhUs1PaaLY1B6yUPd8nsu3I8rMe3rKl+AyZjUqnYJQxc5cvAqEdlGVJNgMfdGwF
ccAUxa5oLqrL3T8mMC/R7JeuTiHmsbH3FoxCv3tmQZDT5OHPidvKDEX4zCmy+v75
vxcX8oDpvDxuDN4A2zpmYn+cLhBvziKiWJoVQEFaav/7/MAgxIRkneWKVLNrICvk
zew6FniTdE09tBsLyHGn/P+peENNRkEz+UV6ur2NMlqEoxIiLaPXhUs0p5lDZMTj
GXoMSd8L3Jer10FbeiiG7xAumgCJ3ARu8s/TfYBxpTmAgEQPmvOZHrNoaTT7TTw=
=ffm8
-----END PGP SIGNATURE-----

--kunpHVz1op/+13PW--
