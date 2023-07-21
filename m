Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE229C0015E
	for <alsa-devel@archiver.kernel.org>; Sat, 22 Jul 2023 17:06:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C351D203;
	Sat, 22 Jul 2023 19:06:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C351D203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690045613;
	bh=24uqrlKYheek8EjnXmWZMew5nkmTQ1jtUtTY8pVVoRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=heGSrraT0PO1caAyFRCn2NglKd33GhAukcYid9u2kJMu+pxppKa1TaRRuM+kPgeN6
	 wtDfUmaGc3CgLo1Cugr2UP7JN8+QAqpAxmH3TrdswdzpikYCyqNaOz9XyHbg092XvC
	 6E+u9Rsrlhf2lOaI/Pt6EGs7GbXCEsZrGUS1+NTA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D2C8BF8053B; Sat, 22 Jul 2023 19:05:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 09635F8007E;
	Sat, 22 Jul 2023 19:05:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1D168F8047D; Fri, 21 Jul 2023 15:19:24 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6398BF8007E
	for <alsa-devel@alsa-project.org>; Fri, 21 Jul 2023 15:19:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6398BF8007E
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="347313906"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200";
   d="scan'208";a="347313906"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2023 06:19:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="702053539"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200";
   d="scan'208";a="702053539"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 21 Jul 2023 06:18:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
	(envelope-from <andy@kernel.org>)
	id 1qMq1x-005vpD-13;
	Fri, 21 Jul 2023 16:18:49 +0300
Date: Fri, 21 Jul 2023 16:18:49 +0300
From: Andy Shevchenko <andy@kernel.org>
To: nikita.shubin@maquefel.me
Cc: Hartley Sweeten <hsweeten@visionengravers.com>,
	Lennert Buytenhek <kernel@wantstofly.org>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Lukasz Majewski <lukma@denx.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Sebastian Reichel <sre@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vinod Koul <vkoul@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
	soc@kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Michael Peters <mpeters@embeddedts.com>,
	Kris Bahnsen <kris@embeddedts.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
	netdev@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org,
	linux-input@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 01/42] gpio: ep93xx: split device in multiple
Message-ID: <ZLqFuWsxhdiP4ZjA@smile.fi.intel.com>
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
 <20230605-ep93xx-v3-1-3d63a5f1103e@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605-ep93xx-v3-1-3d63a5f1103e@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-MailFrom: andy@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: HDBA7NUVTATF24QX3LQA4RHPGZ6JTNGM
X-Message-ID-Hash: HDBA7NUVTATF24QX3LQA4RHPGZ6JTNGM
X-Mailman-Approved-At: Sat, 22 Jul 2023 17:03:49 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HDBA7NUVTATF24QX3LQA4RHPGZ6JTNGM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, Jul 20, 2023 at 02:29:01PM +0300, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> This prepares ep93xx SOC gpio to convert into device tree driver:
> - dropped banks and legacy defines
> - split AB IRQ and make it shared
> 
> We are relying on IRQ number information A, B ports have single shared
> IRQ, while F port have dedicated IRQ for each line.
> 
> Also we had to split single ep93xx platform_device into multiple, one
> for each port, without this we can't do a full working transition from
> legacy platform code into device tree capable. All GPIO_LOOKUP were
> change to match new chip namings.

...

