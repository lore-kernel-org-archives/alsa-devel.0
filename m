Return-Path: <SRS0=cpJH=YO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7314CA9EAF
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Oct 2019 12:15:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C6A0205C9
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Oct 2019 12:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="D0Ya2paC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p59UqSQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C6A0205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8D77415E0;
	Mon, 21 Oct 2019 14:14:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8D77415E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571660106;
	bh=Qc0p0Quj/akjd6eCaDYLJRPJAhaInZHtJUN/7wKcee4=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D0Ya2paCEWUFnpIKAxPabyvDdf5eQ+dGLcFgtu51IxvLHul7zKWbiudKAFlbwzr7D
	 WUSWGEsS2MEdyPPOxSTMzX/B/5LiyRI6YLIkuAwBQ9mPlajMpDsEji+CKEXH5ob+Ry
	 vmQwSoDG9TLbWkZtu2yKnwXUoHrB0mkOLlcAhEYw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 12688F80321;
	Mon, 21 Oct 2019 14:14:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 825F0F80368; Mon, 21 Oct 2019 14:14:14 +0200 (CEST)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 26E6AF80112
 for <alsa-devel@alsa-project.org>; Mon, 21 Oct 2019 14:14:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26E6AF80112
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="p59UqSQ7"
Received: by mail-wr1-x444.google.com with SMTP id n15so2900744wrw.13
 for <alsa-devel@alsa-project.org>; Mon, 21 Oct 2019 05:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7jxHvlIH/GHF2NGpOLWHwkTRpolnPbX/bJ9AbQhHZ50=;
 b=p59UqSQ7ok5T84ox4VFBup57p/nWydONjxf/yNkt7WFcO4wBEmH+YWZ+pQ6Xd9sjdE
 gSUIbcE9ffJQyI/0jl2S6ISp+GqiCmZ4CwtinHAkZf3ssil2Cwd6xHNN922f8P6xmbJM
 1A7w4V4M4aiTNuhFnQdbTE7z3a0w/dAevMvbtl1SHXmxhWzi6KF9O2CXkLIuoQfkfoVZ
 3UyWrMyNdhTb3JGhDiNqUStJdxz5TF+KqxiY1i2V32UCm4MEszjBdPKhce7iMZSsKThJ
 n3wht5xCgM8UzqK/jPTh998UCkiYDCDp3nlKnmBkv+6TTkmV/t5UKE5TBBS9ixIRcHNr
 xDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7jxHvlIH/GHF2NGpOLWHwkTRpolnPbX/bJ9AbQhHZ50=;
 b=WSnEwczNvWMNQxG4/LSh2+MBFrGDjBJPTZJsBFDZ3pPTfzvNaILoLPaqu+eu6Dl+d2
 Y+zsESsvfb2n4sVxXBjmCVGOUFlAcVNxLrSQFen4OU0SwAIXxGgPRMlS1Otd8Xn7y7/A
 EocWTlWNjj56Jc6O0eC81ZROMURSuuUiOx6t3Vehyj03COzRXx9L4BEPDnOZ699uaDua
 q3XJXqHTABK6q2x9jqBwZSYKdwB8bI/bHJWuTio9CpL/XhbXDtyqUGdZHOGQ1+3mbTkq
 NCI6bEow/YMCJcaWNPmPnvmsJyIUJNv24Q/fIIOkBTEhY9I3JVBljmgtyxi5a6CmbMbt
 vsvg==
X-Gm-Message-State: APjAAAUgsh81QIqov7d0gwDDGedWJ/PQZK/wFt/pqxEI8DtLHDdHimDN
 I0eJ0JTc6dc5MFu+jAtuRBfVPQ==
X-Google-Smtp-Source: APXvYqwTt8mxKUqo1qn5DUbfyQDPqC2LuHol4HuaS/wKQN/yN5gkLQelG0gG10cVmYyY/ZB7AYYyLw==
X-Received: by 2002:adf:ea86:: with SMTP id s6mr18677166wrm.397.1571660051249; 
 Mon, 21 Oct 2019 05:14:11 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id l18sm18941821wrn.48.2019.10.21.05.14.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Oct 2019 05:14:10 -0700 (PDT)
To: Lee Jones <lee.jones@linaro.org>
References: <20191018001849.27205-1-srinivas.kandagatla@linaro.org>
 <20191018001849.27205-3-srinivas.kandagatla@linaro.org>
 <20191021104611.GZ4365@dell>
 <1af8a875-8f55-6b7e-4204-ecedc1608889@linaro.org>
 <20191021114520.GD4365@dell>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <38dde3d9-8d7e-7dc0-7cba-137b43cea9d1@linaro.org>
Date: Mon, 21 Oct 2019 13:14:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191021114520.GD4365@dell>
Content-Language: en-US
Cc: robh@kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
 vinod.koul@linaro.org, devicetree@vger.kernel.org, linus.walleij@linaro.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, broonie@kernel.org,
 spapothi@codeaurora.org
Subject: Re: [alsa-devel] [PATCH v2 02/11] mfd: wcd934x: add support to
 wcd9340/wcd9341 codec
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
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 21/10/2019 12:45, Lee Jones wrote:
> On Mon, 21 Oct 2019, Srinivas Kandagatla wrote:
> 
>> Thanks Lee for taking time to review.
>>
>> I agree with most of the style related comments, will fix them in next
>> version. For others I have replied it inline.
> 
> [...]
> 
>>>> +static int wcd934x_slim_status(struct slim_device *sdev,
>>>> +			       enum slim_device_status status)
>>>> +{
>>>> +	struct device *dev = &sdev->dev;
>>>> +	struct wcd934x_data *wcd;
>>>> +	int ret;
>>>
>>> This is semantically odd!  Why are you doing most of the
>>> initialisation and bring-up in 'status' and not 'probe'.  Seems
>>> broken to me.
>>
>> SLIMBus device will not be in a state to communicate before enumeration (at
>> probe), so all the device initialization is done in status callback where it
>> is ready for communication.
> 
> Why do we need the device to be up *before* calling probe?
> 

To Initialize the device.
And SLIMbus device registers access can not be done before enumeration.


>> This is same with SoundWire Bus as well!
> 
> [...]
> 
>>>> +	struct device *dev;
>>>> +	struct clk *extclk;
>>>> +	struct regmap *regmap;
>>>> +	struct slim_device *sdev;
>>>
>>> You don't need 'sdev' and 'dev'.
>>
>> slim_device instance (sdev) is required by audio codec driver to allocate
>> stream runtime.
> 
> You can extrapolate one from the other.
That is possible to do! I can give that a try and see in next version!

> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
