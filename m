From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v3 1/9] ASoC: sun4i-i2s: Adjust
 regmap settings
Date: Sun, 23 Dec 2018 11:16:31 +0800
Message-ID: <CAGb2v66q9NfgRGW=o-m2vYKyP=AJT9rx2A32iiwdGKuiGxWjYw@mail.gmail.com>
References: <20181221152110.17982-1-codekipper@gmail.com> <20181221152110.17982-2-codekipper@gmail.com>
 <CAGb2v66-JmONW9AYqoSmifrEj+nstREdsbkcy9ECwnJ47zxARA@mail.gmail.com> <DB7PR03MB46813005FFDFC8609F67F111ACB90@DB7PR03MB4681.eurprd03.prod.outlook.com>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBBHX47PQAKGQE2KXJCJY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <DB7PR03MB46813005FFDFC8609F67F111ACB90-qmxCgCjGUkLCt975IqKlAceAHadYHfrlvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Jonas Karlman <jonas-uIzNG4q0ceqzQB+pC5nmwQ@public.gmane.org>
Cc: Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Andrea Venturi (pers)" <be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 23, 2018 at 6:12 AM Jonas Karlman <jonas-uIzNG4q0ceqzQB+pC5nmwQ@public.gmane.org> wrote:
>
> On 2018-12-21 17:44, Chen-Yu Tsai wrote:
> > On Fri, Dec 21, 2018 at 11:21 PM <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >> From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >>
> >> Bypass the regmap cache when flushing the i2s FIFOs and modify the tables
> >> to reflect this.
> >>
> >> Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> ---
> >>  sound/soc/sunxi/sun4i-i2s.c | 29 +++++++++--------------------
> >>  1 file changed, 9 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> >> index d5ec1a20499d..64d073cb2aee 100644
> >> --- a/sound/soc/sunxi/sun4i-i2s.c
> >> +++ b/sound/soc/sunxi/sun4i-i2s.c
> >> @@ -548,9 +548,11 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> >>  static void sun4i_i2s_start_capture(struct sun4i_i2s *i2s)
> >>  {
> >>         /* Flush RX FIFO */
> >> +       regcache_cache_bypass(i2s->regmap, true);
> >>         regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
> >>                            SUN4I_I2S_FIFO_CTRL_FLUSH_RX,
> >>                            SUN4I_I2S_FIFO_CTRL_FLUSH_RX);
> >> +       regcache_cache_bypass(i2s->regmap, false);
> > IIRC the flush cache bit is self-clearing. So you likely want to mark
> > this register as volatile. If it is marked as volatile, then all access
> > to that register bypasses the cache, so the regcache_cache_bypass calls
> > are unneeded.
>
> I helped test this together with Marcus and when I tested with this
> register marked
> as volatile audio started to stutter, still unclear why audio starts to
> stutter.

Sounds like we're missing something. However the only other time we
update this register is to set the FIFO mode.

> Without this cache bypass the flush TX/RX bits gets cached and flush
> happens unexpectedly
> resulting in multi channel audio getting mapped to wrong speaker.

This sounds like the flush is happening after DMA transfers and/or I2S
operations have started, disrupting the order of the audio samples. I
think that might be the case since the regcache is synced sequentially,
and the FIFO control register is after the enable bits. That would imply
that the device is taken out of runtime suspend after the .start_capture
or .start_playback callbacks. Not sure if that's the case, but that would
mean the bus clocks are still off at this point, and bypassing the cache
and updating the bits is basically moot.

I think there's something else happening here, but we need to figure it
out instead of papering over it with something that "just works" but
we don't know why it works.

> Other ASoC codecs and fsl_spdif.c seems to use similar cache bypass for
> reset/flush.

fsl_spdif.c does it when forcing a soft reset, which would reset all the
registers. It then does a cache sync, restoring any values set up. That's
not what we're doing here.

