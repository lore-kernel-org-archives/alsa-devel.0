From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/4] ASoC: mmp: add audio dma support
Date: Fri, 25 May 2012 09:05:00 +0100
Message-ID: <20120525080500.GB24149@n2100.arm.linux.org.uk>
References: <1337929863-31885-1-git-send-email-zhangfei.gao@marvell.com>
	<1337929863-31885-3-git-send-email-zhangfei.gao@marvell.com>
	<1337932416.1580.2.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1337932416.1580.2.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: linux-arm-kernel@lists.infradead.org, Eric Miao <eric.y.miao@gmail.com>, Leo Yan <leoy@marvell.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, alsa-devel@vger.kernel.org, Qiao Zhou <zhouqiao@marvell.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Liam Girdwood <lrg@ti.com>, Chao Xie <cxie4@marvell.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 25, 2012 at 01:23:36PM +0530, Vinod Koul wrote:
> On Fri, 2012-05-25 at 15:11 +0800, Zhangfei Gao wrote:
> > mmp-pcm handle audio dma based on dmaengine
> > Support mmp and pxa910
> Looks like this is *not* using soc-dmaengine library, why?

Note also...

> > +	prtd->dma_chan = dma_request_channel(mask, filter, prtd);
> > +	if (!prtd->dma_chan)
> > +		return -EINVAL;

This should be done at probe time, so we know the struct device, so
that...

> > +static int mmp_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
> > +{
> > +	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
> > +	struct snd_dma_buffer *buf = &substream->dma_buffer;
> > +	size_t size = mmp_pcm_hardware[stream].buffer_bytes_max;
> > +	struct gen_pool *gpool;
> > +
> > +	buf->dev.type = SNDRV_DMA_TYPE_DEV;
> > +	buf->dev.dev = pcm->card->dev;

... this uses the right device, and...

> > +static u64 mmp_pcm_dmamask = DMA_BIT_MASK(64);
> > +
> > +int mmp_pcm_new(struct snd_soc_pcm_runtime *rtd)
> > +{
> > +	struct snd_card *card = rtd->card->snd_card;
> > +	struct snd_pcm *pcm = rtd->pcm;
> > +	int ret = 0;
> > +
> > +	if (!card->dev->dma_mask)
> > +		card->dev->dma_mask = &mmp_pcm_dmamask;
> > +
> > +	if (!card->dev->coherent_dma_mask)
> > +		card->dev->coherent_dma_mask = DMA_BIT_MASK(64);

... we don't need crap like this.

Because then we'll be allocating buffers against the _right_ struct device
which is the DMA engine struct device.
