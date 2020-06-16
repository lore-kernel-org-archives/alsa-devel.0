Return-Path: <SRS0=xZai=75=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB623C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Jun 2020 08:26:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4655D20767
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Jun 2020 08:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rTtDUPwD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b1kHUj6w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4655D20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C290A167C;
	Tue, 16 Jun 2020 10:26:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C290A167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592296015;
	bh=m5Lnjn5DnOrVjOTGqUTMzRtU8Jd1E/ehTe7PWx2YNpw=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rTtDUPwDiDBhZwstx5J0O1+1ZurCxxE0auGC2G3Yed1olywvFfyuYnTlHfTavHRPh
	 Wdyxh/YIyFRxtU9G1djwtY5uLgB38OMc4+HvJFHPSZMmiGOIHBmdNp2eTICYxxgX1H
	 6tf5XF8Ni9SCI1YF0YYMFXgTzjtIGl56t85b1T1E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3CC42F800EF;
	Tue, 16 Jun 2020 10:26:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4E060F8022B; Tue, 16 Jun 2020 10:26:02 +0200 (CEST)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 55E13F800EF
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2020 10:25:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 55E13F800EF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="b1kHUj6w"
Received: by mail-wr1-x442.google.com with SMTP id j10so19768905wrw.8
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2020 01:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=07xCk+5jY+yVjJJU7xq7mzkwYJS7vzdNmZHffvaVIG8=;
 b=b1kHUj6wycATLgHP2T0yk5ebuvDbaMh0SHv3EO3P7pDMzuuXYJW6HMZWVpdQwLm/Z8
 N0+Yhsobpl7IGNJo9+dWe4cEtOoZZCT4nYLv0qGZy0ySdTxrPx5OgavRJKJDt971Lo9q
 3s4UDyoO68dySXB/GkSTL3MHwb+qU5Lg33s/SWZJr6+oTvfYvSLL/+x1RpNttp92KZmx
 6P624mEVTjnrfy+JPMnh7G3eK7RrpJDCsati3oVWCROJZWv3LcHjB4ztn0h1+Fn5rm15
 jPgq9oBlOUjehpGuIJK49SgqFnYEMq6+OQR9MXDHtvLI4XlA1botlXrUcJFMSoPBH5Se
 PZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=07xCk+5jY+yVjJJU7xq7mzkwYJS7vzdNmZHffvaVIG8=;
 b=YTdqc2jxbdGJRIpZn2vGt9ZSSN903nKxYIDs6k6iwWYWfe5oumRwtyZkaKUUo+UZ9Y
 vodaLNCYyhKLPqiSLeQnoOftvAdg+ecgdyHWBFh+zJOvEn+tYDa3yTADe/hAYXsA7/40
 t/uogxBgCfMLQMofKxQ04ZF3xxLXGHNIjyeuy9kYhy+t3+E9AmT2+pR7bkkicxRVFwv3
 eLbjgks5SHJOdlUh5Y8pGu7Ji4pApgyNkaq4Hi+gb4pQKDJWHgs4X8TfW2YKfmSrn2d5
 BfP5ODacrFLlD+KLb9D9gs4C6DqS0UrFGaoarCRNQXxXxgu/RrbTPlp+L5qP3bXBBnmb
 oJmw==
X-Gm-Message-State: AOAM532jlXwhitksYTt0AqZvIEhFWaF2d8GC8uyfy8A/rRLG3A47BBg6
 G6BvBezkShU0xCAYUqS2fk6bFQiiaGE=
X-Google-Smtp-Source: ABdhPJytHRSw6ChmgjBP9/wCUUzXDWwYWr9dZzrImrRXHR2ZbA+g8UxpOzP42Rf7/PPunUINB/NuTA==
X-Received: by 2002:adf:8b55:: with SMTP id v21mr1850235wra.187.1592295953987; 
 Tue, 16 Jun 2020 01:25:53 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id q5sm27940039wrm.62.2020.06.16.01.25.52
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jun 2020 01:25:53 -0700 (PDT)
Subject: Re: [RESENDx2][PATCH] sound: qcom: Kconfig: Tweak dependencies on
 SND_SOC_SDM845
To: John Stultz <john.stultz@linaro.org>, lkml <linux-kernel@vger.kernel.org>
References: <20200616063417.110263-1-john.stultz@linaro.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <8f7f563b-fae7-e25e-33f2-18c608c338e6@linaro.org>
Date: Tue, 16 Jun 2020 09:25:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200616063417.110263-1-john.stultz@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rohit kumar <rohitkr@codeaurora.org>
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



On 16/06/2020 07:34, John Stultz wrote:
> CROS_EC isn't strictly required for audio to work
> on other SDM845 platforms (like the Dragonboard 845c).
> 
> So lets remove the dependency and select the related
> CROS_EC options if CROS_EC is already enabled.

Sorry John, totally missed this one out!

> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Rohit kumar <rohitkr@codeaurora.org>
> Cc: Patrick Lai <plai@codeaurora.org>
> Cc: Banajit Goswami <bgoswami@codeaurora.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>   sound/soc/qcom/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index f51b28d1b94d..0434f2c7d746 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -99,12 +99,12 @@ config SND_SOC_MSM8996
>   
>   config SND_SOC_SDM845
>   	tristate "SoC Machine driver for SDM845 boards"
> -	depends on QCOM_APR && CROS_EC && I2C && SOUNDWIRE
> +	depends on QCOM_APR && I2C && SOUNDWIRE
>   	select SND_SOC_QDSP6
>   	select SND_SOC_QCOM_COMMON
>   	select SND_SOC_RT5663
>   	select SND_SOC_MAX98927
> -	select SND_SOC_CROS_EC_CODEC
> +	select SND_SOC_CROS_EC_CODEC if CROS_EC

Isn't "imply SND_SOC_CROS_EC_CODEC" better option here?

--srini

>   	help
>   	  To add support for audio on Qualcomm Technologies Inc.
>   	  SDM845 SoC-based systems.
> 
