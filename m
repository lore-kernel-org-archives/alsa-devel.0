From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: new ADAV801/ADAV803 codec driver
Date: Sat, 7 Aug 2010 19:11:54 +0100
Message-ID: <49DFFA4C-ED3F-40A2-B448-388A3FD8EE93@opensource.wolfsonmicro.com>
References: <1281194864-23311-1-git-send-email-vapier@gentoo.org>
	(sfid-20100807_162746_281383_2D369E92)
Mime-Version: 1.0 (iPad Mail 7B405)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F0F0F1037FE
	for <alsa-devel@alsa-project.org>;
	Sat,  7 Aug 2010 20:11:37 +0200 (CEST)
In-Reply-To: <1281194864-23311-1-git-send-email-vapier@gentoo.org>
	(sfid-20100807_162746_281383_2D369E92)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: Cliff Cai <cliff.cai@analog.com>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Yi Li <yi.li@analog.com>
List-Id: alsa-devel@alsa-project.org

On 7 Aug 2010, at 16:27, Mike Frysinger <vapier@gentoo.org> wrote:

> -	select SND_SOC_ADS117X
>  	select SND_SOC_AD73311 if I2C
> +	select SND_SOC_ADAV80X if SND_SOC_I2C_AND_SPI
> +	select SND_SOC_ADS117X

The restarting should really have been done separately or flagged in the changelog - part of making things easy to review is avoiding surprises.

> +static struct snd_soc_codec *adav80x_codec;
> +struct snd_soc_codec_device soc_codec_dev_adav80x;
> +static int adav80x_register(struct adav80x_priv *adav80x, int bus_type);
> +static void adav80x_unregister(struct adav80x_priv *adav80x);

This also needs to be redone against multi-component as with the driver I reviewed earlier today. Please avoid posting any further drivers that haven't been done against multi-component, it'll be merged into -next pretty much as soon as the merge window closes.

> +	/* DAC peak volume detect, read clears it */
> +	SOC_DOUBLE_R("DAC Peak Volume", ADAV80X_DAC_L_PEAK_VOL,
> +			ADAV80X_DAC_R_PEAK_VOL, 0, 0x3F, 0),

This really needs a new, read only, control type defining. I'm also not seeing these registers being marked as volatile which means that these controls will always return cached values rather than actual data read from the chip.

> +	/* ADC volume control */
> +	SOC_DOUBLE_R("ADC Volume", ADAV80X_ADC_L_VOL,
> +			ADAV80X_ADC_R_VOL, 0, 0xFF, 0),

Use Playback and Capture instead of DAC and ADC.

> +		/* ADC Modulator clock is 6.144MHz Max,
> +		   need to set devidor properly */
> +		if (sample_rate == 96000)
> +			reg |= 0x80;
> +		else if (sample_rate == 48000)
> +			reg &= 0x7F;
> +		else
> +			/* Unsupported sample rate */
> +			return -1;

A switch statement would flow better here and you should return a proper error code.

> +	if (clk_id == ADAV80X_CLK_PLL1) {
> +		/* PLL1 clock rate is assumed to be 256 * Fs */
> +
> +		reg = snd_soc_read(codec, ADAV80X_DAC_CTRL2);
> +		if (sample_rate == 96000)
> +			/* Set the MCLK divider to be MCLK/2,
> +			   and MCLK = 128 * Fs */
> +			reg |= 0x24;
> +		else
> +			reg &= 0x11;
> +
> +		snd_soc_write(codec, ADAV80X_DAC_CTRL2, reg);
> +	}

What if the clock is not PLL1?

> +#ifdef CONFIG_PM
> +static int adav80x_soc_suspend(struct platform_device *pdev,
> +		pm_message_t state)
> +{
> +	return 0;
> +}
> +
> +static int adav80x_soc_resume(struct platform_device *pdev)
> +{
> +	return 0;
> +}

Remove empty functions.

> +	reg = snd_soc_read(codec, ADAV80X_DAC_CTRL1);
> +	reg = (mute > 0) ? reg & ~0x3 : reg | 0x3;
> +	snd_soc_write(codec, ADAV80X_DAC_CTRL1, reg);

The ternery operator isn't great for legibility.


> +	if (freq_in && freq_out) {
> +		/* XIN - assumes 27MHz */
> +		if (freq_in != 27000000)
> +			return -1;
> +
> +		if (pll_id != ADAV80X_CLK_PLL1)
> +			return -1;

Return proper error codes.

> +
> +		/* freq_out = sample_rate * 256 */
> +		switch (freq_out) {
> +		case 32000:
> +			reg = 0x8;
> +			break;
> +		case 44100:
> +			reg = 0xC;
> +			break;
> +		case 48000:
> +			reg = 0x0;
> +			break;
> +		case 64000:
> +			reg = 0x9;
> +			break;
> +		case 88200:
> +			reg = 0xD;
> +			break;
> +		case 96000:
> +			reg = 0x1;
> +			break;
> +		}

Looking at this the output frequencies you're handling are actually the sample rates rather than 256fs like the comment says. You also need to handle unknown frequencies here.

> +		if (adav80x->clk_src == ADAV80X_CLK_XIN)
> +			return 0;
> +		else
> +			adav80x->clk_src = ADAV80X_CLK_XIN;
> +
> +		/* Turn off PLL, power on XTAL */
> +		snd_soc_write(codec, ADAV80X_PLL_CTRL1, 0xC);
> +
> +		/* DAC, ADC, ICLK clock source - XIN */
> +		snd_soc_write(codec, ADAV80X_ICLK_CTRL1, 0x0);
> +		snd_soc_write(codec, ADAV80X_ICLK_CTRL2, 0x0);

Normally I'd expect to see the clock source switched over to XIN before rather than after the PLL is stopped to ensure a continuity in clocking.

> 
> +	/* Power down SYSCLK output, power down S/PDIF receiver */
> +	snd_soc_write(codec, ADAV80X_PLL_OUTE, 0x27);
> +
> +	/* Disable S/PDIF transmitter */
> +	snd_soc_write(codec, ADAV80X_TX_CTRL, 0x0);

DAPM should be able to take care of all this automatically.

> +	/* Datapath: ADC->record, AUX_IN->SRC->AUX_OUT */
> +	snd_soc_write(codec, ADAV80X_DPATH_CTRL1, 0xC4);

Remove this and pretty much all of the rest of this function - just leave the chip with the default settings and let the user configure whatever use case they want on their system. The values you set here may not be appropriate for other users.

> +#if (CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
> +/* ADAV80X I2C interface requires left-shifting reg addr for 1-bit */
> +#define ADAV80X_NUM_REGS (0x7E<<1)

This is all going to break if the user elects to build both I2C and SPI support into the same kernel and in any case even for a compile time selection having two totally different sets of register definitions is pretty inelegant.
