Return-Path: <SRS0=Vpzd=O3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83857C433FE
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Oct 2021 13:55:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D638611EE
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Oct 2021 13:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0D638611EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0C93B1607;
	Thu,  7 Oct 2021 15:54:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0C93B1607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633614941;
	bh=A8+CDLk4FfHH7QEiRnlITvACrbfdq/bY2KnBY4gno/A=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O6P4RYB9auwWTU59j1fD5sXvd4rSZWUCJgqhh6NdbKfE4GCsDuOsm4NxOp3WNWxki
	 6RL/hd6qMq/W2tOoiqF2lKb58NS+/crwSqU+Q3jl1Kpk40/F/WPJ+3m3YJpUIS/cmr
	 tuT6kFSg031G49Dc1cMleGwGdLU8PuJqxPlB9lsE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7970EF80259;
	Thu,  7 Oct 2021 15:54:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 76F34F80130; Thu,  7 Oct 2021 15:54:48 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 15105F800F0
 for <alsa-devel@alsa-project.org>; Thu,  7 Oct 2021 15:54:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 15105F800F0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="dYj5vqnS"
Received: by mail-wr1-x42f.google.com with SMTP id t2so19341790wrb.8
 for <alsa-devel@alsa-project.org>; Thu, 07 Oct 2021 06:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JmI9Xb1yRSSSNlr3bLX03Fwf/+HcWlHnhsZDlHxB6vE=;
 b=dYj5vqnSQwe5DgTOReWWmmfQLM4MrKLltnTo3um2EWr33clCTkzznA4ppLNtrHZjyK
 FWAhLR+4z882pjupUtfHVJlDBp4PXKBOoeQU8I+n/eu5SCdEMWWLrP8UZIvBTPeJTBsd
 0uQMo+o/t29f5eCUd+JnE7sTW1DP1qO0BYA7oGI/1YFxPZ6cJ2yA+UAr8paCBEY+L2J9
 BoLl5aM2Hn3T2G01wLjfjisETY412ydBWjcnw2P9m3xY7ziCi+AvYpe3awHBX5hePijU
 46TPCQvyQ275BnutZ11qBJ2uOgr25e5WycpvgAOsgciZyHe9sFbOs4w/tGP9Tj0S+iUS
 929Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JmI9Xb1yRSSSNlr3bLX03Fwf/+HcWlHnhsZDlHxB6vE=;
 b=sF1XNWdugypv7WLr98HufgrLSdGcy69nQ0vsDh0tRS4la7d/26Xk/w2H6ehkLmCAq/
 /46y6VvnLCdtrH10EsI3Rtn6Z0h5y2fC1zvmBuK+GXq+9y5z+zcRk83SDuOmsRBVUL4s
 3S/BX3ey2HCN6I7nBhw5vSOl8kTogcD7NEpdnfkByPK0dIGyP6EK3HkRTfWWBiPmOop8
 8IFFgV5yp+KYe5U2o4Nd1eTO6fF2ZHV4HeWb8yHkEgi1aULynXwy7dF9lKlj7KGD5USu
 UTY98N0N1DsF4gxZwzsbr0GIzMwWUsYXwgfnYuqJy7eruidnNHkQ3xZd1EuS1aX6+mjY
 ji7g==
X-Gm-Message-State: AOAM533ZsdLHpGCiwDb0FsxG1JAkpB8FK8Lo9qq1TyeXof2ybNE5uZ4z
 z6HC1rHSfvqrrwVwpaB7O6ewKw==
X-Google-Smtp-Source: ABdhPJzvJg/xj+gie63fewWxxYbalLYjwPQBUmTPcgHHReNhtcnYsGUoOl7IeXm9TXMiIZ0ZTQJEgg==
X-Received: by 2002:a1c:1b90:: with SMTP id b138mr4836177wmb.160.1633614879620; 
 Thu, 07 Oct 2021 06:54:39 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.googlemail.com with ESMTPSA id l12sm17979848wro.14.2021.10.07.06.54.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Oct 2021 06:54:39 -0700 (PDT)
Subject: Re: [PATCH] ASoC: wcd938x: Fix jack detection issue
To: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>, agross@kernel.org,
 bjorn.andersson@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
 robh+dt@kernel.org, plai@codeaurora.org, bgoswami@codeaurora.org,
 perex@perex.cz, tiwai@suse.com, rohitkr@codeaurora.org,
 linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 swboyd@chromium.org, judyhsiao@chromium.org
References: <1633614619-27026-1-git-send-email-srivasam@codeaurora.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <ee2e0088-da35-d01e-3207-6bcd41743d30@linaro.org>
Date: Thu, 7 Oct 2021 14:54:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1633614619-27026-1-git-send-email-srivasam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Venkata Prasad Potturu <potturu@codeaurora.org>
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



On 07/10/2021 14:50, Srinivasa Rao Mandadapu wrote:
> This patch is to fix audio 3.5mm jack detection failure
> on wcd938x codec based target.
> 
> Fixes: bcee7ed09b8e (ASoC: codecs: wcd938x: add Multi Button Headset Control support)
> 
> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   sound/soc/codecs/wcd938x.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
> index f0daf8d..52de7d1 100644
> --- a/sound/soc/codecs/wcd938x.c
> +++ b/sound/soc/codecs/wcd938x.c
> @@ -4144,10 +4144,10 @@ static int wcd938x_codec_set_jack(struct snd_soc_component *comp,
>   {
>   	struct wcd938x_priv *wcd = dev_get_drvdata(comp->dev);
>   
> -	if (!jack)
> +	if (jack)
>   		return wcd_mbhc_start(wcd->wcd_mbhc, &wcd->mbhc_cfg, jack);
> -
> -	wcd_mbhc_stop(wcd->wcd_mbhc);
> +	else
> +		wcd_mbhc_stop(wcd->wcd_mbhc);
>   
>   	return 0;
>   }
> 
