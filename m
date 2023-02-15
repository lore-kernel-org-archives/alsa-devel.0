Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516F7C636CC
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Feb 2023 19:21:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 403BF886;
	Wed, 15 Feb 2023 20:20:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 403BF886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1676488876;
	bh=j+7GGiF4OQmmWeeBajHkaO7pnaF3gDIBjmRD8vplX0o=;
	h=Date:Subject:To:References:From:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=cS+XInidM9Q1klTjOSFdu6NTuGkqKRwtFErsU1B7DldetR8bW6huceVUuabM2xlnf
	 FmUy8p2O+8h0gL+we67BA2u+s+5xsEjCko5t7Acf5ctCbyVx1TBU2FLTSlbdUNoOoP
	 YEZ/YMOtJFbI2ZR/nlGdPNsXozkGt151+y/jyZ7w=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1B8EFF80526;
	Wed, 15 Feb 2023 20:19:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A63D2F80526; Wed, 15 Feb 2023 20:19:50 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A9D17F80496
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2023 20:19:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A9D17F80496
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=fBnHeZPL
Received: by mail-wr1-x42b.google.com with SMTP id o15so16918290wrc.9
        for <alsa-devel@alsa-project.org>;
 Wed, 15 Feb 2023 11:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zVy/c+cEbMIt9TIoyvZusWRPHpRTQuTATF5cUQLqC4s=;
        b=fBnHeZPLzrGTJ+GWgxhoUQ9ZzA3Lc7rxkwystan7qPiLYpBrQCaL3fRgz6836TNTHz
         0iRj/kV9eAPZdwryApHfytig73xF31qAFfLDTc9kubaZor1EIr0Z4ie4gQz+lUrlq9C8
         AbzlsY2hrUPX/PGGF9aXLRqydd36ogYo8YFWgcqwHh9CH5w+DORJybeyaXgCoKbLChWy
         F27AGqX52xFaCy7uGk1ApL/r+Wq2TvTPkoGUqzLTpq5KcGP9D8E0rdPGmMBUSYI1XYIU
         Zdy/18FoRvtaQwRvwIhC7xEJ77Dz4Y2eLbj3Q2uT101HaqUzNKO3k9nWcsBtikrlkHf8
         pVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zVy/c+cEbMIt9TIoyvZusWRPHpRTQuTATF5cUQLqC4s=;
        b=MW0SqmHiks1U7oqMJ0sc/ynK/9qrpAepZ01b9O5PB1s0Njj5BHIx9/ZWVSDSuKrTn7
         SvoX8bGRnpMzONq5uNKeFr0GzHfuJM0UzvYAKWjXbHukHxmEJQbhH9j/e+SsjHo78dQ8
         snnS49NFHOnb3BAbTT0wEuPquNmamy8sMWC/8o60//ug7F7bzlVh189rwPQP8/bC0Lzy
         PX9pZ1jbH0yvj4hSpDCkS8TD0Hk/00VM8/QCNODJyiczrLH3z//RZhahBCDJHEleD1fI
         /PzGeayT8TuzprUucRF15OPN0q1XUQl/U1Xiwqx31E2Djopnc0/WAhs4dK6mP8jMBnU0
         sLLQ==
X-Gm-Message-State: AO0yUKWlFVfvPIsTI6O+g4HVovVe8ZD6YBOSn5D1k1t+OxlzrgdFY0fo
	HFXGA+DGqGXmqbgJkwEj/U5Zbg==
X-Google-Smtp-Source: 
 AK7set/9DsbtaIrsocf96fJaGpubiBoTK5aOjMvOd3HgsZ49/Uzn8dJY8QA23em2CaUqweOCX9YRDw==
X-Received: by 2002:a05:6000:1152:b0:2c5:52f5:c63b with SMTP id
 d18-20020a056000115200b002c552f5c63bmr2756520wrx.11.1676488784705;
        Wed, 15 Feb 2023 11:19:44 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id
 t15-20020a5d534f000000b002c55306f6edsm10284549wrv.54.2023.02.15.11.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 11:19:44 -0800 (PST)
Message-ID: <2334035b-cc52-8dfb-9ba4-544081b98d6f@linaro.org>
Date: Wed, 15 Feb 2023 20:19:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] dt-bindings: sound: ep93xx: Add I2S and AC'97
 descriptions
Content-Language: en-US
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
 devicetree@vger.kernel.org
References: <20230212232137.299005-1-alexander.sverdlin@gmail.com>
 <46d5b6af-23e1-4178-83bc-b4a435b1426e@linaro.org>
 <109868b9492aecaca0a7170cba9fb51e62de7116.camel@gmail.com>
 <c4f5f733-ce22-2dfa-30f7-cde309eadaf9@linaro.org>
 <ba51ecefb814115e977d90062ca5fe99859cb327.camel@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ba51ecefb814115e977d90062ca5fe99859cb327.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 3DYNDUD4PACOHGO2F2SXSMDKP5CESDZD
X-Message-ID-Hash: 3DYNDUD4PACOHGO2F2SXSMDKP5CESDZD
X-MailFrom: krzysztof.kozlowski@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Hartley Sweeten <hsweeten@visionengravers.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3DYNDUD4PACOHGO2F2SXSMDKP5CESDZD/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 14/02/2023 15:26, Alexander Sverdlin wrote:
> Hello Krzysztof!
> 
> On Tue, 2023-02-14 at 15:11 +0100, Krzysztof Kozlowski wrote:
>>>>> +  interrupts:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  clocks:
>>>>> +    minItems: 3
>>>>
>>>> maxItems instead
>>>
>>> reg and clocks are required, I suppose I should include both minItems
>>> and maxItems for both of them?
>>
>> No. minItems is implied.
> 
> I see. But I think minItems "3" should be included for clocks, right?

No, why? It is implied when you provide maxItems. Therefore why would
you need it to make it explicitly (although you can, but we avoid it for
smaller code)?

Best regards,
Krzysztof

