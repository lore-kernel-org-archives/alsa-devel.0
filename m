From: John Keeping <john-HPTTJ/6qucUJ3nxcUk3PyQ@public.gmane.org>
Subject: Re: [PATCH 1/2] ASoC: rockchip: i2s: separate capture and playback
Date: Sat, 30 Apr 2016 08:00:49 +0100
Message-ID: <20160430070049.GF14612@serenity.lan>
References: <1449657147-26959-1-git-send-email-john@metanate.com>
 <CAFqH_52C4JKno4uyt54UdWKAJKM4FPGRiQaQQ9_H-Mz1Cr+Hqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFqH_52C4JKno4uyt54UdWKAJKM4FPGRiQaQQ9_H-Mz1Cr+Hqg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi Enric,

On Fri, Apr 29, 2016 at 04:59:27PM +0200, Enric Balletbo Serra wrote:
> 2015-12-09 11:32 GMT+01:00 John Keeping <john-HooS5bfzL4hWk0Htik3J/w@public.gmane.org>:
> > If we only clear the tx/rx state when both are disabled it is not
> > possible to start/stop one multiple times while the other is running.
> > Since the two are independently controlled, treat them as such and
> > remove the false dependency between capture and playback.
> >
> > Signed-off-by: John Keeping <john-HooS5bfzL4hWk0Htik3J/w@public.gmane.org>
> > ---
> >  sound/soc/rockchip/rockchip_i2s.c | 72 +++++++++++++++++----------------------
> >  1 file changed, 32 insertions(+), 40 deletions(-)
> >
> > diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
> > index 83b1b9c..acc6225 100644
> > --- a/sound/soc/rockchip/rockchip_i2s.c
> > +++ b/sound/soc/rockchip/rockchip_i2s.c
> > @@ -82,8 +82,8 @@ static void rockchip_snd_txctrl(struct rk_i2s_dev *i2s, int on)
> >                                    I2S_DMACR_TDE_ENABLE, I2S_DMACR_TDE_ENABLE);
> >
> >                 regmap_update_bits(i2s->regmap, I2S_XFER,
> > -                                  I2S_XFER_TXS_START | I2S_XFER_RXS_START,
> > -                                  I2S_XFER_TXS_START | I2S_XFER_RXS_START);
> > +                                  I2S_XFER_TXS_START,
> > +                                  I2S_XFER_TXS_START);
> >
> >                 i2s->tx_start = true;
> >         } else {
> > @@ -92,27 +92,23 @@ static void rockchip_snd_txctrl(struct rk_i2s_dev *i2s, int on)
> >                 regmap_update_bits(i2s->regmap, I2S_DMACR,
> >                                    I2S_DMACR_TDE_ENABLE, I2S_DMACR_TDE_DISABLE);
> >
> > -               if (!i2s->rx_start) {
> > -                       regmap_update_bits(i2s->regmap, I2S_XFER,
> > -                                          I2S_XFER_TXS_START |
> > -                                          I2S_XFER_RXS_START,
> > -                                          I2S_XFER_TXS_STOP |
> > -                                          I2S_XFER_RXS_STOP);
> > +               regmap_update_bits(i2s->regmap, I2S_XFER,
> > +                                  I2S_XFER_TXS_START,
> > +                                  I2S_XFER_TXS_STOP);
> >
> > -                       regmap_update_bits(i2s->regmap, I2S_CLR,
> > -                                          I2S_CLR_TXC | I2S_CLR_RXC,
> > -                                          I2S_CLR_TXC | I2S_CLR_RXC);
> > +               regmap_update_bits(i2s->regmap, I2S_CLR,
> > +                                  I2S_CLR_TXC,
> > +                                  I2S_CLR_TXC);
> >
> > -                       regmap_read(i2s->regmap, I2S_CLR, &val);
> > +               regmap_read(i2s->regmap, I2S_CLR, &val);
> >
> > -                       /* Should wait for clear operation to finish */
> > -                       while (val) {
> > -                               regmap_read(i2s->regmap, I2S_CLR, &val);
> > -                               retry--;
> > -                               if (!retry) {
> > -                                       dev_warn(i2s->dev, "fail to clear\n");
> > -                                       break;
> > -                               }
> > +               /* Should wait for clear operation to finish */
> > +               while (val & I2S_CLR_TXC) {
> > +                       regmap_read(i2s->regmap, I2S_CLR, &val);
> > +                       retry--;
> > +                       if (!retry) {
> > +                               dev_warn(i2s->dev, "fail to clear\n");
> > +                               break;
> >                         }
> >                 }
> >         }
> > @@ -128,8 +124,8 @@ static void rockchip_snd_rxctrl(struct rk_i2s_dev *i2s, int on)
> >                                    I2S_DMACR_RDE_ENABLE, I2S_DMACR_RDE_ENABLE);
> >
> >                 regmap_update_bits(i2s->regmap, I2S_XFER,
> > -                                  I2S_XFER_TXS_START | I2S_XFER_RXS_START,
> > -                                  I2S_XFER_TXS_START | I2S_XFER_RXS_START);
> > +                                  I2S_XFER_RXS_START,
> > +                                  I2S_XFER_RXS_START);
> >
> >                 i2s->rx_start = true;
> >         } else {
> > @@ -138,27 +134,23 @@ static void rockchip_snd_rxctrl(struct rk_i2s_dev *i2s, int on)
> >                 regmap_update_bits(i2s->regmap, I2S_DMACR,
> >                                    I2S_DMACR_RDE_ENABLE, I2S_DMACR_RDE_DISABLE);
> >
> > -               if (!i2s->tx_start) {
> > -                       regmap_update_bits(i2s->regmap, I2S_XFER,
> > -                                          I2S_XFER_TXS_START |
> > -                                          I2S_XFER_RXS_START,
> > -                                          I2S_XFER_TXS_STOP |
> > -                                          I2S_XFER_RXS_STOP);
> > +               regmap_update_bits(i2s->regmap, I2S_XFER,
> > +                                  I2S_XFER_RXS_START,
> > +                                  I2S_XFER_RXS_STOP);
> >
> > -                       regmap_update_bits(i2s->regmap, I2S_CLR,
> > -                                          I2S_CLR_TXC | I2S_CLR_RXC,
> > -                                          I2S_CLR_TXC | I2S_CLR_RXC);
> > +               regmap_update_bits(i2s->regmap, I2S_CLR,
> > +                                  I2S_CLR_RXC,
> > +                                  I2S_CLR_RXC);
> >
> > -                       regmap_read(i2s->regmap, I2S_CLR, &val);
> > +               regmap_read(i2s->regmap, I2S_CLR, &val);
> >
> > -                       /* Should wait for clear operation to finish */
> > -                       while (val) {
> > -                               regmap_read(i2s->regmap, I2S_CLR, &val);
> > -                               retry--;
> > -                               if (!retry) {
> > -                                       dev_warn(i2s->dev, "fail to clear\n");
> > -                                       break;
> > -                               }
> > +               /* Should wait for clear operation to finish */
> > +               while (val & I2S_CLR_RXC) {
> > +                       regmap_read(i2s->regmap, I2S_CLR, &val);
> > +                       retry--;
> > +                       if (!retry) {
> > +                               dev_warn(i2s->dev, "fail to clear\n");
> > +                               break;
> >                         }
> >                 }
> >         }
> > --
> > 2.6.3.462.gbe2c914
> 
> Using my Veyron Jerry Chromebook wiht latest kernel I found that the
> speakers doesn't work. Bisect points to this patch as the offending
> commit. However your changes looks reasonable the fact is that
> reverting the patch makes the audio work again on my device. I need to
> dig a bit more into the issue, but meanwhile, any idea on what is
> happening ? Can I ask which device did you test?

I tested this on a Radxa Rock2 square.  This change fixed an issue I
found when running separate processes for playback and recording (I was
testing with arecord and speaker-test IIRC) but I don't think that
should be relevant.  I just read through the patch again and I can't see
anything obviously wrong so I'm afraid I don't have any idea what's
causing the problem you're seeing.


John
