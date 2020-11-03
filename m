Return-Path: <SRS0=G+7e=EJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1EDC388F7
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:32:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01DF122226
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SI4QBxFL";
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yjlArQ+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01DF122226
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7897D16B5;
	Tue,  3 Nov 2020 13:31:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7897D16B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604406729;
	bh=ReO4w5jCQQvBQ3u859v5xMaUwjdpS9DMlOpngKT1MRY=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SI4QBxFLOq71fmd1Ir4HcgZJ59K7O2HCc3smCUW0eT7F9JY/UjjFaaxGNy5XXs/AO
	 7c9T1d6JLtniwKjA7BOYaW1yluoObYCXhz3e8VjucsDfdn6YBm2WQ/BDJUJi6NxJQa
	 UJyaX8Pns5XTr/FUDCgNtzBxfN6751EGoqGnZl3c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E85D8F80162;
	Tue,  3 Nov 2020 13:31:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 32188F80171; Tue,  3 Nov 2020 13:31:18 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C0F2EF80083
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2020 13:31:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C0F2EF80083
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="yjlArQ+/"
Received: by mail-wm1-x341.google.com with SMTP id p22so12558893wmg.3
 for <alsa-devel@alsa-project.org>; Tue, 03 Nov 2020 04:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SRAmPKxls/K0himBvhIafEeFLCy40iv3c8xY8MMo+5w=;
 b=yjlArQ+/J50s8bIT0wWu8ypN/BiUQy/0+HvAGiCuMVkbaqvaSDd56btEbJhVTNue94
 i8bRRJPnnW5vW8eX3/xpmb/SGRR9BXDYVZlRDRDfW5e7PsDIS6z1O08UVwqkgpVdPHse
 7UoNPwi9PIENXvUZOgMg7UAtWR/uOugicg9LN9i+7BgyZnWdCe8mR+BdnRPQA2oB7Cdv
 egfkGDNHwfZpKPIqjejyKWcgsZXxQd+V78kjkdpUcUj3/glvtuR+/9VyVb0H0idJr6jp
 s9acSbE0kns1kq7v9JPZ+jid6bnXMp5ctt7NG6l1t4437v47zkT+deT2tzrc2VMBa0bv
 s5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SRAmPKxls/K0himBvhIafEeFLCy40iv3c8xY8MMo+5w=;
 b=Sea640FabYUa4M4sU9IH3s23XyfrWItj2mSlIjF2vZtV+1s9s/txNbWj0Lb3AuDCg3
 l4a33gtC/YFQMyUQTjozTVh6WHWAlUjGm8GdsArBqJCwjWHvvsY5SKsobMno3jhhrvqC
 PSLcTQQUqHzBeJHuqKB4E+GhWoFs3134xuh3s0U610NfjuUmNPuboqzkTk2Y+Y07zXDW
 tY5OSK2G6eElW0qtuz5giUiVEenjXORgXVFIkkKfTrE/k1HIQn8WiHae8UPtzUy/VwxU
 KcPGx97Y6tFiEWEPTKN+18AXL+jv9kCICdlunAqMI10eYhE4ueF3Uz2uFIqROGa7Ie1Q
 945w==
X-Gm-Message-State: AOAM53312Qzwv+g9QIWbmv7KAa6LCGWpsZb5616aV9Bf1S2hUOX94//S
 OXQU91T5p7j1i4kzBwt9nOnnAA==
X-Google-Smtp-Source: ABdhPJxmdWrGxJTWPWlxq/H1sagdyoraNtXp2WgDsGGI6NFdA8DHbZBmEeFowvqfv4vpnp14CFZODg==
X-Received: by 2002:a1c:f312:: with SMTP id q18mr3384462wmq.30.1604406668793; 
 Tue, 03 Nov 2020 04:31:08 -0800 (PST)
Received: from [192.168.86.34]
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.googlemail.com with ESMTPSA id t4sm2769160wmb.20.2020.11.03.04.31.07
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 03 Nov 2020 04:31:08 -0800 (PST)
Subject: Re: [PATCH] ASoC: wcd9335: remove unneeded semicolon
To: trix@redhat.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, 
 tiwai@suse.com, kuninori.morimoto.gx@renesas.com
References: <20201101172128.2305539-1-trix@redhat.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <cfedaa82-d61c-0bc5-a960-991fbe5b7449@linaro.org>
Date: Tue, 3 Nov 2020 12:31:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20201101172128.2305539-1-trix@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

Thanks for the patch,

On 01/11/2020 17:21, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> A semicolon is not needed after a switch statement.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   sound/soc/codecs/wcd-clsh-v2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/wcd-clsh-v2.c b/sound/soc/codecs/wcd-clsh-v2.c
> index 817d8259758c..73258e292e7e 100644
> --- a/sound/soc/codecs/wcd-clsh-v2.c
> +++ b/sound/soc/codecs/wcd-clsh-v2.c
> @@ -507,7 +507,7 @@ static bool wcd_clsh_is_state_valid(int state)
>   		return true;
>   	default:
>   		return false;
> -	};
> +	}
>   }
>   
>   /*
> 
