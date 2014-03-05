From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [alsa-devel] [RFC][PATCH 1/3] ASoC: core: Move the default
 regmap I/O setting to snd_soc_register_codec()
Date: Wed, 5 Mar 2014 01:32:55 +0000
Message-ID: <6957e65a46b94957a9192f1145f8a79c@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1393921529-28985-1-git-send-email-Li.Xiubo@freescale.com>
 <1393921529-28985-2-git-send-email-Li.Xiubo@freescale.com>
 <5315A203.2060103@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5315A203.2060103@metafoo.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


> Subject: Re: [alsa-devel] [RFC][PATCH 1/3] ASoC: core: Move the default regmap
> I/O setting to snd_soc_register_codec()
> 
> On 03/04/2014 09:25 AM, Xiubo Li wrote:
> > Add the default regmap I/O setting to snd_soc_register_codec() while
> > the CODEC is initialising, which will be called by CODEC driver device
> > probe(), and then we can make set_cache_io() go away entirely from each
> > CODEC ASoC probe.
> >
> > Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> > ---
> >   include/sound/soc.h  |  3 +++
> >   sound/soc/soc-core.c | 11 +++++++++++
> >   2 files changed, 14 insertions(+)
> >
> > diff --git a/include/sound/soc.h b/include/sound/soc.h
> > index 4c4d7e1..94bc1c4 100644
> > --- a/include/sound/soc.h
> > +++ b/include/sound/soc.h
> > @@ -749,6 +749,9 @@ struct snd_soc_codec_driver {
> >   	int (*set_pll)(struct snd_soc_codec *codec, int pll_id, int source,
> >   		unsigned int freq_in, unsigned int freq_out);
> >
> > +	/* codec regmap */
> > +	struct regmap *regmap;
> > +
> 
> Nope. The driver struct is globally shared between all device instances, the
> regmap struct is device instance specific. The proper way to solve this is
> to have a function like snd_soc_register_codec_with_io() which takes a
> pointer to the regmap struct.
> 

@Lars
Yes, this maybe a better choice, and I will think of it.

Thanks very much,

--
Best Regards,
Xiubo
