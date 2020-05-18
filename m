Return-Path: <SRS0=lMNw=7A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D84DC433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 18 May 2020 09:12:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A45F420643
	for <alsa-devel@archiver.kernel.org>; Mon, 18 May 2020 09:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rrfGs6/Y";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VFzKOHJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45F420643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 15D6C1684;
	Mon, 18 May 2020 11:11:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 15D6C1684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589793132;
	bh=HyuC8yzk+ODkFkVTvr5QKww6nu4eelOy2W8SdK2Q0cw=;
	h=Subject:To:References:From:Date:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=rrfGs6/YWbzmn/QErYD57lOOdEsxygn+8dHERzzac4CfPXStZefypTmobSkyyTYxM
	 kdMjRUqZlrQJedykWylBJIx3Q4Kv0A+buoikpAVqsqRtxOywW7ibXp/8QGudQqTm9e
	 0vUH8om6n3hhgaYj+O5KdFjhPABB6/Xep6b06zQo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 88755F801D8;
	Mon, 18 May 2020 11:11:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 38752F801DA; Mon, 18 May 2020 11:11:20 +0200 (CEST)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F1A42F80086
 for <alsa-devel@alsa-project.org>; Mon, 18 May 2020 11:11:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1A42F80086
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="VFzKOHJH"
Received: by mail-wm1-x341.google.com with SMTP id g14so21878898wme.1
 for <alsa-devel@alsa-project.org>; Mon, 18 May 2020 02:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=UT/NakiOz79TTv31SXoxdGWEN3c4jFqpw85qdC2FHJc=;
 b=VFzKOHJHnVBl5TytrLIvbXK9Wh5weDcaD3pQVtqaH9sMpErbACKPEA45cmEeb9yFEu
 5gCq9BsgrwHQEp9RsVyRsAQWwTHfKLboS08+qN19kTAxSvG8axIyJ+nquEDA5sj6besl
 wZ7D+cveTRhOZiDkiQEWP3VOWKzDw0KMqd692r7xS9YmTK8t04xm4IqCAuAoCsAmZA+I
 u6Dq45rts4ZrspP27Ok/oHa9exUHGT6CqzGddOE/hS4xUyEV+rbm8eJpDsm2NPUjl84g
 GGh8AouJuW5OvhQXrkyXJOxSPwoHkoyqChNn+tt5O2CZeCcZnbHBfNNF/Elqm1C8Vumz
 1pRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:content-language:content-transfer-encoding;
 bh=UT/NakiOz79TTv31SXoxdGWEN3c4jFqpw85qdC2FHJc=;
 b=RuGhHDo4QJIyd8jMXkXunQcHNxgTwQHE4K7ppFC6ku8bjeSc04k3YpNekbt477a4rV
 7AHQs2KI1E0N5PQcm1Rv6aaVIhogBCakpA3gpsAklbVQOloSnaH8axmedqZ2TiqH/iTE
 KqpxqW2AS05/26XAGEsawfyX/21aB+hJd2y6/EEFlpK56WvEg0Rlbc6VhW+QhD+A9Rrl
 +RCTIV3G25fsRRJg4xGeLYO5rfFA/j5MNpVVqLcdmMvY07mnHz+iZu67pM4fF47nqvve
 yiZRJVprCR0MybnHd3Q6susFEMK7BmiVvsGZv7cSDmI49NbZbtzh2QV4wFO2b20YQ5Df
 qUeg==
X-Gm-Message-State: AOAM532qMKMSJ/WYEiKwu8JNY1CGmyVdt+kY/KnJRzMcRfeySrLKN5ZG
 Jcn86C+mgtyB/9xU7MFhkscDaQ==
X-Google-Smtp-Source: ABdhPJy/RHkH0eD1Wy1QiYVZABv/3WZw1Ug7pLTpaJvHX1SxniVJV7s4jHtULcilesmqqthGQ2LFqQ==
X-Received: by 2002:a1c:ed08:: with SMTP id l8mr13276236wmh.169.1589793068120; 
 Mon, 18 May 2020 02:11:08 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id h1sm16515430wme.42.2020.05.18.02.11.07
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 May 2020 02:11:07 -0700 (PDT)
Subject: Re: [PATCH v2 2/7] ASoC: qcom: Add common array to initialize soc
 based core clocks
To: Ajit Pandey <ajitp@codeaurora.org>, broonie@kernel.org,
 plai@codeaurora.org, bgoswami@codeaurora.org
References: =?UTF-8?Q?=3c=1c1586592171-31644-1-git-send-email-ajitp=40codeau?=
 =?UTF-8?Q?rora=2eorg=1d=3e_=3c1589474298-29437-1-git-send-email-ajitp=40cod?=
 =?UTF-8?Q?eaurora=2eorg=3e_=3c1589474298-29437-4-git-send-email-ajitp=40cod?=
 =?UTF-8?Q?eaurora=2eorg=3e?=
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <aa1ad5a5-94e8-0a6a-1937-e9d2abbb67f7@linaro.org>
Date: Mon, 18 May 2020 10:11:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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


On 14/05/2020 17:38, Ajit Pandey wrote:
> AHB-I/X bus clocks inside LPASS coreis not a mandatory clocks for
> SC7180 soc lpass variants, hence make it an optional one.
> 
> Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
> ---

For some reason patch subject seems messed up!

I see two patches with same subject "[PATCH v2 2/7] ASoC: qcom: Add 
common array to initialize soc based core clocks" and totally different 
content and PATCH v2 3/7 is missing as well!

--srini




>   sound/soc/qcom/lpass-cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
> index e00a4af..729ca78 100644
> --- a/sound/soc/qcom/lpass-cpu.c
> +++ b/sound/soc/qcom/lpass-cpu.c
> @@ -594,7 +594,7 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
>   		}
>   	}
>   
> -	drvdata->ahbix_clk = devm_clk_get(dev, "ahbix-clk");
> +	drvdata->ahbix_clk = devm_clk_get_optional(dev, "ahbix-clk");
>   	if (IS_ERR(drvdata->ahbix_clk)) {
>   		dev_err(dev, "error getting ahbix-clk: %ld\n",
>   			PTR_ERR(drvdata->ahbix_clk));
> 
