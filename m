From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] Allow passing platform_data to devices
 attached to AC97 bus
Date: Wed, 22 Jul 2009 02:34:24 +0400
Message-ID: <20090721223424.GA21147@oksana.dev.rtsoft.ru>
References: <200907211633.14388.marek.vasut@gmail.com>
	<s5hvdllvjk8.wl%tiwai@suse.de>
	<200907212353.37737.marek.vasut@gmail.com>
	<200907220013.12824.marek.vasut@gmail.com>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by alsa0.perex.cz (Postfix) with ESMTP id 99298103881
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jul 2009 00:34:26 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, cbou@mail.ru, Eric Miao <eric.y.miao@gmail.com>, dwmw2@infradead.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 22, 2009 at 12:13:12AM +0200, Marek Vasut wrote:
> Btw. I also reworked the wm97xx-battery a little more. Also, CCing power-
> supply people.

> From 0c04c7f9cac26de8b4e401c17e65051c7f44ec3e Mon Sep 17 00:00:00 2001
> From: Marek Vasut <marek.vasut@gmail.com>
> Date: Tue, 21 Jul 2009 18:52:28 +0200
> Subject: [PATCH 3/4] Convert WM97xx driver to use platform_data
> 
> This patch converts the wm97xx driver to use platform_data supplied by
> ac97 bus. Also, this fixes the related wm97xx-battery driver to use
> it's platform_data and prepares a structure for touchscreen driver.
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> ---

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

> +		ret = set_irq_type(gpio_to_irq(pdata->charge_gpio),
> +				IRQ_TYPE_EDGE_BOTH);
> +		if (ret)
> +			goto err2;

I always thought that request_irq() would set trigger type
as necessary if you pass IRQF_TRIGGER_* flags, so there is
no need for explicit set_irq_type() call?

This code in kernel/irq/manage.c:__setup_irq():

                /* Setup the type (level, edge polarity) if configured: */
                if (new->flags & IRQF_TRIGGER_MASK) {
                        ret = __irq_set_trigger(desc, irq,
                                        new->flags & IRQF_TRIGGER_MASK);


> +		ret = request_irq(gpio_to_irq(pdata->charge_gpio),
> +				wm97xx_chrg_irq, IRQF_DISABLED,
> +				"AC Detect", 0);
> +		if (ret)
> +			goto err3;

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
