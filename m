Return-Path: <SRS0=rm39=JM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8288AC43460
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Apr 2021 09:35:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC3D613A9
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Apr 2021 09:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC3D613A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 89BB5165E;
	Thu, 15 Apr 2021 11:34:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 89BB5165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618479327;
	bh=y2HjaAxLOY/RvfV2o9rsvAcwLrmvBIIdplEDPiGFOQE=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TLd7SpDGoO5/JBS553dtsy07lpDBYHwxI35Pivg6ihwCZtR4XmnUs2alIUOrUs7jS
	 1YpL5YIgdv3dJ1fHqwt1jAIDkC7gfzMOx7I38K042BaODXfZ4GN9ezRKilY4vXNtgI
	 2NPCmPgE2ubMyewHkL3HYAv6kXWxZXvXOtZXhV7E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A52DF8021D;
	Thu, 15 Apr 2021 11:34:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ADBEEF8022B; Thu, 15 Apr 2021 11:34:35 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 67455F800FF
 for <alsa-devel@alsa-project.org>; Thu, 15 Apr 2021 11:34:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 67455F800FF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="PyHZ361h"
Received: by mail-ed1-x52e.google.com with SMTP id g17so26501541edm.6
 for <alsa-devel@alsa-project.org>; Thu, 15 Apr 2021 02:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=iL+/YWRONOKDWm29EOJng2/4nOqHH8GQEwRgLaBED28=;
 b=PyHZ361hIf/uOGkKqd5o5jFCXr4+E4XU1FaT4zV1ZL2S9z4MyYU4K4iIUM7NS99Ojk
 eNyc2pToNFcDq84ytnRig615zEWE9pzalGdUu3STQXXDo/6v/r4QLNOGqSWUqSRrxq+d
 wYt91HCVtzngrBj8S/5iQexncyQi8JXEitLvEuKMIx9mn3tfszeycmVQ0orDatz5cYb/
 o3qHEJcGXRgwMThcb/LjECYv8iRI1R1KyJEzu2jeAv9wd3oTe5cBdKH2oM3VaeZoZ/UX
 NQst9E/9UvkVW/36JVcWKGBJHLTPe51uUcxn4WkDqgKPIlp6j3vDJbXu81we/pBfoRHJ
 C/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iL+/YWRONOKDWm29EOJng2/4nOqHH8GQEwRgLaBED28=;
 b=jjRb0UgNlbjoXkZ+IEt53ki3pyUqBllNAw/NX01Q+UAimBbFEXBROAb8Yt+4VIuEOH
 HpOhLbkvnCOZyM6m+pry4IQ5JfaMoY6tlqxRTdEDmY/staq5450DTvFXBmQgv7jGWNBv
 9fMeQxvN3IgQkYEJgzNf9y39r6vbSF6Uzrsw6HnHsEnm+e4Dy/5AF3Q03DWEb/mLItcH
 qJbzT3REmX6CK4mEWoZbTn/xQMyYb8e0PY6Fpd5pHwqlAV0j+Iecf7qkaXVwG5HhlNX8
 pDLSCx8avtE/nwx7Xw8j5HWzfQBxxhxopRn85fl4eP0b5lii6PPnd2WkshOA+jUw3+gT
 36tQ==
X-Gm-Message-State: AOAM530t2JG0ihCZfxya8+1Xmp4TkKYX58Vy+hdMvP53R8NV/En7WxR2
 Rd7Z3G2wutmINiKp7IbXeuENPg==
X-Google-Smtp-Source: ABdhPJzbzdr5JKHdphRKHk2aq73XSes8K8QhG5RTuhJNa/WuYZ0U0Pu7Omr9dZkxNIYDUYgqfBdGYw==
X-Received: by 2002:aa7:d688:: with SMTP id d8mr3034976edr.294.1618479262623; 
 Thu, 15 Apr 2021 02:34:22 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.googlemail.com with ESMTPSA id n3sm1479849ejj.113.2021.04.15.02.34.21
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 15 Apr 2021 02:34:22 -0700 (PDT)
Subject: Re: [PATCH] ASoC: codecs: wcd934x: Fix missing IRQF_ONESHOT as only
 threaded handler
To: zhuguangqing83@gmail.com, Banajit Goswami <bgoswami@codeaurora.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org
References: <20210415073829.22750-1-zhuguangqing83@gmail.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <896527ac-0e94-b930-80ec-8c7ef669b149@linaro.org>
Date: Thu, 15 Apr 2021 10:34:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210415073829.22750-1-zhuguangqing83@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
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



On 15/04/2021 08:38, zhuguangqing83@gmail.com wrote:
> From: Guangqing Zhu <zhuguangqing83@gmail.com>
> 
> Coccinelle noticed:
>    sound/soc/codecs/wcd934x.c:5041:7-32: ERROR: Threaded IRQ with no primary
> handler requested without IRQF_ONESHOT
> 
> Signed-off-by: Guangqing Zhu <zhuguangqing83@gmail.com>
> ---

Thanks for the patch,

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

>   sound/soc/codecs/wcd934x.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
> index 5fe403307b72..cddc49bbb7f6 100644
> --- a/sound/soc/codecs/wcd934x.c
> +++ b/sound/soc/codecs/wcd934x.c
> @@ -5040,7 +5040,7 @@ static int wcd934x_codec_probe(struct platform_device *pdev)
>   
>   	ret = devm_request_threaded_irq(dev, irq, NULL,
>   					wcd934x_slim_irq_handler,
> -					IRQF_TRIGGER_RISING,
> +					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>   					"slim", wcd);
>   	if (ret) {
>   		dev_err(dev, "Failed to request slimbus irq\n");
> 
