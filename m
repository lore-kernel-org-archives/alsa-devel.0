Return-Path: <SRS0=riqU=57=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6111C2BA19
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 09:52:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65C2D20775
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 09:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YHGGfJmT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C2D20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 454CA1616;
	Wed, 15 Apr 2020 11:51:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 454CA1616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586944357;
	bh=5Ett8a4ZRbK8Do9njrPh5yeUjHTPt87XDWU7V41ndK8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YHGGfJmTsN/qsurZKxLFflwWqCeN05KA85BiXst3QQSYpmv6P2XOzX1tBzPozh7NE
	 I8DfcCW1krmJKQAJK5sR8tbKkx1fT4CTkYi9JQAm4cRIf0tpYZTyJnAcC1knWDTj5i
	 BL/Rv2bKaW45/JZNZPx94kEwhjjVOE4DhUpH/d4M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EF0D8F80229;
	Wed, 15 Apr 2020 11:51:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 89811F80115; Wed, 15 Apr 2020 11:51:44 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 30EF5F80115
 for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2020 11:51:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 30EF5F80115
IronPort-SDR: 1okoMbi0Uqw79ygyNL3tkTxiEbWKio4KWEnsStLV1D9sNC+RKGHfYlKDNfFZkXVWWfThBGaqvT
 Am+b29VsNStg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2020 02:51:38 -0700
IronPort-SDR: UnN5cCxPNTxvHGxBYKHw55LozRjz4wqIOdvsn5Q5o6Ua8P40BR8xduL2AKeOtoTkp+MxZbc4GK
 uqtL5ElcoFYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; d="scan'208";a="454856974"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by fmsmga006.fm.intel.com with ESMTP; 15 Apr 2020 02:51:35 -0700
Received: from andy by smile with local (Exim 4.93)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1jOehl-000kBB-BD; Wed, 15 Apr 2020 12:51:37 +0300
Date: Wed, 15 Apr 2020 12:51:37 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 03/16] ASoC: Intel: sof-pcm512x: use gpiod for LED
Message-ID: <20200415095137.GN34613@smile.fi.intel.com>
References: <20200409195841.18901-1-pierre-louis.bossart@linux.intel.com>
 <20200409195841.18901-4-pierre-louis.bossart@linux.intel.com>
 <20200414171752.GC34613@smile.fi.intel.com>
 <92636c24-32d5-3ec6-23db-e7f9e22f66dc@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92636c24-32d5-3ec6-23db-e7f9e22f66dc@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>,
 linux-gpio@vger.kernel.org, tiwai@suse.de,
 Linus Walleij <linus.walleij@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 Daniel Matuschek <daniel@hifiberry.com>, Hui Wang <hui.wang@canonical.com>,
 Matthias Reichl <hias@horus.com>, broonie@kernel.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Tue, Apr 14, 2020 at 12:57:35PM -0500, Pierre-Louis Bossart wrote:

...

> > > +		GPIO_LOOKUP("pcm512x-gpio", 3, "PCM512x-GPIO4", GPIO_ACTIVE_HIGH),
> > 
> > It says GPIO 4 and here is number 3.
> > Does this 4 come from hardware documentation?
> 
> Yes TI count from 1 to 6 in their documentation. The initial HifiBerry DAC+
> also counts from 1 to 6. I can add a comment here.

Okay!

...

> > > +	ctx->gpio_4 = devm_gpiod_get(&pdev->dev, "PCM512x-GPIO4",
> > > +				     GPIOD_OUT_LOW);
> > 
> > Can driver work without this GPIO? If so, perhaps devm_gpiod_get_optional().
> 
> that part yes, it's only for the LED, but if this fails then probably the
> rest of the code will also fail.

The problem with above code that it's setting the hard dependency to a LED
gpio. Is it crucial to get codec working? I bet no. In case
gpiod_get_optional() fails, it will be correct to bail out, because it will
mean other kind of errors not related to optionality of the GPIO (rather it's
present, but something went wrong).

> > > +	if (IS_ERR(ctx->gpio_4)) {
> > > +		dev_err(&pdev->dev, "gpio4 not found\n");
> > > +		ret = PTR_ERR(ctx->gpio_4);
> > > +		return ret;
> > > +	}

-- 
With Best Regards,
Andy Shevchenko


