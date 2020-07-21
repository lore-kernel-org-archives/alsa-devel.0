Return-Path: <SRS0=ClfJ=BA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A034C433E3
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jul 2020 03:35:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19242208E4
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jul 2020 03:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Olisilr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19242208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB54115F2;
	Tue, 21 Jul 2020 05:34:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB54115F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595302549;
	bh=acFLPMYyZn00UCUwRK8nBFW/DAv8aA69O0R5tOKfb68=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Olisilr25FSwxopcBIHHDSFQ0TPebjy4yuC7sWWCJjfEiAeNf3TNzVtYWSDLNjjeQ
	 S5Rnqxc5o8iIpPD2+UBc05nGadaHuW4RfkrXN2VUqdqwxFXFhsaMAmSHVWfv7Ssw/B
	 zrOFXxHukFvjY8GWp7k3pAIHmqacG8ld2Nv00KbY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CBF87F80274;
	Tue, 21 Jul 2020 05:34:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0F6EDF80278; Tue, 21 Jul 2020 05:34:40 +0200 (CEST)
Received: from mail-il1-f196.google.com (mail-il1-f196.google.com
 [209.85.166.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4EBC9F80274
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2020 05:34:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4EBC9F80274
Received: by mail-il1-f196.google.com with SMTP id t27so15166677ill.9
 for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2020 20:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lEjdQBbW/boyhDiNTM7TD+vH0KD1i9XRl22iZgkm7F4=;
 b=KHPGJ7eGOukXg0QNUwVSd5QfU7a6ENnMoAsiU05I8k6C5ptyfrWoMOr+8dsq43AA5I
 ky2bqdEytn/EUxGarzO+KfCiAPiXnUWrdibgKpcE6nuKGIUt1ssJrI9AjQMfrxUg5nK1
 1zCfATda+JrB6A8TViYoPZ9O6WDLGGw5zenFZUtNluw5nQH/FjPbB1qrNYL9VmM1+rmV
 N5nPwj78rmFYBrwsJjamHGimch5KqKNqiZeW14SOZ/kFnUOuK4YaL4mOTJKhBCOuymII
 IPi8pVsAtAvd2cEajT4xQSuHwT8YGwf3tkDLiZjUSytNowkqVkxZ4NDuSN2ZwyvJHzKz
 FCOw==
X-Gm-Message-State: AOAM531Sq8xoMePP+/2pinuQnUZu1FzScECWVcUfMn1GycnfyYD0skmo
 iZrOQtxt7UTQnMOCwN06AA==
X-Google-Smtp-Source: ABdhPJwGADjpvMQZr5FlN1g/SWnGPSX43dFPvjZNtWgdOfy0gtgfbIwb8I4jFOahligwaecKrl9/pA==
X-Received: by 2002:a05:6e02:1212:: with SMTP id
 a18mr24024250ilq.97.1595302465691; 
 Mon, 20 Jul 2020 20:34:25 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
 by smtp.gmail.com with ESMTPSA id v62sm10081537ila.37.2020.07.20.20.34.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 20:34:24 -0700 (PDT)
Received: (nullmailer pid 3503819 invoked by uid 1000);
 Tue, 21 Jul 2020 03:34:23 -0000
Date: Mon, 20 Jul 2020 21:34:23 -0600
From: Rob Herring <robh@kernel.org>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 03/20] dt-bindings: ata: renesas, rcar-sata: Add r8a774e1
 support
Message-ID: <20200721033423.GA3503378@bogus>
References: <1594919915-5225-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594919915-5225-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594919915-5225-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Thu, 16 Jul 2020 18:18:18 +0100, Lad Prabhakar wrote:
> Document SATA support for the RZ/G2H, no driver change required.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
