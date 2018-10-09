From: Cheng-yi Chiang <cychiang@chromium.org>
Subject: Re: [PATCH 2/2] ASoC: max98927: Add reset-gpio support
Date: Tue, 9 Oct 2018 21:46:53 +0800
Message-ID: <CAFv8NwLpS9r=jD2wyBsVgJJofkS1xJNo6YssgYXuVHDmGDLogg@mail.gmail.com>
References: <20180912121955.33048-1-cychiang@chromium.org> <20180912121955.33048-2-cychiang@chromium.org>
 <20180920161905.GM2471@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920161905.GM2471@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, p.zabel@pengutronix.de
Cc: linux-kernel@vger.kernel.org, Ryan Lee <ryans.lee@maximintegrated.com>, alsa-devel@alsa-project.org, Dylan Reid <dgreid@chromium.org>, tzungbi@chromium.org
List-Id: alsa-devel@alsa-project.org

+reset controller maintainer Philipp

Hi Mark,
  Sorry for the late reply. It took me a while to investigate reset
controller and its possible usage. I would like to figure out the
proper way of reset handling because it is common to have a shared
reset line for two max98927 codecs for left and right channels.
Without supporting this usage, a simple reset-gpios change for single
codec would not be useful, and perhaps will be duplicated if reset
controller is a better way.

Hi Philipp,
  I would like to seek your advice about whether we can use reset
controller to support the use case where multiple devices share the
same reset line.

Let me summarize the use case:
There are two max98927 codecs sharing the same reset line.
The reset line is controlled by a GPIO.
The goal is to toggle reset line once and only once.

There was a similar scenario in tlv320aic3x codec driver [1].
A static list is used in the codec driver so probe function can know
whether it is needed to toggle reset line.
Mark pointed out that it is not suitable to handle the shared reset
line inside codec driver.
A point is that this only works for multiple devices using the same
device driver.
He suggested to look into reset controller so I searched through the
usage for common reset line.

Here I found a shared reset line use case [2].
With the patch [2], reset_control_reset can support this =E2=80=9Creset onc=
e
and for all=E2=80=9D use case.

However, I found that there are some missing pieces:

Let=E2=80=99s assume there are two codecs c1 and c2 sharing a reset line
controlled by GPIO.

c1=E2=80=99s spec:
Hold time: The minimum time to assert the reset line is t_a1.
Release time: The minimum time to access the chip after deassert of
the reset line is t_d1.

c2=E2=80=99s spec:
Hold time: The minimum time to assert the reset line is t_a2.
Release time: The minimum time to access the chip after deassert of
the reset line is t_d2.

For both c1 and c2 to work properly, we need a reset controller that
can assert the reset line for
T =3D max(t_a1, t_a2).

1. We need reset controller to support GPIO.
2. We need to specify hold time T to reset controller in device tree
so it knows that it needs hold reset line for that long in its
implementation of reset_control_reset.
3. Assuming we have 1 and 2 in place. In codec driver of c1, it can
call reset_control_reset and wait for t_a1 + t_d1. In codec driver of
c2, it can call reset_control_reset and wait for t_a2 + t_d2.
    We need to wait for hold time + release time because
triggered_count is increased before reset ops is called. When the
second driver finds that triggered_count is 1 and skip the real reset
operation, reset ops might just begin doing its work a short time ago.
    I am not sure whether we would need a flag in reset controller to
mark that "reset is done". When driver sees this flag is done, it can
just wait for release time instead of hold time + release time.

And I found that you already solved 1 and mentioned the
possible usage of 2 in [3].
There were discussion about letting device driver to deal with
reset-gpios by itself in [4], but it seems that reset controller can
better deal with the shared reset line situation.
Maybe we could revive the patch of GPIO support for reset controller ?

Please let me know what direction I should look into.
Thanks a lot!

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2010-November/0332=
46.html
https://patchwork.kernel.org/patch/9424123/

[2] https://patchwork.kernel.org/patch/9424123/

[3] https://lore.kernel.org/patchwork/patch/455839/

[4] https://patchwork.kernel.org/patch/3978121/



On Fri, Sep 21, 2018 at 12:19 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Sep 12, 2018 at 08:19:55PM +0800, Cheng-Yi Chiang wrote:
>
> > +     /*
> > +      * Release reset GPIO because we are not going to use it.
> > +      */
> > +     devm_gpiod_put(dev, max98927->reset_gpio);
>
> There is no need to do this, it's still potentially useful information
> for userspace and it's also going to surprise anyone who tries to modify
> the code to use this function at some other time (eg, when coming out of
> suspend sometimes it's useful to reset the device).
>
> > @@ -934,6 +1010,8 @@ static int max98927_i2c_probe(struct i2c_client *i=
2c,
> >       if (ret < 0)
> >               dev_err(&i2c->dev, "Failed to register component: %d\n", =
ret);
> >
> > +     list_add(&max98927->list, &reset_list);
> > +
>
> I'm not seeing any locking of this list.  This also feels like something
> that shouldn't be in this driver but should be pushed up a level - it's
> only going to do the right thing if the reset line is only shared with
> other devices using this driver, if someone does something like put the
> CODEC and an external speaker amp on the same reset pin then it won't
> work.  I'm not sure where the best place to do that is; drivers/reset
> isn't really for this use case but feels right perhaps?
>
> Can you perhaps split the basic reset handling out from this list
> handling as a separate patch?
