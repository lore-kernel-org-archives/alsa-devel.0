From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: Re: [PATCH 2/3] Add ALSA driver for Atmel Audio
 Bitstream	DAC
Date: Wed, 4 Feb 2009 13:58:21 +0100
Message-ID: <20090204135821.612fc1fc@hcegtvedt>
References: <1233748114-6353-1-git-send-email-hans-christian.egtvedt@atmel.com>
	<1233748114-6353-2-git-send-email-hans-christian.egtvedt@atmel.com>
	<1233748114-6353-3-git-send-email-hans-christian.egtvedt@atmel.com>
	<s5hfxiu9zth.wl%tiwai@suse.de> <20090204131835.522552c3@hcegtvedt>
	<s5h7i469xft.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (relay.atmel.no [80.232.32.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B1D7243BF
	for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2009 13:58:22 +0100 (CET)
In-Reply-To: <s5h7i469xft.wl%tiwai@suse.de>
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

On Wed, 04 Feb 2009 13:52:06 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 4 Feb 2009 13:18:35 +0100,
> Hans-Christian Egtvedt wrote:
> > 
> > > > +static int at32_abdac_trigger(struct snd_pcm_substream
> > > > *substream, int cmd) +{
> > > > +	struct at32_abdac *dac =
> > > > snd_pcm_substream_chip(substream);
> > > > +	int retval = -EINVAL;
> > > > +
> > > > +	switch (cmd) {
> > > > +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE: /* fall through
> > > > */
> > > > +	case SNDRV_PCM_TRIGGER_RESUME: /* fall through */
> > > > +	case SNDRV_PCM_TRIGGER_START:
> > > > +		clk_enable(dac->sample_clk);
> > > > +		retval = dw_dma_cyclic_start(dac->dma.chan);
> > > > +		if (retval)
> > > > +			goto out;
> > > > +		dac_writel(dac, CTRL, DAC_BIT(EN));
> > > > +		break;
> > > > +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH: /* fall through */
> > > > +	case SNDRV_PCM_TRIGGER_SUSPEND: /* fall through */
> > > > +	case SNDRV_PCM_TRIGGER_STOP:
> > > > +		set_bit(DMA_STOP, &dac->flags);
> > > > +		dw_dma_cyclic_stop(dac->dma.chan);
> > > > +		dac_writel(dac, DATA, 0);
> > > > +		dac_writel(dac, CTRL, 0);
> > > > +		clk_disable(dac->sample_clk);
> > > > +		break;
> > > 
> > > No retval is set for these cases?
> > > 
> > 
> > Nope, they are all void return functions and will always complete
> > successfully.
> 
> I meant that retval is kept -EINVAL in the cases for STOP, etc,
> although the call is successful.
> 

Ops, my bad, will fix.

Thanks.

-- 
Best regards,
Hans-Christian Egtvedt
