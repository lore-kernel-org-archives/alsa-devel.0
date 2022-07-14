Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE7FC43334
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Jul 2022 08:39:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 88C7618F4;
	Thu, 14 Jul 2022 10:38:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 88C7618F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657787949;
	bh=CtE8wCMS8phFs8uPIFL1lKGtwmHqHHXPfn8gtS1bN+M=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b3uZ4DrXbw+45CxFEk89e8OfvYTQUoFLgb9E8b9m5UsSHEU+PET3UaiFgWPixKWQx
	 kaDgKVUaPEMD24/YmqK9B5oWHQ/gFRRSti+a7c21K6zPraq5nM3glPYdeUd5c02O6N
	 /qmYqyP/Mtp3JzE6SvoJFX61675EtGcHg4upgnLc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 16438F80152;
	Thu, 14 Jul 2022 10:38:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6B309F80165; Thu, 14 Jul 2022 10:38:17 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4CCDDF800AA
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2022 10:38:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4CCDDF800AA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="AV6Hhli3"
Received: by mail-lf1-x129.google.com with SMTP id o7so1627330lfq.9
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2022 01:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=7fxd01WSVmh4sZ+rShAEvNwWTJPHinWndJQGVhp8bBI=;
 b=AV6Hhli373vNQFbi9Ak8xtnfk65n1qJoOFR1iopuhLqNO+9rR7YVnsPRxPwQyDSQIV
 +QSw/uYsUn0j3lTno1eRLpYu6NCmKMJ9NHXnu4MS/85dt2BIFA1oM9XA7hsrJQYOFIdC
 hQbQbbF8+DErln2+k/IyanoaqZumXBcql8mwC+7C8GE42BE1um9abQ98AyATK4QRbSW2
 ljWFFeMgHHg4xta7hDjX252AJNu8ISxRyUblN+e3kCPgKPRQ1EbvbtncAOYC8xFT3/bH
 xVMAPvZIlkTEWGZd93pTeNDQCQpHIH9ToFdVKCDS72OiK4S9a+FfVKuuh/PHcI4oOCZI
 5d5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=7fxd01WSVmh4sZ+rShAEvNwWTJPHinWndJQGVhp8bBI=;
 b=pXA0REhwbphnFM/7IDmoAsPbCMTO12rhTgJn6UsVE4ERLhEkpJ6qPD7d1XQsODCbzA
 jahgjq32NnWsdpNFZgYDogxDZKuB2dPztnOTKuqn0brLN9mngmX3/OsGMwmQUSEWbc0Z
 1xVOOjSd5HWUj3etMrjzd61eSE2ZacfORzvAgQXtPn4yzIQr0jyvAwyNq9/lPDCdo9l1
 GKIXNfZdiEgjSaLeJCEWzz+VJGcgq6lvzyP5qEBx9UPIPF/tm0UjriIoRUMGhDRRaaMM
 ozwy4FoIC83UFFQEkZtYtCwXFY/HpUbNletkKeSfiZSh9/ss6aq3UXwcOivKbZJee8z+
 noMQ==
X-Gm-Message-State: AJIora+Ptizx4qaFrnJzqenYd6u06sQfzp9IwavQMfU8aK+wJVm0AzxQ
 WzDJ7jS+70vG673ziWhwe0pCDw==
X-Google-Smtp-Source: AGRyM1uNnmvHoyTRHbkEvCEx1QbExHpVGO/O3M8jCnCpVPFay7j9MN3UnazfseCVeu8DlEirOYwVeg==
X-Received: by 2002:a05:6512:2308:b0:48a:f9d:7389 with SMTP id
 o8-20020a056512230800b0048a0f9d7389mr3677290lfu.235.1657787888760; 
 Thu, 14 Jul 2022 01:38:08 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
 by smtp.gmail.com with ESMTPSA id
 k6-20020ac257c6000000b00489cd8ee61asm237159lfo.275.2022.07.14.01.38.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Jul 2022 01:38:07 -0700 (PDT)
Message-ID: <3178fad9-b761-dd28-971a-007159d10695@linaro.org>
Date: Thu, 14 Jul 2022 10:38:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ASoC: dt-bindings: atmel-i2s: Convert to json-schema
Content-Language: en-US
To: Ryan.Wanner@microchip.com, lgirdwood@gmail.com, broonie@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@microchip.com
References: <20220713162538.139115-1-Ryan.Wanner@microchip.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220713162538.139115-1-Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

On 13/07/2022 18:25, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 

Thank you for your patch. There is something to discuss/improve.

> Convert atmel i2s devicetree binding to json-schema.
> Change file name to match json-schema naming.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  .../bindings/sound/atmel,sama5d2-i2s.yaml     | 83 +++++++++++++++++++
>  .../devicetree/bindings/sound/atmel-i2s.txt   | 46 ----------
>  2 files changed, 83 insertions(+), 46 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/atmel,sama5d2-i2s.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/atmel-i2s.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/atmel,sama5d2-i2s.yaml b/Documentation/devicetree/bindings/sound/atmel,sama5d2-i2s.yaml
> new file mode 100644
> index 000000000000..1cadc476565c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/atmel,sama5d2-i2s.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/atmel,sama5d2-i2s.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel I2S controller
> +
> +maintainers:
> +  - Nicolas Ferre <nicolas.ferre@microchip.com>
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +  - Claudiu Beznea <claudiu.beznea@microchip.com>
> +
> +description:
> +  Atmel I2S (Inter-IC Sound Controller) bus is the standard
> +  interface for connecting audio devices, such as audio codecs.
> +
> +properties:
> +  compatible:
> +    const: atmel,sama5d2-i2s
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      Only the peripheral clock (pclk) is required. The generated clock (gclk)
> +      and the I2S mux clock (muxclk) are optional and should only be set together,
> +      when Master Mode is required.

Skip property description, but list and describe the items.

> +
> +  clock-names:
> +    items:
> +      - const: pclk
> +      - const: gclk
> +      - const: muxclk
> +    minItems: 1
> +
> +  dmas:
> +    description:
> +      Should be one per channel name listed in the dma-names property.
> +    maxItems: 2

Instead items+description. The description you pasted is obvious and not
helping.

> +
> +  dma-names:
> +    items:
> +      - const: tx
> +      - const: rx
> +
Best regards,
Krzysztof
