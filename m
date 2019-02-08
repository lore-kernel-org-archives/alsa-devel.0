From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3] gpiolib: acpi: Introduce
	ACPI_GPIO_QUIRK_ONLY_GPIOIO
Date: Fri, 8 Feb 2019 18:53:41 +0200
Message-ID: <20190208165341.GS9224@smile.fi.intel.com>
References: <20190206204946.61730-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdbewwKFzHLz8Ok5Kh9gijK-AtKUykTKL1fdQ=zAWYDCoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id BB038267A29
 for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2019 17:53:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CACRpkdbewwKFzHLz8Ok5Kh9gijK-AtKUykTKL1fdQ=zAWYDCoQ@mail.gmail.com>
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
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 08, 2019 at 03:51:56PM +0100, Linus Walleij wrote:
> On Wed, Feb 6, 2019 at 9:49 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > New quirk enforces search for GPIO based on its type,
> > i.e. iterate over GpioIo resources only.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > Tested-by: Hans de Goede <hdegoede@redhat.com>
> 
> I suppose I ACKed that because it needed to be applied in some
> other tree (sorry for short teflon-type memory...)

I still hope Mark will apply to ASoC tree.
Mark?


-- 
With Best Regards,
Andy Shevchenko
