Return-Path: <SRS0=OoyA=6A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0266DC352BE
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Apr 2020 07:57:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8541E20784
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Apr 2020 07:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FhOl6whk";
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y7ina6p4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8541E20784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D1B71825;
	Thu, 16 Apr 2020 09:56:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D1B71825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587023841;
	bh=cNDF7qhpMH6pg/+TKeoj+Xr+TAp4cEJH8eMcsN9G2K4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FhOl6whkmEd47RV4b1JpCdf6p1cLfUofqIKGFtgVDya/LGUNobkDfC5YkjAvjmNUN
	 Clx+xIqzO6xo4gMme0hnwN1febC2YLKvFBDhDZ6B//oqHoc5wQvigfulyRGHiQQCu5
	 WkpXcQYRleS75QXHDu4UgDWvEgiP2yf6LrEj6wr0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6D0AFF8013D;
	Thu, 16 Apr 2020 09:56:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C6D93F8016F; Thu, 16 Apr 2020 09:56:27 +0200 (CEST)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6456DF8012E
 for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2020 09:56:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6456DF8012E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="Y7ina6p4"
Received: by mail-wr1-x444.google.com with SMTP id k1so3681239wrx.4
 for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2020 00:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=w/Twrrdf4aERctgvRFlbz6BP8MBD5X/Um5Xg9eTKcW8=;
 b=Y7ina6p4jnvrCKgO7lBVPAbioKnXqyuPb3pQ10H3Ixj+9N0m4LLg+Tm/fVFS59rqw1
 54EOJp051uGi2tgLjCH63h+y789rWnGVP14odkxHivl8CwVW8vnzJDff55u0snS+rTY4
 26p4yEbDBSaXjMxKfAZ2vMRjkOxNw/JNRUUJ0zgOfHvTgrqLt+jXSIHtTOeej9Kc0fgw
 oM/xfp3zTfich3szdVe5k0+Z8fm4AuY0pQu2mskVsvq9x8AyFaFOeO66Bu6qH8zHemWO
 J6IDMhVc2rZjTCaS73ZsSeYve3O4kVqGa/4rAMXEiYCb1GnGimCL0VVWeMlsb8nc178l
 hjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w/Twrrdf4aERctgvRFlbz6BP8MBD5X/Um5Xg9eTKcW8=;
 b=cphCeApQQ4VNfeXpEUtTk1eV4GslPmGSMw3TefAcLxJYneEmyNt7lnpwdne5IhJtNk
 38z4zsUJxOC8F8P8Ks1nxnKFyZuzawXkkPyywjeePrZAK7be/yl4EL0ci9VPdNuI49f1
 EuBPABCaIMiZ5u9+rM/Jk3CUmWBNzBJq1pDmOF9DGgtg6G4+I7G7rtzjkwG0Aatr80/v
 t4VeALb5OOcmNrfHHKbeVM/zeMa+PkzYhDILV2PJE0rNEnX3OCyxETtwp1ySWhnGBshD
 03qCHtLF4NEOzY3BrEob2jxzp2k0ZpvlInOVFUDz/DO0eU/9uFY6UHfPrN8Mda8pA/5m
 MpwA==
X-Gm-Message-State: AGi0Puafqp4a+l99V3jgIwz3zJAARi8md21cgKjHaQq5iq6F40g4Uj3y
 I6fslN2pdpr/1jiTfWo2O05JOg==
X-Google-Smtp-Source: APiQypIndcDNGYipdeHfDJwCf7g8gYyRPAsL3CbpsAhYIuPXR/ssSsok1DLHdVgKoNzj+vRBsfocKQ==
X-Received: by 2002:a5d:44c6:: with SMTP id z6mr26438709wrr.192.1587023776920; 
 Thu, 16 Apr 2020 00:56:16 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id s6sm2598117wmh.17.2020.04.16.00.56.15
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 16 Apr 2020 00:56:16 -0700 (PDT)
Subject: Re: [PATCH 11/11] ASoC: qcom: lpass-platform: Replace card->dev with
 component->dev
To: Ajit Pandey <ajitp@codeaurora.org>, alsa-devel@alsa-project.org,
 broonie@kernel.org, devicetree@vger.kernel.org, plai@codeaurora.org,
 bgoswami@codeaurora.org
References: <1586592171-31644-1-git-send-email-ajitp@codeaurora.org>
 <1586592171-31644-12-git-send-email-ajitp@codeaurora.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <08277130-ed31-837e-a8b1-9e71fb1b6989@linaro.org>
Date: Thu, 16 Apr 2020 08:56:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1586592171-31644-12-git-send-email-ajitp@codeaurora.org>
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
> We are allocating dma memory for component->dev but trying to mmap
> such memory for substream->pcm->card->dev. Replace device argument
> in mmap with component->dev to fix this.
> 
> Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>

Probably a fixes tag here,

Fixes: c5c8635a0471("ASoC: qcom: Add LPASS platform driver")

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   sound/soc/qcom/lpass-platform.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
> index 821599e..9ab2dd5 100644
> --- a/sound/soc/qcom/lpass-platform.c
> +++ b/sound/soc/qcom/lpass-platform.c
> @@ -401,9 +401,8 @@ static int lpass_platform_pcmops_mmap(struct snd_soc_component *component,
>   {
>   	struct snd_pcm_runtime *runtime = substream->runtime;
>   
> -	return dma_mmap_coherent(substream->pcm->card->dev, vma,
> -			runtime->dma_area, runtime->dma_addr,
> -			runtime->dma_bytes);
> +	return dma_mmap_coherent(component->dev, vma, runtime->dma_area,
> +				 runtime->dma_addr, runtime->dma_bytes);
>   }
>   
>   static irqreturn_t lpass_dma_interrupt_handler(
> 
