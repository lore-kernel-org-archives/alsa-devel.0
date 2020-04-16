Return-Path: <SRS0=OoyA=6A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B91FC2BB55
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Apr 2020 19:32:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16E5C21BE5
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Apr 2020 19:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DesT/ZrJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E5C21BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4D2EB15E4;
	Thu, 16 Apr 2020 21:31:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4D2EB15E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587065536;
	bh=rr/IdS13zfQRtLooHZNTeQ39fm0/kQrw1TdyrXsGIb4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DesT/ZrJ5M7C5z0i2dv4xrgp0+ZDfM+s1jfQajxPmAX6REH9kBvVFl5qCbitTDVxA
	 4GQhM9RqWdVJTQd8ggd3Lu/DFlCtqlCxp6aoEgtqx8Sz9ouQ62r/cWB4zWKX3FTKrR
	 SVTJ2Euf2zinj3Tk8h5RpvR+MvWDNTxXJ9SelsqY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CC243F80115;
	Thu, 16 Apr 2020 21:31:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B9679F8014E; Thu, 16 Apr 2020 21:31:23 +0200 (CEST)
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
 [209.85.167.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 32B61F800AB
 for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2020 21:31:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 32B61F800AB
Received: by mail-oi1-f193.google.com with SMTP id j16so17569313oih.10
 for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2020 12:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=83Bpp8uoGsIBtYSm1pLHa49KTy+QHzu3gut9+0c+dz8=;
 b=BqUB47AsrudUYebp3XwGNMywzvWQ9HyxYjy8foHypwrt7XuXYuIkNk8HYuFO/ssq4X
 0gyLzfyRywYLI0B/dSry+pFf91WxVdjNp+70azprQW76Bxb2ShPBrGXsIrXRplsGiNSy
 T/8QT80WmwYUoOSf/oMyNuKOrPvoV3ALdDtqjRYaLsoVHYqFUHROJktnvMG36QOB3WNK
 AqmP/2xYcHAhhvdQaNUHcpgj1UrMzLFjTx3MTChIwHWVIiKLrF9p08MMhonQa9gcPLne
 M9kD3hnjWp6QTJXJBT8dpdtXpENemZwh16VBZyvEMCSZVcTnk/uUin1bg5eV1YR7PFyQ
 Kz9w==
X-Gm-Message-State: AGi0PuYz4vvXMneLrAh8i4en7r+RJxj619Mn5dBr6FFui7cyLbdnATsy
 bzyK/lM0jB4QIw+MQeOHqA==
X-Google-Smtp-Source: APiQypKtFNn7klGmlxS7O33zd15hLes5Ce7gwnHv476q+1Q8X3OSIexFGD7vX+EbNCMQi+0zLh3qvw==
X-Received: by 2002:aca:d705:: with SMTP id o5mr4155329oig.67.1587065461930;
 Thu, 16 Apr 2020 12:31:01 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id r205sm7324602oih.47.2020.04.16.12.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2020 12:31:01 -0700 (PDT)
Received: (nullmailer pid 19733 invoked by uid 1000);
 Thu, 16 Apr 2020 19:31:00 -0000
Date: Thu, 16 Apr 2020 14:31:00 -0500
From: Rob Herring <robh@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH trivial 1/6] dt-bindings: Fix misspellings of "Analog
 Devices"
Message-ID: <20200416193100.GA19671@bogus>
References: <20200416103058.15269-1-geert+renesas@glider.be>
 <20200416103058.15269-2-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416103058.15269-2-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 dmaengine@vger.kernel.org
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

On Thu, 16 Apr 2020 12:30:53 +0200, Geert Uytterhoeven wrote:
> According to https://www.analog.com/, the company name is spelled
> "Analog Devices".
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../devicetree/bindings/display/bridge/adi,adv7123.txt        | 4 ++--
>  .../devicetree/bindings/display/bridge/adi,adv7511.txt        | 4 ++--
>  Documentation/devicetree/bindings/dma/adi,axi-dmac.txt        | 2 +-
>  Documentation/devicetree/bindings/iio/dac/ad5755.txt          | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 

Applied, thanks.

Rob
