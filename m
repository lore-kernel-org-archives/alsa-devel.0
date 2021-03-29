Return-Path: <SRS0=ZkCr=I3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04974C433C1
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Mar 2021 05:53:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF6A061964
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Mar 2021 05:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6A061964
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AFBC315E5;
	Mon, 29 Mar 2021 07:52:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AFBC315E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616997176;
	bh=ZvG5EGoSMPPgI1fR5NGRyaSCNnxhz3Rb3MTg+ROpFy0=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kCgjgYdh2XehG3hQs+6zJyhF9UX9dZQzhsPSzafudx8JnFv7tA+RAVQesYakWfSYq
	 3y+Pbhzo77lycUZFDwidux8iNcIW1FJfrEF5cmNAnf2tLzUULgJXNHbm5s3PoqZVwx
	 NMByPejY3kUcaeOuifIaI4rzG1uFWnHJCFLwaMZc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 32E7AF800DD;
	Mon, 29 Mar 2021 07:52:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 65FF7F8015A; Mon, 29 Mar 2021 07:52:03 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7BF1CF800DD
 for <alsa-devel@alsa-project.org>; Mon, 29 Mar 2021 07:51:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7BF1CF800DD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="hNAHBojY"
Received: by mail-lf1-x131.google.com with SMTP id i26so16586461lfl.1
 for <alsa-devel@alsa-project.org>; Sun, 28 Mar 2021 22:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RTLEyGYV7yZnyiywVX1eOKOUOm0dlrQWocBPAeC79ME=;
 b=hNAHBojYISzngalmZZEPtvRBfhgwq4l7m6YkXQek8/1QFA2rul3OVIBvlStI01aBHC
 hxo9w3v7g05OYpns2vmFULGfBkX3dE1exCo6nX+P4Qc4/JSzgT2VPVSjSUQ2NonW2GYW
 YDj0OUyKAwGXNc08nvbkhEu/8Xu6D0YL9enJTsggteQnKCOrjK2Onvb8rjCRt4boYdPX
 Madcp2QIdCcHzrR+lrF9eEtm+54C6WoNmW808AtKEZWFvHGAfrcs6KB+XZdLzL/B45QS
 0ETnX78rbx3ECTEcNkAsP9sTRdBRwWD7ARh5htEPboxnb4juYxjT9TiQCv8RqcS77diM
 bULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RTLEyGYV7yZnyiywVX1eOKOUOm0dlrQWocBPAeC79ME=;
 b=m3oI0kuDykxdFNevWTZufki7RWvao/u77XEeoMMvaPGfp6OhWorFg3bw8j2Cx7MVV5
 jjk0UCGviNHFTFXUIOl+T3gF96xrsNH6qWedmUKYwGEHIOHcwX82/355Y7PqEI+8rNDe
 vKtofm3vKsNdLoBO+nCsMuaTnEWhnUeUlN/MRFwFRO9d2zJMmCjPvvkqoD+F2GGdx3Vy
 OYX6ilSpJs8heB1EPaY8S7Q2V2uH5kW25JuQDksPqlsFoXMt8Dc3quONCzs7MWjxY4jt
 neiO3TE70WBjSgoNb82FVh4B666gtEjEgx5IiH8rX/xegFLEYIKQjqwkVzbMS2BLdouW
 IXZA==
X-Gm-Message-State: AOAM533jb2SlxVp0Sh6Gmfod90MkOITaPepgQ2vzLT+VxNJKZRNLCCwm
 C1lHQYdr+stnmPYm8/6jXr4=
X-Google-Smtp-Source: ABdhPJzUmHX+nuyzaEP26EJ10aru8aZC9ARy5zb2nWO8j/0CzMhFhLBvwpv8cuYyGvkhN9urB6hxlg==
X-Received: by 2002:a05:6512:36c8:: with SMTP id
 e8mr14779024lfs.635.1616997113586; 
 Sun, 28 Mar 2021 22:51:53 -0700 (PDT)
Received: from [10.0.0.42] (91-157-86-200.elisa-laajakaista.fi.
 [91.157.86.200])
 by smtp.gmail.com with ESMTPSA id n18sm1360128lfl.148.2021.03.28.22.51.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Mar 2021 22:51:53 -0700 (PDT)
Subject: Re: [PATCH 14/17] ASoC: ti: omap-abe-twl6040: remove useless
 assignment
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
References: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
 <20210326215927.936377-15-pierre-louis.bossart@linux.intel.com>
From: =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Message-ID: <c21d4306-4219-009c-289a-14aa5bb7f241@gmail.com>
Date: Mon, 29 Mar 2021 08:52:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210326215927.936377-15-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
 broonie@kernel.org,
 "open list:OMAP AUDIO SUPPORT" <linux-omap@vger.kernel.org>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>
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



On 3/26/21 11:59 PM, Pierre-Louis Bossart wrote:
> cppcheck warning:
> 
> sound/soc/ti/omap-abe-twl6040.c:173:10: style: Variable 'ret' is
> assigned a value that is never used. [unreadVariable]
>  int ret = 0;
>          ^

Thanks,
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  sound/soc/ti/omap-abe-twl6040.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/ti/omap-abe-twl6040.c b/sound/soc/ti/omap-abe-twl6040.c
> index 16ea039ff865..91cc9a4f44d7 100644
> --- a/sound/soc/ti/omap-abe-twl6040.c
> +++ b/sound/soc/ti/omap-abe-twl6040.c
> @@ -170,7 +170,7 @@ static int omap_abe_twl6040_init(struct snd_soc_pcm_runtime *rtd)
>  	struct snd_soc_card *card = rtd->card;
>  	struct abe_twl6040 *priv = snd_soc_card_get_drvdata(card);
>  	int hs_trim;
> -	int ret = 0;
> +	int ret;
>  
>  	/*
>  	 * Configure McPDM offset cancellation based on the HSOTRIM value from
> 

-- 
Péter
