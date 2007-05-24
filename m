From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [RFC] [PATCH 1/2] ASoC sound support for
	SMDK2440	boards: UDA1341 driver
Date: Thu, 24 May 2007 18:15:55 +0100
Message-ID: <1180026955.28539.54.camel@a10072.wolfsonmicro.main>
References: <5b7270f40705240736h7f47e0a0p16ac2b36ae07a5d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 5DBD324431
	for <alsa-devel@alsa-project.org>;
	Thu, 24 May 2007 19:15:57 +0200 (CEST)
In-Reply-To: <5b7270f40705240736h7f47e0a0p16ac2b36ae07a5d0@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Zoltan Devai <zdevai@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Zoltan,

Many thanks for this. Looks good, with some minor style changes required
for ALSA.

On Thu, 2007-05-24 at 16:36 +0200, Zoltan Devai wrote:
> ASoC Support for the UDA1341 codec.
> Please note that until there is a final L3-bus driver, this patch won't work.
> 
> ---

> +static inline void uda1341_reset(struct snd_soc_codec *codec)
> +{
> +	u8 reset_reg = uda1341_read_reg_cache(codec, UDA1341_STATUS0);
> +	uda1341_write(codec, UDA1341_STATUS0, reset_reg | (1<<6));
> +}

IMHO, there should be a space between the shift and it's operands.
Interestingly, the kernel coding style doc doesn't mention shifts in any
of it's spacing rules.

> +
> +	/* Anything between 256fs*8Khz and 512fs*48Khz should be acceptable
> +	we'll error out on set_hw_params if it's not OK */
> +	if ( (freq >= (256 * 8000)) && (freq <= (512 * 48000)) ) {
> +		uda1341->sysclk = freq;
> +		return 0;
> +	}
> +

There probably shouldn't be a space between any parenthesis openings and
closures in the if statement.

> +
> +	codec->private_data = uda1341;
> +
> +        codec->reg_cache = kmemdup(uda1341_reg, sizeof(uda1341_reg), \
> +								GFP_KERNEL);

Indentation is off here.

Cheers

Liam
