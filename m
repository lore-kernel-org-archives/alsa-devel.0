Return-Path: <SRS0=n32M=CG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE00C433E2
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:11:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1C00208CA
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YAWQAM7e";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E/6Z7lX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C00208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5EB0C1892;
	Fri, 28 Aug 2020 12:10:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5EB0C1892
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598609508;
	bh=TWxbdAQ8PjJ5/WrqjEI2dxIThah8xtjVxsP4s64qnd4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YAWQAM7eh9T4eIrIJFJYrlQexQa4wLr5HOaq4YdEvgKULScQD6jjn7bZKQ8lMlLZP
	 mtguwInDOxoLCcpUmsWfJhzDhbnRI3JKDAIOJIMz9qpToc1kf4ZLmYXAbzrExdPr3t
	 2Hbj5qDG2WNRrAYxRUIHwBwtgp4X92ZNGHIAc7s4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7F767F801D9;
	Fri, 28 Aug 2020 12:10:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 735AFF801F2; Fri, 28 Aug 2020 12:10:53 +0200 (CEST)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 92470F80143
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2020 12:10:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 92470F80143
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="E/6Z7lX1"
Received: by mail-wm1-x342.google.com with SMTP id c19so521270wmd.1
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2020 03:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=4JMFr37STORIgQm4bGEPTAK7/SSI+Z3+hSKZb/jWMU8=;
 b=E/6Z7lX1dsrGY7Qz9e8ERJFdEWAi6Gq+LQeGQ6iQSyk4/VPsQA5bwQc95uE2CYoGf1
 2Gdrh5HzLDnqKQJSGCpWN1EPyRBfF5SnUHF3ThWjBAt3AneY2bckqlYuemdLTl/4JFRN
 Dvo+6qDabXIQF/REsdK6ydQ9T0ZhcZUe53vz/jmnbj5ij4+nNU09HsD9lrNPjw8garom
 fAhtPMM6z8qTWZ8iXQ1WrlacR5jSIKFC9nXHkmoO3/pDyrtpmglCAkGHA7asTGIvZ4p9
 qDEV6w00/ZPPS6yvvZ7QjqBcvK416IOiANM7xgZXferQQ5OJNlAlUxHseyoFyT6cyxnW
 yBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=4JMFr37STORIgQm4bGEPTAK7/SSI+Z3+hSKZb/jWMU8=;
 b=QedEzI76m+9TOSMc3F+BkK9RGYEvJih7mL3+kj5yeSXuVUUYyAei7yM/x0cyIQcUZB
 yq69Zec3cXLmi3zOoT+1wIHGHmJzY0/UaVcB3SGQ54Al6w0lUaK5VTuidNfQzKmzgsnx
 /A9uUW+v8acEKn5jeXWnL8bVrdouTeDVJmkhvQL8o48g556lXFt2bEqMBs9kW90Y1LMw
 2K65TZ6iv8emK3niZRIPschj9qvvXGRMW0kPyluZHdRyJe5HA88KGheP3DcORCzbu2wi
 OXYQRYinT4iTGOTANxD/6KDpbyntB09B/ndTLBcuuiDy2uU6tegCJzSKWiVR2e6zLlAe
 DniQ==
X-Gm-Message-State: AOAM532uGUt6dThzlputWrLCEqj54gy8cm4HsZwCGNdq4bqpDH7c8ahJ
 SwwuK+pRIrHm5PBR3qm9ccP5LQ==
X-Google-Smtp-Source: ABdhPJyd+zEtUn0Pjz24wfI5YhO/ufo1ZrWKml5JZ0SodFr9cwTiaHJAlEhrfM6A5OyXlNedrLY2Yw==
X-Received: by 2002:a7b:c316:: with SMTP id k22mr898552wmj.150.1598609445574; 
 Fri, 28 Aug 2020 03:10:45 -0700 (PDT)
Received: from dell ([91.110.221.141])
 by smtp.gmail.com with ESMTPSA id g18sm1243165wru.27.2020.08.28.03.10.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 03:10:44 -0700 (PDT)
Date: Fri, 28 Aug 2020 11:10:39 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 3/3] mfd: wcd934x: Simplify with dev_err_probe()
Message-ID: <20200828101039.GJ1826686@dell>
References: <20200826144935.10067-1-krzk@kernel.org>
 <20200826144935.10067-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200826144935.10067-3-krzk@kernel.org>
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>,
 Alexandre Torgue <alexandre.torgue@st.com>, patches@opensource.cirrus.com,
 linux-kernel@vger.kernel.org, Richard Fitzgerald <rf@opensource.cirrus.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
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

On Wed, 26 Aug 2020, Krzysztof Kozlowski wrote:

> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/mfd/wcd934x.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
