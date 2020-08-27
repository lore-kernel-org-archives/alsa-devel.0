Return-Path: <SRS0=n32M=CG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4813C433E2
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Aug 2020 11:46:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 478BF2086A
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Aug 2020 11:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mU5wMRkS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkTRJ1mK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 478BF2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8D4331877;
	Fri, 28 Aug 2020 13:45:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8D4331877
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598615194;
	bh=W6Hzcf/Af4P1dqZpm3foiNanaRiwECg60DRBPcqoEpQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mU5wMRkSrmSv9ZpUztyJj/NJpWC3ysTErg0juY98Hd5OiiTyXRlRZ6HXMohfn4pyz
	 uJONvjOt0+gqhK3cul+Z2tPyABwlyB/HCwExNEpwdusEXMczh1Gs36Ev7bSXe5/aWR
	 i1Cokey/e4JCpLwWsthrjWQPgnbirsr28jwKbynI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D656BF802A0;
	Fri, 28 Aug 2020 13:44:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 85E4DF8027B; Thu, 27 Aug 2020 19:34:52 +0200 (CEST)
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com
 [IPv6:2607:f8b0:4864:20::b43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4FFC4F80260
 for <alsa-devel@alsa-project.org>; Thu, 27 Aug 2020 19:34:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4FFC4F80260
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="lkTRJ1mK"
Received: by mail-yb1-xb43.google.com with SMTP id 189so3200425ybw.3
 for <alsa-devel@alsa-project.org>; Thu, 27 Aug 2020 10:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GxmsvrLcpOeXkCsHlYXOAwY7VKh0UFsLAGO+5hEpk1Q=;
 b=lkTRJ1mKgk4cIPuJ5IMvWG7ijG3umHYB9nYkL+oAJE0t4OsJ46F+wrtWGJyoATCPDe
 VgjH7PdTEqWZlvirOE9s9TVibxiJkkuQ6kXyEKqIMRpTeuPee5ss5QhmULBlaR1vuwey
 XxS5NHbuxWiLkMAHuN/JURh/tsxhhFe/K8KNqu+Qzax9sHpZQmbIDX8O/jFU+Y0Od+1e
 W+h5Z0Xk41k+qJEnvjnCG47zj4+oe+aLNkKv+y40anEwRnpVhdFU2OhpFC/f1n1D5KSs
 VIeIMfApZ/AOVKQ3UA5neQ3owEIe4rKaJR8UoqRGR+0wBAaEOIUDt3IUif5ANx5IkZy9
 YGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GxmsvrLcpOeXkCsHlYXOAwY7VKh0UFsLAGO+5hEpk1Q=;
 b=hJ9/22rQ3MFor2sfYgSQSeimFMfG4CKijOtPQvmkj2IJ4lxucqvCIYP8way8BZ3BEq
 rKk5pgRsARaDxcUHPRySADE5+JHyMiZWDWM4K7xY6DxLmrYU40cZcgRsfWlN6qfCJ+fR
 JJeHRicNZ5HJO3Zfw5bkFjLoLrQyE2fIO4zGTndjfSacNZHRxKQv/ty6TLpCHBDu9CmM
 f+71KaS9QLhTihof5teuSZQ+3dMe7nXBcyRyGBFxSNUhHMb5oqngiahMWY7Wq0KDuR+p
 N6C3TWjnzuvG+Y3ljKotF7oho4FRRjCC9OybIhWZXKBtWx0l+8rzVhPv/U9JI8kaam3l
 xDJQ==
X-Gm-Message-State: AOAM532f89y6BQNweyPeh4sQRuket/B9CD9tgc9EFf4Q0sSXNwcAm19A
 GqKsn6AI4Hfy49k5fdFNG0yiMqiDs1V3tKiPFEM=
X-Google-Smtp-Source: ABdhPJxYWuCSYXqkPcWE01ctXjzSlgjHoDui1b/Nonl6BZbG1ITby8r+A827hGsYXxn7sV4XEbLGCqrkeleiozi355w=
X-Received: by 2002:a25:2f4d:: with SMTP id v74mr28532113ybv.401.1598549684365; 
 Thu, 27 Aug 2020 10:34:44 -0700 (PDT)
MIME-Version: 1.0
References: <1594919915-5225-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594919915-5225-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1594919915-5225-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 27 Aug 2020 18:34:18 +0100
Message-ID: <CA+V-a8sn1_fKbHt6cy-27+j2HWFp7Fjt8XBRZPLpvN47C3E3hQ@mail.gmail.com>
Subject: Re: [PATCH 01/20] dt-bindings: pci: rcar-pci: Add device tree support
 for r8a774e1
To: Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 28 Aug 2020 13:44:03 +0200
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

Hi Bjorn,

On Thu, Jul 16, 2020 at 6:18 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> Add PCIe support for the RZ/G2H (a.k.a. R8A774E1).
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/pci/rcar-pci.txt | 1 +
>  1 file changed, 1 insertion(+)
>
Gentle ping.

Cheers,
Prabhakar
