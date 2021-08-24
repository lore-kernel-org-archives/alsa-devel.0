Return-Path: <SRS0=yNKw=NP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128F8C4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Aug 2021 18:04:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3D5D610F7
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Aug 2021 18:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C3D5D610F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A18FF1677;
	Tue, 24 Aug 2021 20:03:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A18FF1677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629828261;
	bh=NaBbsZx1tKEOYTNWbThHhxes8bMmXT8hIdJq72bkx9s=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pddyYdLmc+NvicxPJTOCY9KOOphCxhPmQrIhwAbAHFZnhCdFYUteLKTKyhpYR5sut
	 MuumvOi+BzIZuVhwv/CVpWvwR17WyezDkS6HZ+ihmDwNCRlfJu4Gq7MqB6ynypAu76
	 woJps5kMOeB+syddF3YrwjsGNvcGMKaTaj/dG4HI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2A08CF801D5;
	Tue, 24 Aug 2021 20:03:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 58688F801D8; Tue, 24 Aug 2021 20:03:29 +0200 (CEST)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com
 [209.85.210.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5DBDBF800AE
 for <alsa-devel@alsa-project.org>; Tue, 24 Aug 2021 20:03:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5DBDBF800AE
Received: by mail-ot1-f42.google.com with SMTP id
 i3-20020a056830210300b0051af5666070so38645481otc.4
 for <alsa-devel@alsa-project.org>; Tue, 24 Aug 2021 11:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pzcR6KfvbOWTe3o73soBGsabxlr0DD0//iL4Tmb4lKw=;
 b=S+329bUukLdZQDUcUMQNjou0abbyPtHdX8hM1f/fPz3IJnb5fJvQ6b4iCHd90pzziP
 KDFOAfnrSm+klf9/uiPbu1kSE7yecMzNBHu0dZHCiTdHFuSPlxFeIeVWhZbWXQCjA/nv
 Ufo7DC+eQzmzIxiKe+8m3723wRi2G9qc32kRLpbbwqg2E34qe6FiZkhcD8YJNzrLNccm
 xVA+ZhiOTMxT8Pigkrdk0GzwSCaCxOTh5Oc/nou3FaedFmXtfs0CT8Uk2X5mhPTiOQ7d
 p/6RFicFLXsuU2Xd+xbT341HmpELVnaT3FLqbAZNBW0um/zuJ97bvbWZMzflLCRamNK9
 Of2g==
X-Gm-Message-State: AOAM533XK8tMu2IUJmqjhzF0lXCX1tzRyr2n5NrAGjYglfQ9D2OZGzDz
 GFocaK0sujU/pD4pFCyKTQ==
X-Google-Smtp-Source: ABdhPJwUCQ0B+E1Lp9msS+XzKTGdquG6FeiXzSimbNOU3cWCcnsa1SXe0WgxlpKbAWQKc3CrIlWVKA==
X-Received: by 2002:aca:bfc4:: with SMTP id p187mr3742944oif.21.1629828200154; 
 Tue, 24 Aug 2021 11:03:20 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id bg9sm4676161oib.26.2021.08.24.11.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Aug 2021 11:03:19 -0700 (PDT)
Received: (nullmailer pid 726225 invoked by uid 1000);
 Tue, 24 Aug 2021 18:03:18 -0000
Date: Tue, 24 Aug 2021 13:03:18 -0500
From: Rob Herring <robh@kernel.org>
To: Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: Re: [PATCH v1 4/4] ASoC: dt-bindings: rockchip: Add compatible for
 rk3568 spdif
Message-ID: <YSU0Zk5LpSX9xZG1@robh.at.kernel.org>
References: <1629800162-12824-1-git-send-email-sugar.zhang@rock-chips.com>
 <1629800162-12824-5-git-send-email-sugar.zhang@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629800162-12824-5-git-send-email-sugar.zhang@rock-chips.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, heiko@sntech.de,
 broonie@kernel.org, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, linux-rockchip@lists.infradead.org,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On Tue, 24 Aug 2021 18:16:02 +0800, Sugar Zhang wrote:
> This patch adds compatible string for rk3568 spdif.
> 
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> ---
> 
>  Documentation/devicetree/bindings/sound/rockchip-spdif.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
