Return-Path: <SRS0=ClfJ=BA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57A4C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jul 2020 03:37:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D22C20729
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jul 2020 03:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fouvjlbA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D22C20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ADDDF41;
	Tue, 21 Jul 2020 05:36:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ADDDF41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595302634;
	bh=3fBH0klz0fm9ReZinxYrQPMQRKhmMW0koH78by8tf1c=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fouvjlbAXLK4nA7IsL1EVQlQFzDsHN7OeOpBmr21JkMqXsDGwRMFFdtl6y5840UiY
	 xT4tKhB6MeLCwVbxE23lnRtCTgR6WnL5b/fFu0/bacX50SlKBys8qyFU1ZcHUcF08S
	 6ZHuFBEOtrJnGGbIJ5aXHUoE+SJ5eDBUDs0yhaUE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 02944F80268;
	Tue, 21 Jul 2020 05:35:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CB0EDF802BD; Tue, 21 Jul 2020 05:35:35 +0200 (CEST)
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
 [209.85.166.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1C450F80268
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2020 05:35:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C450F80268
Received: by mail-io1-f67.google.com with SMTP id p205so19872953iod.8
 for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2020 20:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3efDbbFBeN9lqo2tvpiUSIlbTXNfjWRmqWbgrnEOjxI=;
 b=sov4gINP0ACHZ+kjsTUFyPN7XAHdc+rpi2gfZHwsGEe2MOsDAZFp6pF04wBecslewR
 ihDw8UGYSxtmsNzcZY3Fnhjc+Ab7MHhRAUa73zSCbs8p2fYPNjEgY7TES9PNh20wJ+FA
 6qxTrBOFhNGmWL06sO+8bBNSAXDeFxkiFAPvLQxtuCSxFbwStPr0rQQMp/TEbBZz80DB
 31QvAklk80IPFz6LGP0WCr2Db49Xp5G6AsG+3TTQTlvSBfNs1x5GA/os7lP1a6+JJ7zr
 7qI2zzouT7ojdQMH2C89Khn1U1ogoNBjLLosoDXF6UzsOSkjAvpf79wglfVOUPnYeQyV
 khgA==
X-Gm-Message-State: AOAM530viDYcXEOilU5tZozEqTHx20UDE1jPToGQOV0bwJoRTShqjpJZ
 lxfm1EmDxe3QUsj/gVI6NA==
X-Google-Smtp-Source: ABdhPJxyTK/slrF/ELkVKEXDGq34caiEcqrqROYHvjuYHKegslg+EOIDnAZwxhbIOcvtRfx4gn0QQA==
X-Received: by 2002:a6b:4409:: with SMTP id r9mr25670926ioa.158.1595302526232; 
 Mon, 20 Jul 2020 20:35:26 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
 by smtp.gmail.com with ESMTPSA id m5sm9868709ilg.18.2020.07.20.20.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 20:35:25 -0700 (PDT)
Received: (nullmailer pid 3505359 invoked by uid 1000);
 Tue, 21 Jul 2020 03:35:21 -0000
Date: Mon, 20 Jul 2020 21:35:21 -0600
From: Rob Herring <robh@kernel.org>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 08/20] dt-bindings: usb: usb-xhci: Document r8a774e1
 support
Message-ID: <20200721033521.GA3505276@bogus>
References: <1594919915-5225-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594919915-5225-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594919915-5225-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Thu, 16 Jul 2020 18:18:23 +0100, Lad Prabhakar wrote:
> Document r8a774e1 xhci support. The driver will use the fallback
> compatible string "renesas,rcar-gen3-xhci", therefore no driver
> change is needed.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/usb/usb-xhci.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
