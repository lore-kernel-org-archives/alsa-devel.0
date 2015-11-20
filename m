From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/4] ASoC: sun4i-codec: Add support for PA
 gpio pin
Date: Fri, 20 Nov 2015 18:02:06 +0100
Message-ID: <20151120170206.GL32142@lukather>
References: <1448027233-750-1-git-send-email-hdegoede@redhat.com>
 <20151120163047.GF32142@lukather>
 <CAGb2v66PPm+G=RfrLgNHNeVDed8BSuGaERKLgfsnzPpAzKcmsA@mail.gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opU1cLy5W6t5oyvs"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBFFEXWZAKGQEEMYOKWY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGb2v66PPm+G=RfrLgNHNeVDed8BSuGaERKLgfsnzPpAzKcmsA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

--opU1cLy5W6t5oyvs
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Sat, Nov 21, 2015 at 12:42:41AM +0800, Chen-Yu Tsai wrote:
> >>  static void sun4i_codec_stop_playback(struct sun4i_codec *scodec)
> >>  {
> >> -     /*
> >> -      * FIXME: according to the BSP, we might need to drive a PA
> >> -      *        GPIO low here on some boards
> >> -      */
> >> -
> >>       /* Disable DAC DRQ */
> >>       regmap_update_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
> >>                          BIT(SUN4I_CODEC_DAC_FIFOC_DAC_DRQ_EN),
> >>                          0);
> >> +
> >> +     if (scodec->gpio_pa)
> >> +             gpiod_set_value_cansleep(scodec->gpio_pa, 0);
> >
> > You should rather plug that into DAPM, using a speaker widget, and a
> > custom event function that will enable or disable the amplifier only
> > when this audio path is going to be used.
> 
> Isn't an "amplifier" widget better suited?

This is exactly what SND_SOC_DAPM_SPK is used for:
http://lxr.free-electrons.com/source/Documentation/sound/alsa/soc/dapm.txt#L273 ;)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--opU1cLy5W6t5oyvs--
