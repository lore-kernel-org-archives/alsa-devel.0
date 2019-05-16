From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: cs42xx8: Add reset gpio handling
Date: Thu, 16 May 2019 05:50:22 +0000
Message-ID: <VE1PR04MB64791493BF55A587AD10B267E30A0@VE1PR04MB6479.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "brian.austin@cirrus.com" <brian.austin@cirrus.com>, "Paul.Handrigan@cirrus.com" <Paul.Handrigan@cirrus.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark

>=20
> On Mon, Apr 29, 2019 at 10:46:03AM +0000, S.j. Wang wrote:
>=20
> > +	cs42xx8->gpio_reset =3D of_get_named_gpio(dev->of_node, "gpio-
> reset", 0);
> > +	if (gpio_is_valid(cs42xx8->gpio_reset)) {
> > +		ret =3D devm_gpio_request_one(dev, cs42xx8->gpio_reset,
> > +				GPIOF_OUT_INIT_LOW, "cs42xx8 reset");
>=20
> You should just be able to request the GPIO by name without going
> through of_get_named_gpio() using devm_gpio_get().
>=20
Will send v2.

> > @@ -559,6 +577,7 @@ static int cs42xx8_runtime_resume(struct device
> > *dev)
> >
> >  	regcache_cache_only(cs42xx8->regmap, false);
> >
> > +	regcache_mark_dirty(cs42xx8->regmap);
> >  	ret =3D regcache_sync(cs42xx8->regmap);
> >  	if (ret) {
> >  		dev_err(dev, "failed to sync regmap: %d\n", ret);
>=20
> This looks like an unrelated bugfix.

Will separate it to another patch.

Best regards
Wang shengjiu
