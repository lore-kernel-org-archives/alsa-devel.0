From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ALSA:ATMEL: common arch for audio via ssc(patch
	2/3: adding directories)
Date: Fri, 26 Sep 2008 13:19:08 +0100
Message-ID: <20080926121907.GA15493@sirena.org.uk>
References: <48DCAA37.2080508@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0384D103810
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Sep 2008 14:19:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48DCAA37.2080508@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Cc: alsa-devel@alsa-project.org, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, Geoffrey Wossum <geoffrey@pager.net>, Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 26, 2008 at 11:24:07AM +0200, Sedji Gaouaou wrote:
> This patch contains:
> The Kconfig and Makefile, plus the interface files(atmel_ssc_dai and 
> atmel-pcm).

This all looks very good - I've got some comments below but they're all
fairly minor coding style issues.  The only ones that really need to be
addressed are the commented out code and the use of printk KERN_DEBUG
rather than pr_dbg().  However, your mailer appears to have word wrapped
the patch so it won't apply - you'll need to reconfigure your MUA to
avoid this.

You also need to include a Signed-off-by: line in your message when
submitting patches, it's required for code going into the Linux kernel.
Documentation/SubmittingPatches contains an explanation of what that's
for and the text you'd be agreeing to.

Please also include a more detailed changelog entry in your patch
explaining that you're unifying the existing Ateml .  
Documentation/SubmittingPatches has some guidance on this.

> +config SND_ATMEL_SOC_SSC
> +	tristate
> +	depends on SND_ATMEL_SOC
> +	help
> +	  Say Y or M if you want to add support for codecs the

...connected to an...

> +	  ATMEL SSC interface. You will also needs to select the individual
> +	  machine drivers to support below.

> +	buf->dev.dev = pcm->card->dev;
> +	buf->private_data = NULL;
> +	buf->area = dma_alloc_writecombine(pcm->card->dev, size,
> +					   &buf->addr, GFP_KERNEL);
> +	/*buf->area = dma_alloc_coherent(pcm->card->dev, size,
> +					  &buf->addr, GFP_KERNEL);*/

Please remove commented code like this.

> +	printk(KERN_DEBUG "atmel-pcm:"
> +		"preallocate_dma_buffer: area=%p, addr=%p, size=%d\n",
> +		(void *) buf->area,
> +		(void *) buf->addr,
> +		size);

It's probably better to use pr_dbg() for this and most of the other
KERN_DEBUG prints - I'd expect the current code would be too verbose
for normal operation.

> +static int atmel_pcm_mmap(struct snd_pcm_substream *substream,
> +	struct vm_area_struct *vma)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +
> +	return dma_mmap_writecombine(substream->pcm->card->dev, vma,
> +				     runtime->dma_area,
> +				     runtime->dma_addr,
> +				     runtime->dma_bytes);
> +	/*return remap_pfn_range(vma, vma->vm_start,
> +		       substream->dma_buffer.addr >> PAGE_SHIFT,
> +		       vma->vm_end - vma->vm_start, vma->vm_page_prot);*/
> +}

Again, please remove the old, commented code.  There's some other
instances of this in the patch.

> +	/*
> +	 * Currently, there is only one set of dma params for
> +	 * each direction.  If more are added, this code will
> +	 * have to be changed to select the proper set.
> +	 */
> +	dir = ((substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
> +		0 : 1);

I'd really prefer

	if (substream->stream == SND_PCM_STREAM_PLAYBACK)
		dir = 1;
	else
		dir = 0;

for clarity.

> +		 *  For single channel data, one sample is transferred
> +		 * on the falling edge of the LRC clock.
> +		 * For two channel data, one sample is
> +		 * transferred on both edges of the LRC clock.
> +		 */
> +		start_event = ((channels == 1)
> +				? SSC_START_FALLING_RF
> +				: SSC_START_EDGE_RF);

Please expand this to

	if (channels == 1)
		start_event = SSC_START_FALLING_RF;
	else
		start_event = SSC_START_EDGE_RF;

> +#define ATMEL_SSC_RATES (SNDRV_PCM_RATE_8000  | SNDRV_PCM_RATE_11025 |\
> +			SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |\
> +			SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |\
> +			SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |\
> +			SNDRV_PCM_RATE_96000)

Might be clearer to say SNDRV_PCM_RATE_8000_96000 unless there are some
rates which that includes that are missing in there but it's not
important either way.
