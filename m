From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: [PATCH v4 6/9] ASoC: sun4i-i2s: Add multi-lane functionality
Date: Tue, 30 Jul 2019 19:57:10 +0200
Message-ID: <2092329.vleAuWJ0xl@jernej-laptop>
References: <20190603174735.21002-1-codekipper@gmail.com> <CAP03XepJVPge5sz4WcmK8pp2jHAPJdGb6v6A3R0DzSf5O6qj-g@mail.gmail.com> <CAEKpxBmxAQKgDhvjpczAWwNtNhYRs07wjMSnr8nqHk1XxMT=nw@mail.gmail.com>
Reply-To: jernej.skrabec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDP4JJM5QYGRB64JQLVAKGQEHJHEHLY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAEKpxBmxAQKgDhvjpczAWwNtNhYRs07wjMSnr8nqHk1XxMT=nw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Christopher Obbard <chris-ljUBoSVpJTpWk0Htik3J/w@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "Andrea Venturi (pers)" <be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi!

Dne torek, 04. junij 2019 ob 11:38:44 CEST je Code Kipper napisal(a):
> On Tue, 4 Jun 2019 at 11:02, Christopher Obbard <chris-ljUBoSVpJTpWk0Htik3J/w@public.gmane.org> wrote:
> > On Tue, 4 Jun 2019 at 09:43, Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > > On Tue, 4 Jun 2019 at 09:58, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org> 
wrote:
> > > > On Mon, Jun 03, 2019 at 07:47:32PM +0200, codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> > > > > From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > > > 
> > > > > The i2s block supports multi-lane i2s output however this
> > > > > functionality
> > > > > is only possible in earlier SoCs where the pins are exposed and for
> > > > > the i2s block used for HDMI audio on the later SoCs.
> > > > > 
> > > > > To enable this functionality, an optional property has been added to
> > > > > the bindings.
> > > > > 
> > > > > Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > > 
> > > > I'd like to have Mark's input on this, but I'm really worried about
> > > > the interaction with the proper TDM support.
> > > > 
> > > > Our fundamental issue is that the controller can have up to 8
> > > > channels, but either on 4 lines (instead of 1), or 8 channels on 1
> > > > (like proper TDM) (or any combination between the two, but that should
> > > > be pretty rare).
> > > 
> > > I understand...maybe the TDM needs to be extended to support this to
> > > consider channel mapping and multiple transfer lines. I was thinking
> > > about the later when someone was requesting support on IIRC a while
> > > ago, I thought masking might of been a solution. These can wait as the
> > > only consumer at the moment is LibreELEC and we can patch it there.
> > 
> > Hi Marcus,
> > 
> > FWIW, the TI McASP driver has support for TDM & (i think?) multiple
> > transfer lines which are called serializers.
> > Maybe this can help with inspiration?
> > see
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/s
> > ound/soc/ti/davinci-mcasp.c sample DTS:
> > 
> > &mcasp0 {
> > 
> >     #sound-dai-cells = <0>;
> >     status = "okay";
> >     pinctrl-names = "default";
> >     pinctrl-0 = <&mcasp0_pins>;
> >     
> >     op-mode = <0>;
> >     tdm-slots = <8>;
> >     serial-dir = <
> >     
> >         2 0 1 0
> >         0 0 0 0
> >         0 0 0 0
> >         0 0 0 0
> >     >
> >     >;
> >     
> >     tx-num-evt = <1>;
> >     rx-num-evt = <1>;
> > 
> > };
> > 
> > 
> > Cheers!
> 
> Thanks, this looks good.

I would really like to see this issue resolved, because HDMI audio support in 
mainline Linux for those SoCs is long overdue.

However, there is a possibility to still add HDMI audio suport (stereo only) 
even if this issue is not completely solved. If we agree that configuration of 
channels would be solved with additional property as Christopher suggested, 
support for >2 channels can be left for a later time when support for that 
property would be implemented. Currently, stereo HDMI audio support can be 
added with a few patches.

I think all I2S cores are really the same, no matter if internally connected 
to HDMI controller or routed to pins, so it would make sense to use same 
compatible for all of them. It's just that those I2S cores which are routed to 
pins can use only one lane and >2 channels can be used only in TDM mode of 
operation, if I understand this correctly.

