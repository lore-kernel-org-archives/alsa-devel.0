Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF924C47074
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Jan 2024 18:56:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9FB15FCB;
	Tue,  2 Jan 2024 19:56:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9FB15FCB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1704221799;
	bh=aNHG+3Rg310j3tyqCxmCNGKsKxUy8R8S47O0UX6UTrQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ZRhU46Q3NfGDXm6EwqIr6iYrBmH1VQxMm3WwXNqpg5TZ8V0g2lu33pD7NzQiNM7f/
	 7k7u6yF/TLQ3CzvrmczfUDp0OnnDjQfETMkihpBkOdIN6v9c9OOeLkBu12v/BrVt3G
	 3UQ5dyz//q/G3fKhg2k9i/Q1q6TNoFFLU9TfZCPI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 791E9F896CC; Tue,  2 Jan 2024 19:51:07 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0360EF8962D;
	Tue,  2 Jan 2024 19:51:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 725FCF8016E; Fri, 22 Dec 2023 11:04:42 +0100 (CET)
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 33ABBF800D2
	for <alsa-devel@alsa-project.org>; Fri, 22 Dec 2023 11:04:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 33ABBF800D2
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id 69C3B24E2E1;
	Fri, 22 Dec 2023 18:04:30 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 22 Dec
 2023 18:04:30 +0800
Received: from [192.168.125.131] (113.72.145.47) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 22 Dec
 2023 18:04:29 +0800
Message-ID: <20c29117-2e4c-49c6-a90f-27ec507914ff@starfivetech.com>
Date: Fri, 22 Dec 2023 17:56:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: ASoC: Add Cadence I2S controller for
 StarFive JH8100 SoC
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Claudiu Beznea
	<Claudiu.Beznea@microchip.com>, Jaroslav Kysela <perex@perex.cz>, "Takashi
 Iwai" <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor.dooley@microchip.com>
CC: Walker Chen <walker.chen@starfivetech.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>
References: <20231221033223.73201-1-xingyu.wu@starfivetech.com>
 <20231221033223.73201-2-xingyu.wu@starfivetech.com>
 <2e74c513-40de-41b7-ba86-c5b345344ce4@linaro.org>
From: Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <2e74c513-40de-41b7-ba86-c5b345344ce4@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.47]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-MailFrom: xingyu.wu@starfivetech.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: JT7OFON6RCGVL3GFGQFN6DJ5TNEZRCH6
X-Message-ID-Hash: JT7OFON6RCGVL3GFGQFN6DJ5TNEZRCH6
X-Mailman-Approved-At: Mon, 01 Jan 2024 13:18:25 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JT7OFON6RCGVL3GFGQFN6DJ5TNEZRCH6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 2023/12/22 0:07, Krzysztof Kozlowski wrote:
> On 21/12/2023 04:32, Xingyu Wu wrote:
>> +  dma-names:
>> +    items:
>> +      - const: tx
>> +      - const: rx
>> +    minItems: 1
>> +
>> +  cdns,i2s-max-channels:
> 
> Custom properties after generic, so after sound-dai-cells. The coding
> style now mentions this.
> 

Noted.

> 
>> +    description: |
>> +      Number of I2S max stereo channels supported by the hardware.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 1
>> +    maximum: 8
>> +
>> +  "#sound-dai-cells":
>> +    const: 0
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - resets
>> +
>> +oneOf:
>> +  - required:
>> +      - dmas
>> +      - dma-names
>> +  - required:
>> +      - interrupts
>> +
>> +unevaluatedProperties: false
> 
> This is not correct without allOf: which should point you to missing
> $ref to dai-common.

Will fix.

> 
> 
> Best regards,
> Krzysztof
> 

Thanks,
Xingyu Wu

