Return-Path: <SRS0=LtCP=G4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88836C433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Jan 2021 11:03:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAD5822582
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Jan 2021 11:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD5822582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D24DA1824;
	Mon, 25 Jan 2021 12:02:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D24DA1824
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611572629;
	bh=gj0Ks7hZo76F7shG5Fn37MIYJlgkfBqJXJyD0Ajh+nc=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bMuooo/Lhvy+04F71GZ9L/2xeByQBjTjVJukqwU8rqILfMnjbozcU+Q97fJNPZoXZ
	 f4ZaHycFK3kcXLW5COon3VMu+Vz4+TpFNPYBGa3hbXfwOk/UVphnvovyGGbS1sj9lS
	 QUrgQ/2wkNB9gZf0iT7T8HSq2asJYR5FjemBxdwo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 33D29F80260;
	Mon, 25 Jan 2021 12:02:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A17CEF80269; Mon, 25 Jan 2021 12:02:10 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8A4F1F80260
 for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2021 12:02:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8A4F1F80260
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="Ublwv7Qw"
Received: by mail-wr1-x42f.google.com with SMTP id c12so11845532wrc.7
 for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2021 03:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QzNdvpuosJC1QOTYxaF9mnk8zwfeuLCY8x44QLcC2F0=;
 b=Ublwv7QwOtZx1uxcx2883w0d2nqOWKq1KUCxoOVnrP0xOli6xYYAk+APHo/RjzFf3W
 qcTl3EsU9sQaAlxNjjuvFoWioVKUWn/kXb3RgPNOT0whlHpNxF8bDWmvDzXa1tpPjf1F
 546yZiDNcrduNHlw6EO0r88Xjo17v5yvraxCZe/m3jag4H2FbJy0WeJ/BpzPvEEJL8UC
 Y5LVE4QNKmyAqmcpHHnluhs8M6oJ/Bp11aZuCYOjxlfNn/UXT94Xlh0lqbMjwJONfVmo
 WiHIe/JG+3z0+/vkRHU/XxAsMugvBOdwwz3wndHXjTMXT6rzgGBLGN6TI+PSKkAVUAAb
 Of5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QzNdvpuosJC1QOTYxaF9mnk8zwfeuLCY8x44QLcC2F0=;
 b=Jw9/Po17OGlycqAW6R/EXpXu4+POeX88LOxaDLja7mhvy+upKdDt3ZomJspQWwmutE
 G32em2PXs2rT3jUeu0jPaCb4WVeI0w8EIv3NmONtib7Rq6i+cm5yWcSjq9R4phYd/qQw
 BgR/3Id3v9fuHsb7fUskTP5qRnoYL/KcAPLwEVcb6wX7yvKtXbAeOqLAN0CnCjuK3dX4
 FT3AT5Lrrk8k4A6hR3EDrKZbUzGE6U19XwH60n6wyV60zTfmvprxdPjCkE22qCRQJPND
 i7fziHbV45UsG69qMciIcwOQHmZVql7/QYvTgJrjw7uMgCk2bO5USh7KPZGiGmSbGQ/T
 fMhQ==
X-Gm-Message-State: AOAM531GZ7WES/6SPEZXi2Y7/Dfus5zUw4Tnwbh6e7YFtEch/1eRsYI6
 8isiCR0Bq5k0aJu7Tpv7Rw2IFEExqDHBnw==
X-Google-Smtp-Source: ABdhPJyo6sA1ajml4sQhzVFkmLGYUmoWEDEadH/roslTdA7KjTBOO0WOKjxWSZHSSyG3MMzZLuOBRQ==
X-Received: by 2002:adf:ba8b:: with SMTP id p11mr288091wrg.328.1611572520192; 
 Mon, 25 Jan 2021 03:02:00 -0800 (PST)
Received: from [192.168.86.34]
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.googlemail.com with ESMTPSA id o124sm21309132wmb.5.2021.01.25.03.01.59
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 Jan 2021 03:01:59 -0800 (PST)
Subject: Re: [PATCH v2] ASoC: qcom: lpass: Fix i2s ctl register bit map
To: Jun Nie <jun.nie@linaro.org>
References: <20210120024955.3911891-1-jun.nie@linaro.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <07d8fa7e-717b-2d88-4616-40656be6d340@linaro.org>
Date: Mon, 25 Jan 2021 11:01:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210120024955.3911891-1-jun.nie@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: plai@codeaurora.org, bgoswami@codeaurora.org, alsa-devel@alsa-project.org
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



On 20/01/2021 02:49, Jun Nie wrote:
> Fix bitwidth mapping in i2s ctl register per APQ8016 document.
> Fixes: b5022a36d28f ("ASoC: qcom: lpass: Use regmap_field for i2sctl and
> dmactl registers")
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   sound/soc/qcom/lpass-apq8016.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/lpass-apq8016.c b/sound/soc/qcom/lpass-apq8016.c
> index 8507ef8f6679..3efa133d1c64 100644
> --- a/sound/soc/qcom/lpass-apq8016.c
> +++ b/sound/soc/qcom/lpass-apq8016.c
> @@ -250,7 +250,7 @@ static struct lpass_variant apq8016_data = {
>   	.micmode		= REG_FIELD_ID(0x1000, 4, 7, 4, 0x1000),
>   	.micmono		= REG_FIELD_ID(0x1000, 3, 3, 4, 0x1000),
>   	.wssrc			= REG_FIELD_ID(0x1000, 2, 2, 4, 0x1000),
> -	.bitwidth		= REG_FIELD_ID(0x1000, 0, 0, 4, 0x1000),
> +	.bitwidth		= REG_FIELD_ID(0x1000, 0, 1, 4, 0x1000),
>   
>   	.rdma_dyncclk		= REG_FIELD_ID(0x8400, 12, 12, 2, 0x1000),
>   	.rdma_bursten		= REG_FIELD_ID(0x8400, 11, 11, 2, 0x1000),
> 
