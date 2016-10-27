From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: cq93vc: remove MFD_DAVINCI_VOICECODEC
 dependency from CQ0093VC
Date: Thu, 27 Oct 2016 11:17:07 +0100
Message-ID: <20161027101707.GI25322@sirena.org.uk>
References: <878ttafb84.wl%kuninori.morimoto.gx@renesas.com>
 <8760oefb59.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LYw3s/afESlflPpp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8760oefb59.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Lee Jones <lee.jones@linaro.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Arnd Bergmann <arnd@arndb.de>, anish kumar <yesanishhere@gmail.com>, Michael Trimarchi <michael@amarulasolutions.com>, Jacob Siverskog <jacob@teenage.engineering>, "Damien.Horsley" <Damien.Horsley@imgtec.com>, Jeremy McDermond <nh6z@nh6z.net>, Bard Liao <bardliao@realtek.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--LYw3s/afESlflPpp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 27, 2016 at 08:38:45AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> CQ0093VC is no longer dependent on MFD_DAVINCI_VOICECODEC,
> let's remove it. Otherwise, we can't compile it by COMPILE_TEST
> on non-DAVINCE platform

Acked-by: Mark Brown <broonie@kernel.org>

--LYw3s/afESlflPpp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYEdQiAAoJECTWi3JdVIfQg7oH/iQzlwPU+zaxz49XVJHARJ5x
+njbwIJVDPabPQLUiKGw9hSvboLSIWT1r+44TOIKLzDynBNGX4Eq+F2yy30B4SpM
lnyGIEsg/NTFbRvX5uvPsT2VItj5MS7/od4/S3+hQ8VP4pBkOjDaeWrkJ/lg/dBS
k+jr5OMoCtBCPxaOdQ8E81hAL16OuFyJQrXVb2r85ddDChYB6I7Un+n8KihvjEHX
4Qp8PE3qUf52MCMHv7YtQUF6H2eWCIZG3pij7xBrhSvw2N8HfyojZV7mCXA8ApVB
hogScd9dUnTlOqydQVY2amzA5shQXye6z1mXnCrSCY6umdoCAzzMK7iLGLIMdJI=
=t25E
-----END PGP SIGNATURE-----

--LYw3s/afESlflPpp--
