Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3687C636CD
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Feb 2023 12:59:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DF7A7828;
	Wed,  1 Feb 2023 13:59:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DF7A7828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675256395;
	bh=dMt8iEaOiOYFVfe4qci84OXVcLQudVjlDGmhvN4AHKQ=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Ex83FBBTYRaagCa5dj9azXIUEGQlySVaXsT1hY6g8l9zHiQEfYBr+S7UzE4Szkn0Y
	 zc1FjwGY64LwInKLQUW3xaLj4ya2xO5ojMZ75rGUqTqqJXELtWb/xfagVHwr+E/j0/
	 FaWbY1YbNEWL0OXa7R8yb/d1aGG2eeuTkdVGYrWw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8AB4BF8032B;
	Wed,  1 Feb 2023 13:59:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CE28AF80423; Wed,  1 Feb 2023 13:59:04 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8A93DF80169
 for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2023 13:59:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8A93DF80169
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=hBTgJjuM
Received: by mail-wr1-x42e.google.com with SMTP id m7so17221039wru.8
 for <alsa-devel@alsa-project.org>; Wed, 01 Feb 2023 04:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TkRgoBvsamoZEywHKvCbV9XJyi8yWA+6MbvImGKamXs=;
 b=hBTgJjuMuqMdpBJHlKBExlPRRNfyr43zRQIVCYYhHv3Pj/65MJVea6JwDlt9kIVcnS
 rq+pDRMRQk5aFUKi4QxPpbhagu0uVnI3llVEkytALJ9BIseU1fqj34s9KHM/QA+jJu+a
 aFffmNTQYWGBeCleAZLH3hSwTItAMWv+UgZVKcuGAYRtXFytvtECeXB0/G4xDAeroYMD
 CAhIZ6yaDQe5+aEwequcRV8W3HOkErwd6tVkxnx1WN2M1EGu0iFsIknKTU9RMW2ex62I
 Bh6j6dZIvGic4WKnFuE9WOULb6MIRe0GN2wcoEvLlBhjRXOn1CbhDSW40Ge62HQf741c
 4g0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TkRgoBvsamoZEywHKvCbV9XJyi8yWA+6MbvImGKamXs=;
 b=6qefgKxu/tl1kpWqvqwtzyF1HChindF7UmDY9coaqPyav72tQuZf/7Cs2eMQRYR3pY
 oYQs1MW/p1eFhPagtIdY8Jj+ZcvtTnDWA7UeTlU74JZe5wlP29W1UqzRMwSlMvYbCf25
 Ggjpe1YYg3lnh/r750eE5gBDP3tZOwE3zy2MHkgz70kba8Q/KNN/B4fevRUR9s5NZvyg
 AdDsgaGKDWvRgiyNNBZlpk5Yz4oOYta5xMcc/aclNFeLB2LNCKZtmFh5dOsXdZTg4FFP
 J6519PqzxEmF4/xq3P5L2YiD1cyzy8ApY9MWfCQrPkqAcUwQVb8n6MMY2YMxrwY9Ct6L
 REiQ==
X-Gm-Message-State: AO0yUKW8P5+4narOfOWIQju35UxusLBHfS9UVHaUPtHELEoKD1kHhG7b
 DlKZodDzrSCo9Qb01EtdBxey5Q==
X-Google-Smtp-Source: AK7set+ETqVjMTMjZpLUkwhOb9Vi3pV69kQ/Xge9mO9uq+whMqZKH4SBd3uJuKrlCR1q6hKJS1jMbw==
X-Received: by 2002:a5d:53ca:0:b0:2bf:cefa:fd8f with SMTP id
 a10-20020a5d53ca000000b002bfcefafd8fmr1584833wrw.44.1675256338708; 
 Wed, 01 Feb 2023 04:58:58 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
 by smtp.gmail.com with ESMTPSA id
 k7-20020adfb347000000b002bfe5efca78sm10431486wrd.98.2023.02.01.04.58.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Feb 2023 04:58:57 -0800 (PST)
Message-ID: <a6e89f75-7391-171e-3cab-77d3b9f9a0cf@linaro.org>
Date: Wed, 1 Feb 2023 13:58:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] ASoC: dt-bindings: irondevice,sma1303.yaml: Fix about
 breaking the checks
To: Kiseok Jo <kiseok.jo@irondevice.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230131050946.14385-1-kiseok.jo@irondevice.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230131050946.14385-1-kiseok.jo@irondevice.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Rob Herring <robh@kernel.org>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 31/01/2023 06:09, Kiseok Jo wrote:
> Fix the bindings checks like syntax error.
> 
> Signed-off-by: Kiseok Jo <kiseok.jo@irondevice.com>
> Reported-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/sound/irondevice,sma1303.yaml          | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/irondevice,sma1303.yaml b/Documentation/devicetree/bindings/sound/irondevice,sma1303.yaml
> index eb87374cc812..162c52606635 100644
> --- a/Documentation/devicetree/bindings/sound/irondevice,sma1303.yaml
> +++ b/Documentation/devicetree/bindings/sound/irondevice,sma1303.yaml

I would actually prefer to revert... patch was never reviewed (never
CC'ed to all maintainers as requested by get_maintainer.pl) and will
need more fixes after that fix. Eh, more patches to come.

Best regards,
Krzysztof

