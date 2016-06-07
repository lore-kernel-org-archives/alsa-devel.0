From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] ASoC: rockchip: Add machine driver for
 MAX98357A/RT5514/DA7219
Date: Tue, 7 Jun 2016 11:47:11 +0100
Message-ID: <20160607104711.GR7510@sirena.org.uk>
References: <1464267742-15312-1-git-send-email-zhengxing@rock-chips.com>
 <20160601144542.GA3835@rob-hp-laptop>
 <5751912C.6080904@rock-chips.com>
 <20160606235026.GP7510@sirena.org.uk>
 <5756363F.40208@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VdnGiXwuH6t1Tqzo"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5756363F.40208-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Xing Zheng <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--VdnGiXwuH6t1Tqzo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 07, 2016 at 10:49:35AM +0800, Xing Zheng wrote:
> On 2016=E5=B9=B406=E6=9C=8807=E6=97=A5 07:50, Mark Brown wrote:

> > It should probably be three compatibles, one per CODEC, if the driver
> > needs to handle each separately.

> Do you mean like this:
> --------
> sound {
> compatible =3D "rockchip,rk3399-max98357a-rt5514-da7219";
>=20
> dailink-0 {
> compatible =3D "rockchip,rk3399-max98357a";
> rockchip,cpu =3D <&i2s0>;
> rockchip,codec =3D <&max98357a>;
> };
>=20
> dailink-1 {
> compatible =3D "rockchip,rk3399-rt5514";
> rockchip,cpu =3D <&i2s0>;
> rockchip,codec =3D <&headsetcodec>;
> };
>=20
> dailink-2 {
> compatible =3D "rockchip,rk3399-da7219";
> rockchip,cpu =3D <&i2s0>;
> rockchip,codec =3D <&codec>;
> };
> };
> --------
> Above, the machine drvier will handle them. Please correct me if I
> misunderstand.

No, that'd be one card with all three CODECs on the same board which I'm
guessing isn't the intention?

--VdnGiXwuH6t1Tqzo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXVqYtAAoJECTWi3JdVIfQEnUH/jYkld4xArmLDUmrUa4dE8po
flWubc26O/KP8rlBo9SRxNpzwZnL7Ptb7ROX44tbD3pR5L/uCx8zadyYOtk4C8mt
jKvj/1jBSqbiK4ZAP2wYvqjybbWLM8gvfrbcDUT+b87LkfHTUvHvGH9Mt4IY3Azd
6LR4755eK0niT/oIcZ8t+KQnij7bpgX40tvd3brmRfFOW9jvpzZUrdrKYgZ1z0Oy
IVuN23Z1Ml4lS02ROsVZJ9jHUG7Vv8YipErWqFnxLGHnumn0XrIQf6gP3hapQB1g
yOQ2uU8uM5iGZLJEpTGAE/UqWtXP7FRdtHNO2EEWT1LJSb5RTwMRVocFE/wGONs=
=7Caj
-----END PGP SIGNATURE-----

--VdnGiXwuH6t1Tqzo--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
