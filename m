From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 02/10] clk: ccu-sun8i-a33: Add
 CLK_SET_RATE_PARENT to ac-dig
Date: Tue, 17 Jan 2017 17:44:15 +0100
Message-ID: <20170117164415.4qseqbqkdx3e6bvt@lukather>
References: <20170117140230.23142-1-mylene.josserand@free-electrons.com>
 <20170117140230.23142-3-mylene.josserand@free-electrons.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pmqdesejeydvn5wu"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBB2UT7HBQKGQEE74QWGI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20170117140230.23142-3-mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--pmqdesejeydvn5wu
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 17, 2017 at 03:02:22PM +0100, Myl=C3=A8ne Josserand wrote:
> The audio DAI needs to set the clock rates of the ac-dig clock.
> To make it possible, the parent PLL audio clock rates should
> also be changed. This is possible via "CLK_SET_RATE_PARENT" flag.
>=20
> Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org=
>

Please make sure to look at the prefixes usually used in the commit
titles of the area you're working on. In this case that would have
been "clk: sunxi-ng:". I fixed it, and applied.

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

--pmqdesejeydvn5wu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYfknfAAoJEBx+YmzsjxAgod0P/iLJ4CE330NecTUFveMfjllK
4vMqgy3dk0q4bHjEkwf08C5leqCmNCc0w34eXMp3NbCWn2xxvGlsRvBgvXK1Gykj
Y9Fj4Mo1mWENQjgePb1HG8uNfxb77nsq5txtBHEukZXJTyCgoQ6KeroFX8bAkcMX
lwQngZ4WDNOpB7MqINSyFQu8jU+PQU3pai0hxnI5mZeqkpSLhYS/tDBSzlr8qFwv
xPDqX41KQKPhxpUBMF0D3d5auZS/fL2cg0ny5VXFdmMlbPzvsEduEkP5twBEQP4D
PZlMYtoZ9ynk1Nv6SSw8GTCblHRGSDPaXhSCz3zw8RMoWrNZ/Jt5cUlPm6WjMz2x
okrDyZxbydkXmQMTHRyJqzEIfUEtP3bOXabdqgWuai7KHAdDn6Bk9+GmKfKFqt+a
VpHRyoD80homLb/T7EMO5Ce8CRlw2KDrB4q0AwrLoYtCVs3GaimK4LXJG7myXDMr
bzqjZC98zY9vIFmUQ8vramSKzSvG/+EfLt2ATTehWwXzDCC5u6hMJrR3fJi69v7/
UzTg9YtcZ6dV4PwpaRAQkoDjvnxCEL4/LW59vKmFg4R+lWdkHooRkFFb5fL9+qwM
BSrWlgsYBw5itfEwrK6frU14yLwkuFL+gAn8aLSSjhIXx5zC3FWIGdPurd95VYeM
Xi/mRrfsbCwHibR/bfWY
=c6v5
-----END PGP SIGNATURE-----

--pmqdesejeydvn5wu--
