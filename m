Return-Path: <SRS0=W2oN=D2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8760AC433E7
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Oct 2020 22:05:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E6AC222C4
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Oct 2020 22:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NSbXejMJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zi43O5PT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6AC222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E73E116BC;
	Tue, 20 Oct 2020 00:04:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E73E116BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603145103;
	bh=WBxPU3YohQAIr0UzV6DU7fWvPIhGAkcJTIC2AZUs7ng=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NSbXejMJVqhC0P1Bi9eZ1CtYY51D0fpBJTeoTqQ6KQ6n/P+h1VJMM32ptn6jm8a9k
	 xU8avt06hlj8kvjvWWf5Utn8Zf4xj2j8iec2oo1lX74aNJvPcYRiTP01WBbVO9Rkjr
	 tYX/GLCLVmCEqin0JGCFIixv7+yOXbqqm0f7VmzU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 71173F801D5;
	Tue, 20 Oct 2020 00:04:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DF882F80247; Tue, 20 Oct 2020 00:04:10 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 89890F80121
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2020 00:04:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89890F80121
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="zi43O5PT"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 188A72240C
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2020 22:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603145041;
 bh=WBxPU3YohQAIr0UzV6DU7fWvPIhGAkcJTIC2AZUs7ng=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=zi43O5PT/3HY0fCp/F0EDq9ginX8uuiSFbSiN5JM0zWy6JRoQFm/jLnJWp53wW9Q6
 cDhfYBam5LwqV/h/EU5dvxBvGRiwASM62QVOK5lQsmWf5wWpJhxirVOcXmBkO0ZHS2
 OmC3+d+ucmHQYgb9wfXkTfq9oGlaIonYAR8ghEvE=
Received: by mail-ot1-f49.google.com with SMTP id m22so1331208ots.4
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2020 15:04:01 -0700 (PDT)
X-Gm-Message-State: AOAM533JukIUMxjb+pixS+S1PwdrmepCj8RxLKTbPYL3mWdJZEH2cnwk
 cwhToQdfdKKO6vrFUAzr0umMci/bM1Z9bGS1Cw==
X-Google-Smtp-Source: ABdhPJwBY+VRyaJuZ4UsEGF4SP2lyhc+KgtqKs/qxfHE9ZI7JsFpUvG8NIfLhWpTw3bmQfT81VG0vVoz24EIGylkQ84=
X-Received: by 2002:a9d:7993:: with SMTP id h19mr1469970otm.129.1603145040317; 
 Mon, 19 Oct 2020 15:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <878se1vsy6.wl-kuninori.morimoto.gx@renesas.com>
 <875z95vsx2.wl-kuninori.morimoto.gx@renesas.com>
 <20200908232225.GA1122966@bogus>
 <87eemrlx15.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87eemrlx15.wl-kuninori.morimoto.gx@renesas.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 19 Oct 2020 17:03:49 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJDmw3929BxS2wroVoio6EP5QZ5bC3bJHEckLwfo6wP8g@mail.gmail.com>
Message-ID: <CAL_JsqJDmw3929BxS2wroVoio6EP5QZ5bC3bJHEckLwfo6wP8g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ASoC: dt-bindings: renesas,rsnd: switch to yaml
 base Documentation
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

On Wed, Sep 23, 2020 at 9:40 PM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
>
> Hi Rob
>
> > > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > >
> > > This patch switches from .txt base to .yaml base Document.
> > > It is still keeping detail explanations at .txt
> > >
> > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > ---
> (snip)
> > > +  # For OF-graph
> > > +  port:
> > > +    description: OF-Graph subnode
> > > +    $ref: "audio-graph-card.yaml#/definitions/port"
> >
> > Something like this should work (at the top-level):
> >
> > allOf:
> >   - $ref: "audio-graph-card.yaml#
>
> Hmm.. it will be error, see below (A).
> How to solve it ??

All the 'allOf's have to be grouped.

> (I will keep to use above style)
>
> > > +# use patternProperties to avoid naming "xxx,yyy"
> > > +patternProperties:
> > > +  "^rcar_sound,dvc$":
> >
> > None of these are patterns.
>
> As always happen, "xxx,yyy" style will be error for me without patternProperties.
> What is wrong ??

Node names shouldn't really have vendor prefixes, but since you
already depend on this we shouldn't change that. We'll need to relax
the meta-schema, but for now it's fine as-is.

Rob
