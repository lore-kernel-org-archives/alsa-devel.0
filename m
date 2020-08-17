Return-Path: <SRS0=tpTD=B3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5422AC433E1
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:48:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD5DD2075B
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="h2YolL2d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5DD2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 15E4F16CE;
	Mon, 17 Aug 2020 17:47:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 15E4F16CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597679290;
	bh=ktuljItFoTWvDIcChhS8REs/HcYiDtPwmCcRZSfs3vo=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h2YolL2dv/YApz+qR9tDEas2ab3wnVoQKQoLEKuCrODeMP9EkXWkmiwLgvjOP4fWO
	 E5oo6DAlcLwMRjGDkTcmVegge0JG3iVm0Qjh0W/4cR1tvlQN7opQjRWqyCcSugYvz+
	 BkCKkMV0hNJ+TZ6wOE2OiWfG1agL652i8jg7Z6Fo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9444BF80216;
	Mon, 17 Aug 2020 17:47:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1D638F80218; Mon, 17 Aug 2020 17:47:18 +0200 (CEST)
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2B6B8F800EF
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2020 17:47:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2B6B8F800EF
Received: by mail-ed1-f65.google.com with SMTP id i6so12642227edy.5
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2020 08:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=2OOPWwPf31u6+1Sjh8PXYKYbvJooZ2RmnVEA6ydXQrY=;
 b=qUpSMizPrTHDItituxH29e98QBMYyC8BPAu86dXgcbVggyPrKhIzSyC4kioTGN/1uz
 lfru1PR3EKn7WHvSiWHYRN9FZuv7hwEFsQoNc00tGYclmhLu3oM9zn7sMJV1tQv6tmxz
 XBbkcrmNS9FIE0fNHfyQQhoI5Q6EiGwAe0QyqTZm0xVW4SKCFWikSz1bU/kq1N/9yQ+2
 mKErn597ZG8xy/ua8Zc5PkVbSt4xGaP0B1hYfl9GHteqMv0xqwqXut95aQ7h1F+J+udi
 lRk7h74tnR3nUyXiByqkHMJ9sFNdt5MPp9AE79zfG66qd8DaEIWuy5Jqr25noXWbryHr
 n5Tg==
X-Gm-Message-State: AOAM5328U1TIiyHlSILvSd/oGzOohnLA3VIJ2x5aIXdyIlgRQgPh6Mcz
 2a4OXZPOpBMYMJgXWaZYzlvJZ6he0M72RMQc
X-Google-Smtp-Source: ABdhPJwOhH8zi3STLsH1df8QWrCEbCpmOqWgZF/tMl4CTwAQjaelnyAYR/xa735yAwg3DI1So6yFhA==
X-Received: by 2002:aa7:d410:: with SMTP id z16mr15198853edq.287.1597679227376; 
 Mon, 17 Aug 2020 08:47:07 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
 by smtp.googlemail.com with ESMTPSA id v13sm14947106edl.9.2020.08.17.08.47.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 17 Aug 2020 08:47:06 -0700 (PDT)
Date: Mon, 17 Aug 2020 17:47:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v3 3/3] ARM: dts: exynos: Add sound support to Midas
Message-ID: <20200817154704.GB15887@kozik-lap>
References: <20200728131111.14334-1-s.nawrocki@samsung.com>
 <CGME20200728131152eucas1p1d6794f603d1c3474eb6a7bfad04cec6b@eucas1p1.samsung.com>
 <20200728131111.14334-3-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200728131111.14334-3-s.nawrocki@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: simon@lineageos.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
 b.zolnierkie@samsung.com, robh+dt@kernel.org, broonie@kernel.org,
 m.szyprowski@samsung.com
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

On Tue, Jul 28, 2020 at 03:11:11PM +0200, Sylwester Nawrocki wrote:
> From: Simon Shields <simon@lineageos.org>
> 
> Update the never-mainlined "samsung,trats2-audio" binding and instead
> use the new "samsung,midas-audio" binding.
> 
> Signed-off-by: Simon Shields <simon@lineageos.org>
> [s.nawrocki: fixed DAPM routing entries for MICBIAS1/2, adjusted to
>  new cpu/codec binding, corrected the regulator nodes indexing]
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes for v3:
>  - none.
> 
> Changes for v2:
>  - reordering to maintain alphabetical order,
>  - corrected the fixed voltage regulator nodes indexing,

Thanks, applied.

Best regards,
Krzysztof

