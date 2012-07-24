From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] ALSA: ASoC: add DT bindings for cs4270
Date: Tue, 24 Jul 2012 15:39:21 -0500
Message-ID: <500F07F9.8000408@freescale.com>
References: <1343161248-27557-1-git-send-email-zonque@gmail.com>
 <500F0407.8090807@freescale.com> <500F050D.6080505@gmail.com>
 <500F05CC.2000105@freescale.com> <500F0666.3030707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 by alsa0.perex.cz (Postfix) with ESMTP id AFE422652C8
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2012 22:39:32 +0200 (CEST)
In-Reply-To: <500F0666.3030707@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> Yes, I'm aware of this, I just wonder how does your DT note looks like?

Take a look at arch/powerpc/boot/dts/mpc8610_hpcd.dts

> And are you ok with the 2nd patch?

Isn't that something that should be done in platform code?  It seems very
platform-specific for a codec driver.  I have no problem using the CS4270
on my board, and I don't need this feature.

> +	/* See if we way to bring the codec out of reset */
> +	if (np) {
> +		enum of_gpio_flags reset_gpio_flags;

Blank line after variable declarations

> +		int reset_gpio = of_get_named_gpio_flags(np, "reset-gpio", 0,
> +							 &reset_gpio_flags);

Can you make this line shorter by using shorter variable names or something?

> +		if (devm_gpio_request_one(&i2c_client->dev, reset_gpio,
> +				     reset_gpio_flags & OF_GPIO_ACTIVE_LOW ?
> +					GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH,
> +				     "cs4270 reset") < 0) {
> +			reset_gpio = -EINVAL;
> +		}

I don't see where you test whether the reset-gpio property is present.  It
won't be present in my device tree.

> +	}
> +

-- 
Timur Tabi
Linux kernel developer at Freescale
