Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA67EB64DC
	for <alsa-devel@archiver.kernel.org>; Sat,  1 Jul 2023 08:20:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6C4D27F1;
	Sat,  1 Jul 2023 10:20:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6C4D27F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688199653;
	bh=z0ZgAL5A7HA4xoobPsuNePtSqdALgWmCYu3Ls/Zov9s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=lSycOUf4yMeCy2CdxdspJZ5xjUcwZO4fBXSUmQEMt5XqxG7W+7vRwAAayM+3wKHlp
	 0kdeFUZb+qJcmaa9/yA43L5CJiSodsDQNDrTXK3Sz9e0hA3edFzZsq0QtI6NaiMBkx
	 YDWYuBwKmWkHLITdNRfluGIppSFhjG4BPQQfsbtE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C097BF8027B; Sat,  1 Jul 2023 10:19:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 798EAF80246;
	Sat,  1 Jul 2023 10:19:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A5481F80246; Sat,  1 Jul 2023 10:17:58 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0DF27F80169
	for <alsa-devel@alsa-project.org>; Sat,  1 Jul 2023 10:17:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0DF27F80169
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=hZ/FFeqa
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-51bece5d935so3179409a12.1
        for <alsa-devel@alsa-project.org>;
 Sat, 01 Jul 2023 01:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688199473; x=1690791473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nFUtqRuFYxZPNfD4i3kr3X3ptU2+o2FOiAEweLLRh0Y=;
        b=hZ/FFeqa4g54JerJ53qoyxU4QTmUnUf0v73u41e+vOdiGZyUnWeNIEbTY9zWw4XMQw
         zX2EuskfWe+XkRlT71jQ/Imrl935VrguDYwH/WJAC6FgSzab8UDCYWrLrjfpaV5+mcEx
         4vjRkfjXAzH8mjoZyJvU6x0Ms+Qxl+jZqu9S7m3AQtatRtdY4C3jxzFPj1iNK9j7tvsj
         fiS79qaZO6xV8jW4vvzP6xdrGYKSsjN4qM4hv01/6t6X6bNKti8xozXaZAEsDIvpgXT5
         CEP1COSjeAsWkkylM7qBrO5SfimMr8i59FAO7XMV/o8vqa2s1MfsNPE+6Xqc69fDc5C1
         C7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688199473; x=1690791473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nFUtqRuFYxZPNfD4i3kr3X3ptU2+o2FOiAEweLLRh0Y=;
        b=ZCX64AzmHa3ciukxkzbpCoEg4Q4ZVAqXlToP5R8gHyaPxEiawWQUF2q42kbCsK6oaW
         VxgAICs55H6oFTW4QMl/kXXg6Lyqxdp8LdufzhlwpRqiDY1jYOrwr2HLcTDBuONx/7iB
         5tEdhPAy/yzqNdmxMfYMF9DCdHYv235Hv83JRdz5CcwEr04s1RN2bluW25Ls5ZAzt3pW
         Jet9ahfhPMYLOV9l5VbV2GUwv0Vw8HeakwfNdaK/p53RTcOuQdqmn3yYSB7UNFQ1I3Ya
         qubfoSdg0rlHfpp+Fjcp2kbMcERjTN9ANpj/Mc/BwRn8zFMGj2d6+GMrW+a3LRL8TjQk
         6+DA==
X-Gm-Message-State: ABy/qLZ5ix3PGU2uTSPes7VSoaeFQdPKIoWSz406f7RiXFqpN1d2ZXuB
	MImbKsIC4kg37NcePqKQd54o5dMu9urq2Ouukvo0r8M9
X-Google-Smtp-Source: 
 APBJJlHl6fEgoqPBsy1ZFFH2uK0Gpmfi0RiZj0Uiu8sQs4UkbbfdT3pVNRrhM6i2vh5cofEh0GFVtQ==
X-Received: by 2002:a17:906:3650:b0:974:1d8b:ca5f with SMTP id
 r16-20020a170906365000b009741d8bca5fmr3422697ejb.9.1688199473199;
        Sat, 01 Jul 2023 01:17:53 -0700 (PDT)
Received: from [192.168.10.214] ([217.169.179.6])
        by smtp.gmail.com with ESMTPSA id
 jj25-20020a170907985900b00992b1c93279sm2693469ejc.110.2023.07.01.01.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jul 2023 01:17:52 -0700 (PDT)
Message-ID: <c0244a98-4c91-93d8-a3e4-5210d0b3f205@linaro.org>
Date: Sat, 1 Jul 2023 10:17:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 1/5] ASoC: dt-bindings: Add StarFive JH7110 dummy
 PWM-DAC transmitter
Content-Language: en-US
To: Hal Feng <hal.feng@starfivetech.com>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor@kernel.org>, Walker Chen <walker.chen@starfivetech.com>,
 Xingyu Wu <xingyu.wu@starfivetech.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230626110909.38718-1-hal.feng@starfivetech.com>
 <20230626110909.38718-2-hal.feng@starfivetech.com>
 <006ddacd-0496-70d1-3310-99b16706de84@linaro.org>
 <0312262c-28c0-9445-c6f7-2079a57db8c7@starfivetech.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0312262c-28c0-9445-c6f7-2079a57db8c7@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: SW74M4VJFLVA6OFZRNIGNWASCFDAAAM6
X-Message-ID-Hash: SW74M4VJFLVA6OFZRNIGNWASCFDAAAM6
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SW74M4VJFLVA6OFZRNIGNWASCFDAAAM6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 30/06/2023 03:57, Hal Feng wrote:
> On Mon, 26 Jun 2023 17:34:56 +0200, Krzysztof Kozlowski wrote:
>> On 26/06/2023 13:09, Hal Feng wrote:
>>> Add bindings for StarFive JH7110 dummy PWM-DAC transmitter.
>>
>> ...
>>
>>> +required:
>>> +  - compatible
>>> +  - "#sound-dai-cells"
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    pwmdac-dit {
>>> +        compatible = "starfive,jh7110-pwmdac-dit";
>>> +        #sound-dai-cells = <0>;
>>
>> BTW, I don't see any resources here. Neither in the driver. I think you
>> just added this for driver, not for a real hardware.
> 
> Yes, this is a dummy PWM-DAC transmitter as described in the title. The
> StarFive JH7110 PWM-DAC module doesn't need a hardware codec, but a
> dummy codec is needed for the driver.

Bindings are no for drivers, therefore with such reasoning the answer
is: drop entire binding. If you think otherwise, please give me some
more details about the hardware.

Best regards,
Krzysztof

