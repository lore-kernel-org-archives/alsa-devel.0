From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 0/3] ASoC: Move pcm writecombine dma buffer
 allocation to core
Date: Fri, 29 Jun 2012 18:06:52 +0200
Message-ID: <4FEDD29C.8040209@metafoo.de>
References: <1340965398-20872-1-git-send-email-ldewangan@nvidia.com>
	<s5h7guqxqnd.wl%tiwai@suse.de> <4FEDC3F8.8000501@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-132.synserver.de (smtp-out-134.synserver.de
	[212.40.185.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 95C8A11CFA6
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Jun 2012 18:03:04 +0200 (CEST)
In-Reply-To: <4FEDC3F8.8000501@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Stephen Warren <swarren@nvidia.com>, Takashi Iwai <tiwai@suse.de>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "clemens@ladisch.de" <clemens@ladisch.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 06/29/2012 05:04 PM, Laxman Dewangan wrote:
> [...]
> 
> 
>> +/* allocate the coherent DMA pages */
>> +static void *snd_malloc_dev_pages(struct device *dev, size_t size,
>> dma_addr_t *dma)
>> +{
>> +    return __snd_malloc_dev_pages(dev, size, dma, dma_alloc_coherent);
> 
> This does not get compiled in ARM because dma_alloc_coherant is macro
> defined as
> 
> #define dma_alloc_coherent(d, s, h, f) dma_alloc_attrs(d, s, h, f, NULL)
> 
> static inline void *dma_alloc_attrs(struct device *dev, size_t size,
>                                        dma_addr_t *dma_handle, gfp_t flag,
>                                        struct dma_attrs *attrs)
> 
> 
> I fixed this by
> static void *_dma_alloc_coherent(struct device *dev, size_t size,
>                 dma_addr_t *dma_handle, gfp_t flag)
> {
>         return dma_alloc_coherent(dev, size, dma_handle, flag);
> }
> 
> /* allocate the coherent DMA pages */
> static void *snd_malloc_dev_pages(struct device *dev, size_t size,
> dma_addr_t *dma)
> {
>         return _snd_malloc_dev_pages(dev, size, dma, _dma_alloc_coherent);
> }

I think all dma_alloc_* functions use dma_alloc_attrs internally these days.
I think it might be a better idea just to use dma_alloc_attrs in
__snd_malloc_dev_pages and just pass a dma_attrs struct instead of a function.

Something like:

static void *__snd_malloc_dev_pages(struct device *dev, size_t size,
			    dma_addr_t *dma, struct dma_attrs *attrs)
{
....
	res = dma_alloc_attrs(dev, PAGE_SIZE << pg, dma, gfp_flags, attrs);
....
}


static void *snd_malloc_dev_pages(struct device *dev, size_t size,
	dma_addr_t *dma)
{
	return __snd_malloc_dev_pages(dev, size, dma, NULL);
}

static void *snd_malloc_dev_wc_pages(struct device *dev, size_t size,
	dma_addr_t *dma)
{
	DEFINE_DMA_ATTRS(attrs);
	dma_set_attr(DMA_ATTR_WRITE_COMBINE, &attrs);

	return __snd_malloc_dev_pages(dev, size, dma, &attrs);
}

Same applies for freeing the memory again.

- Lars
