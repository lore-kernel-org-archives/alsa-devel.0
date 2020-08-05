Return-Path: <SRS0=cqJl=BP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43164C433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Aug 2020 08:55:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C133A2177B
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Aug 2020 08:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZTnuK8H5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C133A2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2F90384A;
	Wed,  5 Aug 2020 10:54:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2F90384A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596617713;
	bh=TbN1LdnEcI3mYergXHyuj2BtPB3GQcXi6jCvxqyxUSs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZTnuK8H5zJqef2tSZ4YoLWKbqtANgTKQlINtxqnXjBrJFqEHCUn8AcKUDDdaz2+ux
	 snOcJ3wjRGhZYAyM5wH08dQI3FBFvK1Fe0i3PkZE3RhCLlhMUkKCGI60JJLAeLzppi
	 LDQdQtyXF9hOQFrlxENm2JNiHTvXIKpxoapIgDvo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C9450F80112;
	Wed,  5 Aug 2020 10:54:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 85B58F80218; Wed,  5 Aug 2020 10:54:21 +0200 (CEST)
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EE9CAF80112
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2020 10:54:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EE9CAF80112
Received: by mail-oi1-f196.google.com with SMTP id 25so15361349oir.0
 for <alsa-devel@alsa-project.org>; Wed, 05 Aug 2020 01:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o0Tmid+tnSvnAJzyNVALQOzFYE2lj4sH4UY2VIcOcWw=;
 b=MDid5PDirsSXx1q9N6gbMgO0j0GZqtyEwULAnOFV97RJi/opCTNKzlG2KG+gWPs/Q+
 GcmFgRmp3UqMmWtFHuRbmHPZGH4ZrnPeRuNv3h/3z6zrUOLYIm361+Eb9Cw6tMCTnBRM
 ZgK7jcnYOYxlJOOTUmx1LwqHYQtRJamFER4Il/0i3giLAHn+61W5uSIA9/2Q8yxj+etr
 zqH2qmxRJoHWVflkVeikqTJe0WmtJvArA/Z2IVASJdRkaifRFSkyLFgI8xrZ8rLCIjfb
 bQQSd9mp0NWFdj6G83hJd3KGNNW/uoxdoA8yyNwWXYgJ0CApdnDfJw6/2+zJNMWS60cg
 qNTA==
X-Gm-Message-State: AOAM533+TdBWD2lzU+Tx+SaA5tS38ZRPtLhPyu5OQ609+3kIkK0Jb/gU
 tXOvxkGL/RQgU5XYREV6oWWjSXi/4cLwAdYcj0c=
X-Google-Smtp-Source: ABdhPJyljuIryu/u0UTk9F1+3SAnb1XU9mLUVZAv+khu6lPUjs8xyfZNkmrvKtA0yRGPniH4ZpNEEROFWOcNB2m+oEA=
X-Received: by 2002:aca:adc4:: with SMTP id w187mr1794266oie.153.1596617653246; 
 Wed, 05 Aug 2020 01:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <1594919915-5225-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594919915-5225-6-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1594919915-5225-6-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 5 Aug 2020 10:54:02 +0200
Message-ID: <CAMuHMdWebnd8yxLccaQtfaz8UJW3vkTr==2n_ZxT_tjYkBMSiA@mail.gmail.com>
Subject: Re: [PATCH 05/20] dt-bindings: phy: renesas,
 usb2-phy: Add r8a774e1 support
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-ide@vger.kernel.org, Prabhakar <prabhakar.csengg@gmail.com>,
 Linux I2C <linux-i2c@vger.kernel.org>,
 Marek Vasut <marek.vasut+renesas@gmail.com>,
 Magnus Damm <magnus.damm@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Niklas <niklas.soderlund@ragnatech.se>,
 Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Jens Axboe <axboe@kernel.dk>,
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

On Thu, Jul 16, 2020 at 7:19 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Document SoC specific bindings for RZ/G2H (r8a774e1) SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
