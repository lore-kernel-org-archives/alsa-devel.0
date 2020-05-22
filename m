Return-Path: <SRS0=jkt5=7E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16564C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 22 May 2020 08:07:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 933B520814
	for <alsa-devel@archiver.kernel.org>; Fri, 22 May 2020 08:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="M5K/VL1F";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s/xaQv5g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 933B520814
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E7376186F;
	Fri, 22 May 2020 10:07:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E7376186F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590134874;
	bh=nFkhsDzGS4PLEnhYeZSj6l7+YuwUbRb7cG4nu8L9AoQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M5K/VL1FvAiUoIxmc6ES861bGS0TrphbguWtyoJ9b13kds2PRLo75dt2w+y7TyTbU
	 td5qOlrsmVOftU99kV0oWCR03cksq5gruePnjLtFS+qsOkTF3jXpTqT2N1Iirdfd91
	 n47n59btz/LXpEO4PqPyx9EUZjEnjt86fRk2vlvU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 692C8F801DA;
	Fri, 22 May 2020 10:07:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 160D0F801F9; Fri, 22 May 2020 10:07:02 +0200 (CEST)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 01F46F80121
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2020 10:06:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01F46F80121
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="s/xaQv5g"
Received: by mail-wr1-x443.google.com with SMTP id e16so9225316wra.7
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2020 01:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=eYZ+JqAlYOgHXPOJCTtuz0GyTZH5GxzAjW2qDHscMoI=;
 b=s/xaQv5gx2QZodgkEgraSKx6LKxVuErDsWOmIGFJqCi7RbAlAAf2IRD7bLRK3BNX+U
 9AAqXmLYsIzY+eqSywvLWdQK4vlZKqCSGaKrMLaVFBGNjD3IlwYni4fvYJRki0WmP/G5
 JkGHMATLsjlN7UbGBmzQNme4Mr49vmnIaSJEmvwmqx2W7HEzHI2lppGMGoVBMO4CD8da
 4hDgiv4yYBICc0pCHlOTru+XXmnhmtSVD5jhDe9tBKx3SDQHgFnne0HvPfrtKtqkp+l8
 5xJWpLcyGHMHDPVpq02LQcPXuqteNUybnAKDX9jm7GsKtV1bbvNoYLq+keXP2TpqUy6H
 L9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=eYZ+JqAlYOgHXPOJCTtuz0GyTZH5GxzAjW2qDHscMoI=;
 b=ZhYlnttKOxY5N2gpu7q2OUA96ugPYzpz6NrhLmDFlKuWzML+YmftZC49osBnZghHMf
 b49CvxCeJK22Q0aBgrn09eRGU8fleUVYcQwiVCHm+7jtRohhBk5tVOoFHBGOlCX48Lff
 3wIvhJwm0V3+5hVIbAyyobdAVmf/CUonVYEIDz0yek3//bkHrCox4JIxcuDDJG12rQQ/
 NVXyXbrdYf2UvuGsPPrFOtKMMQ/ik9h5VTK4cXbSRdMe5gLDqnxz1uHvFCLBdXse5YQ6
 fyodEq6lyQqRpTTRVMso1waNbGVSCfj76aLrgy2hj3jBpeahwcK40AHgToAWv6Ch6YNi
 AfVQ==
X-Gm-Message-State: AOAM5304HsFw6s4gI9ET0V8yy6HTt8UnpfG9D1bOmM21Qg+0f5jJmw5L
 5lyhmJQDqdqazCVFluFI+AVHyw==
X-Google-Smtp-Source: ABdhPJys1hWyXl3jHtzATMUKReeozUyk1CGPsBMj6QlrMYrp7cQPEUT5Drui5+A7TU3k3HbQDtX/pA==
X-Received: by 2002:a05:6000:1083:: with SMTP id
 y3mr2227792wrw.425.1590134814513; 
 Fri, 22 May 2020 01:06:54 -0700 (PDT)
Received: from dell ([95.149.164.102])
 by smtp.gmail.com with ESMTPSA id p1sm363971wrx.44.2020.05.22.01.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 01:06:53 -0700 (PDT)
Date: Fri, 22 May 2020 09:06:52 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 1/4] mfd: wm8994: Fix driver operation if loaded as modules
Message-ID: <20200522080652.GR271301@dell>
References: <20200427074832.22134-1-m.szyprowski@samsung.com>
 <CGME20200427074842eucas1p1abfb9af74f0d898ba381700f37820318@eucas1p1.samsung.com>
 <20200427074832.22134-2-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200427074832.22134-2-m.szyprowski@samsung.com>
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>,
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
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

On Mon, 27 Apr 2020, Marek Szyprowski wrote:

> WM8994 chip has built-in regulators, which might be used for chip
> operation. They are controlled by a separate wm8994-regulator driver,
> which should be loaded before this driver calls regulator_get(), because
> that driver also provides consumer-supply mapping for the them. If that
> driver is not yet loaded, regulator core substitute them with dummy
> regulator, what breaks chip operation, because the built-in regulators are
> never enabled. Fix this by annotating this driver with MODULE_SOFTDEP()
> "pre" dependency to "wm8994_regulator" module.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/mfd/wm8994-core.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
