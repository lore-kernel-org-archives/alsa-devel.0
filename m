Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22F7CD5BD1
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Jun 2026 08:10:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CD1C16023F;
	Mon,  1 Jun 2026 10:10:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CD1C16023F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780301448;
	bh=9ueTTfsQM7Cuw9fsa2Mw5zy14prrsOw1dfrs93kRZHI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=QHoPrGtDKBA3dztbZMh2TzplS2LfhOTiwRD6OpNLZb+RiSIz5x+4ogI9Nrm7O9Lq1
	 ebzXmn0OIgQbHuLs0EuoOFU26o9pSTSATr5MaaYAPbuBxmMZfBYfb6PVKjMB/Jl3Ol
	 eU5aooyTSbzciFcOgDxOb2vxtw1+0MxBOAIhEbRo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CD673F80635; Mon,  1 Jun 2026 10:09:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A7D1F80637;
	Mon,  1 Jun 2026 10:09:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8E1E5F804D6; Fri, 29 May 2026 10:49:23 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 573D3F801F5
	for <alsa-devel@alsa-project.org>; Fri, 29 May 2026 10:49:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 573D3F801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=pOcsRO0U
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-3665a90bcd3so14318363a91.1
        for <alsa-devel@alsa-project.org>;
 Fri, 29 May 2026 01:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780044557; x=1780649357;
 darn=alsa-project.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QhjoroGKXf9Vnwm4rb6qgzeF8DBjHLvOxd0WaalRzBk=;
        b=pOcsRO0U8R2/tGwDM37xaZ63cgrnhhlMQ8d+RxMB9fU9NIiiR0sCEjBjEitscXDGmk
         DGU90PjIqBnwra64lfrvMSNrg8kqzlh+gap6/F72/vb4eemszglga5dx0ykhMngXjhSR
         dyjJfkipT9MkBt9vx/noRVGXX+FLjbPAEVd2YG9DJGyAUBPdlC8uj6JvELZCZm6pMYg8
         U6COxdnrBPiFpNvHZY5tEeN0PmGXJji5108B3CUvTiLWbgup7yZvJDDlAVoWWvJKjMRy
         MPS7Of3hz3h5TnvmMqCx2BOGXIX6984aBCvYsTFb7diNqz93mAxrsIe+neogmn9nd/Tv
         sRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780044557; x=1780649357;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QhjoroGKXf9Vnwm4rb6qgzeF8DBjHLvOxd0WaalRzBk=;
        b=Vgy06BXSX5mVgr+mPwXMo2k+cpdKuvvh2gGkxxnBOIqIUvri1Tzlu3odA1HUUy2sai
         WmOwqsbQJ74nnPI7a8Lbqj5aRgx4VtmBnopcEv++hvOAz1S5LQDmU5piWIaMVACyQ2MB
         LjwD1RSpZ9uoY4JZm6+rGxtserJZG9QYOFjfobEqPNF2yJXOo8X4zq9SKsSNc22WM33u
         QIJP07kcLPtbQYvSGLjK7TL3ivd4pTyU94JFOkd7+KyFDrTIipLAXR+ypCTYaMOPCJ0m
         gI7E06dJK9mbiHN+ni0s9leldR/g0zKXfGdpGNkDvP/DwcGpIxxuNpJ0n4s1wxqbtiYG
         7Y/w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+YV5Nq9C+KSKhBtIVZVmMkFeUwVjaG2AFe6pZ7PVhc64A00bb7lUPSj4ty5H89LvRoVCfG083i02Om@alsa-project.org
X-Gm-Message-State: AOJu0YzN/Kg51OGkEOHykQNRQxgmLqq4ffBGPj3teDITAuUt8fFvJge+
	oDlO56p/lorz7Tium23fFBtAQCowp6khtkrWS9E9prhMBOBEBYhE0CE7
X-Gm-Gg: Acq92OGfgsEqmGEUcX2CfmOU+PMQuj/RcabCAQL8zJ+e4fqrqggjhfsxRPeZeyeqbQu
	djNJN0gLI6lyjoGOjJErD7fosr+7PbbLm+hzUJHX4ye6xzuFRKGpRMvICBJeD313C/tlAWZUjhq
	X7K+ZrsogP5bHLxFcu7OykNdmoSS7TVvL/J7Kw0bhpUOe5QylJl6LqdV4KzZtN1VH8rnu7c2FqY
	J4B5KnL0hZoc3bS0irRYvlY8Wqrx54H/YVe/dSlJE4PxfQnboaKotz5KcpMEfAScwzgZsQjOqNu
	FyE/+0IZIcrrbPQvYv7LdacgQ9DDZFTA2bIw/EzVjIvK8bbqG81ftTxwnf86hMpj+3O73l4V12l
	ixkhEr5+y9/4HofJenx4k9ikq/iOSep19BIvHu3GTfCYMX3vCsddl2SCiU8qlp1cEML+4aoX72M
	BZqpR8KloGnmwAi9Zv9/hHfJuRpmtFDgNUy1tgn1Vcu4IzC+bOPYoaTddfcfBPeQjrgJSA
