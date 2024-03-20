Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132E0C54E67
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Mar 2024 20:30:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 27D5E2232;
	Wed, 20 Mar 2024 21:30:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 27D5E2232
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1710966615;
	bh=sibqcgVk69cAWwUp5fELHFPqFKZCzweuaYfOTBxCD6o=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Dh5hWf73aHt2Uwxa1p5A6oZw6blQ4avncpB5bbqUX4pCCBu71VbWJqAGlNU6QWo+g
	 FD63yrz1bkP+7zTg6UiFox/p7abZpYIJK+BJVskgse3IBN/jVjy00T6qbltLYCobJ+
	 LUcXhhu9hlOszmRENvEPZQ5ZrM94Xj7h41nsG+PY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0AD48F805A8; Wed, 20 Mar 2024 21:29:37 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 256B4F805AB;
	Wed, 20 Mar 2024 21:29:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D0FC3F804E7; Wed, 20 Mar 2024 21:29:27 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 38957F8025F
	for <alsa-devel@alsa-project.org>; Wed, 20 Mar 2024 21:29:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 38957F8025F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=T5Led9Vh
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-513e134f73aso371695e87.2
        for <alsa-devel@alsa-project.org>;
 Wed, 20 Mar 2024 13:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710966556; x=1711571356;
 darn=alsa-project.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dvd7/K/iPH6D09kkHMbkBRJCLxovJRz+5X5JeM9cC40=;
        b=T5Led9VhjNlK12lrE4kCh1cM2q8toop1GWUHzzC+5boy1X/fEJshy1p702jqIyx9R1
         gkxV71ajq4i3720sIbwRXMF/Pj8Ocu4f0f8YsOj+hHSRPeJy6kdsj+oWuprvzkAt1L7h
         fiLBShYymdlWtFQwEF9tdpwFJmf6Vn3uZwCYELtvMweCVE82zo3bCfd8wL7NrqhSuQfZ
         G8YxLB2fLJl0ESfRBsK1VSvm6xIREGf/tVzl1TNTziVBHs8yCOMoAak+rEyqx14PNM3+
         VAyJgNuZBIlpQlVZw0BNB7OzRQGUsXei701ionAtHDBYkyP78RFrz1s8A6lYnheXw1bm
         94/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710966556; x=1711571356;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dvd7/K/iPH6D09kkHMbkBRJCLxovJRz+5X5JeM9cC40=;
        b=iYm4wHU7FTcqsvG/j+5UwIEHl1qU51b9u++UnYCsGNZnNYgybDX6+FnJmapDvX36A6
         ja01vO1efcvz5Tuu64WXKp1bbqh6sbA470Gx7yO4nhxMdwUhcrjNh4elVVnHljssi/xj
         SnC1QwSziRNGmz+FJ7Eq3VJ4dPKiOsqRF9OFxn3cn5SKaO/L4PGrAjpKLR+IEq/BmsCI
         fW6IAVLd3p0RyKmuRYPmXVFNsfvZT/8U9oML0QJXiMnlBS4EAuLuqdI0u0etawkehJw3
         r/hjKDVJMrNRa5QhpLwITTyE/+jdkqB6PeMCZInz740JDCrl2Tn4C0WaptbvILHIwkTF
         IaOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN1VaiDKMC8Ah677AyT+NOan3xdwMs3XIZhmsagx47kFLVWSuyC4pJb4dQMngN0nsVmS3RstoSxbxMWkbuSUT0IC2+t+YC1/5oYAw=
X-Gm-Message-State: AOJu0Yxd0QIfKU7LOASgSCxEuZqZCGAswAkwt/tPt2RVDKeVsaIOBd8k
	NlKBaO1EB3BVfSV7+7cd+nUqEhdp5LLQ+4Mi8CdicD+NSwZyVXnB
X-Google-Smtp-Source: 
 AGHT+IGeAB6MCS1rA/ycdxQ22gDA1FTucn7CNo0Yl14vI1V2G3iGJZh5xoX+yAWkcX+Cye2/GFrHmw==
X-Received: by 2002:a19:f803:0:b0:512:ed8e:97ce with SMTP id
 a3-20020a19f803000000b00512ed8e97cemr5087582lff.16.1710966555838;
        Wed, 20 Mar 2024 13:29:15 -0700 (PDT)
Received: from [10.0.0.100] (host-85-29-76-118.kaisa-laajakaista.fi.
 [85.29.76.118])
        by smtp.gmail.com with ESMTPSA id
 q5-20020ac25145000000b00512e594e235sm2348058lfd.242.2024.03.20.13.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 13:29:15 -0700 (PDT)
Message-ID: <d20dc37c-13fa-43d1-af52-dce8d8dcdd75@gmail.com>
Date: Wed, 20 Mar 2024 22:30:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] ASoC: ti: davinci-i2s: Opitonally drive DX pin
 during capture streams
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, herve.codina@bootlin.com,
 christophercordahi@nanometrics.ca
References: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
 <20240315112745.63230-14-bastien.curutchet@bootlin.com>
 <00182d1d-ef29-457f-9e3e-6e9b57592118@gmail.com>
 <0bb26153-8bcb-475f-8892-5eb925fec538@bootlin.com>
 <7925bbe5-17e8-42cb-a5f0-4f3e06810a90@gmail.com>
Content-Language: en-US
In-Reply-To: <7925bbe5-17e8-42cb-a5f0-4f3e06810a90@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: JW6QMNWCXU55UJUCONNHIP7GNHSSMRHQ
X-Message-ID-Hash: JW6QMNWCXU55UJUCONNHIP7GNHSSMRHQ
X-MailFrom: peter.ujfalusi@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JW6QMNWCXU55UJUCONNHIP7GNHSSMRHQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 20/03/2024 17:42, Péter Ujfalusi wrote:
>>> On 15/03/2024 13:27, Bastien Curutchet wrote:
>>>> The McBSP's DX pin that outputs serial data during playback streams can
>>>> be used during capture streams to repeatedly output a chosen pattern.
>>>> For instance, this can be useful to drive an active-low signal during
>>>> captures (by choosing <0> as output pattern).
>>>
>>> Are there really any other use of this than to pull down or up the DX
>>> pin (0 or 0xffff)
>>
>> I don't know, indeed today I can only think about these two patterns.
>> I tried to do something in a 'generic' way so it can evolve if needed.
> 
> I think the definition of the 'ti,drive-dx' is somehow odd. It allows
> you to set it to 0x1234 and the DX pin will show 0x1234 when you capture
> 32bit. If you capture 16bit then it will transmit 0x12 (or 0x34?), no?
> If you have 4 channel capture then I won't speculate what will be on the
> DX pin ;)
> 
> Would not be better to say that the DX pin will be driven low or high
> during capture _and_ disable the playback support?

After some thinking, it might be still better to use the DX pin as GPIO
and either have a custom machine driver which would handle it (set low
when a capture trigger happens) or connect it in DAPM as a supply, bias
or something and ASoC would handle it automagically.

I think that would be cleaner in many ways. What do you think?

-- 
Péter
