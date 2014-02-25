From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [alsa-devel] [PATCH 2/4] ASoC: simple-card: dynamically
 allocate the DAI link array
Date: Tue, 25 Feb 2014 09:02:49 +0100
Message-ID: <20140225090249.4e6cace9@armhf>
References: <cover.1392995566.git.moinejf@free.fr>
	<41aa7354a6883f31afa60c21c2e14ecbb3bbb7e9.1392995566.git.moinejf@free.fr>
	<397c6a465f424a3eb42ead8f1e55f7d9@BY2PR03MB505.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <397c6a465f424a3eb42ead8f1e55f7d9@BY2PR03MB505.namprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Cc: Mark Brown <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 24 Feb 2014 03:32:02 +0000
"Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com> wrote:
>=20
> > @@ -20,7 +20,6 @@ struct simple_card_data {
> >  	unsigned int daifmt;
> >  	struct asoc_simple_dai cpu_dai;
> >  	struct asoc_simple_dai codec_dai;
> > -	struct snd_soc_dai_link snd_link;
> >  };
> >=20
> >  static int __asoc_simple_card_dai_init(struct snd_soc_dai *dai,
> > @@ -246,7 +245,9 @@ static int asoc_simple_card_probe(struct platfo=
rm_device
> > *pdev)
> >  	struct device *dev =3D &pdev->dev;
> >  	int ret;
> >=20
> > -	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	priv =3D devm_kzalloc(dev,
> > +			sizeof(*priv) + sizeof(*dai_link),
>=20
> This is okey for me.
>=20
> Well, how about splitting the *priv and *dai_link into two separated
> memory blocks? As we can get the dai-link pointer via priv->snd_card.=
dai_link
> in other places.
>=20
> IMHO, then the code will be much more simplifier and readable.

It is just a simple optimization: less calls to memory allocation and
less code (also, less TLB reload?). I will add more comments.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
