Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF53ECAAD3
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Sep 2022 09:43:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 30A361686;
	Fri,  9 Sep 2022 11:42:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 30A361686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662716609;
	bh=3r8aSja8xSwmmCnxCZGKKwCdOGoUeZdPdnAElxSvFwM=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eDTTYVmnwIwRq7lg5uGUeO1NuL4eKkgmvEKMk0XaoZLlCuGUH24ueA/6uF963zSJ+
	 Zsv+9pC63718tJKjXFDzizGezjvUKDwkbXZkGC7W8SxJ5z9zN3VVGG11yWjCx6nhkn
	 +FUV+OmPEYrkP7brGqcZju9Sw/tpH8Q/tgFN/J1k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B945FF8016D;
	Fri,  9 Sep 2022 11:42:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 11410F8023A; Fri,  9 Sep 2022 11:42:37 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D68ECF8011C
 for <alsa-devel@alsa-project.org>; Fri,  9 Sep 2022 11:42:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D68ECF8011C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="xP9k++dx"
Received: by mail-wr1-x42c.google.com with SMTP id bj14so1754072wrb.12
 for <alsa-devel@alsa-project.org>; Fri, 09 Sep 2022 02:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date;
 bh=JS0Czy7dsUI1cWCRoLjh3QMDTfvpIvOi8LnTDYzrDZ0=;
 b=xP9k++dx7d5LLlwEg98W3EOH+AzIBtMr+JHYdIyjEPUAbvI+red0aOZMzFTj97yEg4
 J/YmlC2Fyvo3OuKGiXm8YqLofQmqpWv9F3aeyayGRbY2g7Sq98oFmhKhryue7TB1k6Hq
 N3GeWWxQCzWsKxy+pGQiK5G0+b1JL+zsKqzWJZVBaKc768padgEjV6zS1QGqyR9wUkDQ
 hXpzsfNtcPZ0b8G21/DlfnJl8tg4xpV1FTQbnxegc/Xu9Mudk9/QUhEDwP6GZw4oIVl4
 taXstMfHj/KQF1CYqgWwlxpzLQ1PZmW5pzJDwuB+31dHUZH6Gwy97bnmJ/2XTL4VVG5A
 JoBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=JS0Czy7dsUI1cWCRoLjh3QMDTfvpIvOi8LnTDYzrDZ0=;
 b=4MNdSruHpuO4d1duqhC1dkr/Y975wleDBOFFieuU//gh5VmrG0hpyk1vuXZnyCcryb
 9PPPIPjLkUP4fqK1uccRZ7SLJuHjnidbXWvVYU/YOmUtOUOWPXEJc4orr7L+ArO+sGGu
 h4wvIEp2VM0oIhsrGlaqL1pXTHEfDtJNx/zTDm7XwcTWts/EhkypSJSio0/FFjQKpQpT
 n4mJ1h8hIES2t6QROnZX4qadwC9VnJmY6i1CoDRqbPZVV3huFqfGWUp3lRjAac2tvq66
 xo/R0a7Ub8WVcx5XYzAuyums+s7foC9ReoyIEC/TxyMExAWulvEya/KCFawWfvoCukX3
 muSg==
X-Gm-Message-State: ACgBeo0kyD8zj/thZuXefBiSsVy3R0QcOp40ISSseW/Ko2bWtInzLsCc
 QygPZPdbHHACe5V20IIldk5nhA==
X-Google-Smtp-Source: AA6agR5TOXDSJeXNS8ameg/jXPtMSLz7G7W0z8By9yV5czl7eFUQKgNjyqjiM/lafjuNn/JAFIwKuA==
X-Received: by 2002:adf:d1e4:0:b0:22a:34a4:79ab with SMTP id
 g4-20020adfd1e4000000b0022a34a479abmr3438748wrd.188.1662716548864; 
 Fri, 09 Sep 2022 02:42:28 -0700 (PDT)
Received: from [192.168.86.238]
 (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
 by smtp.googlemail.com with ESMTPSA id
 p27-20020a05600c1d9b00b003b340cca018sm100814wms.16.2022.09.09.02.42.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Sep 2022 02:42:28 -0700 (PDT)
Message-ID: <983d552e-1dd1-8881-47e5-5d3e8bfdefb3@linaro.org>
Date: Fri, 9 Sep 2022 10:42:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/3] slimbus: qcom-ngd: use correct error in message of
 pdr_add_lookup() failure
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
References: <20220830175207.13315-1-krzysztof.kozlowski@linaro.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220830175207.13315-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: stable@vger.kernel.org
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



On 30/08/2022 18:52, Krzysztof Kozlowski wrote:
> Use correct error code, instead of previous 'ret' value, when printing
> error from pdr_add_lookup() failure.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: e1ae85e1830e ("slimbus: qcom-ngd-ctrl: add Protection Domain Restart Support")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
Applied all thanks,

--srini
> Changes since v1:
> 1. Correct typo
> 2. Return 'ret' instead of again PTR_ERR
> ---
>   drivers/slimbus/qcom-ngd-ctrl.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
> index 0aa8408464ad..f4f330b9fa72 100644
> --- a/drivers/slimbus/qcom-ngd-ctrl.c
> +++ b/drivers/slimbus/qcom-ngd-ctrl.c
> @@ -1581,8 +1581,9 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
>   
>   	pds = pdr_add_lookup(ctrl->pdr, "avs/audio", "msm/adsp/audio_pd");
>   	if (IS_ERR(pds) && PTR_ERR(pds) != -EALREADY) {
> +		ret = PTR_ERR(pds);
>   		dev_err(dev, "pdr add lookup failed: %d\n", ret);
> -		return PTR_ERR(pds);
> +		return ret;
>   	}
>   
>   	platform_driver_register(&qcom_slim_ngd_driver);
