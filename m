Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF00CD8CA8
	for <alsa-devel@archiver.kernel.org>; Sat, 13 Jun 2026 07:38:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F2F0D601EF;
	Sat, 13 Jun 2026 09:38:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F2F0D601EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781336322;
	bh=qLJW6iZI+DbYBLSHpRvh1fHoPbFOfRR9v4LVQsoegAw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BhS++lINigUMcFOZ1vFlF2QOISiWSbtD8gJXJSGqVx1nKs3n7K1WEaKvntPEaLhoj
	 b6v26JVHaJa/kFbEIT5CVyCB8Ftw5okzWveqW2pXhwgqXgAaxmud4k/L6trfiPuFkl
	 gI8WMbEhTK60ZjzpyTGk4kL9ez36t+ULVH+QB3Pc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B9F2DF805FF; Sat, 13 Jun 2026 09:38:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 48AFFF8026D;
	Sat, 13 Jun 2026 09:38:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 56202F804F2; Sat, 13 Jun 2026 09:38:03 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781336279;
	b=kg7/w04RTucz5fr6YZUfV+nlW2w7QDCnLmMlVpYV964EIUbB2UTjH64wDAau86nocNYb
	 O0FhP5UqYJjwgbdLlB0QiGdhSztXJ2cVn+k4WEzN6brqqIyHxXbS2z37FFwOVXREECrvx
	 LzB1YD98jzioB+K8wKG2p3433ZzP1PWKAPdFV16TVmu7bjRJchggmfrmGUO5r5WNZR7/S
	 qCZ1L+o5gVJXXYJvOQKy+4HLf90aZ4vMsXSRPlM2q6u+18DaMOG1CYJvY0dcxMF6617md
	 f2PueGJFYyn8YOwfNoF9cmWhwVzBtTYELVoaRl12OxJ/58HaNpaf5FfeuBMuk9WMiUA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781336279;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=qLJW6iZI+DbYBLSHpRvh1fHoPbFOfRR9v4LVQsoegAw=;
	b=S7Er3L9LTiEx7uJOS2F608EaCOWfraHhOnkCKnswmFQit/0f7nQo6sep3F7Ae2Dzkwaa
	 D0qDWXYVqkNPKeg7USwq2VZIfhCDCIL5JW9GQc8+L1f9GG7xeC8iUlX9KlezAY5UzrtBu
	 vZSNZh5R/idrWEpElAq83/3TB40i7p6eBVDuEPUkzQt9pUjuPZ1Uw28aOolCetQxGGW6H
	 25FvqaomR3UToEzhWVB9qZjwf8KPUrdmJ18t4ju2mo4CNd8J1XPSUd3GcRoN5TB9NugaH
	 xKno6E3c5r9oSlyzDjQJB7r5yfh1laIz2p7/xdzKThMrftofwa6rZDf26szYKRhrblQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=laJLiSKE;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CAB0CF8015B
	for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2026 09:37:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CAB0CF8015B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=laJLiSKE
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3D58343934;
	Sat, 13 Jun 2026 07:37:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3A81F000E9;
	Sat, 13 Jun 2026 07:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781336274;
	bh=tQSHJmp7JNCNmTswMfi2HcByw7yaz6k/MRHxiY6lZ/A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=laJLiSKEjRcTGpq9l4JAC/T0gQMV1SJ3WPcE4IRUYz/377NwZcop85p4yPBpYxDav
	 DU+TwaWLv0I7bcXMUubQ7Bli+4KZJdqfOkxsYdE6xOyUTyVmoBlXY2Ql0M36oRKwT0
	 l1UYFO/VhCpjxiaMwXlsUsujkR0F3onuH6s4nLPFXCs0nbjh6MXIsEE8APPXGVN2Mh
	 R5SZlGu/rhV0JwXHvvpfoNeVM+16olk6Rai5+bez1lPBl/T5DK4z4rndk8rNmUrFwG
	 QUCrxR01y1aupwI5fqOVXb7brHoN3ey5lS65TuCAHjyBgDXR9Mk0iFXUzeAEAAznDh
	 kTkt+1PPuCXbA==
Message-ID: <fa710884-e66e-4ef8-bbbd-034eeef8ee62@kernel.org>
Date: Sat, 13 Jun 2026 09:37:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] ASoC: dt-bindings: ES8389: Add members about HPF and
 clock
To: Zhang Yi <zhangyi@everest-semi.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 tiwai@suse.com
References: <20260609-vociferous-thick-lyrebird-d53eda@quoll>
 <20260610095820.25386-1-zhangyi@everest-semi.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20260610095820.25386-1-zhangyi@everest-semi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: 6KCKVY7WDDCQF5RRRMYRF3HNMNLFO7YK
X-Message-ID-Hash: 6KCKVY7WDDCQF5RRRMYRF3HNMNLFO7YK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6KCKVY7WDDCQF5RRRMYRF3HNMNLFO7YK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 10/06/2026 11:58, Zhang Yi wrote:
>> Please organize the patch documenting the ABI (DT bindings)
>> before the patch using that ABI.
>> See also: https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/devicetree/bindings/submitting-patches.rst#L46
> 
> Thanks for the reminder
> 
>>> +  everest,mclk-from-sclk:
>>> +    $ref: /schemas/types.yaml#/definitions/flag
>>> +    description:
>>> +      Indicates that SCLK is used as the internal clock.
>>
>> And what happens with mclk in such case? Is it still wired?
> 
> Yes, setting mclk-from-sclk does not affect the MCLK connection.

I am asking about wiring of the device. If MCLK is used from SCLK, but
SCLK is used as the internal clock, then how can you still have MCLK
connected?

> 
>>> +
>>> +  everest,hpfl:
>>> +    $ref: /schemas/types.yaml#/definitions/uint8
>>> +    description:
>>> +      the HPF value of ADCL.
>>
>> Is HPF value in dB? If so, use proper unit suffix and proper units.
> 
> No, the values here correspond to the values in the registers.
> The value is not in dB

What are the meanings of the register values?

> 
>>>          vddd-supply = <&vdd3v3>;
>>>          vdda-supply = <&vdd3v3>;
>>> +        everest,hpfl = [0a];
>>
>> <0xa>? What did you want to say here?
> 
> I just wanted to give an example to show how to set the values of everest,hpfl to 0x0a.

So use syntax I asked.

Best regards,
Krzysztof
