Return-Path: <SRS0=tzaW=56=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A83C2BA19
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 18:19:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 099642076A
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 18:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BsF62s95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 099642076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6102416BD;
	Tue, 14 Apr 2020 20:18:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6102416BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586888361;
	bh=Isoszig2rBkd0qzBJNkNiAgWGkvwQIYDHsr2xfKcQq8=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BsF62s95OnEpIM/G0D9fZNr5iJR/aBiDb82vXWO/kFQvvccbYGU0pqfWkkr6fdkuF
	 2PUpaXYx1NrnVEtuo43RN8HoszU8hti4ASIgy86qwUIfo71S7UuWl1Edq3Dx0W7+6K
	 kWWdEwWRVwNggNKh+2Cn0jPqq2pGpqnoN8ZLFai4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B436BF80291;
	Tue, 14 Apr 2020 20:16:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1B6C6F8028D; Tue, 14 Apr 2020 20:16:54 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3B7CAF8027C
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2020 20:16:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3B7CAF8027C
IronPort-SDR: F0Wur6D5YBVHhgHstv3NeDtZQf5p45T1nedbt5xa63NrH/AqO0ACPDZUD57JpQx2KzFU9ZgMnv
 7qkpfgEKy+bg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2020 11:16:49 -0700
IronPort-SDR: /zzOMGLyZlN9FAnCZYZ6we8qJCwRUlhg2Zfn/adASU2GUBV2fVkkGPRd4QbB+J+bkdZJKOGUjR
 vs07wIwlJtGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,383,1580803200"; d="scan'208";a="253272874"
Received: from svarahab-mobl.amr.corp.intel.com (HELO [10.212.190.40])
 ([10.212.190.40])
 by orsmga003.jf.intel.com with ESMTP; 14 Apr 2020 11:16:46 -0700
Subject: Re: [RFC PATCH 03/16] ASoC: Intel: sof-pcm512x: use gpiod for LED
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20200409195841.18901-1-pierre-louis.bossart@linux.intel.com>
 <20200409195841.18901-4-pierre-louis.bossart@linux.intel.com>
 <20200414171752.GC34613@smile.fi.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <92636c24-32d5-3ec6-23db-e7f9e22f66dc@linux.intel.com>
Date: Tue, 14 Apr 2020 12:57:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200414171752.GC34613@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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


>> +static struct gpiod_lookup_table pcm512x_gpios_table = {
>> +	/* .dev_id set during probe */
>> +	.table = {
> 
>> +		GPIO_LOOKUP("pcm512x-gpio", 3, "PCM512x-GPIO4", GPIO_ACTIVE_HIGH),
> 
> It says GPIO 4 and here is number 3.
> Does this 4 come from hardware documentation?

Yes TI count from 1 to 6 in their documentation. The initial HifiBerry 
DAC+ also counts from 1 to 6. I can add a comment here.

> 
>> +		{ },
> 
> No comma for terminator entries.

ok

> 
>> +	},
>> +};
> 
> ...
> 
>> +	gpiod_add_lookup_table(&pcm512x_gpios_table);
> 
> Where is the counterpart gpiod_remove_lookup_table() call?

Ah that's a miss, thanks for flagging this. I remember looking but 
obviously needed a coffee at the time.

>> +	ctx->gpio_4 = devm_gpiod_get(&pdev->dev, "PCM512x-GPIO4",
>> +				     GPIOD_OUT_LOW);
> 
> Can driver work without this GPIO? If so, perhaps devm_gpiod_get_optional().

that part yes, it's only for the LED, but if this fails then probably 
the rest of the code will also fail.
> 
>> +	if (IS_ERR(ctx->gpio_4)) {
>> +		dev_err(&pdev->dev, "gpio4 not found\n");
>> +		ret = PTR_ERR(ctx->gpio_4);
>> +		return ret;
>> +	}
> 
