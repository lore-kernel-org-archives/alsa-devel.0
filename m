From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: Re: [PATCH 2/3] Add ALSA driver for Atmel Audio
 Bitstream	DAC
Date: Wed, 4 Feb 2009 13:18:35 +0100
Message-ID: <20090204131835.522552c3@hcegtvedt>
References: <1233748114-6353-1-git-send-email-hans-christian.egtvedt@atmel.com>
	<1233748114-6353-2-git-send-email-hans-christian.egtvedt@atmel.com>
	<1233748114-6353-3-git-send-email-hans-christian.egtvedt@atmel.com>
	<s5hfxiu9zth.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (relay.atmel.no [80.232.32.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E3AD24385
	for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2009 13:18:37 +0100 (CET)
In-Reply-To: <s5hfxiu9zth.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 04 Feb 2009 13:00:42 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Wed,  4 Feb 2009 12:48:33 +0100,
> Hans-Christian Egtvedt wrote:
> > 
> > +static int at32_abdac_hw_params(struct snd_pcm_substream
> > *substream,
> > +		struct snd_pcm_hw_params *hw_params)
> > +{
> > +	struct at32_abdac *dac = snd_pcm_substream_chip(substream);
> > +	int retval;
> > +
> > +	retval = snd_pcm_lib_malloc_pages(substream,
> > +			params_buffer_bytes(hw_params));
> > +	if (retval)
> > +		return retval;
> 
> snd_pcm_lib_malloc_pages() returns 1 if the buffer is changed
> (e.g. reallocation).  So, this check should be if (retval < 0).
> 

Ah, okay, I'll fix this.

> > +static int at32_abdac_trigger(struct snd_pcm_substream *substream,
> > int cmd) +{
> > +	struct at32_abdac *dac = snd_pcm_substream_chip(substream);
> > +	int retval = -EINVAL;
> > +
> > +	switch (cmd) {
> > +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE: /* fall through */
> > +	case SNDRV_PCM_TRIGGER_RESUME: /* fall through */
> > +	case SNDRV_PCM_TRIGGER_START:
> > +		clk_enable(dac->sample_clk);
> > +		retval = dw_dma_cyclic_start(dac->dma.chan);
> > +		if (retval)
> > +			goto out;
> > +		dac_writel(dac, CTRL, DAC_BIT(EN));
> > +		break;
> > +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH: /* fall through */
> > +	case SNDRV_PCM_TRIGGER_SUSPEND: /* fall through */
> > +	case SNDRV_PCM_TRIGGER_STOP:
> > +		set_bit(DMA_STOP, &dac->flags);
> > +		dw_dma_cyclic_stop(dac->dma.chan);
> > +		dac_writel(dac, DATA, 0);
> > +		dac_writel(dac, CTRL, 0);
> > +		clk_disable(dac->sample_clk);
> > +		break;
> 
> No retval is set for these cases?
> 

Nope, they are all void return functions and will always complete
successfully.

> > +static int __devinit at32_abdac_probe(struct platform_device *pdev)
> (snip)
> > +	retval = -ENOMEM;
> > +	card = snd_card_new(SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
> > +			THIS_MODULE, sizeof(struct at32_abdac));
> 
> The recent version has a newer API, snd_card_create().  This function
> gives the error code.  Please use the new function instead.
> 

Okay, no problem, will redo with the new API.

-- 
Best regards,
Hans-Christian Egtvedt
