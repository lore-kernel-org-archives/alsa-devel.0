From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Implementing sync start
Date: Sun, 9 Aug 2009 22:19:37 -0400
Message-ID: <9e4733910908091919o617eb1b8r44436cd87a6873ff@mail.gmail.com>
References: <9e4733910908081116p221e606cma31a95b06d9b5be6@mail.gmail.com>
	<9e4733910908082007n5d2e7f48g453b1f2e3c6eb23e@mail.gmail.com>
	<9e4733910908091913j63debfefja44e8e04e278e087@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f203.google.com (mail-yw0-f203.google.com
	[209.85.211.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 526F62466B
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Aug 2009 04:19:38 +0200 (CEST)
Received: by ywh41 with SMTP id 41so4030895ywh.23
	for <alsa-devel@alsa-project.org>; Sun, 09 Aug 2009 19:19:37 -0700 (PDT)
In-Reply-To: <9e4733910908091913j63debfefja44e8e04e278e087@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Here's how I implemented sync start/stop.......

/**
 * psc_dma_trigger: start and stop the DMA transfer.
 *
 * This function is called by ALSA to start, stop, pause, and resume the DMA
 * transfer of data.
 */
static int psc_dma_trigger(struct snd_pcm_substream *sub, int cmd)
{
	struct snd_soc_pcm_runtime *rtd;
	struct psc_dma *psc_dma;
	struct snd_pcm_runtime *runtime;
	struct psc_dma_stream *s;
	struct snd_pcm_substream *substream;
	struct mpc52xx_psc __iomem *regs;
	u16 imr;
	unsigned long flags;
	int i;

	snd_pcm_group_for_each_entry(substream, sub) {

		rtd = substream->private_data;
		psc_dma = rtd->dai->cpu_dai->private_data;
		runtime = substream->runtime;
		regs = psc_dma->psc_regs;

		dev_dbg(psc_dma->dev, "psc_dma_trigger(substream=%p, cmd=%i)"
			" stream_id=%i\n",
			sub, cmd, substream->pstr->stream);

		if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
			s = &psc_dma->capture;
		else
			s = &psc_dma->playback;

		switch (cmd) {
		case SNDRV_PCM_TRIGGER_START:
			s->period_bytes = frames_to_bytes(runtime,
							  runtime->period_size);
			s->period_start = virt_to_phys(runtime->dma_area);
			s->period_end = s->period_start +
					(s->period_bytes * runtime->periods);
			s->period_next_pt = s->period_start;
			s->period_current_pt = s->period_start;
			s->period_size = runtime->period_size;
			s->active = 1;

			/* track appl_ptr so that we have a better chance of detecting
			 * end of stream and not over running it.
			 */
			s->runtime = runtime;
			s->appl_ptr = s->runtime->control->appl_ptr -
					(runtime->period_size * runtime->periods);

			/* Fill up the bestcomm bd queue and enable DMA.
			 * This will begin filling the PSC's fifo.
			 */
			spin_lock_irqsave(&psc_dma->lock, flags);

			if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE) {
				bcom_gen_bd_rx_reset(s->bcom_task);
				for (i = 0; i < runtime->periods; i++)
					if (!bcom_queue_full(s->bcom_task))
						psc_dma_bcom_enqueue_next_buffer(s);
			} else {
				bcom_gen_bd_tx_reset(s->bcom_task);
				psc_dma_bcom_enqueue_tx(s);
			}

			bcom_enable(s->bcom_task);
			spin_unlock_irqrestore(&psc_dma->lock, flags);

			out_8(&regs->command, MPC52xx_PSC_RST_ERR_STAT);

			break;

		case SNDRV_PCM_TRIGGER_STOP:
			s->active = 0;

			spin_lock_irqsave(&psc_dma->lock, flags);
			bcom_disable(s->bcom_task);
			if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
				bcom_gen_bd_rx_reset(s->bcom_task);
			else
				bcom_gen_bd_tx_reset(s->bcom_task);
			spin_unlock_irqrestore(&psc_dma->lock, flags);

			break;

		default:
			dev_dbg(psc_dma->dev, "invalid command\n");
			return -EINVAL;
		}
		if (sub != substream)
			snd_pcm_trigger_done(substream, sub);

		/* Update interrupt enable settings */
		imr = 0;
		if (psc_dma->playback.active)
			imr |= MPC52xx_PSC_IMR_TXEMP;
		if (psc_dma->capture.active)
			imr |= MPC52xx_PSC_IMR_ORERR;
		out_be16(&regs->isr_imr.imr, psc_dma->imr | imr);
	}
	return 0;
}



-- 
Jon Smirl
jonsmirl@gmail.com
