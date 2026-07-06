Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75779C43458
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:30:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 06FFE6021E;
	Tue,  7 Jul 2026 16:30:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 06FFE6021E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783434636;
	bh=3M4AFgg5AocNGF3AzQgibwDCAQy05KMhECy7Mmf5/bs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=jipyrhQ/F17d16JguPGItaPY07Fg8yY4pwag/Td5YWQBo6x6bzZF+l8tzauFeFW6j
	 CK09f/LpURKwNAiMvj3xEmXwmPUsi6XYE9Ra1+bCfRWjgioF3saVj5ZQhlYWZZ+sGu
	 IjBHdmF2HHgmgZtvbnb5ng3T1ycxR3fayA8yntzE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 099FBF80614; Tue,  7 Jul 2026 16:29:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CDC92F80611;
	Tue,  7 Jul 2026 16:29:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 06D6CF80524; Mon,  6 Jul 2026 05:25:36 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783308334;
	b=REg0czN3KN/kWie5Ukh6D+mBV4kLJa+y8KQl20u71flW/fNhf7vcw3tNNMvf/OD09kmR
	 Ely1RJdwF8iqI8MVVjHYo1gIkR1BoSq4ZxqJHCtIk63GI5VAh8KABo3fXiEGlxLHe0Hhp
	 9SVHZ3K1DQvl/7dWU/VpkNBuMFd3T2xulfcShVTDM3qfnTSsi4fMwHxF4WDtZmEVuTyRP
	 zuoujQS5nL3bshZzqGc3ys3HkKo59vhChBB3mmQteo0ARQ+OVfLau/Stw3OBbT6pOWX4/
	 M2S9/nROT/oBvUqoJK/PTzEMxVV1+mPFmsAualAzOsemMU9EkT258CHxGrmXaDZ5/yQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783308334;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=3M4AFgg5AocNGF3AzQgibwDCAQy05KMhECy7Mmf5/bs=;
	b=dw9s32LDbuff3aQ930Uw96YkdH+bKhYLPvuLP7IVI4lUyFq0XmbZIERG6JVUwpvyGxb2
	 havfMF/upy7ZG6VIz5dRFJfkb7JocRoIu+JtsLZ/NfpfBwyH5pQdxnzBVVqASgX0GISM5
	 CTFfwX0wRFcpxOSJRHA4tqagmfZ3F+XqcrjOMLkJLQaIJUsaQvv04dqyXJ91Jd+G9SbQu
	 FDBzj9pmzw19cILhYnSItVmpSp816AeEkwfBr0XtAMK7YrHDYEAZTYE5dcxv8iPIf9kBc
	 CnI0IkLMDOXVYH/3C1iKz+IuM+5IkiqMsPplK5X8psN5Xx928vp5JHl2mk+b2w0/L8A==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="cmIhaIg/";
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B0A7EF8047D
	for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2026 05:25:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0A7EF8047D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=cmIhaIg/
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2cc97653887so6736775ad.1
        for <alsa-devel@alsa-project.org>;
 Sun, 05 Jul 2026 20:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783308331; x=1783913131;
 darn=alsa-project.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=alpVrOd6n2aWZg+GKi3BWfgonMarNUPCjsDlmyEHlpk=;
        b=cmIhaIg/dhzn+7xrTxHGQqxvUEfhFkllo5QrqUtWE3jnLvPL7ljG+gcWp30EZ+vH1j
         9SSIc6KkGywB0DBeUogE1hntFdqq0y+eCrPC4FuyrEYzE2sjP39ZgZ9yU/F+xqBQLFx9
         oA3X03MWp2nv2lCz1BSuNcMUPpfuAtFgohhjj42giD5+dGXTYkvqt/YDalnFe1dzAzXN
         0IDkEvit9N5yZnZoJioWBj2/ewArePy7P+l1PVQxEHBe49Tbc0mSQWMIGjfFHqPYGG4B
         S9rkjBQ9BKcapNT0oENBCpiKfQGHVBTJnuGK4f9lS8hK5l9No5dacZnPOpNXDwUVmfrB
         sJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783308331; x=1783913131;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=alpVrOd6n2aWZg+GKi3BWfgonMarNUPCjsDlmyEHlpk=;
        b=kX9bSKaf9w7WvIQkRguXTL09RAcFgbqIN1AB2Is+WWJ01Zy2nJ1oOYq5arFuxzhdKY
         dwKGvEh1ptZO2+RWtuX91hj6k5xZtaCcv88XSvLWNKgE+5DYQduWjvd/aCGEJRhdVsq7
         7VQHGPZqjPTEwrzXx7bg+L/TbF4hZFQ/6X2MmNgrAHlWeDgLdETb6tVzuRcNWyZYncE3
         Hf5rvrk+PYFdbMitgnnU+zbDdrfBzfEzjFZJxG4c8C5GMEKx07paoSmYpbBDKlXX72jW
         Nnh55Yhu7ETKfolDiMSEnnhiKUljySAzantqbV0sAr+xf+EtjRzZwy1eoUJ0im4Cwz4q
         tatw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpbs6nZolXthfzQQxck/JJN2YybCPljdQ+MXVTCTh3g4KYz5U1M+ZDBT+E7QZfquOX+nXrfrU6lb+uq@alsa-project.org
