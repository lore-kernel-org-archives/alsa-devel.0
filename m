From: Fletcher Woodruff <fletcherw@chromium.org>
Subject: Re: [PATCH v7 3/4] ASoC: rt5677: clear interrupts by polarity flip
Date: Tue, 18 Jun 2019 12:00:59 -0600
Message-ID: <CAN-6NYZzMqwDaw2oDyms4P9uKFPJvuQOtGbqMWLtFV3kDyQHJQ@mail.gmail.com>
References: <20190614194854.208436-1-fletcherw@chromium.org>
 <20190614194854.208436-4-fletcherw@chromium.org> <4e560e12-4c20-8d5d-b3f9-587a55da279d@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4e560e12-4c20-8d5d-b3f9-587a55da279d@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>, Curtis Malainey <cujomalainey@chromium.org>, Ross Zwisler <zwisler@chromium.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Jun 16, 2019 at 10:56 AM Cezary Rojewski
<cezary.rojewski@intel.com> wrote:
> On 2019-06-14 21:48, Fletcher Woodruff wrote:
> > +static irqreturn_t rt5677_irq(int unused, void *data)
> > +{
> > +     struct rt5677_priv *rt5677 = data;
> > +     int ret = 0, i, reg_irq, virq;
> > +     bool irq_fired = false;
> > +
> > +     mutex_lock(&rt5677->irq_lock);
> > +     /* Read interrupt status */
> > +     ret = regmap_read(rt5677->regmap, RT5677_IRQ_CTRL1, &reg_irq);
> > +     if (ret) {
> > +             pr_err("rt5677: failed reading IRQ status: %d\n", ret);
>
> The entire rt5677 makes use of dev_XXX with the exception of.. this very
> function. Consider reusing "component" field which is already part of
> struct rt5677_priv and removing pr_XXX.

I was using dev_XXX, but I believe Curtis found that 'component' was
sometimes uninitialized when this function was called, so I switched
back to pr_XXX. I may be misremembering though, so I'll let Curtis
comment as well.

> > +     if (ret) {
> > +             dev_err(&i2c->dev, "Failed to request IRQ: %d\n", ret);
> >               return ret;
>
> You may want to simplify this, similarly to how's it done in your
> rt5677_i2c_probe - leave message alone and return "ret" explicitly at
> the end.

Good suggestion. I'll update that for the next patch.
