From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RESEND v7 2/3] ASoC: add es8328 codec driver
Date: Thu, 10 Jul 2014 14:55:18 +0200
Message-ID: <20140710125518.GG30458@sirena.org.uk>
References: <1404353989-19580-1-git-send-email-xobs@kosagi.com>
 <1404353989-19580-3-git-send-email-xobs@kosagi.com>
 <20140709094527.GA21251@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j6Ejlva3tMw3xXYi"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140709094527.GA21251-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Nicolin Chen <b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bunnie-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--j6Ejlva3tMw3xXYi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 09, 2014 at 10:45:27AM +0100, Charles Keepax wrote:
> On Thu, Jul 03, 2014 at 10:19:48AM +0800, Sean Cross wrote:

> > +static int es8328_codec_probe(struct snd_soc_codec *codec)
> > +{
> > +	struct es8328_priv *es8328;
> > +	int ret;
> > +	int i;
> > +
> > +	es8328 = snd_soc_codec_get_drvdata(codec);
> > +
> > +	for (i = 0; i < ARRAY_SIZE(es8328->supplies); i++)
> > +		es8328->supplies[i].supply = supply_names[i];
> > +
> > +	ret = devm_regulator_bulk_get(codec->dev, ARRAY_SIZE(es8328->supplies),
> > +				es8328->supplies);

> Is it safe to use devm_ from the ASoC level probe here? I think
> there was a discussion recently that this can cause problems on
> driver unbinding.

No, it's not and there's a much bigger problem here that we shouldn't be
doing resource allocation in the ASoC level probe().

--j6Ejlva3tMw3xXYi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTvo0rAAoJELSic+t+oim9c/YP/RcpnvP6BP/RlMb12WAyZczo
ROORQCSf0amwSqFHb0vInmWLxAex+xgBwma6rN/8wjzhFVbH496Efuwq/Me5qw5y
50RQAB6+hWtCwWAYQXOW/ZfiA/lBDo2s894SfjljF0CEZLhHnJMpM2K3OB+OqsJ6
IMUafmfPj11YpPdfTsas8wSi8bH55HdaIPi02FVYQFR/l+i4McOo0cxR0gwjswz8
H7JuvISyPDonr1HXL2mmr5nDMP84GDsM6AXzz69YZ+uLTv5byOq3fdgpnMItuvwh
DaUmeM30A3P6ZaYNZYa+yfrZMzFhzSE6s7/SK37/x7EcJI/xPKqLRtmRJImn/KP2
OtvqIOzzpyenV9YjRdpDdSnujFDw15YPc98tYztr4jFTFX1uzWeR3mQl0sslsP3T
xI2gzGg5tos+KORfH6DwcpPMz5dOdyGIIT5WIE03uvjZUxpCHfOSdJo8Ul3f3u5M
Sy3ZpXaJoSHlzzvNWCUBge/ECfndHkSCz+bBdpkAUZErJZ4RQNzvkuw2gTWDOGpV
BKlEjji1KpIKLHG/kw6xR7pF7PAcoDAThrPppqWMfWyeEfHs/xn4thNmKKKRduKI
lxnTbZJgS3Fe/pCBiFRbyk1xbgayvXWsn+GEuJX1QSMwhrE+7DVNWUJsf9ZD/103
SY6zf1pJ6giO0evCFCzv
=OAQ9
-----END PGP SIGNATURE-----

--j6Ejlva3tMw3xXYi--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
