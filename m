From: Curtis Malainey <cujomalainey@google.com>
Subject: Re: [PATCH v7 3/4] ASoC: rt5677: clear interrupts by polarity flip
Date: Tue, 18 Jun 2019 12:10:10 -0700
Message-ID: <CAOReqxj+9WH70P5oDN12KdDqkX8Kp18NBdTswOZSC8u=AwS_LQ@mail.gmail.com>
References: <20190614194854.208436-1-fletcherw@chromium.org>
 <20190614194854.208436-4-fletcherw@chromium.org> <4e560e12-4c20-8d5d-b3f9-587a55da279d@intel.com>
 <CAN-6NYZzMqwDaw2oDyms4P9uKFPJvuQOtGbqMWLtFV3kDyQHJQ@mail.gmail.com>
 <CAOReqxhETC9xAojXyDWLMOJ3W22Zn4GNGry44=XC=t_k7SCHqA@mail.gmail.com> <20190618184710.GP5316@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190618184710.GP5316@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Fletcher Woodruff <fletcherw@chromium.org>, Cezary Rojewski <cezary.rojewski@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>, Curtis Malainey <cujomalainey@chromium.org>, Ross Zwisler <zwisler@chromium.org>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 18, 2019 at 11:47 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jun 18, 2019 at 11:12:58AM -0700, Curtis Malainey wrote:
> > On Tue, Jun 18, 2019 at 11:01 AM Fletcher Woodruff
> > > On Sun, Jun 16, 2019 at 10:56 AM Cezary Rojewski
> > > > On 2019-06-14 21:48, Fletcher Woodruff wrote:
>
> > > > > +     ret = regmap_read(rt5677->regmap, RT5677_IRQ_CTRL1, &reg_irq);
> > > > > +     if (ret) {
> > > > > +             pr_err("rt5677: failed reading IRQ status: %d\n", ret);
>
> > > > The entire rt5677 makes use of dev_XXX with the exception of.. this very
> > > > function. Consider reusing "component" field which is already part of
> > > > struct rt5677_priv and removing pr_XXX.
>
> > > I was using dev_XXX, but I believe Curtis found that 'component' was
> > > sometimes uninitialized when this function was called, so I switched
> > > back to pr_XXX. I may be misremembering though, so I'll let Curtis
> > > comment as well.
>
> > The issue here is that the IRQ is setup in the i2c probe and the
> > component is setup in the codec probe. In theory if the hardware is in
>
> The component is not needed for a struct device, you must have a struct
> device if you have a regmap or have probed at all.
Ah yes, we could modify the struct and store the i2c device and get
the device out of that as well. That will likely be simpler. Ok lets
do that.
