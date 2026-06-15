Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94325CD98C7
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Jun 2026 10:59:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6E5996013C;
	Mon, 15 Jun 2026 12:58:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6E5996013C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781521144;
	bh=VjrgEW5Pqjix5ZZy/LLAPgYsKbIfPhYYjQJdMexb7fs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VsHGc67elZwllCmN5qOr13wVobVjHKPoKfyI6nQkVqew0slgCw9ViWu8viFWVrTM1
	 8sFKtUGVu93ox+Yp4qsdaCUx9Xyx9ImxUr3S3/k9C3XpgN5895mZLMAefH1GL3AczZ
	 a2DnKU/20o3b0kBOgOxpi4pMS808uVYlKqSm7KuE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 616F6F805F7; Mon, 15 Jun 2026 12:58:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 119F8F80601;
	Mon, 15 Jun 2026 12:58:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 478F4F8047D; Mon, 15 Jun 2026 12:58:24 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781521103;
	b=O3qWbTf/s23W9BeYpkx/gktQs3EaPemdtRWp0+iAwk//xzZxOcfUTFvBzcRi7k5QCSuB
	 2tnMZ8wMz4XyueDJ628ux4WdWnOCl99Ez3dWLBMA6UEVzZggXdhTLaBr258wvAnzh+phx
	 GEhpMJsB/BxMXFU7UMAd/9qV/XsN+cCHix8bo9tS8PIYX5/dpk9Qgo56JDUL2lW8hJP8v
	 g7v7MrDvBavs5ix0RmXFm2WFiSF/VK4urn/TjMknJ8TBiVizXxFURG4sfKDNDv6Ui7R8r
	 C4JGX2epF6+45VNi3NT7Cl+UykptYNxkHllYrnfACWhgr5Akw597SFu5AO2zstQCTsg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781521103;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=VjrgEW5Pqjix5ZZy/LLAPgYsKbIfPhYYjQJdMexb7fs=;
	b=ryfkbKHXakW4PY7R+IzkuhDMsqrSuDO35KYNt5Q0YY4eMHDZL5d+WHr0Cohx6/U2/aCW
	 J033X2+Xvw1Rx60V4Neg07L7UtxupP/6t1XvSSVwGZFHw1BRIJ8vTzTJp64ze2zZE2AMg
	 fa1DZBddZJJi24GcSVYR3fNzCY4e95vMv+tmsVXSzneaKctY2WZLUo5IEilpxr6r66q9P
	 o/6J+kKuXG1nifkkkeEjSMd9Be7Dbzi2PBxi8BGMYvVQ7spAO5RkL0Qxg57MmBpkO2FCn
	 Yits8diS0S5wJLiJEA4i5xXODVe+jZa0XzUmvXam+eXVN2L8px8gaGyQhPxYrRVRAfw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=YlkDCYFM;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 64470F8010B
	for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2026 12:58:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 64470F8010B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=YlkDCYFM
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0358F6008A;
	Mon, 15 Jun 2026 10:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101FD1F000E9;
	Mon, 15 Jun 2026 10:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781521099;
	bh=LuKeEn5cNI6llmnwlNvGXwwBfqGQwoSmAXWxDCHvQkE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YlkDCYFMHSP92k1XPHrp4BoKUIvIxnDvbbeRBejCRdf9n8eMjgGjsLWbffXAX7pCM
	 vw5T/uZ1hJ7zQwJFZSCpgvnRO9Hzz9MxdAz0bYTeNHGzenrdl8fvmHRF+TJe7VZVvb
	 1xIeMUJTlcEbkU4Uh/VHGoeu6uypJTu6VV8dsBGCvt7GMvdIxuhEGqhaRMRJtQJb7S
	 tGOdAj2wA3atGWiOKCGXAopiPKOrupPjPaaPzvd4Zv3a8EGUtPfL1mXG6KJuKEucvG
	 +X/f/UHosxm6Nnk5V9AkPMjRrEOmH3I4Kg2oE+nAww9tHra50L7orHoKDw6WlYs2A1
	 a1udBPQN1g7zw==
Message-ID: <992b1fa0-650b-4a60-ad55-206cfcf1c892@kernel.org>
Date: Mon, 15 Jun 2026 12:58:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] ASoC: dt-bindings: ES8389: Add members about HPF and
 clock
To: Zhang Yi <zhangyi@everest-semi.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 tiwai@suse.com
References: <241d0fab-26ea-4c06-9928-e256f2cc5d1c@kernel.org>
 <20260615101423.19781-1-zhangyi@everest-semi.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20260615101423.19781-1-zhangyi@everest-semi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: WHYGMAINA6SI3LUZ4K3LP3GSNPKV3X5Y
X-Message-ID-Hash: WHYGMAINA6SI3LUZ4K3LP3GSNPKV3X5Y
X-MailFrom: krzk@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WHYGMAINA6SI3LUZ4K3LP3GSNPKV3X5Y/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 15/06/2026 12:14, Zhang Yi wrote:
>>>>> Yes, setting mclk-from-sclk does not affect the MCLK connection.
>>>>
>>>> I am asking about wiring of the device. If MCLK is used from SCLK, but
>>>> SCLK is used as the internal clock, then how can you still have MCLK
>>>> connected?
>>>
>>> If MCLK is derived from SCLK, whether the 'MCLK' pin on the device is
>>> connected or not has no effect on operation.
>>
>> If MCLK is connected, why would you derive it from SCLK? That's the
>> point - your clocks property already might be telling everything needed
>> here.
> 
> This is because sometimes the codec does not work properly
> when using the MCLK provided by the CPU.

OK.

> 
>>>>>>> +
>>>>>>> +  everest,hpfl:
>>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint8
>>>>>>> +    description:
>>>>>>> +      the HPF value of ADCL.
>>>>>>
>>>>>> Is HPF value in dB? If so, use proper unit suffix and proper units.
>>>>>
>>>>> No, the values here correspond to the values in the registers.
>>>>> The value is not in dB
>>>>
>>>> What are the meanings of the register values?
>>>
>>> The value of everest,hpfl is equal to the value of the corresponding register,
>>> not the cutoff frequency of the HPF.
>>
>> You keep avoiding answers.
>>
>> I don't want you to encode standard units as register values.
> 
> I think I understand what you mean.
> Do you want me to enter the physical values in DTS and then convert them to register values in the code?

If you have clear physical values then this should be rather used in DTS.


Best regards,
Krzysztof
