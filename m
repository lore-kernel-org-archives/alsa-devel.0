From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH 1/2] ALSA: Add SoC on-chip internal memory
 support for DMA buffer allocation
Date: Wed, 16 Oct 2013 16:48:45 +0800
Message-ID: <20131016084844.GA24805@MrMyself>
References: <03ed477b729fd972b896d52312666e5773d8dfec.1381911378.git.b42378@freescale.com>
 <525E5467.5090301@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0184.outbound.messaging.microsoft.com [213.199.154.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C74326507F
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2013 11:06:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <525E5467.5090301@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi Lars,

On Wed, Oct 16, 2013 at 10:55:03AM +0200, Lars-Peter Clausen wrote:
> > +void *snd_malloc_dev_iram(struct device *dev, size_t size, dma_addr_t *dma)
> > +{
> > +	struct gen_pool *pool = of_get_named_gen_pool(dev->of_node, "iram", 0);
> 
> dev will be the dma controller device not the audio controller device. This
> means the iram property needs to be specified on dma controller node and
> will be shared by all users of that controller. Is this the intention?

True.

> Also I think you need to check whether of_node is NULL before passing it to
> of_get_named_gen_pool.

Oh, you're right.

> 
> > +	unsigned long vaddr;
> > +
> > +	if (!pool)
> > +		return NULL;
> > +
> > +	vaddr = gen_pool_alloc(pool, size);
> > +	if (!vaddr)
> > +		return NULL;
> > +
> > +	if (dma)
> 
> This check will always be true.

I'll drop it and below as well.

Thank you.
Nicolin Chen

> 
> > +		*dma = gen_pool_virt_to_phys(pool, vaddr);
> > +
> > +	return (void *)vaddr;
> > +}
> > +
> > +/**
> > + * snd_free_dev_iram - free allocated specific memory from on-chip internal memory
> > + * @dev: DMA device pointer
> > + * @size: size in bytes of memory to free
> > + * @ptr: cpu-view address returned from snd_malloc_dev_iram
> > + * @dma: dma-view address returned from snd_malloc_dev_iram
> > + *
> > + * This function requires iram phandle provided via of_node
> > + */
> > +void snd_free_dev_iram(struct device *dev, size_t size, void *ptr, dma_addr_t dma)
> > +{
> > +	struct gen_pool *pool = of_get_named_gen_pool(dev->of_node, "iram", 0);
> > +	if (!pool)
> > +		return;
> > +
> > +	gen_pool_free(pool, (unsigned long)ptr, size);
> > +
> > +	ptr = NULL;
> 
> This ...
> 
> > +
> > +	if (dma)
> > +		dma = 0;
> 
> ... and this assignment are noops
> 
> > +}
> > +#endif /* CONFIG_OF */
> >  #endif /* CONFIG_HAS_DMA */
> 
