Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF03CC43334
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jun 2022 19:53:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 058B01AD1;
	Fri, 10 Jun 2022 21:53:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 058B01AD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654890835;
	bh=F2fRn3a3rhDagwezWwy4538nMwRfGCub9eEIYPlJaUg=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JthOGU80+Z04wBML3SpAnhzEZLYcjf0OsuGIa5/6PzMok8q78UuK8hRKYyBPKVsA0
	 /PuMIOfhpWAb3jwp72kBk9/We2fSTAGGBjRCNRZKCQj16WvsDgU+cJX1FGGBs+3Hqk
	 FgMOo3x22mvm865c4ftXeELpQJMKjnGKUgtP/jlU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7E21CF804CF;
	Fri, 10 Jun 2022 21:53:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B568EF800DF; Fri, 10 Jun 2022 21:53:02 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2CE07F800DF
 for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2022 21:52:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2CE07F800DF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="VFre5QqF"
Received: by mail-wm1-x329.google.com with SMTP id
 r187-20020a1c44c4000000b0039c76434147so1625779wma.1
 for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2022 12:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=/0seJj7vutXMisqi25YbC/BlVcmbiGDjG4jipxqxReo=;
 b=VFre5QqFlIlGENzelDzmUJOiheZWLY1JoEfaXQVUp03TC5OyhQ0ntZuxLQEbTNb1nI
 fZ77oE2MANgxD9i4a+OG/UMCw/nXPHHqaMOFIoC4TykgPW4PhLMOi5wWTtpljPBdjnpR
 KXH7emFO02shqEjX2tYrQfNFiFlRCpPjXdioNwa/7QFfw2YdLuLjJEjyHKcYdy5bQPaY
 Q74EgOC28ix3FxjkDeA/ZJFMW/F2ftQiTpB+up5jC65umBvutgiviDcZfXlWCHwd1wbp
 Wu42XjbBl1rdm1jHloojb5ZtGu8ZXX0go2pD5gbMSQ5o2jHwKwraEy919Hq7I979v9E5
 DoNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=/0seJj7vutXMisqi25YbC/BlVcmbiGDjG4jipxqxReo=;
 b=GWQcrUEaB2Rt7akzi9Ff6+muCFc3W9LXR8pOzZalC7LZrdgedREgBORPm9pPlaK3RW
 Apq85c9McHG/bmrc8a7CqDG0UgoIRMbe46GIRCobTOrMT0f3wXHvbIbR7BMbTg+YS3n/
 KKBq8gpI3ogQPsxYf5vV96ghBhjZ30/0cpdjjVwd1Cnr5VvC3bUX5PMgn5UCdRnQ60p5
 U1K6o0uhMEFanrxzFus+dPe42lotYgiVtSwokVedwDKQjfhoOXgZaD+cs5f/cdBpn/7d
 /TVNkkYPho+cmG/PvXgGVsWcDMzp1ZcopXY8XQuwXpn4KaWDGHnfy6mO5yXMbeBQXxPb
 QL/Q==
X-Gm-Message-State: AOAM530b9ekLzMmar0bgOqdAfUY2/shBmww4WQi1BfUhgSb5CiGF1dah
 kEOwAr6UhXavKxa0n9gjd+dN7A==
X-Google-Smtp-Source: ABdhPJwlVgYEJ4hq/w7bJ1jcGdQfLjStMZWUjC+0iWkoeA/KWncZxa3J5xGCX5dZ/sQBCQE9dWBZGQ==
X-Received: by 2002:a05:600c:3516:b0:39c:8091:31b6 with SMTP id
 h22-20020a05600c351600b0039c809131b6mr1308386wmq.164.1654890778440; 
 Fri, 10 Jun 2022 12:52:58 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-176-92.adslplus.ch.
 [188.155.176.92]) by smtp.gmail.com with ESMTPSA id
 f2-20020adfb602000000b002185c6dc5b1sm273167wre.108.2022.06.10.12.52.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jun 2022 12:52:57 -0700 (PDT)
Message-ID: <bb4ab218-3461-9afb-ecba-5c9e87f6acfc@linaro.org>
Date: Fri, 10 Jun 2022 21:52:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ASoC: samsung: i2s: Check before clk_unregister() not
 needed
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Yihao Han <hanyihao@vivo.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20220527065412.3677-1-hanyihao@vivo.com>
 <2bcf706b-10d5-9369-ff8a-2a3263f9fa70@linaro.org>
 <d53ad0e2-e32d-1b46-b626-e82b44230704@wanadoo.fr>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d53ad0e2-e32d-1b46-b626-e82b44230704@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 10/06/2022 18:15, Christophe JAILLET wrote:
> Le 29/05/2022 à 10:06, Krzysztof Kozlowski a écrit :
>> On 27/05/2022 08:54, Yihao Han wrote:
>>> clk_unregister() already checks the clk ptr using
>>> !clk || WARN_ON_ONCE(IS_ERR(clk)) so there is no need to check it
>>> again before calling it.
>>>
>>
>> No, this explanation does not make sense. clk_unregister() warns and
>> this code is not equivalent.
>>
>>
>>
>> Best regards,
>> Krzysztof
>>
> 
> Hi,
> 
> Moreover, as pointed out by greg in [1] on some plateform the assertion 
> in the commit description is wrong. His message is about clk_disable() 
> but, IIUC, it makes sense for clk_unregister() as well. See [2] on the 
> sh plateform.
> 

Yes, this is true as well, although does not have the practical impact
on this driver as it uses platforms with common clock framework.


Best regards,
Krzysztof
