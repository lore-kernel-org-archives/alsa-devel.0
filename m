From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 52/54] sound: soc: wm8903: Be sure to clamp return value
Date: Wed, 23 Dec 2015 09:50:22 +0000
Message-ID: <20151223095022.GX6058@localhost.localdomain>
References: <1450795849-28642-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450795849-28642-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 22, 2015 at 03:50:49PM +0100, Linus Walleij wrote:
> As we want gpio_chip .get() calls to be able to return negative
> error codes and propagate to drivers, we need to go over all
> drivers and make sure their return values are clamped to [0,1].
> We do this by using the ret = !!(val) design pattern.
> 
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: alsa-devel@alsa-project.org
> Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
