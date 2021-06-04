Return-Path: <SRS0=evnw=K6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5EEC07E94
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Jun 2021 07:15:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DF8D61418
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Jun 2021 07:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF8D61418
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E0A181706;
	Fri,  4 Jun 2021 09:14:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E0A181706
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622790950;
	bh=KxTCIp1dwsQB+nSfF9KMYfPybZvStasHtQjN8WOnefU=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XWummvbIHEwFypsasRFnABVdC7T4rG2KsFq7uDh6MlCK9rPfoBATx1f9sZw5gRRVq
	 fg4ZXzWfiKlJ7CTpc0bSiOK63KM9z57+FaoneGIsho8ZMl/V+6htzyvhB3SkL+P6g2
	 pFOFAhplma9mZOtjPoQoMQr9HSl//RlIlKr597QI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 74892F802A9;
	Fri,  4 Jun 2021 09:14:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 85ABAF802C4; Fri,  4 Jun 2021 09:14:58 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 73BE7F800CC
 for <alsa-devel@alsa-project.org>; Fri,  4 Jun 2021 09:14:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 73BE7F800CC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="QgkeChCI"
Received: by mail-lf1-x134.google.com with SMTP id w33so12584579lfu.7
 for <alsa-devel@alsa-project.org>; Fri, 04 Jun 2021 00:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hFVfJJ6Ejdu+Nc6pP4+2Kj/FAk9+HqPn9yXfhDOY5Ro=;
 b=QgkeChCIXwPltaFv0/iPA3nqsD6PxNhw++qgors9r/uV+iU/4fXeTH91YkFwM+fna7
 Voj7VYZEGnJMYqo8Q4pCU7cDDdkvw1GEjFi0ItnLj9pgve+ATxPWSuYU/r0q08XPd3As
 j/9Y1uZiR5rGOrQK4My9s3B7zSOXAa9lGgrb2L5i/vKrL/qzqlJD1jDarMC8E4zKbYLJ
 +Vo/E9UKfDoBevWuyp+sqlxBkJ7mCwiaQlBjNTqqM7AhWpe0zWprPxlAj2jaNb+SaDTa
 T78uQ0gO26GD8eKzOic9Y7Uj/sXuq00Rf7j336ebHOX838ZgTuFayaMfKXGjXuFkhZEK
 XaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hFVfJJ6Ejdu+Nc6pP4+2Kj/FAk9+HqPn9yXfhDOY5Ro=;
 b=sEjcCsCDHj+30Uq37IMdh2nTJJ2+3/xjH5pg3RMxQQlkwoiQch8uTEU+/EGKZFSTnt
 i2sFX/orWCifsDR0rKm1htdHBHtFQ9MC8y8T1Q4axmJY6smR70ZkUn93XAgycv5Dmb/0
 O/855iXcP7cHWMke98liyTQUf4/Sw0G6i8duOKIUiBN9IAvdbMEIXGdLaBtdeoYcpjHu
 kK+RFa7Emp2q03Suf7gi6BzC8Z8HqeqwQ8YVzR/9eSP6RWuhCb0gZIPxluWBxsWRsA++
 3unfXmBc8LfUOQV/lXai9c13O3VGlGRX4IUCyCWFBuOGt3Ip28tfmx3PxpNRmMlGeuXT
 oTgw==
X-Gm-Message-State: AOAM530tsevQiX6gTh3au0qyuTUKkB/UdSv0IGLtUr/9r67Jdb+YSmHm
 zsKpuCAJyjZNMzhUNDpWN3w=
X-Google-Smtp-Source: ABdhPJyvLqfzFB8dyRAycRpMLE+vWsX/t92KFUNJOpadhY9cIhKj7mXAnjMuGDP62SM+NjdRU/gutg==
X-Received: by 2002:a05:6512:38a4:: with SMTP id
 o4mr1831752lft.288.1622790894175; 
 Fri, 04 Jun 2021 00:14:54 -0700 (PDT)
Received: from [10.0.0.40] (91-155-111-71.elisa-laajakaista.fi.
 [91.155.111.71])
 by smtp.gmail.com with ESMTPSA id s16sm529885lfp.106.2021.06.04.00.14.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jun 2021 00:14:53 -0700 (PDT)
Subject: Re: [PATCH][next] ASoC: ti: davinci-mcasp: Fix fall-through warning
 for Clang
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20210528202047.GA39602@embeddedor>
From: =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Message-ID: <25941c37-6e38-88ae-3afe-4f5af44380d3@gmail.com>
Date: Fri, 4 Jun 2021 10:14:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210528202047.GA39602@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
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



On 28/05/2021 23:20, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a goto statement instead of letting the code fall
> through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> JFYI: We had thousands of these sorts of warnings and now we are down
>       to just 25 in linux-next. This is one of those last remaining
>       warnings.
> 
>  sound/soc/ti/davinci-mcasp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
> index b94220306d1a..587967720135 100644
> --- a/sound/soc/ti/davinci-mcasp.c
> +++ b/sound/soc/ti/davinci-mcasp.c
> @@ -2317,6 +2317,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
>  		break;
>  	default:
>  		dev_err(&pdev->dev, "No DMA controller found (%d)\n", ret);
> +		goto err;

Would:
	fallthrough;

be enough to silence the warning? If so, then I would prefer this version.

>  	case -EPROBE_DEFER:
>  		goto err;
>  	}
> 

-- 
Péter
