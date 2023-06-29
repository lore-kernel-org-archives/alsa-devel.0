Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E16DEB64D9
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Jun 2023 20:06:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3EE70822;
	Thu, 29 Jun 2023 22:05:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3EE70822
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688069192;
	bh=+XG67RYBVrI2+O5d3oiTCMQ3q8BBoiuy+RLMhIwpkrE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ZN9QMym+MXf7X9LdQ6uB61nFacqZ854BXabtOVsST/GqFK7fceIe0THTVOPiUqlM6
	 +dA4EVQ9wQj9FVr3A4dXvW98v3lYRmc7l71O+9kf3eqJ2hsR1y8jrqz60FWdlMvHm2
	 jVFIqNqd50j9mf3ssUXnYWaBcmAyIz7NG3G75Pag=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C2098F80534; Thu, 29 Jun 2023 22:05:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 53A9FF80169;
	Thu, 29 Jun 2023 22:05:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2E430F80246; Thu, 29 Jun 2023 22:05:13 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 42F99F80169
	for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2023 22:05:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 42F99F80169
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=gxSfIjzJ
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4fba03becc6so741572e87.0
        for <alsa-devel@alsa-project.org>;
 Thu, 29 Jun 2023 13:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688069099; x=1690661099;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OF3SWHQBitllVPlaYnVLF/iiTBXMytWTZQU29N7FmDM=;
        b=gxSfIjzJgF4o6hdReIGjdG8oDb8YMY+FvG9DOf48gJS/uXUgVgdRBxWOyIbIwZURQ6
         qqlLtGy9beddY4617elmaPql81XYUQ8zxW7WylayUjuELQrLfAH6Ort+7wOGubNRvfjs
         vPUnouklFBiwE0tQK5VjdKd6ndIr8to+h+Q9RDGQzK+DZDXTIUQ1jVsZKarH3Pku08RX
         2QvOPHNXoyjvlv7ryV1D7SN/jNZctB6mPECftJZV3hBBGOiv7QrR0qAJLqP8YAr1Kln/
         XVdozh/5IpjZyWV41qXtrBGwBcWg4aLtVJRCcZRZeIvobORm50LcEvt3gPIPCgI5UMbS
         PLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688069099; x=1690661099;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OF3SWHQBitllVPlaYnVLF/iiTBXMytWTZQU29N7FmDM=;
        b=k+JTjnfwWKHeSx7+oAb9x8/wMml+UfiHwZW5x1Fg9UwlWXLn8XrasdVwwycskOD1oi
         DikP1Ve7T25AxW1cszPpmZjhsvJ0NUAOyHnIrfpQPct8p7eBiTR198RjWE7r3XM0Fl66
         2f1aVlmxXYyU7sVz52xG2R8Dqyh4k8NdxSrXSMc2HVRcpDgaasJUyby8KXgICMmVnFCO
         EY88A/BR+h5hNOelnDovYrAqWOUf6RT+kWCbN3nBqUnF56zdfA/Um0NSnpCAgNW+vEtm
         cbBwI6hx+3uZiJpZlUMkTsYGWm18DLdB3hEDZim0DDVp9PleV/m4ExdnW+sGTtrHkJ1z
         GD8w==
X-Gm-Message-State: ABy/qLa9V3VtLXY47ko2piJTXFu7vaope7IlqNNPeqnmGJ1nfP+GUAhi
	/EAM0JSxBbwJcCVlckSwDSRHDQ==
X-Google-Smtp-Source: 
 APBJJlHCImMszh08qroN+ScqTvW+Lm4kzbNBHCoakjGE3swSx6rZ5XyHj9KuN68oeeMW8B9bxhKuoQ==
X-Received: by 2002:a05:6512:693:b0:4f8:6d9d:abe0 with SMTP id
 t19-20020a056512069300b004f86d9dabe0mr365281lfe.33.1688069099306;
        Thu, 29 Jun 2023 13:04:59 -0700 (PDT)
Received: from [192.168.1.101] (abyk82.neoplus.adsl.tpnet.pl. [83.9.30.82])
        by smtp.gmail.com with ESMTPSA id
 k28-20020ac2457c000000b004fb9fbdd8fcsm207623lfm.252.2023.06.29.13.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 13:04:58 -0700 (PDT)
