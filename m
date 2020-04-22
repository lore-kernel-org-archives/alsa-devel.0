Return-Path: <SRS0=We8V=6G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04B7C55189
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2020 11:11:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A4D720774
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2020 11:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="u/qcAjSp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A4D720774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B379F16C1;
	Wed, 22 Apr 2020 13:10:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B379F16C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587553900;
	bh=vf1zPSfoEcKlU8QIfQQeS4xKAG4LTMa9kAXXnHff1FI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u/qcAjSpooAv5VdCY17hAlq6GciZ5m9mL4SBaD3xnYKyuBGqy2ZsmNTbXJbUcaFj7
	 Nhl6feY7iB6SGY+nHaJKP16R3BnivTWmlOgJYGRiDzRlBJiFp59XxCqnc5Ly0z3x69
	 FixX3UBj3fyG5vX3aoab6qBYn4ygK/BYhS6bgylU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3DC6BF801D9;
	Wed, 22 Apr 2020 13:10:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B4F4CF8023F; Wed, 22 Apr 2020 13:09:55 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9293EF800FF
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2020 13:09:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9293EF800FF
IronPort-SDR: mpQf2pmftGTqbTWadrm8YolU+RvOeEo6013U2TKrt5zlHuvfJwNMWVUB92oI7epA2JC09HL4pc
 s814q6oQWZag==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2020 04:09:39 -0700
IronPort-SDR: zrx63v+4Ld9sS5yeRI5wicoe4XOKrd5S577ODD2pZGoLaTNDF/hU0/7MBEwNcSL1UmBQ4IwfPj
 a7MhtA4R0pHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,414,1580803200"; d="scan'208";a="457108286"
Received: from ajavier-mobl1.amr.corp.intel.com (HELO [10.255.68.153])
 ([10.255.68.153])
 by fmsmga006.fm.intel.com with ESMTP; 22 Apr 2020 04:09:37 -0700
Subject: Re: [RFC PATCH 12/16] clk: hifiberry-dacpro: add ACPI support
To: Stephen Boyd <sboyd@kernel.org>, alsa-devel@alsa-project.org
References: <20200409195841.18901-1-pierre-louis.bossart@linux.intel.com>
 <20200409195841.18901-13-pierre-louis.bossart@linux.intel.com>
 <158754793532.132238.9824423478783177623@swboyd.mtv.corp.google.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <60402718-f36c-cab3-2766-9ae180dd7504@linux.intel.com>
Date: Wed, 22 Apr 2020 04:54:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <158754793532.132238.9824423478783177623@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Matthias Reichl <hias@horus.com>, tiwai@suse.de,
 Linus Walleij <linus.walleij@linaro.org>,
 Daniel Matuschek <daniel@hifiberry.com>, linux-clk@vger.kernel.org,
 Hui Wang <hui.wang@canonical.com>, linux-gpio@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, broonie@kernel.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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



On 4/22/20 4:32 AM, Stephen Boyd wrote:
> Quoting Pierre-Louis Bossart (2020-04-09 12:58:37)
>> On ACPI platforms the of_ functions are irrelevant, conditionally
>> compile them out and add devm_clk_hw_register_clkdev() call instead.
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/clk/clk-hifiberry-dacpro.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/clk/clk-hifiberry-dacpro.c b/drivers/clk/clk-hifiberry-dacpro.c
>> index bf0616c959da..d01a90fed51b 100644
>> --- a/drivers/clk/clk-hifiberry-dacpro.c
>> +++ b/drivers/clk/clk-hifiberry-dacpro.c
>> @@ -114,15 +114,22 @@ static int clk_hifiberry_dacpro_probe(struct platform_device *pdev)
>>                  return ret;
>>          }
>>   
>> +#ifndef CONFIG_ACPI
> 
> Use if (!IS_ENABLED(CONFIG_ACPI)) instead?

git grep CONFIG_ACPI shows most of the kernel code uses #if(n)def 
CONFIG_ACPI. It's equivalent, it's a boolean.
