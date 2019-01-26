From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFT][PATCH v2] gpiolib: acpi: Introduce ACPI_GPIO_QUIRK_ONLY_GPIOIO
Date: Sat, 26 Jan 2019 13:14:03 +0100
Message-ID: <CACRpkdZecFta8JaW85C0HyuH-LLD3bFsPf8DNna9o83OdkfU5w@mail.gmail.com>
References: <20190109105245.25954-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdZAOaqPQkKzyNate3A67Ce0T+V7ig+Y3BV4ycx==U5jkQ@mail.gmail.com> <20190125174442.GR9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125174442.GR9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 25, 2019 at 6:44 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, Jan 21, 2019 at 02:03:09PM +0100, Linus Walleij wrote:
> > On Wed, Jan 9, 2019 at 11:52 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> >
> > > New quirk enforces search for GPIO based on its type,
> > > i.e. iterate over GpioIo resources only.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >
> > > - it was sent few weeks ago to Hans for testing, but better to re-test
> > > - it's supposed to go via ASoC subsystem due to recent changes made for
> > >   sound driver
> > >
> > > v2:
> > > - Expand explanation why this quirk might be needed (Mika)
> >
> > I tried to apply this but it doesn't apply on the GPIO devel
> > branch.
> >
> > I suppose because of Hans de Goede's
> > commit 72893f0c6bd399ce84e3c1c9fc69d234fe37d098
> > Author: Hans de Goede <hdegoede@redhat.com>
> > Date:   Mon Dec 31 21:55:21 2018 +0100
> >
> >     gpiolib-acpi: Preserve non direction flags when updating gpiod_flags
> >
> > Could you rebase and resend?
>
> Linus, as I mentioned in comments above this should go via ASoC tree, there is
> no conflicts with gpio/devel for GPIO matters.
>
> So, please, give your Ack and hopefully Mark will apply this soon.

OK with me:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
