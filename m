Return-Path: <SRS0=Rw3p=A2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C44C433E1
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jul 2020 22:10:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CD4B2065F
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jul 2020 22:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jVS7VYV1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD4B2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0FC791669;
	Thu, 16 Jul 2020 00:09:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0FC791669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594851033;
	bh=DSZsjoyCOCsReRg8iiRclXuUu/fznXGewkpPC4xc62g=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jVS7VYV1hCwheEStpvKT/ChR4Bo5BYdv0CVKC7wQ54IlY3cqqsFmSCtprsohQ0SCo
	 3H7OMrUGbdd4/ZppXsa+KmF5mSFNDoDEICY8QSjjOxi06lLHXFiQFh54NqRsBPG4sN
	 8rMlHOnBea1Jww1KGVOBKqFg20UZOmOk5i/9Q4CA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 05A3FF80229;
	Thu, 16 Jul 2020 00:09:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8D8A3F8023F; Thu, 16 Jul 2020 00:09:26 +0200 (CEST)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com
 [209.85.166.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C7AE2F80227
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2020 00:09:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C7AE2F80227
Received: by mail-io1-f49.google.com with SMTP id l1so3945122ioh.5
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2020 15:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Xn5jIa76g7gx0OoxSi/M5tGMd+ItITsCiEbCKsIiVN8=;
 b=EIodvRBAHUz8EMYte3PnEVG0V6gI43cVIGZlhTG1lSzRpSR3ICCYUlRtgAERLgHKo3
 Fccs83q4eC2a9gfmcT9rumf29ZaqALo2TWxtiN44OJd8SwlB+kvcmiBlGz+xgn3m3QvF
 Q4mDIO0U8+2/mhn5crc1/PyC2wOlmhlCV26KFLUjQ9vxn3vKB9zhraeh6K+4fs18KY3g
 FGvsRNqaOjS0zo0fh7+05pdIDN0gZWxfNn/P8DRIGLxcQnD1NPJAL46WSBxhdOK6grRt
 mEBk9AXqYCqVlpSulaGrT9hTDwmXsbXIqYEwuDWSgpwyCt70KexAottnS34u2NwGubGa
 Dihg==
X-Gm-Message-State: AOAM532dHH5jBmCDpmVY8+FEw62SHdnD/F1iBWA9o/30SWNR9o0ZSDu5
 pY9oO6VbfnbvTRH2wyGA/w==
X-Google-Smtp-Source: ABdhPJyencf1AvFsxgRmIS+aOs4uA7bSB7KI2oNAVyobT/QGkMOSz+fPkhZHb17MIPS8xpxF2nFcKw==
X-Received: by 2002:a6b:691d:: with SMTP id e29mr1420360ioc.159.1594850961741; 
 Wed, 15 Jul 2020 15:09:21 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
 by smtp.gmail.com with ESMTPSA id b24sm1744162ioh.6.2020.07.15.15.09.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 15:09:21 -0700 (PDT)
Received: (nullmailer pid 903768 invoked by uid 1000);
 Wed, 15 Jul 2020 22:09:20 -0000
Date: Wed, 15 Jul 2020 16:09:20 -0600
From: Rob Herring <robh@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH][resend] ASoC: dt-bindings: ak4613: switch to yaml base
 Documentation
Message-ID: <20200715220920.GA903738@bogus>
References: <87mu4cxlo2.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mu4cxlo2.wl-kuninori.morimoto.gx@renesas.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>
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

On Tue, 07 Jul 2020 08:35:10 +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch switches from .txt base to .yaml base Document.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> 
>  - 2weeks passed, but nothing happen
> 
>  .../devicetree/bindings/sound/ak4613.txt      | 27 ----------
>  .../devicetree/bindings/sound/ak4613.yaml     | 49 +++++++++++++++++++
>  2 files changed, 49 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/ak4613.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/ak4613.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
