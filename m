From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/5] Introduce a managed function for gpio_request_array
Date: Wed, 9 Jul 2014 12:14:42 +0200
Message-ID: <CACRpkdYbK3tizezXNaTBT6ANQ8fxoBUH5OATpb5cLykQqRSuKA@mail.gmail.com>
References: <cover.1404665589.git.himangi774@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <cover.1404665589.git.himangi774@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Himangi Saraogi <himangi774@gmail.com>, Alexandre Courbot <gnurou@gmail.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, patches@opensource.wolfsonmicro.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Eric Miao <eric.y.miao@gmail.com>, Russell King <linux@arm.linux.org.uk>, Haojian Zhuang <haojian.zhuang@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Philipp Zabel <philipp.zabel@gmail.com>, Paul Parsons <lost.distance@yahoo.com>, Julia Lawall <julia.lawall@lip6.fr>
List-Id: alsa-devel@alsa-project.org

On Sun, Jul 6, 2014 at 7:46 PM, Himangi Saraogi <himangi774@gmail.com> wrote:

> This patchset intoduces a new managed interface devm_gpio_request_array,
> adds it in the documentation and its declaration in the gpio.h include
> file. Some cases of gpio_request_array are changed to
> devm_gpio_request_array.
>
> Himangi Saraogi (5):
>   gpiolib: devres: Introduce the function devm_request_gpio_array
>   ASoC: wm1250-ev1: Use devm_gpio_request_array
>   ASoC: pxa: Use devm_gpio_request_array
>   ASoC: pxa: e800_wm9712: Introduce the use of devm_gpio_request_array
>   ASoC: pxa/hx4700: Introduce the use of devm_gpio_request_array

Sorry, we're not encouraging extension of the old gpio* plain API anymore.

The right thing to do is convert users over to using GPIO descriptors
internally, then introduce devm_gpiod_get_array() if that makes some
sense.

Alexandre, what do you say?

Yours,
Linus Walleij
