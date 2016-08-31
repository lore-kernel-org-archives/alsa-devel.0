From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] clk: x86: Add Atom PMC platform clocks
Date: Tue, 30 Aug 2016 17:37:22 -0700
Message-ID: <20160831003722.GH12510@codeaurora.org>
References: <1471459276-11517-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1471459276-11517-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Sender: linux-clk-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: linux-clk@vger.kernel.org, mturquette@baylibre.com, alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de, irina.tirdea@intel.com
List-Id: alsa-devel@alsa-project.org

On 08/17, Pierre-Louis Bossart wrote:
> @@ -414,6 +456,13 @@ static int pmc_setup_dev(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (ret)
>  		dev_warn(&pdev->dev, "debugfs register failed\n");
>  
> +	/* Register platform clocks - PMC_PLT_CLK [5:0] */
> +	clkdev = platform_device_register_data(NULL, "clk-byt-plt", -1,
> +					       &clks, sizeof(clks));

Shouldn't we register the clk device as a child of the
registering device? Otherwise it's just floating in the device
hierarchy?

> diff --git a/drivers/clk/x86/clk-byt-plt.c b/drivers/clk/x86/clk-byt-plt.c
> new file mode 100644
> index 0000000..330cd35
> --- /dev/null
> +++ b/drivers/clk/x86/clk-byt-plt.c
> @@ -0,0 +1,413 @@
> +
> +static int plt_pmc_atom_update(struct clk_plt *clk, u32 mask, u32 val)
> +{
> +	int ret;
> +	u32 orig, tmp;
> +	unsigned long flags = 0;
> +
> +	spin_lock_irqsave(&clk->lock, flags);
> +
> +	ret = pmc_atom_read(clk->offset, &orig);
> +	if (ret)
> +		goto out;
> +
> +	tmp = orig & ~mask;
> +	tmp |= val & mask;
> +
> +	if (tmp == orig)
> +		goto out;
> +
> +	ret = pmc_atom_write(clk->offset, tmp);

It's sad that this can't be compiled on any platform. Has there
been any move towards making this into a regmap provider so that
this clk driver can use cross platform regmap APIs instead? Or
even passing the __iomem pointer through platform data or
something so that we can use readl/writel APIs directly instead
of pmc_atom_write()/read()?

> +	if (ret)
> +		goto out;
> +
> +out:
> +	spin_unlock_irqrestore(&clk->lock, flags);
> +
> +	return ret;
> +}
[...]
> +
> +static int plt_clk_is_enabled(struct clk_hw *hw)
> +{
> +	struct clk_plt *clk = to_clk_plt(hw);
> +	u32 value;
> +	int ret;
> +
> +	ret = pmc_atom_read(clk->offset, &value);
> +	if (ret)
> +		return ret;

Should return 0?

> +
> +	return plt_reg_to_enabled(value);
> +}
> +
> +static struct clk *plt_clk_register(struct platform_device *pdev, int id,
> +				    const char **parent_names, int num_parents)
> +{
> +	struct clk_plt *pclk;
> +	struct clk *clk;
> +	struct clk_init_data init;
> +	int ret = 0;
> +
> +	pclk = devm_kzalloc(&pdev->dev, sizeof(*pclk), GFP_KERNEL);
> +	if (!pclk)
> +		return ERR_PTR(-ENOMEM);
> +
> +	init.name =  kasprintf(GFP_KERNEL, "%s%d", PLT_CLK_NAME_BASE, id);
> +	init.ops = &plt_clk_ops;
> +	init.flags = 0;
> +	init.parent_names = parent_names;
> +	init.num_parents = num_parents;
> +
> +	pclk->hw.init = &init;
> +	pclk->id = id;
> +	pclk->offset = PMC_CLK_CTL_0 + id * PMC_CLK_CTL_SIZE;
> +	spin_lock_init(&pclk->lock);
> +
> +	clk = clk_register(&pdev->dev, &pclk->hw);

Please use clk_hw_register() instead (and devM_clk_hw_register()
would be even simpler).

> +	if (IS_ERR(clk)) {
> +		ret = PTR_ERR(clk);
> +		goto err_free_pclk;
> +	}
> +
> +	pclk->lookup = clkdev_create(clk, init.name, NULL);

And clkdev_hw_create().

> +	if (!pclk->lookup) {
> +		ret = -ENOMEM;
> +		goto err_clk_unregister;
> +	}
> +
> +	kfree(init.name);
> +
> +	return clk;
> +
> +err_clk_unregister:
> +	clk_unregister(clk);
> +err_free_pclk:
> +	kfree(init.name);
> +	return ERR_PTR(ret);
> +}

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
