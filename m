Return-Path: <SRS0=yD/C=LC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80917C4743E
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Jun 2021 10:44:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8214E610E5
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Jun 2021 10:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8214E610E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1ED88169D;
	Tue,  8 Jun 2021 12:43:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1ED88169D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623149068;
	bh=ED+81+QGTThq5NfKIJq3px9SRqFYiGHq81gP2WNDtSc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pHBfGh92N21/uAg6wdb2eQn2ohdCj28poIeN9lWIGL+En1eRd87kPNyxorCUrnxV3
	 WmOLsG1CMBeRrEmiXydYcSw4WNaxJMagFmT8qbXzMLOSSaW6JmlUmYz3He5Xh4w0sw
	 WBWuL+o8hyu3aMDF5Gs9VsKEJrYXFMpSLLgLPdwk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9DA32F801EC;
	Tue,  8 Jun 2021 12:43:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 335CEF80218; Tue,  8 Jun 2021 12:43:35 +0200 (CEST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com
 [209.85.217.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 30C7EF80116
 for <alsa-devel@alsa-project.org>; Tue,  8 Jun 2021 12:43:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 30C7EF80116
Received: by mail-vs1-f44.google.com with SMTP id j15so10604361vsf.2
 for <alsa-devel@alsa-project.org>; Tue, 08 Jun 2021 03:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xSpARCXEY9r5sC5PxBnmVPG/+mNFD4xLIb8KPhmPVtE=;
 b=mcELPUYA8PkERU93SENWsJCwM3QarmummjjSymtVsQlakN9N5qmAgpIjZfxpEimOPx
 TMHFxPzHfssaxrqaoTjZEXeHy+AR1SIFaeO/QRwb/yeONmyAiXdRPS0ahkvbE5MRKVb6
 U2tUIQzwCf+gjq1sfmGl5sumonmUX055TSw1L8GH/9u2IlchIRZBWH+QW0+NmRr1QrAh
 wRhRp59CtncCbME5B5HLMcycfLlmTUe1Aw3TxxUEK9U+pfWIBcSzDIF/iFI4jiZg/m9O
 OgHjmja07xQPrOaUPhKAzYnBpemtcmg2jJoEQQfTNWc/xVhRB9Fhf9cgRgKRulSfSboz
 8DGw==
X-Gm-Message-State: AOAM531zaE1cP8Znb6ufoS07eYlDXO+7pGshJgOKsIhSeuYhh7HKIfRW
 CyHsB37+DA5M2mWgRmZeipPDtgwz9P7tfZ/1ldg=
X-Google-Smtp-Source: ABdhPJyWVn2KezQdjunvFca9KXFsmRggMf0glvDI0gjObu5ODDYPdSBPHjvrB8I0zR1cpmXLdpUxBUw5zDVm7Os6A+8=
X-Received: by 2002:a67:f106:: with SMTP id n6mr7769858vsk.40.1623149004456;
 Tue, 08 Jun 2021 03:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210603110315.81146-1-colin.king@canonical.com>
In-Reply-To: <20210603110315.81146-1-colin.king@canonical.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 8 Jun 2021 12:43:13 +0200
Message-ID: <CAMuHMdV0kOjRo6DBksoaLBuXrw_BiUaF6e6DOj9OwSjrs405pw@mail.gmail.com>
Subject: Re: [PATCH][next][V2] ASoC: rsnd: check for zero node count
To: Colin King <colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
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

Hi Colin,

Thanks for your patch!

On Thu, Jun 3, 2021 at 1:05 PM Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Most callers of_get_child_count() check that "nr" is non-zero so it

Note that there is no longer a call to of_get_child_count(), as of the commit
referred to from the Fixes tag below.

> causes a static checker warning when we don't do that here.  This
> does not cause a problem or a crash, but having zero SSUIes does not
> make sense either so let's add a check.
>
> Addresses-Coverity: ("Unchecked return value")
> Fixes: c413983eb66a ("ASoC: rsnd: adjust disabled module")
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> V2: Rephrase commit message based on Dan Carpenter's suggestion.
>     Thanks Dan!


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
