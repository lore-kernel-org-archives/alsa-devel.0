Return-Path: <SRS0=FUiO=CY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9881EC43461
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:56:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E9E22145D
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="M0Amrap/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9E22145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 34107112;
	Tue, 15 Sep 2020 18:55:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 34107112
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600188992;
	bh=4u1mqOcesqjEmTr8oDpFU6Z/Y6vn1eQRNk+fs1zlmUc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M0Amrap/id1jArPEDuE9ob4CxgyiLGdxuKX/PA8FAQDpBjJFvuvcvZ/bU+LG8qnYY
	 2AnRgRu3v9A5vkgVM3CFJj3Pea5vOgUqLo2oxDtdtoOGY5tjhnWuUOSOF16BHL/6yT
	 szDgu0dYr6YvLVr1EnEZa+xa/9KyZQaAjk7xDILc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A1080F800E5;
	Tue, 15 Sep 2020 18:55:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0B216F80212; Tue, 15 Sep 2020 18:55:40 +0200 (CEST)
Received: from mail-il1-f193.google.com (mail-il1-f193.google.com
 [209.85.166.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A23FBF800E5
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2020 18:55:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A23FBF800E5
Received: by mail-il1-f193.google.com with SMTP id f82so3648440ilh.8
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2020 09:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bETQrHlgY+giuYgPl/jo3S5uao6J8l5uzCi3TzZPVZA=;
 b=kfAuHz3ELSANP4gCeL83t9VfOxbkCqd4+ssRlyTGT/+NZi5J+vvq8ea+urGh3pw0xh
 x7U+pBnmdq9cGUtcqEOXGrQvZ8RDEzDrlIL1RPSRd2BK7vDI6ZRaWJKc1mid2d3HQdBw
 02IkoB0470RLn0X87nOuS0ZgqzciNIErhJdYFDsLWOZvma5ugCjKI569bLow36Ymm2yM
 oS04Mygd4Hs7SHDSuIwzJ8TCpusQICphUDnEx6I2p8x2Dv5y4c1FXcb9+z8YVnYkEtdG
 1Xv+imeTloGkouSpJ4vs37QxI+2uHz7KSFJk86lTHNyLYuRXCe9Jo0CMReIHC1lynrQJ
 Z6oA==
X-Gm-Message-State: AOAM530RDRrYm/elXb5ZcfXe9xs9XzGZj35zQero+ogTvoF79BtxxTYG
 UykxEvADi883NJ2b0OjslA==
X-Google-Smtp-Source: ABdhPJzTpqhRYoX0orE95dExGzGsMu6Z+Szq5lkJDUMDgJUa0R1o5rp/mlwEDwerBCCvE+fbcd+OCA==
X-Received: by 2002:a92:db42:: with SMTP id w2mr4824823ilq.247.1600188927677; 
 Tue, 15 Sep 2020 09:55:27 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
 by smtp.gmail.com with ESMTPSA id m15sm8983132ild.8.2020.09.15.09.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 09:55:27 -0700 (PDT)
Received: (nullmailer pid 2115706 invoked by uid 1000);
 Tue, 15 Sep 2020 16:55:24 -0000
Date: Tue, 15 Sep 2020 10:55:24 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings:  Correct interrupt flags in examples
Message-ID: <20200915165524.GA2115652@bogus>
References: <20200908145954.4629-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908145954.4629-1-krzk@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>
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

On Tue, 08 Sep 2020 16:59:54 +0200, Krzysztof Kozlowski wrote:
> GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
> These are simple defines so they could be used in DTS but they will not
> have the same meaning:
> 1. GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE
> 2. GPIO_ACTIVE_LOW  = 1 = IRQ_TYPE_EDGE_RISING
> 
> Correct the interrupt flags, assuming the author of the code wanted some
> logical behavior behind the name "ACTIVE_xxx", this is:
>   ACTIVE_HIGH => IRQ_TYPE_LEVEL_HIGH
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/sound/max98090.txt | 2 +-
>  Documentation/devicetree/bindings/sound/rt5640.txt   | 2 +-
>  Documentation/devicetree/bindings/sound/rt5659.txt   | 2 +-
>  Documentation/devicetree/bindings/sound/rt5665.txt   | 2 +-
>  Documentation/devicetree/bindings/sound/rt5668.txt   | 2 +-
>  Documentation/devicetree/bindings/sound/rt5677.txt   | 2 +-
>  Documentation/devicetree/bindings/sound/rt5682.txt   | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
