From: Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 3/3] ASoC: sun4i-i2s: Adjust LRCLK width
Date: Tue, 27 Aug 2019 10:36:26 +0200
Message-ID: <CAEKpxBnCzC5hX+b4UMPpKLzKyABZ0e07RwZvULfauphzC4x7=A@mail.gmail.com>
References: <20190826180734.15801-1-codekipper@gmail.com> <20190826180734.15801-4-codekipper@gmail.com>
 <20190827070101.tastgcqvzrgv3kc5@flea>
Reply-To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCHNXO4F7MHBBFWXSPVQKGQENBLPA5Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20190827070101.tastgcqvzrgv3kc5@flea>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "Andrea Venturi (pers)" <be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 27 Aug 2019 at 09:01, Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
> On Mon, Aug 26, 2019 at 08:07:34PM +0200, codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> > From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >
> > Some codecs such as i2s based HDMI audio and the Pine64 DAC require
> > a different amount of bit clocks per frame than what is calculated
> > by the sample width. Use the values obtained by the tdm slot bindings
> > to adjust the LRCLK width accordingly.
> >
> > Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  sound/soc/sunxi/sun4i-i2s.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > index 056a299c03fb..0965a97c96e5 100644
> > --- a/sound/soc/sunxi/sun4i-i2s.c
> > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > @@ -455,7 +455,10 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
> >               break;
> >
> >       case SND_SOC_DAIFMT_I2S:
> > -             lrck_period = params_physical_width(params);
> > +             if (i2s->slot_width)
> > +                     lrck_period = i2s->slot_width;
> > +             else
> > +                     lrck_period = params_physical_width(params);
> >               break;
>
> That would be the case with the DSP formats too, right?

Maybe....but I need a TDM test volunteer!,
CK
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
