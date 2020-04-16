Return-Path: <SRS0=OoyA=6A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C33C2BA2B
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Apr 2020 07:59:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 779CF206E9
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Apr 2020 07:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Lhlwpt1d";
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V+92JQII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 779CF206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BF45B1673;
	Thu, 16 Apr 2020 09:58:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BF45B1673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587023942;
	bh=75nl5rR7HAjoWsPJD9lmExdiaeuYKXkfw1imM39nU7M=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lhlwpt1dfDne/y+qxJ3M/btOpnaYXEkyGU53Pjjxs/Y1bJ2x1INNA8YprebDDynag
	 6jgmBK/CqMaJRTBf8BAz3EcBzSt18b5i3Dc00KdhROTgRH0b+ug3aZCY8sv1qmIGd1
	 vzaPCffp8Kz4EXvXGkmUa+w9KMiEBBbA5GPY6wSg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BFB4BF80292;
	Thu, 16 Apr 2020 09:56:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CE32EF80278; Thu, 16 Apr 2020 09:56:36 +0200 (CEST)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 882D7F8014E
 for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2020 09:56:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 882D7F8014E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="V+92JQII"
Received: by mail-wm1-x341.google.com with SMTP id x25so3539020wmc.0
 for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2020 00:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Kox1QxtahOd3osgWGMNatL/3WlQIWrSz32253M5/lF0=;
 b=V+92JQIIZjdcgco4btvgFG/iteh1q+0MLX70rPI2MGIuuDVP3vVQReGKfMarxs+Zta
 C5CQG5qoCn3eIgicA17GU2C9WDKmoL80EmGMBpU1/LUvdZwASEN95FstsDrQopoTuNtU
 3i9E9Dyfk6Wpx1xGAL7NfoYq7EclvZumOHRPwoBbIUHpqZpEr08EUVVu4y1zQOYvq5ju
 FTaoVpYkmqtpq+lp+Oi4b2Q/p17S146c52E4qOC5KnjlPTtm7sjj3lLqM0VGYgdly4Go
 ztIxXGmG+gVvETvZ/IBzNn6dM71b0ZCuXzh8Zrwyf2OnSCDVwnGRyqwzHyh+pooLiAru
 IuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Kox1QxtahOd3osgWGMNatL/3WlQIWrSz32253M5/lF0=;
 b=J8TkC+Ozwo3BJNXniSxL6XVqkw4SugNgv96913EqZuNAtKURoDRIS9QQ5ev3ECRu7L
 aLgFzx8Jl5niXToGPshjzsy/zsFTte8hGCMSBjOPvtlO9x/SRnAke4IbYmScwGeyeNan
 OqSckCb3FwiEFvlA0ZDfUPthgQc4j+2AbelhISllrKcF3LacJwaCJrTX2Iek3xdSbq9H
 4ip94jhFcQhi5CTZpD/QxpD17xhGhbBkH0l/nkZ4AKbbTF/EB26zvNdC+euG7EEV2pz9
 T2ujdVGjd963B+RK0gwygMR+IFMS5z6Vcpe9OrEYULViUDGzGKphpybzullsF03gk6nW
 HjSQ==
X-Gm-Message-State: AGi0PuZzoAZQHYc9PxJC2/bUIM2+n4nzcGZCdUTr9U5Cs0ffRuIsjzoR
 RyEmBuhsL2CZZWJRS6Gd59+5mA==
X-Google-Smtp-Source: APiQypLjmf5r74x3HUYZnkW/IPjGxXrvT2N38yPWo5rdm9IEUQaAASgf3S69VUg0RsMZ+W2jo4ynZg==
X-Received: by 2002:a1c:9e42:: with SMTP id h63mr3297924wme.115.1587023787696; 
 Thu, 16 Apr 2020 00:56:27 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id c17sm26766247wrp.28.2020.04.16.00.56.26
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 16 Apr 2020 00:56:27 -0700 (PDT)
Subject: Re: [PATCH 04/11] ASoC: qcom: lpass-cpu: Make "ahbix-clk" an optional
 clock.
To: Ajit Pandey <ajitp@codeaurora.org>, alsa-devel@alsa-project.org,
 broonie@kernel.org, devicetree@vger.kernel.org, plai@codeaurora.org,
 bgoswami@codeaurora.org
References: <1586592171-31644-1-git-send-email-ajitp@codeaurora.org>
 <1586592171-31644-5-git-send-email-ajitp@codeaurora.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <090b1b81-3c33-7d37-e0bb-a5f73ab76ad0@linaro.org>
Date: Thu, 16 Apr 2020 08:56:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1586592171-31644-5-git-send-email-ajitp@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, tiwai@suse.com
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



On 11/04/2020 09:02, Ajit Pandey wrote:
> AHB-I/X bus clocks inside LPASS coreis not a mandatory clocks for
s/coreis/core is/
> newer lpass variants, hence make it an optional one.
> 

Can you add more detail on which version of IP would not have this clk.

> Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
> ---
>   sound/soc/qcom/lpass-cpu.c | 31 ++++++++++++++++++-------------
>   1 file changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
> index 492f27b..f177932 100644
> --- a/sound/soc/qcom/lpass-cpu.c
> +++ b/sound/soc/qcom/lpass-cpu.c
> @@ -504,26 +504,31 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> -	drvdata->ahbix_clk = devm_clk_get(&pdev->dev, "ahbix-clk");
> +	drvdata->ahbix_clk = devm_clk_get_optional(&pdev->dev, "ahbix-clk");
>   	if (IS_ERR(drvdata->ahbix_clk)) {
>   		dev_err(&pdev->dev, "error getting ahbix-clk: %ld\n",
>   			PTR_ERR(drvdata->ahbix_clk));
>   		return PTR_ERR(drvdata->ahbix_clk);
>   	}
>   
> -	ret = clk_set_rate(drvdata->ahbix_clk, LPASS_AHBIX_CLOCK_FREQUENCY);
> -	if (ret) {
> -		dev_err(&pdev->dev, "error setting rate on ahbix_clk: %d\n",
> -			ret);
> -		return ret;
> -	}
> -	dev_dbg(&pdev->dev, "set ahbix_clk rate to %lu\n",
> -		clk_get_rate(drvdata->ahbix_clk));
> +	if (drvdata->ahbix_clk != NULL) {

No need for NULL checks here, clk apis already have checks.

--srini

> +		ret = clk_set_rate(drvdata->ahbix_clk,
> +				   LPASS_AHBIX_CLOCK_FREQUENCY);
> +		if (ret) {
> +			dev_err(&pdev->dev,
> +				"error setting rate on ahbix_clk: %d\n", ret);
> +			return ret;
> +		}
>   
> -	ret = clk_prepare_enable(drvdata->ahbix_clk);
> -	if (ret) {
> -		dev_err(&pdev->dev, "error enabling ahbix_clk: %d\n", ret);
> -		return ret;
> +		dev_dbg(&pdev->dev, "set ahbix_clk rate to %lu\n",
> +			clk_get_rate(drvdata->ahbix_clk));
> +
> +		ret = clk_prepare_enable(drvdata->ahbix_clk);
> +		if (ret) {
> +			dev_err(&pdev->dev,
> +				"error enabling ahbix_clk: %d\n", ret);
> +			return ret;
> +		}
>   	}
>   
>   	ret = devm_snd_soc_register_component(&pdev->dev,
> 
