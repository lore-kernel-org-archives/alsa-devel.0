Return-Path: <SRS0=cqJl=BP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CD6C433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Aug 2020 11:16:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 326C122D01
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Aug 2020 11:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tkGSHSeh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 326C122D01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7A84B1668;
	Wed,  5 Aug 2020 13:15:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7A84B1668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596626188;
	bh=k1c7CZGUnl6zl58/e01pn89mlbD5PVWL56qQSUq3yqQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tkGSHSeh1bRX6oaA/s3IhGPfRznqIN+00z/Mfzm8MdCYlX9hHOTWV03XZeJUw3wMq
	 xWb3E1HrTt6XZXft1/gcggA1gI8qSTKHqOBv5cD7EaoMObCrGwYAEfI4L4SypKC2AR
	 0hjM1jMibA2BimHwUzKBcBy4SBcCZ+kcmzVHpazQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C5960F8023E;
	Wed,  5 Aug 2020 13:15:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 952B1F80249; Wed,  5 Aug 2020 13:15:12 +0200 (CEST)
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8C7D3F80112
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2020 13:15:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8C7D3F80112
Received: by mail-ot1-f66.google.com with SMTP id t7so19181124otp.0
 for <alsa-devel@alsa-project.org>; Wed, 05 Aug 2020 04:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TiO7nzmTLhp/HssO4wueBR+pe6NyyJ3Wi4fmHclssB0=;
 b=f5Lpe7gXzKRUkkIsKjtT9yHF5OAj2m5wkJ2TPyJBbsP/u2F9jjhecKFwDJ+yPH5JRm
 Y/WjeJJQ/qVXh7tngZJOd1erFab2t6qnuVpEqgfNzmBq+zZ7CKKmbOOMf7tZnwECTStI
 0FLgCUDKsW3Y3RFWuC0pCSkWSw2B0ZOG8RAP4XwA7PE0c6uKenllspnAtRyconj5plzX
 AgYIpXYZxx+ZKcPplD58UL3dzmftDZmJrqMijd1IkUUYCeYjUwjpfKEWJF0Ih8IMqGQc
 /bncdInL6eMh80dO/H25BGk25CZ5Y/BRP7flewOTDaNICBiQYTQ6RONun3IWQtwTwM6n
 5CCQ==
X-Gm-Message-State: AOAM532f8Myfmy0vTTbe+3cndSwINTcUa4rZIh7/N72Iwiimhhii13hi
 gPXjfFvSb93FAm4JBV6rCphWm43/JT7W72GPur0=
X-Google-Smtp-Source: ABdhPJwK6o7b8lq3G6CAJpeeN/eYVnhyuuPm34lifo/8pWI+ku4U2jyzPQkSzpymHd67QjfIjokNuU68r0XO2FkgnuU=
X-Received: by 2002:a05:6830:1b79:: with SMTP id
 d25mr2044718ote.107.1596626105327; 
 Wed, 05 Aug 2020 04:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <1594919915-5225-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594919915-5225-14-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1594919915-5225-14-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 5 Aug 2020 13:14:54 +0200
Message-ID: <CAMuHMdWU1UaL8B4EqA3qS3vebOZWL69uHMgkTBwUnoUz=z_p7Q@mail.gmail.com>
Subject: Re: [PATCH 13/20] arm64: dts: renesas: r8a774e1: Add USB-DMAC and
 HSUSB device nodes
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
> Add usb dmac and hsusb device nodes to the RZ/G2H SoC dtsi.
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
