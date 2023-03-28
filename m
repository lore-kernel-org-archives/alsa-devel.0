Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B50C76195
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Mar 2023 08:25:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8953D1F7;
	Tue, 28 Mar 2023 10:24:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8953D1F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1679991929;
	bh=FlF2aOV6rHsmx/9FgyhhfDVRg3+GmHHaYAf1AT2WMMQ=;
	h=Date:Subject:To:References:From:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=rL4zFx+rVO3RBnndvfSBYCwvs/14buOy5CvhYc64BDSQyWogriEQkNG8GXZja9fEk
	 4DfPPDZaJygzTNC8ek3awDxwqbdC94ZcNt1A3n7IV85jDwQ4l/zbMw8bSBhzZmCT+U
	 dpZ/R4PuvTrxdxqj0FW6OUmEwTL2IzLtQeg36nmQ=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 86DACF80272;
	Tue, 28 Mar 2023 10:24:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 072E6F80272; Tue, 28 Mar 2023 10:24:13 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 56578F80114
	for <alsa-devel@alsa-project.org>; Tue, 28 Mar 2023 10:24:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 56578F80114
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=lIe36//w
Received: by mail-ed1-x52b.google.com with SMTP id ew6so46175181edb.7
        for <alsa-devel@alsa-project.org>;
 Tue, 28 Mar 2023 01:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679991843;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ywfDEh4j3TIad7B4v5GyW5cEwUOW1bLBQ19ZKpGmXtQ=;
        b=lIe36//we0gyKnYLvwkSXARqX6I5K/VdhR/nFiiQBaNRlzn67lPotVDQIdLxAmT7+x
         xZgE0zThDvODSfroz/rsBcTkls5kY5cxdfEHEJ69cNZW8g8nI8YkwZFyl11H/K8DR427
         whs5mIXjWQ+PO2oV1vmmu9HF8GMp5wyTBmz+QGUpk8k2IjvpvCgJgVOLmH0hxAz+Tx3S
         ksG8jepCM76ZZoXTe9i0033BosNhQxbYXUOn/kecUyiu6c0UZo//YeTFDjgwI2x4kpik
         Ove0VK+/zhXZYNLffbAWHLUZiDrOQZkqh7Plhpc0sT/3ert6WxSaz0HoVvjd1pje5EXB
         4RDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679991843;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ywfDEh4j3TIad7B4v5GyW5cEwUOW1bLBQ19ZKpGmXtQ=;
        b=imRKyck7T+JrA3OJ/B4Y/GYdv8lUdpWvLlRRVfhgiN4ThkoFUN+XKbtoksMaazx435
         rzIZ/S1ex3MR4EK+eUjFanJOMhcjcv/ecqAFaU8Y6Sw43zalHdsMAsHj6j+9KtXboHD6
         EZOu4vbcF7lpAVTe31+Y+d2vXs9holWv1j0DxHUEhq4gHkTxn2oISuDqqbd+1KO8sVSR
         qDHqZqWpPbOB8bPJR0VV4p6gVyNC4lrnT64/XLkAgATXzqMtyEhGhM4meFy7/uo7+BTb
         QiW2iin+EDD24u/MisRUG7+N0gptQ+AdmEvUIJGCzBCvQl+DFjwY09Dp9r1aZewOH+qB
         lLRg==
X-Gm-Message-State: AAQBX9fthJYcdk2CsEM3pd7Utx45isVa83WISe7eJ8aMjByztjEOJf6A
	PAeceEbgowaoLngRz/YFoiF75w==
X-Google-Smtp-Source: 
 AKy350YPZFDeXBQ1t0a9hoZeT7QNScxDyGG1LAp0JRVDNEdIQKa/fTHx35lWl5jX5FSZFuH7mh5Eqw==
X-Received: by 2002:a17:906:fcc9:b0:92c:138e:ff1f with SMTP id
 qx9-20020a170906fcc900b0092c138eff1fmr14321837ejb.18.1679991843377;
        Tue, 28 Mar 2023 01:24:03 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9e92:dca6:241d:71b6?
 ([2a02:810d:15c0:828:9e92:dca6:241d:71b6])
        by smtp.gmail.com with ESMTPSA id
 n22-20020a17090695d600b009222a7192b4sm14964442ejy.30.2023.03.28.01.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 01:24:03 -0700 (PDT)
Message-ID: <9490b5ef-3068-fcbb-0105-baf3839c21df@linaro.org>
Date: Tue, 28 Mar 2023 10:24:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4] ASoC: dt-bindings: alc5632: Convert to dtschema
Content-Language: en-US
To: Saalim Quadri <danascape@gmail.com>, daniel.baluta@nxp.com,
 krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com, robh+dt@kernel.org
References: <20230327211629.28643-1-danascape@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230327211629.28643-1-danascape@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: 4OBAORVE6JPBXUWCGBUNBPK2ZJTLSWAR
X-Message-ID-Hash: 4OBAORVE6JPBXUWCGBUNBPK2ZJTLSWAR
X-MailFrom: krzysztof.kozlowski@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, broonie@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4OBAORVE6JPBXUWCGBUNBPK2ZJTLSWAR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 27/03/2023 23:16, Saalim Quadri wrote:
> Convert the ALC5632 audio codec bindings to DT schema.
> 
> Signed-off-by: Saalim Quadri <danascape@gmail.com>
> ---


I wanted to review it but for some reason you keep ignoring my comment.
So one more time:

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

Is there something not clear about my request above?

Best regards,
Krzysztof

