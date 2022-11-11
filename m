Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1328C4332F
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Nov 2022 15:09:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E9921669;
	Fri, 11 Nov 2022 16:08:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E9921669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668179367;
	bh=aEPEua0jf/V6uHEYwYaPqgHH9uv+O3S1y8iUJqitokU=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LsVSWxQ+XSsHjPoYc2vQISdovgr10nag9yhoUXLq9sFBqewW+7ReQF4eFJSSP8VmM
	 RFlHFlg1heuU93WQF+Mz3Pe8rSITKSOyeM8dfXuetzNgakud91RuyQhX82zatDN63t
	 oQx2ZBG9TNclBn06HrhgagfVPC9sb10Wzo6B5cD0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DCB9EF80249;
	Fri, 11 Nov 2022 16:08:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 00882F800CC; Fri, 11 Nov 2022 16:08:34 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 274BDF800CC
 for <alsa-devel@alsa-project.org>; Fri, 11 Nov 2022 16:08:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 274BDF800CC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="qjbmHmGh"
Received: by mail-lf1-x130.google.com with SMTP id l12so8727968lfp.6
 for <alsa-devel@alsa-project.org>; Fri, 11 Nov 2022 07:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HXyReKf+SaMmxMwPVNiY20ax8fGYox21y6b/Jds1MEM=;
 b=qjbmHmGhkfAc9SZRc4BaDop8iz4fk/nFEUN8L5XmKXjhpRQYTfXDVLiV6V9R2Yyo1p
 Einfdr48B9enB9KKx512RxrWJ6vAJm/hyc8uaqY97w496PNj3GittjPJaupZafQsVLRh
 Hc2N2ufex3SFDgfcfmdCSaw3q3Ab3pGceRtDItMjFSDojCnGx4PF2N87S4aIWFgyw0hk
 TQvdqvkl7Aec15kSOu3+OKqpsN/n7T35fxYVAM8wdbAwuzZPM68WAdtM12NWklzgPvba
 ijt1fYw8KcHFzTkTRhB28Es2gluYha926QocJ04JI1M9VstCoXUudQZXxTbLFI4pLqfG
 gbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HXyReKf+SaMmxMwPVNiY20ax8fGYox21y6b/Jds1MEM=;
 b=Ec4cKUP7nJ5QLE4LjFh6QAUZCcAEJElVme5TBtIZ1ObYIjsQF3CFApFCZW8zoftbtB
 rTCtRtFopn9x85k5Aj1UIZI+z3kS5lYYKCBCYFrqldNmuBjcIjuKBKqCvtpsaIFEffJ7
 4ACslmLEf3jZiBeVOIkvur74deTRNFKVdTAY2JH37CC9O3sg6kAjplpSp+pYPGF9o3wg
 3C+Jqjg1TOkt0HLVRLVWYyPeKHRzl9iot2ISkdPILUa8diXcHR/CDO8bR3DJXo/9G1q3
 GppntoG89bkl9Zdf5Hs5zJ5U73bsKN1h+AaEG9k6LR3Wi3nEbvw8H3kRJVMHSP7fbv4i
 p97A==
X-Gm-Message-State: ANoB5pkWkUmotuwfWWFwcodWzLbKmVBVpavF+coejyD4ao3PrRuMU2xr
 o0+qxUlSZxR6fSw1Z/Sli1E45g==
X-Google-Smtp-Source: AA0mqf7gOa7BEiHFktV1pJNb/PcyayuvnLMqvrj+8Oia8oSRxXKytbHFtu/fI2gwTRkaD+IkEqa7Jg==
X-Received: by 2002:a05:6512:159e:b0:4ac:660b:1f02 with SMTP id
 bp30-20020a056512159e00b004ac660b1f02mr943223lfb.9.1668179306958; 
 Fri, 11 Nov 2022 07:08:26 -0800 (PST)
Received: from [192.168.0.20]
 (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
 by smtp.gmail.com with ESMTPSA id
 v19-20020a05651203b300b0048a757d1303sm365510lfp.217.2022.11.11.07.08.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Nov 2022 07:08:26 -0800 (PST)
Message-ID: <7da8c6fe-6264-4e9f-6060-6aa4625732ee@linaro.org>
Date: Fri, 11 Nov 2022 16:08:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V3 5/6] ASoC: dt-bindings: Add schema for "awinic, aw883xx"
Content-Language: en-US
To: wangweidong.a@awinic.com, broonie@kernel.org, perex@perex.cz,
 alsa-devel@alsa-project.org, tiwai@suse.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, ckeepax@opensource.cirrus.com,
 tanureal@opensource.cirrus.com, quic_potturu@quicinc.com,
 pierre-louis.bossart@linux.intel.com, cy_huang@richtek.com
References: <000701d8e7521f78bc05e6a340awinic.com>
 <1668165992-6493-1-git-send-email-wangweidong.a@awinic.com>
 <1668165992-6493-6-git-send-email-wangweidong.a@awinic.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1668165992-6493-6-git-send-email-wangweidong.a@awinic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: duanyibo@awinic.com, yijiangtao@awinic.com, zhangjianming@awinic.com,
 zhaolei@awinic.com, liweilei@awinic.com
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

On 11/11/2022 12:26, wangweidong.a@awinic.com wrote:
> From: Weidong Wang <wangweidong.a@awinic.com>
> 
> Add a DT schema for describing Awinic AW883xx audio amplifiers. They are
> controlled using I2C.
> 
> Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
> ---
>  .../devicetree/bindings/sound/awinic,aw883xx.yaml  | 60 ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/awinic,aw883xx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/awinic,aw883xx.yaml b/Documentation/devicetree/bindings/sound/awinic,aw883xx.yaml
> new file mode 100644
> index 0000000..1c0c726
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/awinic,aw883xx.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/awinic,aw883xx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Awinic AW883xx Smart Audio Amplifier
> +
> +maintainers:
> +  - Stephan Gerhold <stephan@gerhold.net>
> +
> +description:
> +  The Awinic AW883XX is an I2S/TDM input, high efficiency
> +  digital Smart K audio amplifier with an integrated 10.25V
> +  smart boost convert.
> +
> +allOf:
> +  - $ref: name-prefix.yaml#
> +
> +properties:
> +  compatible:
> +    const: awinic,aw883xx_smartpa
> +
> +  reg:
> +    maxItems: 1
> +
> +  reset-gpio:

reset-gpios

> +    maxItems: 1
> +
> +  irq-gpio:

irq-gpios

> +    maxItems: 1

You also need here description

> +
> +  sound-channel:
> +    maxItems: 1

What's this? Does not look like a standard property. You need type and
description (and sometimes also vendor prefix...).


> +
> +  sound-name-prefix: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpio
> +  - irq-gpio
> +  - sound-channel
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        aw883xx_smartpa@34 {
Node names should be generic, so codec or amplifier
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +            compatible = "awinic,aw883xx_smartpa";
> +            reg = <0x34>;
> +            reset-gpio = <&ap_gpio 92 0>;



> +            irq-gpio = <&ap_gpio 93 0>;

Use defines for flags.

> +            sound-channel = <0>;
> +        };
> +    };

Best regards,
Krzysztof

