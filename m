From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/2] ALSA: Add SoC on-chip internal memory
 support for DMA buffer allocation
Date: Wed, 16 Oct 2013 10:55:03 +0200
Message-ID: <525E5467.5090301@metafoo.de>
References: <03ed477b729fd972b896d52312666e5773d8dfec.1381911378.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-202.synserver.de (smtp-out-202.synserver.de
 [212.40.185.202])
 by alsa0.perex.cz (Postfix) with ESMTP id 392FB265071
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2013 10:53:10 +0200 (CEST)
In-Reply-To: <03ed477b729fd972b896d52312666e5773d8dfec.1381911378.git.b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 10/16/2013 10:18 AM, Nicolin Chen wrote:
> Now it's quite common that an SoC contains its on-chip internal memory.
> By using this memory space for DMA buffer during audio playback/record,
> we can shutdown the voltage for external memory to save power.
> 
> Thus add new DEV type with iram malloc()/free() and accordingly modify
> current default mmap() for the iram circumstance.
> 
> Signed-off-by: Nicolin Chen <b42378@freescale.com>

I think this is much better then having each machine add custom callbacks
for it.

[...]
> +
> +#ifdef CONFIG_OF
> +/**
> + * snd_malloc_dev_iram - allocate memory from on-chip internal memory
> + * @dev: DMA device pointer
> + * @size: number of bytes to allocate from the iram
> + * @dma: dma-view physical address
> + *
> + * Return cpu-view address or NULL indicating allocating failure
> + *
> + * This function requires iram phandle provided via of_node
> + */
> +void *snd_malloc_dev_iram(struct device *dev, size_t size, dma_addr_t *dma)
> +{
> +	struct gen_pool *pool = of_get_named_gen_pool(dev->of_node, "iram", 0);

dev will be the dma controller device not the audio controller device. This
means the iram property needs to be specified on dma controller node and
will be shared by all users of that controller. Is this the intention?

Also I think you need to check whether of_node is NULL before passing it to
of_get_named_gen_pool.

> +	unsigned long vaddr;
> +
> +	if (!pool)
> +		return NULL;
> +
> +	vaddr = gen_pool_alloc(pool, size);
> +	if (!vaddr)
> +		return NULL;
> +
> +	if (dma)

This check will always be true.

> +		*dma = gen_pool_virt_to_phys(pool, vaddr);
> +
> +	return (void *)vaddr;
> +}
> +
> +/**
> + * snd_free_dev_iram - free allocated specific memory from on-chip internal memory
> + * @dev: DMA device pointer
> + * @size: size in bytes of memory to free
> + * @ptr: cpu-view address returned from snd_malloc_dev_iram
> + * @dma: dma-view address returned from snd_malloc_dev_iram
> + *
> + * This function requires iram phandle provided via of_node
> + */
> +void snd_free_dev_iram(struct device *dev, size_t size, void *ptr, dma_addr_t dma)
> +{
> +	struct gen_pool *pool = of_get_named_gen_pool(dev->of_node, "iram", 0);
> +	if (!pool)
> +		return;
> +
> +	gen_pool_free(pool, (unsigned long)ptr, size);
> +
> +	ptr = NULL;

This ...

> +
> +	if (dma)
> +		dma = 0;

... and this assignment are noops

> +}
> +#endif /* CONFIG_OF */
>  #endif /* CONFIG_HAS_DMA */
