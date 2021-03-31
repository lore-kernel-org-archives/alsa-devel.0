Return-Path: <SRS0=wMTJ=I5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C731FC433ED
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Mar 2021 16:25:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E10A6100B
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Mar 2021 16:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E10A6100B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F36831670;
	Wed, 31 Mar 2021 18:24:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F36831670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617207922;
	bh=ZXaOIxoRAcxDwfYjD+cFiTvMMkIyIR3P1cvDM2FWmm8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TahkE+U6Gm1CQenRL0jo2fbhfQrgXSne7KwU7p/r5E74YClOl3bddZe5wRU6Y4a0k
	 +rAw1aTQKem72cdWijZKJVllj2ktvinCMR+aGSeqcmGMbxHsED0RiqXvkOBYVDzNPu
	 L/9BNiXeuMz8jdntvsATVj6sKSRRviCeblVL8VMQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7E19EF8015A;
	Wed, 31 Mar 2021 18:24:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AB645F80166; Wed, 31 Mar 2021 18:24:29 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E793EF8014E
 for <alsa-devel@alsa-project.org>; Wed, 31 Mar 2021 18:24:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E793EF8014E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="WA7Cspsa"
Received: by mail-oi1-x22f.google.com with SMTP id n140so20534943oig.9
 for <alsa-devel@alsa-project.org>; Wed, 31 Mar 2021 09:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=6ojW2lv70Zjf6csQxfrD5M3Jt02GT2Ern8AWuYsfFGY=;
 b=WA7CspsaOUGzoSg93E6Kb+UCLYKW6UuEO+xHKotKr9HCmlukDg+vvgAdY2B0jdhjYv
 IqSIk9iLxcUOOSvMS+iF5vv70kIQH3+CiyySeQSJSE4tPXi+Vtco06RfKmro6Eu5kqGC
 /HgP47QXoiyaJO7bFi3zjH/XieBfuRG0WirKPKCzUWCzVWFWOADTCYbpBxm8bYqLen+0
 KtnVv5bHTXeML1murK1rx0r7Cu0zFEk/vQU9NJXFcDc7JmOHfO+2CeHFL7xXo4zWa6JB
 h9QYn60ZCT9ILTfCPfgav5ytklkuL4UJH6/9gLQgHmcTF22SdFyInpFCnsaVKTKskowD
 rPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6ojW2lv70Zjf6csQxfrD5M3Jt02GT2Ern8AWuYsfFGY=;
 b=lhfBc/vsrm1Bp/y9W+Gr7SlldRq4Bq9apQttn26a0GlnOwup27GPf1NLHcBJy+Skr5
 dqVSIt1N1fAEDjrgawZMfkfEXxPJJYolhfhb/kA2o7FqwW40Vsd0gOP3jOZP+sWNOsDs
 1F/YcwoU7tpc5rIYWNC1pM+xk1WzESFVvSG+Wic5Ze35D7gqWjDUW+ski6okybNvtobT
 2IzjH5CZPmp3rgMyNLEfRczm/a9ubMSv9ytkqbKZ4shGUQqkaJ8XlJwAlm7ud2X595Tr
 L6EH+1+xqY2E8BBoMeFBhWksavaFEyzwkSRZBkVmoAQhbWyF8+oHfexdprJHR52hHmN/
 cZdQ==
X-Gm-Message-State: AOAM530FWdq/lCrpztZub7Yge1NJ9DVYymeEpxTZf7ed4DWxET2514Bm
 yOgCvmJYreNXmqW7LUhsLwweiA==
X-Google-Smtp-Source: ABdhPJwfdWI6nnYFm5Aq9dILT7eMDQoeMTKFzGdX2gtf7uIYU9+M/Q8rUSa0gR4MiAxlPEOfqFm5xA==
X-Received: by 2002:aca:3389:: with SMTP id z131mr2873290oiz.11.1617207856188; 
 Wed, 31 Mar 2021 09:24:16 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net.
 [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id m129sm506802oif.34.2021.03.31.09.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Mar 2021 09:24:15 -0700 (PDT)
Date: Wed, 31 Mar 2021 11:24:13 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH] soundwire: qcom: use signed variable for error return
Message-ID: <20210331162413.GJ904837@yoga>
References: <20210331072111.2945945-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331072111.2945945-1-vkoul@kernel.org>
Cc: alsa-devel@alsa-project.org, kernel test robot <lkp@intel.com>,
 linux-arm-msm@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-kernel@vger.kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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

On Wed 31 Mar 02:21 CDT 2021, Vinod Koul wrote:

> We get warning for using a unsigned variable being compared to less than
> zero. The comparison is correct as it checks for errors from previous
> call to qcom_swrm_get_alert_slave_dev_num(), so we should use a signed
> variable instead.
> 
> drivers/soundwire/qcom.c: qcom_swrm_irq_handler() warn: impossible
> condition '(devnum < 0) => (0-255 < 0)'
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/soundwire/qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index b08ecb9b418c..55ed133c6704 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -428,7 +428,7 @@ static irqreturn_t qcom_swrm_irq_handler(int irq, void *dev_id)
>  	struct qcom_swrm_ctrl *swrm = dev_id;
>  	u32 value, intr_sts, intr_sts_masked, slave_status;
>  	u32 i;
> -	u8 devnum = 0;
> +	s8 devnum = 0;

At least in today's linux-next qcom_swrm_get_alert_slave_dev_num()
returns an int and the code only checks to see if this is negative.  So
it seems like making this a full int ensures there's no truncation etc.

And at least as written today there's no need to initialize the
variable.

Regards,
Bjorn

>  	int ret = IRQ_HANDLED;
>  
>  	swrm->reg_read(swrm, SWRM_INTERRUPT_STATUS, &intr_sts);
> -- 
> 2.26.3
> 