> >
> > However, looking at the code, the write would seem to be ignored if the
> > regmap is in the cache_only state. We only set this when the bus clock
> > is disabled. Under such a condition, bypassing the cache and forcing a
> > write would be unwise, as the system either drops the write, or stalls
> > altogether.
> >
> >>         /* Clear RX counter */
> >>         regmap_write(i2s->regmap, SUN4I_I2S_RX_CNT_REG, 0);
> >> @@ -569,9 +571,11 @@ static void sun4i_i2s_start_capture(struct sun4i_i2s *i2s)
> >>  static void sun4i_i2s_start_playback(struct sun4i_i2s *i2s)
> >>  {
> >>         /* Flush TX FIFO */
> >> +       regcache_cache_bypass(i2s->regmap, true);
> >>         regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
> >>                            SUN4I_I2S_FIFO_CTRL_FLUSH_TX,
> >>                            SUN4I_I2S_FIFO_CTRL_FLUSH_TX);
> >> +       regcache_cache_bypass(i2s->regmap, false);
> >>
> >>         /* Clear TX counter */
> >>         regmap_write(i2s->regmap, SUN4I_I2S_TX_CNT_REG, 0);
> >> @@ -703,13 +707,7 @@ static const struct snd_soc_component_driver sun4i_i2s_component = {
> >>
> >>  static bool sun4i_i2s_rd_reg(struct device *dev, unsigned int reg)
> >>  {
> >> -       switch (reg) {
> >> -       case SUN4I_I2S_FIFO_TX_REG:
> >> -               return false;
> >> -
> >> -       default:
> >> -               return true;
> >> -       }
> >> +       return true;
> > I don't understand why this is relevant. Do you need to read back from the TX
> > FIFO?
>
> This change was inspired by c66234cfedfc "ASoC: rockchip: i2s: fix
> playback after runtime resume" [1]
> On resume a cached sample would be written to FIFO_TX_REG unless it is
> marked volatile,
> the rockchip commit indicated that read is needed for volatile regs.
>
> [1]
> https://github.com/torvalds/linux/commit/c66234cfedfc3e6e3b62563a5f2c1562be09a35d

What about simply marking the FIFO registers as both unreadable and
unwritable, thus excluding them from the regmap? That should get rid
of any unwanted syncs. We are doing DMA transfers to/from them. Do we
need regmap access?

Either way this context should be provided in the commit log.

Regards
ChenYu

> >
> > If so, just drop the call-back altogether. If no callback is provided and no
> > rd_table is provided either, it defaults to all registers under max_register
> > (if max_register < 0) are readable.
> >
> > However this seems like it deserves to be a separate patch (where you explain
> > in the commit log why it's needed).
> >
> > Regards
> > ChenYu
> >
> >>  }
> >>
> >>  static bool sun4i_i2s_wr_reg(struct device *dev, unsigned int reg)
> >> @@ -728,6 +726,8 @@ static bool sun4i_i2s_volatile_reg(struct device *dev, unsigned int reg)
> >>  {
> >>         switch (reg) {
> >>         case SUN4I_I2S_FIFO_RX_REG:
> >> +       case SUN4I_I2S_FIFO_TX_REG:
> >> +       case SUN4I_I2S_FIFO_STA_REG:
> >>         case SUN4I_I2S_INT_STA_REG:
> >>         case SUN4I_I2S_RX_CNT_REG:
> >>         case SUN4I_I2S_TX_CNT_REG:
> >> @@ -738,23 +738,12 @@ static bool sun4i_i2s_volatile_reg(struct device *dev, unsigned int reg)
> >>         }
> >>  }
> >>
> >> -static bool sun8i_i2s_rd_reg(struct device *dev, unsigned int reg)
> >> -{
> >> -       switch (reg) {
> >> -       case SUN8I_I2S_FIFO_TX_REG:
> >> -               return false;
> >> -
> >> -       default:
> >> -               return true;
> >> -       }
> >> -}
> >> -
> >>  static bool sun8i_i2s_volatile_reg(struct device *dev, unsigned int reg)
> >>  {
> >>         if (reg == SUN8I_I2S_INT_STA_REG)
> >>                 return true;
> >>         if (reg == SUN8I_I2S_FIFO_TX_REG)
> >> -               return false;
> >> +               return true;
> >>
> >>         return sun4i_i2s_volatile_reg(dev, reg);
> >>  }
> >> @@ -809,7 +798,7 @@ static const struct regmap_config sun8i_i2s_regmap_config = {
> >>         .reg_defaults   = sun8i_i2s_reg_defaults,
> >>         .num_reg_defaults       = ARRAY_SIZE(sun8i_i2s_reg_defaults),
> >>         .writeable_reg  = sun4i_i2s_wr_reg,
> >> -       .readable_reg   = sun8i_i2s_rd_reg,
> >> +       .readable_reg   = sun4i_i2s_rd_reg,
> >>         .volatile_reg   = sun8i_i2s_volatile_reg,
> >>  };
> >>
> >> --
> >> 2.20.1
> >>
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
> >
