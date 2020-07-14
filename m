Return-Path: <SRS0=Ss6N=AZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D398C433E1
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 06:15:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11153207D4
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 06:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oQ1wz/+K";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="cqAASXHE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11153207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9869D84D;
	Tue, 14 Jul 2020 08:14:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9869D84D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594707337;
	bh=QkyJ2wwt3GJSLUgxNbNmJ+mUi7WHy9r/Mu9Dv41O+lo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oQ1wz/+K6NIF8CNgBx/9romVbMz24r81sUL2OzAaUJjiHrvVlgEM+ZI5TOdv/bYCf
	 HRHtajEDK5mGE4WpmFIthIUJn/g2Cr6ctj94vHZl1X65pjAulgeCLsuw2j7Nia/tUh
	 EVv7FTDQJcPEZS33bk2AuX32i15tA66JF25Ue3LQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ECA5FF8016F;
	Tue, 14 Jul 2020 08:14:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0447EF8019B; Tue, 14 Jul 2020 08:14:45 +0200 (CEST)
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com
 [210.131.2.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 08118F80113
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2020 08:14:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 08118F80113
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com
 header.b="cqAASXHE"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com
 [209.85.217.51]) (authenticated)
 by conssluserg-03.nifty.com with ESMTP id 06E6E39e014197
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2020 15:14:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 06E6E39e014197
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1594707244;
 bh=mOcbSlBkfHZn1T5iVADjaQnNfA8I3/LNq/v0cJT1fAM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=cqAASXHE2xvsuWfTGsHKyFDQ0O+vz02gDrjZDek4ngpLYWT5W/MAqVkMbJVvHNmGV
 O/2vjzOV71V/Ud0weZvBeDDCq6rL+bUUzrskD7JljG1+5vbrVn154Xe1Ka98k/JlzO
 tOwGIK9Pm7Y72c3mMlHgsWSq++wZMr4mBE27uaavR8AZijz9wZRYwpV2WlaYsv7vN4
 rhnEzkv7gZV1Sh7/3akVmIT0ZRqtz77m6+T2nteISia2vY3EBj2XmrAHNKjB7XDU8W
 e3f5aeF6+xVXDe7Pv0i5PoBNLP+vE2mV4BtUSvr8tEpQCilzsVMUho+EDk/8bXmycl
 to/QDh74WNAhQ==
X-Nifty-SrcIP: [209.85.217.51]
Received: by mail-vs1-f51.google.com with SMTP id e15so7925610vsc.7
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2020 23:14:04 -0700 (PDT)
X-Gm-Message-State: AOAM5329zUWUD9Zg9vuv2WFRYb6avfgu3Wv2/2vnpNQbAkTwkQtaos9M
 zD3f+Hb6xHUGOMBGlrLT+yLApVyVVi5sTtSzxEc=
X-Google-Smtp-Source: ABdhPJyEQUewdqjYSjbQ5eQsqie1dSmZKBqqOnYOdQ1EPFt5mHUxq1RYQUHAYkUTcRbFtkaVmamaxfWs9F9YcL/S6+w=
X-Received: by 2002:a67:de09:: with SMTP id q9mr2024085vsk.179.1594707243302; 
 Mon, 13 Jul 2020 23:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200623114005.791643-1-yamada.masahiro@socionext.com>
 <20200714022252.GA1151466@bogus>
In-Reply-To: <20200714022252.GA1151466@bogus>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 14 Jul 2020 15:13:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQrdqztMrHtAHnbMkxeaDLLyBS68WVovev+zytHdD7RVQ@mail.gmail.com>
Message-ID: <CAK7LNAQrdqztMrHtAHnbMkxeaDLLyBS68WVovev+zytHdD7RVQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: ASoC: Convert UniPhier EVEA codec to
 json-schema
To: Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Cc: DTML <devicetree@vger.kernel.org>, - <alsa-devel@alsa-project.org>,
 Katsuhiro Suzuki <katsuhiro@katsuster.net>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
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

On Tue, Jul 14, 2020 at 11:22 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, 23 Jun 2020 20:40:05 +0900, Masahiro Yamada wrote:
> > Convert the UniPhier EVEA sound codec binding to DT schema format.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> > Changes in v2:
> >   - Add schema for subnode 'port'
> >
> >  .../sound/socionext,uniphier-evea.yaml        | 70 +++++++++++++++++++
> >  .../bindings/sound/uniphier,evea.txt          | 26 -------
> >  2 files changed, 70 insertions(+), 26 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/sound/socionext,uniphier-evea.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/sound/uniphier,evea.txt
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>


What do you mean by Reviewed-by ?
Do you expect this to go to the asoc tree?

I just thought the schema conversion
would go through the dt tree.



-- 
Best Regards
Masahiro Yamada