New property would have to be optional, so it's omission would result in same 
channel configuration as it is already present, to preserve compatibility with 
old device trees. And this mode is already sufficient for stereo HDMI audio 
support.

Side note: HDMI audio with current sun4i-i2s driver has a delay (about a 
second), supposedly because DW HDMI controller automatically generates CTS 
value based on I2S clock (auto CTS value generation is enabled per DesignWare 
recomendation for DW HDMI I2S interface). I2S driver from BSP Linux solves 
that by having I2S clock output enabled all the time. Should this be flagged 
with some additional property in DT?

Best regards,
Jernej

> CK
> 
> > > Do you have any ideas Master?
> > > CK
> > > 
> > > > You're trying to do the first one, and I'm trying to do the second
> > > > one.
> > > > 
> > > > There's a number of assumptions later on that will break the TDM case,
> > > > see below for examples
> > > > 
> > > > > ---
> > > > > 
> > > > >  sound/soc/sunxi/sun4i-i2s.c | 44
> > > > >  ++++++++++++++++++++++++++++++++-----
> > > > >  1 file changed, 39 insertions(+), 5 deletions(-)
> > > > > 
> > > > > diff --git a/sound/soc/sunxi/sun4i-i2s.c
> > > > > b/sound/soc/sunxi/sun4i-i2s.c
> > > > > index bca73b3c0d74..75217fb52bfa 100644
> > > > > --- a/sound/soc/sunxi/sun4i-i2s.c
> > > > > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > > > > @@ -23,7 +23,7 @@
> > > > > 
> > > > >  #define SUN4I_I2S_CTRL_REG           0x00
> > > > >  #define SUN4I_I2S_CTRL_SDO_EN_MASK           GENMASK(11, 8)
> > > > > 
> > > > > -#define SUN4I_I2S_CTRL_SDO_EN(sdo)                   BIT(8 + (sdo))
> > > > > +#define SUN4I_I2S_CTRL_SDO_EN(lines)         (((1 << lines) - 1) <<
> > > > > 8)
> > > > > 
> > > > >  #define SUN4I_I2S_CTRL_MODE_MASK             BIT(5)
> > > > >  #define SUN4I_I2S_CTRL_MODE_SLAVE                    (1 << 5)
> > > > >  #define SUN4I_I2S_CTRL_MODE_MASTER                   (0 << 5)
> > > > > 
> > > > > @@ -355,14 +355,23 @@ static int sun4i_i2s_hw_params(struct
> > > > > snd_pcm_substream *substream,> > > > 
> > > > >       struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
> > > > >       int sr, wss, channels;
> > > > >       u32 width;
> > > > > 
> > > > > +     int lines;
> > > > > 
> > > > >       channels = params_channels(params);
> > > > > 
> > > > > -     if (channels != 2) {
> > > > > +     if ((channels > dai->driver->playback.channels_max) ||
> > > > > +             (channels < dai->driver->playback.channels_min)) {
> > > > > 
> > > > >               dev_err(dai->dev, "Unsupported number of channels:
> > > > >               %d\n",
> > > > >               
> > > > >                       channels);
> > > > >               
> > > > >               return -EINVAL;
> > > > >       
> > > > >       }
> > > > > 
> > > > > +     lines = (channels + 1) / 2;
> > > > > +
> > > > > +     /* Enable the required output lines */
> > > > > +     regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
> > > > > +                        SUN4I_I2S_CTRL_SDO_EN_MASK,
> > > > > +                        SUN4I_I2S_CTRL_SDO_EN(lines));
> > > > > +
> > > > 
> > > > This has the assumption that each line will have 2 channels, which is
> > > > wrong.> > > 
> > > > >       if (i2s->variant->is_h3_i2s_based) {
> > > > >       
> > > > >               regmap_update_bits(i2s->regmap,
> > > > >               SUN8I_I2S_CHAN_CFG_REG,
> > > > >               
> > > > >                                  SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM_MASK
> > > > >                                  ,
> > > > > 
> > > > > @@ -373,8 +382,19 @@ static int sun4i_i2s_hw_params(struct
> > > > > snd_pcm_substream *substream,> > > > 
> > > > >       }
> > > > >       
> > > > >       /* Map the channels for playback and capture */
> > > > > 
> > > > > -     regmap_field_write(i2s->field_txchanmap, 0x76543210);
> > > > > 
> > > > >       regmap_field_write(i2s->field_rxchanmap, 0x00003210);
> > > > > 
> > > > > +     regmap_field_write(i2s->field_txchanmap, 0x10);
> > > > > +     if (i2s->variant->is_h3_i2s_based) {
> > > > > +             if (channels > 2)
> > > > > +                     regmap_write(i2s->regmap,
> > > > > +                                  SUN8I_I2S_TX_CHAN_MAP_REG+4,
> > > > > 0x32);
> > > > > +             if (channels > 4)
> > > > > +                     regmap_write(i2s->regmap,
> > > > > +                                  SUN8I_I2S_TX_CHAN_MAP_REG+8,
> > > > > 0x54);
> > > > > +             if (channels > 6)
> > > > > +                     regmap_write(i2s->regmap,
> > > > > +                                  SUN8I_I2S_TX_CHAN_MAP_REG+12,
> > > > > 0x76);
> > > > > +     }
> > > > 
> > > > And this creates a mapping matching that.
> > > > 
> > > > >       /* Configure the channels */
> > > > >       regmap_field_write(i2s->field_txchansel,
> > > > > 
> > > > > @@ -1057,9 +1077,10 @@ static int
> > > > > sun4i_i2s_init_regmap_fields(struct device *dev,> > > > 
> > > > >  static int sun4i_i2s_probe(struct platform_device *pdev)
> > > > >  {
> > > > >  
> > > > >       struct sun4i_i2s *i2s;
> > > > > 
> > > > > +     struct snd_soc_dai_driver *soc_dai;
> > > > > 
> > > > >       struct resource *res;
> > > > >       void __iomem *regs;
> > > > > 
> > > > > -     int irq, ret;
> > > > > +     int irq, ret, val;
> > > > > 
> > > > >       i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
> > > > >       if (!i2s)
> > > > > 
> > > > > @@ -1126,6 +1147,19 @@ static int sun4i_i2s_probe(struct
> > > > > platform_device *pdev)> > > > 
> > > > >       i2s->capture_dma_data.addr = res->start +
> > > > >       SUN4I_I2S_FIFO_RX_REG;
> > > > >       i2s->capture_dma_data.maxburst = 8;
> > > > > 
> > > > > +     soc_dai = devm_kmemdup(&pdev->dev, &sun4i_i2s_dai,
> > > > > +                            sizeof(*soc_dai), GFP_KERNEL);
> > > > > +     if (!soc_dai) {
> > > > > +             ret = -ENOMEM;
> > > > > +             goto err_pm_disable;
> > > > > +     }
> > > > > +
> > > > > +     if (!of_property_read_u32(pdev->dev.of_node,
> > > > > +                               "allwinner,playback-channels",
> > > > > &val)) {
> > > > > +             if (val >= 2 && val <= 8)
> > > > > +                     soc_dai->playback.channels_max = val;
> > > > > +     }
> > > > > +
> > > > 
> > > > I'm not quite sure how this works.
> > > > 
> > > > of_property_read_u32 will return 0, so you will enter in the
> > > > condition. But what happens if the property is missing?
> > > > 
> > > > Maxime
> > > > 
> > > > --
> > > > Maxime Ripard, Bootlin
> > > > Embedded Linux and Kernel engineering
> > > > https://bootlin.com
> > > 
> > > --
> > > You received this message because you are subscribed to the Google
> > > Groups "linux-sunxi" group. To unsubscribe from this group and stop
> > > receiving emails from it, send an email to
> > > linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org To view this discussion on
> > > the web, visit
> > > https://groups.google.com/d/msgid/linux-sunxi/CAEKpxB%3DRdYF9eEvAJ%2BR7
> > > sT6OtdtBWjhMM1am%2BEhaN%3D9ZO9Gd2A%40mail.gmail.com. For more options,
> > > visit https://groups.google.com/d/optout.
