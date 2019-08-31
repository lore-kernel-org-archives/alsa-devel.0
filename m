Return-Path: <SRS0=OpZL=W3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6556BC3A59F
	for <alsa-devel@archiver.kernel.org>; Sat, 31 Aug 2019 11:19:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62AF622D37
	for <alsa-devel@archiver.kernel.org>; Sat, 31 Aug 2019 11:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BmmU9Wgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62AF622D37
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=katsuster.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E3601857;
	Sat, 31 Aug 2019 13:18:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E3601857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567250390;
	bh=Bp/ZuxbTUi/2ODZLy6GY3S1jaOtTKjIcmhGl9eltCHw=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BmmU9WgzqWK7L52kzzHojR8kiuXgAAIMGjnNbXHfsLYjxbZnWvKqXOkdCWkcPQo5y
	 T5oMh3wp79QJBDhOONs1kYiGDDNo80udBsHor2NmmEUG58kWf4OGQKZhQ3VC4vYYo1
	 LOVH4zpy8UIB5AyYsJnEIzOJEe4ekRebhU4hdmnA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E77EF80229;
	Sat, 31 Aug 2019 13:18:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 185E5F80268; Sat, 31 Aug 2019 13:18:58 +0200 (CEST)
Received: from www1102.sakura.ne.jp (www1102.sakura.ne.jp [219.94.129.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D45D7F800D1
 for <alsa-devel@alsa-project.org>; Sat, 31 Aug 2019 13:18:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D45D7F800D1
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x7VBIhZf087789;
 Sat, 31 Aug 2019 20:18:43 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp);
 Sat, 31 Aug 2019 20:18:43 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp)
Received: from [192.168.1.2] (118.153.231.153.ap.dti.ne.jp [153.231.153.118])
 (authenticated bits=0)
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x7VBIgAG087782
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
 Sat, 31 Aug 2019 20:18:43 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
To: Mark Brown <broonie@kernel.org>
References: <20190829173205.11805-1-katsuhiro@katsuster.net>
 <20190829173205.11805-2-katsuhiro@katsuster.net>
 <20190830111817.GA5182@sirena.co.uk>
From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <ee38ca00-4146-49fe-21c0-af0578b1d65c@katsuster.net>
Date: Sat, 31 Aug 2019 20:18:42 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830111817.GA5182@sirena.co.uk>
Content-Language: en-US
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, David Yang <yangxiaohua@everest-semi.com>,
 Daniel Drake <drake@endlessm.com>
Subject: Re: [alsa-devel] [PATCH 2/3] ASoC: es8316: Add clock control of MCLK
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Message-ID: <20190831111842.6J65miM3Z_ClSF0-bzaFKOhm9V9RsYwxhneU-hf1BWo@z>

Hello Mark,

On 2019/08/30 20:18, Mark Brown wrote:
> On Fri, Aug 30, 2019 at 02:32:04AM +0900, Katsuhiro Suzuki wrote:
> 
>> +	es8316->mclk = devm_clk_get(component->dev, "mclk");
>> +	if (PTR_ERR(es8316->mclk) == -EPROBE_DEFER)
>> +		return -EPROBE_DEFER;
> 
> If we don't get a clock it'd be nice to at least log that in case
> there's something wrong with the clock driver so that people have more
> of a hint as to why things might be breaking.
> 

OK, to change more user friendly.


>> +
>> +	if (es8316->mclk) {
>> +		ret = clk_prepare_enable(es8316->mclk);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
> 
> There's nothing that disables the clock on remove.
> 
> Otherwise this looks good.
> 
Thank you for reviewing. I'll fix it and send V2 patch set.


> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 

Best Regards,
Katsuhiro Suzuki
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
