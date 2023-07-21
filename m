Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94A3C0015E
	for <alsa-devel@archiver.kernel.org>; Sat, 22 Jul 2023 17:11:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2EA9CE76;
	Sat, 22 Jul 2023 19:10:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2EA9CE76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690045876;
	bh=xJJqgsylIILQ+ilyC5S+KgsBXDwuXZTOL3Q9zzIwEh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qDQLpdX4QppC8Xh7uQs3lN9G51NoPxjZfBc1vRL4qCQV3+LxMCT277jJdn3wsJYB+
	 42fLTh6LRYwimRdGHbtleArX8jpiSIRBpRuloCupW68Kue4/zDlsZKPxza+lNBxVeF
	 iZZwkATUOx50TFyvqZXdfa3WnifleBJukc0p4kIY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 83B64F8063A; Sat, 22 Jul 2023 19:06:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 85739F80633;
	Sat, 22 Jul 2023 19:06:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 79A61F8047D; Fri, 21 Jul 2023 18:21:26 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 62FB8F8007E
	for <alsa-devel@alsa-project.org>; Fri, 21 Jul 2023 18:21:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 62FB8F8007E
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="453435616"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200";
   d="scan'208";a="453435616"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2023 09:21:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="848870377"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200";
   d="scan'208";a="848870377"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 21 Jul 2023 09:21:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
	(envelope-from <andy@kernel.org>)
	id 1qMssF-00CCBV-0a;
	Fri, 21 Jul 2023 19:20:59 +0300
Date: Fri, 21 Jul 2023 19:20:58 +0300
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
Subject: Re: [PATCH v3 22/42] dma: cirrus: add DT support for Cirrus EP93xx
Message-ID: <ZLqwajir6kFLgbcm@smile.fi.intel.com>
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
 <20230605-ep93xx-v3-22-3d63a5f1103e@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605-ep93xx-v3-22-3d63a5f1103e@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-MailFrom: andy@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 74N6VJRL62XQX3AS4PHWAXTMYI2WQ4X2
X-Message-ID-Hash: 74N6VJRL62XQX3AS4PHWAXTMYI2WQ4X2
X-Mailman-Approved-At: Sat, 22 Jul 2023 17:04:42 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/74N6VJRL62XQX3AS4PHWAXTMYI2WQ4X2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, Jul 20, 2023 at 02:29:22PM +0300, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> - drop subsys_initcall code
> - add OF ID match table with data
> - add of_probe for device tree

...

> +#include <linux/of_device.h>

Why?

...

> +#ifdef CONFIG_OF

Why this ugly ifdeffery?

...

> +	data = of_device_get_match_data(&pdev->dev);

device_get_match_data()

> +	if (!data)
> +		return ERR_PTR(dev_err_probe(&pdev->dev, -ENODEV, "No device match found\n"));

...

> +	edma = devm_kzalloc(&pdev->dev,
> +					  struct_size(edma, channels, data->num_channels),
> +				      GFP_KERNEL);

Something wrong with indentation. Not the first time, please check all your
patches for this kind of issues.

> +		return ERR_PTR(-ENOMEM);

...

> +		edmac->regs = devm_platform_ioremap_resource(pdev, i);

No check?

> +		edmac->irq = platform_get_irq(pdev, i);

No check?

> +		edmac->edma = edma;
> +
> +		edmac->clk = of_clk_get(np, i);

> +

Redundant blank line.

Why one of devm_clk_get*() can't be called?

> +		if (IS_ERR(edmac->clk)) {
> +			dev_warn(&pdev->dev, "failed to get clock\n");
> +			continue;
> +		}

...

> +	if (platform_get_device_id(pdev))
> +		edma = ep93xx_init_from_pdata(pdev);
> +	else
> +		edma = ep93xx_dma_of_probe(pdev);

> +

Unneeded blank line.

> +	if (!edma)
> +		return PTR_ERR(edma);

...

> --- a/include/linux/platform_data/dma-ep93xx.h
> +++ b/include/linux/platform_data/dma-ep93xx.h

>  #include <linux/types.h>
>  #include <linux/dmaengine.h>
>  #include <linux/dma-mapping.h>

> +#include <linux/of.h>

property.h.

...

> +	if (of_device_is_compatible(dev_of_node(chan->device->dev), "cirrus,ep9301-dma-m2p"))
> +		return true;
> +

device_is_compatible()

-- 
With Best Regards,
Andy Shevchenko


