From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [linux-sunxi] [PATCH v5 2/7] ASoC: sunxi: Add a simple HDMI CODEC
Date: Thu, 27 Oct 2016 19:36:17 +0100
Message-ID: <20161027183617.GR25322@sirena.org.uk>
References: <cover.1477142934.git.moinejf@free.fr>
 <5cb540f20f64d28bd7dee82a0e14ee5209631979.1477142934.git.moinejf@free.fr>
 <CAGb2v67cE8v3=XtTzDBst2D2U6wM8pffQYK9nEok+j4xnPT39A@mail.gmail.com>
 <20161027191634.f2fa6478cd07d84a60274339@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JKGvNdIvrY8Ovf7Z"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161027191634.f2fa6478cd07d84a60274339-GANU6spQydw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--JKGvNdIvrY8Ovf7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 27, 2016 at 07:16:34PM +0200, Jean-Francois Moine wrote:
> Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org> wrote:
> > There's already a driver for basically the same thing:

> >     sound/soc/codec/hdmi-codec.c

> > You use it by registering a sub-device from your hdmi driver, with the
> > proper platform_data and callbacks. Grep for HDMI_CODEC_DRV_NAME for
> > platforms already using it.

> I know that for a long time, and I will not use it on any account: it is
> a gasworks!

If there are problems with what's there then articulate them and fix
them, don't just open code something separate.  Just open coding
something else without any articulated reasoning is not helping things.

--JKGvNdIvrY8Ovf7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYEkkeAAoJECTWi3JdVIfQKccH/2/WboztCOcwhKZjtIB2+m68
/Z5N1IM6U07rVVjsaeJs2HYUYomf8bIpKT6c6B2fPrUMGNn+gSZi0RNm0mHg/h7R
2KK/STeO3fjtwiajPIjQKrRGHjs9Tri3OODhTRbO3rDYnrYZr0uWwl4tgNpM76Bq
H6AvrLLuREwsvubbQUtQ3mSuArwwJd/fsG4qPg+LqyLqHkOD46HzRPwtk2R2sbnf
83DtVLhxko4TSKjvmkHIPgMVL81I4skG7kzlZPmAKSH+0/FcdhCY6KNp52JhBQxS
sFLFiO+Nxgf2BpJyWaX/ClkJs/qLGeG+iOIp3mBMBdGR1YHbHKLgBNbO9XPMrRk=
=haVC
-----END PGP SIGNATURE-----

--JKGvNdIvrY8Ovf7Z--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
