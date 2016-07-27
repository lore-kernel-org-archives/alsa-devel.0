From: Mark Brown <broonie@kernel.org>
Subject: Re: Is this bug ? dev_set/get_drvdata() of rtd
Date: Wed, 27 Jul 2016 11:47:41 +0100
Message-ID: <20160727104741.GJ11806@sirena.org.uk>
References: <8760rrdb10.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1EKig6ypoSyM7jaD"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8760rrdb10.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--1EKig6ypoSyM7jaD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 27, 2016 at 03:25:41AM +0000, Kuninori Morimoto wrote:

> I think device data of "rtd->dev" is set as "rtd" on soc_post_component_i=
nit()
> by using dev_set_drvdata(),
> and many soc-core functions are based on it (=3D they are using dev_get_d=
rvdata())

> But, soc.h has snd_soc_pcm_set_drvdata().=20
> device data of rtd->dev will be overwrite by this function ?
> But is this OK ? or bug ?

Looks like a bug, I suspect there's some confusion caused by old code
expecting there to be a soc-card device there and getting confused.

> static ssize_t codec_reg_show(xxx)
> {
> 	struct snd_soc_pcm_runtime *rtd =3D dev_get_drvdata(dev);
> 	...
> }

We can probably kill this file now, everything is on regmap now.

>=20
> static ssize_t pmdown_time_show(xxx)
> {
> 	struct snd_soc_pcm_runtime *rtd =3D dev_get_drvdata(dev);
> 	...
> }

These ones will need a bit more looking at, they probably want to be on
the card using the card device I think.

--1EKig6ypoSyM7jaD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXmJFMAAoJECTWi3JdVIfQBnEH/0IS7/GObfcuu56346lBU+on
krZhUHd/kd4M+WbhLdhgBIsVno1VFM75Qlaw1hZJdh8Dx+suwPUNS1lnxA4l9SRx
N8Rq6ArL7U6JiNBO7jw6Fj+uCli4IE5uYOPm2MUMMqrEnQpvXCbUd7P3B2B0zmJ9
UgEU4nPdRr0zq9giMNVV4NdUYdgHtpp0SGe32Vp6sRE8VPRumAYmIpoVaOYU+k54
UrEsY1q7CO1aVwrBDAIhZjyDjYNrMsk/D+yQdNLDV8iq44QBhOzhOpQaWGNVVm/a
yusMvmbQpP0QrY1Wvg4SRP/MADyLhfCFuoNFsezYTOaSnD0LU07Z9++dMSQWMEc=
=g/hZ
-----END PGP SIGNATURE-----

--1EKig6ypoSyM7jaD--
