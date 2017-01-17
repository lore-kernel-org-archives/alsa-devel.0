From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 01/10] ASoC: sun4i-i2s: Increase DMA max
 burst to 8
Date: Tue, 17 Jan 2017 17:41:11 +0100
Message-ID: <20170117164111.76mefaj32fy64f7o@lukather>
References: <20170117140230.23142-1-mylene.josserand@free-electrons.com>
 <20170117140230.23142-2-mylene.josserand@free-electrons.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2gweboskz7ujobya"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBMUS7HBQKGQEQYZMJWA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20170117140230.23142-2-mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--2gweboskz7ujobya
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 17, 2017 at 03:02:21PM +0100, Myl=C3=A8ne Josserand wrote:
> As done previously for sun4i-codec, the DMA maxburst of 4
> is not supported by every SoCs so the DMA controller engine
> returns "unsupported value".
>=20
> As a maxburst of 8 is supported by all variants, this patch
> increases it to 8.
>=20
> For more details, see commit from Chen-Yu Tsai:
> commit 730e2dd0cbc7 ("ASoC: sun4i-codec: Increase DMA max burst to 8")

Those details could have been included directly in the commit log.

Otherwise,
Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Thanks!
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

--2gweboskz7ujobya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYfkknAAoJEBx+YmzsjxAgPaIQAIK/zBjeQja/p8TCOIYY/Q5P
k6tBGE8os+KjiXv9tJq+MX8p+8423SGlQ0VsRhMb1dNwyr7Qs95HBdBwFv4GyAj2
Zo7EXeR8s5VQiNTYWxYA+d5VCwgAvByhMDffchYa0/3IiEb1VnBpeuASOvWxmk5J
9+eeT3ozYi7gRgvCdZ9ZQpX/itG7sIFaydmrc/NfEz9WfyWGXx0JHz/8a4f6+h/i
NsXEJplTf8mtAFyDnPYZ9xoCzPBvvfeAP680zACN8lR+fvq9qlZcSYei84QnvGHn
tLy5iZeaF5g6MhHS9B88ImfBEQC3lzkEFBio539yKlR2yCQNv1Ogh5qmnzWFpc5E
YNOcIy5mtiwREY+Si+qG1exO8CXOsCNM6ny1CI+xcVBSBvW5Jk4gvMaOpwAZqRmQ
2af8htLvl63gThRRy4nKcncDPQPXDoigTQdVfrhk2TECduEU5o7kUXzS5Qk0HGI0
9HFtZ//U/S6sRlRuYXtl8ey9PNk4KfAnVMExj9nrfW1H38togDxpLQi8C5Pp4M72
iQkkOOv7noWqlPcIKm0YeotLJ3iya75/cHst3+7jNmdAPqCnd3yWkqizzA8mxuZI
4gm9JC3BfcRws218k2Icm8aBVUqolYnRzxZp/Tkv4U2pqpveFx1dHsNoFFIUNMIt
iE7xdIM/mUO6jW83Qc8G
=3lxr
-----END PGP SIGNATURE-----

--2gweboskz7ujobya--
