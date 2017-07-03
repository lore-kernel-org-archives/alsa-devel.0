From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH 2/6] clk: at91: add audio pll clock driver
Date: Mon, 3 Jul 2017 16:01:40 +0200
Message-ID: <20170703160140.6959bad8@bbrezillon>
References: <20170623090059.8371-1-quentin.schulz@free-electrons.com>
 <20170623090059.8371-3-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D018266B38
 for <alsa-devel@alsa-project.org>; Mon,  3 Jul 2017 16:01:41 +0200 (CEST)
In-Reply-To: <20170623090059.8371-3-quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, thomas.petazzoni@free-electrons.com, lgirdwood@gmail.com, Nicolas Ferre <nicolas.ferre@atmel.com>, mturquette@baylibre.com, tiwai@suse.com, sboyd@codeaurora.org, nicolas.ferre@microchip.com, linux@armlinux.org.uk, robh+dt@kernel.org, alexandre.belloni@free-electrons.com, broonie@kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, 23 Jun 2017 11:00:55 +0200
Quentin Schulz <quentin.schulz@free-electrons.com> wrote:

> From: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> This new clock driver set allows to have a fractional divided clock that
> would generate a precise clock particularly suitable for audio
> applications.
> 
> The main audio pll clock has two children clocks: one that is connected
> to the PMC, the other that can directly drive a pad. As these two routes
> have different enable bits and different dividers and divider formula,
> they are handled by two different drivers. Each of them could modify the
> rate of the main audio pll parent.
> The main audio pll clock can output 620MHz to 700MHz.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  .../devicetree/bindings/clock/at91-clock.txt       |  10 +

As already mentioned by Alex, DT bindings should go in a separate patch

>  arch/arm/mach-at91/Kconfig                         |   4 +
>  drivers/clk/at91/Makefile                          |   2 +
>  drivers/clk/at91/clk-audio-pll-pad.c               | 204 ++++++++++++++++++
>  drivers/clk/at91/clk-audio-pll-pmc.c               | 175 +++++++++++++++
>  drivers/clk/at91/clk-audio-pll.c                   | 237 +++++++++++++++++++++
>  include/linux/clk/at91_pmc.h                       |  25 +++
>  sound/soc/atmel/atmel-classd.c                     |  20 +-

Same goes for the atmel-classd changes.

>  8 files changed, 658 insertions(+), 19 deletions(-)
>  create mode 100644 drivers/clk/at91/clk-audio-pll-pad.c
>  create mode 100644 drivers/clk/at91/clk-audio-pll-pmc.c
>  create mode 100644 drivers/clk/at91/clk-audio-pll.c
> 

[...]

> diff --git a/drivers/clk/at91/clk-audio-pll-pmc.c b/drivers/clk/at91/clk-audio-pll-pmc.c
> new file mode 100644
> index 000000000000..208d0b59eb4e
> --- /dev/null
> +++ b/drivers/clk/at91/clk-audio-pll-pmc.c
> @@ -0,0 +1,175 @@
> +/*
> + *  Copyright (C) 2016 Atmel Corporation,
> + *                     Nicolas Ferre <nicolas.ferre@atmel.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + */
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk/at91_pmc.h>
> +#include <linux/of.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +
> +#include "pmc.h"
> +
> +/*
> + * DOC: PMC output for fractional PLL clock for audio
> + *
> + * Traits of this clock:
> + * enable - clk_enable writes qdpmc, and enables PMC output
> + * rate - rate is adjustable.
> + *        clk->rate = parent->rate / (qdpmc + 1)
> + * parent - fixed parent.  No clk_set_parent support
> + */
> +
> +#define AUDIO_PLL_FOUT_MIN		620000000
> +#define AUDIO_PLL_FOUT_MAX		700000000
> +#define AUDIO_PLL_REFERENCE_FOUT	660000000

These 3 macros are not unused, you can drop them.
