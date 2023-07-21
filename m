Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA9D3C0015E
	for <alsa-devel@archiver.kernel.org>; Sat, 22 Jul 2023 17:07:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C3325846;
	Sat, 22 Jul 2023 19:06:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C3325846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690045667;
	bh=XvPCFlRfGCdmQne8rvcRYA1Jr4DTeIUTvq7yg4h3F40=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Ny9aPl4mOretsgQeboBdovhtxA9X/x88Al76LYmpf/f9LfUoYm1sdn6lqSas2y53i
	 xQVPPUaT0FV1rNo6NLm/LaqeB0zgGK0CvUJ5dmTMUurj2+qBLWFdJ6BaVLtvdwcddu
	 DsumNCe4J2STudQpe9IIAjG2t3JgCfSPB0+DKFYs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E80ECF8057F; Sat, 22 Jul 2023 19:05:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7C60AF80579;
	Sat, 22 Jul 2023 19:05:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 01D29F8047D; Fri, 21 Jul 2023 16:04:45 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D0D63F8007E
	for <alsa-devel@alsa-project.org>; Fri, 21 Jul 2023 16:04:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0D63F8007E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=PuGwprqK
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fbea147034so16564865e9.0
        for <alsa-devel@alsa-project.org>;
 Fri, 21 Jul 2023 07:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689948280; x=1690553080;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i0hqft4rLykA1Qm+aWWngJrri1KXMWVHpmrflE+PpLU=;
        b=PuGwprqKdpq8LkzNLASjiLmbz8p+yLCZy03ATCdJs8insWuhZan57oKC4jNZCzS4ND
         E7w8hDj2JEk/yaK001S70oJdFPQrhUiTFfWV3ga4MQCxDAA5JM/JTtabf+JXMWw8QZqr
         uoSOVXGMsahKvU4F69owM+VtHTiwZXV4Sac3eBA92YtCWMRlMuuTlEdryO1jsFqitT9q
         Y1i7MCt3snL55MX8kx8uOg3fD3m9IlBurQS/nGi/qx0D8zW2mRSuqw3P0325+pIM+Zak
         ouue3EcgaEHjRHxqHf3v/fAkDRZkz6EaGTuc3CsJGpLhr2+Jc9UQriimeNAwdK1RDAD2
         VUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689948280; x=1690553080;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i0hqft4rLykA1Qm+aWWngJrri1KXMWVHpmrflE+PpLU=;
        b=QSf3wlt1782i39K1Y2haaKXynBoC42j7K3CJCppwk3KcWDDwzCqe3aNIRgomPuctLm
         0WFppKT0U1bLjiW7jLmX0ougOZqmjrT3bC3q1ju49mNcTqmkXHobxQk3QXy8TEvf+mCs
         NLlt7zKpkBfY3haqr53totPhRH7WTyX9cC2ft2SEcWUFYczxLC16Sgux3zvoKU0rW1d1
         aCHNEFJL+0vhwAxEClHLWxM+/XxK+XHRMdrnZYhPZxn0uvRfmM4WAo4PI1DPMq+kN8Wv
         vy18JWuBkYCaF9ZwZWQV8ux52SKr8+OzSu8BFJiuG64Xtk7uuXJz6Gi2xAR7G3tUFDJF
         jstA==
X-Gm-Message-State: ABy/qLapfsJ906LYu0NB3HmoHpxQdGhmy3GvnWDkFZIJC4Z0l48jn7cV
	IVMsjvvgM03X+/XYAcObxti1rQ==
X-Google-Smtp-Source: 
 APBJJlEsMYe5JQ+pU4AezELFYdRQHmI7TefsDs6cDm78/h68oOlcICdvW129lDjtJ/t6VHgFfG467Q==
X-Received: by 2002:adf:fc03:0:b0:314:1634:491e with SMTP id
 i3-20020adffc03000000b003141634491emr1269926wrr.20.1689948279591;
        Fri, 21 Jul 2023 07:04:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id
 x8-20020a1c7c08000000b003f90b9b2c31sm6142028wmc.28.2023.07.21.07.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 07:04:38 -0700 (PDT)
