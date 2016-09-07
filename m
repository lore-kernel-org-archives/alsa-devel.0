From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2] clk: x86: Add Atom PMC platform clocks
Date: Wed, 7 Sep 2016 16:52:27 -0700
Message-ID: <20160907235227.GB13062@codeaurora.org>
References: <1473266524-14786-1-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1473266524-14786-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-clk-owner@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: linux-clk@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 09/07, Irina Tirdea wrote:
> @@ -152,6 +155,17 @@
>  #define	SLEEP_TYPE_S5		0x1C00
>  #define	SLEEP_ENABLE		0x2000
>  
> +struct pmc_clk {
> +	const char *name;
> +	unsigned long freq;
> +	const char *parent_name;
> +};
> +
> +struct pmc_clk_data {
> +	void __iomem *base;
> +	const struct pmc_clk *clks;
> +};

Can you please put these structures in
include/linux/platform_data/ with some new file? That way we
don't need to have any architecture specific configuration to
test build the clk driver and we can drop the asm include fro
mthe clk driver too.

> diff --git a/drivers/clk/x86/Makefile b/drivers/clk/x86/Makefile
> index 0478138..cbdc8cc 100644
> --- a/drivers/clk/x86/Makefile
> +++ b/drivers/clk/x86/Makefile
> @@ -1,2 +1,3 @@
>  clk-x86-lpss-objs		:= clk-lpt.o
>  obj-$(CONFIG_X86_INTEL_LPSS)	+= clk-x86-lpss.o
> +obj-$(CONFIG_PMC_ATOM)		+= clk-byt-plt.o
> diff --git a/drivers/clk/x86/clk-byt-plt.c b/drivers/clk/x86/clk-byt-plt.c
> new file mode 100644
> index 0000000..ec98bdf
> --- /dev/null
> +++ b/drivers/clk/x86/clk-byt-plt.c
> @@ -0,0 +1,387 @@
> +/*
> + * Intel Atom platform clocks driver for BayTrail and CherryTrail SoC.
> + *
> + * Copyright (C) 2016, Intel Corporation
> + * Author: Irina Tirdea <irina.tirdea@intel.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/clkdev.h>
> +
> +#include <asm/pmc_atom.h>
> +
> +#define PLT_CLK_NAME_BASE	"pmc_plt_clk_"
> +#define PLT_CLK_DRIVER_NAME	"clk-byt-plt"
> +
> +#define PMC_CLK_CTL_SIZE	4
> +#define PMC_CLK_NUM		6
> +#define PMC_MASK_CLK_CTL	GENMASK(1, 0)
> +#define PMC_MASK_CLK_FREQ	BIT(2)
> +#define PMC_CLK_CTL_GATED_ON_D3	0x0
> +#define PMC_CLK_CTL_FORCE_ON	0x1
> +#define PMC_CLK_CTL_FORCE_OFF	0x2
> +#define PMC_CLK_CTL_RESERVED	0x3
> +#define PMC_CLK_FREQ_XTAL	0x0	/* 25 MHz */
> +#define PMC_CLK_FREQ_PLL	0x4	/* 19.2 MHz */
> +
> +struct clk_plt_fixed {
> +	struct clk *clk;

Hopefully this can be a clk_hw pointer instead.

> +	struct clk_lookup *lookup;
> +};
> +
[..]
> +
> +static void plt_clk_reg_update(struct clk_plt *clk, u32 mask, u32 val)
> +{
> +	u32 orig, tmp;
> +	unsigned long flags = 0;
> +
> +	spin_lock_irqsave(&clk->lock, flags);
> +
> +	orig = readl(clk->reg);
> +
> +	tmp = orig & ~mask;
> +	tmp |= val & mask;
> +
> +	if (tmp == orig)
> +		goto out;
> +
> +	writel(tmp, clk->reg);

Or just

	if (tmp != orig)
		writel(..)

> +
> +out:
> +	spin_unlock_irqrestore(&clk->lock, flags);
> +}
> +
[..]
> +
> +static struct clk_plt_fixed *plt_clk_register_fixed_rate(struct platform_device *pdev,
> +						 const char *name,
> +						 const char *parent_name,
> +						 unsigned long fixed_rate)
> +{
> +	struct clk_plt_fixed *pclk;
> +	int ret = 0;
> +
> +	pclk = devm_kzalloc(&pdev->dev, sizeof(*pclk), GFP_KERNEL);
> +	if (!pclk)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pclk->clk = clk_register_fixed_rate(&pdev->dev, name, parent_name,

clk_hw_register_fixed_rate?

> +					    0, fixed_rate);
> +	if (IS_ERR(pclk->clk)) {
> +		ret = PTR_ERR(pclk->clk);
> +		return ERR_PTR(ret);

Could be simplified to return ERR_CAST(pclk->clk);

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
