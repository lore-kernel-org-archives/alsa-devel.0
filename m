From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: Re: [PATCH v2 4/9] arm: dts: sun8i: split Allwinner
 H3 .dtsi
Date: Fri, 27 Jan 2017 22:10:29 +0100
Message-ID: <20170127211029.k5ylfhrreqfdn2iz@lukather>
References: <20170127190239.2MQaUuKh@smtp2o.mail.yandex.net>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7qkvjbcap2tkdxtz"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBRXOV3CAKGQEZT5YZCY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20170127190239.2MQaUuKh-ZlSS+R3Zzis0PDqKvflMoHmW9unr2Ajn@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Cc: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--7qkvjbcap2tkdxtz
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 28, 2017 at 12:02:20AM +0800, Icenowy Zheng wrote:
>=20
> 2017=E5=B9=B41=E6=9C=8827=E6=97=A5 23:55=E4=BA=8E Maxime Ripard <maxime.r=
ipard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Thu, Jan 26, 2017 at 11:48:54PM +0800, Icenowy Zheng wrote:=20
> > > - mmc0: mmc@01c0f000 {=20
> > > + mmc@01c0f000 {=20
> >
> > There's no point in removing the labels, and you can even use the=20
> > label-based syntax to reference them, instead of using the path.=20
>=20
> I think keeping a tree structure in sub dtsi file will make it more
> pretty and easy to use :-)

We're already using that syntax for all the DTS, so it won't be less
pretty than those.

And keeping a tree structure valid is not easier to use than, well,
not having to keep it.

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

--7qkvjbcap2tkdxtz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYi7dBAAoJEBx+YmzsjxAg2QUP/38ftxITIFgoKnTha63G7UyF
KWtervmBniGEWkJfekz6M97NmwQvd6Mk2xx0XCHrOpMsSprHAuBRdRIXc40JmcxI
TYg51vFnEZPKrJ9u89hLdqls99unJr4bJKl5Zjvn4c84VLBnClQNi8e/EU6wBJnc
BhvAvm3+NuoL/dK2mJos0K4rGY7Y+i6EldKQ2DqmfgRCrnOCs7d/uxpEkLfu2UK8
ltPCmAZyWXZdqa5EbqJVSMKSSZVvnIOCAQ8objjQuIb4V1k2vXiodVr/Zm/Ziv5S
kOc/KTgHy7YP2dODlybs5eYvke+oQ/QbomL3i1RxLedJEku9vRz75jnHyTonKLLy
oPTvZaoG3KNkipkPPyJVHxiA/WmTXUflqhk2gxnxjl7PSFlJelkRkTYu/l51vUwh
8B4caEI3mWsgmNOJy0NWWv7TfwkKEZ1eUrfSRWIENlrIRQE0rnAZ966h5RCNTGWq
NIGhSZ4/XlkOODGrCr0pwsA6duhT9ZecXbcHZHIAjt9tEgy1cGwdQbSjUOpFah/e
TKzO7AxHXF0OVXeCixtPg3RNMpfrPa7qmh7XF2X7RmHaNfuELnqPECCzc3vI952+
ZMGGjzZqJVckqyPiafTrv7WK+yytfN+7LEixcfcIdq8pGFeJhYxWgRx2AHKx6c5Y
pj/1bhisw8RGlDJgP3/r
=BJIC
-----END PGP SIGNATURE-----

--7qkvjbcap2tkdxtz--