Message-ID: <5603264e-2efe-48ce-b025-797501f29fde@linaro.org>
Date: Fri, 21 Jul 2023 16:04:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 06/42] dt-bindings: soc: Add Cirrus EP93xx
Content-Language: en-US
To: nikita.shubin@maquefel.me, Hartley Sweeten
 <hsweeten@visionengravers.com>, Lennert Buytenhek <kernel@wantstofly.org>,
 Alexander Sverdlin <alexander.sverdlin@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Lukasz Majewski <lukma@denx.de>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Alessandro Zummo
 <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Mark Brown <broonie@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Damien Le Moal <dlemoal@kernel.org>, Sergey Shtylyov <s.shtylyov@omp.ru>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Olof Johansson <olof@lixom.net>, soc@kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Andy Shevchenko <andy@kernel.org>,
 Michael Peters <mpeters@embeddedTS.com>, Kris Bahnsen <kris@embeddedTS.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
 netdev@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org,
 linux-input@vger.kernel.org, alsa-devel@alsa-project.org
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
 <20230605-ep93xx-v3-6-3d63a5f1103e@maquefel.me>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230605-ep93xx-v3-6-3d63a5f1103e@maquefel.me>
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
Message-ID-Hash: QV45YZMX3JQ7K6LN5MJD6OECM43TDFKK
X-Message-ID-Hash: QV45YZMX3JQ7K6LN5MJD6OECM43TDFKK
X-Mailman-Approved-At: Sat, 22 Jul 2023 17:03:51 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: <>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 20/07/2023 13:29, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> This adds device tree bindings for the Cirrus Logic EP93xx.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  .../bindings/arm/cirrus/ep9301-syscon.yaml         | 59 ++++++++++++++++++++++

syscon goes to soc directory. Also, please add vendor prefix to the
filenames.

>  .../devicetree/bindings/arm/cirrus/ep9301.yaml     | 39 ++++++++++++++
>  2 files changed, 98 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cirrus/ep9301-syscon.yaml b/Documentation/devicetree/bindings/arm/cirrus/ep9301-syscon.yaml
> new file mode 100644
> index 000000000000..77fbe1f006fd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/cirrus/ep9301-syscon.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/cirrus/ep9301-syscon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logic EP93xx Platforms System Controller
> +
> +maintainers:
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +  - Nikita Shubin <nikita.shubin@maquefel.me>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - cirrus,ep9302-syscon
> +              - cirrus,ep9307-syscon
> +              - cirrus,ep9312-syscon
> +              - cirrus,ep9315-syscon
> +          - const: cirrus,ep9301-syscon
> +          - const: syscon
> +          - const: simple-mfd
> +      - items:
> +          - const: cirrus,ep9301-syscon
> +          - const: syscon
> +          - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  reboot:
> +    type: object
> +    properties:
> +      compatible:
> +        const: cirrus,ep9301-reboot

Patch introducing it should be before this one. Also, do not use
different styles for your child nodes. Your other nodes use $ref.

> +
> +  clock-controller:
> +    type: object
> +    $ref: ../../clock/cirrus,ep9301-clk.yaml

Absolute path, so /schemas/clock/cirrus.....

> +
> +  pinctrl:
> +    type: object
> +    $ref: ../../pinctrl/cirrus,ep9301-pinctrl.yaml

Ditto

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    syscon@80930000 {
> +      compatible = "cirrus,ep9301-syscon",
> +                   "syscon", "simple-mfd";
> +      reg = <0x80930000 0x1000>;

Incomplete example.

> +    };
> diff --git a/Documentation/devicetree/bindings/arm/cirrus/ep9301.yaml b/Documentation/devicetree/bindings/arm/cirrus/ep9301.yaml
> new file mode 100644
> index 000000000000..6087784e93fb
> --- /dev/null


Best regards,
Krzysztof

