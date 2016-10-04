From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 08/14] dt-bindings: sound: Add sun8i analog codec
 documentation
Date: Tue, 4 Oct 2016 18:24:30 +0200
Message-ID: <20161004162430.GQ5228@lukather>
References: <cover.1475571575.git.mylene.josserand@free-electrons.com>
 <06ea14939405c3eb0fb9be655d26ee564a04a53d.1475571575.git.mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="p2u4WfPhYOuYlOsk"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <06ea14939405c3eb0fb9be655d26ee564a04a53d.1475571575.git.mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--p2u4WfPhYOuYlOsk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 04, 2016 at 11:46:21AM +0200, Myl=E8ne Josserand wrote:
> Add the documentation for dt-binding of the analog audiocodec
> driver for SUN8I SoC.
>=20
> Signed-off-by: Myl=E8ne Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  .../devicetree/bindings/sound/sun8i-codec-analog.txt | 20 ++++++++++++++=
++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/sun8i-codec-a=
nalog.txt
>=20
> diff --git a/Documentation/devicetree/bindings/sound/sun8i-codec-analog.t=
xt b/Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
> new file mode 100644
> index 0000000..a03ec20
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
> @@ -0,0 +1,20 @@
> +* Allwinner A23/A33 Analog Codec
> +
> +This codec must be handled as a PRCM subnode.

Like Mark was saying, you should probably reference the sun6i-prcm.txt
binding here

> +Required properties:
> +- compatible: must be either "allwinner,sun8i-codec-analog"

Our compatible prefix is <family>-<soc>, and using the older SoC that
introduced that block.

In this case, that would be sun6i-a31, I think?

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--p2u4WfPhYOuYlOsk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX89e+AAoJEBx+YmzsjxAg4vIP/A+feM0Z7SRv5eTtt5g+yqeA
RG/N/G1nJt32ENjJvDAMh67S5dUWLcb+4RsmdxfDkdQHjFBVxfCVINI/2/mxo1B2
0MdSlvMKvWgZsUFUzVpRf9Lmx7/u7zzljcK+z+vvF8mnLGfwB0a6T5j2JIzAWrrw
218qh4xkDJpwdxseKgqFAS/J0aH2j9cRU/woxk8mwGyFCMQiVrzKS0j0+I/sc8jC
BtTJPqOIEUCspqGQzg0mDIMsgMbdio23J1F5guOqs43BE9tDKCofaob2PACrVcvj
ze9IlAd7YnPUma3ijOCEO7iAkhpujq3SMDNMCWbwNIXzMfY7y0WD5nHEatxEERhQ
iYwi1z2TDtw9MLWVMGtCLQ6Go0V16OQhnOFPR0Ps2Wyv3gNWV11XrpDqLh1rDmdU
TpUQl4ows57z9jalbd7X7qhwd8G1ESpwA5iLHTnJ7Ec8cby5rkIPWdiXxy9k1pqX
TjAM4f6ALHeX/VV2z0u787PQt5skpsM7EHiLoklrsxDWTyF0VwtKtltC+VffTn7t
9cCLn6nOOcmMIcnrmZwAeccSCvPCnkrtSu1fRx3TutudpgkpUgXw2KUuOMhiTEs2
F4Yqwx6glIzmTQY0BNe+fmL8GqNpKPQ7st9htsUUVNtKOqX/BhsRlhZtdLMSmzGn
PPLgo4ehUi+6//MOCg6D
=3pp+
-----END PGP SIGNATURE-----

--p2u4WfPhYOuYlOsk--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
