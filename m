Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E39C55ABF
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2026 14:40:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3091660240;
	Thu,  6 Aug 2026 16:40:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3091660240
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786027215;
	bh=HvOaSyaubcWGnvu8G7COzydNX4gVIagbZo6JUJnP/jE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Zs3MVzsCTq+Q9WKVSffyLXvejJNagU2FyM75/l3MfyJH3O2wpDpKjOzuqROyZlbg9
	 sxFs32l/qpCQeUe4e21CNBj7K6dr+3Yzz+5aQqFrN4wMOvwZx/I27wbQnhz+VZz36N
	 9ZGjptpuWmGbmVJg8oMiI1llwwASlEYrb1gQ4GnI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E334BF8061A; Thu,  6 Aug 2026 16:39:29 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 56542F80620;
	Thu,  6 Aug 2026 16:39:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0E603F8027B; Wed,  5 Aug 2026 13:36:51 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785929809;
	b=YP6zpaylcgEEZJvi3VG/oqCn7WwIBRxMEsQcXfQ0+weDTNTTJE+tUzWXydsyNAtVCnqy
	 nLbytuYNNFn+bHlGDEPuUmAMmAiFbkH/g2AiyrdZVp2pFEwf3JRew4SUB/U3nhwzIMA7y
	 qEJ2ONNLweQmEVttPvJFZRG7UxEMnV38LSV4IwfFcN2dulPqXM4QyK4rie2VsohpQN1e3
	 8SUhrATjPpbu6f1fqRBGDahEylFrBD5h6qJbC4K/Q4IozHw6vb/ncRkPj+8j/TTrkTMrN
	 PvWkqjJYWKy7ftJw3LaqUC/J1H3XU+C5QlIiTpgH3qJGAuepXhqhaKLW+ULCkFDdkxQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785929809;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=HvOaSyaubcWGnvu8G7COzydNX4gVIagbZo6JUJnP/jE=;
	b=P3WP75yuxxVHe5vpOPAFM91mrvmLgur9BGkyKR8RIfbJpoSB2Q/VwuBXeDZHlqSN011U
	 lz7mGtYxXVspEDpfSmT7Lo6KxdH3OrEWTMQphT5zwms3QViyIcucj2VwYmYfduRmI9ewn
	 Ch35KyWCiDBKqBPbEZ21k7XAbNKT6UD0ueAc6gCX4OG1YF0V6Wg4YfrlWOwJYzL4DJpon
	 rBoGhy8QQzMd9ExgrGO11wRD0jeO8IFOaP6FzwyeWRWHZ0MFmT1UhF+PZugIOgpv+ZImo
	 rMDIKZMX0AhuSUtqN8waQ8Xqcy9/CzY9qXOAc667oQdhi4+rf6UgZg4sBWYAHW6Zpsw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=E8oqaoaQ;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5C3F1F80124
	for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2026 13:36:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5C3F1F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=E8oqaoaQ
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-38e347638adso920739a91.0
        for <alsa-devel@alsa-project.org>;
 Wed, 05 Aug 2026 04:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785929806; x=1786534606;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5l7FenGvrQnRcqxVxpQbcS8hPgr2hqhc1H3dtV5WU08=;
        b=E8oqaoaQd6KyYs9UZeEZ786kkeFTSrRqM/LEhxKYYg5LNCGibDtvHGGd3GgThtyie5
         dQ9oiSvgEVPuivjUMe8REIeHD4YE9grX+dO5diIckZKfc0D1al9qqEpA5MEhlqWrcduD
         aQMpO6lpDtYTWKzd/1AA1CpSdAG2LZZ1HRbs665NuoZ0KkkDE1mOUy2eaBSqZlvHagMP
         jdT2US27JbVKvcPypPhgR87Z9fVYTiyMP58OPUYve66cyJwwheU8+YXNPffosI7nlbwX
         QF9loFCVH9gGHqyFixiSajJjBB88TD4FQctznvPyN4oISL56ONDAKj230TNn9IucQGGw
         BS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785929806; x=1786534606;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5l7FenGvrQnRcqxVxpQbcS8hPgr2hqhc1H3dtV5WU08=;
        b=mQk3noEJjsBCr+/BqeHJ3ZDWkfpNlcuBwP3eHc9H6S7UjvxQ6enIlojwo1fzFKRklU
         IwoexLIuC1XOh8E4xtiYeXM5lHuly3KpjMHBsJ+Wdk0GIClhvAh/O7tuOGT84Il6sjSx
         Oh+Rw9b8SRpe8GHfTNx5SIL7p6czRrUFy3evzxywoPAJ108RrLPiNYeK7dmEcUDZvrjX
         PQIVSQsaGjFTE5S20qu8JJ2ee3Wo0WBxUmdhq4a5hIK0t6/RIbFBRKVDohnmod7o+UrY
         93XpPsSF5PGS/RI/6Azblnc0/2H9mL6v4ESlTr5g7MrnoaWS1Cv1LjZWKcv+C//92NFs
         /ILQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqVqmNhSrTVmmSA6n2pAyt3Csal4Tl/SxJLmkcYyJEebUhNKQV0S2ko68z0nG6s4gIXnk22j0rx26oq@alsa-project.org
