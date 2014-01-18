From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v3 09/16] ALSA: Oxygen: Modify
 initialization functions
Date: Sat, 18 Jan 2014 11:50:52 +0100
Message-ID: <52DA5C8C.9050400@ladisch.de>
References: <1389971315-3215-1-git-send-email-v1ron@mail.ru>
 <1389971315-3215-9-git-send-email-v1ron@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 144C12619E4
 for <alsa-devel@alsa-project.org>; Sat, 18 Jan 2014 11:51:05 +0100 (CET)
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 43C9A20F0D
 for <alsa-devel@alsa-project.org>; Sat, 18 Jan 2014 05:51:04 -0500 (EST)
In-Reply-To: <1389971315-3215-9-git-send-email-v1ron@mail.ru>
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
> Changes in GPIO values and sequence at startup, CS4245
> initialization changed and simplified, according to
> datasheets and reverse-engineering information.
>
>  static void cs4245_init(struct oxygen *chip)
>  {
>  	struct dg *data = chip->model_data;
>
> -	data->cs4245_regs[CS4245_DAC_CTRL_1] =
> -		CS4245_DAC_FM_SINGLE | CS4245_DAC_DIF_LJUST;
> -	data->cs4245_regs[CS4245_ADC_CTRL] =
> -		CS4245_ADC_FM_SINGLE | CS4245_ADC_DIF_LJUST;
> -	data->cs4245_regs[CS4245_SIGNAL_SEL] =
> -		CS4245_A_OUT_SEL_HIZ | CS4245_ASYNCH;
> -	data->cs4245_regs[CS4245_PGA_B_CTRL] = 0;
> -	data->cs4245_regs[CS4245_PGA_A_CTRL] = 0;
> -	data->cs4245_regs[CS4245_ANALOG_IN] =
> -		CS4245_PGA_SOFT | CS4245_PGA_ZERO | CS4245_SEL_INPUT_4;
> -	data->cs4245_regs[CS4245_DAC_A_CTRL] = 0;
> -	data->cs4245_regs[CS4245_DAC_B_CTRL] = 0;
> -	cs4245_registers_init(chip);
> +	/* Save the initial state: codec version, registers */
> +	cs4245_shadow_control(chip, CS4245_SAVE_TO_SHADOW);
> +
> +	data->cs4245_shadow[CS4245_POWER_CTRL] = 0;
> +	data->cs4245_shadow[CS4245_SIGNAL_SEL] = CS4245_A_OUT_SEL_DAC |
> +		CS4245_ASYNCH;
> +	data->cs4245_shadow[CS4245_DAC_CTRL_1] = 0;
> +	data->cs4245_shadow[CS4245_DAC_CTRL_2] = CS4245_DAC_SOFT |
> +		CS4245_DAC_ZERO | CS4245_INVERT_DAC;
> +	data->cs4245_shadow[CS4245_ADC_CTRL] = 0;
> +	data->cs4245_shadow[CS4245_ANALOG_IN] = CS4245_PGA_SOFT |
> +		CS4245_PGA_ZERO;

Please don't remove symbols like "CS4245_DAC_FM_SINGLE | CS4245_DAC_DIF_LJUST";
this would imply that you don't care about these settings.

Why don't you initialize registers like PGA/DAC_A/B?

> +void dg_init(struct oxygen *chip)
>  {
> -	data->output_sel = 0;
> -	data->input_sel = 3;
> -	data->hp_vol_att = 2 * 16;

These initializations should not be removed until all the other code
that uses them is also removed.

> -	oxygen_clear_bits16(chip, OXYGEN_GPIO_DATA,
> -			    GPIO_INPUT_ROUTE | GPIO_HP_REAR);
> +	oxygen_write16(chip, OXYGEN_GPIO_DATA, GPIO_HP_REAR | GPIO_INPUT_ROUTE);

Why are these bits now initialized to the opposite value?


Regards,
Clemens
