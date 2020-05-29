Return-Path: <SRS0=qQ1O=7L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55854C433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 29 May 2020 17:51:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D49632073B
	for <alsa-devel@archiver.kernel.org>; Fri, 29 May 2020 17:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="llbbgiql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49632073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 290FA16FD;
	Fri, 29 May 2020 19:50:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 290FA16FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590774706;
	bh=JfIc5aBCzZZJRsvXP+j0UzPMyNiYy9PWPDJHh3LLdkQ=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=llbbgiql3RnXND5H5pgQ15dv3F6Jcd0PfN6GmN37B5nDnrZlf1czSLCDHah3DdNVN
	 tHV9aYSj94QX3rJcahj2BjVpP7By670v6NQqgQzLTOYnxsz4qMqA1JZMXECM2cebkY
	 kuauultyC41sDTTf17dwf/lnOZ7V87paWV5CM+rk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9A851F80149;
	Fri, 29 May 2020 19:50:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 094DEF8014E; Fri, 29 May 2020 19:50:54 +0200 (CEST)
Received: from mail-il1-f193.google.com (mail-il1-f193.google.com
 [209.85.166.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A8F5EF800FF
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2020 19:50:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A8F5EF800FF
Received: by mail-il1-f193.google.com with SMTP id d1so3311468ila.8
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2020 10:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aZMImuOMErdosJw902w3lfnnqYNAbBeX5tzr7TiMmoE=;
 b=t6Mc6M56jJaBfHKS+qMdheKwEa/f8GfP/+vLbwrl8hNO5TTZVf0muDj93mA74lWEYy
 d1x0fPQXnDqZy6nAUW6IOoBeZ3DmBAxuxi6CdhV36acpj7Kr89vvqsDVO01FRjjK7b2a
 lsxP7N6PXueGLZeaOSacJ1R30djrIu51N+d+tt4UOVuQI1yAkHoCU8x1AYK9JEoz/zqI
 Hsw2yrv/a3z7KqIvUPqz48BIilC4DwMqrum+/ML5TExt612ZXlzSsLRO+VqVuKjnhmfC
 sxadB9FtMmu7Uj2edHhUWk5juuspu2k4L/D684c4/X7T1txX2uS1+Bx3g5ONDnl4e00O
 AMGA==
X-Gm-Message-State: AOAM530kjldhoz4aLPsNJ3RNijUwHXCcaH7/xHPtGyBXSXsbhAd3fBzL
 ejlfcbzotWWVq4rT9UMD4A==
X-Google-Smtp-Source: ABdhPJx2Ns3zNiNxUdzgyDku6xMKAeXBcxz6x0Fk8S26HMB57s65sJE/GP7d3bzt0EqhR0Xyk9Bf6Q==
X-Received: by 2002:a92:ba05:: with SMTP id o5mr8844482ili.263.1590774645587; 
 Fri, 29 May 2020 10:50:45 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
 by smtp.gmail.com with ESMTPSA id v2sm3151751iol.36.2020.05.29.10.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 10:50:44 -0700 (PDT)
Received: (nullmailer pid 2647017 invoked by uid 1000);
 Fri, 29 May 2020 17:50:43 -0000
Date: Fri, 29 May 2020 11:50:43 -0600
From: Rob Herring <robh@kernel.org>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 1/2] dt-bindings: ASoC: renesas,rsnd: Add r8a7742 support
Message-ID: <20200529175043.GA2646968@bogus>
References: <1590526904-13855-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1590526904-13855-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590526904-13855-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Geert Uytterhoeven <geert+renesas@glider.be>, Mark Brown <broonie@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, linux-renesas-soc@vger.kernel.org,
 Prabhakar <prabhakar.csengg@gmail.com>, Rob Herring <robh+dt@kernel.org>
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

On Tue, 26 May 2020 22:01:43 +0100, Lad Prabhakar wrote:
> Document RZ/G1H (R8A7742) SoC bindings.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
