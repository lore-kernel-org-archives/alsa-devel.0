From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/2] snd-oxygen: Changes for oxygen driver
 to fix the Xonar DG card
Date: Tue, 19 Nov 2013 23:23:41 +0100
Message-ID: <528BE4ED.4050105@ladisch.de>
References: <20131119182617.0bbae792@v1ron-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 2768A2608D8
 for <alsa-devel@alsa-project.org>; Tue, 19 Nov 2013 23:24:27 +0100 (CET)
In-Reply-To: <20131119182617.0bbae792@v1ron-desktop>
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

Many thanks for doing all this work!

However, there are still a few small problems.

Roman Volkov wrote:
> This patch does some preparation of existing Oxygen driver.

This patch should be separated into four logical changes.

> +++ linux-3.12-my/sound/pci/oxygen/cs4245.h	2013-11-15 15:46:40.000000000 +0400
> -#define CS4245_SPI_ADDRESS	(0x9e << 16)
> -#define CS4245_SPI_WRITE	(0 << 16)
> +#define CS4245_SPI_ADDRESS	0x9e
> +#define CS4245_SPI_WRITE	0
> +#define CS4245_SPI_READ		1

This is only part of a logical change; applying this patch alone would
break the driver.

> +++ linux-3.12-my/sound/pci/oxygen/oxygen_io.c	2013-11-19 00:56:12.000000000 +0400
> -	wait_event_timeout(chip->ac97_waitqueue,
> -			   ({ status |= oxygen_read8(chip, OXYGEN_AC97_INTERRUPT_STATUS);
> +	wait_event_timeout(chip->ac97_waitqueue, ({ status |= oxygen_read8(chip,
> +					OXYGEN_AC97_INTERRUPT_STATUS);
>  			      status & mask; }),

Why this change?

> +int oxygen_wait_spi(struct oxygen *chip)
>  ...
> -		udelay(4);
> +		udelay(1);

Please don't reduce this delay; the CMI8788 has a bug that can crash the
machine if this register is polled too often.

> +EXPORT_SYMBOL(oxygen_wait_spi);

Why this export?

> +++ linux-3.12-my/sound/pci/oxygen/oxygen_mixer.c	2013-11-18 14:03:54.000000000 +0400

> +EXPORT_SYMBOL(oxygen_update_dac_routing);

This should be integrated into the patch that adds the actual call.


Regards,
Clemens
