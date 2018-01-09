From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 1/3] ACPI / utils: Introduce acpi_dev_get_first_match_name()
Date: Tue, 09 Jan 2018 01:18:17 +0100
Message-ID: <3404188.B388fAZkns@aspire.rjw.lan>
References: <20180105160935.48588-1-andriy.shevchenko@linux.intel.com> <CAJZ5v0iH+2JHe8vCR9tQX62ULwx_eVd1QGPtinSLNDzWx1NmEg@mail.gmail.com> <1515416960.7000.784.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1515416960.7000.784.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Erik Schmauss <erik.schmauss@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, linux-gpio@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Monday, January 8, 2018 2:09:20 PM CET Andy Shevchenko wrote:
> On Sat, 2018-01-06 at 00:27 +0100, Rafael J. Wysocki wrote:
> > On Fri, Jan 5, 2018 at 5:09 PM, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > Sometimes the user wants to have device name of the match rather
> > > than
> > > just checking if device present or not. To make life easier for such
> > > users introduce acpi_dev_get_first_match_name() helper based on code
> > > for acpi_dev_present().
> > > 
> > > For example, GPIO driver for Intel Merrifield needs to know the
> > > device
> > > name of pin control to be able to apply GPIO mapping table to the
> > > proper
> > > device.
> > > 
> > > To be more consistent with the purpose rename
> > > 
> > >   struct acpi_dev_present_info  -> struct acpi_dev_match_info
> > >   acpi_dev_present_cb()         -> acpi_dev_match_cb()
> > > 
> > > in the utils.c file.
> > > 
> > > Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.co
> > > m>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > OK, so which way do you want this to go in?
> 
> If you have no objections, patch 1 may go straight forward to linux-pm
> tree as far as you are okay with the contents.
> 
> I dunno, if Mika's ACK is enough to you to get the second one (patch 2)
> together, otherwise Linus' ACK would be needed or leave it for next
> cycle.
> 
> According to what Mark and Pierre told previously I guess we just
> postpone patch 3 for next cycle.

OK

Linus, can you please have a look at the [2/3] from this lot and let me know
whether or not I can take it?

Thanks,
Rafael

