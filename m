Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CEFEB64D7
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Jun 2023 11:37:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E4E2CEAD;
	Mon, 26 Jun 2023 13:36:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E4E2CEAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687779420;
	bh=f5p3xcHtZzbN1uabxmCRZ+tL2+zofVgLHZgKmPhSCss=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=s1Xj4zr7oHk3aie3jxspczEJe09Hu/hSdY6nSaloNdRwO4rt2EHOgM45YEvAOfO+c
	 VRphIja8LhuYkAIGIjpI5uxaxVhGmHjjj4fRPGVXAByxW5iE+d+3KH/yiNK+RkVXJ2
	 GaS1KeoOypMf12/3KjMUlYPpWIbwuntFTw9j+JNY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8D27BF806E3; Mon, 26 Jun 2023 13:28:57 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5842FF806EF;
	Mon, 26 Jun 2023 13:28:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7C709F80141; Sat, 24 Jun 2023 09:53:22 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E43FCF80124
	for <alsa-devel@alsa-project.org>; Sat, 24 Jun 2023 09:53:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E43FCF80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=LQEc0yoJ
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-51bec86b9c9so1499734a12.2
        for <alsa-devel@alsa-project.org>;
 Sat, 24 Jun 2023 00:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687593192; x=1690185192;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hr9nrGlYrxN00jEwRxs6PYBUQxgnGyvMLv6d+S+IyFk=;
        b=LQEc0yoJm0GslpUZYCjcHtwoTCvu+59CHRYP/sGpmh7IIEWYyKbcmwOTWkHIAk5amo
         GW/7Gpe870PqzwscCvwhvS2tRdD4lIO92N5a+9t0YvyTUExmCh3G/ey+cNZCCGzcBTPJ
         6yPMwkjqsKsodsXDqWTZBNezjTKe+7X8fdEpM8mYCN9NPvWn/peXOWQ5kyvKsBiKcO44
         1nn5gapVl7Ro8gQLfw1L+9piaUTX+p6FPVZZ1/ijnscvD92eH3mJCbstLfuZt0gY2UUX
         +QldvphwJQ8glfg3JyKVOgSk3y2EQry5UIdVnMeV03t88wxPGoe0khhNc6S3VhqB4zja
         Bt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687593192; x=1690185192;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hr9nrGlYrxN00jEwRxs6PYBUQxgnGyvMLv6d+S+IyFk=;
        b=eOUfWslLlwrl+44uezbCvcQO6N8RhZGfkr3t/hB2/5vbK7IODNHw955Yy2+5LD8TFS
         GeO/OyhxQ1Tin+xsnQx+cdsZ3PX1RiVvh4k2vKg1K5cnbqf2P72Yjqg2A+6Eg7Ij9x5x
         STGwI4VEpCqXliRqakdj+MkNuLMBuGJMajCErJwpt5OzpSZu9o7qMHlVGbp5l659E5/l
         rFIIOb4/YGnsiQjk7svGl8YFGM3boRSrcOjgcJxV7EvW1+9k9Gx7k+cub917ZRaGqW3T
         vt1rcQoRPpINvqqXJfCcGWncPMk9JYVEeKlHKXeXJCDXHWYWlbxTu24fRtO3UOBmEYCo
         L6RQ==
X-Gm-Message-State: AC+VfDw34HI5pdIYPD06l3mUlQo2jiUIxx3fOwI4x3C26F+9Um+VTpZZ
	r7yKop3GIh4bgGNJan6U6yxG0Q==
X-Google-Smtp-Source: 
 ACHHUZ522CJYVOfO8kVotsUuEt+wtHkNFHrIi0PS6ACNcKvYFOPHzOCYWLySAcxpXgHfsNodLNJqrA==
X-Received: by 2002:a50:ef12:0:b0:51a:f6de:bb81 with SMTP id
 m18-20020a50ef12000000b0051af6debb81mr10804337eds.28.1687593192613;
        Sat, 24 Jun 2023 00:53:12 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id
 m5-20020aa7d345000000b0051495ce23absm404938edr.10.2023.06.24.00.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 00:53:12 -0700 (PDT)
Message-ID: <074048a2-5153-e013-3562-b5cad2ba0954@linaro.org>
Date: Sat, 24 Jun 2023 09:53:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 01/45] dt-bindings: microchip: atmel,at91rm9200-tcb:
 add sam9x60, sam9x7 compatible
Content-Language: en-US
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org,
 tglx@linutronix.de, maz@kernel.org, lee@kernel.org, ulf.hansson@linaro.org,
 tudor.ambarus@linaro.org, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linus.walleij@linaro.org, p.zabel@pengutronix.de, olivia@selenic.com,
 a.zummo@towertech.it, radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
 gregkh@linuxfoundation.org, lgirdwood@gmail.com, broonie@kernel.org,
 wim@linux-watchdog.org, linux@roeck-us.net, arnd@arndb.de, olof@lixom.net,
 soc@kernel.org, linux@armlinux.org.uk, sre@kernel.org,
 jerry.ray@microchip.com, horatiu.vultur@microchip.com,
 durai.manickamkr@microchip.com, andrew@lunn.ch, alain.volmat@foss.st.com,
 neil.armstrong@linaro.org, mihai.sain@microchip.com,
 eugen.hristev@collabora.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
 netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: Hari.PrasathGE@microchip.com, cristian.birsan@microchip.com,
 balamanikandan.gunasundar@microchip.com, manikandan.m@microchip.com,
 dharma.b@microchip.com, nayabbasha.sayed@microchip.com,
 balakrishnan.s@microchip.com
References: <20230623203056.689705-1-varshini.rajendran@microchip.com>
 <20230623203056.689705-2-varshini.rajendran@microchip.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230623203056.689705-2-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-MailFrom: krzysztof.kozlowski@linaro.org
X-Mailman-Rule-Hits: max-recipients
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-size; news-moderation; no-subject; digests;
 suspicious-header
Message-ID-Hash: K3LFEYVP4HOZNQTGYAYDGLNY5OUA3PDR
X-Message-ID-Hash: K3LFEYVP4HOZNQTGYAYDGLNY5OUA3PDR
X-Mailman-Approved-At: Mon, 26 Jun 2023 11:28:40 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/K3LFEYVP4HOZNQTGYAYDGLNY5OUA3PDR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 23/06/2023 22:30, Varshini Rajendran wrote:
> Add sam9x60, sam9x7 compatible string support in the schema file.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  .../devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml | 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

