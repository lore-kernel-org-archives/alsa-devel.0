Return-Path: <SRS0=We8V=6G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01E3C55189
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2020 11:55:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5013A2077D
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2020 11:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ip2J8aip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5013A2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9EB45169E;
	Wed, 22 Apr 2020 13:54:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9EB45169E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587556518;
	bh=IQ1l7CLlu40p/Vs6vI8dvQjETuZgN3rdkRhPNeh8uzA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ip2J8aipk8zTM3xnGQUYO5aMEMUSKBl18yGF2ycYRlrllXw0c/h1d7InYW3fGMCYQ
	 jYRyWGkhnBfaAGmzjikJmqycDNZUF6VelBXV/hPGxzjVDOAMg4OyRvHfyNZCICFBtB
	 80EtpJrN9Xz0m3qklFgpOWGYDqS0KEE1m1zL5144=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3303BF80108;
	Wed, 22 Apr 2020 13:54:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F352BF80142; Wed, 22 Apr 2020 13:54:25 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 096A5F800FF
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2020 13:54:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 096A5F800FF
IronPort-SDR: eG5DU3Q6MMbX9H3tA235lF2H8u+22PhL5FTfI6q7lXnBkx1FVeVcA25HM/aI4CrFgx8KZwmWRb
 1kuYXzADSxuA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2020 04:54:18 -0700
IronPort-SDR: O9CjOCHYmPwWZIqf6i+YiDP/7wq2CxiygWwU1a6RtXS81F0b1Jyas3sJgTJCR5gv1Gf/eIs2Gw
 Dw3hScIsZsvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,414,1580803200"; d="scan'208";a="273860164"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga002.jf.intel.com with ESMTP; 22 Apr 2020 04:54:14 -0700
Received: from andy by smile with local (Exim 4.93)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1jRDxJ-002RAE-6g; Wed, 22 Apr 2020 14:54:17 +0300
Date: Wed, 22 Apr 2020 14:54:17 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 13/16] clk: hifiberry-dacpro: add "sclk" lookup
Message-ID: <20200422115417.GG185537@smile.fi.intel.com>
References: <20200409195841.18901-1-pierre-louis.bossart@linux.intel.com>
 <20200409195841.18901-14-pierre-louis.bossart@linux.intel.com>
 <158754810745.132238.7647643247125302962@swboyd.mtv.corp.google.com>
 <c52e0f7d-1eaf-a89b-ff5d-b2a02ad56021@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c52e0f7d-1eaf-a89b-ff5d-b2a02ad56021@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>,
 Matthias Reichl <hias@horus.com>, Stephen Boyd <sboyd@kernel.org>,
 linux-gpio@vger.kernel.org, Daniel Matuschek <daniel@hifiberry.com>,
 linux-clk@vger.kernel.org, Hui Wang <hui.wang@canonical.com>, tiwai@suse.de,
 broonie@kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Linus Walleij <linus.walleij@linaro.org>
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

On Wed, Apr 22, 2020 at 04:51:52AM -0500, Pierre-Louis Bossart wrote:
> > > +       proclk->sclk_lookup = clkdev_hw_create(&proclk->hw, "sclk", NULL);
> > > +       if (!proclk->sclk_lookup) {
> > > +#ifndef CONFIG_ACPI
> > 
> > Is it to save code space? Otherwise the ifdefs are pretty ugly and I'd
> > prefer we just call of_clk APIs and rely on the inline stubs when
> > CONFIG_OF isn't enabled to be optimized out.
> 
> CONFIG_OF was added as a dependency (see patch 10/16) so that we can use the
> 'compatible' string to probe w/ the PRP0001 device.

PRP0001 does not require CONFIG_OF to be set.

> I must admit I don't know what these functions do so I just filtered them
> out in the ACPI case.

I think you have to check if one is a superposition of the other.

> > > +               of_clk_del_provider(dev->of_node);
> > > +#endif
> > > +               return -ENOMEM;
> > > +       }

-- 
With Best Regards,
Andy Shevchenko


