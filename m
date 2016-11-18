From: Mark Brown <broonie@kernel.org>
Subject: Re: [patch] ASoC: rt5665: Unlock on error in rt5665_calibrate()
Date: Fri, 18 Nov 2016 12:01:23 +0000
Message-ID: <20161118120123.jlqb2eglhwbpwzfa@sirena.org.uk>
References: <20161118115611.GA3784@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7vvxkr23su6lyhrq"
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161118115611.GA3784@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--7vvxkr23su6lyhrq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 18, 2016 at 02:56:11PM +0300, Dan Carpenter wrote:
> We should probably unlock before returning here.
>=20
> Fixes: 33ada14a26c8 ("ASoC: add rt5665 codec driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

This doesn't apply against current code, please check and resend.

--7vvxkr23su6lyhrq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYLu2SAAoJECTWi3JdVIfQOjAH/iwdEr6VzhNcYEa0Caw7OmWo
uB7VEb5XxXrnY82wqAxmLL/U5V0xDZ2sMgq1VUeG1jRLb4jPiRzr4cOZdAXiXkP+
az0Gmvb9ao58ZPvAaEluzMpY5EFHtGbMTofk4AHDTlHRFzftdKKC63Wb1r7/inUV
YYFOETIeFYyabW6OjLNxQpt/g8Sc08MCVi4j+w4IWhbp2/nOMFjsQlSUPzy7T1SZ
iOKi/BhgUSHHPDyNVTF5M4S37yM65ZE27yF83p1Oup2C+UbnH3zuGNSHtF329gyz
HXOlF1fc7XHdunziTUyLd9jsS3zYe6O7i5jfww8deVn+3AzKBR2fcp4VQzg/Cqg=
=SPMh
-----END PGP SIGNATURE-----

--7vvxkr23su6lyhrq--
