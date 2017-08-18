From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/9] ASoC: rt5514: Avoid legacy dai naming
Date: Fri, 18 Aug 2017 12:45:44 +0100
Message-ID: <20170818114544.szfxl5pbul7gwgxg@sirena.org.uk>
References: <20170818031147.16810-1-jeffy.chen@rock-chips.com>
 <20170818031147.16810-2-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i5iao33e5l3rmp5z"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170818031147.16810-2-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, dgreid@chromium.org, heiko@sntech.de, briannorris@chromium.org, mka@chromium.org, dianders@chromium.org, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--i5iao33e5l3rmp5z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2017 at 11:11:39AM +0800, Jeffy Chen wrote:
> Currently we are using devm_snd_soc_register_component, which would
> use legacy dai naming when dai drv id is zero.
>=20
> Set a non-zero dai drv id to use dai drv name for dai name.

Why?  This is clearly not good, we shouldn't be expecting all devices
with a single DAI to set the DAI number to 1 and the changelog doesn't
articulate any reason why anything cares what the name is.

--i5iao33e5l3rmp5z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmW02cACgkQJNaLcl1U
h9CPcAf+Ju6NbxRsKuFWso08GxyqgMyB9ZzQ6xIbRbS316AwX9+AHNLXqelgs58g
Znvx5FR82TQzidTV4pKcaRxiZuz6vQmiw1Zpi2RABKAMPUqGGFA2ZXgg1Pa696F1
T4jOAMGZ8/OdkL03xVtu8a08C1olMF6mlLAcpBWo/IkV43DucLkkg2TSDJp9xdnX
xVRO6YmZOdLxJM4bxbvnKl/hvYT2Ey8okLWCZALKLOF76jNWumBcBzWJ24t+lw7m
rctyZuykM7Psid445Pso/7GHdObgmR5QHKjZa3pmfndLDt+FQuq8joFk00lcb8qO
BPzTWLXAh2T+siWjxUPOleQr/MMxKg==
=GunK
-----END PGP SIGNATURE-----

--i5iao33e5l3rmp5z--
