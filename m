From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 01/16] mfd: madera: Add register definitions for Cirrus
 Logic Madera codecs
Date: Fri, 7 Apr 2017 10:27:56 +0200
Message-ID: <CACRpkdaYzPSVqqhbi2Zop7J9vzCqZZiN=9pAEw1vcWy_ove9Tg@mail.gmail.com>
References: <1491386884-30689-1-git-send-email-rf@opensource.wolfsonmicro.com> <1491386884-30689-2-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1491386884-30689-2-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "open list:WOLFSON MICROELECTRONICS DRIVERS" <patches@opensource.wolfsonmicro.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 5, 2017 at 12:07 PM, Richard Fitzgerald
<rf@opensource.wolfsonmicro.com> wrote:

> This patch adds a header file of register definitions for Cirrus
> Logic "Madera" class codecs. These codecs are all based off a common
> set of hardware IP so have a common register map (with a few minor
> device-to-device variations). These are complex devices with a large
> mber of features and so have a correspondingly large register set.
> The registers.h file has been auto-generated from the hardware register
> definitions, stripped down to only registers we need to access from
> the driver.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>

This:
 include/linux/mfd/madera/registers.h | 8832 ++++++++++++++++++++++++++++++++++

Get included in all subdrivers I suppose?

So you are broadcasting 8800+ lines into every subdriver across the
entire kernel.

Just the time spent in the preprocessor parsing this will affect compilation
time.

Please implement separation of concerns. Move the register definitions into
the drivers, and if they are too large, atleast make a local include file in
sound/soc for the codec parts so the GPIO subdriver does not have
to churn through all this to get its job done.

I know there are other MFD drivers doing this but it's not a good pattern.

Yours,
Linus Walleij
