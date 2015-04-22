From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH 7/8] ASoC: wm8998: Initial WM8998 codec driver
Date: Wed, 22 Apr 2015 21:46:55 +0200
Message-ID: <1429732015.9081.38.camel@x220>
References: <1429619636-25478-1-git-send-email-rf@opensource.wolfsonmicro.com>
	 <1429619636-25478-8-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429619636-25478-8-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: lee.jones@linaro.org, broonie@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

A license mismatch is all I spotted.

On Tue, 2015-04-21 at 13:33 +0100, Richard Fitzgerald wrote:
> --- /dev/null
> +++ b/sound/soc/codecs/wm8998.c

> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

This states the license is GPL v2.

> +MODULE_LICENSE("GPL");

And, according to include/linux/module.h, this states the license is GPL
v2 or later. So I think either the comment at the top of this file or
the license ident used in the MODULE_LICENSE() macro needs to change.


Paul Bolle
