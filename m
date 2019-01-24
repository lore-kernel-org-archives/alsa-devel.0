From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [alsa-devel] [RFT][PATCH v2] gpiolib: acpi: Introduce ACPI_GPIO_QUIRK_ONLY_GPIOIO
Date: Fri, 25 Jan 2019 00:52:56 +0200
Message-ID: <CAHp75VfHTiPnOqT3ONq_bW8=ceCRFebuogsH9xVOc=S4nKdnOw@mail.gmail.com>
References: <20190109105245.25954-1-andriy.shevchenko@linux.intel.com> <e5e54be2-7be1-9496-b455-336e9edfb406@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e5e54be2-7be1-9496-b455-336e9edfb406@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 24, 2019 at 2:20 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 09-01-19 11:52, Andy Shevchenko wrote:
> > New quirk enforces search for GPIO based on its type,
> > i.e. iterate over GpioIo resources only.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >
> > - it was sent few weeks ago to Hans for testing, but better to re-test
>
> I've just re-tested this on a device which uses the speaker-enable
> GPIO with a rt5651 codec, still works as advertised:
>
> Tested-by: Hans de Goede <hdegoede@redhat.com>

Thanks, Hans, I will resend it rebased and with tags tomorow.
-- 
With Best Regards,
Andy Shevchenko
