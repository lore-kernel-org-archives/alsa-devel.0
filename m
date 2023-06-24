Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF98EB64D7
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Jun 2023 11:41:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F2DD1ED2;
	Mon, 26 Jun 2023 13:40:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F2DD1ED2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687779671;
	bh=j0z00SLnYSO2fkDDK+MT5uUPSeAlc4CcXSHkLRpRCxk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=I+6ehVi87lm+TH/9JcrhNrol/PrvsdIXAt3+jOWLtVvPLU7FbgtUtYH/KeXwYwFrA
	 zqvSNYIalMz5KO5xV9Y6hZiF51VcDWsHLym4FQ9wJtvrtK9IYylA4RA/53LYtGXGhn
	 tpawL9Z94tT0TqEu7J2Q+1HL+ExgBhpGN1lUKT5c=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B6E60F8080E; Mon, 26 Jun 2023 13:30:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CF801F8080E;
	Mon, 26 Jun 2023 13:29:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 45346F80141; Sat, 24 Jun 2023 10:02:47 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 64B72F80130
	for <alsa-devel@alsa-project.org>; Sat, 24 Jun 2023 10:02:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 64B72F80130
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=w8QQgOND
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-988c495f35fso165019266b.1
        for <alsa-devel@alsa-project.org>;
 Sat, 24 Jun 2023 01:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687593763; x=1690185763;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jaGxY+NnkNtbiINqgZVIrn7LMLj+M5ushBYs/d6ygok=;
        b=w8QQgONDomUOqDBoVh74CKpXdYrNhuFs41+qRLRJ7+fbvCMztxR2frYWC/83GW8hxQ
         3999BqBWVkJkuE9zm1JY6YjkcJceD+QK8nJzyeaQCGD24DDH+0SG6712mcjzXHoAWzM5
         m4ybyz1vjuPBLNw9H7DwOIngDiMWxYC6lTWMStgy4ra9SRYTJ1ld9vMzfpmrRabfHZ1W
         l9EohQU41D2zbZS0eNatZtiDvIYHa4nIYO0iuwVzKFNi1KNiAwzY+VYQu99FV+fe4bhL
         8f0QKWSQetVmrEASvd1LR7mIEihTpdS6wcmS7mAgyQ6/10XhHyEcYX3XwOqGChl7fY7J
         VPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687593763; x=1690185763;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jaGxY+NnkNtbiINqgZVIrn7LMLj+M5ushBYs/d6ygok=;
        b=MW9JecJVj1EJTAYIxNpVGVNz+yr1H0iAICIKX2jgiSlNpcQsJmvb8goynPTthzVQwx
         mTMsrKlHml+hjIkhR+OxnP3vVXy6FiuM9D2rnARugWwt4slwNjonosWxbjswJcXa/CdO
         CLc4q0IpssCT14zb+zi6tvEza+pyHMZuf5rMC46tajqAlEZJaVZwGcuv4xrvHg2KJwrK
         VrLBrqIP5QKTd+DghgSXRU4P57TyyvCp+Ga14jxPL4RiA7PLVJaK+yUVQaIC18ziTVyM
         8i+uIVhC4p34W2fNYvn2RSNlDygkj+hcVMDfhVqwV/OC2BP65Jjd6Gr/cOJeDtM2YE6M
         M0LQ==
X-Gm-Message-State: AC+VfDwEAQm0jtxKV7tPy10FyH6bcrTt6MptIHgVNbxa+g5MqnfvK32F
	sdgo2zl6e/Fo+A5OrnBo/TPeIQ==
X-Google-Smtp-Source: 
 ACHHUZ6vL+lt0p59DekkavEVRdH+VurtmvBUx/CDPLLIsizULEgMBaYfOxG9eWuvaLpHLjFTBqHNMQ==
X-Received: by 2002:a17:906:5d0d:b0:988:cbf5:3a80 with SMTP id
 g13-20020a1709065d0d00b00988cbf53a80mr15099774ejt.62.1687593762629;
        Sat, 24 Jun 2023 01:02:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id
 a2-20020a1709065f8200b009878b0b5302sm619453eju.98.2023.06.24.01.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 01:02:40 -0700 (PDT)
Message-ID: <2d3f27ba-62ce-b37f-3672-df8ee58cdcc0@linaro.org>
Date: Sat, 24 Jun 2023 10:02:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 31/45] dt-bindings: atmel-classd: add sam9x7 compatible
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
 <20230623203056.689705-32-varshini.rajendran@microchip.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230623203056.689705-32-varshini.rajendran@microchip.com>
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
Message-ID-Hash: V2G33GBZ56J4MJ23TFIFVMXPBKYAA7SE
X-Message-ID-Hash: V2G33GBZ56J4MJ23TFIFVMXPBKYAA7SE
X-Mailman-Approved-At: Mon, 26 Jun 2023 11:29:46 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/V2G33GBZ56J4MJ23TFIFVMXPBKYAA7SE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 23/06/2023 22:30, Varshini Rajendran wrote:
> Add sam9x7 compatible to DT bindings documentation.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  .../devicetree/bindings/sound/atmel,sama5d2-classd.yaml      | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/atmel,sama5d2-classd.yaml b/Documentation/devicetree/bindings/sound/atmel,sama5d2-classd.yaml
> index 43d04702ac2d..d53addbcd41b 100644
> --- a/Documentation/devicetree/bindings/sound/atmel,sama5d2-classd.yaml
> +++ b/Documentation/devicetree/bindings/sound/atmel,sama5d2-classd.yaml
> @@ -18,7 +18,10 @@ description:
>  
>  properties:
>    compatible:
> -    const: atmel,sama5d2-classd
> +    oneOf:
> +      - items:
> +          - const: atmel,sama5d2-classd
> +          - const: microchip,sam9x7-classd

Same as in other cases, so just to avoid applying by submaintainer: not
tested, broken.

Best regards,
Krzysztof

