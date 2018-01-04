From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v2 1/3] ACPI / utils: Introduce
 acpi_dev_get_dev_name()
Date: Thu, 04 Jan 2018 19:40:27 +0200
Message-ID: <1515087627.7000.701.camel@linux.intel.com>
References: <20180104164709.64387-1-andriy.shevchenko@linux.intel.com>
         <20180104164709.64387-2-andriy.shevchenko@linux.intel.com>
         <aed928f3-452c-c0b8-bd93-b9921d72df67@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <aed928f3-452c-c0b8-bd93-b9921d72df67@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Erik Schmauss <erik.schmauss@intel.com>, linux-acpi@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2018-01-04 at 11:31 -0600, Pierre-Louis Bossart wrote:
> On 1/4/18 10:47 AM, Andy Shevchenko wrote:
> > Sometimes the user want to have device name of the match rather than
> > just checking if device present or not. To make life easier for such
> > users introduce acpi_dev_get_dev_name() helper based on code for
> > acpi_dev_present().
> > 
> > To be more consistent with the purpose rename
> > 
> >    struct acpi_dev_present_info  -> struct acpi_dev_match_info
> >    acpi_dev_present_cb()         -> acpi_dev_match_cb()
> > 
> > in the utils.c file.
> 
> I would have done this differently. You have two routines 
> (acpi_dev_present and acpi_dev_get_dev_name) which do the same thing 
> except for what they return (bool and const char *) respectively.

I have thought about it :-)

I decide that for two current users there is a little benefit over
effort and readability.

See also below.

> This could be factored with
> 
> static struct device *dev _acpi_dev_present(const char *hid, const
> char 
> *uid, s64 hrv) {
> 
> 	struct acpi_dev_present_info match = {};
> 	struct device *dev;
> 
> 	strlcpy(match.hid[0].id, hid, sizeof(match.hid[0].id));
> 	match.uid = uid;
> 	match.hrv = hrv;
> 
> 	dev = bus_find_device(&acpi_bus_type, NULL, &match,
> 		acpi_dev_present_cb);
> 	
> 	return dev;
> }
> 
> bool acpi_dev_present(const char *hid, const char *uid, s64 hrv)
> {
> 	return !!_acpi_dev_present(const char *hid, const char *uid, s64
> hrv);
> }
> 
> const char *acpi_dev_get_dev_name(const char *hid, const char *uid,
> s64 hrv)
> {
> 	struct device *dev;
> 
> 	dev = _acpi_dev_present(const char *hid, const char *uid, s64
> hrv);
> 
> 	return dev ? match.dev_name : NULL;

And where is the match declaration?

Yes, needs to be duplicated. That's why I stopped going this direction.

It still might make sense when 3+ variant will appear.

> }
> 
> That said you are a much better programmer than me so the other code
> is 
> fine with me...

Thanks.

Would be nice to get your Tested-by at some point.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
