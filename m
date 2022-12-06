Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D69C352A1
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Dec 2022 09:17:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C933217C5;
	Tue,  6 Dec 2022 10:16:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C933217C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670318228;
	bh=K4JlnXTyZc7ANIrM2XjOy0isfMgbzX9qEt6WNEu1vLs=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z+ybQxSjXFHrdW1PfebapIJ7aEZXsyeUMN6tpcGMYLMP49QeqRbedfA9dErcZA6qa
	 kCiHN1eA93M95+iq2NvQztQ5raBcJ53cuALWzmFK/n/V7Z+RafCC8/j5QQ51U5jSQI
	 rEsqIEqG9/UKXS/sAK4RDUQVmSEnayUSjRClUuaU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 887E3F80155;
	Tue,  6 Dec 2022 10:16:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1E56CF8014C; Tue,  6 Dec 2022 10:16:17 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CCDC6F8014C
 for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2022 10:16:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CCDC6F8014C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="bF7aDatV"
Received: by mail-lj1-x22a.google.com with SMTP id a19so16560466ljk.0
 for <alsa-devel@alsa-project.org>; Tue, 06 Dec 2022 01:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nSz8+pdzVOvO17mmGP1PwKitaiaqBA0sMFckD9UpIz8=;
 b=bF7aDatVUWwwHFmYq8p+W4TB9+kDOfdUJgkLUAEalM21QMbDFEPI1W1nnH+5/Y/jKH
 zHjgOiwFTzniV9CrNh1lMlnmhL4Vuo9XhdXvJnBwX91UmAI9DeX1ket72WcxUYyxBD+N
 2rMaYpDsSEVHHbYj1x57wfg4bUwPFFEK0yrWD3MZTiaZgKfsXKZv/uw0j3eXg7VsvP35
 aLL1meaCDJdkEgFOn2al3FRv3Mo63jXDIGbiy3o4MghtDitEuFV4iAvFjsEcdeqnp/bg
 VVfW/IyQ2oIph+wPv4fgyDExBk1aMzJMqO4H0ZFDE/WnXMfMAlZl/9fr9pJpIHtue+0K
 5xow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nSz8+pdzVOvO17mmGP1PwKitaiaqBA0sMFckD9UpIz8=;
 b=Tw//HsUp15yn6yHau6E0l8ZjoM5SphkxLWfKaQxkPwtwTKZ+ETOI+/SEHzj44Vqk1m
 f5zfHVcn2X10n2a7v/fwld8c1zYDgi8fcEgQ1w8E4GrVZMJtHaMLoWC58CS8xa0Tq3PC
 0puR2v9k096M9nnmTHYt8dXpIVAIpIeDKPpChBHoHn3wdBEdrOC+rSu3jqJGOKeVIe37
 UfrSZMRfm2dQ8S4g1Z72u9YcmCgQGy2G9YVsrivQjV4ckHoz4+/M1NpBvlFefmZVyLkI
 KWGeb3AKNxee7DTvgiyAoeYVLB62gVzaU0wfsNZC18IH7qWdmw98Z1dUqmZSu0CspEVY
 QvcQ==
X-Gm-Message-State: ANoB5pkNWHHHsAj4mDUqjGFxUDzdKnBDEygbRx/sOsCVMYAhk9ZFkFhx
 Dzy4Vzb40FfpHNqUQ5S7rdOBFA==
X-Google-Smtp-Source: AA0mqf52hPel6Y7yp0GvQe24wYR3MQwPfgyyDGxL0XTTjSrgY2kcLkcne0d6WDnxB9zk3iTNPDFRlw==
X-Received: by 2002:a2e:c52:0:b0:277:9bf:9411 with SMTP id
 o18-20020a2e0c52000000b0027709bf9411mr19869694ljd.504.1670318168431; 
 Tue, 06 Dec 2022 01:16:08 -0800 (PST)
Received: from [192.168.0.20]
 (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
 by smtp.gmail.com with ESMTPSA id
 b26-20020a2e895a000000b00279e0b8bae7sm1077010ljk.65.2022.12.06.01.16.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Dec 2022 01:16:07 -0800 (PST)
Message-ID: <0565a333-3bb7-89db-735d-56006405bda4@linaro.org>
Date: Tue, 6 Dec 2022 10:16:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/2] dt-bindings: sound: ti,pcm3168a: Convert to
 json-schema
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
References: <cover.1669980383.git.geert+renesas@glider.be>
 <9f2a2474ec71dcc2a76e868295202a8c425a5d41.1669980383.git.geert+renesas@glider.be>
 <b105572c-96fe-dbad-c435-43233cfb25a7@linaro.org>
 <CAMuHMdXG39BoMScDpH_Cxc-BXBKZHxyQqe6MJMEhnerN3yU6Uw@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMuHMdXG39BoMScDpH_Cxc-BXBKZHxyQqe6MJMEhnerN3yU6Uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Damien Horsley <Damien.Horsley@imgtec.com>, linux-renesas-soc@vger.kernel.org,
 Mark Brown <broonie@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
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

On 05/12/2022 09:00, Geert Uytterhoeven wrote:
> Hi Krzysztof,
> 
> Thanks for your comments!
> 
> On Sat, Dec 3, 2022 at 1:13 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>> On 02/12/2022 13:55, Geert Uytterhoeven wrote:
>>> Convert the Texas Instruments PCM3168A Audio Codec Device Tree binding
>>> documentation to json-schema.
>>>
>>> Add missing properties.
>>> Drop unneeded pinctrl properties from example.
>>
>> Thank you for your patch. There is something to discuss/improve.
>>
>>> +description:
>>> +  The Texas Instruments PCM3168A is a 24-bit Multi-channel Audio CODEC with
>>> +  96/192kHz sampling rate, supporting both SPI and I2C bus access.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: ti,pcm3168a
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    items:
>>> +      - description: System clock input
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: scki
>>> +
>>> +  reset-gpios:
>>> +    items:
>>> +      - description: |
>>> +          GPIO line connected to the active-low RST pin of the codec.
>>> +            RST = low: device power-down
>>> +            RST = high: device is enabled
>>> +
>>> +  "#sound-dai-cells":
>>> +    enum: [0, 1]
>>
>> This is a bit unexpected. Looking at DTSes:
>> 1. I see in ulcb-kf.dtsi with cells==0, but two endpoints. The dai cells
>> seem unused? In such case shall dai-cells be skipped if we have endpoints?
>>
>> 2. in k3-j721e-common-proc-board.dts has cells=1, but user's phandle
>> does not have an argument, so practically it is ==0? The user -
>> sound/soc/ti/j721e-evm.c - just gets the node and does not use cells,
>> right? So even though dai-cells==1, it does not matter, because user
>> gets its own parsing?
>>
>> 3. The pcm3168a driver also does not have any xlate function, but it
>> registers to DAIs, so all uses should be with cells==1 to select proper
>> DAI...
> 
> I have no idea (DAI is magic to me), and hope the audio experts
> can provide some input...

It is a bit of magic to me too. Yet I think the correct usage of this is
with dai-cells=1. I think we can skip the choice here between
sound-dai-cells and endpoints (to allow only one) and only fix the value
here to =1.

This would also require changing
arch/arm64/boot/dts/renesas/ulcb-kf.dtsi to dai-cells=1.

Best regards,
Krzysztof