X-Gm-Message-State: AOJu0YxfU2a+BDLknH+IKgGTHN+GBw2e5ywQRh0SLibZFPq1oSeXqdfe
	GIioUF4Czy7SWR5NtQ+n5qAaxm4RshvHCfk3xpdjdq6IllSsRl3MqmQC
X-Gm-Gg: AfdE7ckNfcc6vc0WSDfegjLBa/KnfKwFNV5nZ6v9ehn0WOvMaYGjTtUhO409aDEAni4
	QRx5OO7+oAGzFN93bFVnQjaqFgCFaT98XD9KxS0MHwN9b2qcOzBkwg1KjZZkC/UoflKovJFG9nS
	ozz0IPyxJY1M2ARWHaq7elueOQT21ZoCJSY+vcRoGNmmT1sHsv2I+AJhbJrQoEpY4+WfubNt3Es
	4OuKL0gPVQh+jOw3ERxHv9MzZar4Y+ibLIMqzmfIZMf1nM2pVkHv31igRikioVr1ULNzP3RR7/B
	vKgQcyxMVKCnVM+IAOMbaHZKpYqdXoz0e6aqDaQsnBd/OvaXjNbybrWXtNizNVG/8rsSN771diD
	35fkssqqxIH0D/Cvb/g/zHZkCZYLFEUskECPmYO7unm9oveKl4/XYhljvr3tkbBXzs4hnCppzZD
	2QsfKHXQKCAVRnkpqd6kXwm8LJifQPCdcBCyIZKeCsGBqSIWEzyfRt4hg=
X-Received: by 2002:a17:903:289:b0:2c9:ae0b:61e3 with SMTP id
 d9443c01a7336-2cb97e47c33mr78483555ad.2.1783308331180;
        Sun, 05 Jul 2026 20:25:31 -0700 (PDT)
Received: from [172.20.10.3] (114-137-158-217.emome-ip.hinet.net.
 [114.137.158.217])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cad776577esm41505185ad.39.2026.07.05.20.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 20:25:30 -0700 (PDT)
Message-ID: <61a878fd-1e49-2403-9e63-66544d17861d@gmail.com>
Date: Mon, 6 Jul 2026 11:23:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 2/2] ASoC: codecs: nau8360: Add support for NAU83G60
 amplifier
To: Mark Brown <broonie@kernel.org>
Cc: Neo Chang <YLCHANG2@nuvoton.com>, lgirdwood@gmail.com, perex@perex.cz,
 robh@kernel.org, krzk+dt@kernel.org, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kchsu0@nuvoton.com,
 sjlin0@nuvoton.com
References: <20260630021510.821919-1-YLCHANG2@nuvoton.com>
 <20260630021510.821919-3-YLCHANG2@nuvoton.com>
 <66ce56eb-95b9-4915-8658-a1e4d1eacd7f@sirena.org.uk>
 <3b32493b-b827-e4ed-3ad1-281dc19faf40@gmail.com>
 <akpOy2HJsDCu7wVx@sirena.co.uk>
Content-Language: en-US
From: YLCHANG2 <neo.chang70@gmail.com>
In-Reply-To: <akpOy2HJsDCu7wVx@sirena.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: neo.chang70@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: MCP2Y5AIQOCGPK27AX4QFDF3YSREJW6A
X-Message-ID-Hash: MCP2Y5AIQOCGPK27AX4QFDF3YSREJW6A
X-Mailman-Approved-At: Tue, 07 Jul 2026 14:29:46 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MCP2Y5AIQOCGPK27AX4QFDF3YSREJW6A/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On 7/5/26 20:32, Mark Brown wrote:
> On Fri, Jul 03, 2026 at 11:26:12AM +0800, YLCHANG2 wrote:
>> On 7/2/26 23:15, Mark Brown wrote:
>>> I would expect TDM to be configured by set_tdm_slot() from the machine
>>> driver, not from userspace.  I see the driver does actually have a
>>> set_tdm_slot() operation...
>> Our DSP functions require specific Slot mapping (e.g., Slot 0 for AECL, Slot
>> 1 for AECR).
>> The standard set_tdm_slot() only defines active slots but doesn't handle the
>> functional mapping.
>> We originally intended to allow dynamic mapping via UCM/userspacea and then
>> apply these settings using set_tdm_slot().
>> How should we implement this mapping according to ASoC standards?
> This would usually be doing using DAPM routing if it's expected to be
> runtime variable, define AIF widgets for the bus slots then route to
> them.
>
>> Should we define the default mapping during the codec probe stage,
>> or is there a preferred way to handle this via the machine driver?
> Device properties, this is better if it's supposed to be fixed for the
> system.
Hi Mark,

Thank you for the suggestion.
We will drop the dynamic mapping via kcontrols.
Instead, we will adopt a static approach using device tree properties.

In the next patch version, we plan to:
1. Remove the SOC_ENUM kcontrols intended for DSP functional slot mapping.
2. Introduce device tree properties (e.g., nuvoton,dsp-tx-slot-mapping 
and nuvoton,dsp-rx-slot-mapping).
3. Parse these properties during the codec probe stage to configure the 
internal DSP TDM special function and path registers statically.

