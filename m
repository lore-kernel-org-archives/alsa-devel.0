Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A93C7EE29
	for <alsa-devel@archiver.kernel.org>; Sun,  4 Jun 2023 10:33:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E608F820;
	Sun,  4 Jun 2023 12:32:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E608F820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685874823;
	bh=zH4fuXV02o1NCjFm3YqqEymemdoLLxIttYKWohRnBl0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=DMGA9UDTogyKhiDGswpmfgmaj6XwNlFFVoo/LIrpZZZ4Fr4DYMkuqq1U+de0AV+LX
	 1aUMYlcb70YMbUmFMgOHyrSDMrrI+UPoLClPH6ZhXjo8lITEBp4VGoxYtcvWvaNkBJ
	 ZyLBf+NBpIEQAfQ5VA2GUCAJTEJ7eXmM4Be25E7E=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B7E14F800ED; Sun,  4 Jun 2023 12:32:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6B45CF80199;
	Sun,  4 Jun 2023 12:32:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 80C4EF80199; Sun,  4 Jun 2023 12:26:59 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C599BF800C8
	for <alsa-devel@alsa-project.org>; Sun,  4 Jun 2023 12:26:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C599BF800C8
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=WBLIufn6
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-977c89c47bdso177577266b.2
        for <alsa-devel@alsa-project.org>;
 Sun, 04 Jun 2023 03:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685874412; x=1688466412;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AJSHI/wM8OxoIZMScQKHzgdshhk+Z+V6iSUOb3f+fUo=;
        b=WBLIufn6FaDKJRlxmznzODTyp1EIkLlA9g0b7y9YQaN397riJeRgHOvmEhWu6QQTfg
         SIcsO05Y0x5Fo1CswjmM7AnZhLK/2Y6BLTVOVNW9UcKm8rKWzuKnbmChqwJsbbfr52ar
         jvioklNjVDfKH2xnlvzIibk3XTxlqrDVrsrgQHNUoWT7nETIhEc96bg+EzJBBrzeaNYL
         BUq1uwWS+eFrUcrkJX3a5BivOWVLvL/+tV7n8qnju7ZJKj665NBcpyPfwgjleO9dUHZV
         C2NjCIb0Tgorq+YFUbunBkpv4MIECxPrlKlHFPoL+mzVzizOvGfLUqmJlmePrjp2lCZJ
         zMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685874412; x=1688466412;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AJSHI/wM8OxoIZMScQKHzgdshhk+Z+V6iSUOb3f+fUo=;
        b=hY61iPEq/+h9cUphLddJEKhmeA8t17bw0612YVqnE8NDHpHpjM6cMB5wql6EvaKeh7
         3Y8PaQ8/m0ARYGgd9NhSr27ld/MKPMN+Vj0EL+PRTy32h8u5U+YRJg23a6bmQZfR9Qbu
         Ay5PvZ8S0eNrHmttd7tEarH78CGgOR7F59UXQJNHQtoiVGB8FRpDkMwobNk6uTFskqlf
         cktFkNzj7ykW299NoKEuQpIlQDj+WcaJK9gu1HLH1/HdWZDVk8kK1c1f56C/XSKQrJEo
         g42GUzDp9JVNsQuLrjQ4ijdd0c67LZMn0p5pFAj5QsdIcnrPpjZrb1Wze3jGu1YGLS5F
         rNbw==
X-Gm-Message-State: AC+VfDxUHB6+a6pzYBky6miucUvArGVKv1uHuGTCr4lEy+I9TiGaS5Ld
	Wo9Aba17Gk11eGqWX2apfzuJrw==
X-Google-Smtp-Source: 
 ACHHUZ4JYlaRMEe60I46ZCyR3ZzQ9mtSGPn76sEYeljxg2b0VEu14Ft6nUd4H17cb/XZHAbY26cixw==
X-Received: by 2002:a17:907:1c25:b0:977:d48f:97ad with SMTP id
 nc37-20020a1709071c2500b00977d48f97admr1102482ejc.75.1685874411803;
        Sun, 04 Jun 2023 03:26:51 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id
 qu25-20020a170907111900b00974530bb44dsm2905545ejb.183.2023.06.04.03.26.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jun 2023 03:26:51 -0700 (PDT)
Message-ID: <cd4501ab-a088-cd2a-51c8-a469a66b7af5@linaro.org>
Date: Sun, 4 Jun 2023 12:26:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: stm32: document audio of graph
 port for i2s
Content-Language: en-US
To: Olivier Moysan <olivier.moysan@foss.st.com>,
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230531140912.819373-1-olivier.moysan@foss.st.com>
 <20230531140912.819373-2-olivier.moysan@foss.st.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230531140912.819373-2-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: LM6UWSNHRDSLBI5YXNNUEDKG5MVSOACV
X-Message-ID-Hash: LM6UWSNHRDSLBI5YXNNUEDKG5MVSOACV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LM6UWSNHRDSLBI5YXNNUEDKG5MVSOACV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 31/05/2023 16:09, Olivier Moysan wrote:
> When linking the STM32 I2S to another DAI component, according
> to audio graph cards bindings, an OF graph port property is expected
> in the node. Document the port property.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml b/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
> index a040d4d31412..3bc917a45802 100644
> --- a/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
> +++ b/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
> @@ -61,6 +61,10 @@ properties:
>      description: Configure the I2S device as MCLK clock provider.
>      const: 0
>  
> +  port:
> +    $ref: audio-graph-port.yaml#
> +    unevaluatedProperties: false
> +

Extend the example.

Best regards,
Krzysztof

