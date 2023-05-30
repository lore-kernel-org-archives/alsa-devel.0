Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E05C7EE23
	for <alsa-devel@archiver.kernel.org>; Tue, 30 May 2023 17:48:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 00DAF3E8;
	Tue, 30 May 2023 19:47:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 00DAF3E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685468922;
	bh=8kQsIgbTFGXpLg1Hn+3x+6lqlkOuB6eo9hRDYKaKKKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=KIJxEZtRP0KSLFhcx8MFQsyYxhEA/NCTQemz/gipUFzILGrjKmF0WO7pKYb2vST3l
	 da5BGU/S5a2ppbX9xtuEuTjlk55VlHlNwdKk/JgVnWDgPLX9eLyCzvWS9scxGSkMpE
	 KKMjSnaWIscdP9wM1BkVFstTFk+rkQf9VNQbpOs8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E7824F80548; Tue, 30 May 2023 19:47:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E256F8042F;
	Tue, 30 May 2023 19:47:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4603DF8042F; Tue, 30 May 2023 19:47:19 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3CCF9F8016B
	for <alsa-devel@alsa-project.org>; Tue, 30 May 2023 19:47:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3CCF9F8016B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20221208 header.b=OdR4Y7H6
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-64d41763796so3519721b3a.2
        for <alsa-devel@alsa-project.org>;
 Tue, 30 May 2023 10:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685468834; x=1688060834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4KFcanc4CjzN6hzpjon4X1hruFFYHDR7ugE4zm99DHQ=;
        b=OdR4Y7H6Nx7sBNTAd11PEkft3yN3efyKaIhV51v9ftLHVjNGbfszMwZosHkg5dbvth
         fGKbqJWOkQEJBu9OgQv5/ubfry9JCPiWIKt6agjG7Z9uG13BkYg/lmLuPtIG+hdVAG/t
         WztyPKjFqolTIx3oqTGSy0hNZ+bgyO77i/EWyvAzYxdfOPWR07on947GOAxT3K1cYvcb
         dRauGNu4twfMxT+IxF3YuBxl3FxAjvRZnR2zhmO1CoAm7Y/bEdSRRZJFIh55JuuGY2HO
         NLZFONHUXgPe1Yd+JHK7+pyUnZAn8kTI1QC+L6ulzm5YhZyWROjecxT8gFsQvLpmTQwL
         jOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685468834; x=1688060834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4KFcanc4CjzN6hzpjon4X1hruFFYHDR7ugE4zm99DHQ=;
        b=EtIglNCpsr5aD176cClcsGPmmjL6AFc/kNNcCM9vDJ/CXLB0cqVAPaTzskawhgPB64
         ZDIv0Pl8yQBxP+mDsyfFJs9LM000iIwD+eN9UYBKOY9ZjlTiAeDNBnvpLzq4RAAnnk0T
         RxMi1uvYFCHq7eN1QqwB0WEDMN+P+ZsNJD3Ews+zmxRWFRJ1Vxre9CiyOUwB1IUUFXUx
         gUhTr2hWjtVBE2g7kFvxvj5RI6WWf2CxwbKH0p36wakGjrU6TDcAU+abwdPN8NOQ0suQ
         yoTKpQbsDxrJK1EgcHBjdIIAHMmGnqagr48+dF8o51yKtxgeqqD54phBVBOEZsYPdqxb
         qugg==
X-Gm-Message-State: AC+VfDxMuimuxw0G6gtKaVt3d5PQ4x6pICq4feVm5reVJbmpXe3PoKgN
	dm19dWqjeI2rcz/o6fowzVA=
X-Google-Smtp-Source: 
 ACHHUZ5H1oTyoutcnUo3XiPYYzwua35COz5cA3FRa6JU3oW4ADLdTbZES7lj7v/2W8drbB6s7qiXwA==
X-Received: by 2002:a17:903:24e:b0:1af:ff02:bc19 with SMTP id
 j14-20020a170903024e00b001afff02bc19mr3552294plh.26.1685468834029;
        Tue, 30 May 2023 10:47:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id
 b4-20020a170902b60400b001a6f7744a27sm10604029pls.87.2023.05.30.10.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 10:47:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 30 May 2023 10:47:11 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Mark Brown <broonie@kernel.org>, Dipen Patel <dipenp@nvidia.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Dilip Kota <eswara.kota@linux.intel.com>,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-rtc@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-spi@vger.kernel.org, timestamp@lists.linux.dev,
	linux-watchdog@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH 7/7] dt-bindings: watchdog: restrict node name suffixes
Message-ID: <2aaba5d8-37ad-4086-a81d-0d3e78cf5664@roeck-us.net>
References: <20230530144851.92059-1-krzysztof.kozlowski@linaro.org>
 <20230530144851.92059-8-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530144851.92059-8-krzysztof.kozlowski@linaro.org>
Message-ID-Hash: 7ONSGEWL5RB7JAXCPCYIITPK3MLZHSLJ
X-Message-ID-Hash: 7ONSGEWL5RB7JAXCPCYIITPK3MLZHSLJ
X-MailFrom: groeck7@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7ONSGEWL5RB7JAXCPCYIITPK3MLZHSLJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, May 30, 2023 at 04:48:51PM +0200, Krzysztof Kozlowski wrote:
> Make the pattern matching node names a bit stricter to improve DTS
> consistency.  The pattern is restricted to -N suffixes to decimal
> numbers.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> 
> ---
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/watchdog/watchdog.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/watchdog.yaml b/Documentation/devicetree/bindings/watchdog/watchdog.yaml
> index 519b48889eb1..f0a584af1223 100644
> --- a/Documentation/devicetree/bindings/watchdog/watchdog.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/watchdog.yaml
> @@ -17,11 +17,11 @@ description: |
>  select:
>    properties:
>      $nodename:
> -      pattern: "^watchdog(@.*|-[0-9a-f])?$"
> +      pattern: "^watchdog(@.*|-([0-9]|[1-9][0-9]+))?$"
>  
>  properties:
>    $nodename:
> -    pattern: "^(timer|watchdog)(@.*|-[0-9a-f])?$"
> +    pattern: "^(timer|watchdog)(@.*|-([0-9]|[1-9][0-9]+))?$"
>  
>    timeout-sec:
>      description:
> -- 
> 2.34.1
> 
