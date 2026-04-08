Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4638BE98FDD
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2026 09:59:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6FFA660212;
	Thu,  9 Apr 2026 11:58:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6FFA660212
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775728739;
	bh=V8rXhEyN76cQYM9BF6KVpbO+9KEPhf/L+9trOmefMsE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ie3vA9fICqQ0YND18+9a2Ko1NaFdRo38tlS3n196paYquc945Tu2xEyQqNXUh8xQB
	 MuqbxmBaN0TIvgr4W6+zynwCMtOmsXxw30KA1XY1FeyQtWgWydqlZn0Ea47Ih5cve6
	 8+4t2iJRLp7bE/u9/XtDse21ZjePfCYV9i7ynW90=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C9F7CF8067B; Thu,  9 Apr 2026 11:57:50 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 09279F8067B;
	Thu,  9 Apr 2026 11:57:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 59223F804CF; Wed,  8 Apr 2026 10:53:26 +0200 (CEST)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1E2A6F8024C
	for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2026 10:53:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1E2A6F8024C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=AEq3Yr8v
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-c76c60c7502so273327a12.0
        for <alsa-devel@alsa-project.org>;
 Wed, 08 Apr 2026 01:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775638402; x=1776243202;
 darn=alsa-project.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q0O2gUMwG94qjNO3Rau2fy1EWrjPL+RirtTuaeXZuXI=;
        b=AEq3Yr8v4j2fO7TY+8ZvA7uMLyo5DBNWwPtZo6/DsuTrZcQc8RvFpPIZpnWkfQUaBw
         x5DK3ENk83vFtoRsGGmIhcFNvTeixftoRktnN0BcyMqWerVJgzDgoFFBviax5EgbzlHp
         CCL06KlTOpcQdK/kQMeHbiliTyHC7q2ZGeSuLrz17PZTW1GzG4MgTW6WtGW67l8i0jmN
         p6gOYwovHq0X97tIXX64FB5Qz/TE+7su5Kigz3uJ2/itX5RDce6MWWdRO4SMSp0cyzYy
         gn2RUxHd7QKQ8NexA+o0NHXQmFYqoM37ZP9eRses3kPLKdezZRWKl8K+W4yN/fY5PFHe
         ja5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775638402; x=1776243202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q0O2gUMwG94qjNO3Rau2fy1EWrjPL+RirtTuaeXZuXI=;
        b=h273FB3sfv0DBJqB8N/fW+bZ72GoOGm0SCc6u4GWlzCo9nrVkNUkufLnHWjLu3mmlI
         CMv5jUEGcJ5Lar0MWJKw5dwDtyrFzeHGIwEodbr3gQ1cIXKmk1uNcK08Vtfw2AfVINlu
         NFXx1vW4gwUrTg+mpwgYh7mf+lEU5d+2qdSE4UwgEVPQWDfjU+0b5Bw006qrmt/8aGbS
         3v4SENSzIShfNzpCoOhnsSzokeJxjZp62A9R/OVdvb4DjToiisKn04JS2KWJ68AW3/F3
         16lR7GGNf/MCkS3TGUe9N/MjPsHJp39urCE53NRyYrEPFyPcW3LNtMeU+zysCwhFX14S
         qIxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEjjKgRaOkOvbpDemGddtCWUGTLGrUFLtV6KSgH4nbAexv+48rC8TUlqtnR4eTew46vndF3VmjD0zF@alsa-project.org
X-Gm-Message-State: AOJu0YzPXXHlzOeuoFFVvH9mw/7pjdaNr/kJ+efPR/c/I97jhDd5x5s/
	8CUxoF6qa9FQ3L7VuDUOlj8HEsL6AHpihIhDbe435CYX8kpVNZKV90dU
X-Gm-Gg: AeBDies8nAxi0LlzBdcg+IpppO7mfBuD3tU4IYx3+BEJjTbJcE3CIFNTyK9sTZZYpUM
	LSO0dTljMwA4wRalrD3o0IhiAPFDsiEWUjhliqbsy2Vo9j5kqClkYcB+HPrkVkKruKOvFV4kWO+
	cGcPZY4KA2Gc3bygQV3lGR9zNRaS/Jmakylgil1fpJ1+GqrHNNdL7Iiwq34vimqfr2DxOA3rdgV
	qd+6RrSZiI5low/kMr1x5QvKQ5nfI9PLG32Wa60peTSb7s1Mz4kcakHbNkk8T5PXf92nT7nVcO6
	v0d7FGO7CwO8sslhb+vq3/iT3zvN6t2C/ISg40a9yxEdrtHm46MzuGa2q1HqHZo1EcX74JUUy8g
	OIOwxui77M6hGtjAw+G//BEpk5Ggz/3Tj9bUfbayCmBN4TpUySUhRxvCGSxTDxl0fqXk451/P7V
	BhS/JvYvHgy3FYc7ol1Hx2GUsOpcGwSKpdAtbqwF2J2TCRShWoAg77EM/UaUMd
X-Received: by 2002:a05:6a20:12cb:b0:39c:212c:9088 with SMTP id
 adf61e73a8af0-39f170ded85mr3378151637.20.1775638401563;
        Wed, 08 Apr 2026 01:53:21 -0700 (PDT)
Received: from [172.20.10.2] (42-77-205-177.emome-ip.hinet.net.
 [42.77.205.177])
        by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c65995a9sm17556167a12.27.2026.04.08.01.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 01:53:20 -0700 (PDT)
Message-ID: <1d0863b2-64f4-9f2f-94a3-3d730e9638f2@gmail.com>
Date: Wed, 8 Apr 2026 16:51:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] ASoC: nau8325: Add software reset during probe
Content-Language: en-US
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Neo Chang <YLCHANG2@nuvoton.com>
Cc: perex@perex.cz, tiwai@suse.com, krzysztof.kozlowski@oss.qualcomm.com,
 dan.carpenter@linaro.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, kchsu0@nuvoton.com, broonie@kernel.org,
 lgirdwood@gmail.com, linux-sound@vger.kernel.org
References: <20260408052639.187149-1-YLCHANG2@nuvoton.com>
 <08462a39-61e2-4125-957e-9454751b011e@intel.com>
From: YLCHANG2 <neo.chang70@gmail.com>
In-Reply-To: <08462a39-61e2-4125-957e-9454751b011e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: neo.chang70@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 4WYNYBJL22LND4XLGDJVR6HKAOMYYD46
X-Message-ID-Hash: 4WYNYBJL22LND4XLGDJVR6HKAOMYYD46
X-Mailman-Approved-At: Thu, 09 Apr 2026 09:57:40 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4WYNYBJL22LND4XLGDJVR6HKAOMYYD46/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On 4/8/26 16:07, Cezary Rojewski wrote:
> On 2026-04-08 7:26 AM, Neo Chang wrote:
>> Currently, the driver only performs a hardware reset during the I2C 
>> probe
>> sequence. To ensure all internal states of the codec are properly 
>> cleared
>> without affecting the configuration registers, a software reset is also
>> required.
>>
>> According to the hardware specification, writing to the Software Reset
>> register (R01) twice will reset all internal states safely.
>>
>> This patch adds the nau8325_software_reset() function, executes it right
>> after the hardware reset in the probe function, and marks the R01 
>> register
>> as writeable in the regmap configuration.
>
> The first two paragraphs explain the situation, I'd say the third is 
> redundant. Not a reason for a resend though, only something to consider.
>
> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>

Thank you for the review and the advice on the commit message.

I will keep it in mind for the next time.

