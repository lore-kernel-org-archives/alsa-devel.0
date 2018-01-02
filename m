From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [alsa-devel] [PATCH v6 1/6] ASoC: Intel: Skylake: Add ssp clock
 driver
Date: Tue, 2 Jan 2018 15:39:29 -0800
Message-ID: <20180102233929.GO7997@codeaurora.org>
References: <1514306696-7062-1-git-send-email-sriramx.periyasamy@intel.com>
 <1514306696-7062-2-git-send-email-sriramx.periyasamy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1514306696-7062-2-git-send-email-sriramx.periyasamy@intel.com>
Sender: linux-clk-owner@vger.kernel.org
To: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Cc: ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Patches Audi o <patches.audio@intel.com>, mturquette@baylibre.com, linux-clk@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 12/26, Sriram Periyasamy wrote:
> diff --git a/sound/soc/intel/skylake/skl-ssp-clk.c b/sound/soc/intel/skylake/skl-ssp-clk.c
> new file mode 100644
> index 000000000000..bb828f285b16
> --- /dev/null
> +++ b/sound/soc/intel/skylake/skl-ssp-clk.c
> @@ -0,0 +1,432 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright(c) 2015-17 Intel Corporation

Does this also go into the // part? I thought just the tag was
with // comment style.

> +
> +static int skl_clk_set_rate(struct clk_hw *hw, unsigned long rate,
> +					unsigned long parent_rate)
> +{
> +	struct skl_clk *clkdev = to_skl_clk(hw);
> +	struct skl_clk_rate_cfg_table *rcfg;
> +	int clk_type;
> +
> +	if (!rate)
> +		return -EINVAL;
> +
> +	if (__clk_is_enabled(hw->clk))

We have CLK_SET_RATE_GATE for this.

> +		return -EBUSY;
> +
> +	rcfg = skl_get_rate_cfg(clkdev->pdata->ssp_clks[clkdev->id].rate_cfg,
> +							rate);
> +	if (!rcfg)
> +		return -EINVAL;
> +
> +	clk_type = skl_get_clk_type(clkdev->id);
> +	if (clk_type < 0)
> +		return clk_type;
> +
> +	skl_fill_clk_ipc(rcfg, clk_type);
> +	clkdev->rate = rate;
> +
> +	return 0;
> +}
> +
> +static unsigned long skl_clk_recalc_rate(struct clk_hw *hw,
> +				unsigned long parent_rate)
> +{
> +	struct skl_clk *clkdev = to_skl_clk(hw);
> +
> +	if (clkdev->rate)
> +		return clkdev->rate;
> +
> +	return 0;
> +}
> +
> +/* Not supported by clk driver. Implemented to satisfy clk fw */
> +long skl_clk_round_rate(struct clk_hw *hw, unsigned long rate,
> +				unsigned long *parent_rate)
> +{
> +	return rate;
> +}
> +
> +/*
> + * prepare/unprepare are used instead of enable/disable as IPC will be sent
> + * in non-atomic context.
> + */
> +static const struct clk_ops skl_clk_ops = {
> +	.prepare = skl_clk_prepare,
> +	.unprepare = skl_clk_unprepare,
> +	.set_rate = skl_clk_set_rate,
> +	.round_rate = skl_clk_round_rate,
> +	.recalc_rate = skl_clk_recalc_rate,
> +};

Otherwise looks good.

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
