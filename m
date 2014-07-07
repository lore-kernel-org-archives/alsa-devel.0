From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] ASoC: sgtl5000: Use devm_ functions
Date: Mon, 7 Jul 2014 16:58:24 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1407071655171.4757@hadrien>
References: <20140706070800.GA2927@himangi-Dell> <20140707144832.GL30458@sirena.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140707144832.GL30458@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Himangi Saraogi <himangi774@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, julia.lawall@lip6.fr
List-Id: alsa-devel@alsa-project.org



On Mon, 7 Jul 2014, Mark Brown wrote:

> On Sun, Jul 06, 2014 at 12:38:00PM +0530, Himangi Saraogi wrote:
>
> > diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
> > index 249fadb..0efd6d6 100644
> > --- a/sound/soc/codecs/sgtl5000.c
> > +++ b/sound/soc/codecs/sgtl5000.c
> > @@ -841,14 +841,15 @@ static int ldo_regulator_register(struct snd_soc_codec *codec,
> >  	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
> >  	struct regulator_config config = { };
> >
> > -	ldo = kzalloc(sizeof(struct ldo_regulator), GFP_KERNEL);
> > +	ldo = devm_kzalloc(codec->dev, sizeof(struct ldo_regulator),
> > +			   GFP_KERNEL);
>
> You're using the managed functions within the ASoC level probe functions
> which doesn't work - devm_ is only usable as part of the driver model
> binding and unbinding.  All this resource allocation needs to be moved
> into the device level probe (which is a better thing anyway) before it
> is converted to devm.

Nevertheless, there is already a call to devm_regulator_bulk_get in
sgtl5000_enable_regulators which calls sgtl5000_replace_vddd_with_ldo
which calls ldo_regulator_register.  That call was introduced by

commit 63e54cd9caa3ce03635810608519e2b37d8bc706
Author: Fabio Estevam <fabio.estevam@freescale.com>
Date:   Thu Apr 24 14:13:08 2014 -0300

It seems that that patch should be reverted?

julia
