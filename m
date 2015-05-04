From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V3 3/4] ASoC: tas571x: New driver for TI TAS571x power
 amplifiers
Date: Mon, 4 May 2015 12:45:58 +0100
Message-ID: <20150504114558.GD15510@sirena.org.uk>
References: <1430697619-22773-1-git-send-email-cernekee@chromium.org>
 <1430697619-22773-4-git-send-email-cernekee@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ieNMXl1Fr3cevapt"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430697619-22773-4-git-send-email-cernekee@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Cernekee <cernekee@chromium.org>
Cc: lgirdwood@gmail.com, lars@metafoo.de, dgreid@chromium.org, abrestic@chromium.org, olofj@chromium.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--ieNMXl1Fr3cevapt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 03, 2015 at 05:00:18PM -0700, Kevin Cernekee wrote:

> +	}
> +
> +	codec->dapm.bias_level =3D level;
> +	return 0;
> +}

This assignment was factored out into the core last week, I'll fix up
for that.

> +	if (dev->of_node) {
> +		const struct of_device_id *of_id;
> +
> +		of_id =3D of_match_device(tas571x_of_match, dev);
> +		if (of_id)
> +			priv->chip =3D of_id->data;
> +	}

Doesn't of_match_device() do the right thing with devices not registered
=66rom DT?

--ieNMXl1Fr3cevapt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVR1v2AAoJECTWi3JdVIfQB50H/AmSEQPSTPu2NKen6stBNWL/
bDThUtuD3yS7eU+jyZdFYU9qX/XjmcwMbvrUq2skMiXFd3E3a2SwifJ8pfHjze86
X2YksmReUZEBytyYWRiaTp5NqsfU7+zHCBsZ/2m25YB/5JLHojYrA2uX8h3pcqXZ
SGhm0/ISqOgtOPlp824y/SFjc4+A0TomPD2ykKeG9E47f86n5vFzusOJm0YaKMUO
WIWdxjbV85M2/3vtr1drAydWF/uFY3h1W0szs3TKDS9g/vkVCfi4aBRBu7B9Vl+J
JaE/k9cAyU85zTP7tv5acN5d7ymyEr+1gcDeBsbKUglVKU3A2fJ7ZT5owUR8tG8=
=vjIR
-----END PGP SIGNATURE-----

--ieNMXl1Fr3cevapt--
