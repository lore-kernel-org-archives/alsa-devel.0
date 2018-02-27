From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v1 3/4] ASoC: codecs: pcm179x: Add reset gpio
Date: Tue, 27 Feb 2018 19:30:11 -0300
Message-ID: <CAOMZO5C+Ub2R6srR+2jv2pY8zwjwkPSecpO1gbXvmXMTTnhU8Q@mail.gmail.com>
References: <20180227212433.2189-1-mylene.josserand@bootlin.com> <20180227212433.2189-4-mylene.josserand@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180227212433.2189-4-mylene.josserand@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, alexandre.belloni@bootlin.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 27, 2018 at 6:24 PM, Myl=C3=A8ne Josserand
<mylene.josserand@bootlin.com> wrote:

> +       pcm179x->reset =3D of_get_named_gpio(np, "reset-gpios", 0);
> +       if (gpio_is_valid(pcm179x->reset)) {
> +               ret =3D devm_gpio_request_one(dev, pcm179x->reset,
> +                                           GPIOF_OUT_INIT_LOW,
> +                                           "pcm179x reset");
> +               if (ret) {
> +                       dev_err(dev,
> +                               "Failed to request GPIO %d as reset pin, =
error %d\n",
> +                               pcm179x->reset, ret);
> +                       return ret;
> +               }
> +
> +               gpio_set_value(pcm179x->reset, 1);

It would be better to use the gpiod API, which takes the GPIO polarity
into account.

There may be systems that have an inverter connected to this pin, and
this can be changed in dts via GPIO_ACTIVE_HIGH.

Also, as the reset pin can be connected to an I2C expander, for
example, so it is safer to use the cansleep variant:

gpiod_set_value_cansleep(pcm179x->reset, 0);
