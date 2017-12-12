From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 4/4] [DO NOT MERGE] ARM: dts: sun8i: a83t: bpi-m3: Enable
 PCM5122 codec with I2S1
Date: Tue, 12 Dec 2017 09:35:21 +0100
Message-ID: <20171212083521.cpvbirnimaip7kjf@flea.lan>
References: <20171212081148.9194-1-wens@csie.org>
 <20171212081148.9194-5-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c67puyatkrglxrq4"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171212081148.9194-5-wens-jdAy2FN1RRM@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--c67puyatkrglxrq4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 12, 2017 at 04:11:48PM +0800, Chen-Yu Tsai wrote:
> This patch enables a PiFi DAC+ V2.0, which is a PCM5122-based audio
> output DAC add-on board for the Raspberry Pi B+ and later, connected
> to the GPIO header of the Bananapi M3 via jumper cables. The power,
> ground, and I2C pins are in the same position, but the I2S ones are
> not.
>=20
> The I2C controller used is I2C2, while the I2S controller is I2S1.
>=20
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> ---
>=20
> I'm sure I've asked this before, and IIRC the answer was yes: The I2C
> controllers available on the GPIO header all have proper, always-on,
> external pull-ups. Does that mean we can enable them by default, seeing
> as they are likely intended to be used this way (as I2C pins)?
>=20
> I think we have a few boards where either I2C or UARTs on the GPIO
> header are enabled by default.

The consensus we reached that we would fill the nodes, but leave them
disabled.

In this particular case, I guess it would help for the i2c controller,
but not for the i2s one.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--c67puyatkrglxrq4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlovlMYACgkQ0rTAlCFN
r3QFEA/+J0ivMcOs02i9x90FRijubeh9qx6L0hmX9rBDTaSjo6ch/1MrkijcJg10
rJGo9V3hZ9q2pQ/bcn8VSQ86WM47Qrg/068ivAFBHarIChMuI2yc41qhtItwE2zz
lNF7JYfM61N/LQMg6pRBr9mmD9Mlpv98jFkvYsqoHnZ4dwsPXxXYf4NJmHVTnVCn
riiynNl5+J1UO8ArNtReVi9uwCgfe/DNSXrfA6k9foY9mEa0yFOiv66SyuO1nbhw
ThKaAgITMw6dklFy22hGqz1BYB+UEFK4LJ1vS4nlkUqwMXAROBN54x/OmCUZT+W8
p1l1mZJoHiVg7WuUOgbMD3ARqXJh7OG3vhYJcNxJwDwjJK92v1U0iIQQStyyLnZY
UywMRIMJ3ivm/y1FUy54Vatw2K3cHE/RvWnvmvokXawnqDVinqLWPEZyNhMAYlPu
CK6eyJVp5guJhNP6CYrYwfM9TBVt87pnyd0JNy/ccZ5gRdJw4vgUnnr/8XnXdGiH
gKs9/r1dyg2Yr6T3CJfBBBMt07psdPOZzSJ+PggsVjyhMLu2sh+dLmLr8gsSucSK
6eUGmMY4wKMcxsbKWKY/SEX+4LmAd0KbNZJYpXK8OydI02AM6dhl63ziRZgyIHOr
+4cVwIKyzQUTIsE3T6tXgDvkkyssz6vswCuWi2WVpKAyq+v6yeI=
=DA38
-----END PGP SIGNATURE-----

--c67puyatkrglxrq4--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
