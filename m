From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: es8316: Add clock control of MCLK
Date: Fri, 30 Aug 2019 12:18:17 +0100
Message-ID: <20190830111817.GA5182@sirena.co.uk>
References: <20190829173205.11805-1-katsuhiro@katsuster.net>
 <20190829173205.11805-2-katsuhiro@katsuster.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190829173205.11805-2-katsuhiro@katsuster.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc: David Yang <yangxiaohua@everest-semi.com>, Daniel Drake <drake@endlessm.com>, Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 30, 2019 at 02:32:04AM +0900, Katsuhiro Suzuki wrote:

> +	es8316->mclk = devm_clk_get(component->dev, "mclk");
> +	if (PTR_ERR(es8316->mclk) == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;

If we don't get a clock it'd be nice to at least log that in case
there's something wrong with the clock driver so that people have more
of a hint as to why things might be breaking.

> +
> +	if (es8316->mclk) {
> +		ret = clk_prepare_enable(es8316->mclk);
> +		if (ret)
> +			return ret;
> +	}
> +

There's nothing that disables the clock on remove.

Otherwise this looks good.

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1pBfYACgkQJNaLcl1U
h9Cfdgf/QHjLqKONAE1J+gdjS0oEehwivLJxEfiY5Bz+LQ/xr+cbRBqLot2+aWM7
b0nZOgOiyKEj6nHSsFnd5ss9GJPvxePyhpwrYifIwRk9UyD6Z16cDP7V1Rz4ad0z
SFmyAE1XHhvbO5MrQvfmKpO9NfiyiuieFf3HQNDgDfPzLKBHgBXZEv4uHuAp7Id6
DeggzMHMb4buK21+AWzcMUh8i8Uygh93qvvpWp6crjUkiIx11kmGuJSp7bYSTx28
1DAHiGVBssJ/RVRk/DJUDuHamDOg+zdDzsy2Br+67WLM8o7azI/4zV3q80HdMz3P
KnY0fDkDGYNvaRG9WZfo7UR6sCQNdQ==
=QHgV
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
