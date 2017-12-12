From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/4] ASoC: sun4i-i2s: Add support for A83T
Date: Tue, 12 Dec 2017 09:35:42 +0100
Message-ID: <20171212083542.aue7useyyqvuzohi@flea.lan>
References: <20171212081148.9194-1-wens@csie.org>
 <20171212081148.9194-2-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5cktilogsmwipqzf"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171212081148.9194-2-wens-jdAy2FN1RRM@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--5cktilogsmwipqzf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2017 at 04:11:45PM +0800, Chen-Yu Tsai wrote:
> The I2S controller in the A83T is mostly compatible with the one found
> in earlier SoCs such as the A20 and A31. While the documents publicly
> available for the A83T do not cover this hardware, the officially
> released BSP kernel does have register definitions for it. These were
> matched against the A20 user manual. The only difference is the TX FIFO
> and interrupt status registers have been swapped around, like what we
> have seen with the SPDIF controller.
>=20
> This patch adds support for this hardware.
>=20
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>

Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--5cktilogsmwipqzf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlovlNoACgkQ0rTAlCFN
r3SSTQ/+Py1vwc32cgv+UFH3H+n/3UDaoKTDYev1PUeqXlHMQzsrf9/+aYvfwF9m
GNPiH0OJzcIG1qtxGCKF14xBGy9ZjwJK9NryrqQ5xOL9zWR1rsj+DDLpXXpT2cQo
er2/4WF85dXMCWZj+6djL3uYD+MwTPDPYw932db7f/qlTro6OwrYTi6Ee9+Hdqtd
/pGUnsT/6YIQaJ8jDsvALW2tDy75kQUjtcL1ewZZnYuM+qsX2EQ+LNJZILg8a+F3
US5e8Occ6n71dnLeMwA4DR1yX8FTycFSuqidXeHcmwOVOkd8mXkVa6K1LCVlKILt
MakEzqnVT+tfgF5+IeApdRwKuI1l+QSeNyiv5V5VuEXPltzWjNCxvZtlN2hnl9hV
XGZC6CptlQ8YfBmHZR6YAn724bsiVS5dPv2XWYyVjWzrCJaI008LpGIisVypa7c5
aWq6p65RJGZpQxfbiquGA9tSgMq7zPXpErgh3KwkvLjekYOuQhc7+0RN9g0+cN+y
20DisNvS2Ek/ndbtxLQ0C7Xm+pTL3NUgyp+eZq0kzb0lkpTwnQAODL4r7hMRMZjq
je5auTtG1n/J+rsKQY/mNMIfS/p1gFRn+gg9xYx5RxP9s2kslk48v6dx+UcFgnAe
KfLy4aP1OvTlbBkgraky4dn4fY0r6qoBt3ObiUkfdk7MoS3kea8=
=6BXs
-----END PGP SIGNATURE-----

--5cktilogsmwipqzf--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
