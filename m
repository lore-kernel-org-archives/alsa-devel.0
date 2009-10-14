From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH - try2] ASoC: Codec driver for Texas
 Instruments tlv320dac33 codec
Date: Wed, 14 Oct 2009 12:14:10 +0100
Message-ID: <20091014111409.GE20639@rakim.wolfsonmicro.main>
References: <1255435391-18160-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5B1E910381A
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Oct 2009 13:14:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1255435391-18160-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 13, 2009 at 03:03:11PM +0300, Peter Ujfalusi wrote:

> b) The nSample mode implementation uses one interrupt line from DAC33 to

Just a thought, but could a timer based approach work here?

> +	case SND_SOC_BIAS_PREPARE:
> +		break;
> +	case SND_SOC_BIAS_STANDBY:
> +		dac33_soft_power(codec, 0);
> +		break;
> +	case SND_SOC_BIAS_OFF:
> +		break;
> +	}

It'd be nice to do the full power down in BIAS_OFF for future use.

> +static irqreturn_t dac33_interrupt_handler(int irq, void *dev)
> +{
> +	struct snd_soc_codec *codec = dev;
> +	struct tlv320dac33_priv *dac33 = codec->private_data;
> +
> +	if (dac33->state == DAC33_PLAYBACK)
> +		queue_work(dac33->dac33_wq, &dac33->work);
> +
> +	return IRQ_HANDLED;
> +}

Should that return IRQ_HANDLED if it's not expecting an interrupt?  I'd
also expect to see something that either acknowledges the interrupt to
deassert it or keeps it masked until the work has had a chance to do
something.

> +	pdata = (struct tlv320dac33_platform_data *)client->dev.platform_data;

Unneeded cast.

> +	dac33->dac33_wq = create_rt_workqueue("tlv320dac33");
> +	if (dac33->dac33_wq == NULL) {
> +		ret = -ENOMEM;
> +		goto error_wq;
> +	}

Might be nice to skip the workqueue stuff if we don't have an IRQ.
Conditional registration of the nSample controls based on having the IRQ
may also be nice.

> +	ret = snd_soc_register_codec(codec);
> +	if (ret != 0) {
> +		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
> +		goto error_codec;
> +	}

> +	ret = snd_soc_register_dai(&dac33_dai);
> +	if (ret != 0) {
> +		dev_err(codec->dev, "Failed to register DAI: %d\n", ret);
> +		snd_soc_unregister_codec(codec);
> +		goto error_codec;
> +	}

I'd do these last so that we don't have ASoC level init trying to use
the device only to have it yanked from underneath it by a failure in the
following code.
