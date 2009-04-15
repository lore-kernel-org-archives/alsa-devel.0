From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: ASoC: DMA Platform driver for i.mx27
Date: Wed, 15 Apr 2009 11:10:43 +0200
Message-ID: <eedb5540904150210y68f08597p9f6c032ca17faa27@mail.gmail.com>
References: <eedb5540904140917ic0f3626s5f6b98a2d22ec36b@mail.gmail.com>
	<20090414204243.GB6902@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f166.google.com (mail-ew0-f166.google.com
	[209.85.219.166])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DFC424407
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 11:10:44 +0200 (CEST)
Received: by ewy10 with SMTP id 10so3164453ewy.32
	for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2009 02:10:43 -0700 (PDT)
In-Reply-To: <20090414204243.GB6902@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2009/4/14 Mark Brown <broonie@sirena.org.uk>

> On Tue, Apr 14, 2009 at 06:17:39PM +0200, javier Martin wrote:
> Remove the history bit - once it's merged git will provide logs.
>
> > /* debug */
> > #define IMX_DEBUG 0
> > #if IMX_DEBUG
> > #define dbg(format, arg...) printk(format, ## arg)
> > #else
> > #define dbg(format, arg...)
> > #endif
>
> Replace this with use of the standard pr_dbg() macro.


Do you mean that I must do:

> /* debug */
> #define IMX_DEBUG 0
> #if IMX_DEBUG
> #define pr_dbg(format, arg...) printk(format, ## arg)
> #else
> #define pr_dbg(format, arg...)
> #endif

Or that I must use a pr_dbg macro defined elsewhere (I don't find it)?


> > #ifdef CONFIG_SND_SOC_MX27_SSI1
> >
> >             dma_request.dst_addr = (dma_addr_t) (SSI1_BASE_ADDR +
> > MXC_SSI1STX0);
> >             printk("dst_addr is %x\n", dma_request.dst_addr);
> >             printk("src_addr is %x\n", dma_request.src_addr);
> > #else
> >             dma_request.dst_addr =
> >                 (dma_addr_t) (SSI2_BASE_ADDR + MXC_SSI2STX0);
> > #endif
>
> This should be done based on the DAI used by the machine driver - look
> at how some of the other PCM drivers figure out which DMA parameter to
> use for a given stream.
>

Yes, you are right. I was aware of this issue. But current dai "imx-ssi.c"
only exports dma data for the SDMA API used in i.mx31. So I provisionally
use this trick untill I fix that in the SSI.


>
> > static int mxc_pcm_hw_free(struct snd_pcm_substream *substream)
> > {
> >     struct snd_pcm_runtime *runtime = substream->runtime;
> >     struct mx27_runtime_data *prtd = runtime->private_data;
> >
> >
> >     mxc_dma_free(prtd->dma_ch_tx);
> >     mxc_dma_free(prtd->dma_ch_rx);
> >     snd_pcm_lib_free_pages(substream);
> >
> >     return 0;
> > }
>
> This will free both TX and RX DMA channels but you only allocated one of
> them when the device is opened.


Man, I missed that, thanks.
Do you think this could be related to the problem of not being able of
having both directions working properly?
