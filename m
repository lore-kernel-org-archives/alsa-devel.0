From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RFT][PATCH v1] gpiolib: acpi: Introduce
 ACPI_GPIO_QUIRK_ONLY_GPIOIO
Date: Wed, 9 Jan 2019 11:20:58 +0200
Message-ID: <20190109092058.GD2469@lahna.fi.intel.com>
References: <20190108180205.55109-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190108180205.55109-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 08, 2019 at 08:02:05PM +0200, Andy Shevchenko wrote:
> New quirk enforces search for GPIO based on its type.
> Note, supplied index in the mapping table must be 0.

Can you document this where you define the new flag so new users do not
need go through git history?

Otherwise looks good. :)
