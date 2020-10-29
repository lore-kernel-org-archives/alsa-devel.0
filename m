Return-Path: <SRS0=XEtc=EE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECACAC2D0A3
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:41:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9FE52076B
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GxXPEmdV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uqz6RcxO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9FE52076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CFF5E1688;
	Thu, 29 Oct 2020 10:40:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CFF5E1688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603964464;
	bh=udlAY1PrLzD61qPjhI0fPWss9D9aiHKsAEWCCjRDpMQ=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GxXPEmdVraWeO31ypPYI7otnp6YczXrwYNGvo9VwC1lG5u3tXzZUEqkEy8Zydwl00
	 JqTRI99tiCRv5VTu6L3uE1MqAH0SI6t5HFt+ALQFnTNkPbq0n4Ac/4+/C5FSzLhMlu
	 xPf4Uu/KRaEYv7mLTtqIEigTcmZTOFCvaKuRw4AE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 49AA2F800D8;
	Thu, 29 Oct 2020 10:40:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 85321F8020D; Thu, 29 Oct 2020 10:40:11 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 64CF1F800D8
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2020 10:40:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 64CF1F800D8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="Uqz6RcxO"
Received: by mail-wm1-x341.google.com with SMTP id c16so1773198wmd.2
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2020 02:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hur9K+EudzUclv9Q5MgCsUV5nXs9DJUDHPdJFsODeWM=;
 b=Uqz6RcxOD9iSU+l/mOial1rAIMeJOXKNmyvc2QEbl/w8pZk5YOIfProysAgwaK4biy
 jXyJ8u/BHnY4N6RDgPrtiwCQBRhG/Zh2a7/pA4d6R83nFseK01Y5ouFNAyeph4RmcMVl
 hBaBItva8mOBNRuVWgJNIufbfAKZhJ7TIteAVoQ9BqthW34CMURCtoERm9q4pQbRpuXj
 gq4QQAHY6B53q82PyVppwjwdUD7wZrKxXH2vfQP+Mr6PwTl/BbUxqzqyqX9oNP4dbu7Z
 D9d0M3zHNtS0BWRmTKktMSkAAN+AsSP35EybWymaWbT/8JTiv2myvfb/nzVfBU2N/i8w
 zpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hur9K+EudzUclv9Q5MgCsUV5nXs9DJUDHPdJFsODeWM=;
 b=UpMrOqdSgGBUn+pnTc4l3jswD1vAa92dVl+9qt7iI71V29HJuKLxPHbxZ98XH+yYVq
 V3q0ChYEcJp5POcaPE0Q3pbhp/B7jYlV7imnGK9XOy+iEt6vm5JCD1okhEaXTSr6N6Xy
 PLQ47ny7nZeZxcZM3pg2k6DV4am8Q/CQR+0EANCp/hQwlmlvNChgQQRVfn4mBi16+mw4
 ki3Uae63P6fh3wDWmC3IL86oRij4ug6804Egwq+o9ID641bz1gKdFTEcaataF4cm3pZ7
 UMPvvcTJagGn3PuZi4RmKmmv4KbnqYbdRMYsj1ooBDnfDeYyvn46EiZTU88niGzxTGoc
 sSyA==
X-Gm-Message-State: AOAM531/lvrSinvjl5hyPv9prK0Gbcm8V9R0cTWH78YQKVLRtDrjykKA
 c+vF+JvoA89mqBfzM7ky1SbcWw==
X-Google-Smtp-Source: ABdhPJwABc6anNpYjQu1A/0HOMid9JVr/Km6Tz3QWl+sUAYUXr9XM/TFmuG0c2bfemthkDakTGPdEw==
X-Received: by 2002:a1c:2349:: with SMTP id j70mr3305664wmj.78.1603964402648; 
 Thu, 29 Oct 2020 02:40:02 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.googlemail.com with ESMTPSA id p9sm3248589wma.12.2020.10.29.02.40.01
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Oct 2020 02:40:01 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] ASoC: qcom: dt-bindings: Add SM8250 sound card
 bindings
To: Rob Herring <robh@kernel.org>
References: <20201026170947.10567-1-srinivas.kandagatla@linaro.org>
 <20201026170947.10567-2-srinivas.kandagatla@linaro.org>
 <20201028150135.GA4009047@bogus>
 <31981724-b260-e94d-ebc6-ccea21763531@linaro.org>
 <CAL_JsqLUYCrqbgxJPc_CTH9MtQo=h4JBqcmpgwJgWncyLN2gtQ@mail.gmail.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d876d014-8342-e1b9-7773-86995d7d79f6@linaro.org>
Date: Thu, 29 Oct 2020 09:40:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLUYCrqbgxJPc_CTH9MtQo=h4JBqcmpgwJgWncyLN2gtQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, spapothi@codeaurora.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Patrick Lai <plai@codeaurora.org>
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



On 28/10/2020 18:24, Rob Herring wrote:
> On Wed, Oct 28, 2020 at 10:19 AM Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>>
>>
>>
>> On 28/10/2020 15:01, Rob Herring wrote:
>>>> +        - const: qcom,sm8250
>>>
>>> This collides with the top level SoC compatible resulting in:
>>>
>>
>> I did run dt_binding_check before sending out this patch, I might have
>> missed it somehow because the make dt_binding_check did not
>> end/termnitate in any errors, however if I had scrolled 15-20 Page ups
>> it does have this error log!
> 
> make -sk

Thanks for the hint!

> 
> :)
> 
>> Documentation/devicetree/bindings/arm/qcom.yaml does have
>> qcom,qrb5165-rb5 entry under [qcom,sm8250]
>>
>> Can you help me understand why is this not a valid compatible?
> 
> Those compatibles are used at the top level for the SoC. You can't use
> the same compatible to mean 2 different things.
> 
Thanks for explaining this, This is now modified to
  "qcom,qrb5165-rb5-sndcard"
  "qcom,sm8250-sndcard"

I do not see any complains from dt_binding_check.

also makes it inline with other qcom soundcard compatible strings!

--srini
> Rob
> 
