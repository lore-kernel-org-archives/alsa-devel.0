Return-Path: <SRS0=ClfJ=BA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB035C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jul 2020 03:39:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73BD3207DD
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jul 2020 03:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pxRbr8jk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73BD3207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC52D1677;
	Tue, 21 Jul 2020 05:38:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC52D1677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595302743;
	bh=qxKMVewKJIR+lxruWSKjV/r+81jcPMjLO6fUyS7txTs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pxRbr8jkwf+ToK1TMZHs9nIw04SYSpW2pyf2RzC5GVcfo6Q+urWqGwG+G3qVriIle
	 GmyLiikKltmGFLcBVWJfcgB9mzqH9eHBqzmjJA3l+T07U2qm6fsncC9n1IyY3IMDLw
	 vv//WMS9SNZvtz6MbfqcXNQ7vf4vIFwEbQEdW/Y8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9437EF80290;
	Tue, 21 Jul 2020 05:37:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 35F39F802BE; Tue, 21 Jul 2020 05:37:57 +0200 (CEST)
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com
 [209.85.166.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 83590F80274
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2020 05:35:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 83590F80274
Received: by mail-io1-f65.google.com with SMTP id d18so19909853ion.0
 for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2020 20:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=11Ss5+TWbTwC5VEy1eRl+9A6ulBKPK04XldeortitXw=;
 b=p7/PC/01yew7c+rwryfWbReiNcUV/nG1IwAmbuXTcdYmp38bpJld90+1xdgmwxCcXx
 SRLiElhA3ytsX60QG8te/sYhHOpex1W4efjZmoabsPniNFNpH5vU27SQO6on+FmJYvzh
 f5yLNFEAlaa5yW3H7y+9GCfLrcyoyuLyEHucipO3B4hAPOO5FC8EjHNH8yzQKefQLSjP
 Eeyc/9iR0yI/JFYP03Yf7FCMMbhsivVd2DxiS9W05FBUEIta3XLF7nPYb+Fi94JmAPMV
 RUSRpt4pbjB+knepKQlyGfWWl4jnZiEeUSLtDKtWqKurA/dSbpdQotlY1OoYvlpyzfoU
 n+OA==
X-Gm-Message-State: AOAM531bi54y/K8GCv0y40GDWqnDuOHRx15iCWNgyVgVCo07VWlDzYqz
 Ey3TTe3s8nx8wL8vWj+nYg==
X-Google-Smtp-Source: ABdhPJzbcZEoyr7cZeAWu9P+ztBiepZzG70KBotB9TIGBfO7NZ3rZRWdA0exLcnDoc0wa9nH60Do6A==
X-Received: by 2002:a5d:8f01:: with SMTP id f1mr26073476iof.20.1595302548761; 
 Mon, 20 Jul 2020 20:35:48 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
 by smtp.gmail.com with ESMTPSA id m2sm9859770iln.1.2020.07.20.20.35.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 20:35:48 -0700 (PDT)
Received: (nullmailer pid 3506024 invoked by uid 1000);
 Tue, 21 Jul 2020 03:35:44 -0000
Date: Mon, 20 Jul 2020 21:35:44 -0600
From: Rob Herring <robh@kernel.org>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 11/20] dt-bindings: usb: renesas,usbhs: Add r8a774e1
 support
Message-ID: <20200721033544.GA3505976@bogus>
References: <1594919915-5225-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594919915-5225-12-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594919915-5225-12-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: alsa-devel@alsa-project.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, Prabhakar <prabhakar.csengg@gmail.com>,
 linux-i2c@vger.kernel.org, Marek Vasut <marek.vasut+renesas@gmail.com>,
 Magnus Damm <magnus.damm@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 Niklas <niklas.soderlund@ragnatech.se>, Rob Herring <robh+dt@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-usb@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 linux-renesas-soc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 Mark Brown <broonie@kernel.org>, dmaengine@vger.kernel.org
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

On Thu, 16 Jul 2020 18:18:26 +0100, Lad Prabhakar wrote:
> Document RZ/G2H (R8A774E1) SoC bindings.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/usb/renesas,usbhs.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
