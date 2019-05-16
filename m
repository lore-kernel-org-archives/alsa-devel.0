From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V2] ASoC: cs42xx8: Add reset gpio handling
Date: Thu, 16 May 2019 11:09:27 +0000
Message-ID: <VE1PR04MB64790C7A0C1C068503038FDEE30A0@VE1PR04MB6479.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "brian.austin@cirrus.com" <brian.austin@cirrus.com>, "Paul.Handrigan@cirrus.com" <Paul.Handrigan@cirrus.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi

>=20
> On Thu, May 16, 2019 at 06:04:58AM +0000, S.j. Wang wrote:
>=20
> > +	cs42xx8->gpiod_reset =3D devm_gpiod_get_optional(dev, "reset",
> > +							GPIOD_OUT_HIGH);
> > +	if (IS_ERR(cs42xx8->gpiod_reset))
> > +		return PTR_ERR(cs42xx8->gpiod_reset);
>=20
> You also need a binding document update for this.
ok, will send v3

best regards
wang shengjiu
