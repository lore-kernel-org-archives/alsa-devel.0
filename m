Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1A3C433FE
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Nov 2022 08:37:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E26EE15F2;
	Mon, 14 Nov 2022 09:36:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E26EE15F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668415062;
	bh=Sfo3tLGgMoQVqYK1WsYTJw16tfbbqbgE9MIR4bB8Ysc=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mVUg8NfCO4kiOfEgrhyPC5PaNFPGiz+QsYd30VJX5C6Ja6MJk27Z34rKng+obl4x4
	 ujanBI8MRSqfpwIZlssK9N86fRlFeOXPBctoZ1Nl2Ssk/l2P/BW1E8uBnxHfYGrNpj
	 KccHFzesFlTBBKNQNndc//IlrllpDfz/fgEipRC4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C50AF80245;
	Mon, 14 Nov 2022 09:36:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DF739F80431; Mon, 14 Nov 2022 09:36:49 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 06F0DF800B8
 for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2022 09:36:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06F0DF800B8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="MH5HrumJ"
Received: by mail-lj1-x22d.google.com with SMTP id d3so12219675ljl.1
 for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2022 00:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nTEjizgK12vbPhLWwinQMtA1pCqdItXWmozqdg50nZw=;
 b=MH5HrumJHEerfCAmCAxyabzajxtCKGY4N1/zdkGvwRKg47JNE8L+sTUVtBQ/x6DvtH
 Cpr5mXU8diCaYtEDv3BahxuP7NBto4sBDsoYmiylnu6eu0k52kRYFuu6z+kIGYfo+VUG
 1zjSpcde8JazuQ4eiC9nUSewURMfofFkZ3QYqyXZ+rP4WALZQqhDkmsVp+YNpZs+oBG0
 r21KXlNlBJEi2m3U7FzAajtr8KmjkSr4j0L67MHR9zWfxcrfYPctGS+B5JzWm0tup2OH
 VZVdC7uYss5C8myBNKAatvua1SImYoNsSTJ6QjJCJnAbRIwkxx0wJ4LekJD1DrkXQI/7
 c+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nTEjizgK12vbPhLWwinQMtA1pCqdItXWmozqdg50nZw=;
 b=j2Hpos7U9OYiWqxtmE8V1x3jLJk7dDrGg3b3QgAwUl2yuqefscRkhNmpenqz3S/VK8
 zWyxT3KwIRvbcNfXo2QoBJiOkDkMnnkA6LpltvG6jccX4nF8Y5MXs1WKu7JEfFf2I1VP
 EiKGCMzIYIPhQWvqo6rZItRIpA0Ktczg89Q1u5sPDxcvz+/aL5DVcMv3BsE+KSrbtwLv
 dk5ZRTR2Cy1BoGd10Kv29PTpa+X6K53UB4xDClZFEDt3h3o4eER/rhyAtPUoCtiH7mSb
 rl4FlFuk/MSBH8CPuGr+f4xK1ILGY1wAN53J3RdowAy4hzI0TuA12Pime47LC/b0J/lr
 55eA==
X-Gm-Message-State: ANoB5pknPotEPMuVbeST+dDxhwQRWpeYqpqporkkey0lniLATx49dzYd
 2pDA1CxFuG9wdOtNVhGR093jGA==
X-Google-Smtp-Source: AA0mqf5ureuJ0OvXRBMKbOyPj06BKiN5ustz7hPEnpAjwdnbagssD5btEaHfUpLOiAXZy7Z9dFwL7w==
X-Received: by 2002:a05:651c:130d:b0:26e:a:b5c9 with SMTP id
 u13-20020a05651c130d00b0026e000ab5c9mr3833473lja.481.1668414998294; 
 Mon, 14 Nov 2022 00:36:38 -0800 (PST)
Received: from [192.168.0.20]
 (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
 by smtp.gmail.com with ESMTPSA id
 a1-20020a19ca01000000b004a03d5c2140sm1733277lfg.136.2022.11.14.00.36.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Nov 2022 00:36:37 -0800 (PST)
Message-ID: <09da5c6b-490a-b003-70de-cfee9835260f@linaro.org>
Date: Mon, 14 Nov 2022 09:36:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 01/12] dt-bindings: mfd: Add Cirrus Logic CS48L32 audio
 codec
Content-Language: en-US
To: Richard Fitzgerald <rf@opensource.cirrus.com>, lee@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 linus.walleij@linaro.org, broonie@kernel.org, tglx@linutronix.de,
 maz@kernel.org
References: <20221109165331.29332-1-rf@opensource.cirrus.com>
 <20221109165331.29332-2-rf@opensource.cirrus.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221109165331.29332-2-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
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

On 09/11/2022 17:53, Richard Fitzgerald wrote:
> The CS48L32 has multiple digital and analog audio I/O, a
> high-performance low-power programmable audio DSP, and a variety of
> power-efficient fixed-function audio processors, with digital
> mixing and routing.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  .../bindings/mfd/cirrus,cs48l32.yaml          | 166 ++++++++++++++++++
>  1 file changed, 166 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/cirrus,cs48l32.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/cirrus,cs48l32.yaml b/Documentation/devicetree/bindings/mfd/cirrus,cs48l32.yaml
> new file mode 100644
> index 000000000000..d128600c0b72
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/cirrus,cs48l32.yaml
> @@ -0,0 +1,166 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/cirrus,cs48l32.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logic CS48L32 audio CODECs Multi-Functional Device
> +
> +maintainers:
> +  - patches@opensource.cirrus.com
> +
> +description: |
> +  The CS48L32 is an audio SoC with extensive digital capabilities
> +  and a range of digital and analogue I/O.
> +
> +  See also the child driver bindings in:
> +
> +    bindings/pinctrl/cirrus,cs48l32.yaml
> +    bindings/regulator/wlf,arizona.yaml
> +    bindings/sound/cirrus,cs48l32.yaml
> +
> +allOf:
> +  - $ref: /schemas/pinctrl/cirrus,cs48l32.yaml#

There is no such file.

Best regards,
Krzysztof

