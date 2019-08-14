From: Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 01/15] ASoC: sun4i-i2s: Add regmap field
 to sign extend sample
Date: Wed, 14 Aug 2019 13:24:26 +0200
Message-ID: <CAEKpxBkDGFUQTZXKUda71P02n2f4eDHJS0D4DdgbQN_JJE10cQ@mail.gmail.com>
References: <20190814060854.26345-1-codekipper@gmail.com> <20190814060854.26345-2-codekipper@gmail.com>
 <20190814064339.lgfngdkiaalygolk@flea>
Reply-To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCHNXO4F7MHBB5W6Z7VAKGQEG4VGBBI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20190814064339.lgfngdkiaalygolk@flea>
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
> On Wed, Aug 14, 2019 at 08:08:40AM +0200, codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> > From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >
> > On the newer SoCs such as the H3 and A64 this is set by default
> > to transfer a 0 after each sample in each slot. However the A10
> > and A20 SoCs that this driver was developed on had a default
> > setting where it padded the audio gain with zeros.
> >
> > This isn't a problem whilst we have only support for 16bit audio
> > but with larger sample resolution rates in the pipeline then SEXT
> > bits should be cleared so that they also pad at the LSB. Without
> > this the audio gets distorted.
> >
> > Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  sound/soc/sunxi/sun4i-i2s.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > index 793457394efe..8201334a059b 100644
> > --- a/sound/soc/sunxi/sun4i-i2s.c
> > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > @@ -135,6 +135,7 @@ struct sun4i_i2s;
> >   * @field_fmt_bclk: regmap field to set clk polarity.
> >   * @field_fmt_lrclk: regmap field to set frame polarity.
> >   * @field_fmt_mode: regmap field to set the operational mode.
> > + * @field_fmt_sext: regmap field to set the sign extension.
> >   * @field_txchanmap: location of the tx channel mapping register.
> >   * @field_rxchanmap: location of the rx channel mapping register.
> >   * @field_txchansel: location of the tx channel select bit fields.
> > @@ -159,6 +160,7 @@ struct sun4i_i2s_quirks {
> >       struct reg_field                field_fmt_bclk;
> >       struct reg_field                field_fmt_lrclk;
> >       struct reg_field                field_fmt_mode;
> > +     struct reg_field                field_fmt_sext;
> >       struct reg_field                field_txchanmap;
> >       struct reg_field                field_rxchanmap;
> >       struct reg_field                field_txchansel;
> > @@ -186,6 +188,7 @@ struct sun4i_i2s {
> >       struct regmap_field     *field_fmt_bclk;
> >       struct regmap_field     *field_fmt_lrclk;
> >       struct regmap_field     *field_fmt_mode;
> > +     struct regmap_field     *field_fmt_sext;
> >       struct regmap_field     *field_txchanmap;
> >       struct regmap_field     *field_rxchanmap;
> >       struct regmap_field     *field_txchansel;
> > @@ -345,6 +348,9 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
> >                                  SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
> >                                  SUN8I_I2S_FMT0_LRCK_PERIOD(32));
> >
> > +     /* Set sign extension to pad out LSB with 0 */
> > +     regmap_field_write(i2s->field_fmt_sext, 0);
> > +
> >       return 0;
> >  }
> >
> > @@ -917,6 +923,7 @@ static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
> >       .field_fmt_lrclk        = REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
> >       .has_slave_select_bit   = true,
> >       .field_fmt_mode         = REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 1),
> > +     .field_fmt_sext         = REG_FIELD(SUN4I_I2S_FMT1_REG, 8, 8),
> >       .field_txchanmap        = REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
> >       .field_rxchanmap        = REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
> >       .field_txchansel        = REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
> > @@ -936,6 +943,7 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
> >       .field_fmt_lrclk        = REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
> >       .has_slave_select_bit   = true,
> >       .field_fmt_mode         = REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 1),
> > +     .field_fmt_sext         = REG_FIELD(SUN4I_I2S_FMT1_REG, 8, 8),
> >       .field_txchanmap        = REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
> >       .field_rxchanmap        = REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
> >       .field_txchansel        = REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
> > @@ -979,6 +987,7 @@ static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
> >       .field_fmt_bclk         = REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
> >       .field_fmt_lrclk        = REG_FIELD(SUN4I_I2S_FMT0_REG, 19, 19),
> >       .field_fmt_mode         = REG_FIELD(SUN4I_I2S_CTRL_REG, 4, 5),
> > +     .field_fmt_sext         = REG_FIELD(SUN4I_I2S_FMT1_REG, 4, 5),
> >       .field_txchanmap        = REG_FIELD(SUN8I_I2S_TX_CHAN_MAP_REG, 0, 31),
> >       .field_rxchanmap        = REG_FIELD(SUN8I_I2S_RX_CHAN_MAP_REG, 0, 31),
> >       .field_txchansel        = REG_FIELD(SUN8I_I2S_TX_CHAN_SEL_REG, 0, 2),
> > @@ -998,6 +1007,7 @@ static const struct sun4i_i2s_quirks sun50i_a64_codec_i2s_quirks = {
> >       .field_fmt_bclk         = REG_FIELD(SUN4I_I2S_FMT0_REG, 6, 6),
> >       .field_fmt_lrclk        = REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
> >       .field_fmt_mode         = REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 1),
> > +     .field_fmt_sext         = REG_FIELD(SUN4I_I2S_FMT1_REG, 8, 8),
> >       .field_txchanmap        = REG_FIELD(SUN4I_I2S_TX_CHAN_MAP_REG, 0, 31),
> >       .field_rxchanmap        = REG_FIELD(SUN4I_I2S_RX_CHAN_MAP_REG, 0, 31),
> >       .field_txchansel        = REG_FIELD(SUN4I_I2S_TX_CHAN_SEL_REG, 0, 2),
>
> You're missing the A83t here

ARRGGGHHHHH...ACK...thanks,
CK
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
