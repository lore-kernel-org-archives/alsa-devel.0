From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 04/10] ASoC: sun4i-i2s: Add quirks to
 handle new compatible for reset
Date: Tue, 17 Jan 2017 17:47:22 +0100
Message-ID: <20170117164722.yohrxvlempkjldu3@lukather>
References: <20170117140230.23142-1-mylene.josserand@free-electrons.com>
 <20170117140230.23142-5-mylene.josserand@free-electrons.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bsjsst4jgd4saubz"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBJEV7HBQKGQESWJAC3I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20170117140230.23142-5-mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--bsjsst4jgd4saubz
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 17, 2017 at 03:02:24PM +0100, Myl=C3=A8ne Josserand wrote:
> Some SoCs have a reset line that must be asserted/deasserted.
> This patch adds a quirk to handle the new compatible
> "allwinner,sun6i-a31-i2s" which will deassert the reset
> line on probe function and assert it on remove's one.
>=20
> This new compatible is useful in case of A33 codec driver, for example.
>=20
> Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org=
>

Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--bsjsst4jgd4saubz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYfkqZAAoJEBx+YmzsjxAgXG8P/2tSaQNI7pYK5hKBqBy+DXKF
wgiyEJJfvFSNXL6+kHgY/iUzraZuzitMqiJsGat+VX0vvB5Kh6QsPGq9u/YuOoeA
WQZG3kszPlaMnkLSsKoAyFClESAZrV0P/kwSc6p/aJYzXWiLlVH/tfmmlelmJf9i
YxqOp05yG/ADeSubiIVDdMspn0huuz2aUiT5PPfWqy0kNABD0rKPOefqvPstHIHQ
RBXQhVu+JpjqlmxcascAee4KJuQWTp3NbDDCtDUi7HBXTF2zPEcg8T45BHV07mat
WIQrbsOp0SY5nHWHgxailcb74D7iLnp/U630qgVbz6EsGqn4pb0568xhDCN8Zc2I
ErrMpEMHo/f02V47TeBeAqTMuRE9cjVxWa7wnnfu3LK8BcSn482xo7cRm6awzNtM
p09JwPbzF3X1TePDQn/F+/28Hmek9DuiguvlHver7dc38JVV+aNzofu3h7HEGv5/
hdd9WM9s5Jh/zAHfqD7ueKov9BeS1b37s4zkkVJk39R/VMtnQPkHCzMPqIizUwl8
u44c+MGEUIMvXcq1XxEBDkWNbLit/x4XZgPSPNHcxjyEdyvdU3nWscCuXYcYo6Pv
QXLFG2EtwAIX2z096JRbHGey5K/Hhm+dh8KXi9yHOgSjOhvKoqNaeCv9BMSRZ2Gf
finOAdgqDqtqQDFQ0Bn3
=/Zyc
-----END PGP SIGNATURE-----

--bsjsst4jgd4saubz--
