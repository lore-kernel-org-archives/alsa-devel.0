Return-Path: <SRS0=WNc7=LP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61324C49EA2
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 09:23:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14827610A3
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 09:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14827610A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B92C783E;
	Mon, 21 Jun 2021 11:22:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B92C783E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624267411;
	bh=OouAr56f9IjK9F3tRCvoB72K9UxoXNwZlIfzWf7Kmg8=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nzIfc2g3fffGrvMhvk8ujpbbxACjRWYMMS+bopwTOHKo+6XqgRBZ/xKesI6MZqu98
	 iwM2NnQry2XOuBgiAL7Fc3hKAhulUv3yEeAgp9N9eNGmPdvF+PN5CgBxz6iiTn88qa
	 Oh3Ss4ho8vwvMIx0Jy31MEyniVkt2Mbp35AbdeH4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 59EEDF8016B;
	Mon, 21 Jun 2021 11:22:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 53451F8016D; Mon, 21 Jun 2021 11:22:40 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6FBDBF80137
 for <alsa-devel@alsa-project.org>; Mon, 21 Jun 2021 11:22:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6FBDBF80137
Received: from mail-ed1-f72.google.com ([209.85.208.72])
 by youngberry.canonical.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <krzysztof.kozlowski@canonical.com>)
 id 1lvG8X-0000ZL-3G
 for alsa-devel@alsa-project.org; Mon, 21 Jun 2021 09:22:33 +0000
Received: by mail-ed1-f72.google.com with SMTP id
 y18-20020a0564022712b029038ffac1995eso7491523edd.12
 for <alsa-devel@alsa-project.org>; Mon, 21 Jun 2021 02:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7esRvVcinYR7rlyfgxB0axaJuCa7vrRfbX3KD5RVOvA=;
 b=LqCwh8reOTxboisTqco7htPS/taRn1cpMHmTfg+zqV/Z4Q+pS+fR88s9BKB6IfUsaa
 Okx0I01gXo3ltxKIP7xZuSTC+KpuKGTbnPsKtX7ZBLwxCTQK9/Bt+0/Sa1aDyR/3EJ7k
 kI+7S+sdwY41TgrZAk1d9MRTuc8jSHnO3QN7AMxvCHvRGTiRSr+qiY/rY8F11mJVKk+4
 KF1n8iUvMx8CNBbeuS6gz1cg3Jdm0lcDUdux6/RhlVwvRPKDxS4VkcLfEiU8zXiq8iqz
 qhYcvhFcV0jSW42BPc2d9ivV3sNknYn0nwAfpfiFjvyiu08VcaCLaaChU9XfDHvCpfQv
 tobg==
X-Gm-Message-State: AOAM5316tXudnXwNLSkisq5vgyKsGINuwYdBExNRM3UM4R+OxQkEoGn2
 nYbZUkPOvumvv6JWvEs05leOCAk7T5mgt/l5J5Z0Bp2BSw3SXenifRieLOmUXsH+IVsgqRWJtEu
 FO8Hril0jC0xaoX9QENYsO6Z0jdyIPJYiaZlQtQMX
X-Received: by 2002:a17:907:10d8:: with SMTP id
 rv24mr23244121ejb.542.1624267352894; 
 Mon, 21 Jun 2021 02:22:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwK87IiOxM4hAhjXuyIaQM65msNysHT4P/N9iideRyYDPL+x8j12EeilZUbJEJaGVB4YOM4Vw==
X-Received: by 2002:a17:907:10d8:: with SMTP id
 rv24mr23244113ejb.542.1624267352732; 
 Mon, 21 Jun 2021 02:22:32 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch.
 [188.155.177.222])
 by smtp.gmail.com with ESMTPSA id gz12sm4555566ejc.36.2021.06.21.02.22.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jun 2021 02:22:32 -0700 (PDT)
Subject: Re: [PATCH -next 4/4] ASoC: samsung: s3c24xx-i2s: Use
 devm_platform_get_and_ioremap_resource()
To: Yang Yingliang <yangyingliang@huawei.com>, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org
References: <20210616091652.2552927-1-yangyingliang@huawei.com>
 <20210616091652.2552927-5-yangyingliang@huawei.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <a5d4ccb1-e98b-f983-ff0a-d57ddd2c045e@canonical.com>
Date: Mon, 21 Jun 2021 11:22:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210616091652.2552927-5-yangyingliang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: broonie@kernel.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 16/06/2021 11:16, Yang Yingliang wrote:
> Use devm_platform_get_and_ioremap_resource() to simplify
> code.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  sound/soc/samsung/s3c24xx-i2s.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
