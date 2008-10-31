From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/1] [ALSA]TLV320AIC23B: Support more
	sample rates
Date: Fri, 31 Oct 2008 22:11:56 +0000
Message-ID: <20081031221155.GA6786@sirena.org.uk>
References: <1225488034-28557-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 552CD246D0
	for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2008 23:12:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1225488034-28557-1-git-send-email-troy.kisky@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: alsa-devel@alsa-project.org, arunks@mistralsolutions.com
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 31, 2008 at 02:20:34PM -0700, Troy Kisky wrote:
> Add support for more sample rates, different crystals
> and split playback/capture rates.
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> Acked-by: Arun KS <arunks@mistralsolutions.com>

This looks good, thanks - it's great to see more drivers moving away
from fixed tables for clock sources.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

but a few minor coding standard things:

> +	for (i = 0; i < 4; i++) {
> +		int base = mclk / bosr_usb_divisor_table[i];
> +		int mask = sr_valid_mask[i];

...

> +		for (j = 0; j < 16; j++, mask >>= 1) {

...

> +			adc = base * sr_adc_mult_table[j];
> +			dac = base * sr_dac_mult_table[j];

It'd be better if these loops used ARRAY_SIZE() for the limits rather
than having magic numbers.

> +static int set_sample_rate_control(struct snd_soc_codec *codec, int mclk,
> +		u32 sample_rate_adc, u32 sample_rate_dac)
> +{
> +	/* Search for the right sample rate */
> +	int data = find_rate(mclk, sample_rate_adc, sample_rate_dac);
> +	if (data < 0) {
> +		printk(KERN_ERR "%s:Invalid rate %u,%u requested\n",
> +				__func__, sample_rate_adc, sample_rate_dac);
> +		return -EINVAL;
> +	}
> +	tlv320aic23_write(codec, TLV320AIC23_SRATE, data);
> +	if (1) {
> +		int adc, dac;
> +		get_current_sample_rates(codec, mclk, &adc, &dac);
> +		printk(KERN_DEBUG "actual samplerate = %u,%u reg=%x\n",
> +			adc, dac, data);
> +	}

There's no need for the if () statement here - you can just open a new
block.  I guess this is supposed to be for debug purposes only?  If so
then it'd be better to surround it in #ifdef DEBUG.