X-Received: by 2002:a17:903:32c7:b0:2bf:2e06:2ebf with SMTP id
 d9443c01a7336-2bf2e062fb8mr2415555ad.31.1780044556442;
        Fri, 29 May 2026 01:49:16 -0700 (PDT)
Received: from [172.20.10.2] (42-79-54-216.emome-ip.hinet.net. [42.79.54.216])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf23a21f0bsm10975345ad.34.2026.05.29.01.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 01:49:15 -0700 (PDT)
Message-ID: <1d7a01aa-dd65-129a-c9ac-e24e9b474f8e@gmail.com>
Date: Fri, 29 May 2026 16:49:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 2/2] ASoC: codecs: nau8360: Add support for NAU83G60
 amplifier
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Neo Chang <YLCHANG2@nuvoton.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org, krzk+dt@kernel.org,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, kchsu0@nuvoton.com, sjlin0@nuvoton.com
References: <20260526015826.440769-1-YLCHANG2@nuvoton.com>
 <20260526015826.440769-3-YLCHANG2@nuvoton.com>
 <d4cf4ad9-82fb-4beb-be5b-b3687f822fcf@sirena.org.uk>
From: YLCHANG2 <neo.chang70@gmail.com>
In-Reply-To: <d4cf4ad9-82fb-4beb-be5b-b3687f822fcf@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: neo.chang70@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: PIIYQ7EWV6TWGGPUV63WCB37ZOV72ZN7
X-Message-ID-Hash: PIIYQ7EWV6TWGGPUV63WCB37ZOV72ZN7
X-Mailman-Approved-At: Mon, 01 Jun 2026 08:09:50 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PIIYQ7EWV6TWGGPUV63WCB37ZOV72ZN7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On 5/27/26 21:43, Mark Brown wrote:
> On Tue, May 26, 2026 at 09:58:26AM +0800, Neo Chang wrote:
>> Add support for the Nuvoton NAU83G60 audio codec. The NAU83G60 is a
>> stereo 30W+30W smart amplifier with an integrated low-latency
>> Advanced Audio DSP.
> A few things below, you also have a bunch of what look like legitimate
> issues picked up by sashiko (some of which overlap with what I've got
> below):
>
>     https://sashiko.dev/#/patchset/20260526015826.440769-1-YLCHANG2%40nuvoton.com
Regarding the sashiko report, I have a few questions:
Are we required to address every issue caught by sashiko? We found that 
some of them are actually false positives.
If we need to explain our code regarding sashiko's findings, who should 
we send the reply to?
Additionally, is there a way to run the sashiko checks locally before 
submitting our patches?
>
>> +static int nau8360_peq_coeff_get(struct snd_kcontrol *kcontrol,
>> +	struct snd_ctl_elem_value *ucontrol)
>> +{
> ...
>
>> +	snd_soc_component_update_bits(cp, NAU8360_R9D_PEQ_CTL, NAU8360_HW1_MEM_TEST,
>> +		NAU8360_HW1_MEM_TEST);
>> +	for (i = 0; i < params->max / sizeof(u16); i++) {
>> +		value = snd_soc_component_read(cp, reg + i);
>> +		*(val + i) = cpu_to_be16(value);
>> +	}
>> +	snd_soc_component_update_bits(cp, NAU8360_R9D_PEQ_CTL, NAU8360_HW1_MEM_TEST, 0);
>> +
>> +	return 0;
>> +}
>
>> +static int nau8360_peq_coeff_put(struct snd_kcontrol *kcontrol,
>> +	struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	snd_soc_component_update_bits(cp, NAU8360_R9D_PEQ_CTL, NAU8360_HW1_MEM_TEST,
>> +		NAU8360_HW1_MEM_TEST);
> ...
>
>> +	snd_soc_component_update_bits(cp, NAU8360_R9D_PEQ_CTL, NAU8360_HW1_MEM_TEST, 0);
> We use an rwsem to protect the controls from userspace so we could get
> more than one caller in these, you need some driver local locking.
Got it. I will add local lock in v4.
>
>> +static int nau8360_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
>> +	unsigned int rx_mask, int slots, int slot_width)
>> +{
>> +	struct snd_soc_component *cp = dai->component;
>> +	struct nau8360 *nau8360 = snd_soc_component_get_drvdata(cp);
>> +	unsigned int tx_slot_used = 0, rx_slot_used = 0;
>> +	int ret = 0;
>> +
>> +	if (slot_width != 16 && slot_width != 24 && slot_width != 32) {
>> +		dev_err(cp->dev, "Invalid TDM channel length: %d", slot_width);
>> +		return -EINVAL;
>> +	}
> This stops the support for disabling TDM from working, a slot_width is
> required here.
Got it. I will fix this in v4.
