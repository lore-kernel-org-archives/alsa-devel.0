Return-Path: <SRS0=PysP=C7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F426C2D0E2
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:40:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B43823A34
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qL1Hi0Oa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJGS3A93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B43823A34
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 783A716A0;
	Tue, 22 Sep 2020 10:39:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 783A716A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600763999;
	bh=Mm0cw1XMHiTcGFvYZ5YAxmxvfxAfdbEoZVA80me39JE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qL1Hi0OaSQcEQVNEEcmAKidMT2/379Qv4+YAlC7jqlBFu6DWGZ9fCedEkeXaq3gHU
	 o7ZeHuWCK2Wy8pccuPx9GoUrDTMfLOrchYyhQWvQIwAAfQHJq8wHNM278JHsbbMe2s
	 Iw0f5XOkBCF54d48OV+qoTkd1XZaW+Pg+Nsy7sqI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AEA91F80234;
	Tue, 22 Sep 2020 10:39:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B935BF80234; Tue, 22 Sep 2020 10:39:03 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7B051F8010A
 for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2020 10:38:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7B051F8010A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="lJGS3A93"
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2F3DA23A1E;
 Tue, 22 Sep 2020 08:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600763929;
 bh=Mm0cw1XMHiTcGFvYZ5YAxmxvfxAfdbEoZVA80me39JE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lJGS3A93Lgq85UkTDgJdes21K55ht2plPLTIViCrhCUCIC3GbnIc5h/FFIvwdAN7y
 GZhrRI/BtSs3f5OiCBv4YSrBUeSmOmarfFBLok5wtLaSTM8T+VppMPRyZogheOejZ9
 PC9RJDxQ+/0Q63ijmDGf4+v/jSPWVgbPUXU+FO1g=
Date: Tue, 22 Sep 2020 10:39:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 07/20] dt-bindings: usb: renesas,usb3-peri: Document
 r8a774e1 support
Message-ID: <20200922083909.GA2092905@kroah.com>
References: <1594919915-5225-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594919915-5225-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CA+V-a8vJ2n3KEL8P+XmVob2zjoWaX+s4a6c1TV_WoPFkwdkZmA@mail.gmail.com>
 <20200920140824.GA2915460@kroah.com>
 <CAMuHMdUyXMfZcVKkqaZHJ8tJf-3Kotqg+S2NHMZT0VFO0ZJJww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUyXMfZcVKkqaZHJ8tJf-3Kotqg+S2NHMZT0VFO0ZJJww@mail.gmail.com>
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

On Mon, Sep 21, 2020 at 09:30:39AM +0200, Geert Uytterhoeven wrote:
> Hi Greg,
> 
> On Sun, Sep 20, 2020 at 4:08 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Sat, Sep 19, 2020 at 11:50:07AM +0100, Lad, Prabhakar wrote:
> > > On Thu, Jul 16, 2020 at 6:19 PM Lad Prabhakar
> > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > >
> > > > Document RZ/G2H (R8A774E1) SoC bindings.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/usb/renesas,usb3-peri.yaml | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > Could you please pick this patch.
> >
> > Don't DT patches have to be acked by a DT maintainer first?
> 
> https://lore.kernel.org/r/20200721033508.GA3504365@bogus

Ah, missed that, sorry.  This, and patch 11/20, now queued up.

greg k-h
