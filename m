Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292F5CD5BD1
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Jun 2026 08:10:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DA971601D3;
	Mon,  1 Jun 2026 10:10:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DA971601D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780301431;
	bh=0pbmQ8x+4jkjdTH1lwE4m2tQBElxZ0ixePvmyrKwvMo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=dizygxIzmYerVWhGQf0ai5tbnAkzEtgeZ7rcyZ6y1f/ZL4G2lJINVB01budgMvpb6
	 9mAAMPvxxw8tN9QzdoZOVbhyu6ZOL6dWxN7yApGfVZxFxh6ym7lZaTwIw8o+z9jUOn
	 O60JQmJW7D0vwAIxklqv/DG4r6pnuwiUzgS0751I=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A3FF9F8061B; Mon,  1 Jun 2026 10:09:50 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 606CDF8060D;
	Mon,  1 Jun 2026 10:09:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E1CC3F804D6; Fri, 29 May 2026 10:49:00 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 16C3CF8003C
	for <alsa-devel@alsa-project.org>; Fri, 29 May 2026 10:48:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 16C3CF8003C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=dpf0ISVq
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-36ad15213fbso3207527a91.0
        for <alsa-devel@alsa-project.org>;
 Fri, 29 May 2026 01:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780044537; x=1780649337;
 darn=alsa-project.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zu4woSO4TBEOYZHa/WNQ9LLC4/vLLUP8Ms3Ns6fPdiY=;
        b=dpf0ISVqHauIcZegAc840k//28lO5fbe2y7k0aQUsDZm28TJeupCLTKLZESW0U4I1y
         WPcGwOhL97N/G2H3GEjP2Tkx6PmiMf/iifRAK9xuO8kVbtAD2wjAYX8MSfb+iAxXHMk4
         HHj9VgDLKz/9/mgFhV6nZcpJGJTBYWreB2iH1wJZM8GE6dfbk99t1Y0rKuu5yaONWXZU
         SJf3K81axiZoPEw1d3kzdiRBpzacRf5VaOjhZzRg/nTkpfbaNgc3qmhTovksIQIrWbDn
         zNv7Fxxk43/VivUDe33BX7maBF9a2mJXbTGuA+sZEgD2ohSPLSlSkqOja4gDv++W4lW0
         No5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780044537; x=1780649337;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zu4woSO4TBEOYZHa/WNQ9LLC4/vLLUP8Ms3Ns6fPdiY=;
        b=VaRSsHRKGRPs9M5UIFzIyOonOTT7TMlEpQoK6u08cd2RVcpuqBnfX5F0zJFBypsg2b
         YFIBBPnNurBKbeTbgnNcuGKI54JOdXY5jqIkiDf3eldYt8r7c73D68gBJnkUHk/LoTb+
         MmDHe90hJ/o4nWLe5B4xbh+mkESi8asK6X0LzbKUQVcdC1Gi1htHWdKR8Zi68wMxzPEg
         gg6Bs8+zOkT7bw98r3YMCzfnsYUFSJw2jp0Tfz95fP3n/lidBb/+cMw49y/1fc++VIL5
         ZxfQid0RHMujYNurLqS2jRHGwaOMbNLQRfVsUgTNo4b6WF1bE+rOIkVEU+emEsgjWYOV
         0ogQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Givus2jFOcBzJ2BvcA4jZwdwTiQiHrwRvpl5AaGBZTmxtPAsBW7Q1TuBLOSVH6bOclRiGOCIldBko@alsa-project.org
X-Gm-Message-State: AOJu0YxaB2Fx7ark4vNfTtjFhyF92Ycyp1eVy9MjywPGGDvUarTROILR
	XEz7wKysP2h24POHugzYY7KBSMgnPkitr/NT5GZau8rWTUwFlLIXsZhw
