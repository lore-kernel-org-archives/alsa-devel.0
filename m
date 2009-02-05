From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: Re: [PATCH 3/3] Add ALSA driver for Atmel AC97
	controller
Date: Thu, 5 Feb 2009 08:14:29 +0100
Message-ID: <20090205081429.4e5988be@hcegtvedt>
References: <1233748114-6353-1-git-send-email-hans-christian.egtvedt@atmel.com>
	<1233748114-6353-2-git-send-email-hans-christian.egtvedt@atmel.com>
	<1233748114-6353-3-git-send-email-hans-christian.egtvedt@atmel.com>
	<1233748114-6353-4-git-send-email-hans-christian.egtvedt@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (relay.atmel.no [80.232.32.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D82610391F
	for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2009 08:14:31 +0100 (CET)
In-Reply-To: <1233748114-6353-4-git-send-email-hans-christian.egtvedt@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed,  4 Feb 2009 12:48:34 +0100
Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com> wrote:

> This patch adds ALSA support for the AC97 controller found on Atmel
> AVR32 devices.
> 
> Tested on ATSTK1006 + ATSTK1000 with a development board with a AC97
> codec.
> 

<snipp most of patch>

> +static int __devinit atmel_ac97c_pcm_new(struct atmel_ac97c *chip)
> +{
> +	struct snd_pcm *pcm;
> +	int capture = test_bit(DMA_RX_CHAN_PRESENT, &chip->flags);
> +	int playback = test_bit(DMA_TX_CHAN_PRESENT, &chip->flags);
> +	int err;
> +
> +	err = snd_ac97_pcm_assign(chip->ac97_bus,
> +			ARRAY_SIZE(atmel_ac97_pcm_defs),
> +			atmel_ac97_pcm_defs);

Is this call really needed? snd_ac97_pcm_assign() seems to have few
users in ALSA. I do not really get what this does, it is just something
that's always been in the driver.

<snipp>

-- 
Best regards,
Hans-Christian Egtvedt
