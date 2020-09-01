Return-Path: <SRS0=n5aI=CK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73498C433E2
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:12:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E07A5206CD
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="R3zUamB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07A5206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 41F4A1733;
	Tue,  1 Sep 2020 12:11:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 41F4A1733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598955130;
	bh=grH8FnFlGwBGFET0uwnxhIcVCo9NOWmmAKpSLVO8aig=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R3zUamB26T7XjUoCI7foLqm7cKMKwW1RbhGHFbVFDr/Jr3S0GsUl5Pt9OtLXalZPI
	 GGYwZVUVV4G7u99lK91Eb3SADboPVAAgEjtNm9kubwYqAG+VUUdjQIPWnSfUYoWy50
	 Ce/znLUVDWFKJxp2CButEXOi6CFzd4hnlubYzo18=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D0B44F80217;
	Tue,  1 Sep 2020 12:11:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7056BF8025F; Tue,  1 Sep 2020 12:11:16 +0200 (CEST)
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4CED5F800BA
 for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2020 12:11:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4CED5F800BA
Received: by mail-wr1-f65.google.com with SMTP id c15so833890wrs.11
 for <alsa-devel@alsa-project.org>; Tue, 01 Sep 2020 03:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=A1v6htJY2C4gvkXRIZ2JmwZNQ3YQ4RL1hEFI5vq7g+8=;
 b=AtfwSQWjTjqO4qDxMC3TRcvsO3U4NTxJChphap5YnI87J5pM17KYHBCT+1Z6HaMb2d
 iMGqmrEJHpRPg6OkUsp83ov3yToGyKVTnEt+B1Q90bRTz7bWQLt7vl6zzAxb3ok5EBI0
 Y2S6Bs6z+lWMgs+W5ckZ0pc4VD1t5bEAHCCG9h1PfU9FMOhK0jDUSBO4OA2DUOkYW3VN
 5249nW0YWIZcyqIJHmn+NAEmTCD3eGGMo2CBx3FypWcbqiqFtUa5PZD+RDvATkub2OpQ
 aCkyWVrXvEBdknMpzZGZR7P3w+lI2aeQaPnJDzYfkGAIVpRedguFK1FSYVGW4YmhDXRb
 ZVNg==
X-Gm-Message-State: AOAM533uuf8q84QfQwqRnD4Fa0CNx2jCRdc2ti593Bf3kERZJZgPhJVX
 Rf5ddjYA9Ehmz3cSHcrlauA=
X-Google-Smtp-Source: ABdhPJxg01k871o5GFupOXE7beNlZjBYGb1IghFWAqOoAnPRnvevcgE/10DHc6ya9jyFK9jTfOM1ag==
X-Received: by 2002:adf:f54c:: with SMTP id j12mr1037991wrp.265.1598955064678; 
 Tue, 01 Sep 2020 03:11:04 -0700 (PDT)
Received: from kozik-lap ([194.230.155.106])
 by smtp.googlemail.com with ESMTPSA id p16sm1468478wro.71.2020.09.01.03.11.02
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 01 Sep 2020 03:11:04 -0700 (PDT)
Date: Tue, 1 Sep 2020 12:11:01 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 01/10] dt-bindings: arm: samsung: pmu: Use
 unevaluatedProperties
Message-ID: <20200901101101.GB23793@kozik-lap>
References: <20200829142501.31478-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200829142501.31478-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-samsung-soc@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Mark Brown <broonie@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Chanwoo Choi <cw00.choi@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Inki Dae <inki.dae@samsung.com>, Sangbeom Kim <sbkim73@samsung.com>,
 Kukjin Kim <kgene@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Sylwester Nawrocki <snawrocki@kernel.org>, Lee Jones <lee.jones@linaro.org>,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
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

On Sat, Aug 29, 2020 at 04:24:52PM +0200, Krzysztof Kozlowski wrote:
> Additional properties actually might appear (e.g. assigned-clocks) so
> use unevaluatedProperties to fix dtbs_check warnings like:
> 
>   arch/arm64/boot/dts/exynos/exynos5433-tm2.dt.yaml: system-controller@105c0000:
>     'assigned-clock-parents', 'assigned-clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/samsung/pmu.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi Rob,

Could you pick all of my dt-bindings schema patches if they are ok? From
this and other series. You already have few of them in your tree so it
will help to avoid conflicts.

I am afraid that subsystem maintainers can leave them to you and vice
versa :)

Best regards,
Krzysztof

