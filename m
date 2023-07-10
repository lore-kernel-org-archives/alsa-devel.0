Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F37EB64DA
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Jul 2023 15:34:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B63A6203;
	Mon, 10 Jul 2023 17:33:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B63A6203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689003270;
	bh=/Nhh6CNgOPOLlNknULlhicVqhTi0E7lOobdqH1gzezo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ao+oC2oDuiZIC7PNIre+I9TDW9KV/IdOSfFmbxjJBpdy1jxI6qmmWAliyX/Fk37cP
	 TWk3lTBsb1W9pA1gBisUDuy2UPSc1rVr24totMOLH7a1yRv+m8b7oG+IKfbmBgs6xc
	 NTNSQumEw2hway3xvEehGz9IXga8OYsMe7zgiPs0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 83151F805A9; Mon, 10 Jul 2023 17:32:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F2930F805AB;
	Mon, 10 Jul 2023 17:32:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 80C50F80249; Mon, 10 Jul 2023 05:23:10 +0200 (CEST)
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CFB4BF800D2
	for <alsa-devel@alsa-project.org>; Mon, 10 Jul 2023 05:22:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CFB4BF800D2
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id E952A24E023;
	Mon, 10 Jul 2023 11:22:51 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 10 Jul
 2023 11:22:51 +0800
Received: from [192.168.125.93] (113.72.145.114) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 10 Jul
 2023 11:22:51 +0800
Message-ID: <d046796e-34a0-56e5-a740-6a1fcf41d216@starfivetech.com>
Date: Mon, 10 Jul 2023 11:22:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 1/5] ASoC: dt-bindings: Add StarFive JH7110 dummy
 PWM-DAC transmitter
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Mark Brown
	<broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor@kernel.org>, "Walker
 Chen" <walker.chen@starfivetech.com>, Xingyu Wu <xingyu.wu@starfivetech.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC: <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230626110909.38718-1-hal.feng@starfivetech.com>
 <20230626110909.38718-2-hal.feng@starfivetech.com>
 <006ddacd-0496-70d1-3310-99b16706de84@linaro.org>
 <0312262c-28c0-9445-c6f7-2079a57db8c7@starfivetech.com>
 <c0244a98-4c91-93d8-a3e4-5210d0b3f205@linaro.org>
Content-Language: en-US
From: Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <c0244a98-4c91-93d8-a3e4-5210d0b3f205@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.114]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-MailFrom: hal.feng@starfivetech.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: D5TDMRC4LBDG5TTAMKXKHORT2TH766J7
X-Message-ID-Hash: D5TDMRC4LBDG5TTAMKXKHORT2TH766J7
X-Mailman-Approved-At: Mon, 10 Jul 2023 15:32:12 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/D5TDMRC4LBDG5TTAMKXKHORT2TH766J7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sat, 1 Jul 2023 10:17:51 +0200, Krzysztof Kozlowski wrote:
> On 30/06/2023 03:57, Hal Feng wrote:
>> On Mon, 26 Jun 2023 17:34:56 +0200, Krzysztof Kozlowski wrote:
>>> On 26/06/2023 13:09, Hal Feng wrote:
>>>> Add bindings for StarFive JH7110 dummy PWM-DAC transmitter.
>>>
>>> ...
>>>
>>>> +required:
>>>> +  - compatible
>>>> +  - "#sound-dai-cells"
>>>> +
>>>> +additionalProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    pwmdac-dit {
>>>> +        compatible = "starfive,jh7110-pwmdac-dit";
>>>> +        #sound-dai-cells = <0>;
>>>
>>> BTW, I don't see any resources here. Neither in the driver. I think you
>>> just added this for driver, not for a real hardware.
>> 
>> Yes, this is a dummy PWM-DAC transmitter as described in the title. The
>> StarFive JH7110 PWM-DAC module doesn't need a hardware codec, but a
>> dummy codec is needed for the driver.
> 
> Bindings are no for drivers, therefore with such reasoning the answer
> is: drop entire binding. If you think otherwise, please give me some
> more details about the hardware.

I agreed. I will drop this binding and the compatible in patch 2. Thanks.

Best regards,
Hal
