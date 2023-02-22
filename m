Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6272C636D6
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Feb 2023 12:43:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 33C92EA4;
	Wed, 22 Feb 2023 13:42:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 33C92EA4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1677069817;
	bh=JANObHzmxGF7zP/7x4Z4YcpyhXYxmPEhKVOA2vDnM68=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=ckv7HdIrce36VnmNIvA8+WM6Yu3IfNKrPkAcMLnE7werjVD7M5pSTnbE0Q7+pFnct
	 8gtD6kvTNMZXqTvLUC2l3qucx8gqNdTZffsmIHd8//NNb9fwpAbKlboS1UJ0A1iVDt
	 fkfTyigL8QXJnKLngwi1C5gWU6V8rUiFEyKHrke0=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9059AF80266;
	Wed, 22 Feb 2023 13:42:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C57D8F80266; Wed, 22 Feb 2023 13:42:23 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 262B0F80083
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2023 13:42:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 262B0F80083
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=bQ2HpWZ9
Received: by mail-ed1-x531.google.com with SMTP id o12so30224078edb.9
        for <alsa-devel@alsa-project.org>;
 Wed, 22 Feb 2023 04:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YrzMakcOOzZUVFm4JbVcFgj1K440KfwGhI4SW59K+OI=;
        b=bQ2HpWZ9B+PCUcf4/YZOLKZWOYmH5rZUdEl/DIha3BPOImbopbhwhJQpcSKSZdW5Yv
         WpBX37Duc9+JC6Y/aDCXEyY5NUq4sF3yfXc6avmaLWqUkpTTrQ7dkhnnD8autQD39jUa
         1oc54E1b+B1uMWzdV3pLVyuoeSLXPSspFDsq9VZCR/dQ1tmQhNAygUxDXg+BpvZpLVmc
         7DEwFY6261GjSwmewUTbdh4IZJ4I3xq2ergB+EVJWwGwUqsZRvfOKWYoTW9t7KQ6imby
         BWeaJ8dLadBBafh5DyaivsoqpbLhtzve574wpK4Kkr6KAnsf2OljEhQX/cnHZiefFlDP
         Um4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YrzMakcOOzZUVFm4JbVcFgj1K440KfwGhI4SW59K+OI=;
        b=t8+N4OfaAgwzCLKadTxvhrbmS4A7hHlB2/cIeC0w27bSrFwS3ZLEhLng1FkEGvxdmr
         LXyKgokpyqavENK+ceHpj+tuzOGJBGKuu47n8ia18BIeE2FTnsbYC2m+nLA/W4I64sY5
         7iqqQjM5lVeD+x1tkBqNV4MmlXzG7nGv2nFQ0rVRYtw4h7oLVEh0iiTc2BLk9STH1lFo
         rewHVnE71eSeZpNaVtpXMQ3ZQLkzC/ayj6plm5b/vPnmyrU6LoiEMkQvoKHbKHY4WcB0
         fXKmNgHTVP0N7CIwPrOFga2WUAsOXNHEgymQ/81RAxdOiv2MZArWpqrSPEqwVNUHxjnA
         fgcw==
X-Gm-Message-State: AO0yUKVhmao15bZVR2U1mTWzcj/DfK/+hj2DsTeQ4OHHCZmGASZ+meWw
	LUrWYGSWBfatR2vGAbtJdLjhqw==
X-Google-Smtp-Source: 
 AK7set+Osxu3f3jN7fxzKcBM4yGQLcOKGxAn0fzmJemEkNsgcp7K4ihSod8UT6RPaLf/MzCWkBPXMg==
X-Received: by 2002:a17:906:4081:b0:878:72d0:2817 with SMTP id
 u1-20020a170906408100b0087872d02817mr14835920ejj.29.1677069738302;
        Wed, 22 Feb 2023 04:42:18 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id
 bw10-20020a170906c1ca00b008b133f9b33dsm8347517ejb.169.2023.02.22.04.42.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 04:42:17 -0800 (PST)
Message-ID: <506f92cd-7cf5-4fd5-a930-9af086732f84@linaro.org>
Date: Wed, 22 Feb 2023 13:42:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/4] ASoC: dt-bindings: wlf,wm8524: Add a property to
 specify power up sequency time
Content-Language: en-US
To: Chancel Liu <chancel.liu@nxp.com>, lgirdwood@gmail.com,
 broonie@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 perex@perex.cz, tiwai@suse.com, ckeepax@opensource.cirrus.com,
 patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230222113945.3390672-1-chancel.liu@nxp.com>
 <20230222113945.3390672-2-chancel.liu@nxp.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230222113945.3390672-2-chancel.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: FLS2X4AZVGYUGIA7L5GQVKDDCHTBJT73
X-Message-ID-Hash: FLS2X4AZVGYUGIA7L5GQVKDDCHTBJT73
X-MailFrom: krzysztof.kozlowski@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FLS2X4AZVGYUGIA7L5GQVKDDCHTBJT73/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 22/02/2023 12:39, Chancel Liu wrote:
> This property specifies power up to audio out time. It's necessary
> beacause this device has to wait some time before ready to output audio

typo... run spellcheck, also on the subject

> after MCLK, BCLK and MUTE=1 are enabled. For more details about the
> timing constraints, please refer to WTN0302 on
> https://www.cirrus.com/products/wm8524/
> 
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
> ---
>  .../devicetree/bindings/sound/wlf,wm8524.yaml          | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8524.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8524.yaml
> index 09c54cc7de95..54b4da5470e4 100644
> --- a/Documentation/devicetree/bindings/sound/wlf,wm8524.yaml
> +++ b/Documentation/devicetree/bindings/sound/wlf,wm8524.yaml
> @@ -21,6 +21,15 @@ properties:
>      description:
>        a GPIO spec for the MUTE pin.
>  
> +  wlf,power-up-delay-ms:
> +    maximum: 1500

maximum is 1003. Where do you see 1500?

minimum: 82

> +    default: 100
> +    description:
> +      Power up sequency delay time in millisecond. It specifies power up to

typo: sequence?

> +      audio out time. For more details about the timing constraints of this
> +      device, please refer to WTN0302 on
> +      https://www.cirrus.com/products/wm8524/.

According to WTN0302 this might or might not include regulator
ramp-up-delay. You should clearly indicate which part of it this delay
is to not mix up with ramp up. IOW, mention exactly from where the value
comes (e.g. Δt POWER UP TO AUDIO OUT TIMING table, depending on sampling
clock rate). Otherwise you introduce quite loose property which will be
including regulator ramp up in some cases...

Best regards,
Krzysztof

