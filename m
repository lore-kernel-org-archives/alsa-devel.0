Return-Path: <SRS0=3Slh=C4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FB2C43464
	for <alsa-devel@archiver.kernel.org>; Sat, 19 Sep 2020 10:24:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F7DC21D42
	for <alsa-devel@archiver.kernel.org>; Sat, 19 Sep 2020 10:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DgFBcPav";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTgudd0w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7DC21D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0E5921684;
	Sat, 19 Sep 2020 12:23:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0E5921684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600511087;
	bh=415tlnHbT6GIFEfclsRO5mwdsq4YOTPV8BRXnWN/dsc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DgFBcPavo4GJdJ7iSWgMfrxAtU3XI3jG2l/KwQ0BF+InN6sTWMPQM3vvTgmDzLBM/
	 oaVIXdXGNTOIxioZsKSJuO1QQF+I+hvu+nBdDZRlIUdPFPWQl96kFoTeEuOq8CgKEs
	 KtorbhP0OyQtnDz1UAG+GyLHkB6gj5UqANg5Wp8Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7E0A3F801EC;
	Sat, 19 Sep 2020 12:23:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 35CB5F80212; Sat, 19 Sep 2020 12:23:54 +0200 (CEST)
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com
 [IPv6:2607:f8b0:4864:20::b41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 43D60F800EA
 for <alsa-devel@alsa-project.org>; Sat, 19 Sep 2020 12:23:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 43D60F800EA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="UTgudd0w"
Received: by mail-yb1-xb41.google.com with SMTP id k2so6297168ybp.7
 for <alsa-devel@alsa-project.org>; Sat, 19 Sep 2020 03:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6eCfSV8Ptzwh9vo0B+QF+qFkhZVWBhG7mYqX5yvNY50=;
 b=UTgudd0w5mQs9vT1TTOv7Ft4rtia6NtVy8EXAdA5Nr3DW6o/m6ioJ/RkkKJJ35ZTz0
 DIVTYbQO7Nr5qj0sxh/WN85JJEz/Y2xDTPSqhE6myX5le0fDmSK8gfEZn6TjCeKYBIC5
 cHW5+IjsIjMc7X7nlYgzPOZUoebvuQ7CvXfeproRRaFtXdzaiJUyCENgrMEXKMNUWd65
 FOScJtIjjzh0IP9lmkvggcgpTu3m0TkTZ30YzjNbDgbaUB1Sr9MYp8eTQiHGL7e0ieQS
 v2Bgu1n5tLj95nSasFpmYYKfLNsI4CVUzOLbL3O0+OULq763EX5R+Q/20pEPYbR4T+DG
 klPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6eCfSV8Ptzwh9vo0B+QF+qFkhZVWBhG7mYqX5yvNY50=;
 b=WhZ2WeljFMReCTAPIZzVYrbLomb8y5K4xhwWJZc2Ry6gfRQi2zzOjIJfCNmnEIFmNl
 l6+o8yqbN5kKH7FH4ykzQEw9NN2FkjMZyGC46XeNHOZUrb49fVexizpo4rt3+hZsviZ0
 bra/OchvMIxf3J215EXdRHjqArvo54MhUq/DllRxBN90TlybBQXq231SdbLrogJCD2e1
 5oY4mO6j1vOrZ9q4iXi7ug46RUH36zkTZx/HMJWvo2Wx4FeJlzmdAjzKXdLZPz5vh4Ie
 oprFAVDlFNHe9J9HqdEeR1r2Kla0CWKiDGWaaehYmSUPkRjHlqrvser5x2li/6CrnWXv
 c/XQ==
X-Gm-Message-State: AOAM532UNI7TevjsYAqyhFWJkxFqn1UdMH+5PycJvqo3nXkcY2evaqZN
 NxHwhpfu89w7ttglNd1wNdOQn/DG71x5ilidhVQ=
X-Google-Smtp-Source: ABdhPJxJvGLmkjcwDwl3wap9FpKrFE9YZL6lgmFOz6nspGUWPzIFULr921hybhvvnKUrHrAjjmPYowSLNP5qI7UbVnU=
X-Received: by 2002:a25:23d6:: with SMTP id j205mr36022995ybj.76.1600511024640; 
 Sat, 19 Sep 2020 03:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <1594919915-5225-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594919915-5225-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1594919915-5225-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Sat, 19 Sep 2020 11:23:18 +0100
Message-ID: <CA+V-a8uMoCs40RYENPhhpPQGrnoj-S_Zir718nvd94knsphO1Q@mail.gmail.com>
Subject: Re: [PATCH 03/20] dt-bindings: ata: renesas,
 rcar-sata: Add r8a774e1 support
To: Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel <alsa-devel@alsa-project.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-pci <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-ide@vger.kernel.org, Linux I2C <linux-i2c@vger.kernel.org>,
 Marek Vasut <marek.vasut+renesas@gmail.com>,
 Magnus Damm <magnus.damm@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 linux-media <linux-media@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Niklas <niklas.soderlund@ragnatech.se>, Rob Herring <robh+dt@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 USB list <linux-usb@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
 dmaengine <dmaengine@vger.kernel.org>
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

Hi Jens,

On Thu, Jul 16, 2020 at 6:19 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> Document SATA support for the RZ/G2H, no driver change required.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
Could you please pick this patch.

Cheers,
Prabhakar


> diff --git a/Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml b/Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml
> index d06096a7ba4b..2ad2444f1042 100644
> --- a/Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml
> +++ b/Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml
> @@ -26,6 +26,7 @@ properties:
>        - items:
>            - enum:
>                - renesas,sata-r8a774b1     # RZ/G2N
> +              - renesas,sata-r8a774e1     # RZ/G2H
>                - renesas,sata-r8a7795      # R-Car H3
>                - renesas,sata-r8a77965     # R-Car M3-N
>            - const: renesas,rcar-gen3-sata # generic R-Car Gen3 or RZ/G2
> --
> 2.17.1
>
