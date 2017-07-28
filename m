From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/3] ASoC: codecs: msm8916-wcd-digital: select DMIC
 source in CIC filter path
Date: Fri, 28 Jul 2017 14:32:06 +0100
Message-ID: <20170728133206.7ynzrbfvreclltkx@sirena.org.uk>
References: <20170725234822.18763-1-srinivas.kandagatla@linaro.org>
 <20170725234822.18763-4-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wkyciy5kezguznkq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170725234822.18763-4-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: srinivas.kandagatla@linaro.org
Cc: Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--wkyciy5kezguznkq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2017 at 01:48:22AM +0200, srinivas.kandagatla@linaro.org wr=
ote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>=20
> This patch fixes a missing selection of DMIC in CIC filter source path.
> Without this patch dmic is not functional.

What happens when someone needs this filter connected somewhere else -
shouldn't this be controlled as part of the DAPM routing?

--wkyciy5kezguznkq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAll7PNMACgkQJNaLcl1U
h9DiHQf4xxrHuJD5P3eMwn6IGKY39qm6ecjMRhdgqMteL6hLkaRn+RML4yijA1ca
YfrMkUmxroasMOSxzFZpsWeyanwu4PgytVJPimEkb912q9BCE7f6YEXIwk0lt4w8
UfAbAQNWQPcXvcP69h7tSVwBhddpgeMwBIvs8Mka3a59qG2buxv711rrnsQajGzq
FStV6ohjIRV7f003wkUAFek2H9iCWwYrXqo+nWEQQBYslTPPNaW1pV/Elkpm7sKM
SZ6yT9KmAYBFeOPcDF2nUMNqNK6zt1p4Z4wQwbpdy/nqTtQ6Z+Vmnqag0/4oI/x6
hZgWqg60CrVDk3D45SGXlMitru3b
=4kiL
-----END PGP SIGNATURE-----

--wkyciy5kezguznkq--
