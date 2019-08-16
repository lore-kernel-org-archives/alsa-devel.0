From: Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 02/15] ASoC: sun4i-i2s: Add set_tdm_slot functionality
Date: Fri, 16 Aug 2019 08:27:05 +0200
Message-ID: <CAEKpxBkOu0+zek9f=4grNEhyPS=Ly3nweCUCgaz6y8M61xvpaQ@mail.gmail.com>
References: <20190814060854.26345-1-codekipper@gmail.com> <20190814060854.26345-3-codekipper@gmail.com>
 <20190814070923.wwkw7hybjvy3p4br@flea>
Reply-To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCHNXO4F7MHBBRMZ3HVAKGQE3OYC4DQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20190814070923.wwkw7hybjvy3p4br@flea>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "Andrea Venturi (pers)" <be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 14 Aug 2019 at 13:08, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org> wrote:
>
> Hi,
>
> On Wed, Aug 14, 2019 at 08:08:41AM +0200, codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> > From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >
> > Codecs without a control connection such as i2s based HDMI audio and
> > the Pine64 DAC require a different amount of bit clocks per frame than
> > what is calculated by the sample width. Use the tdm slot bindings to
> > provide this mechanism.
> >
> > Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  sound/soc/sunxi/sun4i-i2s.c | 23 +++++++++++++++++++++--
> >  1 file changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > index 8201334a059b..7c37b6291df0 100644
> > --- a/sound/soc/sunxi/sun4i-i2s.c
> > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > @@ -195,6 +195,9 @@ struct sun4i_i2s {
> >       struct regmap_field     *field_rxchansel;
> >
> >       const struct sun4i_i2s_quirks   *variant;
> > +
> > +     unsigned int    tdm_slots;
> > +     unsigned int    slot_width;
> >  };
> >
> >  struct sun4i_i2s_clk_div {
> > @@ -346,7 +349,7 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
> >       if (i2s->variant->has_fmt_set_lrck_period)
> >               regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
> >                                  SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
> > -                                SUN8I_I2S_FMT0_LRCK_PERIOD(32));
> > +                                SUN8I_I2S_FMT0_LRCK_PERIOD(word_size));
> >
> >
> >       /* Set sign extension to pad out LSB with 0 */
> >       regmap_field_write(i2s->field_fmt_sext, 0);
> > @@ -450,7 +453,8 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
> >       regmap_field_write(i2s->field_fmt_sr, sr);
> >
> >       return sun4i_i2s_set_clk_rate(dai, params_rate(params),
> > -                                   params_width(params));
> > +                                   i2s->tdm_slots ?
> > +                                   i2s->slot_width : params_width(params));
>
> This is slightly more complicated than that.

At this point we're only supporting 2 channels with fixed slot
settings. I've added a comment to state
that we're using the tdm_slot at the moment as an indicator to
override the slot width. Do you think
that is enough for now?.

Thanks,
CK
>
> On the H3 (and all related ones), the CHAN_CFG_TX_SLOT_NUM and
> _RX_SLOT_NUM fields in the CHAN_CFG register need to be set to the
> number of slots as well.
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
