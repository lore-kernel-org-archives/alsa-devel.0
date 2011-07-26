From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V5 1/3] ASoC: Alchemy AC97C/I2SC audio
	support
Date: Tue, 26 Jul 2011 15:31:13 +0100
Message-ID: <20110726143112.GF7285@opensource.wolfsonmicro.com>
References: <1311594287-31576-1-git-send-email-manuel.lauss@googlemail.com>
	<1311594287-31576-2-git-send-email-manuel.lauss@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1311594287-31576-2-git-send-email-manuel.lauss@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Linux-MIPS <linux-mips@linux-mips.org>, alsa-devel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 25, 2011 at 01:44:45PM +0200, Manuel Lauss wrote:

Looks good, I'll apply this but a few minor comments you might want to
look at incrementally.

> +#define ALCHEMY_PCM_FMTS					\
> +	(SNDRV_PCM_FMTBIT_S8     | SNDRV_PCM_FMTBIT_U8 |	\
> +	 SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE |	\
> +	 SNDRV_PCM_FMTBIT_U16_LE | SNDRV_PCM_FMTBIT_U16_BE |	\
> +	 SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S32_BE |	\
> +	 SNDRV_PCM_FMTBIT_U32_LE | SNDRV_PCM_FMTBIT_U32_BE |	\
> +	 0)

Why the | 0?  Same for the other one.

> +	case (DMA_D0 | DMA_D1):
> +		pr_debug("DMA %d missed interrupt.\n", stream->dma);
> +		au1000_dma_stop(stream);
> +		au1000_dma_start(stream);
> +		break;
> +	case (~DMA_D0 & ~DMA_D1):
> +		pr_debug("DMA %d empty irq.\n", stream->dma);

This case should return IRQ_NONE really since it didn't handle an
interrupt...
