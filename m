From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V1 11/11] ASoC: DaVinci: pcm,
 fix underruns by using sram
Date: Sun, 5 Jul 2009 14:03:52 +0100
Message-ID: <20090705130352.GE5334@sirena.org.uk>
References: <1246761001-21982-3-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-4-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-5-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-6-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-7-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-8-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-9-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-10-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-11-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-12-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7495124363
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Jul 2009 15:03:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1246761001-21982-12-git-send-email-troy.kisky@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 04, 2009 at 07:30:01PM -0700, Troy Kisky wrote:
> Fix underruns by using dma to copy 1st to sram
> in a ping/pong buffer style and then copying from
> the sram to the ASP. This also has the advantage
> of tolerating very long interrupt latency on dma
> completion.

Overall this looks good though clearly there are some cross tree merge
issues which will need to be resolved.  I do have some queries and
concerns below, though.

One more general question is what sort of testing you've done with user
space applications - what sort of things have you tried the new DMA code
with?  I'd be especially interested to see this tested with PulseAudio
simply because that is so good at turning up problems with DMA.

> +#define DAVINCI_PCM_DEBUG 0
> +#if DAVINCI_PCM_DEBUG
> +#define DPRINTK(format, arg...) printk(KERN_DEBUG format, ## arg)

I'd be inclined to use the standard DEBUG and VERBOSE_DEBUG defines
here together with their display macros here.

> +/*
> + * when 1st started, ram -> iram dma channel will fill the entire iram
> + * Then, whenever a ping/pong asp buffer finishes, 1/2 iram will be filled
> + */

Indentation.

> -	/* Request parameter RAM reload slot */
> -	ret = edma_alloc_slot(EDMA_SLOT_ANY);
> -	if (ret < 0) {
> -		edma_free_channel(prtd->master_lch);
> -		return ret;
> +	/* Request ram link channel */
> +	ret = prtd->ram_link_lch = edma_alloc_slot(
> +			EDMA_CTLR(prtd->ram_master_lch), EDMA_SLOT_ANY);

The signature for edma_alloc_slot() appears to have changed - that looks
awfully like the SRAM patch or whatever else introduced this change
ought to be including an update for this code to keep it buildable?

> +/* I2S master (codec/cpudai) should start/stop dma request,
> + *  we shouldn't ignore them
> + *  codec AIC33 needs fixed
> + */
> +#define BROKEN_MASTER 1
> +#ifdef BROKEN_MASTER

Could you expand on what's going on here?  The idea that if the CODEC is
master it should be starting DMA sounds wrong - obviously it should know
nothing about the DMA controller.  If you mean that it should start and
stop the clocks that causes issues in situations like TDM since there
can be transfers going on independantly of the CPU which may need the
clocks running.  Not everything will be able to gate the clocks, too.

In any case, this looks like a separate patch that should be split out
of this one.

> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		/* reading ram before asp should be safe
> +		 * as long as the asp transfers less than a ping size
> +		 * of bytes between the 2 reads
> +		 */
> +		edma_get_position(prtd->ram_master_lch,
> +				&ram_src, &ram_dst);
> +		edma_get_position(prtd->asp_master_lch,
> +				&asp_src, &asp_dst);
> +		count_asp = asp_src - prtd->asp_params.src;
> +		count_ram = ram_src - prtd->ram_params.src;
> +		mod_ram = count_ram % period_size;
> +		mod_ram -= count_asp;

Is it perhaps saner to just look at the current position as being the
position of the transfer to SRAM?  This does mean more variation from
the point at which data is audibly playing but on the other hand as far
as the CPU is concerned once the audio gets to SRAM it can't work with
it any longer so it's potentially misleading to report the SRAM
position.  Not all hardware will be able to report the position at all
so userspace ought to be able to cope.

> +	iram_virt = sram_alloc(iram_size, &iram_phys);
> +	if (!iram_virt)
> +		goto exit2;

Should this perhaps be configured via platform data?  You've currently
picked 7 * 512 bytes but there appears to be no urgent reason for that
particular number and presumably SRAM is a limited resource which people
may want to prioritise differently.  That may mean having bigger buffers
for audio as well as less - things like MP3 players can get better
battery life by setting up very big DMAs.  On a similar vein is it worth
considering making this feature entirely optional and/or falling back to
non-SRAM if SRAM allocation fails?

I think we should be able to go with the approach you've got initially
but I suspect that as the SRAM gets more widely used it'll become more
of an issue.
