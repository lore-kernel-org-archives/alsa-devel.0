From: Mark Brown <broonie@kernel.org>
Subject: Re: [v2] ASoC: AMD: Configure wclk and bclk of master codec
Date: Mon, 25 Mar 2019 12:16:38 +0000
Message-ID: <20190325121638.GA14893@sirena.org.uk>
References: <20190325063759.28300-1-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190325063759.28300-1-akshu.agrawal@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Cc: "djkurtz@chromium.org" <djkurtz@chromium.org>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Adam.Thomson.Opensource@diasemi.com" <Adam.Thomson.Opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>, Wei Yongjun <weiyongjun1@huawei.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 25, 2019 at 06:38:27AM +0000, Agrawal, Akshu wrote:
> With CCF support in da7219, we can now set the correct rate of
> wclk and bclk.
> Setting bclk at lower rate at 1.53Mhz from its earlier default
> rate of 3Mhz, also fixes noise issue observed on some dmics.

This doesn't seem to apply against current code, please check and
resend.

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyYxqUACgkQJNaLcl1U
h9AE0wf+LXwOaH1w+xCs6SCg8diunJ4u7GEznVhKGP1N7MznNlyFDd3andGgCGt3
nw82fXJX9sccYdOeXit/jS2bONhXrcKiU6Bj/Y5DfB4WyFtnhx6uI2rrFiiKm7jS
fPSr8ZMOvQSQJyKeb04e7dzYt7oJGCJfqL69IzwHem2Xx7USG41HPfI36xo9ZjRl
SxOy1FAn4ZNxdK9S9Rm40utNUSgvTO9CGa9jagDu+AoDhfP6nOYa9YmTH9c+HYQ2
oaMGpYV07ZS/oaFv0sBtc0ysa1/5rpzg/rZbVEEwwDMmloBXQKqrrhYpnZNsKqiJ
gUBMyhuYtwpytp5znagNZkeoki7n5w==
=ZPfW
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
