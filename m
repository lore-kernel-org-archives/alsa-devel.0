Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE2A606A331
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2026 12:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=vDUDi4A0;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BZJFuSga
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B5E6F601F3;
	Mon, 23 Nov 2026 13:02:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B5E6F601F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795435376;
	bh=yoHFqupTbaXVrYYdkqiKU010IQ2HVTU0uh9IReb1Wvc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=vDUDi4A0UwkeKm/fX8uDWGujXFKrrgmeW+RZSxiQg+1ZuPTT2EF1Al4A+4JYwTAgK
	 EyHRf1cLgvYLgR7cEF+qGB/TrkyALePmegdzY4JwOu8pPszJOiGGqvpLZxJh6LGOgX
	 f1pO5cjyVSxrDVrclGK7Zug+lcY+l9GxVgA1T5II=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4C374F805F8; Mon, 23 Nov 2026 13:02:21 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 189BEF805FB;
	Mon, 23 Nov 2026 13:02:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CF8DEF805A8; Tue, 17 Nov 2026 04:43:15 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794886995;
	b=JL15WLDI7o6ciQgNTntEeJ4gVTMyOi3+zT9HQWOrjWz2pP9wXxPqQvJuMDfbPo94RmFL
	 0dmMdNM6PXWqbuZNgSlhMwrmH1a3PK7FlWNzbFEPgLsYjUfCAwo6MQG5o0OzvPBktPuZs
	 FuJ2snxFLBTVuqCylPqhw8Hd4gtr9So8jVG4K6dtclnz4JZF3H1cLP3VTxtu1f0ftpg0B
	 aIkcBM0v5kbXcUwIuO5OeXAF2FmUyB2tLOS/T8ehoK9akrdzo9NV3Z/aygvqZbbzEFZpq
	 n9zmiyyKrZUag/WEHEqKCPYWQyLW4EZd6HHieAQ532tn3dFyMFMCnodk71Mr4nknx5w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794886995;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=yoHFqupTbaXVrYYdkqiKU010IQ2HVTU0uh9IReb1Wvc=;
	b=gIntQ3jlL27E2mjkLovXxC6tHWUfgM7LB0U65ydzzfWomH+GHcJUqEQdHoM/1TuLbfRc
	 X3T7ah0EQvIwIaNZ4b6ePqlaO5GvYB/ihhOTKjUf5sDlMDoG8lqF/YxuoMPcIH+Rn2k0U
	 2MS+0vUB/YDfPlugEr2kp27S5X2W5//+CRgk+WMrSYOgXjubomq2QhFZZF/KFNkyJUU6T
	 FGPG14ohG2JRderavfpgU/fJ1R54HZ8Wp5rOCzHl2OEd0yb1IlN4uXjaGlYM1gwhsEdLy
	 JqVW/Zgv/7RSEgUufYJndB43Dl6mDEtNpUhrXxf5XdGGrL2kKMYLV2pWORL32eXcSZg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=BZJFuSga;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 14A56F80510
	for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2026 04:43:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 14A56F80510
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=BZJFuSga
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2efe022c04bso488875ad.1
        for <alsa-devel@alsa-project.org>;
 Mon, 16 Nov 2026 19:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794886991; x=1795491791;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nRBAFnEApl3XvYxVAcATjRSQNlRWncFye6hnLwE9I8g=;
        b=BZJFuSgazUTaxey2UUe0XVXUNq4aqSpej5rSKrLKTWaAoqlQi4i68QF6RzFnW2tDgL
         oHNaOkQUmXI3Y3FJyF3ys3zSjTYNIekzxUArPzYgFMEWZZSPszmxBCngpm7gtGC4j9T4
         565J4aPFp/OGSdZxCdo42NDaJqCKR5Drkx8BXi8yWSC91Fk6AcrGsAxpCasjrXWFA2EG
         nAXU4a3EZ4DaG7wmt6oAe5y49m5mBWJIWIaBmjc9fmj0XM5IJlPHRTXH3rYEdOONaJat
         /Gex+N5/F/BQUYIQL8W98BdGigzeXsU5QeLYxnexcZL6AWQYX/taME3qUVawJ8pG2Pkb
         h9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794886991; x=1795491791;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nRBAFnEApl3XvYxVAcATjRSQNlRWncFye6hnLwE9I8g=;
        b=h46wDj6uKq7tai3Wd0v1j6ThnZhrW67colQfY78DeMNep5mhj8YCmFTYpzUnaALWcd
         SqhhR+L55smZ5NtjtRaKEKPd9JfkdTNEqL/6JRFL8brTlEARj2NAVXe0wyFiz0IGN5A+
         811l+Rf0kbLU7jbu2VG4lyiML2w40Bmx8dyAx0Kejzj4by6Vqk/QsmwSlkx9z/G+Wd80
         fvAl5I5f3gU70IOUaRPUgIhF/hShUpuYQ8SF+aS+Q+xc6pLiQv4AvrWhrtGsZgizaNWc
         fcSxQIEzLtVN/oGO9Ty3+Nj2DAuDSgFFwvFlwIET8lJQ+yj/+E0csXLApHzj/L3p7Jwh
         4IEg==
