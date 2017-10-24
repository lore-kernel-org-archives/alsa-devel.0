From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2 5/7] ASoC: Intel: Skylake: Add ssp clock driver
Date: Tue, 24 Oct 2017 07:33:12 -0700
Message-ID: <20171024143312.GA22264@codeaurora.org>
References: <1505710610-17952-1-git-send-email-subhransu.s.prusty@intel.com>
 <1505710610-17952-6-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1505710610-17952-6-git-send-email-subhransu.s.prusty@intel.com>
Sender: linux-clk-owner@vger.kernel.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org, lgirdwood@gmail.com, patches.audio@intel.com, mturquette@baylibre.com, linux-clk@vger.kernel.org, harshapriya.n@intel.com, Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>
List-Id: alsa-devel@alsa-project.org

On 09/18, Subhransu S. Prusty wrote:
> diff --git a/sound/soc/intel/skylake/skl-ssp-clk.c b/sound/soc/intel/skylake/skl-ssp-clk.c
> new file mode 100644
> index 000000000000..769ece306f58
> --- /dev/null
> +++ b/sound/soc/intel/skylake/skl-ssp-clk.c
> @@ -0,0 +1,288 @@
> +/*
> + *  skl-ssp-clk.c - ASoC skylake ssp clock driver
> + *
> + *  Copyright (C) 2017 Intel Corp
> + *  Author: Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>
> + *  Author: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> + *
> + *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; version 2 of the License.
> + *
> + *  This program is distributed in the hope that it will be useful, but
> + *  WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  General Public License for more details.
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>

Is this include used?

> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>
> +#include "skl-ssp-clk.h"
> +
> +#define to_skl_clk(_hw)	container_of(_hw, struct skl_clk, hw)
> +
> +struct skl_clk_parent {
> +	struct clk_hw *hw;
> +	struct clk_lookup *lookup;
> +};
> +
> +struct skl_clk {
> +	struct clk_hw hw;
> +	struct clk_lookup *lookup;
> +	struct skl_clk_ops *ops;
> +	unsigned long rate;
> +	void *pvt_data;
> +	u32 id;
> +};
> +
> +struct skl_clk_data {
> +	struct skl_clk_parent parent[SKL_MAX_CLK_SRC];
> +	struct skl_clk *clk[SKL_MAX_CLK_CNT];
> +	u8 avail_clk_cnt;
> +};
> +
> +static int skl_clk_prepare(struct clk_hw *hw)
> +{
> +	struct skl_clk *clkdev = to_skl_clk(hw);
> +
> +	if (!clkdev->ops || !clkdev->ops->prepare)
> +		return -EIO;

Ok is this the "virtual" part? Because it is sort of odd. Why
can't we give clk ops directly for everything and get rid of
struct skl_clk_ops here? Bouncing through this layer must be
because something isn't converted to CCF, but what is that?

> +
> +	if (!clkdev->rate)
> +		return -EINVAL;
> +
> +	return clkdev->ops->prepare(clkdev->pvt_data, clkdev->id, clkdev->rate);
> +}
> +
> +static void skl_clk_unprepare(struct clk_hw *hw)
> +{
> +	struct skl_clk *clkdev = to_skl_clk(hw);
> +
> +	if (!clkdev->ops || !clkdev->ops->unprepare)
> +		return;
> +
> +	if (!clkdev->rate)
> +		return;
> +
> +	clkdev->ops->unprepare(clkdev->pvt_data, clkdev->id, clkdev->rate);
> +}
> +
> +static int skl_clk_set_rate(struct clk_hw *hw, unsigned long rate,
> +					unsigned long parent_rate)
> +{
> +	struct skl_clk *clkdev = to_skl_clk(hw);
> +	int ret;
> +
> +	if (!clkdev->ops || !clkdev->ops->set_rate)
> +		return -EIO;
> +
> +	ret = clkdev->ops->set_rate(clkdev->id, rate);
> +	if (!ret)
> +		clkdev->rate = rate;
> +
> +	return ret;
> +}
> +
> +unsigned long skl_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> +{
> +	struct skl_clk *clkdev = to_skl_clk(hw);
> +
> +	if (clkdev->rate)
> +		return clkdev->rate;
> +
> +	if (!clkdev->ops || !clkdev->ops->recalc_rate)
> +		return -EIO;
> +
> +	clkdev->rate = clkdev->ops->recalc_rate(clkdev->id, parent_rate);
> +
> +	return clkdev->rate;
> +}
> +
> +/* Not supported by clk driver. Implemented to satisfy clk fw */
> +long skl_clk_round_rate(struct clk_hw *hw, unsigned long rate,
> +				unsigned long *parent_rate)
> +{
> +	return rate;
> +}
> +
> +static const struct clk_ops skl_clk_ops = {
> +	.prepare = skl_clk_prepare,
> +	.unprepare = skl_clk_unprepare,
> +	.set_rate = skl_clk_set_rate,
> +	.round_rate = skl_clk_round_rate,
> +	.recalc_rate = skl_clk_recalc_rate,
> +};
> +
> +static void unregister_parent_src_clk(struct skl_clk_parent *pclk, u8 id)

Why is id a u8? Would be simpler as unsigned. Usually I think of
registers when using u8/16/32/64, not array sizes.

> +{
> +	while (id--) {
> +		clkdev_drop(pclk[id].lookup);
> +		clk_hw_unregister_fixed_rate(pclk[id].hw);
> +	}
> +}
> +
> +static void unregister_src_clk(struct skl_clk_data *dclk)
> +{
> +	u8 cnt = dclk->avail_clk_cnt;
> +
> +	while (cnt--)
> +		clkdev_drop(dclk->clk[cnt]->lookup);
> +}
> +
> +static int skl_register_parent_clks(struct device *dev,
> +			struct skl_clk_parent *parent,
> +			struct skl_clk_parent_src *pclk)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < SKL_MAX_CLK_SRC; i++) {
> +
> +		/* Register Parent clock */
> +		parent[i].hw = clk_hw_register_fixed_rate(dev, pclk[i].name,
> +				pclk[i].parent_name, 0, pclk[i].rate);
> +		if (IS_ERR(parent[i].hw)) {
> +			ret = PTR_ERR_OR_ZERO(parent[i].hw);

If it's an IS_ERR then we just need PTR_ERR.

> +			goto err;
> +		}
> +
> +		parent[i].lookup = clkdev_hw_create(parent[i].hw, pclk[i].name,
> +									NULL);
> +		if (!parent[i].lookup) {
> +			clk_hw_unregister_fixed_rate(parent[i].hw);
> +			ret = PTR_ERR_OR_ZERO(parent[i].lookup);

If it's not NULL then we always unregister parent and return some
random number? Maybe I'm missing something.


> +			goto err;
> +		}
> +	}
> +
> +	return 0;
> +err:
> +	unregister_parent_src_clk(parent, i);
> +	return ret;
> +}
> +
[...]
> +
> +	return 0;
> +
> +err_unreg_skl_clk:
> +	unregister_src_clk(data);
> +	unregister_parent_src_clk(data->parent, SKL_MAX_CLK_SRC);
> +
> +	return ret;
> +}
> +
> +static int skl_clk_dev_remove(struct platform_device *pdev)
> +{
> +	struct skl_clk_data *data;
> +
> +	data = platform_get_drvdata(pdev);
> +	unregister_parent_src_clk(data->parent, SKL_MAX_CLK_SRC);
> +	unregister_src_clk(data);

This is opposite path of error path in probe, so something smells
wrong.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
