Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BAC8C46CA1
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Sep 2023 16:00:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 86B0DA4B;
	Mon, 18 Sep 2023 17:59:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 86B0DA4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695052821;
	bh=P2Wi6yZVEElIZa+S6uqGb8GsdyiF6u3MY9GZpLmEvYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Fc7BcCTB4HecAcmIl3GhVyOfv6rLmPeh7B+gJt8Wb/BEw3sHC/D5M9Be29oxHQ9rU
	 07Cfw5Bbw3GLJ+utLpga+AjqXj+dA28nha+4s8wtd6AxLnBKVWJhK678bffXy9H03j
	 6wwi9KzLdS5PT7xtKMOaz9BEQws7dokl0WY0Dspw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 08503F805AF; Mon, 18 Sep 2023 17:57:59 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4A8C9F805AD;
	Mon, 18 Sep 2023 17:57:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0A7C3F801F5; Mon, 18 Sep 2023 09:39:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 52EE4F800AA
	for <alsa-devel@alsa-project.org>; Mon, 18 Sep 2023 09:39:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 52EE4F800AA
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="382333097"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000";
   d="scan'208";a="382333097"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2023 00:39:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="811259953"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000";
   d="scan'208";a="811259953"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2023 00:39:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
	(envelope-from <andy@kernel.org>)
	id 1qi8qk-0000000EvwK-3qGW;
	Mon, 18 Sep 2023 10:39:18 +0300
Date: Mon, 18 Sep 2023 10:39:18 +0300
From: Andy Shevchenko <andy@kernel.org>
To: nikita.shubin@maquefel.me
Cc: Hartley Sweeten <hsweeten@visionengravers.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Lukasz Majewski <lukma@denx.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
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
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
	netdev@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org,
	linux-input@vger.kernel.org, alsa-devel@alsa-project.org,
	Arnd Bergmann <arnd@arndb.de>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v4 00/42] ep93xx device tree conversion
Message-ID: <ZQf+pps0Ffsak+BA@smile.fi.intel.com>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-MailFrom: andy@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: CZ3JNCP6PMV5RHCZQJPDLH3MGQQJUOLY
X-Message-ID-Hash: CZ3JNCP6PMV5RHCZQJPDLH3MGQQJUOLY
X-Mailman-Approved-At: Mon, 18 Sep 2023 15:57:48 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CZ3JNCP6PMV5RHCZQJPDLH3MGQQJUOLY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, Sep 15, 2023 at 11:10:42AM +0300, Nikita Shubin via B4 Relay wrote:
> This series aims to convert ep93xx from platform to full device tree support.
> 
> The main goal is to receive ACK's to take it via Arnd's arm-soc branch.
> 
> Major changes:
> - drop newline at the end from each YAML files
> - rename dma and clk bindings headers to match first compatible
> - shrink SoC exported functions number to only 2
> - dropped some ep93xx_pata fixes from these series
> - dropped m48t86 stuff from these series
> 
> Bit thanks to Andy Shevchenko for thorough review.

You are welcome!

Dunno if you have used --patience when formatted the patches, but I think
you should, if hadn't, for the next version. It will help a lot in reviewing
and understanding the changes.

-- 
With Best Regards,
Andy Shevchenko


