From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH 177/182] ASoC: wm5100: use gpiochip data
 pointer
Date: Thu, 10 Dec 2015 11:04:55 +0000
Message-ID: <20151210110455.GK6058@localhost.localdomain>
References: <1449669089-7167-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449669089-7167-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, Johan Hovold <johan@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Michael Welling <mwelling@ieee.org>, Markus Pargmann <mpa@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 09, 2015 at 02:51:29PM +0100, Linus Walleij wrote:
> This makes the driver use the data pointer added to the gpio_chip
> to store a pointer to the state container instead of relying on
> container_of().
> 
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Liam/Mark: please ACK this so I can merge it into the GPIO tree.
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

I guess you probably still want an ack from Mark before applying
to the GPIO tree but for what is worth looks fine to me.

Thanks,
Charles
