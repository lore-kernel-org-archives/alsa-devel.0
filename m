From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH V2 01/10] ASoc: mxs: add mxs-pcm driver
Date: Wed, 13 Jul 2011 08:44:37 +0100
Message-ID: <20110713074437.GF23270@n2100.arm.linux.org.uk>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-2-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 9E72D103962
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jul 2011 09:44:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1310483085-31442-2-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <b29396@freescale.com>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, u.kleine-koenig@pengutronix.de, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 12, 2011 at 11:04:36PM +0800, Dong Aisheng wrote:
> +static int mxs_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
> +{
> +	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
> +	struct snd_dma_buffer *buf = &substream->dma_buffer;
> +	size_t size = 64 * 1024;
> +
> +	buf->dev.type = SNDRV_DMA_TYPE_DEV;
> +	buf->dev.dev = pcm->card->dev;
> +	buf->private_data = NULL;
> +	buf->area = dma_alloc_writecombine(pcm->card->dev, size,
> +					   &buf->addr, GFP_KERNEL);
...
> +static int snd_mxs_pcm_mmap(struct snd_pcm_substream *substream,
> +		struct vm_area_struct *vma)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	int ret;
> +
> +	ret = dma_mmap_coherent(NULL, vma, runtime->dma_area,
> +			runtime->dma_addr, runtime->dma_bytes);

This is wrong.  Hint 1:

int dma_mmap_writecombine(struct device *dev, struct vm_area_struct *vma,
                          void *cpu_addr, dma_addr_t dma_addr, size_t size)

Hint 2: struct device *dev - you have one above.
