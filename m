From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 2/2] snd-oxygen: Fixes for the Xonar DG card
Date: Tue, 19 Nov 2013 23:23:54 +0100
Message-ID: <528BE4FA.4060402@ladisch.de>
References: <20131119183112.4079e9e9@v1ron-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 25D0B261A3C
 for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2013 23:24:36 +0100 (CET)
In-Reply-To: <20131119183112.4079e9e9@v1ron-desktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Roman Volkov <v1ron@mail.ru>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Roman Volkov wrote:
> Fixes for the Xonar DG model of the Oxygen driver:

Each of the following sentences describes a separate logical change.

> +++ linux-3.12-my/sound/pci/oxygen/xonar_dg.c	2013-11-19 01:01:07.000000000 +0400

> + * DGX card: not tested.
> + * Suspend/resume: not tested

This does not belong in the source code; if some tests succeeds, we do
not want to update the driver.

> + * SPDIF: not tested

SPDIF is handled completely by the CMI8788 itself.

> + * 128kHz doesn't work for CS4361 (multichannel playback)

Why do you expect 128 kHz to work?

> + * CS4245 Auxiliary Output is connected to the front panel headphones jack
> + * through amplifier.

The comment below already says this.

> - *   GPIO 3 <- ?
> + *   GPIO 3 <- unused (?)

Why this change?

> - *   GPIO 5 -> route input jack to line-in (0) or mic-in (1)
> - *   GPIO 6 -> route input jack to line-in (0) or mic-in (1)
> + *   GPIO 5 -> ADC analog circuit power supply control for left channel (?)
> + *   GPIO 6 -> ADC analog circuit power supply control for right channel (?)

The Xonar cards often use mechanical relays for these routing things;
you should be able to hear them when switching.

> - *   GPIO 7 -> enable rear headphone amp
> + *   GPIO 7 -> switches green rear output jack between CS4245 / CS4361 first
> + * channel

0 or 1?

> - *   GPIO 8 -> enable output to speakers
> + *   GPIO 8 -> DAC analog circuit power supply control (?)

This relay is intended to prevent popping when powering on.

> +static int cs4245_dump_regs(struct oxygen *chip, bool bRead)

Why "dump" for writing?  This should be two functions.

> +	for (address = 0; address <= 0x10; address++) {
> +		return bRead ? cs4245_read_spi(chip, address) :
> +			cs4245_write_spi(chip, address);
> +	}

Why return from the loop?

> +static void dg_init(struct oxygen *chip)

> +	 * Recommended sequence from the datasheet: reset the codec and then
> +	 * initialize it.

> +	oxygen_write8_masked(chip, OXYGEN_FUNCTION, 0,
> +		OXYGEN_FUNCTION_RESET_CODEC);

This is what the _set/clear_bits functions are for.

Is the reset pin actually connected?  Does the Windows driver do this?

> +	mdelay(1);

Use mdelay() only when sleeping is not possible; use msleep() instead.

> +	msleep_interruptible(1000);

When you use _interruptible, you should also check for the interrupt.

>  static void set_cs4245_dac_params(struct oxygen *chip,
>  				  struct snd_pcm_hw_params *params)

> +	unsigned char tmp;
> +	unsigned char tmp2;

These variable names are not very descriptive.

> +	case PLAYBACK_DST_20_CH:
> +	case PLAYBACK_DST_40_CH:
> +	case PLAYBACK_DST_51_CH:

Why is it necessary to differentiate between those?  There should be no
mixer control; the driver can automatically detect what format is used.
And this should not make any difference because the unused channels will
be silent anyway.

> +/* Put the codec into low power mode, disable audio output, save registers */

Does the Windows driver implement this?

> +static void dg_suspend(struct oxygen *chip)
>  {
>  	struct dg *data = chip->model_data;
> +	data->cs4245_shadow[CS4245_POWER_CTRL] = CS4245_PDN_MIC |
> +		CS4245_PDN_ADC | CS4245_PDN_DAC | CS4245_PDN;
> +	cs4245_write_spi(chip, CS4245_POWER_CTRL);
> +	cs4245_dump_regs(chip, true);

Why reading the registers?  The cs4245_shadow values should already be
valid.

> -	.function_flags = OXYGEN_FUNCTION_SPI,
> +	.function_flags = OXYGEN_FUNCTION_SPI | OXYGEN_FUNCTION_ENABLE_SPI_4_5,

Why?

> +++ linux-3.12-my/sound/pci/oxygen/xonar_dg.h	2013-11-19 01:06:12.000000000 +0400

This file was intended as the interface between xonar_dg.c and the
generic oxygen.c driver.

That you have to add so much stuff indicates that xonar_dg.c and
xonar_dg_mixer.c are not very independent and maybe should have stayed
a single file.

> +	/* Independend capture volumes */
> +	char mic_vol_l;
> +	char mic_vol_r;
> +	bool mic_m;
> +	char line_vol_l;
> +	char line_vol_r;
> +	bool line_m;
> +	char aux_vol_l;
> +	char aux_vol_r;
> +	bool aux_m;

The old driver had a separate volume for front mic.

> + * It is not good that we do not have software volume control
> + * as the Windows driver does. CS4361 cannot attenuate the volume.
> + * When we are switching from headphones to the speakers,
> + * which are controlled by the simple DAC CS4361, our headphones
> + * in the rear jack can stun us.

This is why I did not implement a volume control in the first place.

> +static int xonar_dg_pcm_route_apply(struct oxygen *chip)

> +		oxygen_write8_masked(chip, OXYGEN_GPIO_DATA, 0x00, 0x80);

Use _set_bits and the GPIO_ symbol.

> +static int xonar_dg_pga_volume_get(struct snd_kcontrol *ctl,
> +				struct snd_ctl_elem_value *val)
> +	switch (ctl->private_value) {
> +	case CAPTURE_SRC_MIC:
> +	case CAPTURE_SRC_LINE:
> +	case CAPTURE_SRC_AUX:

And FP_MIC?  (Also elsewhere.)


Regards,
Clemens