X-Gm-Message-State: AOJu0Yzdnnt7BKXCIhr04qgwfGdWbuTVYHG0Hs/T96lc3Jf1H7vu6vxV
	ZWrw5iCsfEkCwyqSh7f2BopTZyU5KoIA8Qoona3/ueJK5gk7j5EATzoj
X-Gm-Gg: AR+sD129Q2C8JnI0kwHmKjfWlLf1rRUC8gLBQ78JWAnt+ziTr8u78XZPsdZCbLzvwzA
	TiJF4VqZ6QP5Y5KdBhFhmqaGYuVFzvm5dMKVG+nAj0KeDdjbc/B1K52BvzvNfoDJvS3EzhEuOrQ
	8EfQ2pX4uiUmrUTFO8dyMNZlfHLwY9D0rlDu2RGy8rKMuIxNv0X9SmkWIz1/s+b5oo1h5Jto8vR
	veBzduPKsHvhJyAXZYQezwWQ6O/IOCLy+7n8SlzqvYOXnmbkIvmyoWkfDLLhOdjtQBSN76XOxC/
	8hnKHOHLu6514DOx2nGWvwFat/+BOLvQbcT679RrJgFntV2LrzAlR9ILPAmGR5Vj/Ro0pXn+xsc
	3fjjU0LtYrdxVRQG64JKowt+2h39+upaGH/Q2KbOlqWX95s1ZcyrF4uNxtSAhGX+kiCyUDO/Kvc
	fQEYpt4tLQPa3LPGS8TrD3pWhv6Xt61XMzgVndC5jRmIekYa3QHtJ1iwYsm0XylAm/H7jxsjT98
	l3v9tvsdHO4//YjOtxKQtHAqWoouxwDXbuxpJUr2iY=
X-Received: by 2002:a17:90b:6cf:b0:380:7688:fbe9 with SMTP id
 98e67ed59e1d1-3903c559075mr6498561a91.8.1785929805614;
        Wed, 05 Aug 2026 04:36:45 -0700 (PDT)
Received: from [192.168.1.110] (111-243-10-58.dynamic-ip.hinet.net.
 [111.243.10.58])
        by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3903927db6esm2893962a91.10.2026.08.05.04.36.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 04:36:45 -0700 (PDT)
Message-ID: <79bc356b-e727-7e40-9faa-e622c9a24ee9@gmail.com>
Date: Wed, 5 Aug 2026 19:34:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 2/2] ASoC: codecs: nau8360: Add support for NAU83G60
 amplifier
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: Neo Chang <YLCHANG2@nuvoton.com>, lgirdwood@gmail.com, perex@perex.cz,
 robh@kernel.org, krzk+dt@kernel.org, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kchsu0@nuvoton.com,
 sjlin0@nuvoton.com
References: <20260804032951.1069901-1-YLCHANG2@nuvoton.com>
 <20260804032951.1069901-3-YLCHANG2@nuvoton.com>
 <479efa04-2c02-4b5d-8fdd-e3d4c6e49c4f@sirena.org.uk>
 <7691eac8-5798-c1b5-5ffd-19c780b69a3f@gmail.com>
 <fe60dbe2-0626-4d52-8be3-62445a35ddaf@sirena.org.uk>
From: YLCHANG2 <neo.chang70@gmail.com>
In-Reply-To: <fe60dbe2-0626-4d52-8be3-62445a35ddaf@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: neo.chang70@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: O3EOSI7KU54VBOFOPJMS4FBSX2HIT52X
X-Message-ID-Hash: O3EOSI7KU54VBOFOPJMS4FBSX2HIT52X
X-Mailman-Approved-At: Thu, 06 Aug 2026 14:39:23 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/O3EOSI7KU54VBOFOPJMS4FBSX2HIT52X/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On 8/5/26 18:30, Mark Brown wrote:
> On Wed, Aug 05, 2026 at 05:03:01PM +0800, YLCHANG2 wrote:
>> On 8/4/26 23:58, Mark Brown wrote:
>>> On Tue, Aug 04, 2026 at 11:29:51AM +0800, Neo Chang wrote:
>>>> +	switch (clk_id) {
>>>> +	case NAU8360_CLK_ID_INT:
>>> Usually we don't have a lot of fine grained control of the internal
>>> clock dividers of the device, things are a lot easier when the device
>>> just figures out what it needs based on it's input clocks.
>> To make sure I understand: Should we remove the internal clock IDs from
>> set_sysclk and handle clock configurations automatically inside the codec
>> driver?
> That's ideal.
>
>> Does this mean we should avoid configuring them via the machine driver
>> entirely? If so, what is the preferred way to handle clock fallback when
>> playback stops or MCLK is absent
>> (e.g., via PCM shutdown hooks or DAPM events)?
> What do you mean by clock fallbacks here?  Presumably there's some clock
> still running, if that's the only one running it's reasonable for the
> device to switch over to it.
By 'clock fallback', I mean switching the clock source back to the 
internal clock when the MCLK stops, in order to keep the DSP alive.