> -static void ep93xx_gpio_ab_irq_handler(struct irq_desc *desc)
> +static u32 ep93xx_gpio_ab_irq_handler(struct gpio_chip *gc)
>  {
> -	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
> -	struct ep93xx_gpio *epg = gpiochip_get_data(gc);
> -	struct irq_chip *irqchip = irq_desc_get_chip(desc);
> +	struct ep93xx_gpio_irq_chip *eic = to_ep93xx_gpio_irq_chip(gc);
>  	unsigned long stat;
>  	int offset;
>  
> -	chained_irq_enter(irqchip, desc);
> -
> -	/*
> -	 * Dispatch the IRQs to the irqdomain of each A and B
> -	 * gpiochip irqdomains depending on what has fired.
> -	 * The tricky part is that the IRQ line is shared
> -	 * between bank A and B and each has their own gpiochip.
> -	 */
> -	stat = readb(epg->base + EP93XX_GPIO_A_INT_STATUS);
> +	stat = readb(eic->base + EP93XX_INT_STATUS_OFFSET);
>  	for_each_set_bit(offset, &stat, 8)
> -		generic_handle_domain_irq(epg->gc[0].gc.irq.domain,
> -					  offset);
> +		generic_handle_domain_irq(gc->irq.domain, offset);
>  
> -	stat = readb(epg->base + EP93XX_GPIO_B_INT_STATUS);
> -	for_each_set_bit(offset, &stat, 8)
> -		generic_handle_domain_irq(epg->gc[1].gc.irq.domain,
> -					  offset);
> +	return stat;
> +}
>  
> -	chained_irq_exit(irqchip, desc);
> +static irqreturn_t ep93xx_ab_irq_handler(int irq, void *dev_id)
> +{
> +	return IRQ_RETVAL(ep93xx_gpio_ab_irq_handler(dev_id));
>  }
>  
>  static void ep93xx_gpio_f_irq_handler(struct irq_desc *desc)
>  {
> -	/*
> -	 * map discontiguous hw irq range to continuous sw irq range:
> -	 *
> -	 *  IRQ_EP93XX_GPIO{0..7}MUX -> EP93XX_GPIO_LINE_F{0..7}
> -	 */
>  	struct irq_chip *irqchip = irq_desc_get_chip(desc);
> -	unsigned int irq = irq_desc_get_irq(desc);
> -	int port_f_idx = (irq & 7) ^ 4; /* {20..23,48..51} -> {0..7} */
> -	int gpio_irq = EP93XX_GPIO_F_IRQ_BASE + port_f_idx;
> +	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
> +	struct gpio_irq_chip *gic = &gc->irq;
> +	unsigned int parent = irq_desc_get_irq(desc);
> +	unsigned int i;
>  
>  	chained_irq_enter(irqchip, desc);
> -	generic_handle_irq(gpio_irq);
> +	for (i = 0; i < gic->num_parents; i++)
> +		if (gic->parents[i] == parent)
> +			break;
> +
> +	if (i < gic->num_parents)
> +		generic_handle_irq(irq_find_mapping(gc->irq.domain, i));

Can we use

		generic_handle_domain_irq(gc->irq.domain, i);

here as well?

>  	chained_irq_exit(irqchip, desc);
>  }

...

> -	int offset = d->irq & 7;
> +	int offset = irqd_to_hwirq(d);

	irq_hw_number_t ?

>  	irq_flow_handler_t handler;

...

> +	int ret, irq, i = 0;

What do you need this assignment for?

...

> +		ret = devm_request_irq(dev, irq,
> +				ep93xx_ab_irq_handler,

It can be located on the previous line.

> +				IRQF_SHARED, gc->label, gc);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "error requesting IRQ : %d\n", irq);

Drop duplicating word 'error' in the message.
Space is not needed before colon.

...

> +	/* TODO: replace with handle_bad_irq once we are fully hierarchical */

To be pedantic: handle_bad_irq()

> +	gc->label = dev_name(&pdev->dev);
> +	if (platform_irq_count(pdev) > 0) {
> +		dev_dbg(&pdev->dev, "setting up irqs for %s\n", dev_name(&pdev->dev));
> +		ret = ep93xx_setup_irqs(pdev, egc);
> +		if (ret)

> +			dev_err(&pdev->dev, "setup irqs failed for %s\n", dev_name(&pdev->dev));

What's the point to print dev name twice? Esp. taking into account
gc->label assignment above. Why not use dev_err_probe() to unify
the format of the messages from ->probe()?

-- 
With Best Regards,
Andy Shevchenko


