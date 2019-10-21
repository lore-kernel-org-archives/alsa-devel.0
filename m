Return-Path: <SRS0=cpJH=YO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31E1CA9EB5
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Oct 2019 09:34:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB2A2089C
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Oct 2019 09:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dFsGlAEH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GvM8GedZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB2A2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5A32D166C;
	Mon, 21 Oct 2019 11:33:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5A32D166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571650454;
	bh=f0Y9vpOGrdXhcSHCalzW6CwgvGrIN07EKiF/CTvcUXc=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dFsGlAEHmD3L4k2nSNqPQb4JCY3qLi/W6BetFo50Pe5gjtb8pcHoSbUS07NOV97Ri
	 dPx27MTRP8cdzgZG/0qRmrTlbq7wlZ6px4x87f3HxGHeia7ED/QjQWeZc8A6NM+/IH
	 IxxS+X/xUmdqgs9qlz3aKvxOBbDK6oMYHtqlq4Zs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 88611F80112;
	Mon, 21 Oct 2019 11:32:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C23B5F80444; Mon, 21 Oct 2019 11:32:32 +0200 (CEST)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 50919F80112
 for <alsa-devel@alsa-project.org>; Mon, 21 Oct 2019 11:32:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 50919F80112
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="GvM8GedZ"
Received: by mail-wr1-x442.google.com with SMTP id r1so3263266wrs.9
 for <alsa-devel@alsa-project.org>; Mon, 21 Oct 2019 02:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=d5bdX8xeuW9qs28DpqOcFZGihG4/KfD6OFklKeD5tNY=;
 b=GvM8GedZ070Ew4R5fuWq9/BrMuHCOCcn1gvw4apY1gGPcMk5I3A9JaCWc9MKsJOs8F
 D4rd9PQm15UZ3NVtH6TYpmo6V73jFuD50Emr7tMcLy3eekQjFZ+caBjHx1he6NtmABO3
 fJEDi3vo8ORhUNNThiBupAi3zRa+Tai4KU7SAU58M9kZ1bVyneQVoIW/c8UvxLfpRqPZ
 ELmDI6Heall1c2P73/5Y+xc8StwPd7WykFxWp9RlSV6BAAVQZPr4JSxTgDMQJ/Yhvm1F
 7SDeOztFGTOw2F7WG18EpTVy881H0a6DQhOlGcNBPASAKtk1B0v5tCwRTR9Boysq/LTB
 rUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=d5bdX8xeuW9qs28DpqOcFZGihG4/KfD6OFklKeD5tNY=;
 b=pDLLNiHfuSvL1Z+opxAKilNP4BDTSNnCdP2yPvA64sizCR4Fg5llNoSEihlUpXvKCd
 /mXA/9p17v6epTIGyZRboQLrqki8guuLHMkKgikOY9LnT8YSnpu2L8c0lONPG93HJuMt
 f/FeMNDileJpI/yzltnTMMdOBTF5UQyY182dJGpZhCBQpDUvwjH5uB79X7whfBWl9X1A
 d5Yvu6R5iP5ZgKK1QncakMuIKKDWSyv2lnoxn0wqiCo1eax8eB5l+JrvyHGCeYY2xsrV
 bb8JbDDFkzselTKndQdhx5UowQHy1l+eiLkTAoKeURefyJ4sH1Cuhojt5EK7Pdmsx3f1
 YiUA==
X-Gm-Message-State: APjAAAW+9j5zclauoh7pekvh8gQcTHTF1k/0QSyUDfabqyZBfFuAbB5X
 DIpZvhlj1Vb67FTSegwb/Sfbvg==
X-Google-Smtp-Source: APXvYqz73fCx504enzShzr5TeqfdSYt+cbgtZUgqC7BWiCCPlAuDB0lzryLp5L6I99ZiK2mLcCGgjw==
X-Received: by 2002:a5d:4d85:: with SMTP id b5mr4598892wru.248.1571650346232; 
 Mon, 21 Oct 2019 02:32:26 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id a2sm1604111wrv.39.2019.10.21.02.32.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Oct 2019 02:32:25 -0700 (PDT)
To: Stephan Gerhold <stephan@gerhold.net>, Mark Brown <broonie@kernel.org>
References: <20191020153007.206070-1-stephan@gerhold.net>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <b23e4ca0-467c-00da-9abe-1f9ff1ffbc91@linaro.org>
Date: Mon, 21 Oct 2019 10:32:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191020153007.206070-1-stephan@gerhold.net>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: msm8916-wcd-analog: Fix RX1
 selection in RDAC2 MUX
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 20/10/2019 16:30, Stephan Gerhold wrote:
> According to the PM8916 Hardware Register Description,
> CDC_D_CDC_CONN_HPHR_DAC_CTL has only a single bit (RX_SEL)
> to switch between RX1 (0) and RX2 (1). It is not possible to
> disable it entirely to achieve the "ZERO" state.
> 
> However, at the moment the "RDAC2 MUX" mixer defines three possible
> values ("ZERO", "RX2" and "RX1"). Setting the mixer to "ZERO"
> actually configures it to RX1. Setting the mixer to "RX1" has
> (seemingly) no effect.
> 
> Remove "ZERO" and replace it with "RX1" to fix this.
> 
> Fixes: 585e881e5b9e ("ASoC: codecs: Add msm8916-wcd analog codec")
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Thanks for the patch, Nice catch!

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


> ---
>   sound/soc/codecs/msm8916-wcd-analog.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
> index 667e9f73aba3..e3d311fb510e 100644
> --- a/sound/soc/codecs/msm8916-wcd-analog.c
> +++ b/sound/soc/codecs/msm8916-wcd-analog.c
> @@ -306,7 +306,7 @@ struct pm8916_wcd_analog_priv {
>   };
>   
>   static const char *const adc2_mux_text[] = { "ZERO", "INP2", "INP3" };
> -static const char *const rdac2_mux_text[] = { "ZERO", "RX2", "RX1" };
> +static const char *const rdac2_mux_text[] = { "RX1", "RX2" };
>   static const char *const hph_text[] = { "ZERO", "Switch", };
>   
>   static const struct soc_enum hph_enum = SOC_ENUM_SINGLE_VIRT(
> @@ -321,7 +321,7 @@ static const struct soc_enum adc2_enum = SOC_ENUM_SINGLE_VIRT(
>   
>   /* RDAC2 MUX */
>   static const struct soc_enum rdac2_mux_enum = SOC_ENUM_SINGLE(
> -			CDC_D_CDC_CONN_HPHR_DAC_CTL, 0, 3, rdac2_mux_text);
> +			CDC_D_CDC_CONN_HPHR_DAC_CTL, 0, 2, rdac2_mux_text);
>   
>   static const struct snd_kcontrol_new spkr_switch[] = {
>   	SOC_DAPM_SINGLE("Switch", CDC_A_SPKR_DAC_CTL, 7, 1, 0)
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
