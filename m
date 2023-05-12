Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBB8C77B75
	for <alsa-devel@archiver.kernel.org>; Fri, 12 May 2023 15:27:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 59052851;
	Fri, 12 May 2023 17:26:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 59052851
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683905239;
	bh=jujQ+Po97V/xC7RrFjstZJLf59hLmzJ4GJGFapcGrSI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=E0ygkTgEiw7u7S9+kcCTzlk0eJTNWETIZ340v6+0NGw+iHuKxBOEyHNfhSmzIZrec
	 9LCrIqbiidm+4w0PuffuZdMg4Q3RLVlOEzQUbhN7Lg4Kh1zHKT9JsYlYdYGZzjEngi
	 stp679vR3N668BrJzDEgYoojLZRjoJSt9F1vtuJY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3827FF802E8; Fri, 12 May 2023 17:26:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D001CF8052E;
	Fri, 12 May 2023 17:26:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 34933F8052E; Fri, 12 May 2023 17:25:59 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 559B2F802E8
	for <alsa-devel@alsa-project.org>; Fri, 12 May 2023 17:25:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 559B2F802E8
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=evUjakgZ
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-50bc0117683so17845647a12.1
        for <alsa-devel@alsa-project.org>;
 Fri, 12 May 2023 08:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683905154; x=1686497154;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8tAvOql5lp6FWkpzgWQiK30SNN35QkWi8X6zAAtYsbE=;
        b=evUjakgZfiWHOeaGTxTvfwse8uA7XL2gV7DSxc6/YHDPwIZl9h7joIgg5+ImdcVlHJ
         fjWqIG7H3/sjSQsQ7t1gM5Hub04ClnfGFAaVoYXpNUQI7u/H9G+Fi7bzsO7Go4cy5T4L
         0Czmo/a7u4d6cG2iPg1iT5UX3DtQezAD51OF21qH9ae5xIRttV0uN8WO+7yNAUP8ncrH
         qJoWmqK9TDkZq5JsM9TC4GwylZtD/8H1Ml7c7hwcPu/ayDsACxOrU6uEF71ZoajKP/C4
         ka22BMTKAmKmwVokU68coV0y6EK15f8XkZDstTj/HBoOwy4VGXHL9nACxplBZHIq64lO
         Gcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683905154; x=1686497154;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tAvOql5lp6FWkpzgWQiK30SNN35QkWi8X6zAAtYsbE=;
        b=XK9UasScZfjrtmugvdqH0avRc3WidCTS00x65pUfYQk6hLUg84Yhpdyi55qkF5FS/v
         h7Ng5/2pl4wPCiNc1iNAffAlEDOASKrWXx6eSIS+KQnbLYFLJB3CAN1lRA3QL/bMEH8h
         DaVsfZH4jvZlKHtz/xiITbcjT9xz6QlxzDlDTu86uBzfYIBS4sh1koBJH+UaUqVBWqGo
         uSm+JF8UF6y993OMeBYveVA3YAdaiDdw2GuR/vZcWipEJ8lAgJX/+nmh923xRLP4A/Oi
         Vh4oeH+0piPhNt6r4aEc7eGx+IiufaoLeA7nPvXB+VVwa5+65SS1l73knNbugzmo8Fn+
         rYGQ==
X-Gm-Message-State: AC+VfDyUQ1CiKdSTmjNzBQ6bhrYbQsXleVp9WAu8pAv0GaBexacDCpdo
	GuKcJqmt0wJmIFUCVj6rkf4LZA==
X-Google-Smtp-Source: 
 ACHHUZ6VLH5TEFcmhdJSIdLisEJz4f2jKiPaq4t5hSh2saBPH6sCMNzCPOVC3ciAXYocEELNXOGVhg==
X-Received: by 2002:a05:6402:1a48:b0:50c:d5d:c960 with SMTP id
 bf8-20020a0564021a4800b0050c0d5dc960mr20446684edb.38.1683905154708;
        Fri, 12 May 2023 08:25:54 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7ede:fc7b:2328:3883?
 ([2a02:810d:15c0:828:7ede:fc7b:2328:3883])
        by smtp.gmail.com with ESMTPSA id
 x14-20020aa7d38e000000b0050c0d651fb1sm4031539edq.75.2023.05.12.08.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 08:25:54 -0700 (PDT)
Message-ID: <5969fe82-69cd-34d6-edd1-d16ea741d9cb@linaro.org>
Date: Fri, 12 May 2023 17:25:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 05/10] dt-bindings: mfd: cirrus,cs42l43: Add initial DT
 binding
Content-Language: en-US
To: Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org,
 lee@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, tglx@linutronix.de, maz@kernel.org,
 linus.walleij@linaro.org, vkoul@kernel.org
Cc: lgirdwood@gmail.com, yung-chuan.liao@linux.intel.com,
 sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com,
 alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
 <20230512122838.243002-6-ckeepax@opensource.cirrus.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230512122838.243002-6-ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: RXVLZZUOGJGRBDVIN4WA6IH3CITQM5W2
X-Message-ID-Hash: RXVLZZUOGJGRBDVIN4WA6IH3CITQM5W2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RXVLZZUOGJGRBDVIN4WA6IH3CITQM5W2/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 12/05/2023 14:28, Charles Keepax wrote:
> The CS42L43 is an audio CODEC with integrated MIPI SoundWire interface
> (Version 1.2.1 compliant), I2C, SPI, and I2S/TDM interfaces designed
> for portable applications. It provides a high dynamic range, stereo
> DAC for headphone output, two integrated Class D amplifiers for

...

> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 2

Hm, are you sure? Who is the consumer/user of this interrupt controller?

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  '#sound-dai-cells':
> +    const: 1
> +
> +  clocks:


Best regards,
Krzysztof

