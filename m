From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFT][PATCH v1] gpiolib: acpi: Introduce ACPI_GPIO_QUIRK_ONLY_GPIOIO
Date: Fri, 11 Jan 2019 15:21:39 +0100
Message-ID: <CACRpkdYgBsvNR1PFuzmMegpjraWRi58ACb-=mBrUDvLoi_5J_g@mail.gmail.com>
References: <20190108180205.55109-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190108180205.55109-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Hans de Goede <hdegoede@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 8, 2019 at 7:02 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> New quirk enforces search for GPIO based on its type.
> Note, supplied index in the mapping table must be 0.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

(...)

>  sound/soc/intel/boards/bytcr_rt5651.c | 74 ++++-----------------------

Do we have an ACK from the maintainer of this file?
It's Hans I think. Ideally also from Mark Brown.

Yours,
Linus Walleij
