From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] Allow passing platform_data to
	devices	attached to AC97 bus
Date: Tue, 21 Jul 2009 23:33:34 +0100
Message-ID: <20090721223334.GE7547@n2100.arm.linux.org.uk>
References: <200907211633.14388.marek.vasut@gmail.com>
	<s5hvdllvjk8.wl%tiwai@suse.de>
	<200907212353.37737.marek.vasut@gmail.com>
	<200907220013.12824.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 32E6110387E
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jul 2009 00:33:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200907220013.12824.marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, cbou@mail.ru, dwmw2@infradead.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 22, 2009 at 12:13:12AM +0200, Marek Vasut wrote:
> +		ret = set_irq_type(gpio_to_irq(pdata->charge_gpio),
> +				IRQ_TYPE_EDGE_BOTH);
> +		if (ret)
> +			goto err2;
> +		ret = request_irq(gpio_to_irq(pdata->charge_gpio),
> +				wm97xx_chrg_irq, IRQF_DISABLED,
> +				"AC Detect", 0);

This should be done as one call to request_irq().

Why?

If the IRQ is already in use by something else, calling set_irq_type()
will stamp on that other user, enforcing the change of configuration.
request_irq() will then fail, leaving the IRQ configuration buggered.

Combining the two allows request_irq() to fail if the IRQ line is busy.
If it isn't busy, it will configure the IRQ line prior to enabling the
IRQ.  If the IRQ is shared and sharing is permitted, it will fail if
the configuration is not compatible with the existing IRQ configuration.

set_irq_type() should only be used very sparingly and when there's no
other option.
