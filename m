Return-Path: <SRS0=cqJl=BP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CF8C433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Aug 2020 11:10:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3AB722CA0
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Aug 2020 11:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Hoq9zt03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3AB722CA0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4ED121662;
	Wed,  5 Aug 2020 13:10:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4ED121662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596625851;
	bh=Iqzgl4bA10NpnPwKwLfXLOmdHFj7nBfux2nY12S8RWI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hoq9zt03BXlbqXyvIJhN7r1AU4PENQ+Ea1z3Mj9KArrXIXbJqoN976Ec6qkk4Ie05
	 QTJ97z5B9pS9jiQAtVgTQDVtoeHn/zQKQh99zPSoM4PRk+i1HFMsZ0Je5Vm/u9BUjd
	 5/UWwzc65o9Su6Yc3tBe7MbQTO1T6fJ4UkuskVIY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2E406F8023E;
	Wed,  5 Aug 2020 13:09:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4B4EAF80249; Wed,  5 Aug 2020 13:09:39 +0200 (CEST)
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B1085F80124
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2020 13:09:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B1085F80124
Received: by mail-ot1-f65.google.com with SMTP id q9so17341699oth.5
 for <alsa-devel@alsa-project.org>; Wed, 05 Aug 2020 04:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GhwGBb3og4FBqTm6+fj02zyv7weIuiKRDAujBvepcdQ=;
 b=TeSWk6EOnu0nf/TPhnYEb4IZ/AQpplE/W4iki6omi6lVVCFC8XvuVftlu7iiNUB8pb
 crPirau4bsucKW91Zidpsy6wTmARTnW2+vG4eLBx3yhmh9dVNBN0799RhNhwvP6uQ0Kn
 6G9h5DQR2tqAi7SHO3T0XA5kQLbAzGmZ9dsdd4wYbd8KwlreYkkJhIpZ8yxJS0AKkuNS
 NNibIlIgUGEqaNOXzblnrKRfDfswrvCE/rZjfive+VpDOcYVMJyphokezx3hPSuMojPy
 pQ3X86e2g6x2BPBVcnIF773KQtXRg9x6lZ6/D/LYf3d1iB3w3HTik+orSP7kHfxTPxfj
 WQdg==
X-Gm-Message-State: AOAM531IV7DOscldJ+fka4tVnRmF+q3NfWaM/yJKdN7n8/5NZ4PANrDU
 AZNH5BZSLreSQ2edzNVUoTnv0o5CqJ6D+N1MY/A=
X-Google-Smtp-Source: ABdhPJy6Few2JSpX34d8UWs2mHs62Jj4zoFqif/HtRZNiG9fgu0Yy1ArYH3I3/SVye0G2Oxi4tcy3VslWxu2yq+qpJs=
X-Received: by 2002:a05:6830:1b79:: with SMTP id
 d25mr2025587ote.107.1596625767021; 
 Wed, 05 Aug 2020 04:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <1594919915-5225-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594919915-5225-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1594919915-5225-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 5 Aug 2020 13:09:14 +0200
Message-ID: <CAMuHMdVTBWuDVueW4OJff5kC+=PF+Q5OnKAo5-M4+7g9WB-adA@mail.gmail.com>
Subject: Re: [PATCH 04/20] arm64: dts: renesas: r8a774e1: Add SATA controller
 node
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
> Add the SATA controller node to the RZ/G2H SoC specific dtsi.
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
