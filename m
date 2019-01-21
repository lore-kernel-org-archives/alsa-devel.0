From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFT][PATCH v2] gpiolib: acpi: Introduce ACPI_GPIO_QUIRK_ONLY_GPIOIO
Date: Mon, 21 Jan 2019 14:03:09 +0100
Message-ID: <CACRpkdZAOaqPQkKzyNate3A67Ce0T+V7ig+Y3BV4ycx==U5jkQ@mail.gmail.com>
References: <20190109105245.25954-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109105245.25954-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 9, 2019 at 11:52 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> New quirk enforces search for GPIO based on its type,
> i.e. iterate over GpioIo resources only.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>
> - it was sent few weeks ago to Hans for testing, but better to re-test
> - it's supposed to go via ASoC subsystem due to recent changes made for
>   sound driver
>
> v2:
> - Expand explanation why this quirk might be needed (Mika)

I tried to apply this but it doesn't apply on the GPIO devel
branch.

I suppose because of Hans de Goede's
commit 72893f0c6bd399ce84e3c1c9fc69d234fe37d098
Author: Hans de Goede <hdegoede@redhat.com>
Date:   Mon Dec 31 21:55:21 2018 +0100

    gpiolib-acpi: Preserve non direction flags when updating gpiod_flags

Could you rebase and resend?

(Also pick up Mika's ACK.)

PS I'm a bit split about pure ACPI patches, part of me see it as an
"intel thing" so that you could very well collect it in the Intel
GPIO tree and send me pull requests, on the other hand it is
ACPI and sometimes applied in Rafael's tree. Maybe just as good
that I keep picking them separately like this?

Yours,
Linus Walleij
