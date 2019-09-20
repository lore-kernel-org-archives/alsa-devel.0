Return-Path: <SRS0=YPxo=XP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D002AC49ED7
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Sep 2019 12:44:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A60208C3
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Sep 2019 12:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jz65DoNx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A60208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3DA4D1669;
	Fri, 20 Sep 2019 14:43:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3DA4D1669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568983439;
	bh=oDVddZbkppNoUqxuxx9TUPsBy8O2gU/U/nBm8IIdGNk=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jz65DoNx/fVzgC2j7sbmQqwedima0dfFsvHM61GyTD5UGjS9jVuXUUEEdTEjLmWiA
	 ShTZHQ97t1hLLmEgvcck5PbQyBYEiwL2Fvgc5ET+5R2o9a8/UDX686JKp1OhrZo8ti
	 pmGPrn71al3ti7zEzEyz35ALBhZ28zUBM1zCx6UM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BDDF6F804FF;
	Fri, 20 Sep 2019 14:43:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6276BF80506; Fri, 20 Sep 2019 14:43:07 +0200 (CEST)
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3EF6FF80096
 for <alsa-devel@alsa-project.org>; Fri, 20 Sep 2019 14:43:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3EF6FF80096
Received: by mail-wm1-f65.google.com with SMTP id y21so2161693wmi.0
 for <alsa-devel@alsa-project.org>; Fri, 20 Sep 2019 05:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=IUIz0TFnK+oC5M96ipiDUxKW+O/HTgXIaIGHBEPFmZk=;
 b=WRr3tQu7VWExsz89mMlr/YwzlWIEc2nKdTBS44Z6Z8FnjErFntTOn1ON8yaAjz0RDz
 NyBjegV4nbmwU0S1J6S4aVncyV2PI4xeGzn0ZPUrns1QOC4yIvm8Iyab+nwQ1kWGO72o
 1wSr7bhqQ67TnOajF7yQK23OyQK9TPNdZl+eq2Q4XXzgZGSjyJmZYi7b8pirDSJ3LpN6
 PUCyBaq6YU0lL7HFPKtiH/GvArNiv2lWwmGSi40lO6j/qCDev8NTRQRDGDGTWBd+/ceK
 Q5HHg4QiQt9XdDQyWKnrrvTt4tVqYHSHsL0r9DtxuuOSpw+mAUiZynYxXNJToS7FmcAi
 HlzQ==
X-Gm-Message-State: APjAAAVb1FRO3EVuB7Pbf3XkkRgwbtshSvhaNLhp4gIyw/n2HGBTMhUh
 j/mkBptooSwzdmIB4Lkcvcg=
X-Google-Smtp-Source: APXvYqzbaPx3iXSpFSvDy/ZXK9L8E7TXMCemVZw3zZNJjaJFe/Zom9X+pjc+WhUMLjEMWMRXD5G5Eg==
X-Received: by 2002:a1c:96cd:: with SMTP id y196mr3276669wmd.67.1568983384086; 
 Fri, 20 Sep 2019 05:43:04 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
 by smtp.googlemail.com with ESMTPSA id l9sm1678293wme.45.2019.09.20.05.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 05:43:02 -0700 (PDT)
Date: Fri, 20 Sep 2019 14:43:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <20190920124300.GA26917@pi3>
References: <CAL_JsqJ=QWk07y=h7dHFiRrKuE7NGoUr50bu3kiOC+YU8qS9jg@mail.gmail.com>
 <CGME20190920115200eucas1p2253a3eb13373061ef8aa39131c98a319@eucas1p2.samsung.com>
 <20190920113540.30687-1-m.szyprowski@samsung.com>
 <20190920122616.GA26862@pi3>
 <68ec938a-29b5-0c07-3a5e-771d6ce587b4@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <68ec938a-29b5-0c07-3a5e-771d6ce587b4@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
 Maciej Falkowski <m.falkowski@samsung.com>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Andrzej Hajda <a.hajda@samsung.com>, Rob Herring <robh+dt@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [alsa-devel] [PATCH v3] dt-bindings: sound: Convert Samsung I2S
 controller to dt-schema
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

On Fri, Sep 20, 2019 at 02:33:13PM +0200, Marek Szyprowski wrote:
> Hi Krzysztof,
> 
 >> +examples:
> >> +  - |
> >> +    #include <dt-bindings/clock/exynos-audss-clk.h>
> > Does it really work? When I tried, it was failing... If you look up at
> > resulting DTS example it is wrong.
> 
> In which way it was wrong? We checked and it was correctly propagated to 
> the example dts. It also compiled fine without errors. The only minor 
> issue was that the include was generated inside the root node, but for 
> the clock definitions this doesn't matter, but it makes the example 
> easier to understand.

Hmmm.... indeed this works. The output DTS is weird as include goes to
example node (not even root) but it compiles. Somehow my previous tries
with it were failing, I need to check why. In general I am all in for
this include.

Best regards,
Krzysztof

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
