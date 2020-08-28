Return-Path: <SRS0=n32M=CG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C786BC433E6
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Aug 2020 06:42:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 482DE208CA
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Aug 2020 06:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="D/kCm50K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482DE208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE79B181D;
	Fri, 28 Aug 2020 08:41:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE79B181D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598596958;
	bh=UCB42pXjCqrAOwWGGrcCtsZIoT991dmtYxnXSw1wGTY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D/kCm50K1cL5aFxTy05SeIsDyXRIR+U1nRvsshNsX16ry7ebkbtXzSq3A3TPXZoPt
	 77sRAvfOWqEU+pgVJuk5QFpaFv23tHD1opvX+LlV3J2Nk7yub1Gwke3Q6hXziwrvKZ
	 JATE4n/vD9/J+Y4ldyai+wECvha2lJaOPtR+1GgM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 38F15F80143;
	Fri, 28 Aug 2020 08:41:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5DE5AF80118; Fri, 28 Aug 2020 08:41:46 +0200 (CEST)
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A42D1F80118
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2020 08:41:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A42D1F80118
Received: by mail-ed1-f68.google.com with SMTP id u1so174105edi.4
 for <alsa-devel@alsa-project.org>; Thu, 27 Aug 2020 23:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OazcN7HN9a5E/rLdGkA2HsRtgNCRVnTkO1Ngzs4zc+8=;
 b=CP9d/WX8o0Y8SnJ6qBkKJy9vYjXnEHefCWhkhgP2sbGzVVRXPtuuqTVc76ZXrIS2I+
 g9qjVYhY83qyTPEDSE+T5aJZ+ehBFkrsjJEdNzYBom3OmiFCrOnE1JeHGUzyEorHKFtf
 o6PkQItiXkuwUpFPSwSauZbYLvDUUCAralkXWfbpZz+dZ9aaKS1W5nCk+FO57qrsDbZ4
 Qn+XiKDtYi/NcgWI4pmLBzeVp2H+eFDHW1eIeIbN0WnCT6Iwy+t/bu4DRwSa9exXjb9O
 OGqTDkSiT3bIQc1vCijAkQpBPtghOtPIycAsOzvIDW93uCm8sWYNWPBorD0vHdYiPNHS
 ynTA==
X-Gm-Message-State: AOAM532AYK6Gf0LLR6CXLdkCH4X1n+p5c7eQjCECoXErfvnfhFS3WRjN
 Db7B+s/Yzw8uWw06trN7pSM=
X-Google-Smtp-Source: ABdhPJxlucmdLtn/w19BIOYgR0oWbv9wc9kgrscFOfXHuFO0oaArewtxh298XtJFINJNK8GEvN3ZEQ==
X-Received: by 2002:a05:6402:2359:: with SMTP id
 r25mr377310eda.65.1598596898438; 
 Thu, 27 Aug 2020 23:41:38 -0700 (PDT)
Received: from pi3 ([194.230.155.216])
 by smtp.googlemail.com with ESMTPSA id j92sm156054edc.82.2020.08.27.23.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 23:41:37 -0700 (PDT)
Date: Fri, 28 Aug 2020 08:41:35 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH 1/2] ASoC: wm8994: Skip setting of the WM8994_MICBIAS
 register for WM1811
Message-ID: <20200828064135.GD17406@pi3>
References: <CGME20200827173411eucas1p1283200677c5e077c5e07af938934eb5d@eucas1p1.samsung.com>
 <20200827173357.31891-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200827173357.31891-1-s.nawrocki@samsung.com>
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
 b.zolnierkie@samsung.com, patches@opensource.cirrus.com, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, broonie@kernel.org, m.szyprowski@samsung.com
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

On Thu, Aug 27, 2020 at 07:33:56PM +0200, Sylwester Nawrocki wrote:
> The WM8994_MICBIAS register is not available in the WM1811 CODEC so skip
> initialization of that register for that device.
> This suppresses an error during boot:
> "wm8994-codec: ASoC: error at snd_soc_component_update_bits on wm8994-codec"
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/codecs/wm8994.c  | 2 ++
>  sound/soc/codecs/wm_hubs.c | 3 +++
>  sound/soc/codecs/wm_hubs.h | 1 +
>  3 files changed, 6 insertions(+)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
