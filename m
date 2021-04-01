Return-Path: <SRS0=rMx/=I6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44CBC433B4
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Apr 2021 20:45:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 178E661001
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Apr 2021 20:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 178E661001
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B8D516BB;
	Thu,  1 Apr 2021 22:44:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B8D516BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617309932;
	bh=2GEID7nQU3IuzHUkRqtaYIWwC1aV/CYw+D6hPLGpWXg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VMIIjXlbYJTCGTIxWoE8zWUijhlWmOUat4aYTonbdmy8wkPP/rPh//+Batpj8O8Oa
	 BPFTVXPmCO7DzHcWjaNCIdVfaukRvi+k5abBg9Tq+YOk3ZK0rRjlFeVHCjvFle5ulq
	 YrDz4TVw0oDwy9s/NHm552AdkN6u6dV4jzV5txB0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BF02AF8032C;
	Thu,  1 Apr 2021 22:44:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B70D2F8032D; Thu,  1 Apr 2021 22:44:06 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 362F4F8032B
 for <alsa-devel@alsa-project.org>; Thu,  1 Apr 2021 22:43:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 362F4F8032B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="Ldyj+5xx"
Received: by mail-pg1-x534.google.com with SMTP id q10so2336104pgj.2
 for <alsa-devel@alsa-project.org>; Thu, 01 Apr 2021 13:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=TnAGkom8Le/1tSh1IELvZ1Rrn3to1YCHlf+sinRlIwM=;
 b=Ldyj+5xxbV9Etk8DHCPhNAyEYkdcYT7rLxLCzKHU0qIBBuySi6gyDEXOai8sD8f2wp
 aY5Tah5rIF9eOnQsVa9s4r2zKoVZtrYDoZOxcSJTNQjsKd2quyCyFjXiF829WO+3ppmQ
 7AEQM2SAaeYHSoVlbQ6AEylgvXYACvboHzJiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TnAGkom8Le/1tSh1IELvZ1Rrn3to1YCHlf+sinRlIwM=;
 b=d4gmMcL57hp3jJRK3WAcNPq+2LNuBZex/5FIGnWw5Mm1fP/B+HSiM6dFeGNDqdO6Wk
 kXd21HqSGClvDKW2kv+vn04wgNBVWCISBdWMN/DWieOmoeM+YUKd14P72yU45faVFEof
 +mjIQ0q+GCEwPNQC4i5zz3P+mSnhxdrjofWPzMgHKs0RE5kAy+uyGWpNR109LPuL6BtS
 yCkU+ibsRVzuBUJbGhJYucLqtWPH7wyjDxWswMGV0djuSW0rH7ejdOe8LqDCcoe5pUgU
 B3dUvzX2UywOLjs3s/8gMXrz8MP6Zr2DU3b/n2BLloU3FBjGIEOQR9whV0ZiF6vfHwTG
 YHmQ==
X-Gm-Message-State: AOAM533QMR1sPB816oTCHOwpgaG7OU/syblDAbUj+7rziiTwMXXB3ifB
 Vj/LUuYRXdj6ekwRVCP8b9NxE89WhGcQ/g==
X-Google-Smtp-Source: ABdhPJzWYMInelb3OBb+GquXH+zlhP1gaOEP+g2jJ2fJflUKlb7bxDr5oaLogs1O3v7DD1Zfe9fG1w==
X-Received: by 2002:a63:3008:: with SMTP id w8mr9117215pgw.342.1617309834858; 
 Thu, 01 Apr 2021 13:43:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id x4sm5925350pfn.134.2021.04.01.13.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Apr 2021 13:43:54 -0700 (PDT)
Date: Thu, 1 Apr 2021 13:43:53 -0700
From: Kees Cook <keescook@chromium.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] soundwire: qcom: handle return correctly in
 qcom_swrm_transport_params
Message-ID: <202104011343.B1944F3@keescook>
References: <20210401091502.15825-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401091502.15825-1-srinivas.kandagatla@linaro.org>
Cc: robh@kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
 vkoul@kernel.org, sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com
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

On Thu, Apr 01, 2021 at 10:15:02AM +0100, Srinivas Kandagatla wrote:
> Looks like return from reg_write is set but not checked.
> Fix this by adding error return path.
> 
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1503591 ("UNUSED_VALUE")
> Fixes: 128eaf937adb ("soundwire: qcom: add support to missing transport params")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Thanks for fixing this!

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/soundwire/qcom.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 5fd4a99cc8ac..348d9a46f850 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -731,17 +731,23 @@ static int qcom_swrm_transport_params(struct sdw_bus *bus,
>  	value |= pcfg->si;
>  
>  	ret = ctrl->reg_write(ctrl, reg, value);
> +	if (ret)
> +		goto err;
>  
>  	if (pcfg->lane_control != SWR_INVALID_PARAM) {
>  		reg = SWRM_DP_PORT_CTRL_2_BANK(params->port_num, bank);
>  		value = pcfg->lane_control;
>  		ret = ctrl->reg_write(ctrl, reg, value);
> +		if (ret)
> +			goto err;
>  	}
>  
>  	if (pcfg->blk_group_count != SWR_INVALID_PARAM) {
>  		reg = SWRM_DP_BLOCK_CTRL2_BANK(params->port_num, bank);
>  		value = pcfg->blk_group_count;
>  		ret = ctrl->reg_write(ctrl, reg, value);
> +		if (ret)
> +			goto err;
>  	}
>  
>  	if (pcfg->hstart != SWR_INVALID_PARAM
> @@ -755,11 +761,15 @@ static int qcom_swrm_transport_params(struct sdw_bus *bus,
>  		ret = ctrl->reg_write(ctrl, reg, value);
>  	}
>  
> +	if (ret)
> +		goto err;
> +
>  	if (pcfg->bp_mode != SWR_INVALID_PARAM) {
>  		reg = SWRM_DP_BLOCK_CTRL3_BANK(params->port_num, bank);
>  		ret = ctrl->reg_write(ctrl, reg, pcfg->bp_mode);
>  	}
>  
> +err:
>  	return ret;
>  }
>  
> -- 
> 2.21.0
> 

-- 
Kees Cook
