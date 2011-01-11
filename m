From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH 3/7] ASoC: tegra: Add tegra-pcm driver
Date: Tue, 11 Jan 2011 08:34:35 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF03105680AB@HQMAIL01.nvidia.com>
References: <1294464977-25814-1-git-send-email-swarren@nvidia.com>
	<1294464977-25814-4-git-send-email-swarren@nvidia.com>
	<4D2C0DC4.4000405@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D7A224453
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 17:39:21 +0100 (CET)
In-Reply-To: <4D2C0DC4.4000405@nokia.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Peter Ujfalusi wrote:
> 
> On 01/08/11 07:36, ext Stephen Warren wrote:
> > diff --git a/sound/soc/tegra/tegra_pcm.c b/sound/soc/tegra/tegra_pcm.c
> 
> ...
> 
> > +       switch (cmd) {
> > +       case SNDRV_PCM_TRIGGER_START:
...
> > +       case SNDRV_PCM_TRIGGER_RESUME:
> > +       case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> > +               spin_lock_irqsave(&prtd->lock, flags);
> > +               prtd->running = 1;
> > +               spin_unlock_irqrestore(&prtd->lock, flags);
> > +               tegra_pcm_queue_dma(prtd);
> > +               tegra_pcm_queue_dma(prtd);
> > +               break;
> > +       case SNDRV_PCM_TRIGGER_STOP:
> > +       case SNDRV_PCM_TRIGGER_SUSPEND:
> > +       case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> > +               spin_lock_irqsave(&prtd->lock, flags);
> > +               prtd->running = 0;
> > +               spin_unlock_irqrestore(&prtd->lock, flags);
> > +               tegra_dma_dequeue_req(prtd->dma_chan, &prtd->dma_req[0]);
> > +               tegra_dma_dequeue_req(prtd->dma_chan, &prtd->dma_req[1]);
> 
> Does tegra_dma_dequeue_req stops the ongoing DMA transaction as well?
> If I read the code right, you have two DMA requests placed at every
> given time (one is currently running, the other is waiting).
> What happens if the dma_req[0] was running, and you dequeue it? Will the
> DMA engine moves to process the dma_req[1], which will be stopped a
> moment later?

Yes, that's my understanding.

The DMA driver internally implements tegra_dma_cancel(), which may be a
better thing to use in the long run (simply disables the DMA engine, and
drops everything from the queue without running any completion callbacks).
However, that's not publicly exposed in the header right now; I was going
to investigate why first before trying to use it.

-- 
nvpublic
