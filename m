From: Cheng-yi Chiang <cychiang@chromium.org>
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: max98927: Add reset-gpio support
Date: Mon, 17 Sep 2018 17:00:28 +0800
Message-ID: <CAFv8Nw+mVHroA599ofmK6pwtPQXgP823B2_FG4G0bm5EkNhdWw@mail.gmail.com>
References: <20180912121955.33048-1-cychiang@chromium.org> <20180912121955.33048-2-cychiang@chromium.org>
 <7aa3c049-5ba0-1db3-08c8-510da1cf779d@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7aa3c049-5ba0-1db3-08c8-510da1cf779d@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rohitkr@codeaurora.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Dylan Reid <dgreid@chromium.org>, Ryan Lee <ryans.lee@maximintegrated.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,
Do you have any concern about this patch ?

Thanks!
On Thu, Sep 13, 2018 at 12:47 AM Rohit Kumar <rohitkr@codeaurora.org> wrote:
>
>
>
> On 9/12/2018 5:49 PM, Cheng-Yi Chiang wrote:
> > Toggle reset line in max98927_i2c_probe.
> > Use a list to store max98927 instances so we do not toggle reset line
> > again if more than one instances share the same reset line.
> >
> > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
>
> > ---
> >   sound/soc/codecs/max98927.c | 78 +++++++++++++++++++++++++++++++++++++++++++++
> >   sound/soc/codecs/max98927.h |  2 ++
> >   2 files changed, 80 insertions(+)
> >
> > diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
> > index 941712058a8f5..789b27cdfd9e0 100644
> > --- a/sound/soc/codecs/max98927.c
> > +++ b/sound/soc/codecs/max98927.c
> > @@ -11,6 +11,7 @@
> >    */
> >
> >   #include <linux/acpi.h>
> > +#include <linux/delay.h>
> >   #include <linux/i2c.h>
> >   #include <linux/module.h>
> >   #include <linux/regmap.h>
> > @@ -24,6 +25,11 @@
> >   #include <sound/tlv.h>
> >   #include "max98927.h"
> >
> > +#define MAX98927_MIN_RESET_US 1
> > +#define MAX98927_RELEASE_RESET_DELAY_US 500
> > +
> > +static LIST_HEAD(reset_list);
> > +
> >   static struct reg_default max98927_reg[] = {
> >       {MAX98927_R0001_INT_RAW1,  0x00},
> >       {MAX98927_R0002_INT_RAW2,  0x00},
> > @@ -877,6 +883,54 @@ static void max98927_slot_config(struct i2c_client *i2c,
> >               max98927->i_l_slot = 1;
> >   }
> >
> > +static int max98927_i2c_toggle_reset(struct device *dev,
> > +                                  struct max98927_priv *max98927)
> > +{
> > +     /*
> > +      * If we do not have reset gpio, assume platform firmware
> > +      * controls the regulator and toggles it for us.
> > +      */
> > +     if (!max98927->reset_gpio)
> > +             return 0;
> > +
> > +     gpiod_set_value_cansleep(max98927->reset_gpio, 1);
> > +
> > +     /*
> > +      * We need to wait a bit before we are allowed to release reset GPIO.
> > +      */
> > +     usleep_range(MAX98927_MIN_RESET_US, MAX98927_MIN_RESET_US + 5);
> > +
> > +     gpiod_set_value_cansleep(max98927->reset_gpio, 0);
> > +
> > +     /*
> > +      * We need to wait a bit before I2C communication is available.
> > +      */
> > +     usleep_range(MAX98927_RELEASE_RESET_DELAY_US,
> > +                  MAX98927_RELEASE_RESET_DELAY_US + 5);
> > +
> > +     /*
> > +      * Release reset GPIO because we are not going to use it.
> > +      */
> > +     devm_gpiod_put(dev, max98927->reset_gpio);
> > +
> > +     return 0;
> > +}
> > +
> > +static bool max98927_is_first_to_reset(struct max98927_priv *max98927)
> > +{
> > +     struct max98927_priv *p;
> > +
> > +     if (!max98927->reset_gpio)
> > +             return false;
> > +
> > +     list_for_each_entry(p, &reset_list, list) {
> > +             if (max98927->reset_gpio == p->reset_gpio)
> > +                     return false;
> > +     }
> > +
> > +     return true;
> > +}
> > +
> >   static int max98927_i2c_probe(struct i2c_client *i2c,
> >       const struct i2c_device_id *id)
> >   {
> > @@ -904,6 +958,28 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
> >       } else
> >               max98927->interleave_mode = 0;
> >
> > +     /* Gets optional GPIO for reset line. */
> > +     max98927->reset_gpio = devm_gpiod_get_optional(
> > +                     &i2c->dev, "reset", GPIOD_OUT_LOW);
> > +     if (IS_ERR(max98927->reset_gpio)) {
> > +             ret = PTR_ERR(max98927->reset_gpio);
> > +             dev_err(&i2c->dev, "error getting reset gpio: %d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     /*
> > +      * Only toggle reset line for the first instance when the
> > +      * reset line is shared among instances. For example,
> > +      * left and right amplifier share the same reset line, and
> > +      * we should only toggle the reset line once.
> > +      */
> > +     if (max98927_is_first_to_reset(max98927)) {
> > +             dev_info(&i2c->dev, "%s: toggle reset line\n", __func__);
> > +             ret = max98927_i2c_toggle_reset(&i2c->dev, max98927);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> >       /* regmap initialization */
> >       max98927->regmap
> >               = devm_regmap_init_i2c(i2c, &max98927_regmap);
> > @@ -934,6 +1010,8 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
> >       if (ret < 0)
> >               dev_err(&i2c->dev, "Failed to register component: %d\n", ret);
> >
> > +     list_add(&max98927->list, &reset_list);
> > +
> >       return ret;
> >   }
> >
> > diff --git a/sound/soc/codecs/max98927.h b/sound/soc/codecs/max98927.h
> > index 538992a238b28..d48f61f6c3ba5 100644
> > --- a/sound/soc/codecs/max98927.h
> > +++ b/sound/soc/codecs/max98927.h
> > @@ -275,5 +275,7 @@ struct max98927_priv {
> >       unsigned int master;
> >       unsigned int digital_gain;
> >       bool tdm_mode;
> > +     struct gpio_desc *reset_gpio;
> > +     struct list_head list;
> >   };
> >   #endif
>
