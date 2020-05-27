Return-Path: <SRS0=+ZhY=7J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D32AC433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2020 16:00:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B69692075F
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2020 16:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pz079sGQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69692075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 07B7B1790;
	Wed, 27 May 2020 17:59:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 07B7B1790
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590595249;
	bh=PdlvnwDutjb/77XkEtD1r65LredhRAMtRfD2KGF4Q+g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pz079sGQD6ZevLDxJmlzcbQZHQ7YTaGQssG6N2TVgwAXCFnYgjNMBNJUl8BU3Aw+p
	 4Arj7iJN/HAynjE7B/akBE9P2rkvg4bitEOmhltw79D6GFrHXCaVii8WH/5UGav8dc
	 i2vVNdcrJ8EOghCghfu3s1+KC7OfNhxCtH1DVJUY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9E681F80149;
	Wed, 27 May 2020 17:59:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 83E0DF8014E; Wed, 27 May 2020 17:59:56 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 40249F800FF
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2020 17:59:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 40249F800FF
Received: from mail-qk1-f182.google.com ([209.85.222.182]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MXGzQ-1jVpV11YnW-00YjZ7 for <alsa-devel@alsa-project.org>; Wed, 27 May
 2020 17:59:53 +0200
Received: by mail-qk1-f182.google.com with SMTP id c185so10718951qke.7
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2020 08:59:53 -0700 (PDT)
X-Gm-Message-State: AOAM532V9JxHTDR8rC5HD1VyCUiN44WMejQYGpAvUaB8OgoKLfo+LvnY
 BNXZPcdd+Hp9U51DsdPaeqUPZdrZ/KPsAFhCJG0=
X-Google-Smtp-Source: ABdhPJxDutw7MBd/EYBIKtYxOivFQlLGm+KC5RbbRJSXfuIwQcc5opcAUQCuxjh5ZJMaChtg/SMDmArapoMUIIqUbag=
X-Received: by 2002:ae9:c10d:: with SMTP id z13mr4427434qki.3.1590595192185;
 Wed, 27 May 2020 08:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200527134151.834555-1-arnd@arndb.de>
 <20200527134743.GH5308@sirena.org.uk>
In-Reply-To: <20200527134743.GH5308@sirena.org.uk>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 27 May 2020 17:59:35 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3fmQSTAKehsjZX8CEEEK7oHoGdviLKY2JE4=tTccGkyQ@mail.gmail.com>
Message-ID: <CAK8P3a3fmQSTAKehsjZX8CEEEK7oHoGdviLKY2JE4=tTccGkyQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: amd: rt5682: fix soundwire dependencies
To: Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:PItm1Ki0Bka0tZVzj9YTLHwNK/raKV3Q/gElHh3fueRkhBikag9
 HoeazUcOr2apHb42XmRsDOnVYZ5sbAwNjVfBddFqLGgTIICnjm8ahU2ZmCI0QL4GaeUA/nA
 RMefk1PmMXZxtPdHDDOiwH53gI44x/u1mnIN+7KXF0ubacvY6koIziFqDL71r5YQmNVPAqT
 JDs/oLoZXM+MIINkCHvSg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K8RV9tx35bI=:VcZnVH+wWuLiJR/KkdZcTR
 gwaso36jXTxHZomdjN6nRgMCiWcORPC97NHewkpkwG24sEAAy04L2ZmyhyeqM+2bfV73kUjj9
 XRDXkfoK/xH3aMq74cxvz6D1h4Va0HaiGUw0NTpwMlhxi0CUUyCr0UWV2hoXPtdnuUeD3/abZ
 YNOC2yygO5afLynUp7Ua6FIh7mlVvT4D4w+OpZZUyh0nTk52L/qzXRJURI74lhxwvnHwOFhAr
 GSyKKZEe77nvXrHSxAkamZtATwXx8KqheQ8XPJKZfqGDMGtiFpONYI7kTe76Cupl4Z8sHy4f6
 K3ZZlYRLeUSgZSUJZL7COPm06oZIzdzFuUZ/kE6aEDqRkrRMAWd+OYvnt8AOrKODJAhKj/jRk
 e4UaNSDzo6v6iYLng5pY+p0UCQEHpkMp03jJgttqAP874pApmcV7JK5Kh/Sq66ii/pztObiwP
 JwcjA8ETvni0v4vAN82zScORO+6wxbC5WKpTMKT2AZs/8H/8EOymIQ0aeu3Z9e+cE8vGNaJ5Q
 krSMgaXvVwWCsrr2CPDvcdR7kjS28spfYkW9xQso8/tkxxGlxSofxZg2ZITXhgujgc7UEiAk5
 3fCZ0d9SHbI0qRyLHZO/YHbOyUJjaUnrKBPf3kkXsMCm1FIEc1SWfonWipEc88SqNe6FRH9jN
 rR7//G0JmtjX44AaGARK7K69J1bd5SDReZelveVKIP1UVoy3TopJMIhqzy7d/whLzYo1huqZs
 tow1mLyzAz5YfVPemuDF/avXtcvyRpIHmVqnEA4siSK/TGSwngi0ZK1XK+Aj6Siz3k3Ts5VtD
 7VCV6NGo/B0BpVB8tb8gtvFp6eHuoWPrpVD38nn9Eh6t4Bq/Ig=
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
 Akshu Agrawal <akshu.agrawal@amd.com>
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

On Wed, May 27, 2020 at 3:47 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, May 27, 2020 at 03:41:26PM +0200, Arnd Bergmann wrote:
>
> > Maybe the SND_SOC_RT5682 driver itself can be reworked so that
> > the common part depends on neither soundwire nor i2c and the two
> > bus specific options can be loadable modules when the common part
> > is built-in.
>
> Yes, please do that.

It took me longer than I thought it would, but I have a patch now.
I'll send it after it passes more randconfig builds to ensure it covers
all corner cases.

      Arnd
