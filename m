From: Cheng-yi Chiang <cychiang@chromium.org>
Subject: Re: [PATCH for-4.15] ASoC: rt5514: don't assume rt5514
	component was "attached"
Date: Mon, 18 Dec 2017 12:23:18 +0800
Message-ID: <CAFv8Nw+qiWedqZeVsPn17WiSyc_zwOP3bEnxn2Wc-oQ3ntgq2g@mail.gmail.com>
References: <20171216011230.107527-1-briannorris@chromium.org>
 <20171216031738.GA220575@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yb0-f196.google.com (mail-yb0-f196.google.com
 [209.85.213.196])
 by alsa0.perex.cz (Postfix) with ESMTP id F34E1267196
 for <alsa-devel@alsa-project.org>; Mon, 18 Dec 2017 05:23:50 +0100 (CET)
Received: by mail-yb0-f196.google.com with SMTP id 69so10159340ybc.6
 for <alsa-devel@alsa-project.org>; Sun, 17 Dec 2017 20:23:50 -0800 (PST)
In-Reply-To: <20171216031738.GA220575@google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Norris <briannorris@chromium.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jeffy Chen <jeffy.chen@rock-chips.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Matthias Kaehlcke <mka@chromium.org>
List-Id: alsa-devel@alsa-project.org

Hi Brian,
  Oder has posted the same fix : https://patchwork.kernel.org/
patch/10066257/ and it has been applied.
Perhaps you can cherry-pick it to v4.15 ?

Thanks!

On Sat, Dec 16, 2017 at 11:17 AM, Brian Norris <briannorris@chromium.org>
wrote:

> + others
>
> On Fri, Dec 15, 2017 at 05:12:30PM -0800, Brian Norris wrote:
> > I've found that on Google's "Kevin" Chromebook, the rt5514 codec might
> > not be set up completely, yet its device is still present, and therefore
> > its PM suspend/resume is called. This hits a NULL pointer exception,
> > since we never had the chance to set our drvdata pointer.
> >
> > This resolves crashes seen when trying to resume my system.
> >
> > Fixes: e9c50aa6bd39 ("ASoC: rt5514-spi: check irq status to schedule
> data copy in resume function")
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> > This is a v4.15-rc1 regression
>
> I see that this is probably a bug on its own, which should be fixed on
> its own (e.g., with the $subject patch), but FYI I was also pointed at
> this patch, which also "resolves" this problem by fixing the rt5514 DAI
> setup:
>
> https://patchwork.kernel.org/patch/10067725/
> [PATCH] ASoC: rockchip: Use dummy_dai for rt5514 dsp dailink
>
> Would be nice to see it get handled too, possibly in 4.15 as well (I
> think that's a regression too?).
>
> Brian
>
> >
> >  sound/soc/codecs/rt5514-spi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/codecs/rt5514-spi.c
> b/sound/soc/codecs/rt5514-spi.c
> > index 2df91db765ac..9255afcf2c3a 100644
> > --- a/sound/soc/codecs/rt5514-spi.c
> > +++ b/sound/soc/codecs/rt5514-spi.c
> > @@ -482,7 +482,7 @@ static int __maybe_unused rt5514_resume(struct
> device *dev)
> >       if (device_may_wakeup(dev))
> >               disable_irq_wake(irq);
> >
> > -     if (rt5514_dsp->substream) {
> > +     if (rt5514_dsp && rt5514_dsp->substream) {
> >               rt5514_spi_burst_read(RT5514_IRQ_CTRL, (u8 *)&buf,
> sizeof(buf));
> >               if (buf[0] & RT5514_IRQ_STATUS_BIT)
> >                       rt5514_schedule_copy(rt5514_dsp);
> > --
> > 2.15.1.504.g5279b80103-goog
> >
>
