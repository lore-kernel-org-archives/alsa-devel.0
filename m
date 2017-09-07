From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 5/6] ASoC: Intel: Skylake: Add ssp clock
	driver
Date: Thu, 7 Sep 2017 22:16:42 +0530
Message-ID: <20170907164642.GX3053@localhost>
References: <1504794565-19168-6-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 95232267453
 for <alsa-devel@alsa-project.org>; Thu,  7 Sep 2017 18:43:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1504794565-19168-6-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, broonie@kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>, linux-clk@vger.kernel.org, patches.audio@intel.com, harshapriya.n@intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 07, 2017 at 07:59:24PM +0530, Subhransu S. Prusty wrote:
> From: Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>
> 
> For certain platforms it is required to start the clocks (mclk/sclk/fs)
> before the stream start. Example: for few chrome systems, codec needs the
> mclk/sclk to be enabled early for a successful clock synchronization and
> for few IVI platforms, clock need to be enabled at boot and should be ON
> always.
> 
> This patch creates virtual clock driver, which allows the machine driver to
> use the clock interface to send IPCs to DSP to enable/disable the clocks.

Mark, Michael, Stephen,

So this one adds a 'virtual' clock driver for audio clocks (mclk, bclk...)
and we have DSP configuring them.  The SW (driver) sends messages to DSP for
controlling these clocks, that is why we decided to keep this in ASoC, do
let us know if that is okay.

And it goes without saying that this would need ACK from clk guys before
merging.

> 
> Signed-off-by: Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>
> Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> ---
>  sound/soc/intel/Kconfig               |   7 +
>  sound/soc/intel/skylake/Makefile      |   5 +
>  sound/soc/intel/skylake/skl-ssp-clk.c | 287 ++++++++++++++++++++++++++++++++++
>  3 files changed, 299 insertions(+)
>  create mode 100644 sound/soc/intel/skylake/skl-ssp-clk.c
> 
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index b3c7f554ec30..b9d9d692b4e3 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -269,6 +269,13 @@ config SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH
>            Say Y if you have such a device.
>            If unsure select "N".
>  
> +config SND_SOC_INTEL_SKYLAKE_SSP_CLK
> +	tristate
> +	help
> +	   Enabling this will make the clk driver to be compiled and allow to
> +	   control MCLK/SCLK/FS clocks independent of the stream. It should be
> +	   enabled by the respective machine driver.
> +
>  config SND_SOC_INTEL_SKYLAKE
>  	tristate
>  	select SND_HDA_EXT_CORE
> diff --git a/sound/soc/intel/skylake/Makefile b/sound/soc/intel/skylake/Makefile
> index 3380deb81015..9131c35ad4bb 100644
> --- a/sound/soc/intel/skylake/Makefile
> +++ b/sound/soc/intel/skylake/Makefile
> @@ -13,3 +13,8 @@ snd-soc-skl-ipc-objs := skl-sst-ipc.o skl-sst-dsp.o cnl-sst-dsp.o \
>  		skl-sst-utils.o
>  
>  obj-$(CONFIG_SND_SOC_INTEL_SKYLAKE) += snd-soc-skl-ipc.o
> +
> +#Skylake Clock device support
> +snd-soc-skl-ssp-clk-objs := skl-ssp-clk.o
> +
> +obj-$(CONFIG_SND_SOC_INTEL_SKYLAKE_SSP_CLK) += snd-soc-skl-ssp-clk.o
> diff --git a/sound/soc/intel/skylake/skl-ssp-clk.c b/sound/soc/intel/skylake/skl-ssp-clk.c
> new file mode 100644
> index 000000000000..5b4016826fdc
> --- /dev/null
> +++ b/sound/soc/intel/skylake/skl-ssp-clk.c
> @@ -0,0 +1,287 @@
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
> +			goto err;
> +		}
> +
> +		parent[i].lookup = clkdev_hw_create(parent[i].hw, pclk[i].name,
> +									NULL);
> +		if (!parent[i].lookup) {
> +			clk_hw_unregister_fixed_rate(parent[i].hw);
> +			ret = PTR_ERR_OR_ZERO(parent[i].lookup);
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
> +/* REMOVE: send only ssp_clks[i], ops */
> +/* Assign fmt_config to clk_data */
> +static struct skl_clk *register_skl_clk(struct device *dev,
> +			struct skl_ssp_clk *clk,
> +			struct skl_clk_pdata *clk_pdata, int id)
> +{
> +	struct skl_clk *clkdev;
> +	struct clk_init_data init;
> +	int ret;
> +
> +	clkdev = devm_kzalloc(dev, sizeof(*clkdev), GFP_KERNEL);
> +	if (!clkdev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	init.name = clk->name;
> +	init.ops = &skl_clk_ops;
> +	init.flags = 0;
> +	init.parent_names = &clk->parent_name;
> +	init.num_parents = 1;
> +	clkdev->hw.init = &init;
> +	clkdev->ops = clk_pdata->ops;
> +	clkdev->pvt_data = clk_pdata->pvt_data;
> +
> +	clkdev->id = id;
> +	ret = devm_clk_hw_register(dev, &clkdev->hw);
> +	if (ret) {
> +		clkdev = ERR_PTR(ret);
> +		return clkdev;
> +	}
> +
> +	clkdev->lookup = clkdev_hw_create(&clkdev->hw, init.name, NULL);
> +	if (!clkdev->lookup)
> +		clkdev = ERR_PTR(-ENOMEM);
> +
> +	return clkdev;
> +}
> +
> +static int skl_clk_dev_probe(struct platform_device *pdev)
> +{
> +	struct skl_clk_pdata *clk_pdata;
> +	struct skl_clk_parent_src *parent_clks;
> +	struct skl_ssp_clk *clks;
> +	struct skl_clk_data *data;
> +	struct device *dev = &pdev->dev;
> +	int ret, i;
> +
> +	clk_pdata = dev_get_platdata(&pdev->dev);
> +	parent_clks = clk_pdata->parent_clks;
> +	clks = clk_pdata->ssp_clks;
> +	if (!parent_clks || !clks)
> +		return -EIO;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	/* Register Parent clock */
> +	ret = skl_register_parent_clks(dev, data->parent, parent_clks);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < clk_pdata->num_clks; i++) {
> +		/*
> +		 * Only register valid clocks
> +		 * i.e. for which nhlt entry is present.
> +		 */
> +		if (clks[i].rate_cfg[0].rate == 0)
> +			continue;
> +
> +		data->clk[i] = register_skl_clk(dev, &clks[i], clk_pdata, i);
> +		if (IS_ERR(data->clk[i])) {
> +			ret = PTR_ERR(data->clk[i]);
> +			goto err_unreg_skl_clk;
> +		}
> +
> +		data->avail_clk_cnt++;
> +	}
> +
> +	platform_set_drvdata(pdev, data);
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
> +
> +	return 0;
> +}
> +
> +static struct platform_driver skl_clk_driver = {
> +	.driver = {
> +		.name = "skl-ssp-clk",
> +	},
> +	.probe = skl_clk_dev_probe,
> +	.remove = skl_clk_dev_remove,
> +};
> +
> +module_platform_driver(skl_clk_driver);
> +
> +MODULE_DESCRIPTION("Skylake clock driver");
> +MODULE_AUTHOR("Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>");
> +MODULE_AUTHOR("Subhransu S. Prusty <subhransu.s.prusty@intel.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:skl-ssp-clk");
> -- 
> 1.9.1
> 

-- 
~Vinod
