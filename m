From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 3/7] ASoC: tegra: Add tegra-pcm driver
Date: Tue, 11 Jan 2011 09:59:00 +0200
Message-ID: <4D2C0DC4.4000405@nokia.com>
References: <1294464977-25814-1-git-send-email-swarren@nvidia.com>
	<1294464977-25814-4-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa01.nokia.com (smtp.nokia.com [147.243.1.47])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C5EF2454F
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 08:59:02 +0100 (CET)
In-Reply-To: <1294464977-25814-4-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Stephen Warren <swarren@nvidia.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 01/08/11 07:36, ext Stephen Warren wrote:
> This provides an ASoC platform driver that manages Tegra's APB DMA
> controller.
> =

> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  sound/soc/tegra/tegra_pcm.c |  401 +++++++++++++++++++++++++++++++++++++=
++++++
>  sound/soc/tegra/tegra_pcm.h |   55 ++++++
>  2 files changed, 456 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/tegra/tegra_pcm.c
>  create mode 100644 sound/soc/tegra/tegra_pcm.h
> =

> diff --git a/sound/soc/tegra/tegra_pcm.c b/sound/soc/tegra/tegra_pcm.c

...

> +       switch (cmd) {
> +       case SNDRV_PCM_TRIGGER_START:
> +               prtd->dma_pos =3D 0;
> +               prtd->dma_pos_end =3D frames_to_bytes(runtime, runtime->p=
eriods * runtime->period_size);
> +               prtd->period_index =3D 0;
> +               prtd->dma_req_idx =3D 0;
> +               /* Fall-through */
> +       case SNDRV_PCM_TRIGGER_RESUME:
> +       case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +               spin_lock_irqsave(&prtd->lock, flags);
> +               prtd->running =3D 1;
> +               spin_unlock_irqrestore(&prtd->lock, flags);
> +               tegra_pcm_queue_dma(prtd);
> +               tegra_pcm_queue_dma(prtd);
> +               break;
> +       case SNDRV_PCM_TRIGGER_STOP:
> +       case SNDRV_PCM_TRIGGER_SUSPEND:
> +       case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +               spin_lock_irqsave(&prtd->lock, flags);
> +               prtd->running =3D 0;
> +               spin_unlock_irqrestore(&prtd->lock, flags);
> +               tegra_dma_dequeue_req(prtd->dma_chan, &prtd->dma_req[0]);
> +               tegra_dma_dequeue_req(prtd->dma_chan, &prtd->dma_req[1]);

Does tegra_dma_dequeue_req stops the ongoing DMA transaction as well?
If I read the code right, you have two DMA requests placed at every
given time (one is currently running, the other is waiting).
What happens if the dma_req[0] was running, and you dequeue it? Will the
DMA engine moves to process the dma_req[1], which will be stopped a
moment later?

-- =

P=E9ter
