From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/2] ASoC: dmaengine-pcm: Add support for
	querying	stream position from DMA device
Date: Mon, 11 Jun 2012 15:09:31 +0100
Message-ID: <20120611140931.GH11168@n2100.arm.linux.org.uk>
References: <1339416253-4121-1-git-send-email-lars@metafoo.de>
	<1339416253-4121-2-git-send-email-lars@metafoo.de>
	<20120611132409.GG11168@n2100.arm.linux.org.uk>
	<4FD5FA82.7090107@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 45EC0244BA
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2012 16:09:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4FD5FA82.7090107@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 11, 2012 at 04:02:42PM +0200, Lars-Peter Clausen wrote:
> On 06/11/2012 03:24 PM, Russell King - ARM Linux wrote:
> > On Mon, Jun 11, 2012 at 02:04:13PM +0200, Lars-Peter Clausen wrote:
> >> @@ -202,7 +203,27 @@ EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_trigger);
> >>  snd_pcm_uframes_t snd_dmaengine_pcm_pointer(struct snd_pcm_substream *substream)
> >>  {
> >>  	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
> >> -	return bytes_to_frames(substream->runtime, prtd->pos);
> >> +	struct dma_tx_state state;
> >> +	enum dma_status status;
> >> +	unsigned int pos;
> >> +
> >> +	status = dmaengine_tx_status(prtd->dma_chan, prtd->cookie, &state);
> >> +	if (status != DMA_IN_PROGRESS && status != DMA_PAUSED) {
> >> +		pos = 0;
> >> +	} else if (state.residue == 0) {
> >> +		/* This should never happen with cyclic transfers, so assume
> >> +		 * that the dmaengine driver does not support reporting residue
> >> +		 * and fall back to counting periods. */
> >> +		pos = prtd->pos;
> > 
> > That is an incorrect assumption.
> > 
> > The current DMA position is defined by the DMA pointer.  When the DMA
> > engine has transferred the last few bytes of the DMA, the DMA pointer
> > will be pointing to the byte _after_ the last byte transferred in the
> > buffer.
> > 
> > Therefore, when you calculate the residue as (buf_start + buf_len -
> > current_pointer) you end up with zero.
> 
> My assumption is that for cyclic DMA it will be pointing to the first byte
> again after the last byte has been transferred. Something like this:
> 
> offset = (offset + 1) % buf_len
> and current_pointer = buf_start + offset
> 
> If this is not true for a particular DMA controller I think we should still
> make sure in the driver for this controller that residue will never be zero
> for cyclic transfers, but instead will return the buffer size. This is the
> only thing that really makes sense. The buffer only has buf_len bytes, if
> residue can be a value in the interval of [0,buf_len] this means that it has
> buf_len+1 possible values. Which again means there must be two values which
> map to the same state. In this case it would be 0 and buf_len.

No.  Think about it.  Think about the race conditions which can occur.
You take a spin lock with IRQs disabled.  The DMA engine then completes
the final transfer, and stops with the DMA pointer pointing at the byte
after the last one transferred.  You read the DMA pointer.  Because you're
holding a spinlock, the interrupt to tell you that the DMA has completed
can't be delivered.  You perform the calculation I gave, and the value
will be zero.

That's because you need the interrupt to happen in order to restart the
cyclic DMA.

This _does_ happen with existing drivers.  You can't ignore it.  The whole
"return 0 if you don't implement it" has always been an absurd idea.  You
can't reliably use it to detect lack of implementation.

The only way to detect it is to note whether the residue is ever non-zero.
If it becomes non-zero, always assume it is valid.  Otherwise, if it always
seems to be zero, only then can you make such an assumption.
