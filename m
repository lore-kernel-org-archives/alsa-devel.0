Return-Path: <SRS0=HqWb=NX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D83C43216
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Sep 2021 12:26:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94B9A610A8
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Sep 2021 12:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 94B9A610A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DCC1A16EF;
	Wed,  1 Sep 2021 14:26:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DCC1A16EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630499212;
	bh=4eyWgGsGauFDwmx4B5Eq7uejZpCKlayM5qefW2c+R8E=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cwllv6Fr8SNzl6tttRPcI5BqnSbTCs1qJWoA0Ao901RGuAxrs69Xa0nnXr93Foeud
	 C8Hw4H02/seBHjGfEbJzk1icQVD4Cl1ETs1aAyzxAfJF6/oBpPFrsJ0D7CSKbaocs8
	 M5boUY+P1gG8aEsWC2w4vQ8c5BPttBRhrGrezvu0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B4BA8F802E0;
	Wed,  1 Sep 2021 14:25:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BF7F4F8032B; Wed,  1 Sep 2021 14:25:25 +0200 (CEST)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
 [209.85.210.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6A515F802E0
 for <alsa-devel@alsa-project.org>; Wed,  1 Sep 2021 14:25:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6A515F802E0
Received: by mail-ot1-f41.google.com with SMTP id
 m7-20020a9d4c87000000b0051875f56b95so3187857otf.6
 for <alsa-devel@alsa-project.org>; Wed, 01 Sep 2021 05:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=e3t41E0YWOAJ4Hi/b6TRtUMeNJZteZYB+0tdGv+9MG4=;
 b=D/m25OZEKb2+qudpp92eSrzrQ/G9714xyxalPhx76Mh1NHVyY9mc9F/IkSO922C1xb
 U6sEF4uI/65Onmx7cMMlITIYlI3+SEsYbjmVIgaBocMd4Q9JdVqPT4yvPj7G2ILp7abF
 XtStprGz0BnwdRe5EM/96QsE8lp6Dj9dl2STTJVMtkVPMmiz4ZhFrbuzpCvrQbBpiMAZ
 RQeYeHP7Ld5yauYQ90HvGWjJvYX3/U0DECuhALNweho8Dd4SS5ZwfgAnRoD8ML/60/Qi
 a2Pxx0zAKw0gpul2c/3pAkbt9C+YOo7EXX6xECUklmw/8TJL0EeASyw4gvaJuPobF3k2
 9bRQ==
X-Gm-Message-State: AOAM532KGNtpmgdAI8RLCHI2CEs1M4ltQcFrEwRFRW2TGR5NDgiyCeaC
 S3JuVgy/jmxG8cEGImnMnA==
X-Google-Smtp-Source: ABdhPJwd/30LIOw/DH4iSf8meNlbH8tQXCLaIChT5tmHzz3Ifibm528hlYMw1ubpF0H2VMUPuz6/ZQ==
X-Received: by 2002:a9d:6359:: with SMTP id y25mr29280701otk.274.1630499115371; 
 Wed, 01 Sep 2021 05:25:15 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id b25sm4225297ooq.6.2021.09.01.05.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Sep 2021 05:25:14 -0700 (PDT)
Received: (nullmailer pid 1939544 invoked by uid 1000);
 Wed, 01 Sep 2021 12:25:13 -0000
Date: Wed, 1 Sep 2021 07:25:13 -0500
From: Rob Herring <robh@kernel.org>
To: Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: Re: [PATCH v3 4/7] ASoC: dt-bindings: rockchip: Add binding for
 rk3568 pdm
Message-ID: <YS9xKaheZV2UJYTf@robh.at.kernel.org>
References: <1630468039-7186-1-git-send-email-sugar.zhang@rock-chips.com>
 <1630468083-7248-4-git-send-email-sugar.zhang@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630468083-7248-4-git-send-email-sugar.zhang@rock-chips.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org,
 heiko@sntech.de, linux-rockchip@lists.infradead.org
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

On Wed, 01 Sep 2021 11:48:00 +0800, Sugar Zhang wrote:
> This patch documents for rk3568 pdm.
> 
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> ---
> 
> Changes in v3: None
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/sound/rockchip,pdm.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
