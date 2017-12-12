From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/4] ARM: dts: sun8i: a83t: Add I2S controller device
 nodes
Date: Tue, 12 Dec 2017 09:29:48 +0100
Message-ID: <20171212082948.xjlwksmkaqg22b3a@flea.lan>
References: <20171212081148.9194-1-wens@csie.org>
 <20171212081148.9194-3-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fhejbnoclb53vf5c"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171212081148.9194-3-wens-jdAy2FN1RRM@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--fhejbnoclb53vf5c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 12, 2017 at 04:11:46PM +0800, Chen-Yu Tsai wrote:
> The A83T has 3 I2S controllers. The first is multiplexed with the TDM
> controller. The pins are generally connected to the codec side of the
> AXP81x PMIC/codec/RTC chip. The second is free for other uses. The
> third only supports output, and is connected internally to the HDMI
> controller for HDMI audio output.
>=20
> This patch adds device nodes for the controllers, and a default pinmux
> setting for the second controller.
>=20
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>

Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--fhejbnoclb53vf5c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlovk3kACgkQ0rTAlCFN
r3T4Xg/+IYmB5nPT7S2Wm2NWF2ixzt9faM2Kfg3T37Y33zq8udlx3ILqZMLpU+tr
ti6Wnbg+if5l5ejhJ8rsxjUEir83DVIDkMbLl62PjAXOn8C10bPEIM5JU0zjrcVu
JQ0XqaYhV8wHo6JYpi09dk7LnV1agJS9P0dwQPXWiujaNRKnDUpdKBCyhG0mLuBt
1q5SGTa5Mq/V8jYp+Pco96Uhk5qEE0RuWoD+aHVqzmbLP/9q0iKnxUSwMbJW4eHR
d/AUbnHB8sNmkZt88yVfbnNBOnMuyX6PIC/NNC6Ofom2iUDOewGdg5eDpzPYSaX+
TzMLbZBF5DKMiYKCnOxG/y7KD//dd/TKbHwTEMvcD4zKzwnObhgQpbJPxxzS5TuI
RquCnyB9uBg1iwwVBkUQdCfZ/G1BU5oyflnxQ3H1QMDY/2Txa0XHJXRpFY7tfCPE
ZQ1gJxGdRZVIWf7OhthBjCLuqdpvI5Syz7J7hcnLbtvyihaawnOMjRAy3k3ORXcn
hdFeQeScu3ZJydnEmVfbHmxnr6a3g1306y2cRkr7jj/ydj9Fo40o3GbCvWcCpQXh
mxjJ+Ii03jupqdwVyPkJGqijcb2Xr+TTBLR4e8HDjh/OPHhagyyQxysZHd7ffA1y
+UeEtnHwpAH73oTM05vdzUjjyfD1b2sHeI6a2nlf/Uu9N+P0vWU=
=PipS
-----END PGP SIGNATURE-----

--fhejbnoclb53vf5c--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
