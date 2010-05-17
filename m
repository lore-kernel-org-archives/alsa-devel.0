From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] NUC900/audio: add nuc900 audio driver
	support
Date: Mon, 17 May 2010 03:44:26 +0100
Message-ID: <20100517024425.GA2485@opensource.wolfsonmicro.com>
References: <4BF01069.6060102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D56AA2448A
	for <alsa-devel@alsa-project.org>;
	Mon, 17 May 2010 04:44:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4BF01069.6060102@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Ben Dooks <ben-linux@fluff.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, May 16, 2010 at 11:34:01PM +0800, Wan ZongShun wrote:

This all looks pretty good.  A few comments below but they're all fairly
minor and should be easy to address.

> index b1749bc..81d4848 100644
> --- a/sound/soc/Kconfig
> +++ b/sound/soc/Kconfig
> @@ -36,6 +36,7 @@ source "sound/soc/s3c24xx/Kconfig"
>  source "sound/soc/s6000/Kconfig"
>  source "sound/soc/sh/Kconfig"
>  source "sound/soc/txx9/Kconfig"
> +source "sound/soc/nuc900/Kconfig"

Please keep the Kconfig and Makefile sorted, this helps avoid merge
issues.

> +#define NUC900_AC97_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
> +			SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |\
> +				SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)

SNDRV_PCM_RATE_8000_48000.

> +	if (!timeout)
> +		dev_err(nuc900_audio->dev, "AC97 read register time out !\n");
> +
> +	val = AUDIO_READ(nuc900_audio->mmio + ACTL_ACOS0) ;

If the read timed out shouldn't we be returning rather than continuing?

> +	val = AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON);
> +	val &= (~AC_C_RES);
> +	AUDIO_WRITE(nuc900_audio->mmio + ACTL_ACCON, val);

> +	udelay(1000);

> +	if (!(AUDIO_READ(nuc900_audio->mmio + ACTL_ACIS0) & CODEC_READY))
> +		dev_err(nuc900_audio->dev, "AC97 codec cold reset failed!\n");

What is this actually checking in the hardware?  Not all CODECs enable
the AC97 link by default after a cold reset, the standard allows them to
power up in a low power state which will

On the other hand, given that there's no warm reset operation perhaps
this isn't a big deal.

> +static void nuc900_ac97_remove(struct platform_device *pdev,
> +						struct snd_soc_dai *dai)
> +{
> +	struct nuc900_audio *nuc900_audio = nuc900_ac97_data;
> +
> +	/* Enable unit clock */
> +	clk_disable(nuc900_audio->clk);

Bit rot in the comments here.

> +/* bit definition of REG_ACTL_CON register */
> +#define	AUDCLK_EN		0x8000
> +#define	PFIFO_EN		0x4000
> +#define	RFIFO_EN		0x2000

These constants (and the rest) really should be namespaced - they're
likely to collide with other definitions in, for example, CODEC drivers
used by machines.

> +#define	IIS_EN			0x0002

Looks like there's I2S support to come?

> +static irqreturn_t nuc900_dma_interrupt(int irq, void *dev_id)
> +{

> +
> +	snd_pcm_period_elapsed(substream);
> +
> +	return IRQ_HANDLED;

This is done unconditionally - are you sure there can't be any spurious
interrupts (eg, error interrupts).  It shouldn't cause any harm, of
course.
