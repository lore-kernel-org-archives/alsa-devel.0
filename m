From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFT][PATCH v2] gpiolib: acpi: Introduce
 ACPI_GPIO_QUIRK_ONLY_GPIOIO
Date: Fri, 25 Jan 2019 19:46:46 +0200
Message-ID: <20190125174646.GS9224@smile.fi.intel.com>
References: <20190109105245.25954-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdZAOaqPQkKzyNate3A67Ce0T+V7ig+Y3BV4ycx==U5jkQ@mail.gmail.com>
 <20190125174442.GR9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C2E32666B3
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 18:46:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20190125174442.GR9224@smile.fi.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Jie Yang <yang.jie@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 25, 2019 at 07:44:42PM +0200, Andy Shevchenko wrote:
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

Perhaps Mark can provide you an immutable branch to be merged.

> > (Also pick up Mika's ACK.)
> > 
> > PS I'm a bit split about pure ACPI patches, part of me see it as an
> > "intel thing" so that you could very well collect it in the Intel
> > GPIO tree and send me pull requests, on the other hand it is
> > ACPI and sometimes applied in Rafael's tree. Maybe just as good
> > that I keep picking them separately like this?

I dunno. Let Mika speak up.

-- 
With Best Regards,
Andy Shevchenko
