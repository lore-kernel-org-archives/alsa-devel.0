From: Grant Grundler <grundler@chromium.org>
Subject: Re: [PATCH] ASoC: max98373: Added max98373_reset for stable amp reset
Date: Mon, 26 Nov 2018 18:27:40 -0800
Message-ID: <CANEJEGs+ou+YyB503fyX9sqSzbp-EpykGo7OXgCNV0cW7RA0vA@mail.gmail.com>
References: <20181126183942.2631-1-ryans.lee@maximintegrated.com> <CANEJEGu30oPGRjeK2Sp1dUj4CuFjZeZ9+-2DRwhvmMLNex3p7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANEJEGu30oPGRjeK2Sp1dUj4CuFjZeZ9+-2DRwhvmMLNex3p7A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>
Cc: RyanS.Lee@maximintegrated.com, Liam Girdwood <lgirdwood@gmail.com>, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Benson Leung <bleung@chromium.org>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

I just realized I had one more question...

On Mon, Nov 26, 2018 at 6:24 PM Grant Grundler <grundler@chromium.org> wrote:
>
> Hi Ryan!
>
> Just some questions inline - in general I like the reset function.
>
> On Mon, Nov 26, 2018 at 10:46 AM Ryan Lee <RyanS.Lee@maximintegrated.com> wrote:
> >
> > Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
> > ---
> >  Changes : Created max98373_reset function to minimize code duplication.
> >            Changed regmap_write to regmap_update_bits. Other bits except LSB need to be masked.
> >            Added reset verification step to make sure software reset is completed well. Software reset is done in 10ms in normal case.
> >            Revision ID is available when the amp is in the idle state which means software reset is completed.

Why not poll the RevID register a few times until it gives a value?

Then structure the code to try reset twice (maybe three times).
This would avoid the unusual "sleep time after reset is increased" code.

cheers,
grant

> >            Software reset will be performed maximum 3 times to avoid amp reset failure. Generally it is done in the first trial.
> >            sleep time after software reset is increased + 30ms for every retrial. Maximum possible msleep time is 100 ms (initial 10 ms + 30 ms * 3 times).
>
> Why is the sleep time increased after each SW reset?
> What is the failure case that you've seen which would benefit from this?
>
> >
> >  sound/soc/codecs/max98373.c | 41 +++++++++++++++++++++++++++++++++++------
> >  1 file changed, 35 insertions(+), 6 deletions(-)
> >
> > diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
> > index a09d013..55af7f02 100644
> > --- a/sound/soc/codecs/max98373.c
> > +++ b/sound/soc/codecs/max98373.c
> > @@ -724,14 +724,45 @@ static struct snd_soc_dai_driver max98373_dai[] = {
> >         }
> >  };
> >
> > +static void max98373_reset(struct max98373_priv *max98373, struct device *dev)
> > +{
> > +       int ret, reg, count, delay;
> > +
> > +       count = 0;
> > +       while (true) {
> > +               /* Software Reset */
> > +               ret = regmap_update_bits(max98373->regmap,
> > +                       MAX98373_R2000_SW_RESET,
> > +                       MAX98373_SOFT_RESET,
> > +                       MAX98373_SOFT_RESET);
> > +               if (ret)
> > +                       dev_err(dev, "Reset command failed. (ret:%d)\n", ret);
> > +
> > +               delay = 10000 + (count * 30000);
> > +               usleep_range(delay, delay + 1000);
> > +
> > +               /* Software Reset Verification */
> > +               ret = regmap_read(max98373->regmap,
> > +                       MAX98373_R21FF_REV_ID, &reg);
> > +               if (!ret) {
> > +                       dev_info(dev, "Reset completed (retry:%d)\n", count);
> > +                       break;
>
> Instead of break, can the code return here?
> "break" implies something else will happen after the while loop exits
> - there isn't.
>
> > +               }
> > +
> > +               if (++count > 3)        {
> > +                       dev_err(dev, "Reset failed. (ret:%d)\n", ret);
> > +                       break;
> > +               }
> > +               usleep_range(10000, 11000);
>
> Why is there a second delay after reading MAX98373_R21FF_REV_ID?
> Is this really necessary?
>
> If the second usleep_range() isn't needed, it would be better/clearer
> to make code loop on "while (count < 4)".   And then outside the while
> loop, use dev_err() to share what the failure was.
>
> > +       }
> > +}
> > +
> >  static int max98373_probe(struct snd_soc_component *component)
> >  {
> >         struct max98373_priv *max98373 = snd_soc_component_get_drvdata(component);
> >
> >         /* Software Reset */
> > -       regmap_write(max98373->regmap,
> > -               MAX98373_R2000_SW_RESET, MAX98373_SOFT_RESET);
> > -       usleep_range(10000, 11000);
> > +       max98373_reset(max98373, component->dev);
> >
> >         /* IV default slot configuration */
> >         regmap_write(max98373->regmap,
> > @@ -818,9 +849,7 @@ static int max98373_resume(struct device *dev)
> >  {
> >         struct max98373_priv *max98373 = dev_get_drvdata(dev);
> >
> > -       regmap_write(max98373->regmap,
> > -               MAX98373_R2000_SW_RESET, MAX98373_SOFT_RESET);
> > -       usleep_range(10000, 11000);
> > +       max98373_reset(max98373, dev);
> >         regcache_cache_only(max98373->regmap, false);
> >         regcache_sync(max98373->regmap);
> >         return 0;
> > --
> > 2.7.4
> >
>
> cheers,
> grant
