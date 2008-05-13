From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: 2.6.26-rc1 regression: ISA DMA broken (bisected)
Date: Tue, 13 May 2008 10:59:32 -0600
Message-ID: <200805131059.32911.bjorn.helgaas@hp.com>
References: <4823AAF2.7070102@keyaccess.nl> <s5hzlr0105c.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from g5t0007.atlanta.hp.com (g5t0007.atlanta.hp.com [15.192.0.44])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C56C24B5A
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 19:01:06 +0200 (CEST)
In-Reply-To: <s5hzlr0105c.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Rene Herman <rene.herman@keyaccess.nl>, Ingo Molnar <mingo@elte.hu>, Linux Kernel <linux-kernel@vger.kernel.org>, Glauber Costa <gcosta@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Pete Clements <clem@clem.clem-digital.net>
List-Id: alsa-devel@alsa-project.org

On Friday 09 May 2008 12:06:55 am Takashi Iwai wrote:
> Thanks for catching it.  Yeah, the patch looks buggy.  We had an
> implicit assumption that dev = NULL for ISA devices that require 24bit
> DMA.

Naive question #1:  Why don't we have a struct device for these
ISA devices?  PNP builds a struct device with DMA_24BIT_MASK
for ISAPNP devices.

Naive question #2:  Do other architectures need similar fixes in
dma_alloc_coherent()?

> [PATCH] x86: Fix dma_alloc_coherent() for ISA devices
> 
> The recent work on x86 dma_alloc_coherent() breaks the ISA DMA buffer
> allocation, which is represented by "dev = NULL" and requires 24bit
> DMA implicitly.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> 
> ---
> 
> diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
> index 0c37f16..c5ef1af 100644
> --- a/arch/x86/kernel/pci-dma.c
> +++ b/arch/x86/kernel/pci-dma.c
> @@ -385,11 +385,13 @@ dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
>  	if (dma_alloc_from_coherent_mem(dev, size, dma_handle, &memory))
>  		return memory;
>  
> -	if (!dev)
> +	if (!dev) {
>  		dev = &fallback_dev;
> +		gfp |= GFP_DMA;
> +	}
>  	dma_mask = dev->coherent_dma_mask;
>  	if (dma_mask == 0)
> -		dma_mask = DMA_32BIT_MASK;
> +		dma_mask = (gfp & GFP_DMA) ? DMA_24BIT_MASK : DMA_32BIT_MASK;
>  
>  	/* Device not DMA able */
>  	if (dev->dma_mask == NULL)
> @@ -403,7 +405,7 @@ dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
>  	   larger than 16MB and in this case we have a chance of
>  	   finding fitting memory in the next higher zone first. If
>  	   not retry with true GFP_DMA. -AK */
> -	if (dma_mask <= DMA_32BIT_MASK)
> +	if (dma_mask <= DMA_32BIT_MASK && !(gfp & GFP_DMA))
>  		gfp |= GFP_DMA32;
>  #endif
>  
