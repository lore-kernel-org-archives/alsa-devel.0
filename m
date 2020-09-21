Return-Path: <SRS0=AR4N=C6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2136DC43463
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 07:30:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3524520809
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 07:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HK2KeuZm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3524520809
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8D74E167A;
	Mon, 21 Sep 2020 09:29:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8D74E167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600673449;
	bh=eZovonrUWNuH+G8+edaDB+AVr2Pp+AjC1w1pRtuKOCc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HK2KeuZmFHWax+e/Z+tGIB7eInkLiabAmTLRM6vPilNzRnxs1RS9nyRrgVEdHkvDy
	 KbmG+c33bnGubBDhsjwW1mQmaAI5tB5p8ICNenjC3PcZrwEZmXHVBJHBONWTH/VNdE
	 aXiLtby8xW7D0DTb/8yHa47KFwLMjS4xERQeduRw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1647CF80161;
	Mon, 21 Sep 2020 09:29:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B9DEBF80161; Mon, 21 Sep 2020 09:29:57 +0200 (CEST)
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5948CF80171
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 09:29:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5948CF80171
Received: by mail-oi1-f194.google.com with SMTP id i17so15874186oig.10
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 00:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=90EhcBzbpe2vvxa0ohP9B+Dh75rNdKfJSEph9k8z+pM=;
 b=J9DEuAJhuBgO0jC5o+Y/eRCqcdUZjKi0IPAy2ntVWcyvGON7v7uOlJDzgiJNQ48cnM
 rwV/tOO7fBdR0xlY698+8TB9u/yWsZYU7vFJ1XS5W+OYYNqyRaCoZg+ar6qN3ocic4RB
 dggPOuL9yePkghitn97biQd4RvaFzQbcHLtjQkHTJthAxw4EfoyUZfOh1/1SKFrnkA35
 fMX9ea2CAirGoJ7po56tozcG/M37oFWX+jIu6WrluMvA21r0ZOpQbmztstVCL0RkAwZf
 NV+dChc2C5Yt6MSJL7A4e6X4rDca3O7iSsu3hYv1suCDXdgpkSwcvL30c2J/GqPuSSpC
 AvFA==
X-Gm-Message-State: AOAM53365wU407YhPYvL06AoVY1m/sNjchkVYsgR78KL2mahFJAz0hlx
 Z190PK5YXn48NUsXB/vDox2gM7/0nOcprs1kzZs=
X-Google-Smtp-Source: ABdhPJyf/sKRes03lyRebHMYTTNhwUI3iObyZWkgpxFfbC1QJaXNYOyLYBpf0EYemOiZ0DhKCpWF7uMdeYorWHg/2u4=
X-Received: by 2002:aca:52d6:: with SMTP id g205mr16832418oib.54.1600673388389; 
 Mon, 21 Sep 2020 00:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <1594919915-5225-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594919915-5225-12-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CA+V-a8vuR-7vqxNnrqQ5Ysf3Xjvhp3xRZ33i8+6nEGFLJciT3A@mail.gmail.com>
 <20200920140846.GB2915460@kroah.com>
In-Reply-To: <20200920140846.GB2915460@kroah.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 21 Sep 2020 09:29:36 +0200
Message-ID: <CAMuHMdUNvODmaJDaLi45Q8wpCaZaTA4HnmW_Y0BLwkXw8UxgEQ@mail.gmail.com>
Subject: Re: [PATCH 11/20] dt-bindings: usb: renesas,
 usbhs: Add r8a774e1 support
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel <alsa-devel@alsa-project.org>,
 linux-pci <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-ide@vger.kernel.org, "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
 Linux I2C <linux-i2c@vger.kernel.org>,
 Marek Vasut <marek.vasut+renesas@gmail.com>,
 Magnus Damm <magnus.damm@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 linux-media <linux-media@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Niklas <niklas.soderlund@ragnatech.se>, Rob Herring <robh+dt@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Jens Axboe <axboe@kernel.dk>,
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

Hi Greg,

On Sun, Sep 20, 2020 at 4:08 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sat, Sep 19, 2020 at 11:54:05AM +0100, Lad, Prabhakar wrote:
> > On Thu, Jul 16, 2020 at 6:19 PM Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > >
> > > Document RZ/G2H (R8A774E1) SoC bindings.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> > > ---
> > >  Documentation/devicetree/bindings/usb/renesas,usbhs.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > Could you please pick this patch.
>
> Same here, doesn't a DT maintainer have to ack this?

And so *he did:
https://lore.kernel.org/r/20200721033544.GA3505976@bogus

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
