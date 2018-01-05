From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/3] ACPI / utils: Introduce acpi_dev_get_dev_name()
Date: Fri, 5 Jan 2018 13:06:35 +0100
Message-ID: <CAJZ5v0ih7RCPCdmVyn-RV39pUmZvodZs9S9-Av_ucY4mZ7vTrA@mail.gmail.com>
References: <20180104164709.64387-1-andriy.shevchenko@linux.intel.com> <20180104164709.64387-2-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20180104164709.64387-2-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Erik Schmauss <erik.schmauss@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 4, 2018 at 5:47 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Sometimes the user want to have device name of the match rather than
> just checking if device present or not.

I would give an example here.

> To make life easier for such
> users introduce acpi_dev_get_dev_name()

What about acpi_dev_get_match_name() or just acpi_dev_match_name()?

> helper based on code for
> acpi_dev_present().
>
> To be more consistent with the purpose rename
>
>   struct acpi_dev_present_info  -> struct acpi_dev_match_info
>   acpi_dev_present_cb()         -> acpi_dev_match_cb()
>
> in the utils.c file.

OK

Thanks,
Rafael
