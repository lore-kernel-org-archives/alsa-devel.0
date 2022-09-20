Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC61BECAAD8
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Sep 2022 15:23:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2BB7D950;
	Tue, 20 Sep 2022 17:22:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2BB7D950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663687410;
	bh=f82QtPRzRzSAQPMS63DM53HdEsL57liqIou4BOAySGY=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QOozjs2uHGPdEhOP1QHGkzxT/WTr/4IZPuzkymW1rMZ9MGlWT1fOJBwgBFgSY2k/Y
	 knO7kh/c0jJM1SDqpb5NMWwCR5EhkOSPlaoDkDIk316cOrwew4utYPDGhDjpxqcI9r
	 WbKd4MqiE2DiDPFt71C99ikhwbfU1vldMEQ0zzdI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 73E9EF801D5;
	Tue, 20 Sep 2022 17:22:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CBFC8F804D8; Tue, 20 Sep 2022 17:22:34 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 80C92F80171
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2022 17:22:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 80C92F80171
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="dryOEWp1"
Received: by mail-lf1-x12d.google.com with SMTP id k10so4376729lfm.4
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2022 08:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date;
 bh=rLmosHOkteJetUfMH1iOxaM6TfQV6pI0UvsDV0r2AOY=;
 b=dryOEWp1Y7+Mku+Pejx7aLr/rw7huzEYdezWS0xLztYGKxuuLQJw8FNfkIFjf2EgBQ
 6nD7gHKi87xl4KoJm2kWuXzfZSR4DgZUIh4qW9Gkg0UYqa0H6UA1Tou1NxcTThGa8H3l
 YtH5murKuzBrToHMVSbJ2ep4IQkL9AU1w0OcCSjdV3g+ohb/mCO3J0Nsa46KVxUDxGZJ
 tWgzc6qAxq8wJCUiy9ezPznPUvQUzlYBM1zkUiMqLQmZSMh30MQ2eekGVO5QPI/RTvzI
 XnoRaAH6b0OdB1Sej7DCsmBf4p7kfRFALt+mFKN3z8Fvo9vKp1kBEgENcWnKNHA5CHur
 SbDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=rLmosHOkteJetUfMH1iOxaM6TfQV6pI0UvsDV0r2AOY=;
 b=D9Qm8ZSAitlCKV9LmUoNbkkg0ID9OS+oqB7l74it+bDLviVuX1dTSHuIw6wVVOX0ZU
 cjoMjOPTvzyeO6Cwr4WLqmGKgafoMXmpyLZh75DxuKhHaV7Aq+hu4fpOUhcj6aXTJJCN
 91n7Hp0CT5/9cU4mTo9Kw6huMAJET7ZSZFI6SU4cmIymQl9brqcTWUbAvC9wvNN2v+Zv
 9vMCQDxG+b3C2e+lkSmCQ+zfh5aFyh/IFpEHdIV/0l2+jTzU6vuN4s3cl+3seCrhPnmY
 ESkGI0YIHR5vEDlpXfS9kVfHv/5h8W/qklx3oqxq1lppiu+fzE6n2Kp6Weca2ujSqBAG
 ZEZg==
X-Gm-Message-State: ACrzQf14z3wjYfqEZOVMjjEqXOZaJusMFMZ02+2Z2N9tKJ8A/XNuA5Py
 bnDW//Bzc6FLumcx45yj5/iy7A==
X-Google-Smtp-Source: AMsMyM7CufcP7ESkPRKYW0kpVcKVublFAAxZwckLh16qjJbuGNV+C3YGWX7p770ab5ehifq/4G7sbA==
X-Received: by 2002:a05:6512:118a:b0:49a:d52d:d144 with SMTP id
 g10-20020a056512118a00b0049ad52dd144mr8892398lfr.239.1663687346754; 
 Tue, 20 Sep 2022 08:22:26 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl.
 [78.11.189.27]) by smtp.gmail.com with ESMTPSA id
 i1-20020a2e2201000000b0026c0158b87csm12644lji.29.2022.09.20.08.22.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Sep 2022 08:22:26 -0700 (PDT)
Message-ID: <79658ad6-fd1c-68aa-88e0-6ad5274bea9d@linaro.org>
Date: Tue, 20 Sep 2022 17:22:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 2/3] dt-bindings: sound: ti,s3a227e: add control of
 debounce
Content-Language: en-US
To: Astrid Rost <astrid.rost@axis.com>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Dylan Reid <dgreid@chromium.org>
References: <20220919111258.3774-1-astrid.rost@axis.com>
 <20220919111258.3774-3-astrid.rost@axis.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220919111258.3774-3-astrid.rost@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kernel@axis.com,
 linux-kernel@vger.kernel.org, Astrid Rost <astridr@axis.com>
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

On 19/09/2022 13:12, Astrid Rost wrote:
> Add devicetree parameters to control the insertion, release and press
> debounce times.
> 
> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
> ---
>  .../bindings/sound/ti,ts3a227e.yaml           | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml b/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
> index 327d204cf957..76ce323ce965 100644
> --- a/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
> +++ b/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
> @@ -41,6 +41,35 @@ properties:
>        - 7 # 2.8 V
>      default: 1
>  
> +  ti,debounce-release-ms:
> +    description: key release debounce time in ms (datasheet section 9.6.7).
> +    enum:
> +      - 0  #  0 ms
> +      - 20 # 20 ms

I don't see any improvements here.

Best regards,
Krzysztof
