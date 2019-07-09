From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: DW-DMA: Probe failures on broadwell
Date: Tue, 9 Jul 2019 16:34:48 +0300
Message-ID: <20190709133448.GC9224@smile.fi.intel.com>
References: <CAOReqxhxHiJ-4UYC-j4Quuuy5YP9ywohe_JwiLpCxqCvP-7ypg@mail.gmail.com>
 <20190709131401.GA9224@smile.fi.intel.com>
 <20190709132943.GB9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 656B1F800E0
 for <alsa-devel@alsa-project.org>; Tue,  9 Jul 2019 15:34:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20190709132943.GB9224@smile.fi.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Curtis Malainey <cujomalainey@google.com>
Cc: alsa-devel@alsa-project.org, Ross Zwisler <zwisler@google.com>, Fletcher Woodruff <fletcherw@google.com>, Liam Girdwood <liam.r.girdwood@intel.com>, dmaengine@vger.kernel.org, Pierre-louis Bossart <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 09, 2019 at 04:29:43PM +0300, Andy Shevchenko wrote:
> On Tue, Jul 09, 2019 at 04:14:01PM +0300, Andy Shevchenko wrote:
> > On Mon, Jul 08, 2019 at 01:50:07PM -0700, Curtis Malainey wrote:
> 
> > So, the correct fix is to provide a platform data, like it's done in
> > drivers/dma/dw/pci.c::idma32_pdata, in the sst-firmware.c::dw_probe(), and call
> > idma32_dma_probe() with idma32_dma_remove() respectively on removal stage.
> > 
> > (It will require latest patches to be applied, which are material for v5.x)
> 
> Below completely untested patch to try

Also, it might require to set proper request lines (currently it uses 0 AFAICS).
Something like it's done in drivers/spi/spi-pxa2xx-pci.c for Intel Merrifield.

> 
> --- 8< --- 8< --- 8< ---
> 
>  From 2bd36a75460613f0a14f0763b766cae8ce20c57d Mon Sep 17 00:00:00 2001
>  From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>  Date: Tue, 9 Jul 2019 16:24:35 +0300
>  Subject: [PATCH 1/1] ASoC: Intel: common: Use proper DMA controller type
> 
> It has been reported that Intel Broadwell machines can't use SST
> since DMA driver probe failure. The root cause *maybe* in a wrong type
> of DMA controller in use.
> 
> Use Intel iDMA 32-bit instead of Synopsys DesignWare controller for Intel SST.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  sound/soc/intel/common/sst-firmware.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/intel/common/sst-firmware.c b/sound/soc/intel/common/sst-firmware.c
> index d27947aeb079..5da7fb74c845 100644
> --- a/sound/soc/intel/common/sst-firmware.c
> +++ b/sound/soc/intel/common/sst-firmware.c
> @@ -174,6 +174,16 @@ static int block_list_prepare(struct sst_dsp *dsp,
>  	return ret;
>  }
>  
> +static const struct dw_dma_platform_data idma32_pdata = {
> +	.nr_channels = 8,
> +	.chan_allocation_order = CHAN_ALLOCATION_ASCENDING,
> +	.chan_priority = CHAN_PRIORITY_ASCENDING,
> +	.block_size = 131071,
> +	.nr_masters = 1,
> +	.data_width = {4},
> +	.multi_block = {1, 1, 1, 1, 1, 1, 1, 1},
> +};
> +
>  static struct dw_dma_chip *dw_probe(struct device *dev, struct resource *mem,
>  	int irq)
>  {
> @@ -184,6 +194,7 @@ static struct dw_dma_chip *dw_probe(struct device *dev, struct resource *mem,
>  	if (!chip)
>  		return ERR_PTR(-ENOMEM);
>  
> +	chip->pdata = &idma32_pdata;
>  	chip->irq = irq;
>  	chip->regs = devm_ioremap_resource(dev, mem);
>  	if (IS_ERR(chip->regs))
> @@ -195,7 +206,7 @@ static struct dw_dma_chip *dw_probe(struct device *dev, struct resource *mem,
>  
>  	chip->dev = dev;
>  
> -	err = dw_dma_probe(chip);
> +	err = idma32_dma_probe(chip);
>  	if (err)
>  		return ERR_PTR(err);
>  
> @@ -204,7 +215,7 @@ static struct dw_dma_chip *dw_probe(struct device *dev, struct resource *mem,
>  
>  static void dw_remove(struct dw_dma_chip *chip)
>  {
> -	dw_dma_remove(chip);
> +	idma32_dma_remove(chip);
>  }
>  
>  static bool dma_chan_filter(struct dma_chan *chan, void *param)
> -- 
> 2.20.1
> 
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
With Best Regards,
Andy Shevchenko
