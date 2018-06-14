From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: codecs: PCM1789: include gpio/consumer.h
Date: Thu, 14 Jun 2018 16:44:38 +0200
Message-ID: <CACRpkdb-j4E8JL10i2-AQ4_ZWRu9NrMVaGJBbXwoFxufY60HUQ@mail.gmail.com>
References: <20180530215407.1196429-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180530215407.1196429-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@bootlin.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 30, 2018 at 11:53 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> When CONFIG_GPIOLIB is disabled, this codec fails to build
> because gpio/consumer.h is not included implicitly.
>
> sound/soc/codecs/pcm1789.c: In function 'pcm1789_common_init':
> sound/soc/codecs/pcm1789.c:247:19: error: implicit declaration of function 'devm_gpiod_get_optional'; did you mean 'devm_gpio_request_one'? [-Werror=implicit-function-declaration]
>   pcm1789->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>                    ^~~~~~~~~~~~~~~~~~~~~~~
>
> Fixes: 4ae340d1be36 ("ASoC: codecs: Add support for PCM1789")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