Message-ID: <ef515514-43e8-e4c9-e013-09aa27bc2110@linaro.org>
Date: Thu, 29 Jun 2023 22:04:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 08/11] dt-bindings: usb: ci-hdrc-usb2: Fix handling
 pinctrl properties
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: cros-qcom-dts-watchers@chromium.org, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Benjamin Li <benl@squareup.com>, James Willcox <jwillcox@squareup.com>,
 Joseph Gates <jgates@squareup.com>, Stephan Gerhold <stephan@gerhold.net>,
 Zac Crosby <zac@squareup.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Xu Yang
 <xu.yang_2@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Wesley Cheng <quic_wcheng@quicinc.com>, Jun Nie <jun.nie@linaro.org>,
 Max Chen <mchen@squareup.com>, Shawn Guo <shawn.guo@linaro.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vincent Knecht <vincent.knecht@mailoo.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Konrad Dybcio <konradybcio@kernel.org>, alsa-devel@alsa-project.org,
 iommu@lists.linux.dev, linux-usb@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Leo Yan <leo.yan@linaro.org>, Andy Gross <andy.gross@linaro.org>
References: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
 <20230627-topic-more_bindings-v1-8-6b4b6cd081e5@linaro.org>
 <20230629152335.GA3055525-robh@kernel.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230629152335.GA3055525-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: J72BYMMEUZQMIYK6IR6R3WQIGYBAKZDP
X-Message-ID-Hash: J72BYMMEUZQMIYK6IR6R3WQIGYBAKZDP
X-MailFrom: konrad.dybcio@linaro.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/J72BYMMEUZQMIYK6IR6R3WQIGYBAKZDP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 29.06.2023 17:23, Rob Herring wrote:
> On Tue, Jun 27, 2023 at 06:24:24PM +0200, Konrad Dybcio wrote:
>> Untangle the bit messy oneOf trees and add the missing pinctrl-2 mention
>> to handle the different pinctrl combinations.
>>
>> Fixes: 4c8375d35f72 ("dt-bindings: usb: ci-hdrc-usb2: convert to DT schema format")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  .../devicetree/bindings/usb/ci-hdrc-usb2.yaml      | 27 ++++++----------------
>>  1 file changed, 7 insertions(+), 20 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
>> index 782402800d4a..24431a7adf3e 100644
>> --- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
>> +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
>> @@ -199,17 +199,6 @@ properties:
>>        In case of HSIC-mode, "idle" and "active" pin modes are mandatory.
>>        In this case, the "idle" state needs to pull down the data and
>>        strobe pin and the "active" state needs to pull up the strobe pin.
>> -    oneOf:
>> -      - items:
>> -          - const: idle
>> -          - const: active
> 
> These are no longer valid values? The description still mentions them.
I believe allOf: now covers them all?

> 
>> -      - items:
>> -          - const: default
>> -          - enum:
>> -              - host
>> -              - device
>> -      - items:
>> -          - const: default
>>  
>>    pinctrl-0:
>>      maxItems: 1
>> @@ -357,17 +346,15 @@ allOf:
>>              - const: active
>>      else:
>>        properties:
>> +        pinctrl-2:
> 
> This should be implicitly allowed. Is it not?
No, it errored out for me.

> 
> I'm reallly at a loss as to what problem this patch solves.
Specifying all 3 pin states is impossible with the current state of
this binding, even though it's a supported configuration (check
qcom/apq8039-t2.dtb). I should have been more clear in the commit
message.

Konrad

> 
>> +          maxItems: 1
>> +
>>          pinctrl-names:
>>            minItems: 1
>> -          maxItems: 2
>> -          oneOf:
>> -            - items:
>> -                - const: default
>> -                - enum:
>> -                    - host
>> -                    - device
>> -            - items:
>> -                - const: default
>> +          items:
>> +            - const: default
>> +            - const: host
>> +            - const: device
>>    - if:
>>        properties:
>>          compatible:
>>
>> -- 
>> 2.41.0
>>
