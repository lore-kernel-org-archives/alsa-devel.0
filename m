From: Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 14/15] ASoc: sun4i-i2s: Add 20, 24 and 32
 bit support
Date: Wed, 14 Aug 2019 11:03:39 +0200
Message-ID: <CAEKpxBmsLKt_mKFC3=wR9n+hK9njhh7drLV2EMrzKahv=s4dTw@mail.gmail.com>
References: <20190814060854.26345-1-codekipper@gmail.com> <20190814060854.26345-15-codekipper@gmail.com>
 <4297791.2mJM636zur@jernej-laptop>
Reply-To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCHNXO4F7MHBB544Z7VAKGQEJZ6VKNY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <4297791.2mJM636zur@jernej-laptop>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "Andrea Venturi (pers)" <be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 14 Aug 2019 at 10:28, Jernej =C5=A0krabec <jernej.skrabec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
> wrote:
>
> Hi!
>
> Dne sreda, 14. avgust 2019 ob 08:08:53 CEST je codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> napisal(a):
> > From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >
> > Extend the functionality of the driver to include support of 20 and
> > 24 bits per sample for the earlier SoCs.
> >
> > Newer SoCs can also handle 32bit samples.
> >
> > Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  sound/soc/sunxi/sun4i-i2s.c | 21 +++++++++++++++++++--
> >  1 file changed, 19 insertions(+), 2 deletions(-)
> >
> > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > index a71969167053..d3c8789f70bb 100644
> > --- a/sound/soc/sunxi/sun4i-i2s.c
> > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > @@ -690,6 +690,11 @@ static int sun4i_i2s_hw_params(struct snd_pcm_subs=
tream
> > *substream, case 16:
> >               width =3D DMA_SLAVE_BUSWIDTH_2_BYTES;
> >               break;
> > +     case 20:
> > +     case 24:
> > +     case 32:
>
> params_physical_width() returns 32 also for 20 and 24-bit formats, so dro=
p 20
> and 24.
ACK
>
> Best regards,
> Jernej
>
> > +             width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> > +             break;
> >       default:
> >               dev_err(dai->dev, "Unsupported physical sample width:
> %d\n",
> >                       params_physical_width(params));
> > @@ -1015,6 +1020,13 @@ static int sun4i_i2s_dai_probe(struct snd_soc_da=
i
> > *dai) return 0;
> >  }
> >
> > +#define SUN4I_FORMATS        (SNDRV_PCM_FMTBIT_S16_LE | \
> > +                      SNDRV_PCM_FMTBIT_S20_LE | \
> > +                      SNDRV_PCM_FMTBIT_S24_LE)
> > +
> > +#define SUN8I_FORMATS        (SUN4I_FORMATS | \
> > +                      SNDRV_PCM_FMTBIT_S32_LE)
> > +
> >  static struct snd_soc_dai_driver sun4i_i2s_dai =3D {
> >       .probe =3D sun4i_i2s_dai_probe,
> >       .capture =3D {
> > @@ -1022,14 +1034,14 @@ static struct snd_soc_dai_driver sun4i_i2s_dai =
=3D {
> >               .channels_min =3D 2,
> >               .channels_max =3D 2,
> >               .rates =3D SNDRV_PCM_RATE_8000_192000,
> > -             .formats =3D SNDRV_PCM_FMTBIT_S16_LE,
> > +             .formats =3D SUN4I_FORMATS,
> >       },
> >       .playback =3D {
> >               .stream_name =3D "Playback",
> >               .channels_min =3D 2,
> >               .channels_max =3D 2,
> >               .rates =3D SNDRV_PCM_RATE_8000_192000,
> > -             .formats =3D SNDRV_PCM_FMTBIT_S16_LE,
> > +             .formats =3D SUN4I_FORMATS,
> >       },
> >       .ops =3D &sun4i_i2s_dai_ops,
> >       .symmetric_rates =3D 1,
> > @@ -1505,6 +1517,11 @@ static int sun4i_i2s_probe(struct platform_devic=
e
> > *pdev) goto err_pm_disable;
> >       }
> >
> > +     if (i2s->variant->has_fmt_set_lrck_period) {
> > +             soc_dai->playback.formats =3D SUN8I_FORMATS;
> > +             soc_dai->capture.formats =3D SUN8I_FORMATS;
> > +     }
> > +
> >       if (!of_property_read_u32(pdev->dev.of_node,
> >                                 "allwinner,playback-channels",
> &val)) {
> >               if (val >=3D 2 && val <=3D 8)
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
/linux-sunxi/CAEKpxBmsLKt_mKFC3%3DwR9n%2BhK9njhh7drLV2EMrzKahv%3Ds4dTw%40ma=
il.gmail.com.
