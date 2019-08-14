From: Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 11/15] ASoC: sun4i-i2s: Add support for
 H6 I2S
Date: Wed, 14 Aug 2019 13:08:59 +0200
Message-ID: <CAEKpxBnLfpUdnksxVVrJt7TESsLq=fnkezBnRZsC1kHRrDrSOQ@mail.gmail.com>
References: <20190814060854.26345-1-codekipper@gmail.com> <20190814060854.26345-12-codekipper@gmail.com>
 <13079463.kjevBeenX1@jernej-laptop>
Reply-To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCHNXO4F7MHBBV6XZ7VAKGQE6FC3TXY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <13079463.kjevBeenX1@jernej-laptop>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "Andrea Venturi (pers)" <be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 14 Aug 2019 at 09:57, Jernej =C5=A0krabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>=
 wrote:
>
> Hi!
>
> Dne sreda, 14. avgust 2019 ob 08:08:50 CEST je codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> napisal(a):
> > From: Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
> >
> > H6 I2S is very similar to that in H3, except it supports up to 16
> > channels.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec-gGgVlfcn5nU@public.gmane.org>
>
> Your Signed-off-by is missing here and on all other patches made original=
ly by
> me.
ACK
>
> Best regards,
> Jernej
>
> > ---
> >  sound/soc/sunxi/sun4i-i2s.c | 148 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 148 insertions(+)
> >
> > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > index 6de3cb41aaf6..a8d98696fe7c 100644
> > --- a/sound/soc/sunxi/sun4i-i2s.c
> > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > @@ -121,6 +121,21 @@
> >  #define SUN8I_I2S_RX_CHAN_SEL_REG    0x54
> >  #define SUN8I_I2S_RX_CHAN_MAP_REG    0x58
> >
> > +/* Defines required for sun50i-h6 support */
> > +#define SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET_MASK        GENMASK(21, 20)
> > +#define SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET(offset)     ((offset) << 20)
> > +#define SUN50I_H6_I2S_TX_CHAN_SEL_MASK               GENMASK(19, 16)
> > +#define SUN50I_H6_I2S_TX_CHAN_SEL(chan)              ((chan - 1) << 16=
)
> > +#define SUN50I_H6_I2S_TX_CHAN_EN_MASK                GENMASK(15, 0)
> > +#define SUN50I_H6_I2S_TX_CHAN_EN(num_chan)   (((1 << num_chan) - 1))
> > +
> > +#define SUN50I_H6_I2S_TX_CHAN_MAP0_REG       0x44
> > +#define SUN50I_H6_I2S_TX_CHAN_MAP1_REG       0x48
> > +
> > +#define SUN50I_H6_I2S_RX_CHAN_SEL_REG        0x64
> > +#define SUN50I_H6_I2S_RX_CHAN_MAP0_REG       0x68
> > +#define SUN50I_H6_I2S_RX_CHAN_MAP1_REG       0x6C
> > +
> >  struct sun4i_i2s;
> >
> >  /**
> > @@ -440,6 +455,25 @@ static void sun8i_i2s_set_rxchanoffset(const struc=
t
> > sun4i_i2s *i2s) SUN8I_I2S_TX_CHAN_OFFSET(i2s->offset));
> >  }
> >
> > +static void sun50i_h6_i2s_set_txchanoffset(const struct sun4i_i2s *i2s=
, int
> > output) +{
> > +     if (output >=3D 0 && output < 4) {
> > +             regmap_update_bits(i2s->regmap,
> > +                                SUN8I_I2S_TX_CHAN_SEL_REG +
> (output * 4),
> > +
> SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET_MASK,
> > +
> SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET(i2s->offset));
> > +     }
> > +
> > +}
> > +
> > +static void sun50i_h6_i2s_set_rxchanoffset(const struct sun4i_i2s *i2s=
)
> > +{
> > +     regmap_update_bits(i2s->regmap,
> > +                        SUN50I_H6_I2S_RX_CHAN_SEL_REG,
> > +                        SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET_MASK,
> > +                        SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET(i2s-
> >offset));
> > +}
> > +
> >  static void sun8i_i2s_set_txchanen(const struct sun4i_i2s *i2s, int ou=
tput,
> > int channel)
> >  {
> > @@ -459,6 +493,26 @@ static void sun8i_i2s_set_rxchanen(const struct
> > sun4i_i2s *i2s, int channel) SUN8I_I2S_TX_CHAN_EN(channel));
> >  }
> >
> > +
> > +static void sun50i_h6_i2s_set_txchanen(const struct sun4i_i2s *i2s, in=
t
> > output, +                                    int channel)
> > +{
> > +     if (output >=3D 0 && output < 4) {
> > +             regmap_update_bits(i2s->regmap,
> > +                                SUN8I_I2S_TX_CHAN_SEL_REG +
> (output * 4),
> > +                                SUN50I_H6_I2S_TX_CHAN_EN_MASK,
> > +
> SUN50I_H6_I2S_TX_CHAN_EN(channel));
> > +     }
> > +}
> > +
> > +static void sun50i_h6_i2s_set_rxchanen(const struct sun4i_i2s *i2s, in=
t
> > channel) +{
> > +     regmap_update_bits(i2s->regmap,
> > +                        SUN50I_H6_I2S_RX_CHAN_SEL_REG,
> > +                        SUN50I_H6_I2S_TX_CHAN_EN_MASK,
> > +                        SUN50I_H6_I2S_TX_CHAN_EN(channel));
> > +}
> > +
> >  static void sun4i_i2s_set_txchansel(const struct sun4i_i2s *i2s, int
> > output, int channel)
> >  {
> > @@ -495,6 +549,25 @@ static void sun8i_i2s_set_rxchansel(const struct
> > sun4i_i2s *i2s, int channel) SUN8I_I2S_TX_CHAN_SEL(channel));
> >  }
> >
> > +static void sun50i_h6_i2s_set_txchansel(const struct sun4i_i2s *i2s, i=
nt
> > output, +                                    int channel)
> > +{
> > +     if (output >=3D 0 && output < 4) {
> > +             regmap_update_bits(i2s->regmap,
> > +                                SUN8I_I2S_TX_CHAN_SEL_REG +
> (output * 4),
> > +                                SUN50I_H6_I2S_TX_CHAN_SEL_MASK,
> > +
> SUN50I_H6_I2S_TX_CHAN_SEL(channel));
> > +     }
> > +}
> > +
> > +static void sun50i_h6_i2s_set_rxchansel(const struct sun4i_i2s *i2s, i=
nt
> > channel) +{
> > +     regmap_update_bits(i2s->regmap,
> > +                        SUN50I_H6_I2S_RX_CHAN_SEL_REG,
> > +                        SUN50I_H6_I2S_TX_CHAN_SEL_MASK,
> > +                        SUN50I_H6_I2S_TX_CHAN_SEL(channel));
> > +}
> > +
> >  static void sun4i_i2s_set_txchanmap(const struct sun4i_i2s *i2s, int
> > output, int channel)
> >  {
> > @@ -520,6 +593,20 @@ static void sun8i_i2s_set_rxchanmap(const struct
> > sun4i_i2s *i2s, int channel) regmap_write(i2s->regmap,
> > SUN8I_I2S_RX_CHAN_MAP_REG, channel);
> >  }
> >
> > +static void sun50i_h6_i2s_set_txchanmap(const struct sun4i_i2s *i2s, i=
nt
> > output, +                                    int channel)
> > +{
> > +     if (output >=3D 0 && output < 4) {
> > +             regmap_write(i2s->regmap,
> > +                          SUN50I_H6_I2S_TX_CHAN_MAP1_REG + (output
> * 8), channel);
> > +     }
> > +}
> > +
> > +static void sun50i_h6_i2s_set_rxchanmap(const struct sun4i_i2s *i2s, i=
nt
> > channel) +{
> > +     regmap_write(i2s->regmap, SUN50I_H6_I2S_RX_CHAN_MAP1_REG, channel=
);
> > +}
> > +
> >  static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
> >                              struct snd_pcm_hw_params *params,
> >                              struct snd_soc_dai *dai)
> > @@ -996,6 +1083,22 @@ static const struct reg_default
> > sun8i_i2s_reg_defaults[] =3D { { SUN8I_I2S_RX_CHAN_MAP_REG, 0x00000000 =
},
> >  };
> >
> > +static const struct reg_default sun50i_i2s_reg_defaults[] =3D {
> > +     { SUN4I_I2S_CTRL_REG, 0x00060000 },
> > +     { SUN4I_I2S_FMT0_REG, 0x00000033 },
> > +     { SUN4I_I2S_FMT1_REG, 0x00000030 },
> > +     { SUN4I_I2S_FIFO_CTRL_REG, 0x000400f0 },
> > +     { SUN4I_I2S_DMA_INT_CTRL_REG, 0x00000000 },
> > +     { SUN4I_I2S_CLK_DIV_REG, 0x00000000 },
> > +     { SUN8I_I2S_CHAN_CFG_REG, 0x00000000 },
> > +     { SUN8I_I2S_TX_CHAN_SEL_REG, 0x00000000 },
> > +     { SUN50I_H6_I2S_TX_CHAN_MAP0_REG, 0x00000000 },
> > +     { SUN50I_H6_I2S_TX_CHAN_MAP1_REG, 0x00000000 },
> > +     { SUN50I_H6_I2S_RX_CHAN_SEL_REG, 0x00000000 },
> > +     { SUN50I_H6_I2S_RX_CHAN_MAP0_REG, 0x00000000 },
> > +     { SUN50I_H6_I2S_RX_CHAN_MAP1_REG, 0x00000000 },
> > +};
> > +
> >  static const struct regmap_config sun4i_i2s_regmap_config =3D {
> >       .reg_bits       =3D 32,
> >       .reg_stride     =3D 4,
> > @@ -1023,6 +1126,19 @@ static const struct regmap_config
> > sun8i_i2s_regmap_config =3D { .volatile_reg     =3D sun8i_i2s_volatile_=
reg,
> >  };
> >
> > +static const struct regmap_config sun50i_i2s_regmap_config =3D {
> > +     .reg_bits       =3D 32,
> > +     .reg_stride     =3D 4,
> > +     .val_bits       =3D 32,
> > +     .max_register   =3D SUN50I_H6_I2S_RX_CHAN_MAP1_REG,
> > +     .cache_type     =3D REGCACHE_FLAT,
> > +     .reg_defaults   =3D sun50i_i2s_reg_defaults,
> > +     .num_reg_defaults       =3D ARRAY_SIZE(sun50i_i2s_reg_defaults),
> > +     .writeable_reg  =3D sun4i_i2s_wr_reg,
> > +     .readable_reg   =3D sun8i_i2s_rd_reg,
> > +     .volatile_reg   =3D sun8i_i2s_volatile_reg,
> > +};
> > +
> >  static int sun4i_i2s_runtime_resume(struct device *dev)
> >  {
> >       struct sun4i_i2s *i2s =3D dev_get_drvdata(dev);
> > @@ -1197,6 +1313,34 @@ static const struct sun4i_i2s_quirks
> > sun50i_a64_codec_i2s_quirks =3D { .set_rxchanmap                =3D
> sun4i_i2s_set_rxchanmap,
> >  };
> >
> > +static const struct sun4i_i2s_quirks sun50i_h6_i2s_quirks =3D {
> > +     .has_reset              =3D true,
> > +     .reg_offset_txdata      =3D SUN8I_I2S_FIFO_TX_REG,
> > +     .sun4i_i2s_regmap       =3D &sun50i_i2s_regmap_config,
> > +     .has_fmt_set_lrck_period =3D true,
> > +     .has_chcfg              =3D true,
> > +     .has_chsel_tx_chen      =3D true,
> > +     .has_chsel_offset       =3D true,
> > +     .field_clkdiv_mclk_en   =3D REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 8, 8=
),
> > +     .field_fmt_wss          =3D REG_FIELD(SUN4I_I2S_FMT0_REG,
> 0, 2),
> > +     .field_fmt_sr           =3D REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 6),
> > +     .field_fmt_bclk         =3D REG_FIELD(SUN4I_I2S_FMT0_REG,
> 7, 7),
> > +     .field_fmt_lrclk        =3D REG_FIELD(SUN4I_I2S_FMT0_REG, 19, 19)=
,
> > +     .field_fmt_mode         =3D REG_FIELD(SUN4I_I2S_CTRL_REG, 4,
> 5),
> > +     .field_fmt_sext         =3D REG_FIELD(SUN4I_I2S_FMT1_REG,
> 4, 5),
> > +     .get_sr                 =3D sun8i_i2s_get_sr_wss,
> > +     .get_wss                =3D sun8i_i2s_get_sr_wss,
> > +     .set_format             =3D sun8i_i2s_set_format,
> > +     .set_txchanoffset       =3D sun50i_h6_i2s_set_txchanoffset,
> > +     .set_rxchanoffset       =3D sun50i_h6_i2s_set_rxchanoffset,
> > +     .set_txchanen           =3D sun50i_h6_i2s_set_txchanen,
> > +     .set_rxchanen           =3D sun50i_h6_i2s_set_rxchanen,
> > +     .set_txchansel          =3D sun50i_h6_i2s_set_txchansel,
> > +     .set_rxchansel          =3D sun50i_h6_i2s_set_rxchansel,
> > +     .set_txchanmap          =3D sun50i_h6_i2s_set_txchanmap,
> > +     .set_rxchanmap          =3D sun50i_h6_i2s_set_rxchanmap,
> > +};
> > +
> >  static int sun4i_i2s_init_regmap_fields(struct device *dev,
> >                                       struct sun4i_i2s *i2s)
> >  {
> > @@ -1389,6 +1533,10 @@ static const struct of_device_id sun4i_i2s_match=
[] =3D
> > { .compatible =3D "allwinner,sun50i-a64-codec-i2s",
> >               .data =3D &sun50i_a64_codec_i2s_quirks,
> >       },
> > +     {
> > +             .compatible =3D "allwinner,sun50i-h6-i2s",
> > +             .data =3D &sun50i_h6_i2s_quirks,
> > +     },
> >       {}
> >  };
> >  MODULE_DEVICE_TABLE(of, sun4i_i2s_match);
>
>
>
>

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To view this discussion on the web, visit https://groups.google.com/d/msgid=
/linux-sunxi/CAEKpxBnLfpUdnksxVVrJt7TESsLq%3DfnkezBnRZsC1kHRrDrSOQ%40mail.g=
mail.com.
