From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 06/14] ASoC: Add sun8i digital audio codec
Date: Tue, 4 Oct 2016 15:07:27 +0200
Message-ID: <20161004130727.srmaielkvd2z5k3s@sirena.org.uk>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com>
 <85cbd9926e52d0aa03f6bbfd8794373d8db491e0.1475571575.git.mylene.josserand@free-electrons.com>
 <20161004144008.0d07d18c@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gpztr7jxwopd7ip3"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161004144008.0d07d18c-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--gpztr7jxwopd7ip3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 04, 2016 at 02:40:08PM +0200, Thomas Petazzoni wrote:

> > +/* CODEC_OFFSET represents the offset of the codec registers
> > + * and not all the DAI registers
> > + */

> This is not the proper comment style I believe for audio code, it
> should be:

> /*
>  * ...
>  */

I don't care, IIRC that's something from CodingStyle which checkpatch
moans about.

> > +	/* pcm operations */
> > +	.ops = &sun8i_codec_dai_ops,
> > +};
> > +EXPORT_SYMBOL(sun8i_codec_dai);

> This EXPORT_SYMBOL looks wrong. First because it doesn't seem to be
> used outside of this module. And second because using EXPORT_SYMBOL on
> a function defined as static doesn't make much sense, as the "static"
> qualifier limits the visibility of the symbol to the current
> compilation unit.

Also all the ASoC code is _GPL so a non-GPL export is an issue.

> > +	.component_driver = {
> > +		.dapm_widgets		= sun8i_codec_dapm_widgets,
> > +		.num_dapm_widgets	= ARRAY_SIZE(sun8i_codec_dapm_widgets),
> > +		.dapm_routes		= sun8i_codec_dapm_routes,
> > +		.num_dapm_routes	= ARRAY_SIZE(sun8i_codec_dapm_routes),

> I'm probably missing something, but in the sun4i-codec.c driver, those
> fields are initialized directly in the snd_soc_codec_driver structure,
> not in the .component_driver sub-structure.

We're in the process of pushing everything out to component level, this
update should be made in the old code if it's not happened already.

> > +	if (clk_prepare_enable(scodec->clk_module))
> > +		pr_err("err:open failed;\n");

> Grr, pr_err, not good. Plus you want to return with an error from the
> probe() function.

Also when printing an error message use dev_err().

--gpztr7jxwopd7ip3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX86mOAAoJECTWi3JdVIfQBN0H/0hEvPxnDY3IJcUtpnC9qVeb
ykmKv1gtF/m9M9peXqqorRFZ4in1OwHeyU6vUY0+5bDtq9B9g9V2TYad1Ur1R4nF
7KzqnCxa2XPoqDTGz3pkPsVeLNQjFA39IW/fBqu7MOpK6FZ+neXgfrwBzG81XRzQ
J6/mqeiDi8yygUZqIW0jsthmq0Q0LbpIPJDk6gbT2D5SE+aRJftB4vxdQal6DQPw
wn8kYDdcbnlAwiivzJFmKJuRvSLgcUr9+ab6K4cmWXqfeVaZXvQLaCmBxP13Q5mD
eW5OGleZ28Sprjsp/0DlGF6uAseZAOzCEBIOvJQKj9q8RmHa2ZEcatADMP1pNak=
=PoB3
-----END PGP SIGNATURE-----

--gpztr7jxwopd7ip3--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
