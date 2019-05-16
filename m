From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2] ASoC: cs42xx8: Add reset gpio handling
Date: Thu, 16 May 2019 11:11:36 +0100
Message-ID: <20190516101136.GC5598@sirena.org.uk>
References: <95eb314ef6d47ee6581094a406516a6069278d56.1557986457.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZwgA9U+XZDXt4+m+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <95eb314ef6d47ee6581094a406516a6069278d56.1557986457.git.shengjiu.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "brian.austin@cirrus.com" <brian.austin@cirrus.com>, "Paul.Handrigan@cirrus.com" <Paul.Handrigan@cirrus.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 16, 2019 at 06:04:58AM +0000, S.j. Wang wrote:

> +	cs42xx8->gpiod_reset = devm_gpiod_get_optional(dev, "reset",
> +							GPIOD_OUT_HIGH);
> +	if (IS_ERR(cs42xx8->gpiod_reset))
> +		return PTR_ERR(cs42xx8->gpiod_reset);

You also need a binding document update for this.

--ZwgA9U+XZDXt4+m+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzdN1cACgkQJNaLcl1U
h9B77wf6Am2asgXqw+nI5Ts2nEP5jHpq8r6uTGJ7oAsVZ/DvX7MFJgwRwYwmfaiI
DcGaR6tx0sMwGjHVhLVu4mMG7vAgjkkwNMi7OArvG9hF+c9A4CLy84gQMlxwScqQ
TR562sJfuDfzwI5sA0+FSuZAg3To/WGO9X+wKcH9IASntblmxesPPuMpxwNwb89M
xVNTgRrRWSzfjWptZFCbWrRsoFv8BCov9zXx3UfDbjFMT2CQ86l88QuQs1RwHOB9
/k7pwiObaEGOngMKkg+UIRo34myrsc/RtBNpSwdXX37KpMeXjQ0nIVOIPGbjyxrl
n9xbKAC+csBlahOJM6VzPQyXiCAQmA==
=gQpf
-----END PGP SIGNATURE-----

--ZwgA9U+XZDXt4+m+--
