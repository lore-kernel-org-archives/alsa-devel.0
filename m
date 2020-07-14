Return-Path: <SRS0=Ss6N=AZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8322C433E1
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 11:11:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4045F22203
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 11:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MNHdfa75";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="CzwbZZIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4045F22203
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B875F84A;
	Tue, 14 Jul 2020 13:10:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B875F84A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594725059;
	bh=z0OY3Bi/qrA2I/TTuCzgD3vQdt5c7DkNapFQwkQQDXs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MNHdfa755D0b4wndp7dEQtUV/Bad6jfopS70ZSUyZSi2iA2TDdi1CBMESiWG3F2JT
	 6HRbcb7Bhfdmt0b8NGT/gX9QFLa3DC6tC7jsERmHwI54mcjJczxQ646EaRvsnUWyX2
	 GOcAmYUveH4OfDh0gHC9/U0U5tAvx93G9GER+H5g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2A62AF8014E;
	Tue, 14 Jul 2020 13:10:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6C099F800E5; Tue, 14 Jul 2020 13:10:07 +0200 (CEST)
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BA371F800E5
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2020 13:09:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BA371F800E5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com
 header.b="CzwbZZIf"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com
 [209.85.222.48]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id 06EB9NtJ017983
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2020 20:09:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 06EB9NtJ017983
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1594724964;
 bh=s+qGqbv3CTLs4XT47genE5qR5//Xe3CqrmsU7ugBumg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=CzwbZZIfQDcMPUt8+yrFFQ1YJNYYX5aHiyggE32NZTFoY0mGNbZcUtbFoyrYyOLaC
 NeM8nDqvL1gldnVGWbkj88awT+PpjhU0EInQVQoAYnRAiHsLnZL0F1YNYrdoCXXx2Y
 7S1L0KogiGrmaDY3hNB6zV87DB5p9sAlVTzGMtMG82139iRgnWqzckxlHcB8G1snfE
 RJBt/nhWklQH3KSi1rPclJUwixXjcSqpCPAu/Mekwfi4PXFvsAoD4kRjQx/Oeq1IO0
 kb1J60B1klWKM8fYcqhK6/myexiflOFp6pEh08hqEdS8vLnkn1QChiAPv5K/XLDoro
 6LU02AXqg5kpA==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id b13so5538958uav.3
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2020 04:09:23 -0700 (PDT)
X-Gm-Message-State: AOAM531ilbzNgr9XRlmli5m7R5/E7GI0F+e5CGzGF3/YmDnpSAY5RSjq
 lG+5+tnX7U3knQcIlzqBP/CIPN581yzs0FQLqKY=
X-Google-Smtp-Source: ABdhPJzFoQKXXaO2byKTNGZBH3Q1438vhfsydjUWOj+DZJy+tjh7hGDv32uH8oQMzIflGPVWY3CW7MQ3X206v85g4Lw=
X-Received: by 2002:ab0:71d3:: with SMTP id n19mr2734135uao.25.1594724962474; 
 Tue, 14 Jul 2020 04:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200623114005.791643-1-yamada.masahiro@socionext.com>
 <20200714022252.GA1151466@bogus>
 <CAK7LNAQrdqztMrHtAHnbMkxeaDLLyBS68WVovev+zytHdD7RVQ@mail.gmail.com>
 <20200714095259.GB4900@sirena.org.uk>
In-Reply-To: <20200714095259.GB4900@sirena.org.uk>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 14 Jul 2020 20:08:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNARUwPRtG0uMZ4rwr7=+3wa9X1B70AXbnFL-CF1_wMvevw@mail.gmail.com>
Message-ID: <CAK7LNARUwPRtG0uMZ4rwr7=+3wa9X1B70AXbnFL-CF1_wMvevw@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: ASoC: Convert UniPhier EVEA codec to
 json-schema
To: Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Rob Herring <robh@kernel.org>, - <alsa-devel@alsa-project.org>,
 DTML <devicetree@vger.kernel.org>, Katsuhiro Suzuki <katsuhiro@katsuster.net>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On Tue, Jul 14, 2020 at 6:53 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jul 14, 2020 at 03:13:26PM +0900, Masahiro Yamada wrote:
>
> > What do you mean by Reviewed-by ?
> > Do you expect this to go to the asoc tree?
>
> > I just thought the schema conversion
> > would go through the dt tree.
>
> No, bindings changes usually go through the subsystem - if there's any
> other work on the binding then it'll usually also involve driver
> changes.

OK, then please apply the following two if they look good.

https://lore.kernel.org/patchwork/patch/1261568/
https://lore.kernel.org/patchwork/patch/1261569/

Both got Rob's Reviewed-by.

-- 
Best Regards
Masahiro Yamada
