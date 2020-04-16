Return-Path: <SRS0=OoyA=6A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04E1C2BB55
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Apr 2020 16:52:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33EBF2222D
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Apr 2020 16:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WsgkUUao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33EBF2222D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 720C615E4;
	Thu, 16 Apr 2020 18:51:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 720C615E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587055949;
	bh=kBp32Fy4rhflMsBnqndyf8RvRac1ntz6I3fcKAN3CXo=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WsgkUUaoc+TY/U9L+0ORDkfaYY3Q9U0BxDcFL63betiePXrQGKvOY0bKpzZRLeLO4
	 289azrRh8NkIMkqnat24t0KiXuz5SKYaSjl8+rbTtqj9ZF1PH0VSXJYw5UYtDAa7w7
	 MclLgQAmSbFJ8xEYqCgC0ccATbySqRNKmDOGb/mQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B68ADF800AB;
	Thu, 16 Apr 2020 18:51:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E23F8F8014E; Thu, 16 Apr 2020 18:51:36 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 07F16F800AB
 for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2020 18:51:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07F16F800AB
IronPort-SDR: e0R+K5WEnw4kbW8UoV8JET1U88n2mmdwvaq8GgZ0IbBRpw7ql3fdmuV7llzPxknXies5mlxAjK
 8RDESu98xWSQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2020 09:51:25 -0700
IronPort-SDR: BFJewqmLyHxlwPPIzbmpaDcWq2/78eGWBs6jbDpOcKLssIPLdS5UDrylMxYYckHIXKF9clIUA+
 2JGaJL3drs4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,391,1580803200"; d="scan'208";a="278060214"
Received: from ernestom-mobl.amr.corp.intel.com (HELO [10.251.128.102])
 ([10.251.128.102])
 by fmsmga004.fm.intel.com with ESMTP; 16 Apr 2020 09:51:23 -0700
Subject: Re: [RFC PATCH 01/16] ASoC: pcm512x: expose 6 GPIOs
To: Linus Walleij <linus.walleij@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michael Walle <michael@walle.cc>
References: <20200409195841.18901-1-pierre-louis.bossart@linux.intel.com>
 <20200409195841.18901-2-pierre-louis.bossart@linux.intel.com>
 <20200414170934.GA34613@smile.fi.intel.com>
 <CACRpkdZRnSUhmVPKjJ6dWnSfhnvrAKUrBY6tWLkxPgT28CzbHw@mail.gmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <2cd8d540-8bd0-4a42-4d11-7dea0fb03c22@linux.intel.com>
Date: Thu, 16 Apr 2020 09:25:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdZRnSUhmVPKjJ6dWnSfhnvrAKUrBY6tWLkxPgT28CzbHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, Rob Herring <robh+dt@kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.de>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Daniel Matuschek <daniel@hifiberry.com>,
 Hui Wang <hui.wang@canonical.com>, Matthias Reichl <hias@horus.com>,
 Mark Brown <broonie@kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-clk <linux-clk@vger.kernel.org>
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



On 4/16/20 6:42 AM, Linus Walleij wrote:
> On Tue, Apr 14, 2020 at 7:09 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>> On Thu, Apr 09, 2020 at 02:58:26PM -0500, Pierre-Louis Bossart wrote:
>>> The GPIOs are used e.g. on HifiBerry DAC+ HATs to control the LED
>>> (GPIO3) and the choice of the 44.1 (GPIO6) or 48 (GPIO3) kHz
>>> oscillator (when present).
>>>
>>> Enable basic gpio_chip to get/set values and get/set
>>> directions. Tested with GPIO_LIB from sys/class/gpio, the LED turns
>>> on/off as desired.
>>
>>
>> One question, can this use existing GPIO infrastructure, like bgpio_init()?
>> Ah, I see, that one operates over MMIO, while we would need something based on
>> regmap API.
>>
>> Bartosz, do we have plans to have bgpio_regmap_init() or alike?
> 
> Michael Walle is working on that:
> https://lore.kernel.org/linux-gpio/20200402203656.27047-11-michael@walle.cc/
> 
> I think we should try to merge it sooner rather than later.
> I can provide an ib-* branch for ASoC whenever we agreed
> on a basic generic driver.

Thanks for the pointer, I will give it a try.
