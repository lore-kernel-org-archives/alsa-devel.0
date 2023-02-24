Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B93DC677F1
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Feb 2023 10:01:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AA6EB207;
	Fri, 24 Feb 2023 11:00:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AA6EB207
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1677232901;
	bh=A4Cse4Ql0QKE8ukskC9Ct7aLZhHr9QdI/m8PW+PjYJM=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=ZYELZPt15Wg6aERdhLqDxUqHu82az0s0nHlie7IthsAb10kucs0FN9zhAuwSz6phQ
	 rU24htiBzeNFb7ZDUchuyEyuu5s0hcnI4QtGv4lsIQxUrBLYXhRFkQNJR5a4c/Mp3Q
	 +6o/urbBCQdWPSKKq/k1ph6K+KWT2JG433DwFjEo=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 79B58F800C7;
	Fri, 24 Feb 2023 11:00:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7F5B8F8014C; Fri, 24 Feb 2023 10:59:57 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E64D4F800C7
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2023 10:59:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E64D4F800C7
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ee085rvn
Received: by mail-ed1-x535.google.com with SMTP id x10so51875443edd.13
        for <alsa-devel@alsa-project.org>;
 Fri, 24 Feb 2023 01:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wtIuDW2eQkRbGFvSewuxjU4xIOGxpYMc+vOIKksGCaU=;
        b=ee085rvn0DvOv8XgdsY8PLoWCb0jLodHKCg3Tp+9D8nhapZxcfYT+jcPzwNG8npDwf
         AvM0Bzz9+nybDUnui66nmjEDuVymoj/ZrcK9+SZau2GTSdlC97KlJQtimdhoMrX2xyEV
         W24ZaRgXqwre2fDNy314t/AHyvGccj/WchIMENAT0hdnkBkf2ZZfeI32NBHZ9myrN6D/
         BXSOY37i8R6ihe6gE4xJEyvxD/DwZ1utOKTqkxb2368KlhoaXdp1tteP2ByMPwDnjlae
         jp1qvG3b2T7U1OTOBJspiOgIUoIjg2qGNdF9iAL6TZlZx2aaK6v0ouw3XQfx+uzqqF9+
         5aew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wtIuDW2eQkRbGFvSewuxjU4xIOGxpYMc+vOIKksGCaU=;
        b=wiqdZpLg0h70xHIqytCjbBtudkJOAPvQgPjVx3/bgpSwa0hQDC9cwYyOAf7eAGDc4Q
         A7L45owRXhqTelVposeXP7jSDFxvCkVHd5gq8VGKnXEhD3mD1fwospcg8mpnkF202mC/
         LHsvm5bIkbKHqyTNDRkp85FZsxRFbrtLwIs5QJ7ddKXt70GhdxX/Fe3QDwcqPi9lcEyG
         7mjG3JEeUj46X7QhEE4UugrPlW9lRbmfHafC8a0QxoOBHi++G1fl1BPArn8UVJenDjFZ
         MtxCxHd5pnEGKpYFwdV8G+ZE7ikQc1wUjqJkm7HiSJ/akcV3E3OfQVZzgRJB8XfYTkoE
         JfIw==
X-Gm-Message-State: AO0yUKXwmv8ED+85IRxRmKP3C6hA3tInxdECiUoU8TgvXek7S3VD/gXm
	KIK0rKg+b43DtzXOHrIRtGnc3w==
X-Google-Smtp-Source: 
 AK7set9h4c7mDwoIZ//68yJseIkY4LktumLVuRyyDSSLBuK/4Q79zZF04ClwiptuRbJhP4gLNPBtag==
X-Received: by 2002:a05:6402:1287:b0:4ad:7c30:2596 with SMTP id
 w7-20020a056402128700b004ad7c302596mr14133282edv.3.1677232786097;
        Fri, 24 Feb 2023 01:59:46 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id
 n14-20020a170906840e00b008eaf99be56esm2326189ejx.170.2023.02.24.01.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 01:59:45 -0800 (PST)
Message-ID: <7cbd979d-2126-2b8e-35d9-14e4f9681ea8@linaro.org>
Date: Fri, 24 Feb 2023 10:59:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] ASoC: dt-bindings: max98363: add soundwire amplifier
 driver
To: =?UTF-8?B?4oCcUnlhbg==?= <ryan.lee.analog@gmail.com>,
 lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 rf@opensource.cirrus.com, ckeepax@opensource.cirrus.com,
 pierre-louis.bossart@linux.intel.com, herve.codina@bootlin.com,
 wangweidong.a@awinic.com, james.schulman@cirrus.com,
 ajye_huang@compal.corp-partner.google.com, shumingf@realtek.com,
 povik+lin@cutebit.org, flatmax@flatmax.com, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
 ryans.lee@analog.com
References: <20230224010814.504016-1-ryan.lee.analog@gmail.com>
 <20230224010814.504016-2-ryan.lee.analog@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230224010814.504016-2-ryan.lee.analog@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ZHGFV7TXF6GCAPPB2VFK4NQ5WPZGEFKT
X-Message-ID-Hash: ZHGFV7TXF6GCAPPB2VFK4NQ5WPZGEFKT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZHGFV7TXF6GCAPPB2VFK4NQ5WPZGEFKT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 24/02/2023 02:08, “Ryan wrote:
> From: Ryan Lee <ryans.lee@analog.com>

Thank you for your patch. There is something to discuss/improve.

Your patch is corrupted because you modified it after creating it. It
won't apply correctly and won't work. The bot's response with error is
about this.

Except broken patch, here are some more comments:

> 
> This patch adds dt-bindings information for Analog Devices MAX98363

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> SoundWire Amplifier.
> 

Subject: drop driver. Bindings are about hardware, not drivers.

> Signed-off-by: Ryan Lee <ryans.lee@analog.com>
> ---
>  .../bindings/sound/adi,max98363.yaml          | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/adi,max98363.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/adi,max98363.yaml b/Documentation/devicetree/bindings/sound/adi,max98363.yaml
> new file mode 100644
> index 000000000000..fda571d04a64
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/adi,max98363.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/adi,max98363.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices MAX98363 SoundWire Amplifier
> +
> +maintainers:
> +  - Ryan Lee <ryans.lee@analog.com>
> +
> +description:
> +  The MAX98363 is a SoundWire input Class D mono amplifier that
> +  supports MIPI SoundWire v1.2-compatible digital interface for
> +  audio and control data.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,max98363
> +
> +  reg:
> +    maxItems: 1
> +    description: Peripheral-device unique ID decoded from pin
> +
> +  vdd-supply:
> +    description:
> +      A 2.5V to 5.5V supply that powers up the VDD pin.
> +
> +  dvddio-supply:
> +    description:
> +      A 1.7V or 1.9V supply that powers up the DVDDIO pin.
> +      This property is only needed for MAX98363A/B.

It's not a DAI?

> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - dvddio-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>

Drop the header, you do not use it.

> +    soundwire {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        max98363: amplifier@3 {

also drop label (max98363).

> +            compatible = "adi,max98363";
> +            reg = <0x3>;
> +            vdd-supply = <&regulator_vdd>;
> +            dvddio-supply = <&regulator_1v8>;
> +        };
> +    };

Best regards,
Krzysztof

