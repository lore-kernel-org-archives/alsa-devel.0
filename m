Return-Path: <SRS0=riqU=57=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFD3C2BA19
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 09:50:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCC4C20784
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Apr 2020 09:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mFRPZeED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCC4C20784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0E7C182A;
	Wed, 15 Apr 2020 11:49:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0E7C182A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586944210;
	bh=fCrHR8Wy9AQWsRMRTcRPPQTphq3VbbGg/mUmwg5sEEQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mFRPZeEDIARrNc58Z1VhSPfBQvWPqh5PrBA/wpRVrUqo7xqjvuxJ6kUvFSeKcnACk
	 xiZo2tJIEeJP7P+ZnOUhyVE2Lje66nmLJHowyu0G2ojNlhKxA5sGdJLTNrLEzFEnwl
	 RFBniGSw4YwK175TqvBbBroGQQL+ShpKdWWNpsQo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 99993F80229;
	Wed, 15 Apr 2020 11:49:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 87357F80245; Wed, 15 Apr 2020 11:49:17 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79B46F800ED
 for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2020 11:49:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 79B46F800ED
IronPort-SDR: Sviu487PmwbS/G7VAPiAx8YuI6qhUTvUzJUGWXGXnN700rben9r8RZ72dSAftP6oXn7u52UDpc
 4xF2PQ/2zXYg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2020 02:49:09 -0700
IronPort-SDR: jcQ5vxXjAjoXIVhKj5SRTEUrBbrXcc8h9EFEM7+dPbqDFMhP1PNKmxF9aNNg1C7wmz3L8Jcw3r
 eI8t7yfcq44A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; d="scan'208";a="245651676"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by fmsmga008.fm.intel.com with ESMTP; 15 Apr 2020 02:49:06 -0700
Received: from andy by smile with local (Exim 4.93)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1jOefM-000k9K-J0; Wed, 15 Apr 2020 12:49:08 +0300
Date: Wed, 15 Apr 2020 12:49:08 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 01/16] ASoC: pcm512x: expose 6 GPIOs
Message-ID: <20200415094908.GM34613@smile.fi.intel.com>
References: <20200409195841.18901-1-pierre-louis.bossart@linux.intel.com>
 <20200409195841.18901-2-pierre-louis.bossart@linux.intel.com>
 <20200414170934.GA34613@smile.fi.intel.com>
 <31e956de-8f62-1857-5153-b163ff7d56e1@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31e956de-8f62-1857-5153-b163ff7d56e1@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: alsa-devel@alsa-project.org, Matthias Reichl <hias@horus.com>,
 tiwai@suse.de, Linus Walleij <linus.walleij@linaro.org>,
 Stephen Boyd <sboyd@kernel.org>, Daniel Matuschek <daniel@hifiberry.com>,
 linux-clk@vger.kernel.org, Hui Wang <hui.wang@canonical.com>,
 linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 broonie@kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>
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

On Tue, Apr 14, 2020 at 12:52:07PM -0500, Pierre-Louis Bossart wrote:

...

> > > +static int pcm512x_gpio_direction_output(struct gpio_chip *chip,
> > > +					 unsigned int offset,
> > > +					 int value)
> > > +{
> > > +	struct pcm512x_priv *pcm512x = gpiochip_get_data(chip);
> > > +	unsigned int reg;
> > > +	int ret;
> > > +
> > > +	/* select Register GPIOx output for OUTPUT_x (1..6) */
> > > +	reg = PCM512x_GPIO_OUTPUT_1 + offset;
> > 
> > > +	ret = regmap_update_bits(pcm512x->regmap, reg, 0x0f, 0x02);
> > 
> > Magic numbers detected.
> > 
> > > +	if (ret < 0)
> > 
> > Drop unnecessary ' < 0' parts where it makes sense, like here.
> 
> did you mean use  if (ret) or drop the test altogether?

Do you see 'ret' part in my phrase above?

> There's no standard style for regmap functions so I used what was used in
> the rest of this driver.

I see. May be than to drop it from the rest and do not add more?

> > > +		return ret;

...

> > > +	return (val >> offset) & 1;
> > 
> > Don't forget to use BIT() macro.
> > 
> > 	return !!(val & BIT(offset));
> 
> There's a point where this becomes less readable IMHO, but fine.
> The !! gives me a headache...

You can check assembly if it gives better result in code generation.
But at least new drivers in GPIO are using it.

...

> > > +		pr_debug("%s: regmap_update_bits failed: %d\n", __func__, ret);
> > 
> > No __func__ in debug messages.
> > Use dev_dbg() when we have struct device available.
> 
> Not sure we do, will look into this.

I didn't get you in the first part. Are you talking about struct device?
It's there, just needs to be de-referenced from GPIO chip.

-- 
With Best Regards,
Andy Shevchenko