X-Forwarded-Encrypted: i=1;
 AL+hErEWM4lZhhcuxAfV6Z1D5X0YNid3W7lEvlUave5qWMNTeLeo0HnueWOcvROyZFLowx9DA/fC0fwIyok8@alsa-project.org
X-Gm-Message-State: APuU4Z/MVOV1JnwsXPFYfL69mwl5zxMc57cQsVQWhlBzYnSwZ26Qnfvk
	Gz+oNR9+Q4KNkw/jonSVx0ilL68jjGMWoL21qGbKO+nai3uiGZlJGc+F
X-Gm-Gg: AZFdTZcwoLMCboHdmsw7zkEESybksdSsc/5qFHdaPf60QOMLKiBAiYK+m8AWgQWSniW
	2NzThYYcBKl1jvdu3M87vlPHJznhob3DhcE0GaWA3P0MZkUIID8PoizB3Nv3j25jV8DPQMA1zod
	qU8bw6Qqo1sLpk3Q0EXBaLAck8YWkXHSl0lxNsM0PJCSONYOx9jwwoIKMi24G8IM2RGoEZGDd0Q
	rOu1qNA/9uxZz6gUOxhbdpcCua88WjaIpmkRvabGiGFYjvrUJ1zgIDaEakuOfzlhvSgCV2MlHge
	9EZ/IAR/EaAHaZWoKG9rVGsm6+bGtmuv9yHKvJIEveicoYj3JHItmmXJZIqDmkRxZIARncwx60V
	9TuAwNzQF+4xxcpv7VvjRX35vf0qwoMgL43WhP7nBBNXaVRSpRD9yab7PNecEC+VSUpb0spggXC
	0YGClG/MjLm8oBVFuJ5c5bIyuGKgYRogbZM3iAHeDa82Ku6ZRQ8yTDN1HT0O7zKHMmF64lXJeov
	kuMrdtzLhlUDGU+b//ZKRXFqEGLI/yujqXELuXkR3mvhEa712meiEPcmGbNNv5a72fjQW3Jt8Wb
	7mlAGmeIAahXJjgy+wTRGAgf1I5EfwySp5ki6QdRPAgxcYlsFjG5eZ4nqF4g
X-Received: by 2002:a17:902:fc47:b0:2ed:3eeb:b0db with SMTP id
 d9443c01a7336-2ee0de10ab1mr118955035ad.17.1794886991445;
        Mon, 16 Nov 2026 19:43:11 -0800 (PST)
Received: from [172.20.10.2] (42-79-72-63.emome-ip.hinet.net. [42.79.72.63])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2efd7a87180sm6533155ad.62.2026.11.16.19.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 19:43:10 -0800 (PST)
Message-ID: <63472ed5-1bc5-4acb-97ba-55749ec93c2a@gmail.com>
Date: Tue, 17 Nov 2026 11:38:15 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: nuvoton,nau8310: Add NAU83G10
To: Krzysztof Kozlowski <krzk@kernel.org>, Neo Chang <YLCHANG2@nuvoton.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org,
 krzk+dt@kernel.org, linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, kchsu0@nuvoton.com, sjlin0@nuvoton.com,
 lkp@intel.com
References: <20261109051251.471879-1-YLCHANG2@nuvoton.com>
 <20261109051251.471879-2-YLCHANG2@nuvoton.com>
 <20261109-grateful-white-meerkat-090edc@quoll>
Content-Language: en-US
From: YLCHANG2 <neo.chang70@gmail.com>
In-Reply-To: <20261109-grateful-white-meerkat-090edc@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: neo.chang70@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 5BQ7ZCMLP6C5DMN4M27HEVGGD2PEFFDW
X-Message-ID-Hash: 5BQ7ZCMLP6C5DMN4M27HEVGGD2PEFFDW
X-Mailman-Approved-At: Mon, 23 Nov 2026 12:02:13 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5BQ7ZCMLP6C5DMN4M27HEVGGD2PEFFDW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>


On 11/9/26 21:11, Krzysztof Kozlowski wrote:
> On Mon, Nov 09, 2026 at 01:12:50PM +0800, Neo Chang wrote:
>> +  nuvoton,sar-voltage:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      SAR Gain Tracking Selection.
>> +    enum:
>> +      - 0 # VDDA
>> +      - 1 # VDDA * 1.0
>> +      - 2 # VDDA * 1.1
>> +      - 3 # VDDA * 1.2
>> +      - 4 # VDDA * 1.3
>> +      - 5 # VDDA * 1.4
>> +      - 6 # VDDA * 1.54
>> +      - 7 # VDDA * 3.12
>> +    default: 0
>> +
>> +  nuvoton,sar-compare-time:
> Use proper unit suffix from property-units in dtschema.
>
> Also, Sashiko feedback needs to be addressed.
Got it. I will update the property name with the proper unit suffix and 
address Sashiko's feedback in the next version.
>
> Best regards,
> Krzysztof
>
