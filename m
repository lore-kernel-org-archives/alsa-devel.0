Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985D7C61DA4
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Feb 2023 14:42:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2FF78EA4;
	Wed, 22 Feb 2023 15:41:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2FF78EA4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1677076927;
	bh=/gq/wg4PgL+QwiCI75bs4C3MaTHXOUmYUEBoAhkYQuU=;
	h=Date:Subject:To:References:From:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=cCjZMkuVxzwgV9Qpl/3Y5TMvAbBhPbrdZQQ9xV3Y2/bgtZPOpBp3hdgWtGyf7qKAG
	 ZM0XszrvzqTMbnHmY65W/hsvUru0oTH0U4Y7aZlZOpDZ0khhT8yvKcCO7hKszI6QVd
	 PhKAZpnBo6W4CeI3qOwJwCdV3Ji5hKs0BRGOglJA=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AE42DF80266;
	Wed, 22 Feb 2023 15:41:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8AB71F80266; Wed, 22 Feb 2023 15:40:57 +0100 (CET)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 28F17F80125
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2023 15:40:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 28F17F80125
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=VPBJFAXy
Received: by mail-lf1-x135.google.com with SMTP id f41so10272501lfv.13
        for <alsa-devel@alsa-project.org>;
 Wed, 22 Feb 2023 06:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PvLTXVhFf+9UO9yJz50JTAIFh9uNCAolWXsnSIodUYI=;
        b=VPBJFAXyNbqDjZxq9pO/ZNoH2BJ8eEOKyOGnzkifVboY9avrnNrKkYlKM1Y+FIkiTw
         ggz/lsxUmzfqnR2xmvyy6zckac8EjkrGhtRXkRjXH0Id+/yG42kdjUWUVh1IAJTfn0oV
         rKwcRDzWZm6zcZbYS7zH//wWIYmZsV8eqSFmng4fSxqnwJbmTsQMKs6hPRowXdxyzdfU
         t39+rSq39OMJkvy/MLh+bHSlrFSIsNq2LrWyEIdTZJtNibYJOyOqw6pVjA2+Ih6e5zoi
         9m/4Vm4n6bzWtoBa3BY9M/nNAE/CwS9LZEInrNl+v5DhVzE2zGPjNNTEJ7MyQ5TOaIIE
         voTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PvLTXVhFf+9UO9yJz50JTAIFh9uNCAolWXsnSIodUYI=;
        b=7K5zRyiQlra/r99h8ha0AuFI2iUgT1HtppKyvW8iI6uWpZMBWSYxVKtrI+NNghevYq
         LKnfm0OM66cgmvy4rfC+C4LWCdgPgVbQgFqKYCyk1u+Lw9+mt+Z46XLTp5RHgDizOeQN
         2kVHt1R+diMqottFwAEqE7J/DETUxoV/QkmDQ4r2IHg6qc0PAEUrwOSEN34Lkt3xdwgp
         K0kEQ8NvgshMh4HYdnRULSEMMyDFYQyF+YHOQO6LaPtWQlLTK+NC4hbwtkTOuK8v7lVl
         6DxglDNFokFs8lKOlc2tVoj2e69IzLziNiRpioF+KaR8ctH33s6z8ILM3d0lNeCliS46
         WsHg==
X-Gm-Message-State: AO0yUKWeWbHiAGOVFdw7G9HUlHF5ors0FaFb0n45NOQgXTiFMU6BAMNi
	uVV4DNz7FrBP828sPQgk8uCicg==
X-Google-Smtp-Source: 
 AK7set9tbOG1JDa7ON96GIX0/P9bCWVAB5FYV2Dl3q9zTf2BKn/G3+lDGlHuV1sEnIwqqksw55SqdQ==
X-Received: by 2002:ac2:5298:0:b0:4da:9b7d:637e with SMTP id
 q24-20020ac25298000000b004da9b7d637emr2890097lfm.42.1677076850982;
        Wed, 22 Feb 2023 06:40:50 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id
 8-20020ac24848000000b004db250355b3sm479255lfy.138.2023.02.22.06.40.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 06:40:50 -0800 (PST)
Message-ID: <f1d78b2a-f9ae-6a46-4db6-25e0b823ac46@linaro.org>
Date: Wed, 22 Feb 2023 15:40:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] soundwire: qcom: correct setting ignore bit on v1.5.1
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
References: <20230222140343.188691-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230222140343.188691-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: Q64BQXQYVZCQ4VQAP3RG7TZZMW76FN6L
X-Message-ID-Hash: Q64BQXQYVZCQ4VQAP3RG7TZZMW76FN6L
X-MailFrom: konrad.dybcio@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: stable@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Q64BQXQYVZCQ4VQAP3RG7TZZMW76FN6L/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 22.02.2023 15:03, Krzysztof Kozlowski wrote:
> According to the comment and to downstream sources, the
> SWRM_CONTINUE_EXEC_ON_CMD_IGNORE in SWRM_CMD_FIFO_CFG_ADDR register
> should be set for v1.5.1 and newer, so fix the >= operator.
> 
> Fixes: 542d3491cdd7 ("soundwire: qcom: set continue execution flag for ignored commands")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/soundwire/qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index d5b73b7f98bf..29035cf15407 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -733,7 +733,7 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
>  	}
>  
>  	/* Configure number of retries of a read/write cmd */
> -	if (ctrl->version > 0x01050001) {
> +	if (ctrl->version >= 0x01050001) {
>  		/* Only for versions >= 1.5.1 */
>  		ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CFG_ADDR,
>  				SWRM_RD_WR_CMD_RETRIES |
