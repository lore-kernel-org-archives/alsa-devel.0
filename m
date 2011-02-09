From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: mfld_machine: Add support for
	jack detection
Date: Wed, 9 Feb 2011 13:55:06 +0000
Message-ID: <20110209135506.GD24042@opensource.wolfsonmicro.com>
References: <1297242747-18632-1-git-send-email-vinod.koul@intel.com>
	<1297242747-18632-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3F725103868
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 14:55:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1297242747-18632-3-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 09, 2011 at 02:42:26PM +0530, Koul, Vinod wrote:

> +	sn95031_jack_detection(&jack_data);
> +	/* If american headest, program the gpio control registers */
> +	if (jack_data.micbias_vol >=  MFLD_MV_HP &&
> +		jack_data.micbias_vol <  MFLD_MV_HS)
> +		snd_soc_update_bits(mfld_jack.codec, SN95031_AUDIO_GPIO_CTRL,
> +				BIT(1), BIT(1));
> +	else
> +		snd_soc_update_bits(mfld_jack.codec, SN95031_AUDIO_GPIO_CTRL,
> +				BIT(1), BIT(0));

This looks like the CODEC driver should be exporting gpiolib support -
that'd make it much easier for others to reuse the GPIOs in their
designs (eg, powering external amplifiers).

> +static irqreturn_t snd_mfld_jack_intr_handler(int irq, void *dev)
> +{
> +	struct mfld_mc_private *mc_private = (struct mfld_mc_private *) dev;
> +
> +	memcpy_fromio(&mc_private->interrupt_status,
> +			((void *)(mc_private->int_base)),
> +			sizeof(u8));
> +	return IRQ_WAKE_THREAD;
> +}

Seems like it'd be as easy to do the copy in the main interrupt handler
rather than bothering with having a primary handler but it doesn't
really matter.
