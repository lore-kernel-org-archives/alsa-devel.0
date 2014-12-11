From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 2/2] misc: sram: switch to ioremap_wc from
	ioremap
Date: Thu, 11 Dec 2014 11:08:33 +0100
Message-ID: <1418292513.3188.4.camel@pengutronix.de>
References: <1418266726-12004-1-git-send-email-a.kesavan@samsung.com>
 <1418266726-12004-2-git-send-email-a.kesavan@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 062DE26061E
 for <alsa-devel@alsa-project.org>; Thu, 11 Dec 2014 11:09:00 +0100 (CET)
In-Reply-To: <1418266726-12004-2-git-send-email-a.kesavan@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Abhilash Kesavan <a.kesavan@samsung.com>
Cc: alsa-devel@alsa-project.org, heiko@sntech.de, padma.v@samsung.com, tony@atomide.com, catalin.marinas@arm.com, Will.Deacon@arm.com, kesavan.abhilash@gmail.com, arnd@arndb.de, shc_work@mail.ru, corbet@lwn.net, kgene@kernel.org, grant.likely@linaro.org, kernel@pengutronix.de, pawel.moll@arm.com, nicoleotsuka@gmail.com, robh+dt@kernel.org, shawn.guo@freescale.com, Li.Xiubo@freescale.com, linux-kernel@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, bcousson@baylibre.com, gregkh@linuxfoundation.org
List-Id: alsa-devel@alsa-project.org

Hi Abhilash,

Am Donnerstag, den 11.12.2014, 08:28 +0530 schrieb Abhilash Kesavan:
> Currently, the SRAM allocator returns device memory via ioremap.
> This causes issues on ARM64 when the internal SoC SRAM allocated by
> the generic sram driver is used for audio playback. The destination
> buffer address (which is ioremapped SRAM) is not 64-bit aligned for
> certain streams (e.g. 44.1k sampling rate). In such cases we get
> unhandled alignment faults. Use ioremap_wc in place of ioremap which
> gives us normal non-cacheable memory instead of device memory.

Could this break the omap_bus_sync() implementation in
arch/arm/mach-omap2/omap4-common.c?

    void omap_bus_sync(void)
    {
            if (dram_sync && sram_sync) {
                    writel_relaxed(readl_relaxed(dram_sync), dram_sync);
                    writel_relaxed(readl_relaxed(sram_sync), sram_sync);
                    isb();
            }
    }

It is used in wmb() and omap_do_wfi() to drain interconnect write
buffers on omap4/5. If sram_sync is mapped with write-combining, could
the last write to sram_sync stay stuck in the write-combining buffer
until after the function returns?

regards
Philipp

> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> ---
> This is based on the discussion about the crash here:
> http://www.spinics.net/lists/arm-kernel/msg384647.html
> 
>  drivers/misc/sram.c |   17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
> index 21181fa..15b4d4e 100644
> --- a/drivers/misc/sram.c
> +++ b/drivers/misc/sram.c
> @@ -69,12 +69,23 @@ static int sram_probe(struct platform_device *pdev)
>  	INIT_LIST_HEAD(&reserve_list);
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	virt_base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(virt_base))
> -		return PTR_ERR(virt_base);
> +	if (!res) {
> +		dev_err(&pdev->dev, "found no memory resource\n");
> +		return -EINVAL;
> +	}
>  
>  	size = resource_size(res);
>  
> +	if (!devm_request_mem_region(&pdev->dev,
> +			res->start, size, pdev->name)) {
> +		dev_err(&pdev->dev, "could not request region for resource\n");
> +		return -EBUSY;
> +	}
> +
> +	virt_base = devm_ioremap_wc(&pdev->dev, res->start, size);
> +	if (IS_ERR(virt_base))
> +		return PTR_ERR(virt_base);
> +
>  	sram = devm_kzalloc(&pdev->dev, sizeof(*sram), GFP_KERNEL);
>  	if (!sram)
>  		return -ENOMEM;
