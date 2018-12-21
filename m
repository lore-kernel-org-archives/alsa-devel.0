From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH v3 3/9] ASoc: sun4i-i2s: Add 20, 24 and 32
 bit support
Date: Sat, 22 Dec 2018 01:15:24 +0800
Message-ID: <CAGb2v652h5hpujBxF5r3_g_tj2cOjULkUBhazi_5Xd6kvC2ZPw@mail.gmail.com>
References: <20181221152110.17982-1-codekipper@gmail.com> <20181221152110.17982-4-codekipper@gmail.com>
 <CAGb2v67LyDW6kmDrahzLYsY7q9mSJimrZ=jMO3PrPQ=mcxy0qw@mail.gmail.com>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBBOV76TQAKGQE6T2FHOI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAGb2v67LyDW6kmDrahzLYsY7q9mSJimrZ=jMO3PrPQ=mcxy0qw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "Andrea Venturi (pers)" <be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Dec 22, 2018 at 12:48 AM Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org> wrote:
>
> On Fri, Dec 21, 2018 at 11:21 PM <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >
> > From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >
> > Extend the functionality of the driver to include support of 20 and
> > 24 bits per sample for the earlier SoCs.
> >
> > Newer SoCs can also handle 32bit samples.
> >
> > Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  sound/soc/sunxi/sun4i-i2s.c | 41 ++++++++++++++++++++++++++++++++++---
> >  1 file changed, 38 insertions(+), 3 deletions(-)
> >
> > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > index 80bf29e0cc86..adb988ae9ac5 100644
> > --- a/sound/soc/sunxi/sun4i-i2s.c
> > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > @@ -399,6 +399,11 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
> >         case 16:
> >                 width = DMA_SLAVE_BUSWIDTH_2_BYTES;
> >                 break;
> > +       case 20:
> > +       case 24:
> > +       case 32:
> > +               width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> > +               break;
> >         default:
> >                 dev_err(dai->dev, "Unsupported physical sample width: %d\n",
> >                         params_physical_width(params));
> > @@ -411,7 +416,18 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
> >                 sr = 0;
> >                 wss = 0;
> >                 break;
> > -
> > +       case 20:
> > +               sr = 1;
> > +               wss = 1;
> > +               break;
> > +       case 24:
> > +               sr = 2;
> > +               wss = 2;
> > +               break;
> > +       case 32:
> > +               sr = 4;
> > +               wss = 4;
> > +               break;
> >         default:
> >                 dev_err(dai->dev, "Unsupported sample width: %d\n",
> >                         params_width(params));
> > @@ -687,6 +703,13 @@ static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
> >         return 0;
> >  }
> >
> > +#define SUN4I_FORMATS  (SNDRV_PCM_FMTBIT_S16_LE | \
> > +                        SNDRV_PCM_FMTBIT_S20_3LE | \
> > +                        SNDRV_PCM_FMTBIT_S24_LE)
>
> IIRC SNDRV_PCM_FMTBIT_S24_LE and SNDRV_PCM_FMTBIT_S32_LE with .sig_bits = 24
> are different things, in regards to how the sample is aligned in a 4 byte
> space. Have you checked that things actually work as expected? This was
> something that did not work using SNDRV_PCM_FMTBIT_S24_LE on sun4i-codec.

OK. I see the I2S driver is using FIFO mode 1, which expects the sample
to be in the lower portion of the 4 bytes. However it looks like you would
want SNDRV_PCM_FMTBIT_S20_LE (20 bits LSB justified in 4 bytes) instead of
SNDRV_PCM_FMTBIT_S20_3LE (20 bits LSB justified in 3 bytes).

ChenYu


> > +
> > +#define SUN8I_FORMATS  (SUN4I_FORMATS | \
> > +                        SNDRV_PCM_FMTBIT_S32_LE)
> > +
> >  static struct snd_soc_dai_driver sun4i_i2s_dai = {
> >         .probe = sun4i_i2s_dai_probe,
> >         .capture = {
> > @@ -694,14 +717,14 @@ static struct snd_soc_dai_driver sun4i_i2s_dai = {
> >                 .channels_min = 2,
> >                 .channels_max = 2,
> >                 .rates = SNDRV_PCM_RATE_8000_192000,
> > -               .formats = SNDRV_PCM_FMTBIT_S16_LE,
> > +               .formats = SUN4I_FORMATS,
> >         },
> >         .playback = {
> >                 .stream_name = "Playback",
> >                 .channels_min = 2,
> >                 .channels_max = 2,
> >                 .rates = SNDRV_PCM_RATE_8000_192000,
> > -               .formats = SNDRV_PCM_FMTBIT_S16_LE,
> > +               .formats = SUN4I_FORMATS,
> >         },
> >         .ops = &sun4i_i2s_dai_ops,
> >         .symmetric_rates = 1,
> > @@ -1106,6 +1129,18 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
> >         i2s->capture_dma_data.addr = res->start + SUN4I_I2S_FIFO_RX_REG;
> >         i2s->capture_dma_data.maxburst = 8;
> >
> > +       soc_dai = devm_kmemdup(&pdev->dev, &sun4i_i2s_dai,
> > +                              sizeof(*soc_dai), GFP_KERNEL);
> > +       if (!soc_dai) {
> > +               ret = -ENOMEM;
> > +               goto err_pm_disable;
> > +       }
> > +
> > +       if (i2s->variant->has_fmt_set_lrck_period) {
>
> This condition deserves a comment, particularly as to why you use it
> in place of having a separate quirk field to represent 32 bit support.
>
> Regards
> ChenYu
>
> > +               soc_dai->playback.formats = SUN8I_FORMATS;
> > +               soc_dai->capture.formats = SUN8I_FORMATS;
> > +       }
> > +
> >         pm_runtime_enable(&pdev->dev);
> >         if (!pm_runtime_enabled(&pdev->dev)) {
> >                 ret = sun4i_i2s_runtime_resume(&pdev->dev);
> > --
> > 2.20.1
> >
