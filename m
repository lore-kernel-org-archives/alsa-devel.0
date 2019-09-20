Return-Path: <SRS0=YPxo=XP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7ECC4CEC9
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Sep 2019 12:29:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F17C020B7C
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Sep 2019 12:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WzsbNgZs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F17C020B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2499C166A;
	Fri, 20 Sep 2019 14:28:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2499C166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568982553;
	bh=euw/zCooeh9QFNP94a2mOeMBHX9ek/OaaVXtRtGHcwg=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WzsbNgZsNnleOJDOeT1c97TLUuqLFW3ho2UC4bClbtA1K2HKEtT69AmudsJNH/Qix
	 1yKw9iPN/mKyE6z/EtDVEId3vJpp/1zLeRLrckWLaBjKayLcZFB5G0PSFgz45xS7DV
	 5e/YMHmm60HbGEjgQac+tlKc4Nf5SxANrO3P20e8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B1040F80527;
	Fri, 20 Sep 2019 14:28:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 14811F80535; Fri, 20 Sep 2019 14:28:22 +0200 (CEST)
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EF27DF800C7
 for <alsa-devel@alsa-project.org>; Fri, 20 Sep 2019 14:28:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EF27DF800C7
Received: by mail-wr1-f68.google.com with SMTP id r5so6538985wrm.12
 for <alsa-devel@alsa-project.org>; Fri, 20 Sep 2019 05:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=GA3pOvw9cvyvH9sQ+qekD5v2QhBspBBVn0FQG6OPUYU=;
 b=hzuUPkJO1jLbse6G+fPCsR/I9kSGyTCYYS6tipMCy/lZjICgeQXYLKpw6bcsCN9E8F
 vglMTyfakCvVEldOVvEzp7b1eqAJPWblVblwcFqTRGdT5c4KCP1qF/NOD2BchJsoOy4l
 uMoBZ9zSbvuOWRDlpBv91lGA2JbWIrmT4oyT5J1YVHkPIlNz73JTo3WAeW/Z7S9cDx/N
 JqAUgeZj5pNTyhcY8/D/NSQkGvTyppFT0F6+5g7pfv4Om4+9oJPqmWfKRQsT+35JrW2Y
 5JHVhswbQtc/wKjglDxBbqu49Gdxodp0pl8jUH2CYpsr47AyBPNaOIbQS6lN6Bacyz81
 +++w==
X-Gm-Message-State: APjAAAV8NpgWqMa3z6m3N5+HWj5FdlCfK4Ll/fOiEOOYCVM+llUyT7qe
 ko+iWU3/QmhgePvuaLvqO10=
X-Google-Smtp-Source: APXvYqxmnGq2oEEutMlmvckBo6TPiKxSSizcfXtvJxNZXc6nbSs9KT2dgYsJ0qwY1AyhJqAnzhcTjg==
X-Received: by 2002:a5d:430f:: with SMTP id h15mr11854947wrq.177.1568982499009; 
 Fri, 20 Sep 2019 05:28:19 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
 by smtp.googlemail.com with ESMTPSA id n8sm2186709wma.7.2019.09.20.05.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 05:28:18 -0700 (PDT)
Date: Fri, 20 Sep 2019 14:28:15 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <20190920122815.GB26862@pi3>
References: <CAL_JsqJ=QWk07y=h7dHFiRrKuE7NGoUr50bu3kiOC+YU8qS9jg@mail.gmail.com>
 <CGME20190920121525eucas1p27562c205c41200221540b720c9084fb4@eucas1p2.samsung.com>
 <20190920121431.31678-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190920121431.31678-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
 Maciej Falkowski <m.falkowski@samsung.com>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Andrzej Hajda <a.hajda@samsung.com>, Rob Herring <robh+dt@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [alsa-devel] [PATCH 1/2] ARM: dts: exynos: split phandle in
	dmas property
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Fri, Sep 20, 2019 at 02:14:30PM +0200, Marek Szyprowski wrote:
> From: Maciej Falkowski <m.falkowski@samsung.com>
> 
> Change representation of phandle array as then
> dt-schema counts number of its items properly.
> 
> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi | 14 +++++++-------
>  arch/arm/boot/dts/exynos5410.dtsi |  6 +++---
>  arch/arm/boot/dts/exynos5420.dtsi | 14 +++++++-------
>  3 files changed, 17 insertions(+), 17 deletions(-)

Looks good, I'll take it after merge window but why this is in-reply-to
(inside thread) of completely different patchset?

Best regards,
Krzysztof

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
