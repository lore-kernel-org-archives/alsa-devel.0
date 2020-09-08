Return-Path: <SRS0=EqiG=CR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE69C433E2
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:56:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99B4122525
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cyWnmhWJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gEjB2PVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B4122525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 94687178D;
	Tue,  8 Sep 2020 16:55:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 94687178D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599576960;
	bh=K8VquZ6/8I9+LS76cRptF2Rs06tzVmp3UqJDC8fmBEA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cyWnmhWJ380MMr9TEJks5JLDxq0UAGdRQOC9z/dZjVkH/Y6zOT88yQVKoKM1l2f8n
	 Gbumjv22tpk21IdMQFuiMXtOT0xgftkadLM9XF/nOhg6u3G+duiEdunTwknToFlu/3
	 j+oCz7Ik+cxJ718OKKipFjMc2njHm67tKxYNtnpY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1BD2FF801F2;
	Tue,  8 Sep 2020 16:55:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5FA9FF80264; Tue,  8 Sep 2020 16:55:08 +0200 (CEST)
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 20F9EF8015F
 for <alsa-devel@alsa-project.org>; Tue,  8 Sep 2020 16:54:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 20F9EF8015F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="gEjB2PVR"
Received: by mail-oi1-x241.google.com with SMTP id a3so11041923oib.4
 for <alsa-devel@alsa-project.org>; Tue, 08 Sep 2020 07:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=w5WD7mYu1UZ17o5IwyM77lKheQXm/FoO3alEWArs8d8=;
 b=gEjB2PVRSfcdabC2to0ytgzJqyIE1We/Z9N99i/QXWyfZI29q9ILSekgH2UoRUTGo1
 mTSM6e38qq85pZ/1eQaDy5C9Ri71lBuFgqahCU3dDMEpfMcdod4JVa9HEaInoH/SEQwl
 Vh+EggBAgwVJ02di4FQXo38idBxXJArYd4VMOiIOZLi0ViL4a5UwDGnd0P5ZZiwoK6Ce
 IVuzaRE6dO5Er+fpuifC/1vBBr848mgts7QN0VCcqSs/Uf8+mrE8pvTPpMphF6Y6rwxu
 Ld+/jSsFye84Q/SxKreWOUnNkIEfxQWleKPBpMSNTFUHQVum/1MC+NmkLK4MmJsI7COx
 fgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=w5WD7mYu1UZ17o5IwyM77lKheQXm/FoO3alEWArs8d8=;
 b=V1xHQZDiBICBULCdb4rVBd5C0H8wlLr3MkW+SsYM9XEgVTf9AH5Mv2OQ53m10Nrb/W
 oRtGKzZy8DOlrhYAYb8EvE0v+IISwHnGXyhDfTnc3miKA/Y2D10r69iR/hjXzF9iUL0z
 ngzhhqjh71IHhuB2I5d08mVEId4NjbdB04gjdTSUKu5IIfCecwlQR7HcH1ElR46/HOZD
 hUhrvO6MjkTXCymuXI8zgowMqotRsnphImqD6dnwU3vYVZcJSEUfi5UOhWj5MXMk7DBA
 VmZYHiuWT4k5WQma0HjMphA7XreBnjC7pJCQt6UMy/Wfgh4avdjEjp5u2uLgmE7dqdN+
 sFQQ==
X-Gm-Message-State: AOAM532UgWm+4v8nopVPeqa1PVzLZ/Ez+2txcBw8gIi0SYKaVl+6ZQzK
 0VID3fXVCxzDI1m0fFtP8mj8/w==
X-Google-Smtp-Source: ABdhPJwfgX5hiHCKByDlCicvW5Vmn/1mu2VuOJ8ql9YPirRsdRzLX51mj7XJnCv+3+D49GSpE6m/uA==
X-Received: by 2002:aca:df84:: with SMTP id w126mr1740500oig.103.1599576894821; 
 Tue, 08 Sep 2020 07:54:54 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
 by smtp.gmail.com with ESMTPSA id l5sm3498342otj.40.2020.09.08.07.54.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 07:54:54 -0700 (PDT)
Date: Tue, 8 Sep 2020 09:54:50 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Jonathan Marek <jonathan@marek.ca>
Subject: Re: [PATCH] soundwire: qcom: fix SLIBMUS/SLIMBUS typo
Message-ID: <20200908145450.GM3715@yoga>
References: <20200908140818.28373-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908140818.28373-1-jonathan@marek.ca>
Cc: "moderated list:SOUNDWIRE SUBSYSTEM" <alsa-devel@alsa-project.org>,
 linux-arm-msm@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 open list <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Andy Gross <agross@kernel.org>, Sanyog Kale <sanyog.r.kale@intel.com>,
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

On Tue 08 Sep 09:08 CDT 2020, Jonathan Marek wrote:

> Fix slimbus case being broken thanks to a typo.
> 
> Fixes: 5bd773242f75 ("soundwire: qcom: avoid dependency on CONFIG_SLIMBUS")
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
> This should be squashed into the problematic patch if possible,
> but I'm not sure if that's possible since its already in linux-next?
> 
>  drivers/soundwire/qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 100af93a5eab..c406a079d237 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -780,7 +780,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>  	if (!ctrl)
>  		return -ENOMEM;
>  
> -#if IS_ENABLED(CONFIG_SLIBMUS)
> +#if IS_ENABLED(CONFIG_SLIMBUS)
>  	if (dev->parent->bus == &slimbus_bus) {
>  #else
>  	if (false) {
> -- 
> 2.26.1
> 
