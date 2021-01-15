Return-Path: <SRS0=73/o=GS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736B5C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Jan 2021 14:26:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80DBD23877
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Jan 2021 14:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80DBD23877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A868317B4;
	Fri, 15 Jan 2021 15:25:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A868317B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610720761;
	bh=hWnTiuKGP/AdlhjbjMK4LnIAxL7Z1L2Vhh7QQ/R0Wks=;
	h=Subject:From:To:References:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GNxADwc4Xk4do9c5ODNTQD+sPV52ligKoIEVQNiGp0CWxqOCdiQuFhlHKul0UuHL6
	 bDK+jC86KGoGvNM9dCQfUfNBTtdQFgLcegXruUi93fw6raL5ldQQrjlDoo8n+JMG9m
	 kRIrUcrbRXCmIVjwIXiExdN2cJmjY9diXUBZuTe8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 01E14F8016D;
	Fri, 15 Jan 2021 15:25:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 693A3F801ED; Fri, 15 Jan 2021 15:25:09 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A9B93F80113
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2021 15:25:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A9B93F80113
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="PtZv0SV0"
Received: by mail-lj1-x234.google.com with SMTP id p13so10607505ljg.2
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2021 06:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=B72xa1Z3cOYdg64nqMeoT+FFfbyXEgVFnkRuV0aXWnY=;
 b=PtZv0SV0LObhYS5i8xaO6ZsiV3yoxqB9sr/IRdLTsTnoxaYCmejXmQQHwONCzM8SIy
 ghAONVdW95VGqcvJuBDb6DoCw0LAqvj7CTuG8MYE/eR3GJmfnOjOlnFr6DozuhpklJDI
 JNtl5daB9VhIt3DG+DRp8VWHw+r+INbPN2J6q8iikilympwOhpHwwr7xl0guhOA9dEf6
 tA3rqgTHGxkOFlHz66xuBPI8NjfzOvo7FcPr1/VQX3WCrqdae1A1TR4ISQOdJvvDTpk9
 oKFTsyYXo6bcAvUU4CK98M74WSsoocV/hJVwNFwvWKdMU/XZIkFLevHfppFphCvWM8Hm
 z4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B72xa1Z3cOYdg64nqMeoT+FFfbyXEgVFnkRuV0aXWnY=;
 b=Nik6rHghZ8BoYr7xfMFnY+zKXi4kbzZJPJQhzkg5NpYrOdOhu9OmjjYyIPIFactvXc
 +UopuTHqnh0d/q/HFS9RlncANBLrHXA3lGDV4IdZRa2vQ9HHu49dv/MA1x9JSQbydWuV
 8ZuzhVoK8Kho80DoXcMhkGtJif+s0nTWjLR3iAYGMJF4WHbzsprT2xJK/Kxld8Y5THge
 zXHqrm8m8NxaiWTPLzOKjY7Mc23HJy8dqeSX3QE4O04Ms267+yMYmQbFgOFivsMYLViv
 mc8vwLjCGWJJIcGOn7oFp9vRpcxMaorbudbqVA2Io7/yKLhGCANUSkQUssmGAMzsMfnE
 lDJw==
X-Gm-Message-State: AOAM531GZllGNdKeeTlM1sVl5kW9epNloJyeZkCM7Kcuyk74z9X5SXjV
 Za3rMNtZp+Ek9o8EGOrYaHw=
X-Google-Smtp-Source: ABdhPJyQR8A4raiauC6Oux5Eix29ocPO8hsJ8VWhVtU1B1qTvGdjjVfujN8b7B0ZIe80K7G3SEnPig==
X-Received: by 2002:a2e:9f13:: with SMTP id u19mr5448066ljk.69.1610720703604; 
 Fri, 15 Jan 2021 06:25:03 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru.
 [109.252.192.57])
 by smtp.googlemail.com with ESMTPSA id c3sm824341ljk.88.2021.01.15.06.25.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Jan 2021 06:25:02 -0800 (PST)
Subject: Re: [PATCH v2 5/5] ASoC: tegra: ahub: Reset hardware properly
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Sameer Pujar <spujar@nvidia.com>,
 Peter Geis <pgwipeout@gmail.com>, Nicolas Chauvet <kwizart@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
References: <20210115140145.10668-1-digetx@gmail.com>
 <20210115140145.10668-6-digetx@gmail.com>
Message-ID: <f1a5beae-00c7-5a9c-5189-a52081efd137@gmail.com>
Date: Fri, 15 Jan 2021 17:25:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210115140145.10668-6-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
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

15.01.2021 17:01, Dmitry Osipenko пишет:
> @@ -65,12 +65,32 @@ static int tegra30_ahub_runtime_resume(struct device *dev)
>  {
>  	int ret;
>  
> +	ret = reset_control_assert(ahub->reset);
> +	if (ret)
> +		return ret;
> +
>  	ret = clk_bulk_prepare_enable(ahub->nclocks, ahub->clocks);
>  	if (ret)
>  		return ret;
>  
> +	ret = reset_control_reset(ahub->reset);
> +	if (ret) {
> +		clk_bulk_disable_unprepare(ahub->nclocks, ahub->clocks);
> +		return ret;
> +	}
> +
>  	regcache_cache_only(ahub->regmap_apbif, false);
>  	regcache_cache_only(ahub->regmap_ahub, false);
> +	regcache_mark_dirty(ahub->regmap_apbif);
> +	regcache_mark_dirty(ahub->regmap_ahub);
> +
> +	ret = regcache_sync(ahub->regmap_apbif);
> +	if (ret)
> +		return ret;
> +
> +	ret = regcache_sync(ahub->regmap_ahub);
> +	if (ret)
> +		return ret;
>  

The regcache syncing is corrected now in v2, but I missed to disable the
clocks in the error path :) I'll make a v3 around next Tuesday. If
you'll spot anything else that needs to be improved, please let me know.
