From: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
Subject: Re: [PATCH v14 2/8] ASoC: sun4i-codec: Add Mic1 Boost
 Volume, Mic2 Boost Volume
Date: Sat, 5 May 2018 09:05:13 +0200
Message-ID: <20180505090513.7e3f02c2@scratchpost.org>
References: <20180502210800.1971-1-dannym@scratchpost.org>
	<20180502210800.1971-3-dannym@scratchpost.org>
	<20180503143319.4vyh2y5sluatssnv@flea>
Reply-To: dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCPKHTHNWIPBBL5PWXLQKGQEC4FRD7Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20180503143319.4vyh2y5sluatssnv@flea>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Andrea Bondavalli <andrea.bondavalli74-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Maxime,

On Thu, 3 May 2018 16:33:19 +0200
Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org> wrote:

> > +struct sun4i_codec_quirks {
> > +	const struct regmap_config *regmap_config;
> > +	const struct snd_soc_component_driver *codec;
> > +	struct snd_soc_card * (*create_card)(struct device *dev);
> > +	struct reg_field reg_adc_fifoc;	/* used for regmap_field */
> > +	unsigned int reg_dac_txdata;	/* TX FIFO offset for DMA config */
> > +	unsigned int reg_adc_rxdata;	/* RX FIFO offset for DMA config */
> > +	bool has_reset;
> > +	const struct snd_kcontrol_new *controls;
> > +	unsigned int num_controls;
> > +};
> > +
> > +static int sun4i_codec_component_driver_probe(struct snd_soc_component *codec)
> > +{
> > +	const struct sun4i_codec_quirks *quirks;
> > +
> > +	quirks = of_device_get_match_data(codec->dev);
> > +	return snd_soc_add_component_controls(codec,
> > +					      quirks->controls,
> > +					      quirks->num_controls);  
> 
> Why not just extending the sun4i_codec_controls to add it, and create
> a duplicate one for the A20?

Because sun4i_codec_controls has five controls shared between A10 and A20,
and only two not shared.

And if we extended sun4i_codec_controls, we'd also have to duplicate
sun4i_codec_codec in order to use sun4i_codec_controls vs. sun7i_codec_controls,
which really contains exactly the same data otherwise.

The quirks here are just for two controls, Mic1 Boost Volume and Mic2 Boost Volume,
and there not even for the names or anything - just for some reason the register
moved away.

The simplest way was to add it to the quirks - which already have a variant
selection etc.
