From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 2/3] ALSA SoC: Add mpc5200-psc I2S driver
Date: Mon, 14 Jul 2008 13:10:54 +0100
Message-ID: <20080714121054.GB25448@sirena.org.uk>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080712083934.15025.86862.stgit@trillian.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 07C8824336
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Jul 2008 14:10:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080712083934.15025.86862.stgit@trillian.secretlab.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 12, 2008 at 02:39:34AM -0600, Grant Likely wrote:

> This is an I2S bus driver for the MPC5200 PSC device.  It is probably
> will not be merged as-is because it uses v1 of the ASoC API, but I want
> to get it out there for comments.

Looks basically good.  A few things below, plus you probably want to run
checkpatch over it.

> +/* Bestcomm DMA irq handler */
> +static irqreturn_t psc_i2s_bcom_irq(int irq, void *_psc_i2s_stream)
> +{
> +	struct psc_i2s_stream *s = _psc_i2s_stream;
> +
> +	//spin_lock(&s->psc_i2s->lock);

Either the lock is needed or it isn't :) .

> + * If this is the first stream open, then grab the IRQ and program most of
> + * the PSC registers.

> +static int psc_i2s_startup(struct snd_pcm_substream *substream)
> +{

The comment here doesn't seem to reflect what the function does - it
looks to just unconditionally reinitialise the controller with things
like this:

> +	/* Disable all interrupts and reset the PSC */
> +	out_be16(&regs->mpc52xx_psc_imr, 0);
> +	out_8(&regs->command, 3 << 4); /* reset transmitter */
> +	out_8(&regs->command, 2 << 4); /* reset receiver */
> +	out_8(&regs->command, 1 << 4); /* reset mode */
> +	out_8(&regs->command, 4 << 4); /* reset error */

which I'd imagine might upset running streams?

> +static int psc_i2s_trigger(struct snd_pcm_substream *substream, int cmd)
> +{

> +       case SNDRV_PCM_TRIGGER_STOP:

> +       case SNDRV_PCM_TRIGGER_STOP:

> +	default:
> +		dev_dbg(psc_i2s->dev, "invalid command\n");
> +		return -EINVAL;
> +	}

This doesn't handle the pause, suspend, resume or pause_release
triggers.  If there's really nothing to do for those it should ignore
them, especially given the default: behaviour.
