From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASoC: DMA Platform driver for i.mx27
Date: Tue, 14 Apr 2009 21:42:44 +0100
Message-ID: <20090414204243.GB6902@sirena.org.uk>
References: <eedb5540904140917ic0f3626s5f6b98a2d22ec36b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 595A6103869
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 22:42:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <eedb5540904140917ic0f3626s5f6b98a2d22ec36b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 14, 2009 at 06:17:39PM +0200, javier Martin wrote:

> This still does not support bidirectional audio but works when used playback
> or capture separatelly.
> 
> SDMA API used in i.mx31 dma driver has been moved to DMA API.
> 
> Please, have patience with me, this is a very experimental version and I am
> new to this world (audio codecs and linux in general).
> 
> 
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>

This all looks basically OK at first read, though you probably want to
run it through checkpatch.pl for coding style things - this might help
spot some more stuff.

A few smallish issues below:

>  *  Revision history
>  *    14th April 2009   Initial version.
>  *
>  */

Remove the history bit - once it's merged git will provide logs.

> /* debug */
> #define IMX_DEBUG 0
> #if IMX_DEBUG
> #define dbg(format, arg...) printk(format, ## arg)
> #else
> #define dbg(format, arg...)
> #endif

Replace this with use of the standard pr_dbg() macro.

> /*!
>   * This function is called whenever a new audio block needs to be
>   * transferred to wm8974. The function receives the address and the size
>   * of the new block and start a new DMA transfer.
>   *
>   * @param    substream    pointer to the structure of the current stream.
>   *
>   */

The kernel uses /** to introduce marked up functions.  You probably want
to say "the codec" rather than wm8974 - other options are also available :)

> #ifdef CONFIG_SND_SOC_MX27_SSI1
> 
>             dma_request.dst_addr = (dma_addr_t) (SSI1_BASE_ADDR +
> MXC_SSI1STX0);
>             printk("dst_addr is %x\n", dma_request.dst_addr);
>             printk("src_addr is %x\n", dma_request.src_addr);
> #else
>             dma_request.dst_addr =
>                 (dma_addr_t) (SSI2_BASE_ADDR + MXC_SSI2STX0);
> #endif

This should be done based on the DAI used by the machine driver - look
at how some of the other PCM drivers figure out which DMA parameter to
use for a given stream.

> static int mxc_pcm_hw_free(struct snd_pcm_substream *substream)
> {
>     struct snd_pcm_runtime *runtime = substream->runtime;
>     struct mx27_runtime_data *prtd = runtime->private_data;
> 
> 
>     mxc_dma_free(prtd->dma_ch_tx);
>     mxc_dma_free(prtd->dma_ch_rx);
>     snd_pcm_lib_free_pages(substream);
> 
>     return 0;
> }

This will free both TX and RX DMA channels but you only allocated one of
them when the device is opened.
