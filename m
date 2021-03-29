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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D25C433C1
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Mar 2021 05:56:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66BF861960
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Mar 2021 05:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66BF861960
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6A85E15E5;
	Mon, 29 Mar 2021 07:55:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6A85E15E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616997374;
	bh=zdWMzLpaYlBaGMfYafQXN+8ceR3YGCUHA+hW1l/HcNU=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vLbONPEt2X9l7QsxnIB7eRdLTl6lHs9OoAWFQU7pQ6dqG6/uicZp6/3J0dc1G6pRl
	 LOfoOj0fkDtVLlxZJxFozhZL7eCFcaWyeJkqv/WDPkgd+lg2AYGH09KnbiINMJKNnv
	 E5nTPImlRtZ9ocT3k/rFhJQXsE71muuqSZaRysiw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E1799F800DD;
	Mon, 29 Mar 2021 07:55:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 26009F8015A; Mon, 29 Mar 2021 07:55:22 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 67E00F800DD
 for <alsa-devel@alsa-project.org>; Mon, 29 Mar 2021 07:55:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 67E00F800DD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="ZbwEUR9J"
Received: by mail-lj1-x234.google.com with SMTP id f26so14518322ljp.8
 for <alsa-devel@alsa-project.org>; Sun, 28 Mar 2021 22:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AFwBwKQmaZvAfek2ylzBqiy9Pmq25T+2fBHpaiUkdFo=;
 b=ZbwEUR9JiKBgSN5xGYMSv85NfiSzlVg2dL14PH4e7nqVuN6qo7uIt5SmS972nqkDcu
 9IgSQaYwfdWjeiqmBwgBnSz7YO7l5UaLDXYmJrsw7AHjJ3G6CVezmRFq913T3XfU1ghR
 g+64Y9UyuuJ6Qyvm+IcNbLtCrceI3QSWjzvOT24AiBoQa9gQJy1WK70xyUVHDlQ3P9r2
 XkNI5MzdfrBaKISfHjpEK4h+PXdELvnrKTesw2QDKe/LNDKIjuWArxntQjqyDOvtJSCB
 Ddtg7GRh7ofETihb9mbi8mlceZe7Zw7ejPPS/HLtO8sdCirnrnI3no/dhGY0xWEprIPP
 MaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AFwBwKQmaZvAfek2ylzBqiy9Pmq25T+2fBHpaiUkdFo=;
 b=WFJyjVdAD3IaPkJy4GH2v2bwu+wyqFol0BRJcdxP3OLPpD44xo+k12fdpANQmgPHsF
 bNGFt7DFB9XRaYieFv4CcCr/zQAdZJBWuXNRPW3s2vekVvq/EEIWkBT2pxkQg6ddV+QG
 yfzSE5Ad7adg6gqg7+0F/8uUb5+1cRBD6fR+gR3+0AdOxujvy+vwEFYesIeQ1t+r3n3Z
 NcDnlPWSfQV3dZuFhxhOlnxG6jleyPrPiwTMR72BBmPYO9TGG/fXS9yAm9Pvmoigpg2C
 pPqJPBre70gc2B/MvVeK6U3gqlSVvDiwf5CTBENxt+mzq9B4wGWkTY3i/RLw4A0V2hWU
 xnHw==
X-Gm-Message-State: AOAM531JZE+ZEr0tcVaa+ydR9TAUHhD1SAA5HIGCLdy0eBlx/0LElxCf
 vf/JpKkboiRQHPpOmQtOT6k=
X-Google-Smtp-Source: ABdhPJzpmYL7y4TlZmnpGM1IV/tUVOJPf//OV0otEsKWBQkvYtfnUG5H++Svfy/AiLhizNJHdlSy0A==
X-Received: by 2002:a2e:974d:: with SMTP id f13mr16880816ljj.210.1616997311512; 
 Sun, 28 Mar 2021 22:55:11 -0700 (PDT)
Received: from [10.0.0.42] (91-157-86-200.elisa-laajakaista.fi.
 [91.157.86.200])
 by smtp.gmail.com with ESMTPSA id i22sm2311894ljn.56.2021.03.28.22.55.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Mar 2021 22:55:10 -0700 (PDT)
Subject: Re: [PATCH 15/17] ASoC: ti: omap-mcsp: remove duplicate test
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
References: <20210326215927.936377-1-pierre-louis.bossart@linux.intel.com>
 <20210326215927.936377-16-pierre-louis.bossart@linux.intel.com>
From: =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Message-ID: <38488f20-a155-607d-464e-9461e50bc765@gmail.com>
Date: Mon, 29 Mar 2021 08:56:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210326215927.936377-16-pierre-louis.bossart@linux.intel.com>
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

Hi Pierre,

On 3/26/21 11:59 PM, Pierre-Louis Bossart wrote:
> cppcheck warning:
> 
> sound/soc/ti/omap-mcbsp.c:379:11: style: The if condition is the same
> as the previous if condition [duplicateCondition]
> 
>  if (mcbsp->irq) {
>           ^
> sound/soc/ti/omap-mcbsp.c:376:11: note: First condition
>  if (mcbsp->irq)
>           ^
> sound/soc/ti/omap-mcbsp.c:379:11: note: Second condition
>  if (mcbsp->irq) {
>           ^
> 
> Keeping two separate tests was probably intentional for clarity, but
> since this generates warnings we might as well make cppcheck happy so
> that we have fewer warnings.

There might be other historical reasons why it ended up like this but
merging them does not make it less cleaner.

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  sound/soc/ti/omap-mcbsp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/sound/soc/ti/omap-mcbsp.c b/sound/soc/ti/omap-mcbsp.c
> index 6025b30bbe77..db47981768c5 100644
> --- a/sound/soc/ti/omap-mcbsp.c
> +++ b/sound/soc/ti/omap-mcbsp.c
> @@ -373,10 +373,9 @@ static void omap_mcbsp_free(struct omap_mcbsp *mcbsp)
>  		MCBSP_WRITE(mcbsp, WAKEUPEN, 0);
>  
>  	/* Disable interrupt requests */
> -	if (mcbsp->irq)
> +	if (mcbsp->irq) {
>  		MCBSP_WRITE(mcbsp, IRQEN, 0);
>  
> -	if (mcbsp->irq) {
>  		free_irq(mcbsp->irq, (void *)mcbsp);
>  	} else {
>  		free_irq(mcbsp->rx_irq, (void *)mcbsp);
> 

-- 
Péter
