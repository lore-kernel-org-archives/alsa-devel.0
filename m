Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CADC7EE23
	for <alsa-devel@archiver.kernel.org>; Thu,  8 Jun 2023 07:19:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0406474C;
	Thu,  8 Jun 2023 09:18:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0406474C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686208778;
	bh=ylSwGMmLckBKSOeOCpT3frupjgoNTsuiVRitxRNnBaU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=rGobBaWqaMxmx1lLFJ+deBtDItsz5zvUqsWuUl9CpV1KaGlr6xiKmxsXHpYsD7JCF
	 23fmrBx1XW5TQlOaO96x66T1QHl3lF1L5TMu7dyxPUrDGV9HdGxe51ueFltOF6I2kM
	 5wBwlbcJcYoj/F2MPqwTMKKszgCtcv7DjgeVsm2w=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DC184F80544; Thu,  8 Jun 2023 09:18:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 88A6DF80290;
	Thu,  8 Jun 2023 09:18:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F121CF80199; Thu,  8 Jun 2023 09:18:34 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D7F72F80155
	for <alsa-devel@alsa-project.org>; Thu,  8 Jun 2023 09:18:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7F72F80155
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=xcDa5UVU
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5151934a4e3so371047a12.1
        for <alsa-devel@alsa-project.org>;
 Thu, 08 Jun 2023 00:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686208711; x=1688800711;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LXEBC8JZMICwE4VG2uXVfSnwe1adhgVGBUr3vurvFKA=;
        b=xcDa5UVUhBlXQH80j2JcXOoWmuVBnEfRyqotJ80tYTSl3B4CCJX/kGZTayYM5G+e8q
         Iy2DmVneWnLuvV6I8ygi7liOcJD4UBAPKcanlgyQrWQI/0RLzzoCVxob6zv3dknWykrs
         BXOyHyzo3IkG4bf2sUs/6zu88oRfs4L4c56DkIXpOamxeVvOwgrYrtfmmQBZTQjApxC6
         j5HyHni+vtgru9wBUamm5UNPInaeiVu7DOTLCWFiX3vUykYPW7D/MAg3yPZde/d1vSAG
         7GO2A/9YNe3UEDCUmC60vZM7P2ompCcJsstm8FSTQdug1B6oBHKK53o2H4muBkhBrZAl
         aArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686208711; x=1688800711;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LXEBC8JZMICwE4VG2uXVfSnwe1adhgVGBUr3vurvFKA=;
        b=CRuBbxBWqKO/6i7WxuUWRjvwuHVNh9Iz8c1jrJ98WY33CWJo3csMsR7zl0wCuzqZti
         BDuigJpfHWKwlOLzI/WBlhPDpVbfyYvfQV5aR+P/uGRMMAUsjgD+Zdr/e4AHWogPPutG
         btNBs4V9B5yb7PTwUUqqOzLmSsWqndceiPmFf3op9RbiTOBenmqrJja+6USe4HzeaeiY
         ODMhSLgDU8Hh1XOrgFT5fvZqzq0LrWdHYUCV3nJc6ZpbspRIuEmjMoZy8uG0PLYImxDV
         di/PiJWXYiR4HmXyuBJTO+2LVOAfHTqTkvDb5UAEVXdXQHM8l6tKIiTqGBpCPrb1lpBv
         6wYA==
X-Gm-Message-State: AC+VfDwKtYaTCIi40rYbYS24IOPn2Dwe7wbmpppzb4q1Y7OMNk50ThNB
	wbrGKxrShTF/ZJQFYuBBzNGulg==
X-Google-Smtp-Source: 
 ACHHUZ72SvwbpUytBAKFCe10PfP9CXgTzMFZzoPmBNYuWG1B6C8gUGZQKrwYE0kngcCRTA7RNZatqg==
X-Received: by 2002:a05:6402:1adc:b0:514:95d5:3994 with SMTP id
 ba28-20020a0564021adc00b0051495d53994mr6872541edb.32.1686208710949;
        Thu, 08 Jun 2023 00:18:30 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id
 g16-20020aa7c590000000b0051056dc47e0sm215250edq.8.2023.06.08.00.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 00:18:30 -0700 (PDT)
Message-ID: <87b9c96a-09bf-ec5d-85a0-65f59e5c593d@linaro.org>
Date: Thu, 8 Jun 2023 09:18:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: max98388: add amplifier driver
Content-Language: en-US
To: =?UTF-8?B?4oCcUnlhbg==?= <ryan.lee.analog@gmail.com>,
 lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
 rf@opensource.cirrus.com, ryans.lee@analog.com, wangweidong.a@awinic.com,
 shumingf@realtek.com, herve.codina@bootlin.com,
 ckeepax@opensource.cirrus.com, doug@schmorgal.com,
 ajye_huang@compal.corp-partner.google.com, kiseok.jo@irondevice.com,
 alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: venkataprasad.potturu@amd.com
References: <20230608054230.344014-1-ryan.lee.analog@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230608054230.344014-1-ryan.lee.analog@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: CT3334M2FYUJBH3EP37W4PM6XC6URODU
X-Message-ID-Hash: CT3334M2FYUJBH3EP37W4PM6XC6URODU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CT3334M2FYUJBH3EP37W4PM6XC6URODU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 08/06/2023 07:42, “Ryan wrote:
> From: Ryan Lee <ryans.lee@analog.com>
> 
> Add dt-bindings information for Analog Devices MAX98388 I2S Amplifier
> 
> Signed-off-by: Ryan Lee <ryans.lee@analog.com>

Thank you for your patch. There is something to discuss/improve.

> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,max98388

Blank line

> +  reg:
> +    maxItems: 1
> +    description: I2C address of the device.

Drop description, it's obvious.

> +
> +  '#sound-dai-cells':
> +    const: 0
> +
> +  adi,vmon-slot-no:
> +    description: slot number of the voltage feedback monitor
> +    $ref: "/schemas/types.yaml#/definitions/uint32"

Drop quotes.

> +    minimum: 0
> +    maximum: 15
> +    default: 0
> +
> +  adi,imon-slot-no:
> +    description: slot number of the current feedback monitor
> +    $ref: "/schemas/types.yaml#/definitions/uint32"

Drop quotes.

> +    minimum: 0
> +    maximum: 15
> +    default: 1
> +
> +  adi,interleave-mode:
> +    description:
> +      For cases where a single combined channel for the I/V feedback data
> +      is not sufficient, the device can also be configured to share
> +      a single data output channel on alternating frames.
> +      In this configuration, the current and voltage data will be frame
> +      interleaved on a single output channel.
> +    type: boolean
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#sound-dai-cells"

Keep consistent quotes - either ' or "

> +
> +unevaluatedProperties: false


Best regards,
Krzysztof

