From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3] gpiolib: acpi: Introduce
	ACPI_GPIO_QUIRK_ONLY_GPIOIO
Date: Fri, 8 Feb 2019 15:51:56 +0100
Message-ID: <CACRpkdbewwKFzHLz8Ok5Kh9gijK-AtKUykTKL1fdQ=zAWYDCoQ@mail.gmail.com>
References: <20190206204946.61730-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
 [209.85.167.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C4C02267483
 for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2019 15:52:28 +0100 (CET)
Received: by mail-lf1-f65.google.com with SMTP id q12so2763627lfm.0
 for <alsa-devel@alsa-project.org>; Fri, 08 Feb 2019 06:52:28 -0800 (PST)
In-Reply-To: <20190206204946.61730-1-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 6, 2019 at 9:49 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> New quirk enforces search for GPIO based on its type,
> i.e. iterate over GpioIo resources only.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Tested-by: Hans de Goede <hdegoede@redhat.com>

I suppose I ACKed that because it needed to be applied in some
other tree (sorry for short teflon-type memory...)

If I should just apply it, tell me!

Yours,
Linus Walleij
