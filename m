Return-Path: <SRS0=ofM/=CT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8620C43461
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:58:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9992D20731
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aR2f8uoN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlhzNbRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9992D20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B901383E;
	Thu, 10 Sep 2020 20:57:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B901383E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599764306;
	bh=1UcshxVJPp8wBIXjhAIFdQKjgIBJM0nEQkjbHXHHYoI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aR2f8uoNBzKMLmRJ4d2cIhrSz8GySoFmw0zkpYMy19o7t4h9wHgV17Xs1cw4Pn49f
	 BQqyrmtsnlUkcABdySGKL8iof6cdJZw0y1PYWQ/Y5bWv1yj8L6duwxsYw5xYw+sFY9
	 R48nhFhtSm6GLp7vaYYT66bv/5mt/k/HwBd4Ux+4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 270FCF801F2;
	Thu, 10 Sep 2020 20:57:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F2FD8F80264; Thu, 10 Sep 2020 20:57:33 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 823C9F800E9
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2020 20:57:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 823C9F800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="nlhzNbRd"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E349420731
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2020 18:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599764239;
 bh=1UcshxVJPp8wBIXjhAIFdQKjgIBJM0nEQkjbHXHHYoI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=nlhzNbRdBEqMj5V7xo0ggBY39I+1n34ZMtDp5CUbxIcTomkiQOQJX8wiR2MBGans/
 2NWr9f3PRmUfMuittvDWiwy0GAgih2q1L4ZO2whaaVCiLME0tuvr2w6G58VtYiTNdI
 knGFXy9X+Xz06+vxIIEQ5E8Q23p6SyfEk9cvrKSk=
Received: by mail-oi1-f180.google.com with SMTP id w16so6978310oia.2
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2020 11:57:18 -0700 (PDT)
X-Gm-Message-State: AOAM531e8fD8p2OXgiwoCS6pv0MvpUScoSdLP+t0+6xrjLvAz9JiXabJ
 F2Dm6qi9Go3MobUumLPzywtjQGkr8h/9QeB6hA==
X-Google-Smtp-Source: ABdhPJxS7bMy2m9cVZGVwBZW0cmzeeBAd7Q8fxgPADIHPQGAlD9B5/k/zfJ2VRyJPkSICYlB6HlaFns94VNjKPYAg7o=
X-Received: by 2002:aca:fc07:: with SMTP id a7mr938408oii.106.1599764238271;
 Thu, 10 Sep 2020 11:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <878se1vsy6.wl-kuninori.morimoto.gx@renesas.com>
 <877dtlvsxk.wl-kuninori.morimoto.gx@renesas.com>
 <20200908231422.GA1108858@bogus>
 <87pn6uwhzb.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87pn6uwhzb.wl-kuninori.morimoto.gx@renesas.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 10 Sep 2020 12:57:06 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKA85U8iPPL+bPbbzuA8o=kgetrE+vgCorN5Q-qC86SAg@mail.gmail.com>
Message-ID: <CAL_JsqKA85U8iPPL+bPbbzuA8o=kgetrE+vgCorN5Q-qC86SAg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: audio-graph-card: switch to
 yaml base Documentation
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Cc: devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@kernel.org>
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

On Wed, Sep 9, 2020 at 7:17 PM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
>
> Hi Rob
>
> Thank you for your feedback
>
> > > diff --git a/Documentation/devicetree/bindings/sound/audio-graph-card.yaml b/Documentation/devicetree/bindings/sound/audio-graph-card.yaml
> > > new file mode 100644
> > > index 000000000000..60d7b1504128
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/sound/audio-graph-card.yaml
> > > @@ -0,0 +1,135 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/sound/audio-graph-card.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Audio Graph Card Driver Device Tree Bindings
> > > +
> > > +maintainers:
> > > +  - Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > +
> > > +definitions:
> >
> > Please don't use 'definitions' unless really needed. There's only 1
> > reference to 'endpoint' and 'port' so you don't here.
>
> If this was applied, all audio-graph-card user driver want to use it.

They should reference this schema at the top level, not down in it.

Rob
