From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 10/14] dt-bindings: sound: Add sun8i audio
 card documentation
Date: Tue, 4 Oct 2016 18:32:29 +0200
Message-ID: <20161004163229.GR5228@lukather>
References: <cover.1475571575.git.mylene.josserand@free-electrons.com>
 <c317ce9f180a24611e79086944feca00d416b7b4.1475571575.git.mylene.josserand@free-electrons.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h1wVxq8aeHrvhZJz"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBHVTZ67QKGQEVFIDBNY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <c317ce9f180a24611e79086944feca00d416b7b4.1475571575.git.mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--h1wVxq8aeHrvhZJz
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 04, 2016 at 11:46:23AM +0200, Myl=C3=A8ne Josserand wrote:
> Add the documentation for dt-binding of the audio card driver
> for sun8i SoC.
>=20
> Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org=
>
> ---
>  Documentation/devicetree/bindings/sound/sun8i-audio.txt | 17 +++++++++++=
++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/sun8i-audio.t=
xt
>=20
> diff --git a/Documentation/devicetree/bindings/sound/sun8i-audio.txt b/Do=
cumentation/devicetree/bindings/sound/sun8i-audio.txt
> new file mode 100644
> index 0000000..2403983
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/sun8i-audio.txt
> @@ -0,0 +1,17 @@
> +* Allwinner A23/A33 audio card
> +
> +This binding implements the A33 audio card.
> +
> +Required properties:
> +- compatible: must be "allwinner,sun8i-audio"
> +- allwinner,audio-codec: must have the phandle of the audio codec
> +  ("sun8i-a33-codec", for example).
> +- allwinner,i2s-controller: must have the phandle of the DAI
> +  ("allwinner,sun4i-a10-i2s", for example)

You should probably have a link to the PRCM too, instead of relying on
the name of the device in your card, which is quite fragile.

Also, I'm wondering, shouldn't all these nodes be part of a single
MFD? They share the same address space (even though it's split
nicely), the same clocks, and really are just one big device. Chen-Yu,
Mark, any opinion?

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

--h1wVxq8aeHrvhZJz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX89mdAAoJEBx+YmzsjxAgkAIP/2djagaL2twRMaHwJ5ApV6uo
Dt3DdjLOG8zgNHdN0MWV8jfotG7UnMwlk5paFMUG+hv4UH9GwjopiKd81bORZNW4
fBDjCCspPHp7UaJC56Ij8i+D+HFEahRFbxvhnkds9/00Rlz4x0cq9GEuPwa9XiiV
xxwJo8aJ7ULpSCCtJfotIIPBzabIGU++zok+NsdtjhtO0sUw2pmh+orVY+skMHyT
KKPzWzWk7Cf345AKwgzQvw1QLHj9cPEQFyy3rnZX2ceXJA9qkvP7GQFuCa+7Fz2h
23tqt3iEaHBPsMVFit2WV+PLxuIwrHcQanaROF4TTMcC9m0TxvUOk2GexBHI3D34
nOdK8/i8yOrKeC8kDW5oVQ9NkWHPvoMqktNLwOhoOSXyvUDoVqHWLFZjXnhw8nvB
DTa/motexRjwdz7dZIVv8Q4In7ZFPTTCsfEtGADlEkGMM/pICJbyiZRcmwEHICsf
I/k83ubjbv2bQFHWEDC4C8g96S/oUMw4mD/6aCHYeWe3EdyRHA3JNub5QwJ4lKFP
O+3qAbN884JEg5owuODPJtV4DcKWjbXZ1Vo4tvrXk0pAO/6mDFIedOnxbFsgwpNx
6H5XNb0wCt25U83gwzS8LVC44IFOeYDzyfb9okgE6pA8jG7EczC+F4LK/dyEnlDN
TUvCZzVYKY0CaxlK9OI8
=Wubi
-----END PGP SIGNATURE-----

--h1wVxq8aeHrvhZJz--
