From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/4] ASoC: sunxi: Add Allwinner A10 Digital Audio driver
Date: Fri, 10 Jun 2016 01:37:55 +0100
Message-ID: <20160610003755.GC7510@sirena.org.uk>
References: <20160601175430.11625-1-maxime.ripard@free-electrons.com>
 <20160601175430.11625-3-maxime.ripard@free-electrons.com>
 <20160602102651.GF2282@sirena.org.uk>
 <20160609210515.GI5242@lukather>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8V5qWCo32XWuTbWR"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160609210515.GI5242@lukather>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrea Venturi <ennesimamail.av-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, gianfranco-25KmuZRQ+wx0ubjbjo6WXg@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--8V5qWCo32XWuTbWR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 09, 2016 at 11:05:15PM +0200, Maxime Ripard wrote:
> On Thu, Jun 02, 2016 at 11:26:51AM +0100, Mark Brown wrote:
> > > +static int sun4i_i2s_params_to_sr(struct snd_pcm_hw_params *params)
> > > +{
> > > +	switch (params_width(params)) {
> > > +	case 16:
> > > +		return 0;
> > > +	}
> > > +
> > > +	return -EINVAL;
> > > +}

> > The switch statement here and in the _wss() function look weird because
> > they don't have default cases.  Since there's only one user of both
> > functions it seems better to have the switch statements inline anyway.

> I don't know, maybe it's just me, but I really find it cleaner that
> way, and the compiler will probably inline it anyway. If you insist,
> I'll change it though.

Yes, it's really not helping here.

> > > +	for (i = 0; sun4i_i2s_mclk_div[i].div; i++) {
> > > +		const struct sun4i_i2s_clk_div *mdiv = sun4i_i2s_mclk_div + i;

> > Why not just write these as normal array lookups?

> By normal, you mean using ARRAY_SIZE()?

array[index].

> > > +static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
> > > +{
> > > +	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);

> > > +	/* Enable the whole hardware block */
> > > +	regmap_write(i2s->regmap, SUN4I_I2S_CTRL_REG,
> > > +		     SUN4I_I2S_CTRL_GL_EN);

> > Runtime PM?  It also seems like this is something that ought to be
> > covered in the suspend and resume callbacks.

> runtime_pm is supported, and uses the regmap cache to keep those
> changes.

No, my point is that I'd expect to see the block powered off on suspend.

--8V5qWCo32XWuTbWR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXWgviAAoJECTWi3JdVIfQtswH/jeHY9+bWRXu9FDKJbcVCVtk
pgHCTE2f4JoXn7NqFdlihh2Om0rfviwhXymbiYlQ0ql2EoZp+16BqtRFZTSViee+
2A7x72JLr/SNVy2XVUElzYHmsfRyu0EemCpEE7aPSFj9JphbOZpTT1IqJH2pfzaA
04SUAoO+F/sQryZRI796GEHDk+qLPWWkXL596lRX2kXbV64M2WKGIbyMiRVbnjzv
ZV9wpnARMOMe/+1brKvPregMx7tvOr0OIWnEpu/m2c0qiEhYcPr7sRpZA9gnpd/L
NNROg8T+dEh24+t/g8V2Pg5fyWI3mHvgipdiOn7N7AQCs0/hIhLDj6LrL2YMdr0=
=kmoV
-----END PGP SIGNATURE-----

--8V5qWCo32XWuTbWR--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
