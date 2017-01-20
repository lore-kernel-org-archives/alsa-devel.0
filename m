From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v7 2/5] clk: x86: Add Atom PMC platform clocks
Date: Fri, 20 Jan 2017 15:58:56 -0800
Message-ID: <20170120235856.GF20800@codeaurora.org>
References: <1484690270-28425-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1484690270-28425-3-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484690270-28425-3-git-send-email-pierre-louis.bossart@linux.intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: linux-clk@vger.kernel.org, x86@kernel.org, platform-driver-x86@vger.kernel.org, Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, alsa-devel@alsa-project.org, Irina Tirdea <irina.tirdea@intel.com>, Michael Turquette <mturquette@baylibre.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Mark Brown <broonie@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

On 01/17, Pierre-Louis Bossart wrote:
> diff --git a/drivers/clk/x86/clk-pmc-atom.c b/drivers/clk/x86/clk-pmc-atom.c
> new file mode 100644
> index 0000000..312d4e9
> --- /dev/null
> +++ b/drivers/clk/x86/clk-pmc-atom.c
[...]
> +
> +static void plt_clk_reg_update(struct clk_plt *clk, u32 mask, u32 val)
> +{
> +	u32 tmp;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&clk->lock, flags);
> +
> +	tmp = clk_readl(clk->reg);

Do you need to use clk_readl? I'd prefer we deleted that
function/macro because it's just confusing. Please don't use it
unless you need it for some reason.

> +	tmp = (tmp & ~mask) | (val & mask);
> +	clk_writel(tmp, clk->reg);
> +
> +	spin_unlock_irqrestore(&clk->lock, flags);
> +}
> +
[..]
> +
> +static void plt_clk_unregister_parents(struct clk_plt_data *data)
> +{
> +	plt_clk_unregister_fixed_rate_loop(data, data->nparents);
> +}
> +
> +

Nitpick: Single newline please

> +static int plt_clk_probe(struct platform_device *pdev)
> +{
> +	const struct pmc_clk_data *pmc_data;
> +	const char **parent_names;
> +	struct clk_plt_data *data;
> +	unsigned int i;
> +	int err;
> +
> +	pmc_data = dev_get_platdata(&pdev->dev);
> +	if (!pmc_data || !pmc_data->clks)
> +		return -EINVAL;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	parent_names = plt_clk_register_parents(pdev, data, pmc_data->clks);
> +	if (IS_ERR(parent_names))
> +		return PTR_ERR(parent_names);
> +
> +	for (i = 0; i < PMC_CLK_NUM; i++) {
> +		data->clks[i] = plt_clk_register(pdev, i, pmc_data->base,
> +						 parent_names, data->nparents);
> +		if (IS_ERR(data->clks[i])) {
> +			err = PTR_ERR(data->clks[i]);
> +			goto err_unreg_clk_plt;
> +		}
> +	}
> +
> +	plt_clk_free_parent_names_loop(parent_names, data->nparents);
> +
> +	platform_set_drvdata(pdev, data);
> +	return 0;
> +
> +err_unreg_clk_plt:
> +	plt_clk_unregister_loop(data, i);
> +	plt_clk_unregister_parents(data);
> +	plt_clk_free_parent_names_loop(parent_names, data->nparents);
> +	return err;
> +}
> +
> +static int plt_clk_remove(struct platform_device *pdev)
> +{
> +	struct clk_plt_data *data;
> +
> +	data = platform_get_drvdata(pdev);
> +
> +	plt_clk_unregister_loop(data, PMC_CLK_NUM);
> +	plt_clk_unregister_parents(data);
> +	return 0;
> +}
> +
> +static struct platform_driver plt_clk_driver = {
> +	.driver = {
> +		.name = PLT_CLK_DRIVER_NAME,

Nitpick: Just put the string here

> +	},
> +	.probe = plt_clk_probe,
> +	.remove = plt_clk_remove,
> +};
> +builtin_platform_driver(plt_clk_driver);

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
