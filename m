From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH v2 10/18] pinctrl: madera: Add driver for Cirrus Logic
 Madera codecs
Date: Sat, 20 May 2017 16:06:23 -0400
Message-ID: <CAP=VYLrOdpyOzKJsG0vJwOWP5eEnxuG55naTzi-cB2DhG36=7A@mail.gmail.com>
References: <1493050124-5970-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1493050124-5970-11-git-send-email-rf@opensource.wolfsonmicro.com> <CACRpkdZPoZ0VK=UYsa=T7A_LXHZnULv+yKKFXCEomG+eozkfPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZPoZ0VK=UYsa=T7A_LXHZnULv+yKKFXCEomG+eozkfPQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "open list:WOLFSON MICROELECTRONICS DRIVERS" <patches@opensource.wolfsonmicro.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 28, 2017 at 3:39 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Apr 24, 2017 at 6:08 PM, Richard Fitzgerald
> <rf@opensource.wolfsonmicro.com> wrote:
>
>> These codecs have a variable number of I/O lines each of which
>> is individually selectable to a wide range of possible functions.
>>
>> The functionality is slightly different from the traditional muxed
>> GPIO since most of the functions can be mapped to any pin (and even
>> the same function to multiple pins). Most pins have a dedicated
>> "alternate" function that is only available on that pin. The
>> alternate functions are usually a group of signals, though it is
>> not always necessary to enable the full group, depending on the
>> alternate function and how it is to be used. The mapping between
>> alternate functions and GPIO pins varies between codecs depending
>> on the number of alternate functions and available pins.
>>
>> Note on the Kconfig options:
>> The formula "default y if..." is used for PINCTRL_MADERA so that its
>> select options will be processed, allowing us to group selects for
>> pinctrl into the pinctrl Kconfig where they logically belong instead
>> of accumulating under the parent MFD Kconfig.
>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
>> ---
>> Changes since V1:
>> - dt binding moved to separate patch
>> - moved all source into a subdirectory drivers/pinctrl/cirrus
>> - split chip-specific tables into separate files
>> - codec-specific build options are now selected from MFD
>> - print useful information from madera_pin_dbg_show()
>> - added gpio_set_direciton / gpio_request_enable / gpio_disable_free functions
>> - added strict mode so GPIO and other functions are exclusive
>> - replace #ifdefs with if (IS_ENABLED(...)) in probe
>> - fixed bug reading registers in madera_pin_conf_get()
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

If this hasn't been merged yet, can we get rid of all the
MODULE / module references, since the Kconfigs are
all bool type and hence we shouldn't need to use them.

Alternatively we can do it in a follow-on patch if needed.

Thanks,
Paul.
--

>
> I guess you will apply this through MFD, so waiting for Lee to
> pick it up. Alternatively I can apply it after the MFD core parts
> are upstream.
>
> Yours,
> Linus Walleij
