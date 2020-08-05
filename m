Return-Path: <SRS0=cqJl=BP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEED9C433DF
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Aug 2020 11:15:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5342622D01
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Aug 2020 11:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TOlAaIj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5342622D01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D088684C;
	Wed,  5 Aug 2020 13:14:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D088684C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596626135;
	bh=Qr1ZempBir322lc4FhA/lglGT127kjPpubwBxh4cQc8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TOlAaIj2KpnAMiBizlg9gDuu6NJZ36cie+CvQtkplvTRzFmwTQqg3xLSCA3I6TYgN
	 DwOKYd4KsY4EqBVOOUUBLnMav6p8r2aeISRw7X+aTKkibGerUu18ZdTy3RDu4MHu61
	 UAqTlfYyC4Y+vmGl9sAabDR4JiINN37pT6ndSY3w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 638D8F801F7;
	Wed,  5 Aug 2020 13:14:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1ACFEF80218; Wed,  5 Aug 2020 13:14:44 +0200 (CEST)
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 90C73F80124
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2020 13:14:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 90C73F80124
Received: by mail-oi1-f196.google.com with SMTP id b22so13289391oic.8
 for <alsa-devel@alsa-project.org>; Wed, 05 Aug 2020 04:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5lnCZoNdrZNQbQaV/iF1DKtpBff6Ck+1xozm4eqaEmw=;
 b=Q+jzKx16Brw3OO8DlG7ORLNmXIEQtsk9TKQ0HDuHU4nxlvmv4INbw10yOJA51BHfVg
 agGtzsnxCIHCeH9R9JdUYhVMJGAKgRc9PbkDi0LCHcQWGaqxIq8FCcdHeCB4ELdpKGul
 Yxien/LBpnouXIrk7rYVdAJpXacniDNFJ/TjmnWRd2Q3+LZmzC8AtV/b2AnW7mTJDOT+
 9RljYx0+JogRiz2cgRuOQqiM4Q+f2CiA0t95yhtWnE43PKOUEdqCDsxvkoWr01V0PGnU
 VlGxomoNW3d1ODMjzEH7Q4alK98sfJmRdaesCJmt4Ag0JBtgq15CSU/Mom8RKZM1oztR
 sTfw==
X-Gm-Message-State: AOAM532GwAfDzdX9AlXbXObCHkiBpeSu06DQ2ayLGQ7BhmNrJ2lwgaH6
 Akvte5ej+p1B6l5YRCya7aCZMQySfm339tfpVA4=
X-Google-Smtp-Source: ABdhPJwhUm4QHaZz7xbR+lTUoUQuyCH4le0QF/k75iMvl2tButnuNI7+iEhEoJyqrnRXlecEQMMJHtDC6cCth7F51hU=
X-Received: by 2002:aca:4b54:: with SMTP id y81mr2275594oia.54.1596626072299; 
 Wed, 05 Aug 2020 04:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <1594919915-5225-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594919915-5225-11-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1594919915-5225-11-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 5 Aug 2020 13:14:20 +0200
Message-ID: <CAMuHMdW5_yBdEidPiVNeQO0QwuJfTe0kSiHLg4hkQLzVuRM7VA@mail.gmail.com>
Subject: Re: [PATCH 10/20] arm64: dts: renesas: r8a774e1: Add USB3.0 device
 nodes
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
> Add usb3.0 phy, host and function device nodes on RZ/G2H SoC dtsi.
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
