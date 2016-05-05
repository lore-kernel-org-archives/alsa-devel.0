From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/7] ASoC: rockchip-max98090: Fix DAPM unknown pin for
 Headset Jack
Date: Thu, 5 May 2016 20:20:10 +0100
Message-ID: <20160505192010.GM6292@sirena.org.uk>
References: <1462435421-21205-1-git-send-email-enric.balletbo@collabora.com>
 <1462435421-21205-6-git-send-email-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mzDsWmoYTs+XRn5Z"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462435421-21205-6-git-send-email-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>
List-Id: alsa-devel@alsa-project.org


--mzDsWmoYTs+XRn5Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 05, 2016 at 10:03:39AM +0200, Enric Balletbo i Serra wrote:
> The patch fixes the following error message.
>=20
>  rockchip-snd-max98090 sound: ASoC: DAPM unknown pin Headset Jack

>  	{
> -		.pin =3D "Headset Jack",
> +		.pin =3D "Headphone",

=2E..and makes automatic DAPM management of the headphone jack work.
Again, it's not just shutting up warnings it's fixing an actual bug.

--mzDsWmoYTs+XRn5Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXK5zqAAoJECTWi3JdVIfQQKQH/2QX36gfetQptFU+4DxpsIVw
12l4LukW48qDBO5Bxxp1MMSofYFu4Fl0iLmHY/3cWZ4kG/8YFImdRT7I8901A5mX
UdBJuU5bKQJke0/bAa2o8oxDjyLSXBv9QcPB0i1KK2f4ia7KdJRkkIBL666DV6mP
TbPcw8MUYxfj6CMKQ5yjpbiTvyci6sViag1I87aWSPCaae3o4Sm2p8qC/QGwkhCD
/lbRhNNKtQ83wfoAxAaSDzvykpVc1VCAnffzGSrroBIdazTYbgg68VHrETLt/xMo
25G1AlWumyI9PE25ZeJmknUOceRJLgeCTXqPpLRPVGc+esKaiex6+iGBmtIFnpU=
=5DoX
-----END PGP SIGNATURE-----

--mzDsWmoYTs+XRn5Z--
