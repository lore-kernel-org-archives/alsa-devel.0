Return-Path: <SRS0=LwrQ=AT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFEFC433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 15:27:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 282A0206DF
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 15:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="piGNDt+n";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zHi3NQ6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 282A0206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 938BB15E0;
	Wed,  8 Jul 2020 17:26:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 938BB15E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594222029;
	bh=AoO3h6df3mw6HUtUYcqC63OEykfO8GoJTt5L+j7Elu4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=piGNDt+nPVI00DeIWiozWq/pDe6HrV+AC5VVTaJP9j7AywyBgDKRBMYI8pQcL0ywk
	 1L0br7jGKrZ6bpJSzkDbB8AP9EIl1qE9C1Ehhfuah2vjTjyeEFke2ut8Ba2O8c0Whh
	 SE8cdqQgbkoA5bdO6/CCG9SgtkwzErwb95Lajuvk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 387F9F80115;
	Wed,  8 Jul 2020 17:26:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 84DF0F8015A; Wed,  8 Jul 2020 17:26:17 +0200 (CEST)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1498AF8011F
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2020 17:26:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1498AF8011F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="zHi3NQ6B"
Received: by mail-wm1-x344.google.com with SMTP id 17so3663808wmo.1
 for <alsa-devel@alsa-project.org>; Wed, 08 Jul 2020 08:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Rs6MPvocUji5XwIYCOn+gelVQBocwRHLVhtpEwxkopg=;
 b=zHi3NQ6B1pEluj+8pRje9dKHgoKbTqzf12bvtSJLqPgPd1PZ5P/N/fsCC/EByu/GTd
 ++8Oc6NBX8a3f5/bPCKW7JM4YnUQKD8/hAJR2PJ1Uc9vHLTPnL9e/cFg89VZjBPxvMzA
 y4BkWh5zSPAoF+FoDDhsEVdd8b6S+E1jCbnRDpAHk4hdpNP3GXOj53AHr5r8yK89s+GP
 pye/KGXh35xCAojrNnVW13bWLMqwi7ezhX/xSyPxR0U/y3l+I2x14vaCYP+bBk8+3woy
 zXWpdvdAKra2z194nEkS5/3ll8CQYGCRGxHuQIglF0ZGeS3njAoh8uv9HwlKTkLxnZZH
 a63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Rs6MPvocUji5XwIYCOn+gelVQBocwRHLVhtpEwxkopg=;
 b=s1j/vN08/KlOxSaIHjum5u2XJG+ChW3c1iaI7M9GOIRkSy1kErYLmZk6stfPiqxHL6
 gu6fPXl/ZdYY+ZmLiGsKYTLmps46uuwzc81l56sa5O2x+yaUGpufREgSLCxWkMun5tOo
 M23w+kyQFGpPoBKofkxMH6AK9KfFNzWmpUYGcqvpXzFYJ0PORjNYfqYQ/N5OTh47MMRe
 dGeMS1KsOcuOAbQ29uqH1Rdjd/6KeyWy3dz4xN+eci1xg7tM5dnu/va/rjcMzGBUp/Ab
 AlOImT/rSzjrO713CBi1q+kUhJ44jDB0qlL9tqsI2G3N9Kqw4d9jxtLBf/rLDso6/sRJ
 5miw==
X-Gm-Message-State: AOAM533ygJYSaoF6NQGJ94/Z1dqJZqXhTjuOWiJUO4qI2EKIPi4LGxUv
 yiCxDgtb+M/LUQ4oo5bzMZzbYQ==
X-Google-Smtp-Source: ABdhPJzwmo/GYeZxAsTWJXB+WycKYqDbjAStLBPyn3jw2SSdLqcjmDlSfW2zCFpuBDE+OXnWOYizbw==
X-Received: by 2002:a1c:5a41:: with SMTP id o62mr9955647wmb.16.1594221974686; 
 Wed, 08 Jul 2020 08:26:14 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id y77sm154483wmd.36.2020.07.08.08.26.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jul 2020 08:26:13 -0700 (PDT)
Subject: Re: [PATCH 03/11] ASoC: q6asm: make commands specific to streams
To: Mark Brown <broonie@kernel.org>
References: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
 <20200707163641.17113-4-srinivas.kandagatla@linaro.org>
 <9ff595b4-1093-36c8-f27f-f097e24657a0@linux.intel.com>
 <4eedae20-903f-77c6-c6e9-fbf3db209bcf@linaro.org>
 <20200708131307.GO4655@sirena.org.uk>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <863fb181-9814-ee1e-c174-ca58ff6468f1@linaro.org>
Date: Wed, 8 Jul 2020 16:26:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200708131307.GO4655@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
 linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, vkoul@kernel.org
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



On 08/07/2020 14:13, Mark Brown wrote:
>> Plan is that the users of these apis will send flags directly instead of
>> boiler plating this!
>> This change should go as part of next patch("[PATCH 04/11] ASoC: q6asm: use
>> flags directly from asm-dai") which would make it much clear!
> It should be in here.
> 
> Please be also consistent in your use of ASM, especially given that asm
> is a widely used name in the kernel.

I agree, I will fix such usage in next patchset!

--srini
