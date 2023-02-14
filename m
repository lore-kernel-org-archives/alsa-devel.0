Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF0DC64EC7
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Feb 2023 10:59:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC41A828;
	Tue, 14 Feb 2023 11:58:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC41A828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1676372378;
	bh=LMglzB7gIbsibcJlZ1beUpGvnYl0ADZEiAoq0JT/o9o=;
	h=Date:Subject:To:References:From:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=jzqEMKWMzW3/rHDrB8+g72Zw0MvjqmnLtZNsWl0669ic6g4tlOx/lUnVhyyZq0gK5
	 699lBmDwU5EYb+4u0cGiFOGc6quYLg2Hmqlu9lEw4wVQBqcWUutQZwBZjISfPe2SP/
	 R0Hu4WWhsdqVxT4nOdiFHrukEnyi57eerdarkV4M=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2DE21F8001E;
	Tue, 14 Feb 2023 11:58:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4741BF801C0; Tue, 14 Feb 2023 11:58:20 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CF1FAF8001E
	for <alsa-devel@alsa-project.org>; Tue, 14 Feb 2023 11:58:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF1FAF8001E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=koNK4VCv
Received: by mail-wr1-x431.google.com with SMTP id co8so11435026wrb.1
        for <alsa-devel@alsa-project.org>;
 Tue, 14 Feb 2023 02:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gx40Fv/hr96gRU+c/9uu5X2ZcDhXizr9d7Ess0reKt0=;
        b=koNK4VCvQvRc2CjyayjNk6lDJ+hKgxHPWE3G8ao18g5rTt5qjABVk0RAAtOTNbm4D4
         X+pvM4v3S4flbb63FkXX90tgE7VP3qq6IqO5/aI8Bdr5IrHj4aCImbkI/wE3pD3JCUV1
         B6LKtlYlnFEXVtB0d8XMq7gvMt/MSnP1EYib2H/lV8wIL7XxumfqhXz9AneJvCdI2Zq1
         +MjLTMMKAaK0gxdWLgEP/YiuC0g4sEss7phI+UsxNoNQMiPabyerKWfX/lMpPZgx5p1O
         rEZz1WWtNNZo4YtTuCLYx3hZtGn8pmfqcT9U8IoYB5Mse2wfHrSEzd6Bpx2UDGKtJFGR
         oj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gx40Fv/hr96gRU+c/9uu5X2ZcDhXizr9d7Ess0reKt0=;
        b=DPEh3ixZu6oNp7k8tdxy7yLq4A7Sg55VUr89ga4OArLsSvzpwL/i8uhPHW7jczCo+v
         bE2wzgh6Jr+Sj/+Oee1DqSmHuVAR7DGi4xMWGXT3PwWCxHowUlusl/3BMUKNwad6Uo/2
         jaRy/FT2BCw2/oLe825v8NhB2Qz4uJj7tyq3/iplY7Ermi00fDazt2VzYek2eNr5x/sr
         C3xYZlSDN0MDDdiBCkyykhPxiwt2k+6ewvjXGdVet0h1BROGvIP9lk6CY5W6Wal1f7VE
         +dBdpykoMmk51FVITXXxRb46HrKWk5nYe4WxSZxYJ+iDb5P/XDqkU3qqUoK0tplYlZE8
         FISw==
X-Gm-Message-State: AO0yUKU/5AgK0clIiNHUPFX0FNW5jFh8h4WfroCz60sOq7vdmg9DcJZQ
	pCYhlT8CB0GmhqWtZsLnkRgYpQ==
X-Google-Smtp-Source: 
 AK7set/wETknM6nyMS91eRgNnkHhD4f9C7g93FAnMO+buvH0MuMDeL1A34df/ZNdhAy2Ajz7xf2A7Q==
X-Received: by 2002:adf:dd45:0:b0:2c3:db98:3e87 with SMTP id
 u5-20020adfdd45000000b002c3db983e87mr1784868wrm.20.1676372292992;
        Tue, 14 Feb 2023 02:58:12 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id
 bg1-20020a05600c3c8100b003e118684d56sm18172368wmb.45.2023.02.14.02.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 02:58:12 -0800 (PST)
Message-ID: <46d5b6af-23e1-4178-83bc-b4a435b1426e@linaro.org>
Date: Tue, 14 Feb 2023 11:58:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] dt-bindings: sound: ep93xx: Add I2S and AC'97
 descriptions
Content-Language: en-US
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
 devicetree@vger.kernel.org
References: <20230212232137.299005-1-alexander.sverdlin@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230212232137.299005-1-alexander.sverdlin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: JP5I4VZ6U6N7LS3SQBJGFORUF3RRDROL
X-Message-ID-Hash: JP5I4VZ6U6N7LS3SQBJGFORUF3RRDROL
X-MailFrom: krzysztof.kozlowski@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Hartley Sweeten <hsweeten@visionengravers.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JP5I4VZ6U6N7LS3SQBJGFORUF3RRDROL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 13/02/2023 00:21, Alexander Sverdlin wrote:
> Add device tree bindings for Cirrus Logic EP93xx internal SoCs' I2S and
> AC'97 controllers.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> ---
>  .../bindings/sound/cirrus,ep9301-ac97.yaml    | 47 ++++++++++++++
>  .../bindings/sound/cirrus,ep9301-i2s.yaml     | 63 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  3 files changed, 111 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/cirrus,ep9301-ac97.yaml
>  create mode 100644 Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/cirrus,ep9301-ac97.yaml b/Documentation/devicetree/bindings/sound/cirrus,ep9301-ac97.yaml
> new file mode 100644
> index 000000000000..bfa5d392f525
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/cirrus,ep9301-ac97.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/cirrus,ep9301-ac97.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus EP93xx AC'97 Controller
> +
> +description: |
> +  The AC’97 Controller includes a 5-pin serial interface to an external audio
> +  codec.
> +
> +maintainers:
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +

missing ref to dai-common.yaml

> +properties:
> +  compatible:
> +    const: cirrus,ep9301-ac97
> +
(...)

> diff --git a/Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml b/Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml
> new file mode 100644
> index 000000000000..b47d28dc8389
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/cirrus,ep9301-i2s.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/cirrus,ep9301-i2s.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus EP93xx I2S Controller
> +
> +description: |
> +  The I2S controller is used to stream serial audio data between the external
> +  I2S CODECs’, ADCs/DACs, and the ARM Core. The controller supports I2S, Left-
> +  and Right-Justified DSP formats.
> +
> +maintainers:
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +

ref to dai-common

> +properties:
> +  compatible:
> +    const: cirrus,ep9301-i2s
> +
> +  '#sound-dai-cells':
> +    const: 0
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 3

maxItems instead

> +
> +  clock-names:
> +    items:
> +      - const: mclk
> +      - const: sclk
> +      - const: lrclk


The clk suffixes are quite redundant. Don't these inputs have some
meaningful name?

> +
> +required:
> +  - compatible
> +  - '#sound-dai-cells'
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2s: i2s@80820000 {
> +        compatible = "cirrus,ep9301-i2s";
> +        #sound-dai-cells = <0>;
> +        reg = <0x80820000 0x100>;
> +        interrupt-parent = <&vic1>;
> +        interrupts = <28>;
> +        clocks = <&syscon 29
> +                  &syscon 30
> +                  &syscon 31>;

That's one phandle, but you want three, so <>, <>, <>.


Best regards,
Krzysztof

