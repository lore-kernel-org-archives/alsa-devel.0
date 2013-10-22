From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v6] ALSA: Add SoC on-chip internal memory
 support for DMA buffer allocation
Date: Tue, 22 Oct 2013 14:06:08 +0200
Message-ID: <52666A30.7030102@metafoo.de>
References: <1382410849-11906-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-203.synserver.de (smtp-out-204.synserver.de
 [212.40.185.204])
 by alsa0.perex.cz (Postfix) with ESMTP id D52732619F4
 for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2013 14:07:45 +0200 (CEST)
In-Reply-To: <1382410849-11906-1-git-send-email-b42378@freescale.com>
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

On 10/22/2013 05:00 AM, Nicolin Chen wrote:
[...]
> +/**
> + * snd_free_dev_iram - free allocated specific memory from on-chip internal memory
> + * @dev: DMA device pointer
> + * @size: size in bytes of memory to free
> + * @ptr: cpu-view address returned from snd_malloc_dev_iram
> + *
> + * This function requires iram phandle provided via of_node
> + */
> +void snd_free_dev_iram(struct device *dev, size_t size, void *ptr)
> +{
> +	struct gen_pool *pool = NULL;
> +
> +	if (!dev->of_node)
> +		return;
> +
> +	pool = of_get_named_gen_pool(dev->of_node, "iram", 0);
> +	if (!pool)
> +		return;

I've had a closer look at the other SNDRV_DMA_TYPE implementations and I
think a better way to handle this is to assign the pool to the
snd_dma_buffer's private_data field and then use it here instead of looking
the pool up again. This will also make it easier to use a non-OF lookup scheme.

> +
> +	gen_pool_free(pool, (unsigned long)ptr, size);
> +}
>  #endif /* CONFIG_HAS_DMA */
>  
>  /*
