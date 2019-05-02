From: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/5] ASoC: sun4i-spdif: Add support for
 H6 SoC
Date: Thu, 2 May 2019 11:39:24 +0200
Message-ID: <CAJiuCcdFUPBsXfKtDLt-p6Edx-7JrST9d0C=ofCU4CL8ZxwcsA@mail.gmail.com>
References: <20190419191730.9437-1-peron.clem@gmail.com> <20190419191730.9437-3-peron.clem@gmail.com>
 <20190502082526.c5zo4uzceqzizbxo@flea>
Reply-To: peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCELXIX7UICBBWHVVLTAKGQECZ6PLQY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20190502082526.c5zo4uzceqzizbxo@flea>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi Maxime,

On Thu, 2 May 2019 at 10:25, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org> wrot=
e:
>
> On Fri, Apr 19, 2019 at 09:17:27PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > Allwinner H6 has a different mapping for the fifo register controller.
> >
> > Actually only the fifo tx flush bit is used.
> >
> > Add a new quirk to know the correct fifo tx flush bit.
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  sound/soc/sunxi/sun4i-spdif.c | 42 ++++++++++++++++++++++++++++++-----
> >  1 file changed, 36 insertions(+), 6 deletions(-)
> >
> > diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdi=
f.c
> > index b4af4aabead1..19e4bf9caa24 100644
> > --- a/sound/soc/sunxi/sun4i-spdif.c
> > +++ b/sound/soc/sunxi/sun4i-spdif.c
> > @@ -75,6 +75,18 @@
> >       #define SUN4I_SPDIF_FCTL_RXOM(v)                ((v) << 0)
> >       #define SUN4I_SPDIF_FCTL_RXOM_MASK              GENMASK(1, 0)
> >
> > +#define SUN50I_H6_SPDIF_FCTL (0x14)
> > +     #define SUN50I_H6_SPDIF_FCTL_HUB_EN             BIT(31)
> > +     #define SUN50I_H6_SPDIF_FCTL_FTX                BIT(30)
> > +     #define SUN50I_H6_SPDIF_FCTL_FRX                BIT(29)
> > +     #define SUN50I_H6_SPDIF_FCTL_TXTL(v)            ((v) << 12)
> > +     #define SUN50I_H6_SPDIF_FCTL_TXTL_MASK          GENMASK(19, 12)
> > +     #define SUN50I_H6_SPDIF_FCTL_RXTL(v)            ((v) << 4)
> > +     #define SUN50I_H6_SPDIF_FCTL_RXTL_MASK          GENMASK(10, 4)
> > +     #define SUN50I_H6_SPDIF_FCTL_TXIM               BIT(2)
> > +     #define SUN50I_H6_SPDIF_FCTL_RXOM(v)            ((v) << 0)
> > +     #define SUN50I_H6_SPDIF_FCTL_RXOM_MASK          GENMASK(1, 0)
> > +
> >  #define SUN4I_SPDIF_FSTA     (0x18)
> >       #define SUN4I_SPDIF_FSTA_TXE                    BIT(14)
> >       #define SUN4I_SPDIF_FSTA_TXECNTSHT              (8)
> > @@ -169,16 +181,25 @@ struct sun4i_spdif_dev {
> >       struct snd_soc_dai_driver cpu_dai_drv;
> >       struct regmap *regmap;
> >       struct snd_dmaengine_dai_dma_data dma_params_tx;
> > +     const struct sun4i_spdif_quirks *quirks;
>
> I guess this will generate a warning since the structure hasn't been
> defined yet?

It's a pointer to a structure so no warning from the compiler.

>
> > +};
> > +
> > +struct sun4i_spdif_quirks {
> > +     unsigned int reg_dac_txdata;    /* TX FIFO offset for DMA config =
*/
> > +     unsigned int reg_fctl_ftx;      /* TX FIFO flush bitmask */
> > +     bool has_reset;
>
> You don't really need to move it around, you can just add the
> structure prototype.
>
> If you do want to move it around, then please do so in a separate patch

I have choose to move it to follow what is done in the sun4i-i2s.
I will put it in a separate patch and make the comment a bit more proper.

>
> >  };
> >
> >  static void sun4i_spdif_configure(struct sun4i_spdif_dev *host)
> >  {
> > +     const struct sun4i_spdif_quirks *quirks =3D host->quirks;
> > +
> >       /* soft reset SPDIF */
> >       regmap_write(host->regmap, SUN4I_SPDIF_CTL, SUN4I_SPDIF_CTL_RESET=
);
> >
> >       /* flush TX FIFO */
> >       regmap_update_bits(host->regmap, SUN4I_SPDIF_FCTL,
> > -                        SUN4I_SPDIF_FCTL_FTX, SUN4I_SPDIF_FCTL_FTX);
> > +                        quirks->reg_fctl_ftx, quirks->reg_fctl_ftx);
> >
> >       /* clear TX counter */
> >       regmap_write(host->regmap, SUN4I_SPDIF_TXCNT, 0);
> > @@ -405,22 +426,26 @@ static struct snd_soc_dai_driver sun4i_spdif_dai =
=3D {
> >       .name =3D "spdif",
> >  };
> >
> > -struct sun4i_spdif_quirks {
> > -     unsigned int reg_dac_txdata;    /* TX FIFO offset for DMA config =
*/
> > -     bool has_reset;
> > -};
> > -
> >  static const struct sun4i_spdif_quirks sun4i_a10_spdif_quirks =3D {
> >       .reg_dac_txdata =3D SUN4I_SPDIF_TXFIFO,
> > +     .reg_fctl_ftx   =3D SUN4I_SPDIF_FCTL_FTX,
> >  };
> >
> >  static const struct sun4i_spdif_quirks sun6i_a31_spdif_quirks =3D {
> >       .reg_dac_txdata =3D SUN4I_SPDIF_TXFIFO,
> > +     .reg_fctl_ftx   =3D SUN4I_SPDIF_FCTL_FTX,
> >       .has_reset      =3D true,
> >  };
> >
> >  static const struct sun4i_spdif_quirks sun8i_h3_spdif_quirks =3D {
> >       .reg_dac_txdata =3D SUN8I_SPDIF_TXFIFO,
> > +     .reg_fctl_ftx   =3D SUN4I_SPDIF_FCTL_FTX,
> > +     .has_reset      =3D true,
> > +};
> >
> > +static const struct sun4i_spdif_quirks sun50i_h6_spdif_quirks =3D {
> > +     .reg_dac_txdata =3D SUN8I_SPDIF_TXFIFO,
> > +     .reg_fctl_ftx   =3D SUN50I_H6_SPDIF_FCTL_FTX,
> >       .has_reset      =3D true,
>
> The reg_dac_txdata and reg_fctl_ftx changes here should also be part
> of a separate patch.

You mean the reg_fctl_ftx quirk and the H6 introduction should be split ?

Thanks for the review,
Clement

>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
