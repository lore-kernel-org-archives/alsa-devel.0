From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 2/8] ASoC: sun4i-codec: Add support for A23 codec
Date: Fri, 25 Nov 2016 13:57:54 +0100
Message-ID: <20161125125754.ixgtbm5zyztedl7o@lukather>
References: <20161125123442.28410-1-wens@csie.org>
 <20161125123442.28410-3-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ti5tagvt4l46rhoc"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161125123442.28410-3-wens-jdAy2FN1RRM@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mylene Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--ti5tagvt4l46rhoc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 25, 2016 at 08:34:36PM +0800, Chen-Yu Tsai wrote:
> The codec in the A23 is similar to the one found on the A31. One key
> difference is the analog path controls are routed through the PRCM
> block. This is supported by the sun8i-codec-analog driver, and tied
> into this codec driver with the audio card's aux_dev.
>=20
> In addition, the A23 does not have LINEOUT, and it does not support
> headset jack detection or buttons.
>=20
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--ti5tagvt4l46rhoc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYODVSAAoJEBx+YmzsjxAgaY4P+wX2hoxGhBH25/BLpz0kN87I
9YbwUtHBueEHdp6uGEu8qfPa8eq+NlBbxKQcb5sRCMrBheYj/uctqUrq6fT1MBkH
UOfeztsSIIfKK7DXGp9Sf3Cywv2Y5lxNqZkjPGmuUbxUyYH/bgk3wst5Hta6BB6t
ewM4Ht54ggdYh/qMTeg2FcjYJdJDwg45mbYrr0y/QduZGpjxHDbqjuwBtagPI1gA
kwhIEsxUirt4lgUnKHEeyibMG7kYf/FK0se8mGM6idGFxt80l17TVTrf+TF+9KMF
BER0hm84J25kch9MO8YTFkwjIQgjv9XlZjMysntK4/X1faS27FPLn8xzQ4daA3gn
7huxvzKEjEXHewi0whLU0YxMNurtKPifl+SakKJy8YSZ6utZlwORgI5eYJq34NOH
dDgmGxe3gfGS79/VSKrSg/XbxwraznF+WFMb1YklUkvNr7ipwCMMUGeOQJSmY9Iy
+/Ual85+ZfDHrwWL2tCshPwXXCuWefxheCNfwZQ3+JsqnesRsC8ImjgeMBJRA43k
me9Vkzwov9qhLijk8hvGtSFgSfVMA0364tVFZVsflt15RAv0K1AhmFQRHjIAQMmZ
egD6fo/aPc1yIl7EFymvSwnqzFKdGz5L1xH0HVXwhJtE+Q5f7QLkNRFGdhl6tOhM
0rrTAx2HzFyj9zVGRn3o
=9cC0
-----END PGP SIGNATURE-----

--ti5tagvt4l46rhoc--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
