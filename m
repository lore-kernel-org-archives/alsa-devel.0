Return-Path: <SRS0=cqJl=BP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987C9C433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Aug 2020 11:10:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FF0222D02
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Aug 2020 11:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="j+Dth6C6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF0222D02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9894084A;
	Wed,  5 Aug 2020 13:09:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9894084A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596625798;
	bh=YdYOYRyJgmPYefsdjNv05w/JuOwRFT3mytpi4kxhQys=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j+Dth6C6KQ4P1ZByoe67oTQfh+AI7AzDMqgewN/AUCrnerV1wDZF+Yv1Tj73jcrBA
	 f4nsY7W9YpwCKesOiKN5bqh3OrvfVfmLEgys2uTX2MiFK1oH5uVHnTQX1+T7Mzuqmy
	 xBuKOAnGXtHn7hv1/5flRTgPDAKkX47ytvAtqRXk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 27A1BF801F7;
	Wed,  5 Aug 2020 13:09:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9E3CEF80218; Wed,  5 Aug 2020 13:09:06 +0200 (CEST)
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D37BCF80112
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2020 13:08:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D37BCF80112
Received: by mail-oi1-f196.google.com with SMTP id b22so13277226oic.8
 for <alsa-devel@alsa-project.org>; Wed, 05 Aug 2020 04:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a747GTvzdj8BhTC99m/ltqffKPbWLknrH4UGCy7e+04=;
 b=RTN97CvwLVhlvE8/EX/bI86qMOwCGd744twKRimQsgYEntfYgXvn2LGigKzYlIe3fj
 XcriHKij1Lq6OsmtVqw5hEm1yyWPzy/s19OenL+ixmdxRlDpUQVcFyBCsDRKY3Y4CUPb
 PERLR4pSLLf+IQ91dwrhAB6drQWNc9RXqradhhTimAwN1jqZQm4LD1Gh5Fkiu+/Sdw5t
 RyQrA33Ywr/okRb9SHx94ZqXxJ9kcLyaZT/je9S5NM2h6OoG6u7VwwVdmaNvNkJ/RLdT
 KdWm6Wgz/D5qh+jY8zxg2tcMzss2ERDOXeGMHpaKBlH3NAghS8VIgJVMKjoEyOAporkH
 e3NA==
X-Gm-Message-State: AOAM533CkIQn6DREVtQchPWwQ02cEF8PcRGoGIg4tcaQUAwWL18+e/yy
 JUijGvmx828RPe68ZuZmkz//8MoVnZ9gbiCmFmM=
X-Google-Smtp-Source: ABdhPJxOLh0H5vKRdwT+SgNB4/VJFY79xxN/fk4jyCR22Pxw8fbAj3AqGa5onUuCO90I+Y+bzEmqLPTLGI8ksjYr6g8=
X-Received: by 2002:aca:b742:: with SMTP id h63mr2149267oif.148.1596625738500; 
 Wed, 05 Aug 2020 04:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <1594919915-5225-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594919915-5225-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1594919915-5225-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 5 Aug 2020 13:08:47 +0200
Message-ID: <CAMuHMdVNrbi2twUoJ1wB4DY++M+VgsLVQXxS_NTK9YtExF8BBg@mail.gmail.com>
Subject: Re: [PATCH 02/20] arm64: dts: renesas: r8a774e1: Add PCIe device nodes
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

On Thu, Jul 16, 2020 at 7:18 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add PCIe{0,1} device nodes for R8A774E1 SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.10.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