X-Gm-Gg: Acq92OGrbt6LufML+Zx4mlZW5dkp/m4/w7CxeipsxBDErzKDxoj3gbVZaVB9UJKDG8h
	EKqJBFs2iZJu1LdU5zIqoihETaHFLCGJG6QIm/OzXw3wZfPxRxEAVpWqNH1r9r9lx406HVrwZG0
	8wL5rs1DkFZvL/jS6Pv4PU/NcVd7o4Qz551MMGERm0SmH1kruKL9bQP8x+oeovhxlN6m2NYT0qY
	GX20yfzvjGWQbCh/nLuZpZ/XKGaP1AAMuk/eU8ZzAcF+G7MBqgSwoEqq19R2VRGxgQ9MyuCfvO/
	I3lw4B6fBFypYfVZ1FAEdBOs/0kyuxDZ3W/5Vjpom9uJDtfFEKhVlrmP+m2dyoae2DuM6AA7X+p
	yZlg8lUnuK26Oe9XHFdvYYbRW24a2goK3/vqfX7N6Dxl85a3qaL+L9oYYbdlJ0VS3W8yezk8tL+
	SGTeDFtD3HlPfVybdX+G/Fbafm3nAy7QUm3pmMTJFHAO93c+QpCPVmsplaDEJWpyi3iVWB
X-Received: by 2002:a17:90b:3a50:b0:36b:769c:e5bb with SMTP id
 98e67ed59e1d1-36bbcc145cfmr2354489a91.5.1780044536629;
        Fri, 29 May 2026 01:48:56 -0700 (PDT)
Received: from [172.20.10.2] (42-79-54-216.emome-ip.hinet.net. [42.79.54.216])
        by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36bc0befe7asm1448578a91.11.2026.05.29.01.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 01:48:56 -0700 (PDT)
Message-ID: <b2e7738b-28b2-6b6c-6a7e-0649f42f5b85@gmail.com>
Date: Fri, 29 May 2026 16:46:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/2] ASoC: dt-bindings: nuvoton,nau8360: Add NAU83G60
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, Neo Chang <YLCHANG2@nuvoton.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org,
 krzk+dt@kernel.org, linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, kchsu0@nuvoton.com, sjlin0@nuvoton.com
References: <20260526015826.440769-1-YLCHANG2@nuvoton.com>
 <20260526015826.440769-2-YLCHANG2@nuvoton.com>
 <20260527-pink-cockatrice-of-expression-04b6e0@quoll>
From: YLCHANG2 <neo.chang70@gmail.com>
In-Reply-To: <20260527-pink-cockatrice-of-expression-04b6e0@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: neo.chang70@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: XDGG7DXGDXMKIDFPRPJR353W7SABQIQC
X-Message-ID-Hash: XDGG7DXGDXMKIDFPRPJR353W7SABQIQC
X-Mailman-Approved-At: Mon, 01 Jun 2026 08:09:45 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XDGG7DXGDXMKIDFPRPJR353W7SABQIQC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On 5/27/26 17:15, Krzysztof Kozlowski wrote:
> On Tue, May 26, 2026 at 09:58:25AM +0800, Neo Chang wrote:
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    const: mclk
>> +
>> +  nuvoton,dsp-bypass:
>> +    type: boolean
>> +    description:
>> +      Forcibly disable/bypass DSP path.
> Same questions as v1. Properties are not to control your probe() in the
> driver, but to describe the hardware.
>
> You have entire description or commit msg to convince that previously
> questioned property is still reasonable in terms of DT.
>
> OTOH, isn't lack of firmware binaries enough to deduce that DSP is not
> going to be used?
Got it. I will drop this property in v4. As you mentioned, the firmware 
presence is enough.
>
>> +
>> +  nuvoton,pbtl-enable:
>> +    type: boolean
>> +    description:
>> +      NAU83G60 supports PBTL mode for mono output.
>> +
>> +  nuvoton,dac-cur-enable:
>> +    type: boolean
>> +    description:
>> +      Adjust DAC output current to match speaker impedance and prevent
>> +      hardware damage. +3.2dB when present, 0dB by default.
>> +
>> +  firmware-name:
>> +    minItems: 2
>> +    maxItems: 2
>> +    description:
>> +      Assign firmware filenames for left and right DSP cores.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +allOf:
>> +  - $ref: dai-common.yaml#
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        codec@1a {
>> +            #sound-dai-cells = <0>;
> Please follow DTS coding style.
Thanks for the suggestion. I will follow dts-coding-style.rst in v4.
>
> Best regards,
> Krzysztof
>
