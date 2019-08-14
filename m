From: Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 15/15] ASoC: sun4i-i2s: Adjust regmap settings
Date: Wed, 14 Aug 2019 11:02:54 +0200
Message-ID: <CAEKpxBnNzH3KANfaY7p0qv=XTAyHAk3YSWqFbt_hpWat+xSBxw@mail.gmail.com>
References: <20190814060854.26345-1-codekipper@gmail.com> <20190814060854.26345-16-codekipper@gmail.com>
 <3741744.8c7tOhJ1tT@jernej-laptop>
Reply-To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCHNXO4F7MHBBSU4Z7VAKGQEK2T3HEQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <3741744.8c7tOhJ1tT@jernej-laptop>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "Andrea Venturi (pers)" <be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 14 Aug 2019 at 10:38, Jernej =C5=A0krabec <jernej.skrabec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
> wrote:
>
> Hi!
>
> Dne sreda, 14. avgust 2019 ob 08:08:54 CEST je codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> napisal(a):
> > From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >
> > Bypass the regmap cache when flushing the i2s FIFOs and modify the tabl=
es
> > to reflect this.
> >
> > Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  sound/soc/sunxi/sun4i-i2s.c | 31 ++++++++++---------------------
> >  1 file changed, 10 insertions(+), 21 deletions(-)
> >
> > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > index d3c8789f70bb..ecfc1ed79379 100644
> > --- a/sound/soc/sunxi/sun4i-i2s.c
> > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > @@ -876,9 +876,11 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *d=
ai,
> > unsigned int fmt) static void sun4i_i2s_start_capture(struct sun4i_i2s
> > *i2s)
> >  {
> >       /* Flush RX FIFO */
> > +     regcache_cache_bypass(i2s->regmap, true);
> >       regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
> >                          SUN4I_I2S_FIFO_CTRL_FLUSH_RX,
> >                          SUN4I_I2S_FIFO_CTRL_FLUSH_RX);
> > +     regcache_cache_bypass(i2s->regmap, false);
>
> Did you try with regmap_write_bits() instead? This function will
> unconditionally write bits so it's nicer solution, because you don't have=
 to
> use regcache_cache_bypass().

I didn't....with all the rework I've avoided messing with this change.
Now that the dust
has settled, I can go back to look at this.
Thanks,
CK
>
> >
> >       /* Clear RX counter */
> >       regmap_write(i2s->regmap, SUN4I_I2S_RX_CNT_REG, 0);
> > @@ -897,9 +899,11 @@ static void sun4i_i2s_start_capture(struct sun4i_i=
2s
> > *i2s) static void sun4i_i2s_start_playback(struct sun4i_i2s *i2s)
> >  {
> >       /* Flush TX FIFO */
> > +     regcache_cache_bypass(i2s->regmap, true);
> >       regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
> >                          SUN4I_I2S_FIFO_CTRL_FLUSH_TX,
> >                          SUN4I_I2S_FIFO_CTRL_FLUSH_TX);
> > +     regcache_cache_bypass(i2s->regmap, false);
>
> Ditto.
>
> >
> >       /* Clear TX counter */
> >       regmap_write(i2s->regmap, SUN4I_I2S_TX_CNT_REG, 0);
> > @@ -1053,13 +1057,7 @@ static const struct snd_soc_component_driver
> > sun4i_i2s_component =3D {
> >
> >  static bool sun4i_i2s_rd_reg(struct device *dev, unsigned int reg)
> >  {
> > -     switch (reg) {
> > -     case SUN4I_I2S_FIFO_TX_REG:
> > -             return false;
> > -
> > -     default:
> > -             return true;
> > -     }
> > +     return true;
>
> Why did you change this? Manual mentions that SUN4I_I2S_FIFO_TX_REG is wr=
ite-
> only register. Even if it can be read, then it's better to remove whole
> function, which will automatically mean that all registers can be read.
>
>
> >  }
> >
> >  static bool sun4i_i2s_wr_reg(struct device *dev, unsigned int reg)
> > @@ -1078,6 +1076,8 @@ static bool sun4i_i2s_volatile_reg(struct device =
*dev,
> > unsigned int reg) {
> >       switch (reg) {
> >       case SUN4I_I2S_FIFO_RX_REG:
> > +     case SUN4I_I2S_FIFO_TX_REG:
> > +     case SUN4I_I2S_FIFO_STA_REG:
> >       case SUN4I_I2S_INT_STA_REG:
> >       case SUN4I_I2S_RX_CNT_REG:
> >       case SUN4I_I2S_TX_CNT_REG:
>
> SUN4I_I2S_FIFO_CTRL_REG should be put here, because it has two bits which
> returns to 0 immediately after they are set to 1.
>
> Best regards,
> Jernej
>
> > @@ -1088,23 +1088,12 @@ static bool sun4i_i2s_volatile_reg(struct devic=
e
> > *dev, unsigned int reg) }
> >  }
> >
> > -static bool sun8i_i2s_rd_reg(struct device *dev, unsigned int reg)
> > -{
> > -     switch (reg) {
> > -     case SUN8I_I2S_FIFO_TX_REG:
> > -             return false;
> > -
> > -     default:
> > -             return true;
> > -     }
> > -}
> > -
> >  static bool sun8i_i2s_volatile_reg(struct device *dev, unsigned int re=
g)
> >  {
> >       if (reg =3D=3D SUN8I_I2S_INT_STA_REG)
> >               return true;
> >       if (reg =3D=3D SUN8I_I2S_FIFO_TX_REG)
> > -             return false;
> > +             return true;
> >
> >       return sun4i_i2s_volatile_reg(dev, reg);
> >  }
> > @@ -1175,7 +1164,7 @@ static const struct regmap_config
> > sun8i_i2s_regmap_config =3D { .reg_defaults     =3D sun8i_i2s_reg_defau=
lts,
> >       .num_reg_defaults       =3D ARRAY_SIZE(sun8i_i2s_reg_defaults),
> >       .writeable_reg  =3D sun4i_i2s_wr_reg,
> > -     .readable_reg   =3D sun8i_i2s_rd_reg,
> > +     .readable_reg   =3D sun4i_i2s_rd_reg,
> >       .volatile_reg   =3D sun8i_i2s_volatile_reg,
> >  };
> >
> > @@ -1188,7 +1177,7 @@ static const struct regmap_config
> > sun50i_i2s_regmap_config =3D { .reg_defaults    =3D sun50i_i2s_reg_defa=
ults,
> >       .num_reg_defaults       =3D ARRAY_SIZE(sun50i_i2s_reg_defaults),
> >       .writeable_reg  =3D sun4i_i2s_wr_reg,
> > -     .readable_reg   =3D sun8i_i2s_rd_reg,
> > +     .readable_reg   =3D sun4i_i2s_rd_reg,
> >       .volatile_reg   =3D sun8i_i2s_volatile_reg,
> >  };
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
/linux-sunxi/CAEKpxBnNzH3KANfaY7p0qv%3DXTAyHAk3YSWqFbt_hpWat%2BxSBxw%40mail=
.gmail.com.
