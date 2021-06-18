Return-Path: <SRS0=HRrq=LM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4AEC49EA5
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Jun 2021 14:08:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEBCF613F6
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Jun 2021 14:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEBCF613F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3FEB8171E;
	Fri, 18 Jun 2021 16:07:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3FEB8171E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624025328;
	bh=9n+YRcE68xVHgA0LBoi2Wur5SXN2S4LhtfVQbQFCCJs=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EvL+5oU7hzCUaoqOC9dUxIpzvRaKp9fvICGALK7LtYUvN1lkdFY3PrDeiS1QZnaf4
	 yBI6QV1Wujhygtx0gQFrJzaG7vSozu/7q7v+pUmhykaJ+nJDncILOZFaRw/Uy4qMhu
	 cXRl22hPZFScnH3t4p90y8fAxAS3U96A5NzpyHII=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E4672F80424;
	Fri, 18 Jun 2021 16:07:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 526F6F804B0; Fri, 18 Jun 2021 16:07:13 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 00C0CF80423
 for <alsa-devel@alsa-project.org>; Fri, 18 Jun 2021 16:07:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 00C0CF80423
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="ikMGpc/P"
Received: by mail-lf1-x134.google.com with SMTP id i13so16876590lfc.7
 for <alsa-devel@alsa-project.org>; Fri, 18 Jun 2021 07:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/quGoc38c0p0H8/J6lRb7JsKFmpNqxFSoJWjBr7SmOk=;
 b=ikMGpc/P3dIvtrCXQjqZgQvp/vsiCq4YWydduybjNDcgyQ/v9awwdDXyvTsSq6FXGk
 QOQstqHaG6R1cz5XDEE1NJtaUfLfPtMe4I6pqWYB7/Jga7FnaRnNbqmfKIAZ5UmfTljp
 Gh+D5+4jn/iwyAZxvnIWU5IHQX+XswPPL/+9pvGZ554Yc5ovfGys+xdnyREj2uKU2v/6
 urken14llhUP7AcBSQpTa/lGPCZIJqEjgZ1VYkIN2cZHsizWJR5BkPOTkSNJtj8ZvlH1
 HcxdDLDytJA1TJNE/zpkPjHN+OYAEct5UYtcX2w622wdfsGm3ldQf39hrLtXt9XKOALM
 /4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/quGoc38c0p0H8/J6lRb7JsKFmpNqxFSoJWjBr7SmOk=;
 b=hBvaDEqn41MNY2YaAmhhoa1qvvZ9aONuyF7uMuCR2hqb0TzG9e2HXFSGrdd/GJe/aF
 cQLVDZoXmkoExcrCuBG0GOBw0d6Y5GwivNc2y9uNuogHrEsPPkKPe/IMJExdm77C8QKM
 +G8Bxbh+7vEIq5g/kQXA/1C9b62nmHr1oJRCx693Fvu4s4IGsQMSyD36Nix2g2M0bWYi
 xFACX1VTo4iCMV5TMytRRf8SMkL64FPl0UzoPDPyQOAD6Or4fzaYP13ihLlnZJMov+QK
 RHkWDuWx0ZWNqbO9ffifKW5cKqNQ2TuVU/uWGRarD19dwrlI3Z8dM5WXaRQUjSQOHiYw
 86Ag==
X-Gm-Message-State: AOAM532jzSWBSLAqR4VZkIuA0vTpU2lOSQBesvbB7CCds5pWUR6gVEx7
 ue1L7LilC9Wf0n02ovwqARM=
X-Google-Smtp-Source: ABdhPJxVGE2BlZznSkbT7y1/6eEthlVx5uFIqu3gEggxDqgStqSnHNrPmHtE1voW/bVOntR35eiWxw==
X-Received: by 2002:ac2:4219:: with SMTP id y25mr3320437lfh.400.1624025227243; 
 Fri, 18 Jun 2021 07:07:07 -0700 (PDT)
Received: from [192.168.2.145] (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
 by smtp.googlemail.com with ESMTPSA id d15sm922354lfl.199.2021.06.18.07.07.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Jun 2021 07:07:06 -0700 (PDT)
Subject: Re: [PATCH] ASoC: tegra: Fix a NULL vs IS_ERR() check
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
References: <YMyjOKFsPe9SietU@mwanda>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <be3feac7-e829-ab96-a866-1d9c58aa8dcd@gmail.com>
Date: Fri, 18 Jun 2021 17:07:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMyjOKFsPe9SietU@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Svyatoslav Ryhel <clamor95@gmail.com>,
 kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ion Agorria <ion@agorria.com>,
 linux-tegra@vger.kernel.org
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

18.06.2021 16:44, Dan Carpenter пишет:
> The tegra_machine_parse_phandle() function doesn't return NULL, it returns
> error pointers.
> 
> Fixes: cc8f70f56039 ("ASoC: tegra: Unify ASoC machine drivers")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  sound/soc/tegra/tegra_asoc_machine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/tegra/tegra_asoc_machine.c b/sound/soc/tegra/tegra_asoc_machine.c
> index a53aec361a77..735909310a26 100644
> --- a/sound/soc/tegra/tegra_asoc_machine.c
> +++ b/sound/soc/tegra/tegra_asoc_machine.c
> @@ -409,7 +409,7 @@ int tegra_asoc_machine_probe(struct platform_device *pdev)
>  		return PTR_ERR(np_codec);
>  
>  	np_i2s = tegra_machine_parse_phandle(dev, "nvidia,i2s-controller");
> -	if (!np_i2s)
> +	if (IS_ERR(np_i2s))
>  		return PTR_ERR(np_i2s);
>  
>  	card->dai_link->cpus->of_node = np_i2s;
> 

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
